# Pull from fedora:latest
FROM fedora:latest
# Upgrade and install essential packages
RUN dnf upgrade -y;dnf install -y \
sudo \
ncurses \
cracklib \
cracklib-dicts \
iputils \
iproute \
curl \
neovim \
git \
gh \
openssh-server \
openssh-clients
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create system user and add to wheel group
RUN useradd -m -s /bin/bash monke
RUN usermod -aG wheel monke
RUN passwd -d monke

# Entry point for code-server
COPY entrypoint /home/monke/.config/entrypoint
RUN echo -e "\nalias backup=\"git add .;git commit -m 'Backup +$(date +\"%Y:%m:%d %H:%M:%S\");git push'\"\n\n# REMOVE IF YOU CHANGED THE PASSWORD\necho -e 'IMPORTANT: Please change your password via 'passwd' command\n(Change .bashrc to remove this prompt)'" >> /home/monke/.bashrc
RUN mkdir /home/monke/workspaces
RUN chown -R monke:monke /home/monke

# Expose ports and set user
EXPOSE 8080 8443
USER monke
WORKDIR /home/monke

# Start code-server
CMD ["/bin/bash", "/home/monke/.config/entrypoint"]
