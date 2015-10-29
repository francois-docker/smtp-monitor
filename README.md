# smtp-monitor

docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker -v ~/smtp_monitor/authorized_addresses.list:/root/authorized_addresses.list -v ~/smtp_monitor/already_sent.list:/root/already_sent.list francois/smtp-monitor:latest

