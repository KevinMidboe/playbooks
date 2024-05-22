# SSH

Running main task triggers sub tasks:
 - sshd_config
 - ssh_config
 - create_users
 - keys

Variable `ssh_keys_users` is used to:
 1. create unix user
 2. create /etc/ssh/keys/{user}/authorized_keys file
 3. populate keys file with any keys matching user

## Running sub tasks

It may be required to run some of these individually so the following plays exists:
 - ssh_config
 - ssh_keys
 - sshd_config

These sub tasks hit the same main ssh task, but with variables set to not trigger other ssh operations. This requires some attention when expanding ssh tasks.
