FROM golang:1.10 AS dudewheresmy
RUN CGO_ENABLED=0 GOOS=linux go get -v github.com/asicsdigital/dudewheresmy

# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer:0.1.3 AS installer
ARG CONSUL_VERSION='1.2.2'
ARG VAULT_VERSION='0.10.4'
RUN /install-hashicorp-tool "vault" "$VAULT_VERSION"
RUN /install-hashicorp-tool "consul" "$CONSUL_VERSION"

FROM alpine:3.8
RUN mkdir -p /opt/hermes/bin
COPY --from=dudewheresmy /go/bin/dudewheresmy /opt/hermes/bin/dudewheresmy
COPY --from=installer /software/vault /opt/hermes/bin/vault
COPY --from=installer /software/consul /opt/hermes/bin/consul
COPY scripts/* /opt/hermes/bin/
RUN apk add --update --no-cache git bash openssh curl jq # factor this out into a script
WORKDIR /root
ENV PATH="/opt/hermes/bin:${PATH}"
ENTRYPOINT ["/bin/sh"]
