FROM ubuntu
USER root

RUN apt-get update \
  && apt-get install -y python python3 python-pip python3-pip wget openssh-server tar vim \
  && echo "root:training" | chpasswd \
  && sed -i 's/prohibit-password/yes/' /etc/ssh/sshd_config

#ADD ssh.tar /root/
ADD start.sh /
ADD helpers/build.txt /root/.pycharm_helpers

RUN mkdir /root/.ssh \
  && chown -R root:root /root/.ssh \
  && chmod -R 700 /root/.ssh \
  && echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config \
  && mkdir /var/run/sshd \
  && service ssh start

EXPOSE 22
CMD bash /start.sh
