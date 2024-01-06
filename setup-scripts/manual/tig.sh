# install ncurses
sudo apt-get install --allow-unauthenticated -yy libncurses5-dev libncursesw5-dev
sudo apt-get install --allow-unauthenticated -yy autoconf
git clone https://github.com/jonas/tig.git
cd tig
make configure
./configure
make
make install
rm -rf git