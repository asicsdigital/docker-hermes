FROM asicsdigital/dudewheresmy AS dudewheresmy

# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer:0.1.3 AS installer
ARG CONSUL_VERSION='1.4.0'
ARG VAULT_VERSION='1.0.2'
RUN /install-hashicorp-tool "vault" "$VAULT_VERSION"
RUN /install-hashicorp-tool "consul" "$CONSUL_VERSION"

FROM circleci/node
RUN sudo mkdir -p /opt/hermes/bin
COPY --from=dudewheresmy /usr/bin/dudewheresmy /opt/hermes/bin/dudewheresmy
COPY --from=installer /software/vault /opt/hermes/bin/vault
COPY --from=installer /software/consul /opt/hermes/bin/consul
COPY ../1.X/scripts/* /opt/hermes/bin/
RUN /opt/hermes/bin/install-hermes-deps
RUN curl -fsSL https://goss.rocks/install | GOSS_VER=v0.3.6 GOSS_DST=/opt/hermes/bin sh
WORKDIR /root
ENV PATH="/opt/hermes/bin:${PATH}"
ADD tests /tests
ENTRYPOINT ["/bin/bash"]
