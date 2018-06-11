FROM alpine:3.7

ADD wait.sh /wait.sh

ENTRYPOINT ["/wait.sh"]
