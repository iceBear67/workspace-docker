if ! cat /etc/passwd | grep -E "^user"
    echo "User was not created correctly. Creating user..."
    useradd -m -s /usr/bin/fish user
    if test ! -e /etc/sudoers.d/user.conf
        echo "Setting sudo permissions"
        mkdir -p /etc/sudoers.d/
        echo "user ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/user.conf
    end
    echo "Due to abnormal user creation, auto configuration guide is not available in this setup."
    echo "Try 'bubble destroy' for a new container if needed."
end

function resume
    if test (sudo -u user tmux list-windows | wc -l) -eq 0
        sudo -u user tmux
        return
    end
    if sudo -u user tmux has-session -t 0
        if sudo -u user tmux ls | grep -E "^0.*attached)"
            echo "The default tmux session has been attached, dropping you to a normal shell."
            cd /home/user && sudo -u user /usr/bin/fish
        else
            sudo -u user tmux attach -t 0
        end
    else
        sudo -u user tmux new-session -c /home/user /usr/bin/fish
    end
end

resume
