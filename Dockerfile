FROM alpine:3.7
LABEL maintainer=tyler@berryac.com

ADD wait.sh /wait.sh

ENTRYPOINT ["/wait.sh"]
