<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

return array(
        $DB_PASSWORD = getenv("MYSQL_PASSWORD")

        'components' => array(
                'db' => array(
                        'connectionString' => 'mysql:host=mysql:3306;dbname=limesurvey;',
                        'emulatePrepare' => true,
                        'username' => 'limesurvey',
                        'password' => '$DB_PASSWORD', 
                        'charset' => 'utf8mb4',
                        'tablePrefix' => 'lime_',
                ),

                 'session' => array (
                        'sessionName'=>'LS-XHXHWGILSPHGRVGG',
                        // Uncomment the following lines if you need table-based sessions.
                        // Note: Table-based sessions are currently not supported on MSSQL server.
                        // 'class' => 'application.core.web.DbHttpSession',
                        // 'connectionID' => 'db',
                        // 'sessionTableName' => '{{sessions}}',
                 ),

                'urlManager' => array(
                        'urlFormat' => 'path',
                        'rules' => array(
                                // You can add your own rules here
                        ),
                        'showScriptName' => true,
                ),

        ),
        // For security issue : it's better to set runtimePath out of web access
        // Directory must be readable and writable by the webuser
        // 'runtimePath'=>'/var/limesurvey/runtime/'
        // Use the following config variable to set modified optional settings copied from config-defaults.php
        'config'=>array(
        // debug: Set this to 1 if you are looking for errors. If you still get no errors after enabling this
        // then please check your error-logs - either in your hosting provider admin panel or in some /logs directory
        // on your webspace.
        // LimeSurvey developers: Set this to 2 to additionally display STRICT PHP error messages and get full access to standard templates
                'debug'=>0,
                'debugsql'=>0, // Set this to 1 to enanble sql logging, only active when debug = 2
                // Mysql database engine (INNODB|MYISAM):
                 'mysqlEngine' => 'MYISAM'

,               // Update default LimeSurvey config here
        )
);
