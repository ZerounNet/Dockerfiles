wget https://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz

sudo apt-get install gcc git make fonts-wqy-microhei -y
tar xvf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure --prefix=/usr
make
sudo make install
cd ..
rm -rf ta-lib
rm ta-lib-0.4.0-src.tar.gz

wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod u+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p ~/.conda
rm ./Miniconda3-latest-Linux-x86_64.sh
~/.conda/bin/conda init bash
#source ~/.bashrc

cat > ~/.condarc <<EOF
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
EOF

~/.conda/bin/conda install -n base python==3.6.9 -y
~/.conda/bin/conda update -n base conda -y
~/.conda/bin/conda install -n base  jupyter tensorflow==1.15.0 tensorboard=1.15.0 keras py-xgboost  marshmallow==2.18.0 matplotlib pandas==0.24.2 tzlocal=1.5.1 numpy scikit-learn fastcache -y

~/.conda/bin/pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
~/.conda/bin/pip install TA-LIB pyecharts==0.5.11 tushare
~/.conda/bin/pip install quantaxis qastrategy qifiaccount tqsdk pytdx>=1.72

mkdir ~/.config/matplotlib/ -p
cat > ~/.config/matplotlib/matplotlibrc <<EOF
font.family         : WenQuanYi Micro Hei, sans-serif 
font.sans-serif     : WenQuanYi Micro Hei, DejaVu Sans, Bitstream Vera Sans, Computer Modern Sans Serif, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif
axes.unicode_minus  : False
EOF
ln -s /usr/share/fonts/truetype/wqy/wqy-microhei.ttc ~/.conda/lib/python3.6/site-packages/matplotlib/mpl-data/fonts/ttf/

cat > ~/entrypoint.sh <<EOF
~/.conda/bin/pip install -U quantaxis qastrategy qifiaccount tqsdk tushare pytdx
dumb-init code-server --host 0.0.0.0 --port 8888
EOF
chmod u+x ~/entrypoint.sh

mkdir ~/.quantaxis/setting -p
cat > ~/.quantaxis/setting/config.ini <<EOF
[MONGODB]
uri = mongodb://mgdb:27017

[LOG]
path = '~/.quantaxis/log'
EOF

~/.conda/bin/conda clean -a -y

