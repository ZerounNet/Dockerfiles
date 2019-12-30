wget https://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz

apt-get install gcc git make fonts-wqy-microhei -y
tar xvf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure --prefix=/usr
make
make install
cd ..
rm -rf ta-lib
rm ta-lib-0.4.0-src.tar.gz

mkdir /root/.conda
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod u+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/conda
rm ./Miniconda3-latest-Linux-x86_64.sh
echo 'export PATH="/usr/local/conda/bin:$PATH"' >> ~/.bashrc
PATH="/usr/local/conda/bin:$PATH"

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

conda install -n base python==3.6.9 -y
conda update -n base conda -y
conda install -n base  tensorflow-gpu==1.15.0 tensorborad=1.15.0 keras py-xgboost  marshmallow==2.18.0 matplotlib pandas==0.24.2 tzlocal=1.5.1 numpy scikit-learn -y

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install TA-LIB pyecharts==0.5.11
pip install quantaxis qastrategy qifiaccount tqsdk tushare pytdx

mkdir ~/.config/matplotlib/ -p
cat > ~/.config/matplotlib/matplotlibrc <<EOF
font.family         : WenQuanYi Micro Hei, sans-serif 
font.sans-serif     : WenQuanYi Micro Hei, DejaVu Sans, Bitstream Vera Sans, Computer Modern Sans Serif, Lucida Grande, Verdana, Geneva, Lucid, Arial, Helvetica, Avant Garde, sans-serif
axes.unicode_minus  : False
EOF
ln -s /usr/share/fonts/truetype/wqy/wqy-microhei.ttc /usr/local/conda/lib/python3.6/site-packages/matplotlib/mpl-data/fonts/ttf/

mkdir ~/.jupyter/
cat > ~/.jupyter/jupyter_notebook_config.py <<EOF
c.NotebookApp.ip = '127.0.0.1'
c.NotebookApp.port = '8888'
c.NotebookApp.notebook_dir = '/home'
c.NotebookApp.open_browser = False
c.MultiKernelManager.default_kernel_name = 'python3'
c.NotebookApp.allow_credentials = True
c.NotebookApp.allow_origin = '*'
c.NotebookApp.allow_remote_access = True
c.NotebookApp.tornado_settings = { 'headers': { 'Content-Security-Policy': "" }}
EOF

cat > /entrypoint.sh <<EOF
PATH="/usr/local/conda/bin:\$PATH"
pip install -U quantaxis qastrategy qifiaccount tqsdk tushare pytdx
jupyter lab --allow-root
EOF
chmod u+x /entrypoint.sh

conda clean -a