# dockerfiles

## ansible
Ubuntu 14.04 with ansible, ansible-lint, rolespec
```
docker build -t popstas/ansible ansible/Dockerfile
```

## squeeze
Debian squeeze for testing server scripts.
Contains apache2, nginx, bind9, percona, php, composer, drush, bats.
```
docker build -t popstas/squeeze squeeze/Dockerfile
```
Rebuild (for me):
```
docker rm squeeze; docker build -t popstas/squeeze squeeze && docker run -it --name squeeze popstas/squeeze bash && docker push popstas/squeeze
```

## ubuntu-14.04
Clean Ubuntu 14.04 with openssh-server for ansible testing.


## teamcity-site
Ubuntu 14.04 with php, drush, mysql for drupal testing
mysql root password: `teamcity`