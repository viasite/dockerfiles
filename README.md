# dockerfiles

## ansible
Ubuntu 14.04 with ansible, ansible-lint, rolespec
```
docker build -t popstas/ansible ansible/Dockerfile
```

## squeeze
Debian squeeze for testing server scripts.
Contains apache2, nginx, bind9, percona, php, composer, drush, bats.