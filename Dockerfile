ARG ubuntu_version

FROM ubuntu:${ubuntu_version}

# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Environment setting
ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

# Avoid rbselect the geographic area'
ARG DEBIAN_FRONTEND=noninteractive

# Update ubuntu
RUN apt update && apt upgrade -y

# Install python3.8 and pip3
RUN apt install wget build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y
WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
RUN tar xzf Python-3.8.10.tgz
WORKDIR /usr/src/Python-3.8.10
RUN ./configure --enable-optimizations
RUN make altinstall

# RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.8 2
RUN echo "2" | update-alternatives --config python3

RUN apt install python3-pip -y
WORKDIR /

# Install basic tools
RUN apt install curl git wget file zsh sudo vim ruby ruby-full gem -y
# RUN chsh -s ~/.zshrc
# CMD [ "zsh" ]

# Install C compiler
RUN apt install build-essential libc6-i386 libc6-dbg gcc-multilib make gcc gdb glibc-source -y
RUN dpkg --add-architecture i386
RUN apt update && apt install libc6-dbg:i386 -y

# Install tmux (for gdb.attach)
RUN apt install tmux -y

# Install ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.zshrc

# RUN /root/.rbenv/bin/rbenv install 2.5.0
# RUN /root/.rbenv/bin/rbenv global 2.5.0

# Install one-gadget, seccomp-tools
# RUN gem install one_gadget seccomp-tools

# Install ropgadget, pwntools
# RUN pip3 install setuptools-rust && pip3 install --upgrade pip
# RUN pip3 install ropgadget pwntools

# Install gdb-peda
RUN git clone https://github.com/longld/peda.git ~/peda
RUN echo "source ~/peda/peda.py" >> ~/.gdbinit

# Install pwngdb
RUN git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb
RUN cp ~/Pwngdb/.gdbinit ~/

# Install zsh plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
RUN echo "source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
RUN echo "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=111'" >> ~/.zshrc

# Enable Tmux scroll
RUN echo "set -g mouse on" >> ~/.tmux.conf
