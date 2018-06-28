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
	yum clean all && rm -rf /var/cache/yum/*

RUN pip install --upgrade pip && \
	pip install numpy jupyter vega

# histbook
RUN cd /usr/local/lib && \
	git clone https://github.com/scikit-hep/histbook.git && \
	cd histbook && \
	git checkout issue-37 && \
	python setup.py install

# striped server client
RUN cd /usr/local/lib && \
	git clone http://cdcvs.fnal.gov/projects/nosql-ldrd striped && \
	cd striped/qworker/stripe_tools && \
	python setup.py install

RUN adduser PlayerOne -s /bin/zsh && \
    echo "PlayerOne ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user && \
		cd /home/PlayerOne && \
    sudo -u PlayerOne wget https://github.com/gutsche/docker-containers/raw/master/striped-server-container/setup.tgz && \
    sudo -u PlayerOne tar xzf setup.tgz && \
    sudo -u PlayerOne rm setup.tgz

CMD ["su", "-", "PlayerOne"]
