sudo apt-get install lib32gcc1 screen
mkdir ~/steamcmd
cd ~/steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
sudo apt install libsdl2-2.0-0:i386
cp ~/steamcmd/linux32/libstdc++.so.6 ~/dst/bin/lib32/
sudo apt-get install libcurl4-gnutls-dev:i386
./steamcmd.sh +force_install_dir ~/dst +login anonymous +app_update 343050 validate +quit
