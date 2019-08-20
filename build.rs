//! Convert all music in music/ to ogg.

use std::env;
use std::fs;
use std::fs::File;
use std::path::Path;
use std::process::Command;
use tar::Builder;

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
    let music_dir = Path::new("music");
    let non_ogg_music_extensions = vec!["mp3", "opus", "flac"];

    let output_tar_path = Path::new(&out_dir).join("music.tar");
    let output_tar_file = File::create(output_tar_path).expect("Couldn't create output tar file");
    let mut output_archive = Builder::new(output_tar_file);

    for entry in fs::read_dir(music_dir).expect("Couldn't open music dir") {
        let good_entry = entry.expect("Something weird happened");
        if good_entry
            .file_type()
            .expect("Couldn't get filetype for some reason")
            .is_file()
        {
            let input_path = good_entry.path();

            let input_ext = input_path.extension().unwrap().to_str().unwrap();
            if non_ogg_music_extensions.contains(&input_ext) {
                let output_file_path = input_path.with_extension("ogg");
                let output_file_name = output_file_path.file_name().unwrap();
                let output_final_path = Path::new(&out_dir).join(output_file_name);

                println!(
                    "Converting {input} to {output}",
                    input = input_path.to_string_lossy(),
                    output = output_final_path.to_string_lossy()
                );

                // Finally after all the path fuckery use ffmpeg to convert all input media to ogg.
                // Don't judge me. ogg is fine.
                let ffmpeg_command = Command::new("ffmpeg")
                    .arg("-n")
                    .arg("-i")
                    .arg(input_path)
                    .arg(&output_final_path)
                    .output();

                println!("{:?}", ffmpeg_command);
                ffmpeg_command.expect("ffmpeg failed somehow");

                let mut f = File::open(output_final_path).expect("Couldn't open output file for reading");
                output_archive.append_file(output_file_name, &mut f).unwrap();
            }
        }
    }
}
