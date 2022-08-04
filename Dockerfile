ARG ubuntu_version

FROM ubuntu:${ubuntu_version}

# Environment setting
ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

# Avoid 'select the geographic area'
ARG DEBIAN_FRONTEND=noninteractive

# Update ubuntu
RUN apt update && apt upgrade -y

# Install python3
RUN apt install python3 python3-pip -y

# Install basic tools
RUN apt install curl git wget file zsh sudo vim ruby ruby-full gem -y

# Install C compiler
RUN apt install build-essential libc6-i386 libc6-dbg gcc-multilib make gcc gdb glibc-source -y
RUN dpkg --add-architecture i386
RUN apt update && apt install libc6-dbg:i386 -y

# Install tmux (for gdb.attach)
RUN apt install tmux -y

# Install one-gadget, seccomp-tools
RUN gem install one_gadget seccomp-tools

# Install ropgadget, pwntools
RUN pip3 install setuptools-rust && pip3 install --upgrade pip
RUN pip3 install ropgadget pwntools

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