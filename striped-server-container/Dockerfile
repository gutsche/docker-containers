FROM centos

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo && \
	yum install -y epel-release && \
	yum upgrade -y && \
	yum groupinstall -y 'Development Tools' && \
	yum install -y \
	sudo \
	git \
#	java-1.8.0-openjdk* \
	wget \
	tmux \
	vim \
	zsh \
	sbt \
	python-pip \
	python-devel \
#	libXpm-devel && \
	yum clean all && rm -rf /var/cache/yum/*

RUN pip install --upgrade pip

RUN pip install numpy jupyter vega
# matplotlib pandas pyarrow histogrammar

# scala https://www.scala-lang.org/download/
RUN cd /usr/lib && \
    wget https://downloads.lightbend.com/scala/2.12.4/scala-2.12.4.tgz && \
    tar xvf scala-2.12.4.tgz && \
    ln -s /usr/lib/scala-2.12.4 /usr/lib/scala && \
    rm scala-2.12.4.tgz && \
    echo "export PATH=\$PATH:/usr/lib/scala/bin" | tee -a /etc/profile.d/scala.sh > /dev/null

	# apache spark update page: http://mirrors.ocf.berkeley.edu/apache/spark/
RUN cd /usr/local && \
    wget http://mirrors.ocf.berkeley.edu/apache/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz && \
    tar xvf spark-2.3.0-bin-hadoop2.7.tgz && \
    ln -s /usr/local/spark-2.3.0-bin-hadoop2.7 /usr/local/spark && \
    rm spark-2.3.0-bin-hadoop2.7.tgz && \
    echo "export PATH=\$PATH:/usr/local/spark/bin" | tee -a /etc/profile.d/spark.sh > /dev/null

	# root update page: https://root.cern.ch/downloading-root
RUN cd /usr/local && \
    wget https://root.cern.ch/download/root_v6.12.06.Linux-centos7-x86_64-gcc4.8.tar.gz && \
    tar xzf root_v6.12.06.Linux-centos7-x86_64-gcc4.8.tar.gz && \
    mv root root_v6.12.06.Linux-centos7-x86_64-gcc4.8 && \
    ln -s root_v6.12.06.Linux-centos7-x86_64-gcc4.8 root && \
    rm root_v6.12.06.Linux-centos7-x86_64-gcc4.8.tar.gz && \
    echo "source /usr/local/root/bin/thisroot.sh" | tee -a /etc/profile.d/root.sh > /dev/null

RUN jupyter toree install --interpreters=Scala,PySpark --spark_home=/usr/local/spark

RUN adduser PlayerOne -s /bin/zsh && \
    echo "PlayerOne ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN cd /home/PlayerOne && \
    sudo -u PlayerOne wget https://github.com/gutsche/docker-containers/raw/master/spark-container/setup.tgz && \
    sudo -u PlayerOne tar xzf setup.tgz && \
    sudo -u PlayerOne rm setup.tgz

CMD ["su", "-", "PlayerOne"]
