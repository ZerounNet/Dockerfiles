FROM codercom/code-server:v2

COPY setup.sh ./

RUN  sudo sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sudo sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y \
    && sudo  apt-get install apt-utils -y \
    && sudo chown coder:coder setup.sh \
    && chmod u+x setup.sh && ./setup.sh && rm -rfv setup.sh \
    && mkdir ~/.vscode \
    && sudo apt-get clean -y && sudo rm /tmp/* -rf && sudo rm ~/.cache/ -rf && sudo rm /var/lib/apt/lists/* -rf

COPY ./extensions ~/.vscode/

ENTRYPOINT ["bash", "/home/coder/entrypoint.sh"]
