FROM wata727/tflint AS tflint

FROM golang:1.11 AS terraform-provider-pingdom
RUN go get -v -d github.com/russellcardullo/terraform-provider-pingdom
WORKDIR /go/src/github.com/russellcardullo/terraform-provider-pingdom
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer:0.1.3 AS installer
ARG TF_VERSION='0.11.8'
RUN /install-hashicorp-tool "terraform" "$TF_VERSION"

FROM asicsdigital/hermes:stable
COPY --from=tflint /usr/local/bin/tflint /opt/hermes/bin/tflint
COPY --from=installer /software/terraform /opt/hermes/bin/terraform
COPY --from=terraform-provider-pingdom /go/src/github.com/russellcardullo/terraform-provider-pingdom/app  /opt/hermes/bin/terraform-provider-pingdom
COPY scripts/* /opt/hermes/bin/
RUN mkdir -p /root/.terraform.d/plugins/linux_amd64
RUN ln -s /opt/hermes/bin/terraform-provider-pingdom /root/.terraform.d/plugins/linux_amd64/terraform-provider-pingdom
WORKDIR /root
ENTRYPOINT ["/bin/bash"]
