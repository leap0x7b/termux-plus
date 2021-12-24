#!/data/data/com.termux/files/usr/bin/sh
REPO_URL="https://leapofazzam123.github.io/termux-plus"

echo "[*] Adding Termux Plus..."
echo "deb [trusted=yes] $REPO_URL plus apt" > $PREFIX/etc/apt/sources.list.d/termux-plus.list
echo "[*] Updating APT repository..."
apt update
echo "[✓] Succesfully set up Termux Plus. Go to https://github.com/leapofazzam123/termux-plus/tree/master/packages for list of packages available on Termux Plus"
