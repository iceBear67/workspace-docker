if test -e /workspace/manager.sock
    echo "Manager capability is detected. Type 'bubble' for help."
end

if test ! -e /bin/docker
    echo "Docker is not installed. Type 'install-docker' to install if needed."
end

function exit
    tmux detach && exit
end

function install-docker
    if test -e /bin/docker
        echo "Docker is already present at /bin/docker."
        return
    end
    echo "Installing docker in 3s."
    sleep 3s
    echo "[DOCKER] Updating software registry."
    sudo apt-get update
    sudo apt-get install ca-certificates
    echo "[DOCKER] Updating package manager keyrings"
    sudo install -m 0755 -d /etc/apt/keyrings
    echo "[DOCKER] Adding trust for docker repository"
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "[DOCKER] Adding docker repository"
    bash -c 'echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
    sudo apt-get update
    echo "[DOCKER] Installing docker"
    if sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        echo "[DOCKER] Docker should be installed successfully"
    else
        echo "Unexpected error."
    end
end
