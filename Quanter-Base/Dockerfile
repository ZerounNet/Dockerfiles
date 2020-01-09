FROM zerounnet/conda-base:latest

RUN wget https://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz \
    && apt-get update  && apt-get install gcc make -y \
    && tar xvf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && cd .. \
    && rm -rf ta-lib* \
    && conda install -n base  jupyterlab tensorflow==1.15.0 tensorboard=1.15.0 keras py-xgboost  marshmallow==2.18.0 matplotlib pandas==0.24.2 tzlocal=1.5.1 numpy scikit-learn fastcache -y \
    && pip install TA-LIB pyecharts==0.5.11 tushare \
    && pip install quantaxis qastrategy qifiaccount tqsdk pytdx>=1.72 \
    && conda clean -a -y \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf \\
    && rm /root/.cache/ -rf 

