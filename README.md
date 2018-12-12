# docker-hermes
Docker image for running automated deployments

This Image is designed to make CI runs out of CircleCI (or similar) an easier prospect. It includes the Terraform, Vault, and Consul binaries, as well as a number of helper scripts to auth to vault, and extract secrets for use by Terraform.

#### Helpers

We've bundled a number of helpers.

* `set-vault-token` - This helper authenticated to a vault server defined by `VAULT_ADDR` and places the token in `$HOME/.vault-token`
* `get-iam-auth` - Helper for outputting $HOME/.aws/credentials for use by the terraform aws provider. In Addition this stores the lease_id in `$HOME/.env` for use later by `lease-revoke`
* `lease-revoke` -  Helper for revoking vault leases sourced in from .env files

#### Environment Variables

* `VAULT_ADDR` - Address of the Vault server expressed as a URL and port, ex: `VAULT_ADDR="https://vault.example.com"``
* `VAULT_PAYLOAD` - AppRole payload to auth to vault  `VAULT_PAYLOAD='{"role_id":"<ROLE_ID>","secret_id":"<SECRET_ID>"}'``
* `VAULT_AWS_SECRET_ENGINE_ROLE` - Role name to pass to the AWS Secret Engine

#### Adding Tests

You can add tests by running `goss add <type> <thing>` and then adding that Yaml file to the tests directory, or updating the existing goss.yaml file if one exists. More informaiton about Goss tests can be found here: https://github.com/aelsabbahy/goss/blob/master/docs/manual.md#important-note-about-goss-file-format
