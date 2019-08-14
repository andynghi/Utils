=== apache:
sudo apachectl restart

=== brew command:
brew switch

-- remove old versions
brew cleanup

brew info postgresql
brew switch postgresql <TAB>
brew which postgresql

brew search postgresql

brew untap homebrew/versions
brew tap homebrew/versions

brew unlink nginx
brew link nginx-full

To uninstall something installed by homebrew:
brew uninstall memcached


=== RabbitMQ install
brew install rabbitmq

rabbitmq-plugins enable

Logs: /usr/local/var/log/rabbitmq
Config: /usr/local/etc/rabbitmq
 /usr/local/etc/rabbitmq/rabbitmq-env.conf


=== Nginx
http://learnaholic.me/2012/10/10/installing-nginx-in-mac-os-x-mountain-lion/
log files:
tail -f /usr/local/Cellar/nginx/1.4.4/logs/bob.error.log


=== linux commands
-- largest folders
du -k -I Library ~/* | awk '$1 > 500000' | sort -nr

-- total folder size
du -ch
du -ch | grep total




launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist


To have launchd start memcached at login:
    ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
Then to load memcached now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
Or, if you don't want/need launchctl, you can just run:
    /usr/local/opt/memcached/bin/memcached




To add memcached to launchd again:
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist



/etc/init.d/memcached restart


launchctl list | grep memcached



sudo /etc/init.d/php5-fpm restart


check mq lists:
rabbitmqctl list_queues


-- copy data over remote servers
scp -i ~/.ssh/id_rsa -P 57557 nghi.nguyen@server.com:~/gld.sql  gld.sql
scp -i ~/.ssh/id_rsa -r ~/.ssh nghinguyen@10.103.1.2:~/

time scp -Cr nghinguyen@10.103.1.2:~/tmp /Users/macpro/comp/src/git

grep -Eo "CREATE TABLE [a-z0-9_\`]+" /home/onadj/bob_anon_MY.sql | grep -Eo "[a-z0-9_\`]+"
locate bob_anon_MY.sql | xargs ls -lah
grep sitemap_xml bob_anon_MY.sql
grep -i 'CREATE TABLE' bob_anon_MY.sql  | wc -l

grep -i vhost vendor/queue/configs/broker.ini

-- empty files
for i in `find ./ -name "*.log" -type f`; do > $i; done


=== svn
/home/nghinguyen/.subversion/servers

https://svn.atlassian.com/Confluence ConfluenceAsGit
https://www.atlassian.com/git/migration#!migration-convert
git svn clone --trunk=/ --authors-file=authors.txt https://svnserver.com/svn/ABC/trunk/bin ABCTrunkBinAsGit



=== PHP
brew info php54
brew options php55


export PATH="$(brew --prefix php54)/bin:$PATH"


https://github.com/josegonzalez/homebrew-php


brew install php54-igbinary
brew install php54-



reload php:
ln -sfv /usr/local/opt/php54/*.plist ~/Library/LaunchAgents
launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php54.plist

-- PHP Config debug
http://techmaster.vn/2013/07/debug-php-fpm-tren-nginx-qua-ide-netbeans-va-phpstorm/
http://blog.jetbrains.com/webide/2011/02/zero-configuration-debugging-with-xdebug-and-phpstorm-2-0/
http://www.xdebug.org/docs/remote#browser_session

Debugging script using xDebug/PhpStorm
$ sudo -u www-data XDEBUG_CONFIG="idekey=PHPSTORM" PHP_IDE_CONFIG="serverName=bob.<username>.lzd.co" php -d memory_limit=1G -d xdebug.remote_host=`echo $SSH_CLIENT | cut -d "=" -f 2 | awk '{print $1}'` script.php
or
PHP_IDE_CONFIG="serverName=bob.<USERNAME>.lzd.co" php -d memory_limit=1G -d xdebug.remote_autostart=1 -d xdebug.remote_host=<YOUR_IP> script.php

Ex:
PHP_IDE_CONFIG="serverName=bob.trunk.local" php -d memory_limit=-1 -d xdebug.remote_autostart=1 -d xdebug.remote_host=127.0.0.1

-- zend framework
zf configure db-adapter 'adapter=PDO_SQLITE&dbname=APPLICATION_PATH "/../data/db/guestbook.db"' production


-- PHP code
$date = date('m/d/Y h:i:s a', time());
$date = new Zend_Date(date('Y-m-d H:i:s'));


=== svn commanline:
Branch a new ticket:
svn copy https://svnserver.com/svn/ABC/trunk https://svnserver.com/svn/ABC/branches/ABC-10885 -m "Creata new branch to develop ticket ABC-10885"
svn switch https://svnserver.com/svn/ABC/branches/ABC-10885
svn switch https://svnserver.com/svn/ABC/trunk

svn ls https://svnserver.com/svn/
svn command lines and tests.
	http://svnbook.red-bean.com/en/1.6/svn.branchmerge.basicmerging.html

# clear unversion files
svn status | grep '^?' | awk '{print $2}' | xargs rm -rf


svn commit button.c -m "Fixed a typo in button.c."
svn list http://svn.example.com/svn/repo/some/project
svn status stuff/fish.c
svn status -v
svn status -uv
svn info
svn diff > patchfile
svn diff -r 3 rules.txt
svn diff -r 2:3 rules.txt

svn diff -c 3 rules.txt (compare 3 and 4)
svn log -r 5:19
svn log -r 8
svn log -r 8 -v

svn log -l 5
svn log -l2 ^/.  (show log 2 revision when we are at children folders)

# See specific revision
svn log -v -r 483706 https://svnserver.com/svn
svn info --revision r481254

merge branch to trunk: svn merge --reintegrate https://svnserver.com/svn/ABC/branches/ABC-xxx

svn log -v -r480316 https://svnserver.com/svn/ABC/trunk
svn diff -c 480316 https://svnserver.com/svn/ABC/trunk

view file content
svn cat -r 2 rules.txt

view file content tabular format (line by line revision)
svn annotate rules.txt
svn annotate rules.txt@BASE (don't show unversion changes)

 svn blame rules.txt -r 2


 -- svn merge specific revision
 svn merge -c 100 -c 105 -c 115 http://..../branches/mybranch .

-- If you want to merge only the part of revision 100 that affects file.cpp:
cd trunk/path/to/file.cpp
svn merge -c 100 https://svnserver.com/svn/ABC/trunk/tools/deploy/deploy.mk tools/deploy/deploy.mk

/Users/macpro/comp/src/trunk/

# Checkout the trunk from r1729.
$ svn checkout http://svn.example.com/svn/repo/trunk@1729 trunk-1729
…
# Checkout the current trunk as it looked in r1729.
$ svn checkout http://svn.example.com/svn/repo/trunk -r 1729 trunk-1729
…


$ svn diff -r BASE:HEAD foo.c
# compares the unmodified version of foo.c


svn log -r {2006-11-20}:{2006-11-29}

-- write changes to file and attach to ticket
svn diff -r 341:HEAD ^/calc/trunk > my-patch-file


-- SVN checkout branch:
cp -R trunk/ ABC-9658/
cd ABC-9658
svn switch https://svnserver.com/svn/ABC/branches/ABC-9658
svn revert . --recursive
svn update (optional)
svn status | grep ^\? | cut -c9- | xargs -d \\n rm -r  (optional)


cd <conflict folder>
svn revert . --recursive

svn merge https://svnserver.com/svn/ABC/trunk

=== GIT command line
-- commit counts by person
git shortlog -s -n --all --no-merges


-- checkout force
git checkout -f WS-415

-- create branch
https://www.atlassian.com/git/workflows#!workflow-feature-branch
git checkout -b WS-496 master
git push origin WS-496
git pull --rebase origin WS-496

-- create a branch from a commit
git checkout -b postgresql-8.4.4 fa992c6a82eebdc4cc36a0c0d2837f4c02f3f422
$ brew install postgresql

-- delete a branch
$ git checkout master
$ git branch -d postgresql-8.4.4


-- pull
git stash
git pull --rebase origin WS-415
git stash apply

http://git-scm.com/docs/gittutorial
http://mislav.uniqpath.com/2013/02/merge-vs-rebase/

git status | cut -d ' ' -f 2....
git log --graph --oneline --all

-- revert local commits and history
git reset --hard origin/master

-- revert code only. Keep history
git revert

-- delete branch and recreate it
git branch -D master
git checkout origin/master -b master

-- show current status like svn
git status -sb

git stash
git pull
git stash pop

git checkout --theirs -- config.php



https://bitbucket.org/compweb/comp/compare/master..WS-587#diff
https://bitbucket.org/compweb/comp/branch/WS-587#diff

View file:
https://bitbucket.org/compweb/comp/src/0243851fde3caea0b4d088bbee58ef477fedcd1f/alice/local/Alice/Module/Tracking/Model/Provider/GoogleTagManager/Aggregator.php?at=master
https://bitbucket.org/compweb/comp/branch/WS-860#chg-alice/local/Alice/Controller/IndexController.php


-- check history
git log -S"cua c" --all
git log -S'8.4.4' -- Library/Formula/postgresql.rb

git log -S"getCustomerOrdersTimeLimit" --all

-- rebase master to branch
git pull --rebase origin master

-- get one file from other branch
git checkout WS-415 -- abc/def/Aggregator.php

-- git revert last commit
git reset --hard 'HEAD^'

-- git revert to a commit
git reset --hard <commithash>





=== enable cli debug
export XDEBUG_CONFIG="idekey=PHPSTORM"



=== To make phpunit works
edit ~/.zf.ini
add this line: php.include_path = "/usr/local/Cellar/phpunit/3.7.28/"
(pear config-show)
brew info phpunit


=== XDEBUG params
XDEBUG_SESSION_START=PHPSTORM



=== MySQL
-- drop all tables
mysql -Nse 'show tables' nghinguyen_bob_my | while read table; do mysql -e "drop table $table" nghinguyen_bob_my; done

MYSQL="mysql -D nghinguyen_bob_my"
$MYSQL -BNe "show tables" | awk '{print "set foreign_key_checks=0; drop table `" $1 "`;"}' | $MYSQL
unset MYSQL


-- install
create configure file /etc/my.cnf
sample file: /usr/local/mysql/support-files/

-- MySQL commands
Optimize a database:
All Databases:
$ sudo mysqlcheck -o --all-databases -u root -p
Single Database:
$ sudo mysqlcheck -o db_schema_name -u root -p


Show all users in the mysql database:
mysql> SELECT * FROM mysql.user;

Delete a null user:
mysql> DELETE FROM mysql.user WHERE user = ' ';

Delete all users who are not root:
mysql> DELETE FROM mysql.user WHERE NOT (host="localhost" AND user="root");

Change root user to a less-guessable name (for security):
mysql> UPDATE mysql.user SET user="mydbadmin" WHERE user="root";

Create a new DBA:
mysql> GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' IDENTIFIED BY 'mypass' WITH GRANT OPTION;

Add a new user with specific privileges on a specific database:
mysql> GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON mydatabase.* TO 'username'@'localhost' IDENTIFIED BY 'mypass';

Add a new DBA with all privileges to a specific database:
mysql> GRANT ALL PRIVILEGES ON mydatabase.* TO 'username'@'localhost' IDENTIFIED BY 'mypass' WITH GRANT OPTION;

Change a user or DBA password:
mysql> UPDATE mysql.user SET password=oldpass("newpass") WHERE User='username';

Delete a user or DBA from the database:
mysql> DELETE FROM mysql.user WHERE user="username";
Simple database manipulation:
Show all databases:
mysql> SHOW DATABASES;

Create a database:
mysql> CREATE DATABASE mydatabase;

Use a specific database:
mysql> USE mydatabase;

Delete a database:
mysql> DROP DATABASE mydatabase;

Optimize a database:
All Databases:
$ sudo mysqlcheck -o --all-databases -u root -p
Single Database:
$ sudo mysqlcheck -o db_schema_name -u root -p

Rename a database from command line (not from within MySQL), there is purposely no space beween -p and mypass:

mysqldump -u dbauser -pmypass databasename > mybackup.sql

mysql -u dbauser -pmypass newdatabasename < mybackup.sql

Show the last 200 queries to your database with the sample table name "queries" and the sample field "query_id":

mysql> SELECT * FROM queries ORDER BY query_id DESC LIMIT 200;
Simple table manipulation:
Show all tables within a previously selected database
mysql> SHOW TABLES;




Simple backup options:
Backup all databases uncompressed from the command line (not from within MySQL):
backup: mysqldump -u root -pmypass --all-databases > alldatabases.sql

restore full: mysql -u username -pmypass < alldatabases.sql (no space in between -p and mypass)

restore single: mysql -u username -pmypass mydb < mydb.sql (no space in between -p and mypass)

Backup all databases compressed from the command line (not from within MySQL):
With bzip2: mysqldump --all-databases | bzip2 -c > databasebackup.sql.bz2 (use bunzip2 to uncompress)

With gzip: mysqldump --all-databases | gzip > databasebackup.sql.gz (use gunzip to uncompress)

Mini script to backup all databases and tables using gzip:
#!/bin/sh
date=`date -I`
mysqldump --all-databases | gzip > /var/backup/dbbackup-$date.sql.gz

Backup a specific database only:
mysqldump -u username -pmypass databasename > backupfile.sql

Backup database structure only:
mysqldump --no-data --databases databasename > structurebackup.sql


Backup a specific database and specific tables within that database only:
mysqldump --add-drop-table -u username -pmypass databasename table_1 table_2 > databasebackup.sql

The syntax for the command to issue is:
mysqldump -u [username] -p[password] [databasename] [table1 table2 ....] > backupfilename.sql

Backing up only the database structure of specific databases, not the actual data:
mysqldump --no-data --databases db1 db2 db3 > structurebackup.sql


=== Zend command line
php bob/cli/index.php --env=dev --module=default --controller=index --action=test



=== Test
Test Credit Cards (Staging & Sandbox Only)
Visa & Mastercard only.
CYBERSOURCE 3DS (Malaysia Only)
Name: Sandy Cruz
VISA: 4000 0000 0000 0002
MASTERCARD: 5200 0000 0000 0007
Espiry date: (03/15)
CVV: 737
Non 3DS Gateways (VN, PH, TH, ID)
VISA
4183580095106102
MASTERCARD
5125711101996107
Espiry date: (03/15)
Name: Sandy Cruz
CVC/CVV: 888


=== Regex
Regex to exclude almost useless lines when trace profiler:
^((?!(Zend|ZFDebug|autoload|Profiler|::/|__|_Db_|_Acl_|_Auth-|Bootstrap|->init|->_init|_AbstractObject|Configuration_|Dispatch|_Translate|Cache)).)*$

Ex: generateConfirmationKey


=== setting xhgui profider
  Profiling
  =========

  * For system wide random profiling, you can add the following directive in php.ini:

    auto_prepend_file=/usr/local/Cellar/php54-xhgui/ee00acb/external/header.php

  * If you prefer to configure profiling per virtual host:

    Using Apache:

    <VirtualHost *:80>
        php_admin_value auto_prepend_file "/usr/local/Cellar/php54-xhgui/ee00acb/external/header.php"
        DocumentRoot "/Users/markstory/Sites/awesome-thing/app/webroot/"
        ServerName site.localhost
    </VirtualHost>

    Using nginx:

    server {
        listen 80;
        server_name site.localhost;
        root /Users/markstory/Sites/awesome-thing/app/webroot/;
        fastcgi_param PHP_VALUE "auto_prepend_file=/usr/local/Cellar/php54-xhgui/ee00acb/external/header.php";
     }




To have launchd start mongodb at login:
    ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents
Then to load mongodb now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
Or, if you don't want/need launchctl, you can just run:
    mongod --config /usr/local/etc/mongod.conf


/usr/local/etc/php/5.4/conf.d/ext-mongo.ini


=== Python
-- format array
print('\n'.join('{}: {}'.format(*k) for k in enumerate(ne_chunks)))
for k in ne_chunks: print k.pprint()

