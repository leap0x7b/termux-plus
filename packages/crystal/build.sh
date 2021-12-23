TERMUX_PKG_HOMEPAGE=https://crystal-lang.org/
TERMUX_PKG_DESCRIPTION="A language for humans and computers"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@leapofazzam123"
TERMUX_PKG_VERSION=1.2.2
TERMUX_PKG_REVISION=5
TERMUX_PKG_SRCURL=https://github.com/crystal-lang/crystal/archive/refs/tags/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=6d963a71ef5f6c73faa272a0f81b50e9ddbf814b1ec07e557ce5c95f84d6077e
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libllvm, libgc, libevent, pcre"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_HOSTBUILD=true

termux_setup_crystal() {
	if [ "${TERMUX_PACKAGES_OFFLINE-false}" = "true" ]; then
		CRYSTAL_FOLDER=${TERMUX_SCRIPTDIR}/build-tools/crystal-${TERMUX_PKG_VERSION}
	else
		CRYSTAL_FOLDER=${TERMUX_COMMON_CACHEDIR}/crystal-${TERMUX_PKG_VERSION}
	fi

	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -x "$CRYSTAL_FOLDER/crystal" ]; then
			mkdir -p $CRYSTAL_FOLDER
			CRYSTAL_TARBALL=${TERMUX_PKG_TMPDIR}/crystal-${TERMUX_PKG_VERSION}.tar.gz
			termux_download https://github.com/crystal-lang/crystal/releases/download/${TERMUX_PKG_VERSION}/crystal-${TERMUX_PKG_VERSION}-1-linux-x86_64-bundled.tar.gz \
				"$CRYSTAL_TARBALL" \
				254f266d547434a00a470347147d0069a905c40b7761b9541d78796d76068450
			tar xf "$CRYSTAL_TARBALL" -C "$CRYSTAL_FOLDER"
		fi
		export PATH=$CRYSTAL_FOLDER:$PATH
	fi
}

termux_step_host_build() {
	termux_setup_crystal
	make PREFIX=$TERMUX_PKG_HOSTBUILD_DIR/crystal-host clean crystal install
}

termux_step_make() {
	make clean deps CXX=$CXX

	$TERMUX_PKG_HOSTBUILD_DIR/crystal-host/bin/crystal build --cross-compile \
		--target aarch64-unknown-linux-musl src/compiler/crystal.cr \
		-Dwithout_playground

	$CC crystal.o -o .build/crystal -rdynamic src/llvm/ext/llvm_ext.o \
		`$TERMUX_PKG_HOSTBUILD_DIR/bin/llvm-config --libs --system-libs --ldflags` \
		-lstdc++ -lpcre -lm -lgc -lpthread -levent -lrt -ldl

	if [ -d "shards" ]; then
		git clone https://github.com/crystal-lang/shards.git
		git -C shards pull
		git -C shards reset --hard ff94dd2ee46791e8e331f725fa1e4acdc13d5e9f
	fi

	cd shards
	make release=1 CRYSTAL=$TERMUX_PKG_HOSTBUILD_DIR/crystal-host/bin/crystal SHARDS=false
}

termux_step_make_install() {
	install -Dm700 "$TERMUX_PKG_BUILDDIR"/.build/crystal "$TERMUX_PREFIX"/bin/crystal
	install -Dm700 "$TERMUX_PKG_BUILDDIR"/shards/bin/shards "$TERMUX_PREFIX"/bin/shards
	install -Dm600 "$TERMUX_PKG_SRCDIR"/man/crystal.1 "$TERMUX_PREFIX"/share/man/man1/crystal.1
	install -Dm600 "$TERMUX_PKG_SRCDIR"/etc/completion.bash "$TERMUX_PREFIX"/share/bash-completion/completions/crystal
	install -Dm600 "$TERMUX_PKG_SRCDIR"/etc/completion.zsh "$TERMUX_PREFIX"/share/zsh/site-functions/_crystal

	mkdir -p "$TERMUX_PREFIX/lib/crystal"
	cp -r "$TERMUX_PKG_SRCDIR"/src/* "$TERMUX_PREFIX/lib/crystal"
}
