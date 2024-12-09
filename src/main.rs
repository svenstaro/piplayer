use actix_web::{get, middleware, put, web, App, HttpServer};
use rand::{thread_rng, Rng};
use rodio::Sink;
use std::time::Duration;
use std::{
    io::{Cursor, Read},
    sync::Mutex,
};
use tar::Archive;

const AUDIO_FILES: &[u8] = include_bytes!(concat!(env!("CARGO_MANIFEST_DIR"), "/music.tar"));

#[derive(Debug)]
enum AudioCommand {
    Play(usize),
    Stop,
}

#[derive(Default)]
struct AudioState {
    queued_command: Option<AudioCommand>,
    sink: Option<Sink>,
}

#[put("/play")]
async fn play_random_song(audio_state: web::Data<Mutex<AudioState>>) -> String {
    let mut rng = thread_rng();

    let mut archive_for_count = Archive::new(AUDIO_FILES);
    let songs_count = archive_for_count.entries().expect("tar read error").count();

    let mut archive = Archive::new(AUDIO_FILES);
    let mut songs = archive.entries().expect("tar read error");

    let rnd_index = rng.gen_range(0..songs_count);
    let song = songs.nth(rnd_index).expect("Empty tar");
    let f = song.unwrap();

    println!("Playing {}", f.path().unwrap().to_string_lossy());
    audio_state
        .lock()
        .unwrap()
        .queued_command
        .replace(AudioCommand::Play(rnd_index));

    format!("Playing {}", f.path().unwrap().to_string_lossy())
}

#[put("/stop")]
async fn stop_playback(audio_state: web::Data<Mutex<AudioState>>) -> String {
    audio_state
        .lock()
        .unwrap()
        .queued_command
        .replace(AudioCommand::Stop);

    "Stopped playback".to_string()
}

#[get("/list")]
async fn list() -> String {
    let mut archive = Archive::new(AUDIO_FILES);
    let songs = archive.entries().expect("tar read error");
    let mut song_list = String::new();
    for song in songs {
        song_list.push_str(&song.unwrap().path().unwrap().to_string_lossy());
        song_list.push_str("\n");
    }
    format!("Total songs: {}\n{}", song_list.lines().count(), song_list)
}

#[get("/")]
async fn status(audio_state: web::Data<Mutex<AudioState>>) -> String {
    if let Some(sink) = &audio_state.lock().unwrap().sink {
        if sink.empty() {
            "paused".to_string()
        } else {
            "playing".to_string()
        }
    } else {
        "paused".to_string()
    }
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "actix_web=info");
    pretty_env_logger::init();

    let audio_state: web::Data<Mutex<AudioState>> = web::Data::new(Mutex::new(Default::default()));

    let audio_state_for_thread = audio_state.clone();

    let _ = std::thread::spawn(move || {
        let (_stream, stream_handle) = rodio::OutputStream::try_default().unwrap();

        loop {
            if let Ok(mut audio_state) = audio_state_for_thread.try_lock() {
                if let Some(audio_command) = &audio_state.queued_command {
                    match audio_command {
                        AudioCommand::Play(n) => {
                            let mut archive = Archive::new(AUDIO_FILES);
                            let mut songs = archive.entries().expect("tar read error");
                            let song = songs.nth(*n).expect("Empty tar");

                            let mut buffer = Vec::new();
                            let mut f = song.unwrap();
                            f.read_to_end(&mut buffer).unwrap();
                            let reader = Cursor::new(buffer);
                            let new_sink = stream_handle.play_once(reader).unwrap();
                            audio_state.sink.replace(new_sink);
                        }
                        AudioCommand::Stop => {
                            audio_state.sink.take();
                        }
                    }
                    // Consume the queued command.
                    audio_state.queued_command.take();
                }
            }

            std::thread::sleep(Duration::from_millis(100));
        }
    });

    let server = HttpServer::new(move || {
        App::new()
            .app_data(audio_state.clone())
            .wrap(middleware::Logger::default())
            .service(play_random_song)
            .service(stop_playback)
            .service(status)
            .service(list)
    })
    .bind("[::]:8080")?;

    println!("Started http server: 0.0.0.0:8080");
    server.run().await
}
