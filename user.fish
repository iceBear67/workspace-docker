echo "Type 'bubble' for help."

if test ! -e /usr/sbin/tailscaled
	echo "Tailscale is not installed. Type 'install-tailscale' to install if needed."
end

function exit
    if test ! -z "$TMUX"
        tmux detach
    else
        builtin exit
    end
end

function logout
    exit
end

function install-tailscale
	if test -f /usr/sbin/tailscaled
		echo "Tailscale is already installed at /usr/sbin/tailscaled"
		return
	end
	if curl -fsSL https://tailscale.com/install.sh | sh
		echo "[TAILSCALE] Tailscale should be installed successfully. Starting tailscaled..."
		sudo nohup /usr/sbin/tailscaled --tun=userspace-networking --socks5-server=localhost:1080 > /dev/null 2>&1 &
		echo "Tailscaled is running in background. try running 'tailscale status'"
	else
		echo "Failed to install tailscale."
	end
end
