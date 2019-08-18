use actix_web::{get, middleware, put, web, App, HttpServer};
use rand::{thread_rng, Rng};
use std::io::{Cursor, Read};
use std::sync::Arc;
use std::sync::Mutex;
use tar::Archive;

const AUDIO_FILES: &[u8] = include_bytes!(concat!(env!("OUT_DIR"), "/music.tar"));

#[derive(Clone)]
struct AppState {
    device: Arc<Mutex<rodio::Device>>,
    sink: Arc<Mutex<rodio::Sink>>,
}

#[put("/play")]
fn play_random_song(appstate: web::Data<AppState>) -> String {
    let mut rng = thread_rng();

    let mut archive_for_count = Archive::new(AUDIO_FILES);
    let songs_count = archive_for_count.entries().expect("tar read error").count();

    let mut archive = Archive::new(AUDIO_FILES);
    let mut songs = archive.entries().expect("tar read error");

    let rnd_index = rng.gen_range(0, songs_count);

    let song = songs.nth(rnd_index).expect("Empty tar");

    let mut buffer = Vec::new();
    let mut f = song.unwrap();

    println!("Playing {}", f.path().unwrap().to_string_lossy());
    f.read_to_end(&mut buffer).unwrap();
    let reader = Cursor::new(buffer);

    let sink = &appstate.sink;
    let device = appstate.device.lock().unwrap();
    sink.lock().unwrap().stop();
    *sink.lock().unwrap() = rodio::Sink::new(&device);
    sink.lock()
        .unwrap()
        .append(rodio::Decoder::new(reader).unwrap());

    format!("Playing {}", f.path().unwrap().to_string_lossy())
}

#[put("/stop")]
fn stop_playback(appstate: web::Data<AppState>) -> String {
    let sink = &appstate.sink;
    let device = appstate.device.lock().unwrap();
    sink.lock().unwrap().stop();
    *sink.lock().unwrap() = rodio::Sink::new(&device);

    "Stopped playback".to_string()
}

#[get("/list")]
fn list(appstate: web::Data<AppState>) -> String {
    let mut archive = Archive::new(AUDIO_FILES);
    let mut songs = archive.entries().expect("tar read error");
    let mut song_list = String::new();
    for song in songs {
        song_list.push_str(&song.unwrap().path().unwrap().to_string_lossy());
        song_list.push_str("\n");
    }
    format!("Total songs: {}\n{}", song_list.lines().count(), song_list)
}

#[get("/")]
fn status(appstate: web::Data<AppState>) -> String {
    let sink = &appstate.sink;
    if sink.lock().unwrap().empty() {
        "paused".to_string()
    } else {
        "playing".to_string()
    }
}

fn main() -> Result<(), std::io::Error> {
    std::env::set_var("RUST_LOG", "actix_web=info");
    pretty_env_logger::init();

    let device = Arc::new(Mutex::new(rodio::default_output_device().unwrap()));
    let sink = Arc::new(Mutex::new(rodio::Sink::new(&device.lock().unwrap())));
    let state = AppState { device, sink };

    let server = HttpServer::new(move || {
        App::new()
            .data(state.clone())
            .wrap(middleware::Logger::default())
            .service(play_random_song)
            .service(stop_playback)
            .service(status)
            .service(list)
    })
    .bind("[::]:8080")?;

    println!("Started http server: 0.0.0.0:8080");
    server.run()
}
