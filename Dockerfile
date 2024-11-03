FROM jupyter/minimal-notebook
LABEL maintainer="Litu Zou <litu.zou@cs.ox.ac.uk>"

ARG NB_USER=jovyan
ARG CLOJUPYTER_VERSION
ENV NOTEBOOK_PATH=$HOME/notebooks
ENV PORT=8888
ENV CLOJUPYTER_PATH=$HOME/clojupyter-$CLOJUPYTER_VERSION

USER root

# install JDK 8, make, and leiningen
RUN apt update \
	&& apt-get install -y curl openjdk-8-jdk make leiningen

# install curl
RUN curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh \
	&& chmod +x linux-install.sh \
	&& ./linux-install.sh

USER $NB_USER
RUN	mkdir -p $NOTEBOOK_PATH \
	&& git clone https://github.com/clojupyter/clojupyter $CLOJUPYTER_PATH

# build clojupyter
WORKDIR $CLOJUPYTER_PATH
RUN git checkout $CLOJUPYTER_VERSION \
	&& make install

WORKDIR $NOTEBOOK_PATH
EXPOSE $PORT
VOLUME $NOTEBOOK_PATH
CMD ["jupyter", "lab", "--log-level=ERROR"]
