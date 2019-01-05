use actix_web::{middleware, server, App, HttpRequest, http};
use rand::{Rng, thread_rng};
use std::io::{Read, Cursor};
use std::sync::Arc;
use std::sync::Mutex;
use tar::Archive;

const AUDIO_FILES: &[u8] = include_bytes!(concat!(env!("OUT_DIR"), "/music.tar"));

#[derive(Clone)]
struct AppState {
    device: Arc<Mutex<rodio::Device>>,
    sink: Arc<Mutex<rodio::Sink>>,
}

fn play_random_song(req: &HttpRequest<AppState>) -> String {
    let mut rng = thread_rng();

    let mut archive_for_count = Archive::new(AUDIO_FILES);
    let songs_count = archive_for_count
        .entries()
        .expect("tar read error")
        .count();

    let mut archive = Archive::new(AUDIO_FILES);
    let songs = archive
        .entries()
        .expect("tar read error");

    let rnd_index = rng.gen_range(0, songs_count);

    let song = songs
        .skip(rnd_index)
        .next()
        .expect("Empty tar");

    let mut buffer = Vec::new();
    let mut f = song.unwrap();

    println!("Playing {}", f.path().unwrap().to_string_lossy());
    f.read_to_end(&mut buffer).unwrap();
    let reader = Cursor::new(buffer);

    let sink = &req.state().sink;
    let device = &req.state().device.lock().unwrap();
    sink.lock().unwrap().stop();
    *sink.lock().unwrap() = rodio::Sink::new(&device);
    sink.lock().unwrap().append(rodio::Decoder::new(reader).unwrap());
    // sink.lock().unwrap().play();

    format!("Playing {}", f.path().unwrap().to_string_lossy())
}

fn stop_playback(req: &HttpRequest<AppState>) -> String {
    let sink = &req.state().sink;
    let device = &req.state().device.lock().unwrap();
    sink.lock().unwrap().stop();
    *sink.lock().unwrap() = rodio::Sink::new(&device);

    format!("Stopped playback")
}

fn main() {
    std::env::set_var("RUST_LOG", "actix_web=info");
    pretty_env_logger::init();

    let device = Arc::new(Mutex::new(rodio::default_output_device().unwrap()));
    let sink = Arc::new(Mutex::new(rodio::Sink::new(&device.lock().unwrap())));
    let state = AppState {
        device,
        sink,
    };

    let sys = actix::System::new("piplayer");

    server::new(move || {
        App::with_state(state.clone())
            .middleware(middleware::Logger::default())
            .resource("/play_random_song", |r| r.method(http::Method::PUT).f(play_random_song))
            .resource("/stop_playback", |r| r.method(http::Method::PUT).f(stop_playback))
    })
    .bind("0.0.0.0:8080")
        .unwrap()
        .start();

    println!("Started http server: 0.0.0.0:8080");
    let _ = sys.run();
}
