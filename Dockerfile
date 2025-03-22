FROM golang:1.24
RUN git clone https://github.com/iceBear67/bubble /bubble && cd /bubble/ && bash ./build.sh

FROM debian:11
COPY --from=0 /bubble/target/client /bin/bubble
RUN <<EOF
apt-get update && apt-get upgrade
chmod +x /bin/bubble
apt-get install -y curl jq neovim htop fish tmux sudo git
useradd -m -s /usr/bin/fish user
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -u user mkdir -p /home/user/.config/fish/
EOF
COPY ./init.fish /init.fish
COPY --chown=user ./user.fish /home/user/.config/fish/config.fish

