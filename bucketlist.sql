/*
SQLyog Community v13.0.0 (64 bit)
MySQL - 10.1.34-MariaDB : Database - bucketlist
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bucketlist` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bucketlist`;

/*Table structure for table `tbl_user` */

DROP TABLE IF EXISTS `tbl_user`;

CREATE TABLE `tbl_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) DEFAULT NULL,
  `user_username` varchar(255) DEFAULT NULL,
  `user_password` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_user` */

insert  into `tbl_user`(`user_id`,`user_name`,`user_username`,`user_password`) values 
(7,'test','test@gmail.com','pbkdf2:sha256:50000$XJtoOwi4$b9d2eb7cb6c105c75b418a58a53857d6e1f10da992cf5ae350206e1e9a89cad9');

/*Table structure for table `tbl_wish` */

DROP TABLE IF EXISTS `tbl_wish`;

CREATE TABLE `tbl_wish` (
  `wish_id` int(11) NOT NULL AUTO_INCREMENT,
  `wish_title` varchar(45) DEFAULT NULL,
  `wish_description` varchar(5000) DEFAULT NULL,
  `wish_user_id` int(11) DEFAULT NULL,
  `wish_date` datetime DEFAULT NULL,
  PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_wish` */

insert  into `tbl_wish`(`wish_id`,`wish_title`,`wish_description`,`wish_user_id`,`wish_date`) values 
(3,'First Wish','This is my first wish',7,'2019-02-04 11:44:33'),
(4,'My second Wish','This is my second wish',7,'2019-02-04 11:46:18'),
(5,'Third Wish','This is my 3rd wish',7,'2019-02-04 11:54:06'),
(6,'My fourth wish','This is my fourth wish',7,'2019-02-04 20:37:48'),
(7,'My fiifth wish','This is my fifth wish',7,'2019-02-05 09:39:23'),
(8,'Sixth','Sixth',7,'2019-02-05 11:17:53'),
(9,'Seventh','Seventh',7,'2019-02-05 11:18:02'),
(10,'Eighth','Eighth',7,'2019-02-05 11:18:14'),
(11,'Nineth','Nineth',7,'2019-02-05 11:18:24'),
(12,'Tenth','Tenth',7,'2019-02-05 11:18:31');

/* Procedure structure for procedure `sp_addWish` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_addWish` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addWish`(
    IN p_title varchar(45),
    IN p_description varchar(1000),
    IN p_user_id bigint
)
BEGIN
    insert into tbl_wish(
        wish_title,
        wish_description,
        wish_user_id,
        wish_date
    )
    values
    (
        p_title,
        p_description,
        p_user_id,
        NOW()
    );
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_createUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_createUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
    IN p_name VARCHAR(20),
    IN p_username VARCHAR(45),
    IN p_password VARCHAR(255)
)
BEGIN
    if ( select exists (select 1 from tbl_user where user_username = p_username) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into tbl_user
        (
            user_name,
            user_username,
            user_password
        )
        values
        (
            p_name,
            p_username,
            p_password
        );
     
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_deleteWish` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_deleteWish` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteWish`(
IN p_wish_id bigint,
IN p_user_id bigint
)
BEGIN
delete from tbl_wish where wish_id = p_wish_id and wish_user_id = p_user_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_GetWishById` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_GetWishById` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetWishById`(
IN p_wish_id bigint,
In p_user_id bigint
)
BEGIN
select * from tbl_wish where wish_id = p_wish_id and wish_user_id = p_user_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_GetWishByUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_GetWishByUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetWishByUser`(
IN p_user_id bigint
)
BEGIN
    select * from tbl_wish where wish_user_id = p_user_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_updateWish` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_updateWish` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateWish`(
IN p_title varchar(45),
IN p_description varchar(1000),
IN p_wish_id bigint,
In p_user_id bigint
)
BEGIN
update tbl_wish set wish_title = p_title,wish_description = p_description
    where wish_id = p_wish_id and wish_user_id = p_user_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_validateLogin` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_validateLogin` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateLogin`(
IN p_username VARCHAR(45)
)
BEGIN
    select * from tbl_user where user_username = p_username;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
