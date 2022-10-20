FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

ADD sshd_config /etc/ssh/sshd_config

# add user dev with password dev123
RUN useradd -ms /bin/bash dev && echo "dev:dev" | chpasswd

EXPOSE 2222

# sleep infinity
CMD ["/bin/bash", "-c", "service ssh start && sleep infinity"]
