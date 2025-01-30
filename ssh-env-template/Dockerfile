# Use the official Ubuntu 22.04 LTS as the base image
FROM ubuntu:24.04

# Set environment variable to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        sudo \
        curl \
        git \
        zsh \
        neovim \
        tmux \
        build-essential \
        software-properties-common \
        libssl-dev \
        cmake \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a new user 'naruto' with a home directory and add to sudoers
RUN useradd -m -s /bin/zsh naruto && \
    echo "naruto ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to 'naruto' user for subsequent operations
USER naruto
WORKDIR /home/naruto

# Copy the local .zshrc into the container
COPY --chown=naruto:naruto .zshrc /home/naruto/.zshrc

# Copy the local .config directory into the container
COPY --chown=naruto:naruto .config /home/naruto/.config

# Ensure the .zshrc has the correct permissions
RUN chmod 644 /home/naruto/.zshrc

# Create directories for custom Zsh plugins
RUN mkdir -p ~/.zsh/plugins

# Clone zsh-autosuggestions and zsh-syntax-highlighting plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting

# Source .zshrc
ENV PATH="/home/naruto/.cargo/bin:${PATH}"

# Install Cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install zoxide
RUN cargo install zoxide --locked

# Install gitui
RUN cargo install gitui --locked

# Install lsd
RUN cargo install lsd --locked

# Install Tmux Plugins
RUN git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
RUN cd $HOME/.tmux/plugins/tpm/scripts && ./install_plugins.sh

# Set the entrypoint command to keep the container running
CMD ["tail", "-f", "/dev/null"]
