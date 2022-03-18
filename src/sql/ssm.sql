/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : ssm

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 18/03/2022 17:57:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 163 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三丰', '123456', '男', 20, '广东', 'access/duitan33g.jpg');
INSERT INTO `user` VALUES (2, '李四', '123456', '男', 30, '天津市', 'access/itc.jpg');
INSERT INTO `user` VALUES (3, '王五', '123456', '男', 11, '陕西', NULL);
INSERT INTO `user` VALUES (5, '赵六六', '123456', '男', 23, '南昌市', NULL);
INSERT INTO `user` VALUES (7, '张老三', '123456', '男', 30, '福建', '');
INSERT INTO `user` VALUES (8, '李黑水', '123456', '男', 30, '中国', 'access/doubanio.jpg');
INSERT INTO `user` VALUES (10, '叶凡', '123456', '男', 20, '大陆', 'access/duitang.jpg');
INSERT INTO `user` VALUES (13, '斗战胜佛', '123456', '男', 30, '大陆', 'access/');
INSERT INTO `user` VALUES (15, '黑黄', '123456', '女', 8, '地址8', 'access/');
INSERT INTO `user` VALUES (16, '名字9', '123456', '女', 9, '地址9', NULL);
INSERT INTO `user` VALUES (17, '名字10', '123456', '男', 10, '地址10', NULL);
INSERT INTO `user` VALUES (18, '名字11', '123456', '女', 11, '地址11', NULL);
INSERT INTO `user` VALUES (19, '名字12', '123456', '男', 12, '地址12', NULL);
INSERT INTO `user` VALUES (20, '名字13', '123456', '女', 13, '地址13', NULL);
INSERT INTO `user` VALUES (21, '名字14', '123456', '男', 14, '地址14', NULL);
INSERT INTO `user` VALUES (22, '名字15', '123456', '女', 15, '地址15', NULL);
INSERT INTO `user` VALUES (23, '名字16', '123456', '男', 16, '地址16', NULL);
INSERT INTO `user` VALUES (24, '名字17', '123456', '女', 17, '地址17', NULL);
INSERT INTO `user` VALUES (25, '名字18', '123456', '男', 18, '地址18', NULL);
INSERT INTO `user` VALUES (26, '名字19', '123456', '女', 19, '地址19', NULL);
INSERT INTO `user` VALUES (27, '名字20', '123456', '男', 20, '地址20', NULL);
INSERT INTO `user` VALUES (28, '名字21', '123456', '女', 21, '地址21', NULL);
INSERT INTO `user` VALUES (29, '名字22', '123456', '男', 22, '地址22', NULL);
INSERT INTO `user` VALUES (30, '名字23', '123456', '女', 23, '地址23', NULL);
INSERT INTO `user` VALUES (31, '名字24', '123456', '男', 24, '地址24', NULL);
INSERT INTO `user` VALUES (32, '名字25', '123456', '女', 25, '地址25', NULL);
INSERT INTO `user` VALUES (33, '名字26', '123456', '男', 26, '地址26', NULL);
INSERT INTO `user` VALUES (34, '名字27', '123456', '女', 27, '地址27', NULL);
INSERT INTO `user` VALUES (35, '名字28', '123456', '男', 28, '地址28', NULL);
INSERT INTO `user` VALUES (36, '名字29', '123456', '女', 29, '地址29', NULL);
INSERT INTO `user` VALUES (37, '名字30', '123456', '男', 30, '地址30', NULL);
INSERT INTO `user` VALUES (38, '名字31', '123456', '女', 31, '地址31', NULL);
INSERT INTO `user` VALUES (39, '名字32', '123456', '男', 32, '地址32', NULL);
INSERT INTO `user` VALUES (40, '名字33', '123456', '女', 33, '地址33', NULL);
INSERT INTO `user` VALUES (41, '名字34', '123456', '男', 34, '地址34', NULL);
INSERT INTO `user` VALUES (42, '名字35', '123456', '女', 35, '地址35', NULL);
INSERT INTO `user` VALUES (43, '名字36', '123456', '男', 36, '地址36', NULL);
INSERT INTO `user` VALUES (44, '名字37', '123456', '女', 37, '地址37', NULL);
INSERT INTO `user` VALUES (45, '名字38', '123456', '男', 38, '地址38', NULL);
INSERT INTO `user` VALUES (46, '名字39', '123456', '女', 39, '地址39', NULL);
INSERT INTO `user` VALUES (47, '名字40', '123456', '男', 40, '地址40', NULL);
INSERT INTO `user` VALUES (48, '名字41', '123456', '女', 41, '地址41', NULL);
INSERT INTO `user` VALUES (49, '名字42', '123456', '男', 42, '地址42', NULL);
INSERT INTO `user` VALUES (50, '名字43', '123456', '女', 43, '地址43', NULL);
INSERT INTO `user` VALUES (51, '名字44', '123456', '男', 44, '地址44', NULL);
INSERT INTO `user` VALUES (52, '名字45', '123456', '女', 45, '地址45', NULL);
INSERT INTO `user` VALUES (53, '名字46', '123456', '男', 46, '地址46', NULL);
INSERT INTO `user` VALUES (54, '名字47', '123456', '女', 47, '地址47', NULL);
INSERT INTO `user` VALUES (55, '名字48', '123456', '男', 48, '地址48', NULL);
INSERT INTO `user` VALUES (58, '刘云', '123456', '男', 26, '陕西', NULL);
INSERT INTO `user` VALUES (155, '唐僧', '123456', '男', 30, '东土大唐', 'access/upload/76273abae7a9d545cf46368929162268.jpeg');
INSERT INTO `user` VALUES (156, '路飞', '123456', '男', 20, '哥亚王国风车村', 'access/upload/027c9d1de4e2ac430ccc1bcd3f473266.jpeg');
INSERT INTO `user` VALUES (157, '索隆', '123456', '男', 20, '霜月村', NULL);
INSERT INTO `user` VALUES (158, '娜美', '123456', '女', 20, '欧伊科特王国', NULL);
INSERT INTO `user` VALUES (159, '唐僧', '123456', '男', 30, '东土大唐', 'access/upload/08a73c5c3b911d1d592af49c29c6906f.jpeg');
INSERT INTO `user` VALUES (160, '路飞', '123456', '男', 20, '哥亚王国风车村', 'access/upload/ee8c14dbdc59f8db38d28ffbc1898729.jpeg');
INSERT INTO `user` VALUES (161, '索隆', '123456', '男', 20, '霜月村', NULL);

SET FOREIGN_KEY_CHECKS = 1;
