#!/data/data/com.termux/files/usr/bin/sh
# when testing, wget and curl doesnt use the latest version of the script, wtf
export REPO_URL="https://leapofazzam123.github.io/termux-plus"
echo "[:] Adding Termux Plus..."
echo "deb [trusted=yes] $REPO_URL plus apt" > $PREFIX/etc/apt/sources.list.d/termux-plus.list
echo "[:] Updating APT repository..."
apt update
echo "[✓] Succesfully set up Termux Plus. Run 'apt list | grep plus' to list Termux Plus packages"
