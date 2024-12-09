set dotenv-load := true

build-native:
    cargo build --release

build-cross:
    cross build --release --target aarch64-unknown-linux-gnu

image:
    $CROSS_CONTAINER_ENGINE build -t cross:aarch64-unknown-linux-gnu-custom .
