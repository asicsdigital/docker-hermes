FROM wata727/tflint AS tflint

FROM hermes:latest
COPY --from=tflint /usr/local/bin/tflint /bin/tflint
COPY scripts/get-consul-htpasswd /bin/get-consul-htpasswd
COPY scripts/get-consul-http-auth /bin/get-consul-http-auth
WORKDIR /root
ENTRYPOINT ["/bin/sh"]
