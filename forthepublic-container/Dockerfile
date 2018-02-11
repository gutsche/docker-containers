FROM centos

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo

RUN yum install -y epel-release

RUN yum upgrade -y

RUN yum groupinstall -y 'Development Tools'

RUN yum install -y sudo git wget tmux vim zsh sbt python-pip python-devel libXpm-devel tkinter texlive

RUN pip install --upgrade pip

RUN pip install beautifulsoup4 lxml bibtexparser

RUN cd /usr/local && \
    wget https://github.com/jgm/pandoc/releases/download/2.1.1/pandoc-2.1.1-linux.tar.gz && \
    tar xzvf pandoc-2.1.1-linux.tar.gz && \
    cd pandoc-2.1.1/bin && \
    cp pandoc* /usr/local/bin && \
    cd ../.. && \
    rm -r pandoc-2.1.1 && \
    rm pandoc-2.1.1-linux.tar.gz

RUN adduser PlayerOne -s /bin/zsh && \
    echo "PlayerOne ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN cd /home/PlayerOne && \
    sudo -u PlayerOne wget https://github.com/gutsche/docker-containers/raw/master/forthepublic-container/setup.tgz && \
    sudo -u PlayerOne tar xzf setup.tgz && \
    sudo -u PlayerOne rm setup.tgz

CMD ["su", "-", "PlayerOne"]
