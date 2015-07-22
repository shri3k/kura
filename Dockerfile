FROM ubuntu
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update \
	&& apt-get install -y wget \
	python \
	build-essential

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 0.12.7
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash \
	&& source $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION \ 
	&& nvm use $NODE_VERSION \
	&& npm i -g nodemon 

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
WORKDIR "/home"
EXPOSE 3000

CMD DEBUG=kura:server npm run start-dev
