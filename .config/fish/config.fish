fish_add_path /usr/local/sbin /usr/local/bin /usr/bin
fish_add_path ~/.nimble/bin

# source /etc/profile with bash
if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    exec fish"
end

if status is-interactive

end
