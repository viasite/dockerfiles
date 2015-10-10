# teamcity-site
Ubuntu 14.04 with php, drush, mysql for drupal testing

mysql root password: `teamcity`

Run command:
```
docker run --name=teamcity-site \
-v /path/to/dupal/root:/var/www \
-e SERVICE_NAME=site.domain \
popstas/teamcity-site
```


On start docker checks that `sql.gz` exists in drupal root, detects target database by drush sql-connect and imports it.
After that it runs drush runserver on site.domain

In my infrastructure `SERVICE_NAME` also used by consul, so container available by site.domain in private network.
