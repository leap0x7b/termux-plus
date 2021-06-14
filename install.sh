#!/data/data/com.termux/files/bin/sh
export REPO_URL="https://leapofazzam123.github.io/termux-plus"
echo "[:] Adding Termux Plus..."
echo "deb [trusted=yes] $REPO_URL termux plus" > $PREFIX/etc/apt/sources.d/termux-plus.list
echo "[:] Updating APT repository..."
apt update
echo "[✓] Succesfully set up Termux Plus. Run 'apt list | grep plus' to list Termux Plus packages"
