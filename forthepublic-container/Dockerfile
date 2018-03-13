FROM centos

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
	yum install -y epel-release && \
	yum upgrade -y && \
	yum groupinstall -y 'Development Tools' && \
	yum install -y \
	sudo \
	git \
	wget \
	tmux \
	vim \
	zsh \
	sbt \
	python-pip \
	python-devel \
	libXpm-devel \
	tkinter \
	perl-Tk \
	perl-Digest-MD5 && \
	yum clean all && rm -rf /var/cache/yum/*

RUN pip install --upgrade pip && \
	pip install beautifulsoup4 lxml bibtexparser

RUN cd /usr/local && \
    wget https://github.com/jgm/pandoc/releases/download/2.1.1/pandoc-2.1.1-linux.tar.gz && \
    tar xzvf pandoc-2.1.1-linux.tar.gz && \
    cd pandoc-2.1.1/bin && \
    cp pandoc* /usr/local/bin && \
    cd ../.. && \
    rm -r pandoc-2.1.1 && \
    rm pandoc-2.1.1-linux.tar.gz

ENV PATH $PATH:/usr/local/texlive/2017/bin/x86_64-linux

RUN cd /tmp && \
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    wget https://github.com/gutsche/docker-containers/raw/master/forthepublic-container/texlive.profile && \
    ./install-tl -profile texlive.profile && \
    cd /tmp && \
    rm -rf install-tl* && \
	echo "export PATH=\$PATH:/usr/local/texlive/2017/bin/x86_64-linux" | tee -a /etc/profile.d/texlive.sh > /dev/null && \
	tlmgr paper letter && \
	tlmgr install xetex lm lm-math unicode-math filehook xcolor zapfding booktabs

RUN adduser PlayerOne -s /bin/zsh && \
    echo "PlayerOne ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN cd /home/PlayerOne && \
    sudo -u PlayerOne wget https://github.com/gutsche/docker-containers/raw/master/forthepublic-container/setup.tgz && \
    sudo -u PlayerOne tar xzf setup.tgz && \
    sudo -u PlayerOne rm setup.tgz

CMD ["su", "-", "PlayerOne"]
