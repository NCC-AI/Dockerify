FROM nvidia/cuda:8.0-cudnn6-runtime

RUN echo "root:root" | chpasswd
RUN apt-get update  --fix-missing
RUN apt-get -y install sudo curl git vim zsh unzip imagemagick bzip2 language-pack-ja
RUN apt-get -y install htop xsel
RUN apt-get -y install libglib2.0-0 libsm6 libxrender1 libxext6 libgl1-mesa-glx

# python env
WORKDIR /usr/local/bin
RUN git clone git://github.com/yyuu/pyenv.git .pyenv

ENV PYENV_ROOT /usr/local/bin/.pyenv
ENV PATH $PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin

RUN pyenv install anaconda3-5.0.1
RUN pyenv global anaconda3-5.0.1
RUN pyenv rehash

RUN pip install --upgrade pip
RUN pip install opencv-python tqdm h5py keras==2.1.0 tensorflow-gpu==1.4.0 kaggle-cli gym
RUN pip install chainer
RUN pip install http://download.pytorch.org/whl/cu90/torch-0.4.0-cp36-cp36m-linux_x86_64.whl
RUN pip install torchvision


# create user

RUN groupadd hiroki -g 1000 && useradd -m hiroki -u 1000 -g 1000
RUN usermod -s /bin/bash hiroki
RUN echo "hiroki:nccy" | chpasswd

RUN gpasswd -a hiroki sudo

WORKDIR /home/hiroki
RUN sudo -u hiroki touch "true"
RUN sudo -u hiroki mkdir -p .ssh
RUN sudo -u hiroki chmod 700 .ssh
RUN sudo -u hiroki touch .ssh/authorized_keys
RUN sudo -u hiroki chmod 600 .ssh/authorized_keys
RUN sudo -u hiroki echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUXurqEGm+nx0LDdxT+ABDWt2uNyrg5KDMq8dGeG9A60IbPrAv4ljSSQB7trn8AlOj9efWD806+UBLUFPUWrvkYQB++Lp/3M7v1XLEwTWfxv2YojfkyvlxLw5GkPnKetI+g9VxqJ+fcn+a6uwxJ0tLLY3XU+qOdIC35vKl/lI7/NAtzgOr2bipsCI4eYfp2aEmY5pGMhzKj/2ZMug4MXi0E9Z/vM0NrzQlbQlkOEnhkTM2Zl2pJ8II9ZBpdM2KWv8ce1J1meyPf3LLdqZiOTnryuwGNQ7vl8RiA/TTALFdrZ+arFDrxNjETmio3P1r9S/GGebaiT6JSXdY917tfn5x 1234defgsigeru@gmail.com" > .ssh/authorized_keys
RUN sudo -u hiroki echo "export PYENV_ROOT=/usr/local/bin/.pyenv" >> .bashrc
RUN sudo -u hiroki echo "export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH" >> .bashrc

RUN groupadd yoshiki -g 1001 && useradd -m yoshiki -u 1001 -g 1001
RUN usermod -s /bin/bash yoshiki
RUN echo "yoshiki:nccy" | chpasswd

RUN gpasswd -a yoshiki sudo

WORKDIR /home/yoshiki
RUN sudo -u yoshiki touch "true"
RUN sudo -u yoshiki mkdir -p .ssh
RUN sudo -u yoshiki chmod 700 .ssh
RUN sudo -u yoshiki touch .ssh/authorized_keys
RUN sudo -u yoshiki chmod 600 .ssh/authorized_keys
RUN sudo -u yoshiki echo "jjjjjjjjjjjjjjjjjjjjjjjjjj" > .ssh/authorized_keys
RUN sudo -u yoshiki echo "export PYENV_ROOT=/usr/local/bin/.pyenv" >> .bashrc
RUN sudo -u yoshiki echo "export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH" >> .bashrc

RUN groupadd takano -g 1002 && useradd -m takano -u 1002 -g 1002
RUN usermod -s /bin/bash takano
RUN echo "takano:nccy" | chpasswd

WORKDIR /home/takano
RUN sudo -u takano touch "false"
RUN sudo -u takano mkdir -p .ssh
RUN sudo -u takano chmod 700 .ssh
RUN sudo -u takano touch .ssh/authorized_keys
RUN sudo -u takano chmod 600 .ssh/authorized_keys
RUN sudo -u takano echo "eeeeeeeeeeeeeeeeeeee" > .ssh/authorized_keys
RUN sudo -u takano echo "export PYENV_ROOT=/usr/local/bin/.pyenv" >> .bashrc
RUN sudo -u takano echo "export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH" >> .bashrc



WORKDIR /root

# ssh server
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN sed -i -e "s/\#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
EXPOSE 22

# cleanup
RUN apt-get autoremove && apt-get clean

# default shell
CMD /usr/sbin/sshd -D && tail -f /dev/null
