TERMUX_PKG_HOMEPAGE=https://github.com/Rigellute/spotify-tui
TERMUX_PKG_DESCRIPTION="Spotify for the terminal written in Rust"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@leapofazzam123"
TERMUX_PKG_VERSION=0.25.0
TERMUX_PKG_REVISION=13
TERMUX_PKG_SRCURL=https://github.com/Rigellute/spotify-tui/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9d6fa998e625ceff958a5355b4379ab164ba76575143a7b6d5d8aeb6c36d70a7
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm755 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/spt
}
