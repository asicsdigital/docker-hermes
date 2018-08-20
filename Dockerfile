FROM golang:1.10 AS dudewheresmy
RUN CGO_ENABLED=0 GOOS=linux go get -v github.com/asicsdigital/dudewheresmy

# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer AS installer
ARG CONSUL_VERSION='1.2.2'
ARG VAULT_VERSION='0.10.4'
ARG TF_VERSION='0.11.8'
RUN /install_hashicorp_tool "terraform" "$TF_VERSION"
RUN /install_hashicorp_tool "vault" "$VAULT_VERSION"
RUN /install_hashicorp_tool "consul" "$CONSUL_VERSION"

FROM wata727/tflint AS tflint

# Now copy the binary over into a smaller base image
FROM alpine:latest
RUN apk add --update --no-cache git bash openssh curl jq
COPY --from=dudewheresmy /go/bin/dudewheresmy /bin/dudewheresmy
COPY --from=tflint /usr/local/bin/tflint /bin/tflint
COPY --from=installer /bin/terraform /bin/terraform
COPY --from=installer /bin/vault /bin/vault
COPY --from=installer /bin/consul /bin/consul
COPY scripts/set-vault-token /bin/set-vault-token
COPY scripts/get-consul-htpasswd /bin/get-consul-htpasswd
COPY scripts/get-consul-http-auth /bin/get-consul-http-auth
WORKDIR /root
ENTRYPOINT ["/bin/sh"]
