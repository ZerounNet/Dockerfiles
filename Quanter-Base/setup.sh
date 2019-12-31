apt-get install wget -y
    
wget https://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz
apt-get install gcc make -y
tar xvf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure --prefix=/usr
make
make install
cd ..
rm -rf ta-lib
rm ta-lib-0.4.0-src.tar.gz

wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod u+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/conda
rm ./Miniconda3-latest-Linux-x86_64.sh

cat > /usr/local/conda/.condarc <<EOF
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
ln -s /usr/local/conda/.condarc ~/

/usr/local/conda/bin/conda install -n base python==3.6.9 -y
/usr/local/conda/bin/conda update -n base conda -y
/usr/local/conda/bin/conda install -n base  jupyter tensorflow==1.15.0 tensorboard=1.15.0 keras py-xgboost  marshmallow==2.18.0 matplotlib pandas==0.24.2 tzlocal=1.5.1 numpy scikit-learn fastcache -y

/usr/local/conda/bin/pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
/usr/local/conda/bin/pip install TA-LIB pyecharts==0.5.11 tushare
/usr/local/conda/bin/pip install quantaxis qastrategy qifiaccount tqsdk pytdx>=1.72

/usr/local/conda/bin/conda clean -a -y
rm /root/.cache/ -rf 
