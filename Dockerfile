FROM centos

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo

RUN yum install -y epel-release

RUN yum upgrade -y

RUN yum groupinstall -y 'Development Tools'

RUN yum install -y sudo git java-1.8.0-openjdk* wget tmux vim zsh sbt python-pip python-devel libXpm-devel

RUN pip install --upgrade pip

RUN pip install numpy jupyter matplotlib pandas pyarrow histogrammar
RUN pip install https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0-incubating-rc3/toree-pip/toree-0.2.0.tar.gz

RUN cd /usr/lib && \
    wget https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz && \
    tar xvf scala-2.11.8.tgz && \
    ln -s /usr/lib/scala-2.11.8 /usr/lib/scala && \
    rm scala-2.11.8.tgz && \
    echo "export PATH=\$PATH:/usr/lib/scala/bin" | tee -a /etc/profile.d/scala.sh > /dev/null

RUN cd /usr/local && \
    wget http://mirrors.ocf.berkeley.edu/apache/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz && \
    tar xvf spark-2.2.1-bin-hadoop2.7.tgz && \
    ln -s /usr/local/spark-2.2.1-bin-hadoop2.7 /usr/local/spark && \
    rm spark-2.2.1-bin-hadoop2.7.tgz && \
    echo "export SPARK_EXAMPLES_JAR=/usr/local/spark/examples/jars/spark-examples_2.11-2.2.1.jar" | tee -a /etc/profile.d/spark.sh > /dev/null && \
    echo "export PATH=\$PATH:/usr/local/spark/bin" | tee -a /etc/profile.d/spark.sh > /dev/null

RUN cd /usr/local && \
    wget https://root.cern.ch/download/root_v6.10.08.Linux-centos7-x86_64-gcc4.8.tar.gz && \
    tar xzf root_v6.10.08.Linux-centos7-x86_64-gcc4.8.tar.gz && \
    mv root root_v6.10.08.Linux-centos7-x86_64-gcc4.8 && \
    ln -s root_v6.10.08.Linux-centos7-x86_64-gcc4.8 root && \
    rm root_v6.10.08.Linux-centos7-x86_64-gcc4.8.tar.gz && \
    echo "source /usr/local/root/bin/thisroot.sh" | tee -a /etc/profile.d/root.sh > /dev/null

RUN jupyter toree install --interpreters=Scala,PySpark --spark_home=/usr/local/spark

RUN adduser PlayerOne -s /bin/zsh && \
    echo "PlayerOne ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN cd /home/PlayerOne && \
    sudo -u PlayerOne wget https://www.dropbox.com/s/kl2w1457wtejvbb/setup_180123.tgz && \
    sudo -u PlayerOne tar xzf setup_180123.tgz && \
    sudo -u PlayerOne rm setup_180123.tgz

CMD ["su", "-", "PlayerOne"]
