-- MySQL dump 10.13  Distrib 5.7.10, for Win64 (x86_64)
--
-- Host: localhost    Database: OMS
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_group`
--

DROP TABLE IF EXISTS `app_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_group`
--

LOCK TABLES `app_group` WRITE;
/*!40000 ALTER TABLE `app_group` DISABLE KEYS */;
INSERT INTO `app_group` VALUES (2,'CentOS'),(5,'Database'),(8,'IIS'),(7,'Nginx'),(6,'Redis'),(4,'Web'),(1,'Windows'),(3,'XenServer');
/*!40000 ALTER TABLE `app_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_host`
--

DROP TABLE IF EXISTS `app_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `ip` char(39) NOT NULL,
  `app` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `server_name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`),
  KEY `app_host_349117c7` (`server_name_id`),
  CONSTRAINT `app_host_server_name_id_2eb31f76_fk_app_server_id` FOREIGN KEY (`server_name_id`) REFERENCES `app_server` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_host`
--

LOCK TABLES `app_host` WRITE;
/*!40000 ALTER TABLE `app_host` DISABLE KEYS */;
INSERT INTO `app_host` VALUES (1,'OT-Master-41','192.168.22.41','请求转发、静态页面缓存、redis缓存',1,7),(2,'OT-SQL-44','192.168.22.44','MSSQL数据库，提供数据持久存储',1,8),(3,'OT-WEB-DNS-43','192.168.22.43','DNS服务器、IIS服务器',1,7),(4,'saltminion01-41.ewp.com','10.188.1.41','SaltStack被控测试机01',1,9),(5,'saltminion02-42','10.188.1.42','SaltStack被控测试机02',1,9),(6,'SaltMaster-40','10.188.1.40','SaltStack控制端（测试）',1,9);
/*!40000 ALTER TABLE `app_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_host_detail`
--

DROP TABLE IF EXISTS `app_host_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_host_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(20) NOT NULL,
  `productname` varchar(30) NOT NULL,
  `service_tag` varchar(80) NOT NULL,
  `cpu_model` varchar(50) NOT NULL,
  `cpu_nums` smallint(5) unsigned DEFAULT NULL,
  `cpu_groups` smallint(5) unsigned DEFAULT NULL,
  `mem` varchar(100) NOT NULL,
  `disk` varchar(300) NOT NULL,
  `hostname` varchar(30) NOT NULL,
  `ip` char(39) NOT NULL,
  `ip2` char(39) DEFAULT NULL,
  `os` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_host_detail_ip_61a5f87d_uniq` (`ip`),
  UNIQUE KEY `service_tag` (`service_tag`),
  UNIQUE KEY `app_host_detail_ip2_4b151fbe_uniq` (`ip2`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_host_detail`
--

LOCK TABLES `app_host_detail` WRITE;
/*!40000 ALTER TABLE `app_host_detail` DISABLE KEYS */;
INSERT INTO `app_host_detail` VALUES (1,'DELL','3650m3','34394','xeon E3500',4,2,'2048G','500G','hostname','10.188.1.40','10.188.1.100','centos 6.5'),(2,'','','','',NULL,NULL,'','','','192.168.22.20','','');
/*!40000 ALTER TABLE `app_host_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_host_group`
--

DROP TABLE IF EXISTS `app_host_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_host_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host_id` (`host_id`,`group_id`),
  KEY `app_host_group_group_id_799a8a52_fk_app_group_id` (`group_id`),
  CONSTRAINT `app_host_group_group_id_799a8a52_fk_app_group_id` FOREIGN KEY (`group_id`) REFERENCES `app_group` (`id`),
  CONSTRAINT `app_host_group_host_id_36c5ab8_fk_app_host_id` FOREIGN KEY (`host_id`) REFERENCES `app_host` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_host_group`
--

LOCK TABLES `app_host_group` WRITE;
/*!40000 ALTER TABLE `app_host_group` DISABLE KEYS */;
INSERT INTO `app_host_group` VALUES (25,1,2),(26,1,4),(27,1,6),(28,1,7),(29,2,1),(30,2,5),(32,3,1),(33,3,4),(31,3,8),(34,4,2),(35,5,1),(36,6,2);
/*!40000 ALTER TABLE `app_host_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_idc`
--

DROP TABLE IF EXISTS `app_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `type` varchar(10) NOT NULL,
  `ips` varchar(60) NOT NULL,
  `address` varchar(60) NOT NULL,
  `contact` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_idc`
--

LOCK TABLES `app_idc` WRITE;
/*!40000 ALTER TABLE `app_idc` DISABLE KEYS */;
INSERT INTO `app_idc` VALUES (1,'上海神舟机房','电信','123.45.67.89','上海市徐汇区','021-8364936'),(2,'北京府才机房','联通','62.2.104.73','北京市三里屯UY库','陈先生18920384034'),(3,'长沙渡口机房','电信','222.3.10.82','长沙市','17702130583');
/*!40000 ALTER TABLE `app_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_network`
--

DROP TABLE IF EXISTS `app_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `brand` varchar(30) NOT NULL,
  `model` varchar(30) NOT NULL,
  `info` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `idc_name_id` int(11) NOT NULL,
  `ip_in` char(39),
  `ip_out` char(39),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_in` (`ip_in`),
  UNIQUE KEY `ip_out` (`ip_out`),
  KEY `app_network_idc_name_id_2c7ab415_fk_app_idc_id` (`idc_name_id`),
  CONSTRAINT `app_network_idc_name_id_2c7ab415_fk_app_idc_id` FOREIGN KEY (`idc_name_id`) REFERENCES `app_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_network`
--

LOCK TABLES `app_network` WRITE;
/*!40000 ALTER TABLE `app_network` DISABLE KEYS */;
INSERT INTO `app_network` VALUES (1,'CS防火墙','CISCO','3010','出口路由器','https://222.3.10.82:8080/login.html',3,'10.188.1.1','222.3.10.82'),(2,'BJ防火墙','HUAWEI','520','出口路由器','https://62.2.104.73/login.php',2,'192.168.22.1','62.2.104.73');
/*!40000 ALTER TABLE `app_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_command`
--

DROP TABLE IF EXISTS `app_salt_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cmd` varchar(40) NOT NULL,
  `info` longtext NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmd` (`cmd`),
  KEY `app_salt_command_c9799665` (`module_id`),
  CONSTRAINT `app_salt_command_module_id_5294d5ae_fk_app_salt_module_id` FOREIGN KEY (`module_id`) REFERENCES `app_salt_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_command`
--

LOCK TABLES `app_salt_command` WRITE;
/*!40000 ALTER TABLE `app_salt_command` DISABLE KEYS */;
INSERT INTO `app_salt_command` VALUES (2,'test.ping','Used to make sure the minion is up and responding. Not an ICMP ping.\r\nReturns True.\r\nsalt \'*\' test.ping',1),(3,'cmd.run','salt.modules.cmdmod.run(cmd, cwd=None, stdin=None, runas=None, shell=\'/bin/sh\', python_shell=None, env=None, clean_env=False, template=None, rstrip=True, umask=None, output_loglevel=\'debug\', log_callback=None, timeout=None, reset_system_locale=True, ignore_retcode=False, saltenv=\'base\', use_vt=False, **kwargs)\r\n',3),(4,'service.available','Returns True if the specified service is available, otherwise returns False.',10),(5,'service.get_all','Return a list of all available services',10),(6,'service.reload','Refreshes config files by calling service reload. Does not perform a full restart.',10),(7,'service.restart','Restart the specified service',10),(8,'service.start','Start the specified service',10),(9,'service.status','Return the status for a service, returns the PID or an empty string if the service is running or not, pass a signature to use to find the service via ps',10),(10,'service.stop','Stop the specified service',10),(11,'grains.append','Append a value to a list in the grains config file. If the grain doesn\'t exist, the grain key is added and the value is appended to the new grain as a list item.',20),(12,'grains.delval','salt.modules.grains.delval(key, destructive=False)\r\nDelete a grain from the grains config file.',20),(13,'grains.filter_by','salt.modules.grains.filter_by(lookup_dict, grain=\'os_family\', merge=None, default=\'default\', base=None)\r\nLook up the given grain in a given dictionary for the current OS and return the result',20),(14,'grains.get','salt.modules.grains.get(key, default=\'\', delimiter=\':\')\r\nAttempt to retrieve the named value from grains, if the named value is not available return the passed default. The default return is an empty ',20),(15,'grains.has_value','salt.modules.grains.has_value(key)\r\nDetermine whether a named value exists in the grains dictionary.',20),(16,'grains.item','salt.modules.grains.item(*args, **kwargs)\r\nReturn one or more grains',20),(17,'grains.items','salt.modules.grains.items(sanitize=False)\r\nReturn all of the minion\'s grains',20),(18,'grains.ls','salt.modules.grains.ls()\r\nReturn a list of all available grains',20),(19,'grains.remove','salt.modules.grains.remove(key, val, delimiter=\':\')\r\nRemove a value from a list in the grains config file',20),(20,'grains.set','salt.modules.grains.set(key, val=\'\', force=False, destructive=False, delimiter=\':\')\r\nSet a key to an arbitrary value. It is used like setval but works with nested keys.',20),(21,'grains.setval','salt.modules.grains.setval(key, val, destructive=False)\r\nSet a grains value in the grains config file',20),(22,'grains.setvals','salt.modules.grains.setvals(grains, destructive=False)\r\nSet new grains values in the grains config file',20),(23,'network.active_tcp','salt.modules.network.active_tcp()\r\nReturn a dict containing information on all of the running TCP connections (currently linux and solaris only)',7),(24,'network.arp','salt.modules.network.arp()\r\nReturn the arp table from the minion',7),(25,'network.calc_net','salt.modules.network.calc_net(ip_addr, netmask=None)\r\nReturns the CIDR of a subnet based on an IP address (CIDR notation supported) and optional netmask.',7),(26,'network.connect','salt.modules.network.connect(host, port=None, **kwargs)\r\nTest connectivity to a host using a particular port from the minion.',7),(27,'network.default_rout','salt.modules.network.default_route(family=None)\r\nReturn default route(s) from routing table',7),(28,'network.dig','salt.modules.network.dig(host)\r\nPerforms a DNS lookup with dig',7),(29,'network.get_hostname','salt.modules.network.get_hostname()\r\nGet hostname',7),(30,'network.get_route','salt.modules.network.get_route(ip)\r\nReturn routing information for given destination ip',7),(31,'network.hw_addr','salt.modules.network.hw_addr(iface)\r\nReturn the hardware address (a.k.a. MAC address) for a given interface',7),(32,'network.hwaddr','salt.modules.network.hwaddr(iface)\r\nThis function is an alias of hw_addr.',7),(33,'network.in_subnet','salt.modules.network.in_subnet(cidr)\r\nReturns True if host is within specified subnet, otherwise False.',7),(34,'network.interface','salt.modules.network.interface(iface)\r\nReturn the inet address for a given interface',7),(35,'network.interface_ip','salt.modules.network.interface_ip(iface)\r\nReturn the inet address for a given interface',7),(36,'network.interfaces','salt.modules.network.interfaces()\r\nReturn a dictionary of information about all the interfaces on the minion',7),(37,'network.ip_addrs','salt.modules.network.ip_addrs(interface=None, include_loopback=False, cidr=None)\r\nReturns a list of IPv4 addresses assigned to the host. 127.0.0.1 is ignored',7),(38,'network.is_loopback','salt.modules.network.is_loopback(ip_addr)\r\nCheck if the given IP address is a loopback address',7),(39,'network.mod_hostname','salt.modules.network.mod_hostname(hostname)\r\nModify hostname',7),(40,'network.is_private','salt.modules.network.is_private(ip_addr)\r\nCheck if the given IP address is a private address',7),(41,'network.netstat','salt.modules.network.netstat()\r\nReturn information on open ports and states',7),(42,'network.ping','salt.modules.network.ping(host, timeout=False, return_boolean=False)\r\nPerforms an ICMP ping to a host',7),(43,'network.reverse_ip','salt.modules.network.reverse_ip(ip_addr)\r\nReturns the reversed IP address',7),(44,'network.routes','salt.modules.network.routes(family=None)\r\nReturn currently configured routes from routing table',7),(45,'network.subnets','salt.modules.network.subnets(interfaces=None)\r\nReturns a list of IPv4 subnets to which the host belongs',7),(46,'network.traceroute','salt.modules.network.traceroute(host)\r\nPerforms a traceroute to a 3rd party host',7),(47,'network.wol','salt.modules.network.wol(mac, bcast=\'255.255.255.255\', destport=9)\r\nSend Wake On Lan packet to a host',7),(48,'cp.cache_dir','salt.modules.cp.cache_dir(path, saltenv=\'base\', include_empty=False, include_pat=None, exclude_pat=None, env=None)\r\nDownload and cache everything under a directory from the master',2),(49,'cp.cache_file','salt.modules.cp.cache_file(path, saltenv=\'base\', env=None)\r\nUsed to cache a single file on the salt-minion Returns the location of the new cached file on the minion',2),(50,'cp.cache_files','salt.modules.cp.cache_files(paths, saltenv=\'base\', env=None)\r\nUsed to gather many files from the master, the gathered files will be saved in the minion cachedir reflective to the paths retrieved from the master.',2),(51,'cp.cache_local_file','salt.modules.cp.cache_local_file(path)\r\nCache a local file on the minion in the localfiles cache',2),(52,'cp.cache_master','salt.modules.cp.cache_master(saltenv=\'base\', env=None)\r\nRetrieve all of the files on the master and cache them locally',2),(53,'cp.get_dir','salt.modules.cp.get_dir(path, dest, saltenv=\'base\', template=None, gzip=None, env=None, **kwargs)\r\nUsed to recursively copy a directory from the salt master',2),(54,'cp.get_file','salt.modules.cp.get_file(path, dest, saltenv=\'base\', makedirs=False, template=None, gzip=None, env=None, **kwargs)\r\nUsed to get a single file from the salt master',2),(55,'cp.get_file_str','salt.modules.cp.get_file_str(path, saltenv=\'base\', env=None)\r\nReturn the contents of a file from a URL',2),(56,'cp.get_template','salt.modules.cp.get_template(path, dest, template=\'jinja\', saltenv=\'base\', env=None, makedirs=False, **kwargs)\r\nRender a file as a template before setting it down. Warning, order is not the same as in fileclient.cp for non breaking old API.',2),(57,'cp.get_url','salt.modules.cp.get_url(path, dest, saltenv=\'base\', env=None)\r\nUsed to get a single file from a URL.',2),(58,'cp.hash_file','salt.modules.cp.hash_file(path, saltenv=\'base\', env=None)\r\nReturn the hash of a file, to get the hash of a file on the salt master file server prepend the path with salt://<file on server> otherwise, prepend the file with / for a local file.',2),(59,'cp.is_cached','salt.modules.cp.is_cached(path, saltenv=\'base\', env=None)\r\nReturn a boolean if the given path on the master has been cached on the minion',2),(60,'cp.list_master','alt.modules.cp.list_master(saltenv=\'base\', prefix=\'\', env=None)\r\nList all of the files stored on the master',2),(61,'cp.list_master_dirs','salt.modules.cp.list_master_dirs(saltenv=\'base\', prefix=\'\', env=None)\r\nList all of the directories stored on the master',2),(62,'cp.list_master_symlinks','salt.modules.cp.list_master_symlinks(saltenv=\'base\', prefix=\'\', env=None)\r\nList all of the symlinks stored on the master',2),(63,'cp.list_minion','salt.modules.cp.list_minion(saltenv=\'base\', env=None)\r\nList all of the files cached on the minion',2),(64,'cp.list_states','salt.modules.cp.list_states(saltenv=\'base\', env=None)\r\nList all of the available state modules in an environment',2),(65,'cp.push','salt.modules.cp.push(path, keep_symlinks=False, upload_path=None)\r\nPush a file from the minion up to the master, the file will be saved to the salt master in the master\'s minion files cachedir (defaults to /var/cache/salt/master/minions/minion-id/files)',2),(66,'cp.push_dir','salt.modules.cp.push_dir(path, glob=None, upload_path=None)\r\nPush a directory from the minion up to the master, the files will be saved to the salt master in the master\'s minion files cachedir (defaults to /var/cache/salt/master/minions/minion-id/files). ',2),(67,'dnsutil.A','salt.modules.dnsutil.A(host, nameserver=None)\r\nReturn the A record(s) for host.',5),(68,'dnsutil.hosts_append','salt.modules.dnsutil.hosts_append(hostsfile=\'/etc/hosts\', ip_addr=None, entries=None)\r\nAppend a single line to the /etc/hosts file.',5),(69,'dnsutil.hosts_remove','salt.modules.dnsutil.hosts_remove(hostsfile=\'/etc/hosts\', entries=None)\r\nRemove a host from the /etc/hosts file. If doing so will leave a line containing only an IP address, then the line will be deleted. This function will leave comments and blank lines intact.',5),(70,'dnsutil.parse_hosts','salt.modules.dnsutil.parse_hosts(hostsfile=\'/etc/hosts\', hosts=None)\r\nParse /etc/hosts file.',5),(71,'config.backup_mode','salt.modules.config.backup_mode(backup=\'\')\r\nReturn the backup mode',21),(72,'config.dot_vals','salt.modules.config.dot_vals(value)\r\nPass in a configuration value that should be preceded by the module name and a dot, this will return a list of all read key/value pairs',21),(73,'config.get','salt.modules.config.get(key, default=\'\', delimiter=\':\', merge=None)\r\nAttempt to retrieve the named value from the minion config file, pillar, grains or the master config. ',21),(74,'config.manage_mode','salt.modules.config.manage_mode(mode)\r\nReturn a mode value, normalized to a string',21),(75,'config.merge','salt.modules.config.merge(value, default=\'\', omit_opts=False, omit_master=False, omit_pillar=False)\r\nRetrieves an option based on key, merging all matches.\r\n\r\nSame as option() except that it merges all matches, rather than taking the first match.',21),(76,'config.option','salt.modules.config.option(value, default=\'\', omit_opts=False, omit_master=False, omit_pillar=False)\r\nPass in a generic option and receive the value that will be assigned',21),(77,'config.valid_fileproto','salt.modules.config.valid_fileproto(uri)\r\nReturns a boolean value based on whether or not the URI passed has a valid remote file protocol designation',21),(78,'cmd.exec_code','salt.modules.cmdmod.exec_code(lang, code, cwd=None)\r\nPass in two strings, the first naming the executable language, aka - python2, python3, ruby, perl, lua, etc. the second string containing the code you wish to execute. The stdout will be returned.',3),(79,'cmd.exec_code_all','All cmd artifacts (stdout, stderr, retcode, pid) will be returned.',3),(80,'cmd.has_exec','salt.modules.cmdmod.has_exec(cmd)\r\nReturns true if the executable is available on the minion, false otherwise',3),(81,'cmd.script','salt.modules.cmdmod.script(source, args=None, cwd=None, stdin=None, runas=None, shell=\'/bin/sh\', python_shell=None, env=None, template=None, umask=None, output_loglevel=\'debug\', log_callback=None, quiet=False, timeout=None, reset_system_locale=True, __env__=None, saltenv=\'base\', use_vt=False, **kwargs)\r\nDownload a script from a remote location and execute the script locally. ',3),(82,'cmd.shell','salt.modules.cmdmod.shell(cmd, cwd=None, stdin=None, runas=None, shell=\'/bin/sh\', env=None, clean_env=False, template=None, rstrip=True, umask=None, output_loglevel=\'debug\', log_callback=None, quiet=False, timeout=None, reset_system_locale=True, ignore_retcode=False, saltenv=\'base\', use_vt=False, **kwargs)\r\nExecute the passed command and return the output as a string.',3),(83,'cmd.which','salt.modules.cmdmod.which(cmd)\r\nReturns the path of an executable available on the minion, None otherwise',3),(84,'cmd.which_bin','salt.modules.cmdmod.which_bin(cmds)\r\nReturns the first command found in a list of commands',3),(85,'mongodb.db_exists','salt.modules.mongodb.db_exists(name, user=None, password=None, host=None, port=None)\r\nChecks if a database exists in Mongodb',14),(86,'mongodb.db_list','salt.modules.mongodb.db_list(user=None, password=None, host=None, port=None)\r\nList all Mongodb databases',14),(87,'mongodb.db_remove','salt.modules.mongodb.db_remove(name, user=None, password=None, host=None, port=None)\r\nRemove a Mongodb database',14),(88,'mongodb.find','salt.modules.mongodb.find(collection, query=None, user=None, password=None, host=None, port=None, database=\'admin\')\r\n',14),(89,'mongodb.insert','salt.modules.mongodb.insert(objects, collection, user=None, password=None, host=None, port=None, database=\'admin\')\r\nInsert an object or list of objects into a collection',14),(90,'mongodb.remove','salt.modules.mongodb.remove(collection, query=None, user=None, password=None, host=None, port=None, database=\'admin\', w=1)\r\nRemove an object or list of objects into a collection',14),(91,'mongodb.user_create','salt.modules.mongodb.user_create(name, passwd, user=None, password=None, host=None, port=None, database=\'admin\')\r\nCreate a Mongodb user',14),(92,'mongodb.user_exists','salt.modules.mongodb.user_exists(name, user=None, password=None, host=None, port=None, database=\'admin\')\r\nChecks if a user exists in Mongodb',14),(93,'mongodb.user_grant_roles','salt.modules.mongodb.user_grant_roles(name, roles, database, user=None, password=None, host=None, port=None)\r\nGrant one or many roles to a Mongodb user',14),(94,'mongodb.user_list','salt.modules.mongodb.user_list(user=None, password=None, host=None, port=None, database=\'admin\')\r\nList users of a Mongodb database',14),(95,'mongodb.user_remove','salt.modules.mongodb.user_remove(name, user=None, password=None, host=None, port=None, database=\'admin\')\r\nRemove a Mongodb user',14),(96,'mongodb.user_revoke_roles','salt.modules.mongodb.user_revoke_roles(name, roles, database, user=None, password=None, host=None, port=None)\r\nRevoke one or many roles to a Mongodb user',14),(97,'mongodb.user_roles_exists','salt.modules.mongodb.user_roles_exists(name, roles, database, user=None, password=None, host=None, port=None)\r\nChecks if a user of a Mongodb database has specified roles',14),(98,'mssql.db_exists','salt.modules.mssql.db_exists(database_name, **kwargs)\r\nFind if a specific database exists on the MS SQL server.',17),(99,'mssql.db_list','salt.modules.mssql.db_list(**kwargs)\r\nReturn the databse list created on a MS SQL server.',17),(100,'mssql.db_remove','salt.modules.mssql.db_remove(database_name, **kwargs)\r\nDrops a specific database from the MS SQL server. It will not drop any of \'master\', \'model\', \'msdb\' or \'tempdb\'.',17),(101,'mssql.login_exists','salt.modules.mssql.login_exists(login, **kwargs)\r\nFind if a login exists in the MS SQL server.',17),(102,'mssql.role_create','salt.modules.mssql.role_create(role, owner=None, **kwargs)\r\nCreates a new database role. If no owner is specified, the role will be owned by the user that executes CREATE ROLE, which is the user argument or mssql.user option.',17),(103,'mssql.role_exists','salt.modules.mssql.role_exists(role, **kwargs)\r\nChecks if a role exists.',17),(104,'mssql.role_list','salt.modules.mssql.role_list(**kwargs)\r\nLists database roles.',17),(105,'mssql.role_remove','salt.modules.mssql.role_remove(role, **kwargs)\r\nRemove a database role.',17),(106,'mssql.tsql_query','salt.modules.mssql.tsql_query(query, **kwargs)\r\nRun a SQL query and return query result as list of tuples, or a list of dictionaries if as_dict was passed, or an empty list if no data is available.',17),(107,'mssql.user_create','salt.modules.mssql.user_create(username, new_login_password=None, **kwargs)\r\nCreates a new user. If new_login_password is not specified, the user will be created without a login.',17),(108,'mssql.user_exists','salt.modules.mssql.user_exists(username, **kwargs)\r\nFind if an user exists in a specific database on the MS SQL server.',17),(109,'mssql.user_list','salt.modules.mssql.user_list(**kwargs)\r\nGet the user list for a specific database on the MS SQL server.',17),(110,'mssql.user_remove','salt.modules.mssql.user_remove(username, **kwargs)\r\nRemoves an user.',17),(111,'mssql.version','salt.modules.mssql.version(**kwargs)\r\nReturn the version of a MS SQL server.',14),(112,'mysql.db','salt.modules.mysql.db_check(name, table=None, **connection_args)\r\nRepairs the full database or just a given table',18),(113,'mysql.db_create','salt.modules.mysql.db_create(name, character_set=None, collate=None, **connection_args)\r\nAdds a databases to the MySQL server.',18),(114,'mysql.db_exists','salt.modules.mysql.db_exists(name, **connection_args)\r\nChecks if a database exists on the MySQL server.',18),(115,'mysql.db_list','salt.modules.mysql.db_list(**connection_args)\r\nReturn a list of databases of a MySQL server using the output from the SHOW DATABASES query.',18),(116,'mysql.db_optimize','salt.modules.mysql.db_optimize(name, table=None, **connection_args)\r\nOptimizes the full database or just a given table',18),(117,'mysql.db_remove','salt.modules.mysql.db_remove(name, **connection_args)\r\nRemoves a databases from the MySQL server.',18),(118,'mysql.db_repair','salt.modules.mysql.db_repair(name, table=None, **connection_args)\r\nRepairs the full database or just a given table',18),(119,'mysql.db_tables','salt.modules.mysql.db_tables(name, **connection_args)\r\nShows the tables in the given MySQL database (if exists)',18),(120,'mysql.get_master_status','salt.modules.mysql.get_master_status(**connection_args)\r\nRetrieves the master status from the minion.',18),(121,'mysql.get_slave_status','salt.modules.mysql.get_slave_status(**connection_args)\r\nRetrieves the slave status from the minion.',18),(122,'mysql.grant_add ','salt.modules.mysql.grant_add(grant, database, user, host=\'localhost\', grant_option=False, escape=True, ssl_option=False, **connection_args)\r\nAdds a grant to the MySQL server.',18),(123,'mysql.grant_exists','salt.modules.mysql.grant_exists(grant, database, user, host=\'localhost\', grant_option=False, escape=True, **connection_args)\r\nChecks to see if a grant exists in the database',18),(124,'mysql.grant_revoke','salt.modules.mysql.grant_revoke(grant, database, user, host=\'localhost\', grant_option=False, escape=True, **connection_args)\r\nRemoves a grant from the MySQL server.',18),(125,'mysql.processlist','salt.modules.mysql.processlist(**connection_args)\r\nRetrieves the processlist from the MySQL server via \"SHOW FULL PROCESSLIST\".',18),(126,'mysql.query','salt.modules.mysql.query(database, query, **connection_args)\r\nRun an arbitrary SQL query and return the results or the number of affected rows.',18),(127,'mysql.showglobal','salt.modules.mysql.showglobal(**connection_args)\r\nRetrieves the show global variables from the minion.',18),(128,'mysql.showvariables','salt.modules.mysql.showvariables(**connection_args)\r\nRetrieves the show variables from the minion.',18),(129,'mysql.status','salt.modules.mysql.status(**connection_args)\r\nReturn the status of a MySQL server using the output from the SHOW STATUS query.',18),(130,'svn.add','salt.modules.svn.add(cwd, targets, user=None, username=None, password=None, *opts)\r\nAdd files to be tracked by the Subversion working-copy checkout',19),(131,'svn.checkout','salt.modules.svn.checkout(cwd, remote, target=None, user=None, username=None, password=None, *opts)\r\nDownload a working copy of the remote Subversion repository directory or file',19),(132,'svn.commit','salt.modules.svn.commit(cwd, targets=None, msg=None, user=None, username=None, password=None, *opts)\r\nCommit the current directory, files, or directories to the remote Subversion repository',19),(133,'svn.diff','salt.modules.svn.diff(cwd, targets=None, user=None, username=None, password=None, *opts)\r\nReturn the diff of the current directory, files, or directories from the remote Subversion repository',19),(134,'svn.export','salt.modules.svn.export(cwd, remote, target=None, user=None, username=None, password=None, revision=\'HEAD\', *opts)\r\nCreate an unversioned copy of a tree.',19),(135,'svn.info','salt.modules.svn.info(cwd, targets=None, user=None, username=None, password=None, fmt=\'str\')\r\nDisplay the Subversion information from the checkout.',19),(136,'svn.remove','salt.modules.svn.remove(cwd, targets, msg=None, user=None, username=None, password=None, *opts)\r\nRemove files and directories from the Subversion repository',19),(137,'svn.status','salt.modules.svn.status(cwd, targets=None, user=None, username=None, password=None, *opts)\r\nDisplay the status of the current directory, files, or directories in the Subversion repository',19),(138,'svn.switch','salt.modules.svn.switch(cwd, remote, target=None, user=None, username=None, password=None, *opts)\r\nSwitch a working copy of a remote Subversion repository directory',19),(139,'svn.update','salt.modules.svn.update(cwd, targets=None, user=None, username=None, password=None, *opts)\r\nUpdate the current directory, files, or directories from the remote Subversion repository',19),(140,'file.access','Test whether the Salt process has the specified access to the file. \r\nsalt \'*\' file.access /path/to/file f\r\nsalt \'*\' file.access /path/to/file x',6),(141,'file.append','salt.modules.file.append(path, *args, **kwargs)\r\nAppend text to the end of a file\r\n\r\nsalt \'*\' file.append /etc/motd \\\r\n        \"With all thine offerings thou shalt offer salt.\" \\\r\n        \"Salt is what makes things taste bad when it isn\'t in them.\"',6),(142,'file.basename','salt.modules.file.basename(path)\r\nReturns the final component of a pathname',6),(143,'file.check_perms','salt.modules.file.check_perms(name, ret, user, group, mode, follow_symlinks=False)\r\nCheck the permissions on files and chown if needed\r\nsalt \'*\' file.check_perms /etc/sudoers \'{}\' root root 400',6),(144,'file.chgrp','salt.modules.file.chgrp(path, group)\r\nChange the group of a file\r\nsalt \'*\' file.chgrp /etc/passwd root',6),(145,'file.chown','salt.modules.file.chown(path, user, group)\r\nChown a file, pass the file the desired user and group\r\nsalt \'*\' file.chown /etc/passwd root root',6),(146,'file.contains','salt.modules.file.contains(path, text)\r\nReturn True if the file at path contains text\r\nsalt \'*\' file.contains /etc/crontab \'mymaintenance.sh\'',6),(147,'file.contains_glob','salt.modules.file.contains_glob(path, glob_expr)\r\nDeprecated since version 0.17.0: Use search() instead.\r\nsalt \'*\' file.contains_glob /etc/foobar \'*cheese*\'',6),(148,'file.copy','salt.modules.file.copy(src, dst, recurse=False, remove_existing=False)\r\nCopy a file or directory from source to dst\r\nsalt \'*\' file.copy /path/to/src /path/to/dst\r\nsalt \'*\' file.copy /path/to/src_dir /path/to/dst_dir recurse=True\r\nsalt \'*\' file.copy /path/to/src_dir /path/to/dst_dir recurse=True remove_existing=True',6),(149,'file.restore_backup','salt.modules.file.delete_backup(path, backup_id)\r\nDelete a previous version of a file that was backed up using Salt\'s file state backup system.\r\nsalt \'*\' file.restore_backup /foo/bar/baz.txt 0\r\n',6),(150,'file.directory_exists','salt.modules.file.directory_exists(path)\r\nTests to see if path is a valid directory. Returns True/False.\r\nsalt \'*\' file.directory_exists /etc',6),(151,'file.dirname','salt.modules.file.dirname(path)\r\nReturns the directory component of a pathname\r\nsalt \'*\' file.dirname \'test/path/filename.config\'',6),(152,'file.diskusage','salt.modules.file.diskusage(path)\r\nRecursively calculate disk usage of path and return it in bytes\r\nsalt \'*\' file.diskusage /path/to/check',6),(153,'file.file_exists','salt.modules.file.file_exists(path)\r\nTests to see if path is a valid file. Returns True/False.\r\nsalt \'*\' file.file_exists /etc/passwd',6),(154,'file.find','salt.modules.file.find(path, *args, **kwargs)\r\nsalt \'*\' file.find / type=f name=\\*.bak size=+10m\r\nsalt \'*\' file.find /var mtime=+30d size=+10m print=path,size,mtime\r\nsalt \'*\' file.find /var/log name=\\*.[0-9] mtime=+30d size=+10m delete',6),(155,'file.get_diff','salt.modules.file.get_diff(minionfile, masterfile, env=None, saltenv=\'base\')\r\nReturn unified diff of file compared to file on master\r\nsalt \'*\' file.get_diff /home/fred/.vimrc salt://users/fred/.vimrc',6),(156,'file.grep','salt.modules.file.grep(path, pattern, *args)\r\nGrep for a string in the specified file\r\nsalt \'*\' file.grep /etc/passwd nobody\r\nsalt \'*\' file.grep /etc/sysconfig/network-scripts/ifcfg-eth0 ipaddr \" -i -B2\"\r\nsalt \'*\' file.grep \"/etc/sysconfig/network-scripts/*\" ipaddr \" -i -l\"',6),(157,'file.mkdir','salt.modules.file.mkdir(dir_path, user=None, group=None, mode=None)\r\nEnsure that a directory is available.\r\nsalt \'*\' file.mkdir /opt/jetty/context',6),(158,'file.move','salt.modules.file.move(src, dst)\r\nMove a file or directory\r\nsalt \'*\' file.move /path/to/src /path/to/dst',6);
/*!40000 ALTER TABLE `app_salt_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_flow`
--

DROP TABLE IF EXISTS `app_salt_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `hosts` varchar(100) NOT NULL,
  `info` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_flow`
--

LOCK TABLES `app_salt_flow` WRITE;
/*!40000 ALTER TABLE `app_salt_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_salt_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_flow_funs`
--

DROP TABLE IF EXISTS `app_salt_flow_funs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_flow_funs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salt_flow_id` int(11) NOT NULL,
  `salt_function_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salt_flow_id` (`salt_flow_id`,`salt_function_id`),
  KEY `app_salt_flow__salt_function_id_780cf80e_fk_app_salt_function_id` (`salt_function_id`),
  CONSTRAINT `app_salt_flow__salt_function_id_780cf80e_fk_app_salt_function_id` FOREIGN KEY (`salt_function_id`) REFERENCES `app_salt_function` (`id`),
  CONSTRAINT `app_salt_flow_funs_salt_flow_id_554887f6_fk_app_salt_flow_id` FOREIGN KEY (`salt_flow_id`) REFERENCES `app_salt_flow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_flow_funs`
--

LOCK TABLES `app_salt_flow_funs` WRITE;
/*!40000 ALTER TABLE `app_salt_flow_funs` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_salt_flow_funs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_function`
--

DROP TABLE IF EXISTS `app_salt_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `args` varchar(100) NOT NULL,
  `info` longtext NOT NULL,
  `cmd_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `app_salt_function_cmd_id_39365b27_fk_app_salt_command_id` (`cmd_id`),
  CONSTRAINT `app_salt_function_cmd_id_39365b27_fk_app_salt_command_id` FOREIGN KEY (`cmd_id`) REFERENCES `app_salt_command` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_function`
--

LOCK TABLES `app_salt_function` WRITE;
/*!40000 ALTER TABLE `app_salt_function` DISABLE KEYS */;
INSERT INTO `app_salt_function` VALUES (1,'查看c:\\salt目录','dir c:\\salt','',3);
/*!40000 ALTER TABLE `app_salt_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_function_group`
--

DROP TABLE IF EXISTS `app_salt_function_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_function_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `salt_function_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salt_function_id` (`salt_function_id`,`group_id`),
  KEY `app_salt_function_group_group_id_39a8be6_fk_app_group_id` (`group_id`),
  CONSTRAINT `app_salt_funct_salt_function_id_1795b870_fk_app_salt_function_id` FOREIGN KEY (`salt_function_id`) REFERENCES `app_salt_function` (`id`),
  CONSTRAINT `app_salt_function_group_group_id_39a8be6_fk_app_group_id` FOREIGN KEY (`group_id`) REFERENCES `app_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_function_group`
--

LOCK TABLES `app_salt_function_group` WRITE;
/*!40000 ALTER TABLE `app_salt_function_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_salt_function_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_module`
--

DROP TABLE IF EXISTS `app_salt_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `info` longtext NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_module`
--

LOCK TABLES `app_salt_module` WRITE;
/*!40000 ALTER TABLE `app_salt_module` DISABLE KEYS */;
INSERT INTO `app_salt_module` VALUES (1,'test','Module for running arbitrary tests','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.test.html#module-salt.modules.test'),(2,'cp','Minion side functions for salt-cp','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.cp.html#module-salt.modules.cp'),(3,'cmdmod','A module for shelling out.','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.cmdmod.html#module-salt.modules.cmdmod'),(4,'cron','Work with cron','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.cron.html#module-salt.modules.cron'),(5,'dnsutil','Compendium of generic DNS utilities','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.dnsutil.html#module-salt.modules.dnsutil'),(6,'file','Manage information about regular files, directories,','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.file.html#module-salt.modules.file'),(7,'network','Module for gathering and managing network information',''),(8,'win_pkg','A module to manage software on Windows',''),(9,'yumpgk','Support for YUM/DNF',''),(10,'service','The default service module, if not otherwise specified salt will fall back','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.service.html#module-salt.modules.service'),(11,'win_service','Windows Service module.',''),(12,'win_network','Module for gathering and managing network information',''),(13,'redismod','Module to provide redis functionality to Salt',''),(14,'mongodb','Module to provide MongoDB functionality to Salt\r\nmongodb.host: \'localhost\'\r\nmongodb.port: 27017\r\nmongodb.user: \'\'\r\nmongodb.password: \'\'','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mongodb.html#module-salt.modules.mongodb'),(15,'nginx','Support for nginx',''),(16,'iptables','Support for iptables','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.iptables.html#module-salt.modules.iptables'),(17,'mssql','Module to provide MS SQL Server compatibility to salt. configs/pillars：\r\nmssql.server: \'localhost\'\r\nmssql.port:   1433\r\nmssql.user:   \'sysdba\'\r\nmssql.password:   \'Some preferable','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mssql.html#module-salt.modules.mssql'),(18,'mysql','/etc/salt/minion\r\nmysql.host: \'localhost\'\r\nmysql.port: 3306\r\nmysql.user: \'root\'\r\nmysql.pass: \'\'\r\nmysql.db: \'mysql\'\r\nmysql.unix_socket: \'/tmp/mysql.sock\'\r\nmysql.charset: \'utf8\'','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mysql.html#module-salt.modules.mysql'),(19,'svn','Subversion SCM','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.svn.html#module-salt.modules.svn'),(20,'grains','Return/control aspects of the grains data','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.grains.html#module-salt.modules.grains'),(21,'config','Return config information','https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.config.html#module-salt.modules.config');
/*!40000 ALTER TABLE `app_salt_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_salt_server`
--

DROP TABLE IF EXISTS `app_salt_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_salt_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` char(39) NOT NULL,
  `port` int(11) NOT NULL,
  `user` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `idc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_salt_server_idc_id_2b0df83e_fk_app_idc_id` (`idc_id`),
  CONSTRAINT `app_salt_server_idc_id_2b0df83e_fk_app_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `app_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_salt_server`
--

LOCK TABLES `app_salt_server` WRITE;
/*!40000 ALTER TABLE `app_salt_server` DISABLE KEYS */;
INSERT INTO `app_salt_server` VALUES (1,'10.188.1.40',11511,'OMuser','KJS23o4ij09gHF734iuhsdfhkGYSihoiwhj38u4h',3);
/*!40000 ALTER TABLE `app_salt_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_server`
--

DROP TABLE IF EXISTS `app_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `ip` char(39) NOT NULL,
  `brand` varchar(30) NOT NULL,
  `model` varchar(30) NOT NULL,
  `sn` varchar(30) NOT NULL,
  `location` varchar(30) NOT NULL,
  `system` varchar(30) NOT NULL,
  `idc_name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`),
  KEY `app_server_idc_name_id_63ce1fa3_fk_app_idc_id` (`idc_name_id`),
  CONSTRAINT `app_server_idc_name_id_63ce1fa3_fk_app_idc_id` FOREIGN KEY (`idc_name_id`) REFERENCES `app_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_server`
--

LOCK TABLES `app_server` WRITE;
/*!40000 ALTER TABLE `app_server` DISABLE KEYS */;
INSERT INTO `app_server` VALUES (7,'Open-Test-08','192.168.22.8','IBM','3650M4','7915I28','1-32U','XenServer6.1',2),(8,'Com-SQL-02','192.168.22.2','IBM','3650M4','7915I28','1-28U','XenServer6.1',2),(9,'Ewin-Xen01-36','10.188.1.36','DELL','3650M3','7945001','1-32U','XenServer6.1',3);
/*!40000 ALTER TABLE `app_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_upload`
--

DROP TABLE IF EXISTS `app_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `headImg` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_upload`
--

LOCK TABLES `app_upload` WRITE;
/*!40000 ALTER TABLE `app_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add idc',7,'add_idc'),(20,'Can change idc',7,'change_idc'),(21,'Can delete idc',7,'delete_idc'),(22,'Can add server',8,'add_server'),(23,'Can change server',8,'change_server'),(24,'Can delete server',8,'delete_server'),(25,'Can add host',9,'add_host'),(26,'Can change host',9,'change_host'),(27,'Can delete host',9,'delete_host'),(28,'Can add group',10,'add_group'),(29,'Can change group',10,'change_group'),(30,'Can delete group',10,'delete_group'),(31,'Can add 主机详细信息',11,'add_host_detail'),(32,'Can change 主机详细信息',11,'change_host_detail'),(33,'Can delete 主机详细信息',11,'delete_host_detail'),(34,'Can add Salt服务器',12,'add_salt_server'),(35,'Can change Salt服务器',12,'change_salt_server'),(36,'Can delete Salt服务器',12,'delete_salt_server'),(37,'Can add Salt命令',13,'add_salt_command'),(38,'Can change Salt命令',13,'change_salt_command'),(39,'Can delete Salt命令',13,'delete_salt_command'),(40,'Can add Salt功能',14,'add_salt_function'),(41,'Can change Salt功能',14,'change_salt_function'),(42,'Can delete Salt功能',14,'delete_salt_function'),(43,'Can add Salt流程',15,'add_salt_flow'),(44,'Can change Salt流程',15,'change_salt_flow'),(45,'Can delete Salt流程',15,'delete_salt_flow'),(46,'Can add Salt模块',16,'add_salt_module'),(47,'Can change Salt模块',16,'change_salt_module'),(48,'Can delete Salt模块',16,'delete_salt_module'),(49,'Can add 网络设备',17,'add_network'),(50,'Can change 网络设备',17,'change_network'),(51,'Can delete 网络设备',17,'delete_network'),(52,'Can add 文件上传',18,'add_upload'),(53,'Can change 文件上传',18,'change_upload'),(54,'Can delete 文件上传',18,'delete_upload');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$XRj7QaIgZBO6$6JbsMY/zIHcCoN5x5Y3b88szlPbq+NPHnhGX3WzPO58=','2016-03-24 01:41:37',1,'admin','管理员','管理员','admin@oms.com',1,1,'2016-02-24 02:30:00'),(2,'pbkdf2_sha256$20000$FfcNJ5bqcFvd$mxvC/4fQNS/APokV+SR2g9GuV3LriF2wSPmsc2t2XF8=','2016-03-17 01:21:16',0,'user01','','','',0,1,'2016-02-24 02:31:00');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_30a071c9_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_5151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_1c5f563_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-02-24 02:31:39','2','user01',1,'',4,1),(2,'2016-02-24 02:31:50','2','user01',2,'没有字段被修改。',4,1),(3,'2016-02-25 06:18:09','1','上海曼威',1,'',7,1),(4,'2016-02-25 06:19:54','2','南昌鄱湖云',1,'',7,1),(5,'2016-02-25 06:28:39','3','南昌易往',1,'',7,1),(6,'2016-02-25 06:44:40','1','Windows',1,'',10,1),(7,'2016-02-25 06:44:50','2','CentOS',1,'',10,1),(8,'2016-02-25 06:45:13','3','XenServer',1,'',10,1),(9,'2016-02-25 06:45:34','4','Web',1,'',10,1),(10,'2016-02-25 06:45:42','5','Database',1,'',10,1),(11,'2016-02-25 06:45:46','6','Redis',1,'',10,1),(12,'2016-02-25 06:45:58','7','Nginx',1,'',10,1),(13,'2016-02-25 06:46:02','8','IIS',1,'',10,1),(14,'2016-02-25 06:46:27','9','停用',1,'',10,1),(15,'2016-02-25 06:50:14','7','10.99.1.3',1,'',8,1),(16,'2016-02-25 06:50:42','1','Com-Nginx-Master-33',1,'',9,1),(17,'2016-02-25 06:51:45','1','Com-Nginx-Master-33',2,'没有字段被修改。',9,1),(18,'2016-02-25 06:53:40','8','Com-SQL-02',1,'',8,1),(19,'2016-02-25 06:53:47','2','OT-SQL-44',1,'',9,1),(20,'2016-02-25 06:54:28','1','OT-Master-41',2,'已修改 name，ip，group 和 app 。',9,1),(21,'2016-02-25 06:55:22','3','OT-WEB-DNS-43',1,'',9,1),(22,'2016-02-25 06:55:40','7','Open-Test-08',2,'已修改 name 和 ip 。',8,1),(23,'2016-02-25 07:02:29','9','停用',3,'',10,1),(24,'2016-02-25 08:43:23','2','南昌鄱湖云',2,'没有字段被修改。',7,1),(25,'2016-02-26 06:00:52','1','admin',2,'已修改 first_name，last_name 和 last_login 。',4,1),(26,'2016-02-26 06:53:19','9','Ewin-Xen01-36',1,'',8,1),(27,'2016-02-26 06:54:47','4','SaltMinion01-41',1,'',9,1),(28,'2016-02-26 06:55:26','5','SaltMinion02-42',1,'',9,1),(29,'2016-02-26 06:56:16','6','SaltMaster-40',1,'',9,1),(30,'2016-02-29 02:14:45','1','10.188.1.40',1,'',11,1),(31,'2016-02-29 03:00:25','2','10.188.1.41',2,'没有字段被修改。',11,1),(32,'2016-03-04 05:37:57','5','saltminion02-42',2,'已修改 name 。',9,1),(33,'2016-03-04 05:38:20','4','saltminion01-41.ewp.com',2,'已修改 name 。',9,1),(34,'2016-03-04 05:38:31','4','saltminion01-41.ewp.com',2,'已修改 group 。',9,1),(35,'2016-03-04 05:38:37','5','saltminion02-42',2,'已修改 group 。',9,1),(36,'2016-03-09 01:21:26','1','10.188.1.40',1,'',12,1),(37,'2016-03-09 01:55:29','1','test.ping',1,'',13,1),(38,'2016-03-09 02:06:27','1','test',1,'',16,1),(39,'2016-03-09 02:08:28','2','cp',1,'',16,1),(40,'2016-03-09 02:10:01','3','cmd',1,'',16,1),(41,'2016-03-09 02:10:23','4','cron',1,'',16,1),(42,'2016-03-09 02:10:36','5','dnsutil',1,'',16,1),(43,'2016-03-09 02:10:49','6','file',1,'',16,1),(44,'2016-03-09 02:11:05','7','network',1,'',16,1),(45,'2016-03-09 02:13:06','8','win_pkg',1,'',16,1),(46,'2016-03-09 02:13:21','9','yumpgk',1,'',16,1),(47,'2016-03-09 02:14:55','10','service',1,'',16,1),(48,'2016-03-09 02:15:08','11','win_service',1,'',16,1),(49,'2016-03-09 02:15:57','12','win_network',1,'',16,1),(50,'2016-03-09 02:17:15','13','redismod',1,'',16,1),(51,'2016-03-09 02:18:07','14','mongodb',1,'',16,1),(52,'2016-03-09 02:18:25','15','nginx',1,'',16,1),(53,'2016-03-09 02:19:28','16','iptables',1,'',16,1),(54,'2016-03-09 02:23:10','17','mssql',1,'',16,1),(55,'2016-03-09 02:24:14','17','mssql',2,'没有字段被修改。',16,1),(56,'2016-03-09 02:24:31','18','mysql',1,'',16,1),(57,'2016-03-09 02:26:18','19','svn',1,'',16,1),(58,'2016-03-09 02:49:30','1','test',2,'已修改 url 。',16,1),(59,'2016-03-09 02:49:40','2','test.ping',1,'',13,1),(60,'2016-03-09 02:50:26','3','cmdmod',2,'已修改 name，info 和 url 。',16,1),(61,'2016-03-09 02:51:00','3','cmd.run',1,'',13,1),(62,'2016-03-09 02:51:47','10','service',2,'已修改 url 。',16,1),(63,'2016-03-09 02:52:39','4','service.available',1,'',13,1),(64,'2016-03-09 02:53:07','5','service.get_all',1,'',13,1),(65,'2016-03-09 02:53:35','6','service.reload',1,'',13,1),(66,'2016-03-09 02:53:43','7','service.restart',1,'',13,1),(67,'2016-03-09 02:54:13','8','service.start',1,'',13,1),(68,'2016-03-09 02:54:30','9','service.status',1,'',13,1),(69,'2016-03-09 02:54:47','10','service.stop',1,'',13,1),(70,'2016-03-11 01:14:59','20','grains',1,'',16,1),(71,'2016-03-11 01:17:15','11','grains.append',1,'',13,1),(72,'2016-03-11 01:19:35','12','grains.delval',1,'',13,1),(73,'2016-03-11 01:20:36','13','grains.filter_by',1,'',13,1),(74,'2016-03-11 01:20:57','14','grains.get',1,'',13,1),(75,'2016-03-11 01:22:28','15','grains.has_value',1,'',13,1),(76,'2016-03-11 01:22:46','16','grains.item',1,'',13,1),(77,'2016-03-11 01:23:13','17','grains.items',1,'',13,1),(78,'2016-03-11 01:23:34','18','grains.ls',1,'',13,1),(79,'2016-03-11 01:24:16','19','grains.remove',1,'',13,1),(80,'2016-03-11 01:24:28','20','grains.set',1,'',13,1),(81,'2016-03-11 01:25:00','21','grains.setval',1,'',13,1),(82,'2016-03-11 01:25:15','22','grains.setvals',1,'',13,1),(83,'2016-03-11 07:13:17','4','saltminion01-41.ewp.com',2,'已修改 group 。',9,1),(84,'2016-03-11 07:13:40','5','saltminion02-42',2,'已修改 group 。',9,1),(85,'2016-03-11 08:44:55','23','network.active_tcp',1,'',13,1),(86,'2016-03-11 08:45:16','24','network.arp',1,'',13,1),(87,'2016-03-11 08:45:33','25','network.calc_net',1,'',13,1),(88,'2016-03-11 08:46:04','26','network.connect',1,'',13,1),(89,'2016-03-11 08:46:19','27','network.default_rout',1,'',13,1),(90,'2016-03-11 08:46:37','28','network.dig',1,'',13,1),(91,'2016-03-11 08:46:57','29','network.get_hostname',1,'',13,1),(92,'2016-03-11 08:47:13','30','network.get_route',1,'',13,1),(93,'2016-03-11 08:47:31','31','network.hw_addr',1,'',13,1),(94,'2016-03-11 08:47:47','32','network.hwaddr',1,'',13,1),(95,'2016-03-11 08:48:01','33','network.in_subnet',1,'',13,1),(96,'2016-03-11 08:48:17','34','network.interface',1,'',13,1),(97,'2016-03-11 08:48:33','35','network.interface_ip',1,'',13,1),(98,'2016-03-11 08:48:47','36','network.interfaces',1,'',13,1),(99,'2016-03-11 08:49:28','37','network.ip_addrs',1,'',13,1),(100,'2016-03-11 08:50:44','38','network.is_loopback',1,'',13,1),(101,'2016-03-11 08:51:10','39','network.mod_hostname',1,'',13,1),(102,'2016-03-11 08:51:31','40','network.is_private',1,'',13,1),(103,'2016-03-11 08:52:04','41','network.netstat',1,'',13,1),(104,'2016-03-11 08:52:18','42','network.ping',1,'',13,1),(105,'2016-03-11 08:52:57','43','network.reverse_ip',1,'',13,1),(106,'2016-03-11 08:53:12','44','network.routes',1,'',13,1),(107,'2016-03-11 08:53:36','45','network.subnets',1,'',13,1),(108,'2016-03-11 08:53:52','46','network.traceroute',1,'',13,1),(109,'2016-03-11 08:54:37','47','network.wol',1,'',13,1),(110,'2016-03-14 07:05:02','2','cp',2,'已修改 url 。',16,1),(111,'2016-03-14 07:05:57','48','cp.cache_dir',1,'',13,1),(112,'2016-03-14 07:06:14','49','cp.cache_file',1,'',13,1),(113,'2016-03-14 07:06:35','50','cp.cache_files',1,'',13,1),(114,'2016-03-14 07:06:54','51','cp.cache_local_file',1,'',13,1),(115,'2016-03-14 07:07:08','52','cp.cache_master',1,'',13,1),(116,'2016-03-14 07:07:25','53','cp.get_dir',1,'',13,1),(117,'2016-03-14 07:07:37','54','cp.get_file',1,'',13,1),(118,'2016-03-14 07:08:10','55','cp.get_file_str',1,'',13,1),(119,'2016-03-14 07:08:23','56','cp.get_template',1,'',13,1),(120,'2016-03-14 07:08:42','57','cp.get_url',1,'',13,1),(121,'2016-03-14 07:08:57','58','cp.hash_file',1,'',13,1),(122,'2016-03-14 07:09:19','59','cp.is_cached',1,'',13,1),(123,'2016-03-14 07:09:31','60','cp.list_master',1,'',13,1),(124,'2016-03-14 07:19:08','61','cp.list_master_dirs',1,'',13,1),(125,'2016-03-14 07:21:12','62','cp.list_master_symlinks',1,'',13,1),(126,'2016-03-14 07:21:39','63','cp.list_minion',1,'',13,1),(127,'2016-03-14 07:21:52','64','cp.list_states',1,'',13,1),(128,'2016-03-14 07:22:28','65','cp.push',1,'',13,1),(129,'2016-03-14 07:23:19','66','cp.push_dir',1,'',13,1),(130,'2016-03-14 07:24:34','4','cron',2,'已修改 url 。',16,1),(131,'2016-03-14 07:25:24','5','dnsutil',2,'已修改 url 。',16,1),(132,'2016-03-14 07:25:50','6','file',2,'已修改 url 。',16,1),(133,'2016-03-14 07:26:09','16','iptables',2,'已修改 url 。',16,1),(134,'2016-03-14 07:26:37','14','mongodb',2,'已修改 url 。',16,1),(135,'2016-03-14 07:41:15','67','dnsutil.A',1,'',13,1),(136,'2016-03-14 07:42:50','68','dnsutil.hosts_append',1,'',13,1),(137,'2016-03-14 07:43:09','69','dnsutil.hosts_remove',1,'',13,1),(138,'2016-03-14 07:43:31','70','dnsutil.parse_hosts',1,'',13,1),(139,'2016-03-14 07:44:24','21','config',1,'',16,1),(140,'2016-03-14 08:05:39','71','config.backup_mode',1,'',13,1),(141,'2016-03-14 08:06:03','72','config.dot_vals',1,'',13,1),(142,'2016-03-14 08:07:04','73','config.get',1,'',13,1),(143,'2016-03-14 08:07:38','74','config.manage_mode',1,'',13,1),(144,'2016-03-14 08:08:07','75','config.merge',1,'',13,1),(145,'2016-03-14 08:08:23','76','config.option',1,'',13,1),(146,'2016-03-14 08:08:50','77','config.valid_fileproto',1,'',13,1),(147,'2016-03-14 08:09:55','78','cmd.exec_code',1,'',13,1),(148,'2016-03-14 08:10:42','79','cmd.exec_code_all',1,'',13,1),(149,'2016-03-14 08:11:12','80','cmd.has_exec',1,'',13,1),(150,'2016-03-14 08:25:38','3','cmd.run',2,'已修改 info 。',13,1),(151,'2016-03-14 08:28:33','81','cmd.script',1,'',13,1),(152,'2016-03-14 08:29:55','82','cmd.shell',1,'',13,1),(153,'2016-03-14 08:31:06','83','cmd.which',1,'',13,1),(154,'2016-03-14 08:31:36','84','cmd.which_bin',1,'',13,1),(155,'2016-03-14 08:34:36','85','mongodb.db_exists',1,'',13,1),(156,'2016-03-14 08:34:55','86','mongodb.db_list',1,'',13,1),(157,'2016-03-14 08:35:11','87','mongodb.db_remove',1,'',13,1),(158,'2016-03-14 08:35:27','88','mongodb.find',1,'',13,1),(159,'2016-03-14 08:36:06','89','mongodb.insert',1,'',13,1),(160,'2016-03-14 08:36:21','90','mongodb.remove',1,'',13,1),(161,'2016-03-14 08:36:42','91','mongodb.user_create',1,'',13,1),(162,'2016-03-14 08:36:55','92','mongodb.user_exists',1,'',13,1),(163,'2016-03-14 08:37:27','93','mongodb.user_grant_roles',1,'',13,1),(164,'2016-03-14 08:37:40','94','mongodb.user_list',1,'',13,1),(165,'2016-03-14 08:37:53','95','mongodb.user_remove',1,'',13,1),(166,'2016-03-14 08:38:08','96','mongodb.user_revoke_roles',1,'',13,1),(167,'2016-03-14 08:38:22','97','mongodb.user_roles_exists',1,'',13,1),(168,'2016-03-14 08:39:04','98','mssql.db_exists',1,'',13,1),(169,'2016-03-14 08:39:18','99','mssql.db_list',1,'',13,1),(170,'2016-03-14 08:39:41','100','mssql.db_remove',1,'',13,1),(171,'2016-03-14 08:39:57','101','mssql.login_exists',1,'',13,1),(172,'2016-03-14 08:40:15','102','mssql.role_create',1,'',13,1),(173,'2016-03-14 08:40:28','103','mssql.role_exists',1,'',13,1),(174,'2016-03-14 08:40:44','104','mssql.role_list',1,'',13,1),(175,'2016-03-14 08:41:52','105','mssql.role_remove',1,'',13,1),(176,'2016-03-14 08:42:13','106','mssql.tsql_query',1,'',13,1),(177,'2016-03-14 08:42:30','107','mssql.user_create',1,'',13,1),(178,'2016-03-14 08:42:46','108','mssql.user_exists',1,'',13,1),(179,'2016-03-14 08:43:22','109','mssql.user_list',1,'',13,1),(180,'2016-03-14 08:43:30','110','mssql.user_remove',1,'',13,1),(181,'2016-03-14 08:43:51','111','mssql.version',1,'',13,1),(182,'2016-03-14 08:46:30','17','mssql',2,'已修改 info 。',16,1),(183,'2016-03-14 08:46:42','14','mongodb',2,'已修改 info 。',16,1),(184,'2016-03-14 08:47:42','18','mysql',2,'已修改 info 。',16,1),(185,'2016-03-14 08:48:00','112','mysql.db',1,'',13,1),(186,'2016-03-14 08:48:15','113','mysql.db_create',1,'',13,1),(187,'2016-03-14 08:48:27','114','mysql.db_exists',1,'',13,1),(188,'2016-03-14 08:48:42','115','mysql.db_list',1,'',13,1),(189,'2016-03-14 08:49:03','116','mysql.db_optimize',1,'',13,1),(190,'2016-03-14 08:49:13','117','mysql.db_remove',1,'',13,1),(191,'2016-03-14 08:49:32','118','mysql.db_repair',1,'',13,1),(192,'2016-03-14 08:49:51','119','mysql.db_tables',1,'',13,1),(193,'2016-03-14 08:50:34','120','mysql.get_master_status',1,'',13,1),(194,'2016-03-14 08:50:53','121','mysql.get_slave_status',1,'',13,1),(195,'2016-03-14 08:51:26','122','mysql.grant_add ',1,'',13,1),(196,'2016-03-14 08:51:42','123','mysql.grant_exists',1,'',13,1),(197,'2016-03-14 08:51:57','124','mysql.grant_revoke',1,'',13,1),(198,'2016-03-14 08:52:09','125','mysql.processlist',1,'',13,1),(199,'2016-03-14 08:52:39','126','mysql.query',1,'',13,1),(200,'2016-03-14 08:54:20','127','mysql.showglobal',1,'',13,1),(201,'2016-03-14 08:54:34','128','mysql.showvariables',1,'',13,1),(202,'2016-03-14 08:54:49','129','mysql.status',1,'',13,1),(203,'2016-03-15 06:20:58','1','易往防火墙',1,'',17,1),(204,'2016-03-15 06:22:12','2','EWP线上防火墙',1,'',17,1),(205,'2016-03-15 06:27:47','1','易往防火墙',2,'已修改 ip_out 和 ip_in 。',17,1),(206,'2016-03-15 06:28:32','2','EWP线上防火墙',2,'已修改 ip_out 和 ip_in 。',17,1),(207,'2016-03-15 07:27:36','2','EWP防火墙',2,'已修改 name 。',17,1),(208,'2016-03-15 07:28:58','1','易往防火墙',2,'已修改 username 和 password 。',17,1),(209,'2016-03-15 07:29:03','1','易往防火墙',2,'没有字段被修改。',17,1),(210,'2016-03-15 07:29:07','2','EWP防火墙',2,'已修改 username 和 password 。',17,1),(211,'2016-03-15 07:35:06','130','svn.add',1,'',13,1),(212,'2016-03-15 07:35:16','131','svn.checkout',1,'',13,1),(213,'2016-03-15 07:35:36','132','svn.commit',1,'',13,1),(214,'2016-03-15 07:35:54','133','svn.diff',1,'',13,1),(215,'2016-03-15 07:36:18','134','svn.export',1,'',13,1),(216,'2016-03-15 07:37:34','135','svn.info',1,'',13,1),(217,'2016-03-15 07:37:58','136','svn.remove',1,'',13,1),(218,'2016-03-15 07:38:16','137','svn.status',1,'',13,1),(219,'2016-03-15 07:38:36','138','svn.switch',1,'',13,1),(220,'2016-03-15 07:39:34','139','svn.update',1,'',13,1),(221,'2016-03-21 03:43:27','1','111.75.222.136',2,'已修改 ip 。',12,1),(222,'2016-03-24 01:23:04','1','上海神舟机房',2,'已修改 name，ips，address 和 contact 。',7,1),(223,'2016-03-24 01:24:24','3','长沙渡口机房',2,'已修改 name，ips，address 和 contact 。',7,1),(224,'2016-03-24 01:25:38','2','北京府才机房',2,'已修改 name，type，ips，address 和 contact 。',7,1),(225,'2016-03-24 01:27:13','2','BJ防火墙',2,'已修改 name，brand，model，ip_out，ip_in，info 和 url 。',17,1),(226,'2016-03-24 01:28:13','1','CS防火墙',2,'已修改 name，brand，model，ip_out，info 和 url 。',17,1),(227,'2016-03-24 01:28:52','2','192.168.22.20',2,'已修改 ip 。',11,1),(228,'2016-03-24 01:30:30','1','10.188.1.40',2,'已修改 ip 。',12,1),(229,'2016-03-24 01:35:31','8','Com-SQL-02',2,'已修改 ip 。',8,1),(230,'2016-03-24 01:35:51','7','Open-Test-08',2,'已修改 ip 。',8,1),(231,'2016-03-24 01:35:56','8','Com-SQL-02',2,'已修改 ip 。',8,1),(232,'2016-03-24 01:36:34','1','OT-Master-41',2,'已修改 ip 。',9,1),(233,'2016-03-24 01:36:41','2','OT-SQL-44',2,'已修改 ip 。',9,1),(234,'2016-03-24 01:36:49','3','OT-WEB-DNS-43',2,'已修改 ip 。',9,1),(235,'2016-03-24 01:37:07','4','saltminion01-41.ewp.com',2,'没有字段被修改。',9,1),(236,'2016-03-24 01:37:13','5','saltminion02-42',2,'没有字段被修改。',9,1),(237,'2016-03-24 01:37:19','6','SaltMaster-40',2,'没有字段被修改。',9,1),(238,'2016-03-24 01:38:07','1','CS防火墙',2,'已修改 url 。',17,1),(239,'2016-03-24 07:53:50','140','file.access',1,'',13,1),(240,'2016-03-24 07:54:21','141','file.append',1,'',13,1),(241,'2016-03-24 08:21:04','141','file.append',2,'已修改 info 。',13,1),(242,'2016-03-24 08:23:35','142','file.basename',1,'',13,1),(243,'2016-03-24 08:24:06','143','file.check_perms',1,'',13,1),(244,'2016-03-24 08:24:37','144','file.chgrp',1,'',13,1),(245,'2016-03-24 08:24:54','145','file.chown',1,'',13,1),(246,'2016-03-24 08:25:50','146','file.contains',1,'',13,1),(247,'2016-03-24 08:26:13','147','file.contains_glob',1,'',13,1),(248,'2016-03-24 08:26:51','148','file.copy',1,'',13,1),(249,'2016-03-24 08:28:11','149','file.restore_backup',1,'',13,1),(250,'2016-03-24 08:28:33','150','file.directory_exists',1,'',13,1),(251,'2016-03-24 08:29:10','151','file.dirname',1,'',13,1),(252,'2016-03-24 08:29:27','152','file.diskusage',1,'',13,1),(253,'2016-03-24 08:29:57','153','file.file_exists',1,'',13,1),(254,'2016-03-24 08:31:03','154','file.find',1,'',13,1),(255,'2016-03-24 08:36:28','155','file.get_diff',1,'',13,1),(256,'2016-03-24 08:38:35','156','file.grep',1,'',13,1),(257,'2016-03-24 08:40:48','157','file.mkdir',1,'',13,1),(258,'2016-03-24 08:41:20','158','file.move',1,'',13,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(10,'app','group'),(9,'app','host'),(11,'app','host_detail'),(7,'app','idc'),(17,'app','network'),(13,'app','salt_command'),(15,'app','salt_flow'),(14,'app','salt_function'),(16,'app','salt_module'),(12,'app','salt_server'),(8,'app','server'),(18,'app','upload'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-02-23 08:51:31'),(2,'auth','0001_initial','2016-02-23 08:51:37'),(3,'admin','0001_initial','2016-02-23 08:51:39'),(4,'contenttypes','0002_remove_content_type_name','2016-02-23 08:51:40'),(5,'auth','0002_alter_permission_name_max_length','2016-02-23 08:51:41'),(6,'auth','0003_alter_user_email_max_length','2016-02-23 08:51:42'),(7,'auth','0004_alter_user_username_opts','2016-02-23 08:51:42'),(8,'auth','0005_alter_user_last_login_null','2016-02-23 08:51:43'),(9,'auth','0006_require_contenttypes_0002','2016-02-23 08:51:43'),(10,'sessions','0001_initial','2016-02-23 08:51:43'),(11,'app','0001_initial','2016-02-25 06:11:24'),(12,'app','0002_auto_20160225_1410','2016-02-25 06:11:27'),(13,'app','0003_auto_20160229_1003','2016-02-29 02:03:20'),(14,'app','0004_auto_20160229_1014','2016-02-29 02:14:41'),(15,'app','0005_auto_20160229_1059','2016-03-08 09:00:21'),(16,'app','0006_auto_20160309_0918','2016-03-09 01:18:31'),(17,'app','0007_salt_module','2016-03-09 02:04:06'),(18,'app','0008_salt_command_module','2016-03-09 02:05:00'),(19,'app','0009_salt_module_url','2016-03-09 02:21:41'),(20,'app','0010_auto_20160314_1520','2016-03-14 07:21:06'),(21,'app','0011_network','2016-03-15 06:14:47'),(22,'app','0012_auto_20160315_1419','2016-03-15 06:19:43'),(23,'app','0013_auto_20160315_1425','2016-03-15 06:25:56'),(24,'app','0014_auto_20160315_1529','2016-03-15 07:29:30'),(25,'app','0015_upload','2016-03-15 08:40:28'),(26,'app','0016_upload_date','2016-03-17 01:56:54');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('25hynns1xqemc4qik7a2w00weac2n6rx','OTgzODgwZWEwMzMxOTY1ZGEzODRiMWYyY2YwZDRhZDVkZDM5MzcyZjp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0N2EyZjE0OTdjZGY4NGY4NTkzZjQyNzdmMGNjOGM5ZjkwZTA0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-03-16 03:14:20'),('3jekyofpcq9l304io2tqnp412zjffuu8','OTgzODgwZWEwMzMxOTY1ZGEzODRiMWYyY2YwZDRhZDVkZDM5MzcyZjp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0N2EyZjE0OTdjZGY4NGY4NTkzZjQyNzdmMGNjOGM5ZjkwZTA0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-03-14 08:10:54'),('eouzx40yhyuekocpyymjsmgft08qv1vc','OTgzODgwZWEwMzMxOTY1ZGEzODRiMWYyY2YwZDRhZDVkZDM5MzcyZjp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0N2EyZjE0OTdjZGY4NGY4NTkzZjQyNzdmMGNjOGM5ZjkwZTA0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-03-10 06:11:51'),('rqwx1iuww2zjuhnbpauiltc1yc6n0ahe','OTgzODgwZWEwMzMxOTY1ZGEzODRiMWYyY2YwZDRhZDVkZDM5MzcyZjp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0N2EyZjE0OTdjZGY4NGY4NTkzZjQyNzdmMGNjOGM5ZjkwZTA0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-04-04 03:42:38'),('yg6hypjhl57k3tdon6k2u5cpnuodrx80','OTgzODgwZWEwMzMxOTY1ZGEzODRiMWYyY2YwZDRhZDVkZDM5MzcyZjp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0N2EyZjE0OTdjZGY4NGY4NTkzZjQyNzdmMGNjOGM5ZjkwZTA0NWUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-04-07 01:41:37');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-25 12:58:33
