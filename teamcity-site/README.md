# teamcity-site
Ubuntu 14.04 with php, drush, mysql for drupal testing

mysql database: `test`  
mysql root password: `teamcity`  
root path: `/var/www`  

## Environment variables:  
`SERVICE_NAME` - service name for consul and registrator  
`SITE_DOMAIN` - bind address for drush runserver. Default set to `SERVICE_NAME`  
`MYSQL_RAM_SIZE` - size of ramdisk, default set to `0` (no ramdisk)  
`MYSQL_PASSWORD` - mysql root password, default set to `teamcity`  
`MYSQL_DATABASE` - mysql database, default set to `test`  

## Run command:
```
docker run --name=teamcity-site \
-v /path/to/dupal/root:/var/www \
-e SERVICE_NAME=site.domain \
popstas/teamcity-site
```

## Run with mysql in ram:
```
docker run --privileged
--name=teamcity-site \
-v /path/to/dupal/root:/var/www \
-e SERVICE_NAME=site.domain \
-e MYSQL_RAM_SIZE=256 \
popstas/teamcity-site
```

`--privileged` need for tmpfs mount.  

## On start docker:  
- add settings.local.php (and works only with [patched settings.php](https://gist.github.com/jeffam/1a616d43b0913555b9ef))  
- checks that `sql.gz` exists in drupal root, and imports it do database `test`  
- runs drush runserver on site.domain  

In my infrastructure `SERVICE_NAME` also used by consul, so container available by site.domain in private network.
