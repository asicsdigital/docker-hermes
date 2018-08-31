# docker-hermes
Docker image for running automated deployments from Terraform.

This Image is designed to make Terraform runs out of CircleCI (or similar) an easier prospect. It includes the Terraform, Vault, and Consul binaries, as well as a number of helper scripts to auth to vault, and extract secrets for use by Terraform.

#### Helpers

We've bundled a number of helpers.

* `set-vault-token` - This helper authenticated to a vault server defined by `VAULT_ADDR` and places the token in `$HOME/.vault-token`
* `get-consul-http-auth` -   queries Vault under a prefix call `secret/consul` and outputs the value to an auto tfvars file, _consul_http_auth.auto.tfvars, and _consul_http_addr.auto.tfvars in the working directory the helper is called.  
* `get-consul-htpasswd` - Deprecated helper that queries Vault under a prefix call `secret/consul_htpasswd` and outputs the value to an auto tfvars file, _consul_htpasswd.auto.tfvars,  in the working directory the helper is called.  
* `get-iam-auth` - Helper for outputting $HOME/.aws/credentials for use by the terraform aws provider. In Addition this stores the lease_id in `$HOME/.env` for use later by `lease-revoke`
* `lease-revoke` -  Helper for revoking vault leases sourced in from .env files


#### Environment Variables

* `VAULT_ADDR` - Address of the Vault server expressed as a URL and port, ex: `VAULT_ADDR="https://vault.example.com"``
* `VAULT_PAYLOAD` - AppRole payload to auth to vault  `VAULT_PAYLOAD='{"role_id":"<ROLE_ID>","secret_id":"<SECRET_ID>"}'``
* `VAULT_AWS_SECRET_ENGINE_ROLE` - Role name to pass to the AWS Secret Engine
