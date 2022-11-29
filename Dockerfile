# how to build
# (from anki-hyper-tts directory)
# docker build  --build-arg UNAME=$USER --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t lucwastiaux/anki-addon-svelte-build:latest -f ../anki-addon-svelte-build/Dockerfile .
# inspect/debug:
# docker run -it --rm --mount type=bind,source="$(pwd)"/web,target=/workspace/web lucwastiaux/anki-addon-svelte-build:latest /bin/bash
#
# build assets:
# (from anki-hyper-tts directory)
# docker run -it --rm --mount type=bind,source="$(pwd)"/web,target=/workspace/web --mount type=bind,source="$(pwd)"/web_build_output,target=/workspace/web_build_output lucwastiaux/anki-addon-svelte-build:latest sh -c "cp /workspace/web/* /workspace/web_build/ && cd /workspace/web_build/ && yarn build"
# debug:
# look inside image:
# docker run -it --rm lucwastiaux/anki-addon-svelte-build:latest /bin/bash

FROM node:19

ARG UNAME=node_user
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

RUN mkdir /workspace && chown $UNAME:$UNAME /workspace
COPY web /workspace/web_build
RUN chown -R $UNAME:$UNAME /workspace/web_build
USER $UNAME
RUN cd /workspace/web_build && npm install

