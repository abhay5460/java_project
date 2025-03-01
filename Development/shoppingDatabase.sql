/*
SQLyog Ultimate v11.11 (32 bit)
MySQL - 5.1.44-community : Database - db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(2) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) NOT NULL,
  `admin_email` varchar(60) NOT NULL,
  `admin_password` varchar(53) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `admin` */

insert  into `admin`(`admin_id`,`admin_name`,`admin_email`,`admin_password`) values (1,'Rajesh Kumar','rajesh.kumar@gmail.com','password123'),(2,'Anita Sharma','anita.sharma@gmail.com','password456'),(3,'Vikram Patel','vikrampatel@gmail.com','password789');

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `cart_ibfk_1` (`user_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `cart` */

insert  into `cart`(`cart_id`,`user_id`) values (1,1),(2,2),(3,3),(4,4),(5,5),(7,8),(9,22),(8,28);

/*Table structure for table `cart_items` */

DROP TABLE IF EXISTS `cart_items`;

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `cart_items_ibfk_1` (`cart_id`),
  KEY `cart_items_ibfk_2` (`product_id`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`Product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `cart_items` */

insert  into `cart_items`(`cart_item_id`,`cart_id`,`product_id`,`quantity`) values (1,1,1,2),(2,1,2,1),(8,1,1,2),(9,1,2,1),(37,8,1,1),(38,9,18,1);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `discount_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_ibfk_1` (`discount_id`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`discount_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`,`description`,`discount_id`) values (1,'BerriesFruits','Fresh and juicy berries including strawberries, blueberries, and raspberries.',1),(5,'Melons','Refreshing melons like watermelon, cantaloupe, and honeydew.',5),(6,'Apples','Crisp and sweet apples, perfect for snacking.',6),(8,'DryFruits','Healthy Choice for you body and It is Organic Farmed Based Fruits',6);

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `user_id` int(100) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(70) NOT NULL,
  `phoneno` varchar(40) NOT NULL,
  `address` text,
  `registrationdate` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

/*Data for the table `customer` */

insert  into `customer`(`user_id`,`firstname`,`lastname`,`email`,`password`,`phoneno`,`address`,`registrationdate`) values (1,'Aarav','Munna','aarav.singh@example.com','Abh@45678','9876543324','123 Main St, City, Country','2025-02-24 17:46:07'),(2,'Aditi','Sharma','aditi.sharma@example.com','password123','9876543211','456 Main St, City, Country','2025-02-24 17:46:07'),(3,'Rohan','Patel','rohan.patel@example.com','password123','9876543212','789 Main St, City, Country','2025-02-24 17:46:07'),(4,'Sneha','Gupta','sneha.gupta@example.com','password123','9876543213','101 Main St, City, Country','2025-02-24 17:46:07'),(5,'Karan','Verma','karan.verma@example.com','password123','9876543214','112 Main St, City, Country','2025-02-24 17:46:07'),(6,'Meera','Reddy','meera.reddy@example.com','password123','9876543215','134 Main St, City, Country','2025-02-24 17:46:07'),(7,'Vikas','Mehta','vikas.mehta@example.com','password123','9876543216','156 Main St, City, Country','2025-02-24 17:46:07'),(8,'Abhay','gajjar','gajjarabhay82@gmail.com','Gajjar@123','8799149397','rayka nagar','2025-02-24 23:06:47'),(22,'Sunil','Khatri','Sunil@gmail.com','Sunil@345','1234567890','Dandya Pur','2025-02-25 00:00:00'),(26,'krishna','gajjar','krishna2@gmail.com','Krishna@123','1234567890','nagar','2025-02-25 00:00:00'),(28,'Dhairya','gajjar','dhairyathakkar47@gmail.com','Dha@123456','2849219428','tikala','2025-02-28 00:00:00');

/*Table structure for table `discount` */

DROP TABLE IF EXISTS `discount`;

CREATE TABLE `discount` (
  `discount_id` int(4) NOT NULL AUTO_INCREMENT,
  `discount_name` varchar(50) NOT NULL,
  `discount_type` varchar(50) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`discount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `discount` */

insert  into `discount`(`discount_id`,`discount_name`,`discount_type`,`percentage`,`start_date`,`end_date`,`status`) values (1,'Summer Sale','Seasonal',10.00,'2023-06-01 00:00:00','2023-08-31 23:59:59','Active'),(2,'Winter Discount','Seasonal',15.00,'2023-12-01 00:00:00','2023-12-31 23:59:59','Active'),(3,'New Year Offer','Holiday',20.00,'2023-12-25 00:00:00','2024-01-01 23:59:59','Active'),(4,'Fruit Fiesta','Promotional',5.00,'2023-07-01 00:00:00','2023-07-15 23:59:59','Active'),(5,'Back to School','Seasonal',10.00,'2023-08-01 00:00:00','2023-09-30 23:59:59','Active'),(6,'Weekend Special','Weekly',25.00,'2023-09-01 00:00:00','2023-09-03 23:59:59','Active'),(7,'Clearance Sale','Promotional',30.00,'2023-10-01 00:00:00','2023-10-31 23:59:59','Active');

/*Table structure for table `order_details` */

DROP TABLE IF EXISTS `order_details`;

CREATE TABLE `order_details` (
  `Order_Details_id` int(11) NOT NULL AUTO_INCREMENT,
  `Order_id` int(4) DEFAULT NULL,
  `Product_id` int(10) DEFAULT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Order_Details_id`),
  KEY `FK_Order` (`Order_id`),
  KEY `FK_Product` (`Product_id`),
  CONSTRAINT `FK_Order` FOREIGN KEY (`Order_id`) REFERENCES `orders` (`Order_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Product` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `order_details` */

insert  into `order_details`(`Order_Details_id`,`Order_id`,`Product_id`,`Quantity`,`Price`) values (1,1,1,2,7.98),(2,1,2,1,4.99),(8,1,1,2,7.98),(9,1,2,1,4.99);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `Order_id` int(10) NOT NULL AUTO_INCREMENT,
  `User_id` int(10) NOT NULL,
  `Order_Date` datetime NOT NULL,
  `Total_Amount` decimal(10,2) NOT NULL,
  `Status` varchar(20) NOT NULL,
  PRIMARY KEY (`Order_id`),
  KEY `User_id` (`User_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `customer` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

insert  into `orders`(`Order_id`,`User_id`,`Order_Date`,`Total_Amount`,`Status`) values (1,1,'2025-02-24 15:30:00',199.99,'Processing'),(2,2,'2025-02-24 16:00:00',299.99,'Shipped'),(3,3,'2025-02-24 16:30:00',399.99,'Delivered'),(4,4,'2025-02-24 17:00:00',99.99,'Cancelled'),(5,5,'2025-02-24 17:30:00',149.99,'Returned');

/*Table structure for table `payment` */

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `Payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `Order_id` int(11) DEFAULT NULL,
  `Payment_Method` varchar(30) NOT NULL,
  `Payment_amount` int(11) NOT NULL,
  `Payment_date` date NOT NULL,
  `Payment_status` varchar(20) NOT NULL,
  `Transaction_id` int(11) NOT NULL,
  PRIMARY KEY (`Payment_id`),
  KEY `Order_id` (`Order_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Order_id`) REFERENCES `orders` (`Order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `payment` */

insert  into `payment`(`Payment_id`,`Order_id`,`Payment_Method`,`Payment_amount`,`Payment_date`,`Payment_status`,`Transaction_id`) values (1,1,'Credit Card',1500,'2023-10-01','Completed',100001),(2,2,'PayPal',2500,'2023-10-02','Completed',100002),(3,3,'Debit Card',1200,'2023-10-03','Pending',100003),(4,4,'Bank Transfer',3000,'2023-10-04','Failed',100004),(5,5,'Credit Card',1800,'2023-10-05','Completed',100005);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `Product_id` int(10) NOT NULL AUTO_INCREMENT,
  `Product_name` varchar(30) NOT NULL,
  `Category_id` int(10) NOT NULL,
  `Description` text NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `StockQuantity` int(5) NOT NULL,
  `ImageURL` varchar(255) NOT NULL,
  PRIMARY KEY (`Product_id`),
  KEY `product_ibfk_1` (`Category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`Category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `product` */

insert  into `product`(`Product_id`,`Product_name`,`Category_id`,`Description`,`Price`,`StockQuantity`,`ImageURL`) values (1,'Strawberries',1,'Fresh strawberries, perfect for desserts and smoothies.',3.99,100,'assets\\images\\strawberries.jpg'),(2,'Blueberries',1,'Organic blueberries, rich in antioxidants.',4.99,80,'assets\\images\\blueberries.jpg'),(13,'Anjir',8,'It is Dry Fruits Product For healthy for your body.',20.00,100,'assets/images/anjir.jpg'),(14,'Badam',8,'It is Dry Fruit for healthy for your Heart attack , hair and muscles.',10.00,3000,'assets/images/badam.jpg'),(15,'kaju',8,'kaju is Dry Fruit for jealthy for your leg. ',7.00,2000,'assets/images/kaju.jpg'),(16,'green_apples',6,'green apples is very healthy for your brain.',30.00,200,'assets/images/green_apples.jpg'),(17,'peaches',6,'peaches is red apples healthy for your skkin.',20.00,200,'assets/images/peaches.jpg'),(18,'lemons',5,'lemon is very healthy your fit body.',20.00,100,'assets/images/lemons.jpg'),(19,'Anar',1,'Anar is very healthy for your special teeth.',30.00,300,'assets/images/anar.jpg'),(20,'watermelom',1,'watermelon is very good fruits.',30.00,50,'assets/images/watermelon.jpg');

/*Table structure for table `review` */

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `Review_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `Rating` int(11) NOT NULL,
  `Description` text NOT NULL,
  `Review_Date` datetime NOT NULL,
  PRIMARY KEY (`Review_id`),
  KEY `review_ibfk_1` (`product_id`),
  KEY `review_ibfk_2` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`Product_id`) ON DELETE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `customer` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `review` */

insert  into `review`(`Review_id`,`product_id`,`user_id`,`Rating`,`Description`,`Review_Date`) values (1,1,1,5,'Absolutely delicious! The strawberries are fresh and sweet.','2023-06-15 10:30:00'),(2,1,2,4,'Great strawberries, but a bit pricey.','2023-06-16 11:00:00'),(3,2,1,5,'These blueberries are the best I have ever tasted!','2023-06-17 12:15:00'),(8,1,1,5,'Absolutely delicious! The strawberries are fresh and sweet.','2023-06-15 10:30:00'),(9,1,2,4,'Great strawberries, but a bit pricey.','2023-06-16 11:00:00'),(10,2,1,5,'These blueberries are the best I have ever tasted!','2023-06-17 12:15:00');

/*Table structure for table `shipping` */

DROP TABLE IF EXISTS `shipping`;

CREATE TABLE `shipping` (
  `Shipping_id` int(11) NOT NULL AUTO_INCREMENT,
  `Order_id` int(11) DEFAULT NULL,
  `Shipping_address` text NOT NULL,
  `Shipping_status` varchar(30) NOT NULL,
  `Tracking_Number` varchar(40) NOT NULL,
  PRIMARY KEY (`Shipping_id`),
  KEY `Order_id` (`Order_id`),
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`Order_id`) REFERENCES `orders` (`Order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `shipping` */

insert  into `shipping`(`Shipping_id`,`Order_id`,`Shipping_address`,`Shipping_status`,`Tracking_Number`) values (1,1,'123 Main St, Springfield, IL','Pending','TRACK123456'),(2,2,'456 Elm St, Springfield, IL','Shipped','TRACK123457'),(3,3,'789 Oak St, Springfield, IL','Delivered','TRACK123458'),(4,4,'321 Pine St, Springfield, IL','Pending','TRACK123459'),(5,5,'654 Maple St, Springfield, IL','Delivered','TRACK123460');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
