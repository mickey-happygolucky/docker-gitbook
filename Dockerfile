FROM node:11.9-slim
LABEL maintainer="HeRoMo"

# install apt packages
RUN apt-get update -y && \
    apt-get install -y \
      locales \
      bzip2 \
      calibre \
      fonts-ricty-diminished && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN yarn global add gitbook-cli svgexport

COPY ./start.sh /usr/bin/
RUN chmod 755 /usr/bin/start.sh

RUN mkdir -p /opt/gitbook
COPY ./book.json /opt/gitbook

RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

ENTRYPOINT ["start.sh"]
