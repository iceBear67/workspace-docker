FROM golang:1.24
RUN git clone https://github.com/iceBear67/bubble && cd bubble/ && bash ./build.sh

FROM debian:11
COPY --from=0 /bubble/src/target/client /bin/bubble
RUN <<EOF
apt-get update && apt-get upgrade
apt-get install -y curl jq neovim htop fish tmux sudo git
useradd -m -s /bin/fish user
echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user.conf
EOF
COPY ./init.fish /home/user/.init.fish

