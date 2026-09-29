/*
 Navicat Premium Data Transfer

 Source Server         : sql
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : songam_restaurant

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 28/09/2026 17:17:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for food_ingredients
-- ----------------------------
DROP TABLE IF EXISTS `food_ingredients`;
CREATE TABLE `food_ingredients`  (
  `food_id` int UNSIGNED NOT NULL,
  `material_id` int UNSIGNED NOT NULL,
  `quantity` decimal(11, 3) NOT NULL,
  `unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`food_id`, `material_id`) USING BTREE,
  INDEX `material_id`(`material_id` ASC) USING BTREE,
  CONSTRAINT `food_ingredients_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `foods` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `food_ingredients_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food_ingredients
-- ----------------------------
INSERT INTO `food_ingredients` VALUES (2, 1, 123.000, 'kg');
INSERT INTO `food_ingredients` VALUES (2, 2, 10.000, 'g');
INSERT INTO `food_ingredients` VALUES (3, 1, 214.000, 'kg');
INSERT INTO `food_ingredients` VALUES (4, 1, 3.000, 'kg');
INSERT INTO `food_ingredients` VALUES (5, 1, 32.000, 'kg');
INSERT INTO `food_ingredients` VALUES (6, 1, 3.000, 'kg');
INSERT INTO `food_ingredients` VALUES (10, 2, 333.009, 'g');
INSERT INTO `food_ingredients` VALUES (14, 1, 32.000, 'kg');
INSERT INTO `food_ingredients` VALUES (15, 1, 213.997, 'kg');
INSERT INTO `food_ingredients` VALUES (16, 1, 122.997, 'kg');
INSERT INTO `food_ingredients` VALUES (17, 1, 123.000, 'kg');
INSERT INTO `food_ingredients` VALUES (18, 1, 123.000, 'kg');

-- ----------------------------
-- Table structure for foods
-- ----------------------------
DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `serving_price` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foods
-- ----------------------------
INSERT INTO `foods` VALUES (2, 'beaf food', 10.000, 'USD');
INSERT INTO `foods` VALUES (3, '12', 142.000, 'USD');
INSERT INTO `foods` VALUES (4, '22', 2.998, 'USD');
INSERT INTO `foods` VALUES (5, '3', 3.000, 'USD');
INSERT INTO `foods` VALUES (6, '32', 31.998, 'USD');
INSERT INTO `foods` VALUES (10, '324', 33.000, 'USD');
INSERT INTO `foods` VALUES (14, '235', 32.000, 'KRW');
INSERT INTO `foods` VALUES (15, '46545', 123.998, 'USD');
INSERT INTO `foods` VALUES (16, '1233', 123.000, 'KRW');
INSERT INTO `foods` VALUES (17, '123123', 123.000, 'KRW');
INSERT INTO `foods` VALUES (18, '3434', 123.000, 'USD');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  `unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unit_cost` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `goods_categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (2, 'beer', 2, 'L', 1.000, 'USD');

-- ----------------------------
-- Table structure for goods_categories
-- ----------------------------
DROP TABLE IF EXISTS `goods_categories`;
CREATE TABLE `goods_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_categories
-- ----------------------------
INSERT INTO `goods_categories` VALUES (2, 'drink');

-- ----------------------------
-- Table structure for goods_import_items
-- ----------------------------
DROP TABLE IF EXISTS `goods_import_items`;
CREATE TABLE `goods_import_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `import_id` int UNSIGNED NOT NULL,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` decimal(11, 3) NOT NULL,
  `total_cost` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `goods_id` int UNSIGNED NULL DEFAULT NULL,
  `category_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `import_id`(`import_id` ASC) USING BTREE,
  INDEX `fk_goods_import_item_goods`(`goods_id` ASC) USING BTREE,
  CONSTRAINT `fk_goods_import_item_goods` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `goods_import_items_ibfk_1` FOREIGN KEY (`import_id`) REFERENCES `goods_imports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_import_items
-- ----------------------------
INSERT INTO `goods_import_items` VALUES (4, 3, 'beer', 90.000, 234.000, 'USD', 2, 'drink', 'L');
INSERT INTO `goods_import_items` VALUES (6, 5, 'beer', 45.000, 45.000, 'USD', 2, 'drink', 'L');

-- ----------------------------
-- Table structure for goods_imports
-- ----------------------------
DROP TABLE IF EXISTS `goods_imports`;
CREATE TABLE `goods_imports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `imported_on` date NOT NULL,
  `recorded_by` int UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_imports
-- ----------------------------
INSERT INTO `goods_imports` VALUES (3, '2026-09-27', 1, '2026-09-27 15:29:24');
INSERT INTO `goods_imports` VALUES (5, '2026-09-27', 1, '2026-09-27 15:36:19');

-- ----------------------------
-- Table structure for goods_usage
-- ----------------------------
DROP TABLE IF EXISTS `goods_usage`;
CREATE TABLE `goods_usage`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `goods_id` int UNSIGNED NOT NULL,
  `used_on` date NOT NULL,
  `quantity` decimal(11, 3) NOT NULL,
  `unit_cost` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'USD',
  `note` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `recorded_by` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `used_on`(`used_on` ASC, `goods_id` ASC) USING BTREE,
  INDEX `goods_id`(`goods_id` ASC) USING BTREE,
  CONSTRAINT `goods_usage_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_usage
-- ----------------------------

-- ----------------------------
-- Table structure for management_lock
-- ----------------------------
DROP TABLE IF EXISTS `management_lock`;
CREATE TABLE `management_lock`  (
  `id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of management_lock
-- ----------------------------
INSERT INTO `management_lock` VALUES (1);

-- ----------------------------
-- Table structure for material_categories
-- ----------------------------
DROP TABLE IF EXISTS `material_categories`;
CREATE TABLE `material_categories`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_categories
-- ----------------------------
INSERT INTO `material_categories` VALUES (1, 'meat');
INSERT INTO `material_categories` VALUES (2, 'vegetable');

-- ----------------------------
-- Table structure for material_import_items
-- ----------------------------
DROP TABLE IF EXISTS `material_import_items`;
CREATE TABLE `material_import_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `import_id` int UNSIGNED NOT NULL,
  `material_id` int UNSIGNED NOT NULL,
  `material_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` decimal(11, 3) NOT NULL,
  `unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_cost` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `import_id`(`import_id` ASC) USING BTREE,
  INDEX `material_id`(`material_id` ASC) USING BTREE,
  CONSTRAINT `material_import_items_ibfk_1` FOREIGN KEY (`import_id`) REFERENCES `material_imports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `material_import_items_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_import_items
-- ----------------------------
INSERT INTO `material_import_items` VALUES (3, 2, 1, 'beaf', 123.000, 'g', 123.000, 'KRW');
INSERT INTO `material_import_items` VALUES (4, 2, 1, 'beaf', 123.000, 'g', 123.000, 'USD');

-- ----------------------------
-- Table structure for material_imports
-- ----------------------------
DROP TABLE IF EXISTS `material_imports`;
CREATE TABLE `material_imports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `imported_on` date NOT NULL,
  `recorded_by` int UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_imports
-- ----------------------------
INSERT INTO `material_imports` VALUES (2, '2026-09-27', 1, '2026-09-27 10:03:32');

-- ----------------------------
-- Table structure for material_usage
-- ----------------------------
DROP TABLE IF EXISTS `material_usage`;
CREATE TABLE `material_usage`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `material_id` int UNSIGNED NOT NULL,
  `used_on` date NOT NULL,
  `quantity` decimal(11, 3) NOT NULL,
  `unit_cost` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'USD',
  `note` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `recorded_by` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `used_on`(`used_on` ASC, `material_id` ASC) USING BTREE,
  INDEX `material_id`(`material_id` ASC) USING BTREE,
  CONSTRAINT `material_usage_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_usage
-- ----------------------------

-- ----------------------------
-- Table structure for materials
-- ----------------------------
DROP TABLE IF EXISTS `materials`;
CREATE TABLE `materials`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  `unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unit_cost` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `material_categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of materials
-- ----------------------------
INSERT INTO `materials` VALUES (1, 'beaf', 1, 'kg', 200.000, 'USD');
INSERT INTO `materials` VALUES (2, 'garlic', 2, 'g', 10000.000, 'USD');
INSERT INTO `materials` VALUES (4, 'rsg', 1, 'kg', 3000.000, 'USD');

-- ----------------------------
-- Table structure for sales_export_items
-- ----------------------------
DROP TABLE IF EXISTS `sales_export_items`;
CREATE TABLE `sales_export_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `export_id` int UNSIGNED NOT NULL,
  `item_type` enum('food','goods') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `food_id` int UNSIGNED NULL DEFAULT NULL,
  `goods_id` int UNSIGNED NULL DEFAULT NULL,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` decimal(11, 3) NOT NULL,
  `unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unit_price` decimal(11, 3) NOT NULL,
  `price_unit` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_price` decimal(11, 3) NOT NULL,
  `currency` enum('USD','KRW') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `export_id`(`export_id` ASC) USING BTREE,
  INDEX `food_id`(`food_id` ASC) USING BTREE,
  INDEX `goods_id`(`goods_id` ASC) USING BTREE,
  CONSTRAINT `sales_export_items_ibfk_1` FOREIGN KEY (`export_id`) REFERENCES `sales_exports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sales_export_items_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `foods` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `sales_export_items_ibfk_3` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales_export_items
-- ----------------------------
INSERT INTO `sales_export_items` VALUES (9, 5, 'food', 16, NULL, '1233', 2.000, 'serving', 123.000, 'serving', 246.000, 'KRW');
INSERT INTO `sales_export_items` VALUES (10, 5, 'food', 17, NULL, '123123', 18.000, 'serving', 123.000, 'serving', 2214.000, 'KRW');

-- ----------------------------
-- Table structure for sales_exports
-- ----------------------------
DROP TABLE IF EXISTS `sales_exports`;
CREATE TABLE `sales_exports`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `exported_on` date NOT NULL,
  `export_type` enum('food','goods') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `recorded_by` int UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales_exports
-- ----------------------------
INSERT INTO `sales_exports` VALUES (5, '2026-09-27', 'food', 1, '2026-09-27 15:51:53');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `token_hash` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`token_hash`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Table structure for user_abilities
-- ----------------------------
DROP TABLE IF EXISTS `user_abilities`;
CREATE TABLE `user_abilities`  (
  `user_id` int UNSIGNED NOT NULL,
  `abilities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `user_abilities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_abilities
-- ----------------------------
INSERT INTO `user_abilities` VALUES (1, '[\"users\", \"materials\", \"food\", \"imports\", \"exports\", \"goods\"]');

-- ----------------------------
-- Table structure for user_logs
-- ----------------------------
DROP TABLE IF EXISTS `user_logs`;
CREATE TABLE `user_logs`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `actor` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `subject` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_logs
-- ----------------------------
INSERT INTO `user_logs` VALUES (1, 'Local setup', 'Created user', 'manager@example.com', '2026-09-27 05:10:01');
INSERT INTO `user_logs` VALUES (2, 'manager@example.com', 'Updated user', 'rsg@email.com', '2026-09-27 05:12:40');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job` enum('cooker','manager','worker','servicer','guider') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `birthday` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'rsg', 'rsg@email.com', '6d382eecccb774c12598f8301300815b:3c7046070756331f162eeb513b9dffe8f9cb01906ec30b5e4ca8324ddc3b379b5b6a6cf7702c0092422a846201dbf910e78dd6b5317eb12586d09b6a00ced83a', 'manager', '2006-01-17');

SET FOREIGN_KEY_CHECKS = 1;
