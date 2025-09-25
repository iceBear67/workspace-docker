function init
	if test -f /usr/sbin/tailscaled
		echo "Starting tailscaled"
		chmod +x /usr/sbin/tailscaled
		nohup /usr/sbin/tailscaled \
			--tun=userspace-networking \
			--socks5-server=localhost:1080 > /dev/null 2>&1 &
		echo "Started!"
	end
	echo "Looking for services from /etc/init.d/"
	for script in /etc/init.d/*
		if test -x script
			nohup $script start > /dev/null 2>&1 &
		end
	end
end

init
function on_term --on-signal SIGTERM
    echo "SIGTERM received, exiting"
    exit
end
fish


