FROM theiaide/theia-full 
USER root

RUN apt-get -y install vim dnsutils traceroute htop jq net-tools netcat nmap nikto pandoc tcpdump iputils-ping postgresql-client protobuf-compiler

RUN curl -sSL -o /usr/local/bin/argo https://github.com/argoproj/argo/releases/download/v2.3.0/argo-linux-amd64 && chmod +x /usr/local/bin/argo

RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v1.2.1/argocd-linux-amd64 && chmod +x /usr/local/bin/argocd

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin

##GO
ENV GO_VERSION 1.13.1
ENV GOPATH=/home/project/go
ENV GOBIN=$GOPATH/bin
ENV GO_ROOT=/usr/local/go
ENV PATH $PATH:/usr/local/go/bin
ENV PATH $PATH:${GOPATH}/bin

RUN rm -rf /usr/local/go && curl -sS https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xzf - 

#Ballerina
#WORKDIR /tmp
#RUN wget https://product-dist.ballerina.io/downloads/1.0.0/ballerina-linux-installer-x64-1.0.0.deb && dpkg -i ballerina-linux-installer-x64-1.0.0.deb

USER theia

RUN echo /home/theia/init/init.sh >> /home/theia/.bashrc

RUN curl -s "https://get.sdkman.io" | bash
#RUN /bin/bash -c "source /home/theia/.sdkman/bin/sdkman-init.sh"
#RUN sdk install java 12.0.1.hs-adpt
WORKDIR /home/theia
ENTRYPOINT [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
