FROM theiaide/theia-full:0.12.0-next.fa116f03 
USER root

RUN apt-get update && apt-get -y install vim dnsutils traceroute htop jq net-tools netcat nmap nikto pandoc tcpdump iputils-ping postgresql-client protobuf-compiler silversearcher-ag


ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 19.03.3

RUN curl -sSL -o /usr/local/bin/argo https://github.com/argoproj/argo/releases/download/v2.3.0/argo-linux-amd64 && chmod +x /usr/local/bin/argo && \
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v1.2.1/argocd-linux-amd64 && chmod +x /usr/local/bin/argocd && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin && \
    wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar --extract --file docker.tgz --strip-components 1 --directory /usr/local/bin/ && \
    rm docker.tgz

##GO
ENV GO_VERSION 1.13.1
ENV GOPATH=/home/project/go
ENV GOBIN=$GOPATH/bin
ENV GO_ROOT=/usr/local/go
ENV PATH $PATH:/usr/local/go/bin
ENV PATH $PATH:${GOPATH}/bin

RUN rm -rf /usr/local/go && curl -sS https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xzf - 

USER theia

ENV HOME=/home/theia
WORKDIR ${HOME} 
USER theia

ENV VIM_BUNDLE=${HOME}/.vim/pack/bundle/start
RUN git clone https://github.com/fatih/vim-go.git ${VIM_BUNDLE}/vim-go && \
    git clone https://github.com/itchyny/lightline.vim  ${VIM_BUNDLE}/lightline && \
    git clone https://github.com/raimondi/delimitmate ${VIM_BUNDLE}/delimitmate && \
    git clone https://github.com/junegunn/fzf.vim ${VIM_BUNDLE}/fzf && \
    git clone https://github.com/airblade/vim-gitgutter ${VIM_BUNDLE}/vim-gitgutter && \
    git clone https://github.com/rafi/awesome-vim-colorschemes.git ${VIM_BUNDLE}/colorschemes && \
    git clone https://github.com/sheerun/vim-polyglot.git ${VIM_BUNDLE}/vim-polyglot && \
    git clone https://github.com/tpope/vim-fugitive.git ${VIM_BUNDLE}/vim-fugitive && \
    git clone https://github.com/tmhedberg/simpylfold ${VIM_BUNDLE}/simpylfold

COPY .vimrc ${HOME}
COPY .basrc /tmp/.bashrc
RUN cat /tmp/.bashrc >> ${HOME}/.bashrc

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf && ${HOME}/.fzf/install --key-bindings --completion --update-rc

ENTRYPOINT [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
