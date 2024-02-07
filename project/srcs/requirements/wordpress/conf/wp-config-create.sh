#!bin/sh

if [ ! -f "/var/www/wp-config.php" ]; then
cat << EOF > /var/www/wp-config.php 
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );

# WordPress will use the default collation aka comparison
define( 'DB_COLLATE', '' );

# WordPress will attempt to directly write files 
# to the filesystem without using the PHP FTP extension 
define('FS_METHOD','direct');

# sets the prefix for WordPress database tables
# tables will be named like wp_posts, wp_users, etc. 
\$table_prefix = 'wp_';

# debuf mode is off
define( 'WP_DEBUG', false );

# this code ensures that ABSPATH is always defined 
# to the correct absolute path of the WordPress installation directory.
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );

#including the main WordPress settings file (wp-settings.php) 
#into the PHP script.
require_once ABSPATH . 'wp-settings.php';
EOF
fi