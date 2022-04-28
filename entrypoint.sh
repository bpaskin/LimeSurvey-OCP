#!/bin/bash
# This will setup the LimeSurvey DB and Admin userid/pw

# use MyISAM as the MySQL DB type
export DBENGINE=MyISAM

# check if the DB already exists, if not create
/usr/local/bin/php /var/www/html/application/commands/console.php updatedb

if [ $? -ne 0 ]; then
  /usr/local/bin/php /var/www/html/application/commands/console.php install "$ADMIN_USER" "$ADMIN_PASSWORD" "Admin User" "$ADMIN_EMAIL"
fi

# execute the apache server by executing the command passed to the script
exec "$@"
