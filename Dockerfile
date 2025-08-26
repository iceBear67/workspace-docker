FROM alpine/git
WORKDIR /src
RUN git clone https://github.com/iceBear67/bubble .

FROM debian:13
COPY --from=0 --chmod=0755 /src/bubble.sh /bin/bubble
RUN <<EOF
apt-get update && apt-get upgrade
chmod +x /bin/bubble
apt-get install -y curl jq neovim htop fish tmux sudo git iproute2 iputils-ping dnsutils build-essential htop
useradd -m -s /usr/bin/fish user
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -u user mkdir -p /home/user/.config/fish/
EOF
COPY ./init.fish /init.fish
COPY --chown=user ./user.fish /home/user/.config/fish/config.fish

