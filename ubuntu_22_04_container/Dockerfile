FROM ubuntu:22.04

RUN apt update && \
    apt upgrade -y && \
    apt install -y sudo wget tmux vim zsh python3 curl make git

RUN useradd -m --shell /bin/zsh playerone && \
    echo "playerone ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN cd /home/playerone && \
    sudo -u playerone wget https://github.com/gutsche/docker-containers/raw/master/ubuntu_22_04_container/setup.tgz && \
    sudo -u playerone tar xzf setup.tgz && \
    sudo -u playerone rm setup.tgz

CMD ["su", "-", "playerone"]
