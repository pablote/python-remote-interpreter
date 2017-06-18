FROM ubuntu
USER root
RUN apt-get update && apt-get install -y python python3 python-pip python3-pip wget openssh-server tar vim

RUN echo "root:training" | chpasswd
RUN sed -i 's/prohibit-password/yes/' /etc/ssh/sshd_config
#ADD ssh.tar /root/
RUN mkdir /root/.ssh;chown -R root:root /root/.ssh;chmod -R 700 /root/.ssh
RUN echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config
RUN mkdir /var/run/sshd
RUN service ssh start

ADD start.sh /

EXPOSE 22
CMD bash /start.sh


