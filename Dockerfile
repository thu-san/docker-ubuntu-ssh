#! REFERENCE : https://docs.docker.com/engine/examples/running_ssh_service/

FROM ubuntu

#* INSTALL ADDITIONAL PACKAGES
RUN apt-get update && apt-get install -y vim less mlocate
RUN updatedb

#* INSTLL SSH SERVER
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN systemctl enable ssh

RUN passwd -d root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# # SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

ENV LANG C.UTF-8
RUN echo "export LC_ALL=C.UTF-8" >> ~/.profile
RUN echo "export LANG=C.UTF-8" >> ~/.profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]