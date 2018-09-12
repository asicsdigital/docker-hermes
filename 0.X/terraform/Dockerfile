FROM wata727/tflint AS tflint

# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer:0.1.3 AS installer
ARG TF_VERSION='0.11.8'
RUN /install-hashicorp-tool "terraform" "$TF_VERSION"

FROM hermes:latest
COPY --from=tflint /usr/local/bin/tflint /opt/hermes/bin/tflint
COPY --from=installer /software/terraform /opt/hermes/bin/terraform
COPY scripts/* /opt/hermes/bin/
WORKDIR /root
ENTRYPOINT ["/bin/sh"]
