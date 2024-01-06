# install ncurses
sudo apt-get -yy install libncurses5-dev libncursesw5-dev
sudo apt-get -yy install autoconf
git clone https://github.com/jonas/tig.git
cd tig
make configure
./configure
make
make install
rm -rf git