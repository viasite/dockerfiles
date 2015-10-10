# teamcity-site
Ubuntu 14.04 with php, drush, mysql for drupal testing

mysql database: `test`  
mysql root password: `teamcity`  
root path: `/var/www`  

Run command:
```
docker run --name=teamcity-site \
-v /path/to/dupal/root:/var/www \
-e SERVICE_NAME=site.domain \
popstas/teamcity-site
```


On start docker:  
- add settings.local.php (and works only with [patched settings.php](https://gist.github.com/jeffam/1a616d43b0913555b9ef))  
- checks that `sql.gz` exists in drupal root, and imports it do database `test`  
- runs drush runserver on site.domain  

In my infrastructure `SERVICE_NAME` also used by consul, so container available by site.domain in private network.
