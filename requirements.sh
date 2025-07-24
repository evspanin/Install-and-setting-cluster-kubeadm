#!/bin/bash
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service && \
wget https://github.com/containerd/containerd/releases/download/v2.1.3/containerd-2.1.3-linux-amd64.tar.gz && \
wget https://github.com/opencontainers/runc/releases/download/v1.3.0/runc.amd64 && \
wget https://github.com/containernetworking/plugins/releases/download/v1.7.1/cni-plugins-linux-amd64-v1.7.1.tgz && \
wget https://github.com/containerd/nerdctl/releases/download/v2.1.2/nerdctl-2.1.2-linux-amd64.tar.gz && \
wget https://github.com/moby/buildkit/releases/download/v0.23.1/buildkit-v0.23.1.linux-amd64.tar.gz && \
sudo mkdir -p /etc/containerd && sudo mkdir -p /opt/cni/bin && sudo mkdir -p /usr/local/lib/systemd/system && \
sudo tar Cxzvf /usr/local/ containerd-2.1.3-linux-amd64.tar.gz && \
containerd config default | sudo tee /etc/containerd/config.toml && \
sudo tar Cxvf /usr/local/ buildkit-v0.23.1.linux-amd64.tar.gz && \
sudo install -m 0755 runc.amd64 /usr/local/sbin/runc && \
sudo tar Cxvf /usr/local/bin/ nerdctl-2.1.2-linux-amd64.tar.gz && \
sudo tar Cxvzf /opt/cni/bin cni-plugins-linux-amd64-v1.7.1.tgz && \
sudo cp containerd.service /usr/local/lib/systemd/system/ && \
sudo cp containerd.service buildkitd.service && \
sudo sed -i 's|/usr/loca/bin/containerd|/usr/local/bin/buildkitd|g' buildkitd.service && \
sudo cp buildkitd.service /usr/local/lib/systemd/system/ && \
sudo systemctl daemon-reload
