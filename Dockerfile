FROM theiaide/theia-full 
USER root
##GO
ENV GO_VERSION 1.13.1
ENV GOPATH=/usr/local/go-packages
ENV GO_ROOT=/usr/local/go
ENV PATH $PATH:/usr/local/go/bin
ENV PATH $PATH:${GOPATH}/bin

RUN curl -sS https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xzf - 


#Ballerina
WORKDIR /tmp
RUN wget https://product-dist.ballerina.io/downloads/1.0.0/ballerina-linux-installer-x64-1.0.0.deb && dpkg -i ballerina-linux-installer-x64-1.0.0.deb
USER theia

RUN curl -s "https://get.sdkman.io" | bash
#RUN /bin/bash -c "source /home/theia/.sdkman/bin/sdkman-init.sh"
#RUN sdk install java 12.0.1.hs-adpt

ENTRYPOINT [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
