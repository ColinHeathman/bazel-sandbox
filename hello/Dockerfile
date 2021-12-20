FROM library/alpine:latest

RUN apk add --no-cache python3 py3-pip jq

RUN pip3 install yq

COPY data.yaml data.yaml
COPY filter.jq filter.jq
COPY script.sh script.sh

ENTRYPOINT [ "/bin/ash" ]
CMD [ "script.sh" ]
