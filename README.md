# playbooks

Usage:
```
ansible-playbook -i schleppe -l HOST_NAME plays/NAME_OF_PLAY.yml
```

Running locally on host:
```
anisble-playbook --connection=local --inventory HOST_NAME, --extra-vars "@host_vars/HOST_NAME.yml" plays/NAME_OF_PLAY.yml
```

## Dependencies

Some of the plays are setup to use hashicorp vault instance with secrets defined at a given expected path. View [vault-setup](#vault-setup) below. 

```
VAULT_ADDR=http://IP_ADDRESS:PORT
VAULT_PREFIX=ROOT_FOLDER_NAME_OR_PATH
VAULT_TOKEN=TOKEN_WITH_PERMISSION
```

### SSH

To prevent comitting public keys they are all stored in vault. If environment variables above are set, the keys are automatically fetched.
