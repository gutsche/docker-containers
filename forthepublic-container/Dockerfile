FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago
RUN apt update && \
    apt upgrade -y && \
    apt install -y tzdata && \
    apt install -y sudo wget tmux vim zsh hugo pandoc pandoc-citeproc python3 python3-pip curl make m4 texlive-xetex golang

RUN python3 -m pip install beautifulsoup4 lxml bibtexparser

RUN useradd -m --shell /bin/zsh playerone && \
    echo "playerone ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN cd /home/playerone && \
    sudo -u playerone wget https://github.com/gutsche/docker-containers/raw/master/ubuntu_20_04_container/setup.tgz && \
    sudo -u playerone tar xzf setup.tgz && \
    sudo -u playerone rm setup.tgz

CMD ["su", "-", "playerone"]
