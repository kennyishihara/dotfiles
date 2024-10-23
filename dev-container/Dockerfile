FROM ubuntu:24.10

# Main non-root username
ENV USER_NAME=naruto
ENV TERM=xterm-256color

###############################################################
# Update apt package lists and install a few dependencies
# Then install linuxbrew
###############################################################
RUN apt-get update && \
    apt-get install -y build-essential curl git zsh libfuse2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --create-home --shell /bin/bash linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# Set PATH for Homebrew
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

###############################################################
# Create new non-root user and install brew packages for that user only
###############################################################
USER root
ENV HOME=/home/$USER_NAME
RUN useradd --create-home --shell /bin/zsh $USER_NAME && \
    chown -R $USER_NAME:$USER_NAME $HOME && \
    chown -R $USER_NAME:$USER_NAME /home/linuxbrew/.linuxbrew && \
    chown -R $USER_NAME:$USER_NAME /home/linuxbrew
USER $USER_NAME

# Copy configuration files
COPY --chown=$USER_NAME:$USER_NAME ./ $HOME/.config/
RUN mv $HOME/.config/.zshrc $HOME/.zshrc && cd $HOME/.config && brew bundle

###############################################################
# Tmux Plugins
###############################################################
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

RUN cd $HOME/.tmux/plugins/tpm/scripts && ./install_plugins.sh

WORKDIR $HOME
CMD ["tail", "-f", "/dev/null"]
