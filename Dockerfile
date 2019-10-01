FROM theiaide/theia-full 
USER root

RUN apt-get -y install vim dnsutils traceroute htop jq net-tools netcat nmap nikto pandoc tcdump iputils-ping
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin

##GO
ENV GO_VERSION 1.13.1
ENV GOPATH=/usr/local/go-packages
ENV GO_ROOT=/usr/local/go
ENV PATH $PATH:/usr/local/go/bin
ENV PATH $PATH:${GOPATH}/bin

RUN rm -rf /usr/local/go && curl -sS https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xzf - && \
    go get -u -v github.com/nsf/gocode && \
    go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs && \
    go get -u -v github.com/ramya-rao-a/go-outline && \
    go get -u -v github.com/acroca/go-symbols && \
    go get -u -v golang.org/x/tools/cmd/guru && \
    go get -u -v golang.org/x/tools/cmd/gorename && \
    go get -u -v github.com/fatih/gomodifytags && \
    go get -u -v github.com/haya14busa/goplay/cmd/goplay && \
    go get -u -v github.com/josharian/impl && \
    go get -u -v github.com/tylerb/gotype-live && \
    go get -u -v github.com/rogpeppe/godef && \
    go get -u -v golang.org/x/tools/cmd/godoc && \
    go get -u -v github.com/zmb3/gogetdoc && \
    go get -u -v golang.org/x/tools/cmd/goimports && \
    go get -u -v sourcegraph.com/sqs/goreturns && \
    go get -u -v golang.org/x/lint/golint && \
    go get -u -v github.com/cweill/gotests/... && \
    go get -u -v github.com/alecthomas/gometalinter && \
    go get -u -v honnef.co/go/tools/... && \
    go get -u -v github.com/sourcegraph/go-langserver && \
    go get -u -v github.com/derekparker/delve/cmd/dlv && \
    go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct && \
    go get github.com/deepmap/oapi-codegen/cmd/oapi-codegen && \
    go get github.com/OJ/gobuster



#Ballerina
WORKDIR /tmp
RUN wget https://product-dist.ballerina.io/downloads/1.0.0/ballerina-linux-installer-x64-1.0.0.deb && dpkg -i ballerina-linux-installer-x64-1.0.0.deb
USER theia

RUN curl -s "https://get.sdkman.io" | bash
#RUN /bin/bash -c "source /home/theia/.sdkman/bin/sdkman-init.sh"
#RUN sdk install java 12.0.1.hs-adpt
WORKDIR /home/theia
ENTRYPOINT [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
