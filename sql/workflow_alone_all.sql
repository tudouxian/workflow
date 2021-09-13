/*
 Navicat Premium Data Transfer

 Source Server         : localhost本机
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost:3306
 Source Schema         : workflow_alone

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 13/09/2021 11:53:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for act_cmmn_casedef
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_casedef`;
CREATE TABLE `act_cmmn_casedef`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` bit(1) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `HAS_START_FORM_KEY_` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_CASE_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE,
  INDEX `ACT_IDX_CASE_DEF_DPLY`(`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_CASE_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangelog`;
CREATE TABLE `act_cmmn_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DATEEXECUTED` datetime(0) NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_databasechangelog
-- ----------------------------
INSERT INTO `act_cmmn_databasechangelog` VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:33', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:34', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:34', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:34', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 5, 'EXECUTED', '8:70349de472f87368dcdec971a10311a0', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 6, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 7, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 8, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 9, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 10, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:35', 11, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:36', 12, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2021-09-03 10:17:36', 13, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.3.5', NULL, NULL, '0664252818');

-- ----------------------------
-- Table structure for act_cmmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangeloglock`;
CREATE TABLE `act_cmmn_databasechangeloglock`  (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_databasechangeloglock
-- ----------------------------
INSERT INTO `act_cmmn_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_cmmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment`;
CREATE TABLE `act_cmmn_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment_resource`;
CREATE TABLE `act_cmmn_deployment_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  `GENERATED_` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_CMMN_RSRC_DPL`(`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_CMMN_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_hi_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_case_inst`;
CREATE TABLE `act_cmmn_hi_case_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_hi_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_mil_inst`;
CREATE TABLE `act_cmmn_hi_mil_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_hi_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_plan_item_inst`;
CREATE TABLE `act_cmmn_hi_plan_item_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_STAGE_` bit(1) NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ITEM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ITEM_DEFINITION_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_AVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_ENABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_DISABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_STARTED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_SUSPENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `COMPLETED_TIME_` datetime(3) NULL DEFAULT NULL,
  `OCCURRED_TIME_` datetime(3) NULL DEFAULT NULL,
  `TERMINATED_TIME_` datetime(3) NULL DEFAULT NULL,
  `EXIT_TIME_` datetime(3) NULL DEFAULT NULL,
  `ENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `ENTRY_CRITERION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `EXIT_CRITERION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SHOW_IN_OVERVIEW_` bit(1) NULL DEFAULT NULL,
  `EXTRA_VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DERIVED_CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_case_inst`;
CREATE TABLE `act_cmmn_ru_case_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `LOCK_TIME_` datetime(3) NULL DEFAULT NULL,
  `IS_COMPLETEABLE_` bit(1) NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_CASE_INST_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
  INDEX `ACT_IDX_CASE_INST_PARENT`(`PARENT_ID_`) USING BTREE,
  INDEX `ACT_IDX_CASE_INST_REF_ID_`(`REFERENCE_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_CASE_INST_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_mil_inst`;
CREATE TABLE `act_cmmn_ru_mil_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_MIL_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
  INDEX `ACT_IDX_MIL_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_MIL_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MIL_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_plan_item_inst`;
CREATE TABLE `act_cmmn_ru_plan_item_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_STAGE_` bit(1) NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `ITEM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ITEM_DEFINITION_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_COMPLETEABLE_` bit(1) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` bit(1) NULL DEFAULT NULL,
  `VAR_COUNT_` int(11) NULL DEFAULT NULL,
  `SENTRY_PART_INST_COUNT_` int(11) NULL DEFAULT NULL,
  `LAST_AVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_ENABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_DISABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_STARTED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_SUSPENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `COMPLETED_TIME_` datetime(3) NULL DEFAULT NULL,
  `OCCURRED_TIME_` datetime(3) NULL DEFAULT NULL,
  `TERMINATED_TIME_` datetime(3) NULL DEFAULT NULL,
  `EXIT_TIME_` datetime(3) NULL DEFAULT NULL,
  `ENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `ENTRY_CRITERION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `EXIT_CRITERION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `EXTRA_VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DERIVED_CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_PLAN_ITEM_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
  INDEX `ACT_IDX_PLAN_ITEM_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_PLAN_ITEM_STAGE_INST`(`STAGE_INST_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_sentry_part_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_sentry_part_inst`;
CREATE TABLE `act_cmmn_ru_sentry_part_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REV_` int(11) NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PLAN_ITEM_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ON_PART_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IF_PART_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_SENTRY_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
  INDEX `ACT_IDX_SENTRY_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_SENTRY_PLAN_ITEM`(`PLAN_ITEM_INST_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_SENTRY_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SENTRY_PLAN_ITEM` FOREIGN KEY (`PLAN_ITEM_INST_ID_`) REFERENCES `act_cmmn_ru_plan_item_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_co_content_item
-- ----------------------------
DROP TABLE IF EXISTS `act_co_content_item`;
CREATE TABLE `act_co_content_item`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MIME_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TASK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTENT_STORE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTENT_STORE_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `FIELD_` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTENT_AVAILABLE_` bit(1) NULL DEFAULT b'0',
  `CREATED_` timestamp(6) NULL DEFAULT NULL,
  `CREATED_BY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LAST_MODIFIED_` timestamp(6) NULL DEFAULT NULL,
  `LAST_MODIFIED_BY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTENT_SIZE_` bigint(20) NULL DEFAULT 0,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `idx_contitem_taskid`(`TASK_ID_`) USING BTREE,
  INDEX `idx_contitem_procid`(`PROC_INST_ID_`) USING BTREE,
  INDEX `idx_contitem_scope`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_co_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangelog`;
CREATE TABLE `act_co_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DATEEXECUTED` datetime(0) NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_databasechangelog
-- ----------------------------
INSERT INTO `act_co_databasechangelog` VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2021-09-03 10:17:29', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.3.5', NULL, NULL, '0664249661');
INSERT INTO `act_co_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2021-09-03 10:17:29', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.3.5', NULL, NULL, '0664249661');

-- ----------------------------
-- Table structure for act_co_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangeloglock`;
CREATE TABLE `act_co_databasechangeloglock`  (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_databasechangeloglock
-- ----------------------------
INSERT INTO `act_co_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_dmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangelog`;
CREATE TABLE `act_dmn_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DATEEXECUTED` datetime(0) NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_databasechangelog
-- ----------------------------
INSERT INTO `act_dmn_databasechangelog` VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:28', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:28', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:28', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:28', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('5', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:29', 5, 'EXECUTED', '8:3e03528582dd4eeb4eb41f9b9539140d', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_DMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION; modifyDataType columnName=END_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:29', 6, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:29', 7, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '4.3.5', NULL, NULL, '0664248510');
INSERT INTO `act_dmn_databasechangelog` VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2021-09-03 10:17:29', 8, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.3.5', NULL, NULL, '0664248510');

-- ----------------------------
-- Table structure for act_dmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangeloglock`;
CREATE TABLE `act_dmn_databasechangeloglock`  (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_databasechangeloglock
-- ----------------------------
INSERT INTO `act_dmn_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_dmn_decision
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_decision`;
CREATE TABLE `act_dmn_decision`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `VERSION_` int(11) NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DECISION_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_DMN_DEC_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment`;
CREATE TABLE `act_dmn_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment_resource`;
CREATE TABLE `act_dmn_deployment_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_hi_decision_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_hi_decision_execution`;
CREATE TABLE `act_dmn_hi_decision_execution`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DECISION_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `INSTANCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ACTIVITY_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `FAILED_` bit(1) NULL DEFAULT b'0',
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `EXECUTION_JSON_` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log`  (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DATA_` longblob NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) NULL DEFAULT 0,
  PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `BYTES_` longblob NULL,
  `GENERATED_` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_BYTEARR_DEPL`(`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------
INSERT INTO `act_ge_bytearray` VALUES ('2', 1, 'CSQJ.bpmn', '1', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A61637469766974693D22687474703A2F2F61637469766974692E6F72672F62706D6E2220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E61637469766974692E6F72672F74657374223E0A20203C70726F636573732069643D226C6561766522206E616D653D22E8AFB7E581872220697345786563757461626C653D2274727565223E0A202020203C73746172744576656E742069643D2273746172746576656E743122206E616D653D225374617274223E3C2F73746172744576656E743E0A202020203C757365725461736B2069643D22757365727461736B3122206E616D653D22E68F90E4BAA4E4BABA2220666C6F7761626C653A61737369676E65653D22312220666C6F7761626C653A63616E64696461746547726F7570733D222B3131302B223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A2231222C22646570744964223A22313033222C22646570744E616D65223A22E7A094E58F91E983A8E997A8222C22617265614964223A6E756C6C2C22757365724E616D65223A2261646D696E222C226E69636B4E616D65223A22E7AEA1E79086E59198222C22656D61696C223A227279403136332E636F6D222C2270686F6E656E756D626572223A223135383838383838383838222C22736578223A2231222C22737461747573223A2230222C2270617373776F7264223A22243261243130245872634774764753473036502E74636D576F77627575516F6E3338532E42616B6A4B4556756F3461542F4A5A612F58723852664A57227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B227CE8B083E8A7A3E69CBAE69E84E4B8807C225D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D22757365727461736B3322206E616D653D22E69D8EE59B9B2220666C6F7761626C653A61737369676E65653D2235223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A2235222C22646570744964223A22313030222C22646570744E616D65223A22E59F8EE4BA91E7A791E68A80222C22617265614964223A6E756C6C2C22757365724E616D65223A226C697369222C226E69636B4E616D65223A22E69D8EE59B9B222C22656D61696C223A22222C2270686F6E656E756D626572223A223135303131313131313132222C22736578223A2230222C22737461747573223A2230222C2270617373776F7264223A2224326124313024424846506C7A4C484D672E726362483069633049464F324A7758636A6C34772E636C3144416A35796A6F3534662F4F4467352F6F69227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D22757365727461736B3422206E616D653D22E78E8BE4BA942CE8B5B5E585AD2220666C6F7761626C653A61737369676E65653D22362220666C6F7761626C653A63616E64696461746555736572733D22247B75736572436F64657D223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A2236222C22646570744964223A22313030222C22646570744E616D65223A22E59F8EE4BA91E7A791E68A80222C22617265614964223A6E756C6C2C22757365724E616D65223A2277616E677775222C226E69636B4E616D65223A22E78E8BE4BA94222C22656D61696C223A22222C2270686F6E656E756D626572223A223135303131313131313133222C22736578223A2230222C22737461747573223A2230222C2270617373776F7264223A22243261243130243439763867593268466755343530733243533053314F677751694A33513934583164792E77446632354261337A484D474137766F47227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D22757365727461736B3622206E616D653D22E5BCA0E4B8892220666C6F7761626C653A61737369676E65653D2234223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A2234222C22646570744964223A22313030222C22646570744E616D65223A22E59F8EE4BA91E7A791E68A80222C22617265614964223A6E756C6C2C22757365724E616D65223A227A68616E6773616E222C226E69636B4E616D65223A22E5BCA0E4B889222C22656D61696C223A22313131403136332E636F6D222C2270686F6E656E756D626572223A223135303131313131313131222C22736578223A2230222C22737461747573223A2230222C2270617373776F7264223A22243261243130242F704434326D356177322F68574E64715656756173754E6A723375787275305441336C775861664C355773516D5754554971366D6D227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22666C6F77312220736F757263655265663D2273746172746576656E743122207461726765745265663D22757365727461736B31223E3C2F73657175656E6365466C6F773E0A202020203C6578636C7573697665476174657761792069643D226578636C7573697665676174657761793122206E616D653D224578636C75736976652047617465776179222064656661756C743D22666C6F7737223E3C2F6578636C7573697665476174657761793E0A202020203C73657175656E6365466C6F772069643D22666C6F77362220736F757263655265663D22757365727461736B3122207461726765745265663D226578636C75736976656761746577617931223E3C2F73657175656E6365466C6F773E0A202020203C73657175656E6365466C6F772069643D22666C6F773722206E616D653D22E5A4A9E695B0266C743B3D312220736F757263655265663D226578636C7573697665676174657761793122207461726765745265663D22757365727461736B36223E3C2F73657175656E6365466C6F773E0A202020203C73657175656E6365466C6F772069643D22666C6F773822206E616D653D22E5A4A9E695B02667743B312220736F757263655265663D226578636C7573697665676174657761793122207461726765745265663D22757365727461736B33223E0A2020202020203C636F6E646974696F6E45787072657373696F6E207873693A747970653D2274466F726D616C45787072657373696F6E223E3C215B43444154415B247B636F6E646974696F6E5061727365722E7061727365722822247B64617973203E20317D222C657865637574696F6E297D5D5D3E3C2F636F6E646974696F6E45787072657373696F6E3E0A202020203C2F73657175656E6365466C6F773E0A202020203C73657175656E6365466C6F772069643D22666C6F77392220736F757263655265663D22757365727461736B3322207461726765745265663D22757365727461736B34223E3C2F73657175656E6365466C6F773E0A202020203C73657175656E6365466C6F772069643D22666C6F7731302220736F757263655265663D22757365727461736B3622207461726765745265663D22757365727461736B34223E3C2F73657175656E6365466C6F773E0A202020203C706172616C6C656C476174657761792069643D22706172616C6C656C676174657761793122206E616D653D22506172616C6C656C2047617465776179223E3C2F706172616C6C656C476174657761793E0A202020203C73657175656E6365466C6F772069643D22666C6F7731312220736F757263655265663D22757365727461736B3422207461726765745265663D22706172616C6C656C6761746577617931223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D22757365727461736B3722206E616D653D22E99988E4B8832220666C6F7761626C653A61737369676E65653D2238223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A2238222C22646570744964223A22313030222C22646570744E616D65223A22E59F8EE4BA91E7A791E68A80222C22617265614964223A6E756C6C2C22757365724E616D65223A226368656E7169222C226E69636B4E616D65223A22E99988E4B883222C22656D61696C223A22222C2270686F6E656E756D626572223A223135303131313131313135222C22736578223A2230222C22737461747573223A2230222C2270617373776F7264223A22243261243130245A6E2E776F312F646E6B745979646A32454E462E324F6552454E31724B5A49414D4C516F373834793476506843555361577563532E227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22666C6F7731322220736F757263655265663D22706172616C6C656C676174657761793122207461726765745265663D22757365727461736B37223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D22757365727461736B3822206E616D653D22E8B0A2E585AB2220666C6F7761626C653A61737369676E65653D2239223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A2239222C22646570744964223A22313030222C22646570744E616D65223A22E59F8EE4BA91E7A791E68A80222C22617265614964223A6E756C6C2C22757365724E616D65223A227869656261222C226E69636B4E616D65223A22E8B0A2E585AB222C22656D61696C223A22222C2270686F6E656E756D626572223A223135303131313131313136222C22736578223A2230222C22737461747573223A2230222C2270617373776F7264223A22243261243130243147747151327346414E61425057375172426B68732E4D76623573324B614F2F6D377A436450522F58754F6C53434C2F3151645179227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22666C6F7731332220736F757263655265663D22706172616C6C656C676174657761793122207461726765745265663D22757365727461736B38223E3C2F73657175656E6365466C6F773E0A202020203C706172616C6C656C476174657761792069643D22706172616C6C656C676174657761793222206E616D653D22506172616C6C656C2047617465776179223E3C2F706172616C6C656C476174657761793E0A202020203C73657175656E6365466C6F772069643D22666C6F7731342220736F757263655265663D22757365727461736B3722207461726765745265663D22706172616C6C656C6761746577617932223E3C2F73657175656E6365466C6F773E0A202020203C73657175656E6365466C6F772069643D22666C6F7731352220736F757263655265663D22757365727461736B3822207461726765745265663D22706172616C6C656C6761746577617932223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D22757365727461736B3922206E616D653D22E5BE90E4B99D2220666C6F7761626C653A61737369676E65653D223130223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D446174613E3C2F666C6F7761626C653A666F726D446174613E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746555736572733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746555736572733E0A20202020202020203C666C6F7761626C653A69646D43616E64696461746547726F7570733E3C215B43444154415B5B5D5D5D3E3C2F666C6F7761626C653A69646D43616E64696461746547726F7570733E0A20202020202020203C666C6F7761626C653A61737369676E6565547970653E3C215B43444154415B315D5D3E3C2F666C6F7761626C653A61737369676E6565547970653E0A20202020202020203C666C6F7761626C653A69646D41737369676E65653E3C215B43444154415B5B7B22757365724964223A223130222C22646570744964223A22313030222C22646570744E616D65223A22E59F8EE4BA91E7A791E68A80222C22617265614964223A6E756C6C2C22757365724E616D65223A2278756A6975222C226E69636B4E616D65223A22E5BE90E4B99D222C22656D61696C223A22222C2270686F6E656E756D626572223A223135303131313131313137222C22736578223A2230222C22737461747573223A2230222C2270617373776F7264223A22243261243130246F714662645A435533616C7A664679704D412F43612E4A53457759395277616A527370396F6E4B4F79716658504A3466744C514B2E227D5D5D5D3E3C2F666C6F7761626C653A69646D41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22666C6F7731362220736F757263655265663D22706172616C6C656C676174657761793222207461726765745265663D22757365727461736B39223E3C2F73657175656E6365466C6F773E0A202020203C656E644576656E742069643D22656E646576656E743122206E616D653D22456E64223E3C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22666C6F7731372220736F757263655265663D22757365727461736B3922207461726765745265663D22656E646576656E7431223E3C2F73657175656E6365466C6F773E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F6C65617665223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D226C65617665222069643D2242504D4E506C616E655F6C65617665223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2273746172746576656E7431222069643D2242504D4E53686170655F73746172746576656E7431223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233352E30222077696474683D2233352E302220783D2238302E302220793D2236342E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B31222069643D2242504D4E53686170655F757365727461736B31223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223138382E302220793D2235342E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B33222069643D2242504D4E53686170655F757365727461736B33223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223432302E302220793D223130352E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B34222069643D2242504D4E53686170655F757365727461736B34223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223630302E302220793D2235342E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B36222069643D2242504D4E53686170655F757365727461736B36223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223432302E302220793D22382E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D226578636C75736976656761746577617931222069643D2242504D4E53686170655F6578636C75736976656761746577617931223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2234302E30222077696474683D2234302E302220783D223333302E302220793D2236352E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22706172616C6C656C6761746577617931222069643D2242504D4E53686170655F706172616C6C656C6761746577617931223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2234302E30222077696474683D2234302E302220783D223635312E302220793D223234392E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B37222069643D2242504D4E53686170655F757365727461736B37223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223432302E302220793D223139342E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B38222069643D2242504D4E53686170655F757365727461736B38223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223432302E302220793D223239302E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22706172616C6C656C6761746577617932222069643D2242504D4E53686170655F706172616C6C656C6761746577617932223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2234302E30222077696474683D2234302E302220783D223333302E302220793D223234382E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22757365727461736B39222069643D2242504D4E53686170655F757365727461736B39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2235352E30222077696474683D223130352E302220783D223138382E302220793D223233392E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D22656E646576656E7431222069643D2242504D4E53686170655F656E646576656E7431223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233352E30222077696474683D2233352E302220783D2238302E302220793D223234392E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773137222069643D2242504D4E456467655F666C6F773137223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223138382E302220793D223236362E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223131352E302220793D223236362E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773136222069643D2242504D4E456467655F666C6F773136223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223333302E302220793D223236382E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223239332E302220793D223236362E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773135222069643D2242504D4E456467655F666C6F773135223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223432302E302220793D223331372E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335312E302220793D223331372E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335312E302220793D223238372E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773134222069643D2242504D4E456467655F666C6F773134223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223432302E302220793D223232312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223334392E302220793D223232312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335302E302220793D223234382E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773133222069643D2242504D4E456467655F666C6F773133223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223637312E302220793D223238392E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223637312E302220793D223331372E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223532352E302220793D223331372E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773132222069643D2242504D4E456467655F666C6F773132223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223637312E302220793D223234392E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223637312E302220793D223232312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223532352E302220793D223232312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773131222069643D2242504D4E456467655F666C6F773131223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223730352E302220793D2238312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223737352E302220793D2238312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223737352E302220793D223236382E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223639312E302220793D223236392E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F773130222069643D2242504D4E456467655F666C6F773130223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223532352E302220793D2233352E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223635332E302220793D2233352E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223635322E302220793D2235342E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F7739222069643D2242504D4E456467655F666C6F7739223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223532352E302220793D223133322E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223635332E302220793D223133322E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223635322E302220793D223130392E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F7738222069643D2242504D4E456467655F666C6F7738223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335302E302220793D223130352E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335302E302220793D223133322E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223432302E302220793D223133322E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E6473206865696768743D2231342E30222077696474683D223130302E302220783D223336302E302220793D223133392E30223E3C2F6F6D6764633A426F756E64733E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F7737222069643D2242504D4E456467655F666C6F7737223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335302E302220793D2236352E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223335302E302220793D2233322E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223432302E302220793D2233352E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E6473206865696768743D2231342E30222077696474683D223130302E302220783D223335312E302220793D22392E30223E3C2F6F6D6764633A426F756E64733E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F7736222069643D2242504D4E456467655F666C6F7736223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223239332E302220793D2238312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223333302E302220793D2238352E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22666C6F7731222069643D2242504D4E456467655F666C6F7731223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223131352E302220793D2238312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223138382E302220793D2238312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` VALUES ('3', 1, 'CSQJ.leave.png', '1', 0x89504E470D0A1A0A0000000D49484452000003110000016308060000004212868500002C3A4944415478DAEDDD0B945CF57D1F70395189D3B83934C7E9F1495D1FD2D0D44D69DA9E9086E6A4F136A1AEA815836D56A3D995607D0C2A96851136320FA3A33DC20AE691802464C5756B0AF18344AEC0283CF725ED1EA16D040484B68B515805C4B268174580107AC2EDFFBF9921FB9ADD997DDE99F97CCEF99D59CD1DBDEEBDF3FFFFBFF77F1FF3E6010000000000000000000000000000000000000000000000000055234992F93D3D3D5B3A3B3BDF6D6969499A9A9A540AAAB9B939696F6F7F3DD4127B290000A9120344474747D2DFDF9F9C387142A5A8060606921D3B76BC1902C5C5F65400005223CE400810A90E12279A9A9ABAEDA900007368E586D664AC2A76F9545CBDBEE54FBFBAB1EDE3695A1FF1142683F574570811A77C730100E638448CF7DE44CBF31A1BFFFC8CAB36B67DE1AA0DADBB26FA3BAFDCD0FC6BF173E1CF399EB6F511CFBF37504F7D88487C730100CA38445C7567F3AFAFDCD8BA21D48B576F68BD350684FC670ACD5EC40071F5C6D6E5E1F33BCB3544BCFD465FD2B3FBEEA4AB79ED60C59FE37B06F9420400801051C4F218221A1BDBE697F2F75E7557DBC2F07BEF29C71071E4706FB2F7B1D5C9B30FAD1A56F1BDB8CC405F8800001022C6593E3813B1BEE5CEFC4CC497D7B79DF37EB818E73A8A95EB5BAFBF7A7DEBB2720C1107BA1E1C1520F2F54AD736037D210200408828E6F794724D441402C48FAE5EDFB6A01C434477DB2D0543445C66A02F440000547C88988BBB33853FA337068F720C117B9B1A0B8688B8CC405F880000A08A0811420400004C7B888877632A1422E232037D21020000216258EDDB7957C110119719E80B1100000811C3EA50EF9E64EFE36B469FCA14DE8BCB0CF485080000848851B5FFC97B478588F89E41BE100100801031BA8E1F4FF63DB179F4A94CE1BDB8CC405F880000408818F6B4EA17766E2C784D445CE6A9D54204000042C4E00C43DFBED6E4B9476F281820F2153F133F6B5642880000A04A43C444B30F66258408000084886155CCECC378B31206FE4204000065A8A1A1E1CCC98688C906887C19F80B11000094A1C58B177787BA6DA23051EC2D5E9510010040E58788FDA1924C267338BCDE585B5BFB212142880000A0341FA8B21031104344BE7261A2A1A6A666BE1021440000504480C80DA68F877A33547FA803A1F685DA1BEAA9503BB3D96C6B787D240CB8EF0FAFF7855FDF135EBF1D7EBD219E1A14EAA678543FFC7A5578FD72A865E13397865F2F0EAF1785D70BC2EBEF85F77FBBAEAEEE37C2AFCFA9ADAD3D3BFCFA9F2D5DBAF49FD4D7D7FFFC05175CF033B3116886068811D51DFE8D0B8408210200802206D571001F07F26160FF8B71601F07F86140FDAFE3803F0EFC172D5AF49FE3003B0682F0EB90013297E482C295E1F59A1820629008BFBE35172CBE1DEA7FC7C0910B1E0F876A898124D493A19ECB059597431DCC05981864DE9BE940334E88C8D7D3E1FFFF99C71F7FDC405D880000A0508848D3BF671602CD4421E254F8BD27E3CF06EA4204000065102266E3FF5BA0B684AAC97FCEE94CE9AF2202A1AAF0D28203801031E3E29D98460C428E6532993BE2351A233F2B44988940DB0500E888E3FFF5AC5C783812C343369BFD70A1CF96738808FFFC31ABD8E54204DA2E0040479C535B5BFB91F0FF6D2CE6A9D5E51E22C67B6FA2E54204DA2E0040473C0942841081B60B00D0110B114204DA2E0040472C44081168BB00001DB1102144081168BB0040472C4408114204DA2E00D0110B116EF12A44309BEDD4B6221E3EB7DB9A0200214288504204F976EADC50A7C60B11994C66A1350500428410A1840886B6558F8C132276D5D4D4CCB79600408810229410C1D0B6EADC4221229BCD5E640D0180102144282182B1DAABB1AE8DD86D160200840821420911146AAF465D1BE15A080010228408254430AE101AEE370B0100428410A184084A0911E70DB9166281350200731C22962E5DFA73D6881021445006EDD6E0B511662100608E434478AD09B5FF0FFEE00FFEA1B522440811A4BCDD3AD72C2A50B5922499DFD3D3B3A5B3B3F3DD969696C10E51CD7D35373727EDEDEDAF875A522D21221720FAB3D9EC277C33850821427F530E15DB2EFD0D50956283DED1D191F4F7F71B10A4AC060606921D3B76BC191AF88BAB24440810428410A1BF51FA1BA01CC423421AF45437EC27C220A5BBC203444DEEE2440142881022F4374A7F03948338A5ACF14CFD20E5548507887EE7150B114284FE46E96F00831465905274808833104284EFA7EFA7FD59D99F810A6CD4DF7EA32FE9D97D77D2D5BC76B0E2CFF13D8DAE467DAA0122F76B1D974197EFA7FD597F637F062AA9513F72B837D9FBD8EAE4D987560DABF85E5CA6E1D5A897223E0722DEC675E8351042C4D89CFE91FA3AE6F40FFD8DFE06D0A817A8035D0F8E6AD0F3F54AD7360DAF46BD64239F0321448CADBDBDBDCF85A8E9ADDEDEDEFB5C88AABFD1DF001AF502D5DD764BC1463D2ED3F06AD4A74A88185B6B6BEB85DBB76F7FE3E0C183EFF82EA46B06220688E6E6E697DC12537FA3BF0134EA056A6F5363C1463D2ED3F06AD48588991306A90BC33EB03B9E36E3418CA9A9B82DBA0508FD8DFE06E6486363E3999B366DFAC64D37DDF4E4EAD5AB07962F5F7EB2BEBE3EC93D782A59B66CD9E9AF7DED6B87D7AE5DFBCCB7BEF5AD6FDF78E38DBF62AD69D435EA4204A0BF51FA1BAAD0BA75EBFEEB9A356BFE6AC99225EF85F0903CF0C003C99E3D7B069F6279FAF4E924EFD0A143C9F3CF3F9F3CFAE8A3C9EDB7DF9EC4CF87507120FC9E65353535F3ADC9D969D4E3DD310A35EA71998657A33E450B722162816F24E86FF437FA1B1865E5CA95675D7FFDF5CF5C76D965EF6DD9B265302494E2E4C993C9CE9D3B931B6FBCF1BDE5CB97BF76F9E5977FDA5A9DF9467DDFCEBB0A36EA71998657A33E05E7873A1CEA8EDCEB42DF4AD0DFE86FF437F0BED5AB57AFF8C217BE70EA9E7BEE498E1E3D9A4CD5EEDDBB9310224E5E71C5150FD4D6D67EC81A9EB946FD50EF9E64EFE36B464F2D87F7E2320DAF467D8A01221F1CE24CC4802001FA1BFD8DFE06065D77DD75DFFED297BE74FAA9A79E4AA6D35B6FBD956CDAB4E9644343C3AB21487CC49A9E99463DD6FE27EF1DD5A8C7F734BA1AF5690A1013BD0FE86F94FE866A0B102B56AC78375EEF30537EF0831FBCBB64C99237439038DB1A9F8146FDF8F164DF139B474F2D87F7E2320DAF46BD440B26080AF9E5AE9100FD8DFE467F43358AA730C51988990C10793FFEF18F8F8720D16B46627A1BF5F884D017766E2C788E6A5CE629A21AF54904888902821909D0DFE86FF43754A3781175BC06E299679E4966CBF7BFFFFD57EBEAEA1E74E7A66968D48F1F4FFAF6B526CF3D7A43C1063D5FF133F1B38E1269D48B0C060B66E8F380FE46E96F2877D75D77DD73F122EAD976D55557BD9AC96456D802936FD4273A1AE42891467D0A0162E1247EDF114102F437FA1BFD0D55203E0722DEC6753AEEC254AADEDEDED37575757F9BCD663F6C4B4CAE512FE668D078478934C41AF5690A10D3F5FB01FD8D12222807F141725BB76E4DE6CA37BFF9CDAE10226EB62526D7A84FB641CF978658A33EC4441751CFF69F03E86F9410411A3536369E199F2C5DEA83E4A67936A23F8488D75D1B31B9465D69D4A739404CD7A9486624407FA3F43754AACD9B37DFBC7AF5EA64AE7DF18B5FFC490812BF638B68D435EA7362E445D11F087569EEB514237F9F8BAD417FA3F43754A29B6EBAE9C96DDBB6CD7988B8F3CE3B7756F3294DE1FFDE544C88D2A86BD46730402C1C1204FE57A824F75A6C9028F4FB0409102294FE864AB37AF5EA813D7BF6CC7988E8ECEC7C66F1E2C56DD5BA1DC2FF3D8915C3442693394FA3AE512F564343C399D31820A24B7341202921480C0D10F9BA64C872D7488010A184082AC9F2E5CB4FCEC6C3E526F2DA6BAFF58541745FB5878821F5C85833131A758DFA18FB4E77A8DB2611260A0DECC70A04E30589B13EFF3FC7F8BC6B24408850420495A2BEBE3E397DFA74920671F02C440CAF91A73969D435EA63EC3BFBE3BE92C9640E87D71B6B6B6B3F54428058504230182B48141B20460609A7368110A18408CA7DF09A1642C4B8F5483CCD49A3AE511F63DF1918BAAFE4C244C338773B2B76203F51902835400CFDFB07CC488010A1A656458C1DAAB67C83AB7026428D5F1A7521A28400DA9DCD6617140810C50EE00B05899F9A648018391322488010A1CC444C7BBF682DCC82B45C13313030F0AA6B22C6ACDD994C6661FEA8723935EA230698EFD7742D4FF991A1136100FF56787D3D546FA89EDCB50BCF86FACB501DA19A433D1CB6EFFDE1F5BEF0F97BC2CFDF093FDF157EFEA378B7B2F0736378BD3EBCFF95502BC2AF2F0FAF9784D74CA8CFD4D5D5FDB722C2E7D3B5B5B59F9937F96B12C60A123F994280986CA001AA3C444C67BF51097D90102144CCA9AF7FFDEBAF777575A5E5EE4C1D42C4D8E1A11C8F0C8DD5D88E6CA0A7B23CCD4786C2A0FD8C4F7FFAD3FF2804800F876DF94BE1D7BF1C7EFE78A85F0FDBF537E3752EE1FDDF0F3F5F107EBE288682180EC2CF97859FBF1443430C0FE1E735A1FE30868A182E42FD8F183662E808B5357CEEA1894244F8FCE94F7CE213A7CE38E38C640A03F6B182C45402C4C820E11A09102266BC5F99A93F4B881022AA527C4EC4C30F3F9C8AE744C43BCC08118B77C54165A1F3D9858879A6978B9FC5DA12AA267CE4CCDC60FF8E29FE553F35C60CC44F72EF4FC51DB93FEB4C2D320811428410214494894D9B36DDBE6EDDBA390F112B56ACD89B1BF054EB0E3FE6CC831021448C27DE896944703816F6A33B429D33E2A313DD8D6922E3CD4494F240BA91CC448010214408114244395AB56AD5472EBDF4D2F78E1E3D3A97CF88E8CF66B36F3734347CD01629BF465D8898BB463D349467E5C2C391181EE2E953130CD88FCC9B996B222613245C1301FA1B2142881022CAD9B5D75EFBD7DBB76F9FB31071D75D773D192F28B525840821A234B5B5B51F89175F97F0A0B9528FFC17BA8DEB5877672A2548B83B13E86F84082142882877D75D775DF69A6BAE79772E6EF57AF4E8D1537575757F5B5F5FFF515B428810226645B13300133D07A2D4275BE79D3BCF7322407F33CBFDCABC31EEBE244408114C83E5CB97BFD6D1D131EB21E2A69B6EDA1336F6465BA03243C4BC2ABCC56B9934EA13CD0414FB20B9528344FE94AA8B7C9B417F339BFD4A7CFDE99FFE69B7781522986ECB962DFBE4E5975F7EF2F0E1C3B316209E7EFAE97DD96CF6AFE3C5A1B640E585080FFF49BD423312A53E89BAD82091FFFB0408D0DFCC7AEDDAB52BF9D55FFD55FD8D10C14CB8E28A2B7E74E79D779E9A8DD39A5E7DF5D5A3F134A6458B169D6FCD0B111AF539136724469E5A74E9BCD29F03315690B864C4DFE31A08D0DFCC597DEA539F4ADADADAF43742043321DE5EF4F39FFFFCFE7BEFBDF7E44C0688FEFEFED30D0D0DAF66B3D995D6BA102144A422480CBDD87A682028E54172857E9FDBB882FE46E96F84884A176F11B974E9D2435BB76E3D31533310B90071B3B5AD51D7A8A7C6C8539B6200B8645EE9B76D1DF9FBA6FA7C0A407FA3840821A25CC43B252D59B2A4F7BBDFFDEE6BD37D0D443C85C90C84465DA35E164162AAC63A550AD0DF28FD8D1051C9E28C4418F03F18EFDAF4D24B2F1D9FEA6D5CE35D98E245D4AE81D0A86BD4AB224878901CE86F94FE4688A866994C6645081307BFF18D6F3CF7E28B2FBE56EA93A8376DDAB43BCE3E840DBAD95D9834EA1AF5B230D553909CC204FA1BA5BF1122187C2AEE87E25371431D58B66CD94F6EBDF5D65D6D6D6D4FBFFCF2CB2F0D0D0D870E1D3AD8D9D9F9CC9D77DEB973C58A157BB3D9ECDBF149D41E24A751D7A8976D90287526C145D4A0BF51FA1B2182D14228382F17281E09B53FD4A9B8B172D5176A57A8DB42D53434347CD01AD3A86BD4CB56A9A724398509F4374A7F234480465D69D48B0E06E7CEF3246AD0DF28FD8D10011A75A551CF59900B080BC6593E204080FE46E96F8408D0A82B8DFA508566249CC204FA1BA5BF112240A3AE34EA4507090102F4374A7F234480465D69D48B0E12770810A0BF51FA1B210234EA4AA35EAC05B906DA6D5C474892647E4F4FCF96CECECE775B5A5A06F70535F7D5DCDC9CB4B7B7BF1E6A89BD547FA3BF1122A02AC581898633D5752C34EAA734D0D52906888E8E8EA4BFBFDF77216535303090ECD8B1E3CD10282EB6A7EA6FF437FA28A83AEDEDED7D0628E9ADDEDEDEFB42A3DEAD81AE4E7106C2F733D541E244357C3FF537FA1B21421F05A3B4B6B65EB87DFBF6370E1E3CF88E46345D47846283DEDCDCFC52351CE9D4403B725BC6A77F3872ABBFD1DFE8A3A03A85466361E80877C7CED0F9CEA9A9B82DBAABA541D7408FCD39E4CE21D7DF28FD8D3E0A000DF48C8488B7DFE84B7A76DF9D7435AF1DACF8737CCF205F886046DBAD6DB1EDAAA9A9996F6DE8A300D0409755883872B837D9FBD8EAE4D987560DABF85E5C66A02F4430FD3299CC79A1DD3A15DBAE6C36EBCE72FA280034D0E515220E743D382A40E4EB95AE6D06FA4204331322EE8FED56AE765B23FA280034D0651522BADB6E291822E232037D2182696FAFCECDCF42E42B840A0FCAD44701A0812E9F10B1B7A9B1608888CB0CF48508A6BDBDDA363440E467235C1BA18F0240032D44282182B1DAAA51B310F9CA66B3175943FA280034D0651122E2DD980A8588B8CC405F88605ADBAA47C60A10B9DA650DE9A300D040974588D8B7F3AE8221222E33D0172298B676AAE02C846B23F4510068A0CB2A441CEADD93EC7D7CCDE85399C27B719981BE10C1B4B553DBC60B10EED4A48F0240035D362122D6FE27EF1D1522E27B06F94204DA2E6C67000DB41031BA8E1F4FF63DB179F4A94CE1BDB8CC405F8840DB85ED0CA0811622863DADFA859D1B0B5E131197796AB51081B60BDB1940032D440CCE30F4ED6B4D9E7BF4868201225FF133F1B366258408B45DD8CE001AE82A0D1113CD3E98951022D076613B0368A085886155CCECC378B31206FE4204DA2E6C67000D74958588C906887C19F80B1168BBB09D0134D0551622941081B60BDB19802A6CA0B3D96C53A8DF11228408B45DD8CE0068A08BFEFFC68A612293C99C2744081168BBB09D01D04017152286D42363CD4C08114204DA2E6C670034D08542C4FB331343C384102144A0EDC2760640033D6E88183A33114F7312228408B45DD8CE004C7E505DB565A09EEEB28F2A2DB8100100731D9A7667329985353535F3E3E7CC44988900840800281422868587BC720E11E19F3F6615BB5C8800840800183B44ECCA66B3178D0C0F951222C67B6FA2E54204204400C0F00E69CC9907214288008408009812214288008408001022840840880000214288008408001022840821021022002AC7CA0DADC95855ECF2625CBDBEE54FBFBAB1EDE342845BBC0A1180100150212162BCF7265A7ED586D65D57AF6F5DD6D8F8E7678CFCDC951B9A7F2D2E0F9F3F9E86FFAB87CD0911801001400A42440C0A576F68BD75E5C6D617436DB8EACEE65F1F163036B62E0FCB770A114A8800840800216298C6C6B6F931448C5C76D55D6D0BC37BF708114A88008408002162D097D7B79D53682662F0B3EB5BAF8FA73B09114A88008408002162503C65E9AA8D6D5F18EB9A882804881F5DBDBE6D8110A18408408800A8A010319377670A9FED2D14308408254480100100A926440811801001004284100108110020440811801001004284122200210200214209118010018010A184084088000021428800840800102284084088000021420911204400400AB5B4B418A8A7BB8E851071CA9E0A420400A4467B7B7B5F7F7FBFC17A4AABB7B7F7BE1022BAEDA9204400406AB4B6B65EB87DFBF6370E1E3CF88E417BBA66206280686E6E7E29D4C5F6541022002055C22075615353D3EE78DA4C3CFF5EA5A2E2B6E816204088000000102200000021020000102200000021020000102200000021020000408800000084080000408800000084080000408800000084086B01000010220000002102000010220000002102000010220000008408000040880000008408000040880000008408000040880000001022000000210200001022000000210200001022000000210200004088000000840800004088000000840800987E4992CCEFE9E9D9D2D9D9F96E4B4B4BD2D4D4A45250CDCDCD497B7BFBEBA196D84B41880080548901A2A3A323E9EFEF4F4E9C38A15254030303C98E1D3BDE0C81E2627B2A081100901A7106428048759038D1D4D4D46D4F0521020052239EC264B09EEE0A21E2943D15840800488D78FEBD817AEA4384C105081100507E21E2ED37FA929EDD77275DCD6B072BFE1CDF33C81722002102002162541D39DC9BEC7D6C75F2EC43AB86557C2F2E33D01722002102002162581DE87A705480C8D72B5DDB0CF485084088004088185EDD6DB7140C11719981BE10010811000811C36A6F5363C110119719E80B1180100180102144081180100100930F11F16E4C8542445C66A02F440042040042C4B0DAB7F3AE8221222E33D01722002102002162581DEADD93EC7D7CCDE85399C27B719981BE10010811000811A36AFF93F78E0A11F13D837C2102102200102246D7F1E3C9BE27368F3E9529BC179719E80B11801001801031EC69D52FECDC58F09A88B8CC53AB85084088004088189C61E8DBD79A3CF7E80D050344BEE267E267CD4A08118010014095868889661FCC4A0811801001801031AC8A997D186F56C2C05F8800840800AA2C444C3640E4CBC05F8800840800AA2C442821021022004088A8E01011061FE7663299FBEDCD2044008010A1C60D11313C84DA16EA9401080811002044A88221626478C897BD198408001022D4B01091C964CE8BA72D8D0C0F4204081100CC8C0F58054244398788B1661E840810220098C10031DEC04B2D36502F8F10A1D4944B77204400505AE3FC4E6D6DEDCF5A13A39989289FD399162D5A747ED89777192062906AFB00303B8DF3A110227EC19AA8AC1011FEF96356B1CBCBF5C2EA6C36BB20ECD31D420406A9B60F0033DB381FA8AFAFFFA83551792162BCF7265A5EEEB778CDCD4C74081118A4DA3E00CC4CE3FC425D5DDDBFB02684884A0A1179B999895DF6660C526D1F00A6B7717E2693C9FC5B6B4288A8C4100106A9B60F0033D338EF8AF7D8B7268408210283546C1F008A6D9C5BB2D9ECEF591342841081412AB60F00C536CE7F11EA53D68410214460908AED0340B18DF3964C26536B4D545E88985785B778058354DB07805990CD66EF0921E2126BA2B24244B53D6C0E0C526D1F00665108107F121AE82BAC09214288C02015DB0780621BE73F0E75B5352144081118A462FB00506CE3BC2E93C97CDD9A102284080C52B17D00284A0C10D96CF61BD68410214460908AED0340B121E22BF194266B428810223048C5F601A0D8C6F98A509BF3BFAEADADFD48369BFDB0352344081118A462FB0030AFBEBEFEA32120348506F9B950FB733510EA746CA4875483B52544081118A462FB404A254932BFA7A7674B6767E7BB2D2D2D831DA29AFB6A6E6E4EDADBDB5F0FB5A4021BE34746048691B5AFA6A666BE6FA710214460908AED0329150344474747D2DFDF6F4090B21A18184876ECD8F16608141757D23E97CD663F1E1AE453854244269359E19B2944081118A462FB408AC519080122D541E24418A474576083BCB1408818686868F8A06FA610214460908AED0329164F61321048FD20E554A5ED7721289C99BB16626488B8CDB7528810223048C5F6018314659052A851BE66448088A7389DE55BE9FBE9FB89412AB60F54C820E5ED37FA929EDD77275DCD6B072BFE1CDF3388304899AC78DA52EEEE4C8321229BCDFED0375288F0FDC42015DB072A649072E4706FB2F7B1D5C9B30FAD1A56F1BDB8CC40C22065B24270B86CC805D5E7F8460A11BE9F18A462FB40850C520E743D382A40E4EB95AE6D061206295312C2C3AE10264EFA368EE69AA5D4D7B14ABC660983546C1F989610D1DD764BC11011971948081153515B5BFBA9CF7CE633C77D1B476B6F6FEF73F7B4F4566F6FEF7D9578F7340C52B17D522F9BCD7E3893C92C8E776409D516EAC0880B2DFB42ED0A9FF94EEEB487B3ACB5D90F117B9B1A0B8688B8CC60428898A20B4225B95786686D6DBD70FBF6ED6F1C3C78F01DDF8574CD40C400D1DCDCFC52A53DC70583546C9F545BB468D1F92118DC1F36CAB1099E5C9B8C71F7965DA11A3CD1568810222AC2F9A10E87BA23F7BAD0B772B830485D18F681DDF1B4194F734F4DC56DD12D40304D16E406A90BAC0A2182C21BE1DC50BB4B0C0E85AA3BCE4E58AB331F22E2DD980A8588B8CC405F88986280C80787D8810E0812401571204588602261C07F736E26E1FD20505F5F9FDC7CF3CDC9962D5B92AEAEAEA4AFAF2F3976EC58129D3C793289E702BFF0C20BC9D6AD5B073FB774E9D2B1C2C423E1CFF9A8353C732162DFCEBB0A8688B8CC405F8898860031D1FB000EA420445493DADADA0FE5AE77787FE0DFD0D0907CEF7BDF1B0C09A5387AF468F2C0030F242B57AE1C16243299CCE1F05A636DCF4C8838D4BB27D9FBF89AD1A73285F7E232037D21A2440B26080AF9E5A6F6816A09100EA408118C11203A860EF857AF5E3D38E33015A74F9F4E1E7EF8E1C1998C217FF69150CE4F9D8110116BFF93F78E0A11F13D837C2162920162A280A023052A950329420445ACF4613310F1B4A51800A64B6F6F6FB26AD5AAA141E258269331E898EE1071FC78B2EF89CDA34F650AEFC56506FA42448947DE16CCD0E7011C4841882877B96B20DE1FE07776762633215E4311AF97183A2311FEEE8FDB02D31322E213A95FD8B9B1E035117199A7560B112504828593F87D470409C081148488EA58D9E70EBD883ACE40CCA47811F6BA75EB863D5F223E83C296984288387E3CE9DBD79A3CF7E80D050344BEE267E267CD4A0811337444CD1139C0811484886A90C964FE6AE83510D3790A53216FBDF55672F9E5970FBDD8FA0E5B62722162A2D907B312424409263AF7374A86D454FE1C0007521022CA557C90DCD0BB304DF522EA523CF5D453232FB43ECB16293D441433FB30DEAC8481BF103162E03FD111B46242848E14702045FB274454F88ADE961FC8C7DBB8CEB6DB6FBF7D6890B8CD16293D444C3640E4CBC05F889857DAB9BCC5868852FF5C0007521022CA41BC0E21DE2129FF20B9529F03311D5E7CF1C561CF8F68686838D396292D442821629A0244B11D5D29214290001C48D1FE091195260CDA17E707F0F18E497365E8C3E842B0B9C89611228488D40688C98488A147F81C91031C484188A880957CDB6CDD91693C7FF6677F56D405D6F12E5261F9FD4284817A3987888686860F867DF99A14CCBA4D76603F991031D9C002E0400A42440A57F2FB0F977BFEF9E7E72C44C467520C9989681A2B3CE4AEDD3855ED3B861051BE212277FAE035F196C6B9FDFDAC140488C91C199B6C8870440E481307528408A6B0920FE407EFB37957A6915E7EF9E561CF8C28141EF2254418A8975388A8ADAD3D3BECB737C56B7E86EEC7731822A63A909F4A88C8FFFD033A52C08194E2C453BD439FB1DB66132252B592F3159F243D57E2C3E786FE5BC260EBBC78DAD2C8F020440811E5142272E1E14FF3372F1859353535F3E730404C65003FD510319523800055732025F415170F7D96974D2744A43244CCB51103AC31C3832F9110512E2162AC19B414ECC7D335953E1D21623AFF3D0015752025F70CAF5DC63F424459848834CD44A8F1CB403DFD212293C9BC37D1768CD7FF84D7BF08F57F42FD20D4DDE1F7FD49785D1F96DD1A4F810A7563786F5578FD72A82BC2CF9F0FAF7561F9E7C2CF0BC3EB7F099DCDEF86F77EABAEAEEEDF85F7FE5578FDE7B5B5B5FF34D42FD6D7D7FFFC05175CF033E1EB7EC1BCD21EA034DD35534704012AE6404A68CB6B427538882A4494C34A4EE535118512B82F5179CF44141A6016BBBC9C424418C09F911BF0FFBF42FB716E3FFF54F8DC674318C8869F1BC2CB7F8F8121171C6E8C41221728D6C780117EFE6EF8F9FBE1E71FE5663B1E0FEFED08AF9DB929EFF8F7BD18EA955003A1DE0C753C2C8BEBF28E123AC6D90A11F372FFAEF819CF8801664AA94FA29ED50329679F7DF6F5A1ADDE3ED1C1A7D0B77C2CD42FC7D36543FDCB50BF565F5FFF6FC2B27F9FBB8EF4B742FD76A8FF940B24BF1FDAFF4F86BA201E780A7561EC7342D5C6DBFC87AA0F7549ECAF425F7259EC83422D0F7565F8BD57E76E06726DA81B42AD0ED5983BC0F587E1F7DC12EAF67857CD501B426D8AFD54A8EFC4BE2AD43DA1BE17EA87A1FE3C77C0ECC7B983678FC4FE2B544BEEFF1D83D313A1FE6FA827637F166A4FF87D5DA19E0FEFED0BD513EAA55CFF166F50D21FEA50AE9F7B3B77EAF0C950EF0A11B31322527D77A6F0F382B112B91051BE2162BCF7265A5EAE1756C7735A87DC9169AEF6E3622E2234130154A23373ED50AA0FA47CF6B39F7DAF88B3115ECA0DA6F7C5C1751C64C7C176F8F5D3F1C2EB784029D4CE50EDB9315E73A8C7423D9C3BF0F4401CCCC7417D6E70FFBDDC60FFBB71F09F0B01310C6C089FFBE3DCA300BE196A5DA8B5A1D6C4035CE1F3D787FA5AA8AF865A1943472E7CC41072590C25B970529F0B2B31B47C36FCDE4FC78367717C1767D243FD5EA84F84FA9D50FFB1AEAEEE3F84FA8D38B31EC3510C49B9B074762E3C7D2C37D3FE9138DB1EEA17E28CFBD2A54B7F2EDE3E7DD9B265FFA0B1B1F1A7ECF2B3132236A6E13911F1EF1EF205D938F2DF993B62DB21440811E57A8BD7D0D07D287744E7486E3F3E3007BB4F1CB01F99E79A08A07A6722527D2065C88D659C8941BA85D4B7240D4FAC5EB56AD5D02FC9C5E3FC7BE3CCC42E21428828D787CDE59E15116FF7FA5773B40B4DC7917F776702CA51D91C48C93F5CD72DEE49ADFAFAFA8FE66F3F197E4EDE7AEBADB9BE1EE2581C64D9324244A58688BC383331C71DE95406F053ED40CF9DE7391180032913B6C3614CF4F1DCADC28508D267E875115BB76E9DF510B179F3E6A121E26E5B4488A88610910253990998EA8396E291C08B7C9B0107528A13C344BC86C1A62355869ED2B47CF9F259BDD56B6F6FEFE00C48FEEF8F17D2D82242841091FA8E74B21D68FEEF1320000752A0DCC5A7E68601FC73F981FC030F3C306B2162EDDAB5439F527DBFAD51F921625E95DCE2B5CC3AD2524F2D9A4C07EA1A08C081140752A834436723E2CCC0DFFCCDDFCC788078F8E187873DA13A8488736C89CA0E11D5F4B0B9323D2257EC39C2A576A06EE30A3890E2400A952A77FFE0C141FD57BEF295E4E8D1A333162076EEDC39EC34A6F8245E5B40881022CAE6885C291D68A90105C081142827F1C11DB927DC0E0EECD7AD5B979C3C79724602444343838BA9850821A27C8344B11DE8648EF001389002E526F79093C3F9017EBC66E1D0A143D37A0AD388198847E6F85697428412224AEF484B7980920001389002D5209BCD5E947F7644AC386BD0D9D939E5BB30AD59B366E49317050821428848A7A91E3973E40D7020C58114AAD1A2458BCE0F83FC234307FDF189D6CF3FFF7CC90F928BCF811831FB30780A9300214408116511244AED009DFB0B544AFBE7400A4C46EE298907460CFE932BAFBC32F9E10F7F987474740CDEC5297FDD447C8DA121CE5A6CD9B225B9F6DA6B47068724F7F87617510B114244E51C9173E40DA8E420E1400A4C469C2D0861E2E691B31293A9F81C08B771152284888A0D12F109AC1EA0045412075260AAEAEBEB3F1A82C04D432FBA2EB2E2B515777B12B510214494FD11B923E31C59CB5F3C284000D51A241C4881F13434347C3077BDC46DF1C2E8314E77EACB66B34DE17563081C8BC3CF1FB6D6840821A2A23B5247DE804AE7400A20442821621A83840001540B07520021420911D3D091DEA1E304AA3C4808108010A18488627DEC631FFBF2BCBFBB3FFA05BE914095060907520021420911A558BC78F1B6CF7DEE73EF7AD60B50A516C4EB40E7B98D2B20442821A23821389C9D7BDE4BBC91C2977C23874B92647E4F4FCF96CECECE775B5A5A06F70535F7D5DCDC9CB4B7B7BF1E6A89BD94693A9892580B405989031303F554D7B130683955C11DE7DD439EFDB22FDEB1CDB7F2EFC500111FC4D9DFDFEFBB90B21A18184876ECD8F166081417DB53112280AAD3DEDEDE678092DEEAEDEDBD2F8488EE4ADCF742603833F7EC97A10F91BCCEB7F2EFC51908DFCF5407891395FAFD44880018576B6BEB85DBB76F7FE3E0C183EF1814A46B06220688E6E6E6972AF54867369B5D39C693E80F7B1ECCDF33535816A71B9EB2A722440055290C5217868E7077EC0C9DEF9C9A8ADBA2BB5203444D4DCDFC311E2E990F12DFF1ADFC3BAE5972CD124204009093CD662F1B2B40E42A5E687D96B5547C8878FB8DBEA467F7DD4957F3DAC18A3FC7F70CF28508840800A8A40EB37B9C10116B8BB5545C883872B837D9FBD8EAE4D987560DABF85E5C66A02F4420440040D9CB64328B27081003A1F69B8D282E441CE87A705480C8D72B5DDB0CF48508840800287FB9BB329D152BFF80B9F0F37D315C583BA58788EEB65B0A8688B8CC405F88408800804AED40E3F3221AAC89D243C4DEA6C68221222E33D01722102200A0523BD06F6532992F5A134284108110010014259BCDFE5108115FB1264A0F11F16E4C8542445C66A02F4420440040A586886F8410F1756BA2F410B16FE75D0543445C66A02F4420440040458A012206096BA2F41071A8774FB2F7F135A34F650AEFC56506FA420442040054A41020BE1A4F69B2264A0F11B1F63F79EFA81011DF33C81722102200A09243C4F24C26B3C99A984488387E3CD9F7C4E6D1A73285F7E232037D21022102002A5208109F0F41E2BBD6446921223E91FA859D1B0B5E131197796AB51081100100951A22168710F1436BA2C81071FC78D2B7AF3579EED11B0A06887CC5CFC4CF9A951022102200A0D242C485A1137DC09A9838444C34FB60564288408800806A09119F0C9DE863D6C4C421A298D987F166250CFC8508840800A8088B162DFADDD089B65B13138788C906887C19F80B1108110050113299CC6F864EF42FAD89894384122210220080BF0B11E7844EF4396B4288A8B41011F6EB73C3FE7DBFBD19210200A63F44FC4AE844FFDA9A10222A2544C4F0106A5BA853068808110030331DE82F85EAB5268488720F1123C343BEECCD08110030CDEAEAEAFE71E844FFD69A1022CA3544643299F3E2694B23C383108110010033A4B6B6F66743277ACC9A1022CA31448C35F32044204400C0CCFBC07803B06A2E03F5B208114A4DB9740300C0B43013513EA7332D5AB4E8FC3010DC65800800801031C90AFFFC31ABD8E5E57A6175369B5D10424387100100801031891031DE7B132D2FF75BBCE666263A84080000840821A2A487CDE5662676D99B010010228488A242040000081142841001008010214408110000081142841001008010E116AF42040000547088A8B687CD01008010A184080000840825440000204428210200008408210200008408210200008408254400002044282102000021420911000008114A8800000021428800000021428800000021420911000008114A8800004088504204000055AAA5A5C5403DDD752C848853F654000052A3BDBDBDAFBFBFDF603DA5D5DBDB7B5F0811DDF654000052A3B5B5F5C2EDDBB7BF71F0E0C1770CDAD335031103447373F34BA12EB6A70200902A6190BAB0A9A969773C6D269E7FAF5251715B740B100000000000000000000000000000000000000000000000000000000029F7FF018FC8FA679B6A81BD0000000049454E44AE426082, 1);

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property`  (
  `NAME_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO `act_ge_property` VALUES ('batch.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` VALUES ('common.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('entitylink.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('eventsubscription.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('identitylink.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('job.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('next.dbid', '2501', 2);
INSERT INTO `act_ge_property` VALUES ('schema.history', 'create(6.6.0.0)', 1);
INSERT INTO `act_ge_property` VALUES ('schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('task.schema.version', '6.6.0.0', 1);
INSERT INTO `act_ge_property` VALUES ('variable.schema.version', '6.6.0.0', 1);

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `TRANSACTION_ORDER_` int(11) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_START`(`START_TIME_`) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_END`(`END_TIME_`) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_PROCINST`(`PROC_INST_ID_`, `ACT_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_EXEC`(`EXECUTION_ID_`, `ACT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------
INSERT INTO `act_hi_actinst` VALUES ('10', 1, 'leave:1:4', '5', '7', 'usertask1', '11', NULL, '提交人', 'userTask', '1', '2021-09-10 09:41:31.240', NULL, 3, NULL, NULL, 'CSLC');
INSERT INTO `act_hi_actinst` VALUES ('8', 1, 'leave:1:4', '5', '7', 'startevent1', NULL, NULL, 'Start', 'startEvent', NULL, '2021-09-10 09:41:31.235', '2021-09-10 09:41:31.238', 1, 3, NULL, 'CSLC');
INSERT INTO `act_hi_actinst` VALUES ('9', 1, 'leave:1:4', '5', '7', 'flow1', NULL, NULL, NULL, 'sequenceFlow', NULL, '2021-09-10 09:41:31.240', '2021-09-10 09:41:31.240', 2, 0, NULL, 'CSLC');

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `URL_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CONTENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACTION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `MESSAGE_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `FULL_MSG_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint(20) NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_PROC_INST`(`PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_ACT_INST`(`ACT_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_TIME`(`TIME_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_NAME`(`NAME_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_TASK_ID`(`TASK_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LINK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_`, `ROOT_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_USER`(`USER_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_TASK`(`TASK_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_PROCINST`(`PROC_INST_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------
INSERT INTO `act_hi_identitylink` VALUES ('12', NULL, 'assignee', '1', '11', '2021-09-10 09:41:31.266', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` VALUES ('13', NULL, 'participant', '1', NULL, '2021-09-10 09:41:31.266', '5', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` VALUES ('14', '+110+', 'candidate', NULL, '11', '2021-09-10 09:41:31.266', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` VALUES ('6', NULL, 'starter', '1', NULL, '2021-09-10 09:41:31.233', '5', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT 1,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `END_ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `PROC_INST_ID_`(`PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_INST_END`(`END_TIME_`) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_I_BUSKEY`(`BUSINESS_KEY_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------
INSERT INTO `act_hi_procinst` VALUES ('5', 1, '5', '26019871997431808', 'leave:1:4', '2021-09-10 09:41:31.230', NULL, NULL, '1', 'startevent1', NULL, NULL, NULL, 'CSLC', '请假2021-09-10 09:41:31', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PRIORITY_` int(11) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
  `FORM_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_INST_PROCINST`(`PROC_INST_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------
INSERT INTO `act_hi_taskinst` VALUES ('11', 1, 'leave:1:4', NULL, 'usertask1', '5', '7', NULL, NULL, NULL, NULL, NULL, '提交人', NULL, NULL, NULL, '1', '2021-09-10 09:41:31.241', NULL, NULL, NULL, NULL, 50, NULL, NULL, NULL, 'CSLC', '2021-09-10 09:41:31.266');

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log`  (
  `ID_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DATA_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT 1,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint(20) NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_NAME_TYPE`(`NAME_`, `VAR_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_PROC_INST`(`PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_TASK_ID`(`TASK_ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_EXE`(`EXECUTION_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `USER_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PASSWORD_` longblob NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership`  (
  `USER_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`, `GROUP_ID_`) USING BTREE,
  INDEX `ACT_FK_MEMB_GROUP`(`GROUP_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_PRIV_NAME`(`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PRIV_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_PRIV_MAPPING`(`PRIV_ID_`) USING BTREE,
  INDEX `ACT_IDX_PRIV_USER`(`USER_ID_`) USING BTREE,
  INDEX `ACT_IDX_PRIV_GROUP`(`GROUP_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property`  (
  `NAME_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
INSERT INTO `act_id_property` VALUES ('schema.version', '6.6.0.0', 1);

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TOKEN_VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TOKEN_DATE_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `IP_ADDRESS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USER_AGENT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TOKEN_DATA_` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `FIRST_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `LAST_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DISPLAY_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EMAIL_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PWD_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PICTURE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_INFO_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
  INDEX `ACT_IDX_INFO_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
  INDEX `ACT_FK_INFO_JSON_BA`(`INFO_JSON_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
INSERT INTO `act_re_deployment` VALUES ('1', '测试请假', '1', 'CSQJ', 'CSLC', '2021-09-10 09:39:11.664', NULL, NULL, '1', NULL);

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) NULL DEFAULT NULL,
  `META_INFO_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_MODEL_SOURCE`(`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
  INDEX `ACT_FK_MODEL_SOURCE_EXTRA`(`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
  INDEX `ACT_FK_MODEL_DEPLOYMENT`(`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) NULL DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DERIVED_VERSION_` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_PROCDEF`(`KEY_`, `VERSION_`, `DERIVED_VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------
INSERT INTO `act_re_procdef` VALUES ('leave:1:4', 4, '1', '请假', 'leave', 1, '1', 'CSQJ.bpmn', 'CSQJ.leave.png', NULL, 0, 1, 1, 'CSLC', NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `TRANSACTION_ORDER_` int(11) NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_START`(`START_TIME_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_END`(`END_TIME_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_PROC`(`PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_PROC_ACT`(`PROC_INST_ID_`, `ACT_ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_EXEC`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_EXEC_ACT`(`EXECUTION_ID_`, `ACT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_actinst
-- ----------------------------
INSERT INTO `act_ru_actinst` VALUES ('10', 1, 'leave:1:4', '5', '7', 'usertask1', '11', NULL, '提交人', 'userTask', '1', '2021-09-10 09:41:31.240', NULL, NULL, 3, NULL, 'CSLC');
INSERT INTO `act_ru_actinst` VALUES ('8', 1, 'leave:1:4', '5', '7', 'startevent1', NULL, NULL, 'Start', 'startEvent', NULL, '2021-09-10 09:41:31.235', '2021-09-10 09:41:31.238', 3, 1, NULL, 'CSLC');
INSERT INTO `act_ru_actinst` VALUES ('9', 1, 'leave:1:4', '5', '7', 'flow1', NULL, NULL, NULL, 'sequenceFlow', NULL, '2021-09-10 09:41:31.240', '2021-09-10 09:41:31.240', 0, 2, NULL, 'CSLC');

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
  INDEX `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
  INDEX `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
  INDEX `ACT_IDX_DJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_DJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_DJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_FK_DEADLETTER_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
  INDEX `ACT_FK_DEADLETTER_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LINK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_`, `ROOT_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CONFIGURATION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EVENT_SUBSCR_CONFIG_`(`CONFIGURATION_`) USING BTREE,
  INDEX `ACT_FK_EVENT_EXEC`(`EXECUTION_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PARENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) NULL DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) NULL DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) NULL DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) NULL DEFAULT NULL,
  `IS_MI_ROOT_` tinyint(4) NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) NULL DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) NULL DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int(11) NULL DEFAULT NULL,
  `TASK_COUNT_` int(11) NULL DEFAULT NULL,
  `JOB_COUNT_` int(11) NULL DEFAULT NULL,
  `TIMER_JOB_COUNT_` int(11) NULL DEFAULT NULL,
  `SUSP_JOB_COUNT_` int(11) NULL DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int(11) NULL DEFAULT NULL,
  `EXTERNAL_WORKER_JOB_COUNT_` int(11) NULL DEFAULT NULL,
  `VAR_COUNT_` int(11) NULL DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EXEC_BUSKEY`(`BUSINESS_KEY_`) USING BTREE,
  INDEX `ACT_IDC_EXEC_ROOT`(`ROOT_PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_FK_EXE_PROCINST`(`PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_FK_EXE_PARENT`(`PARENT_ID_`) USING BTREE,
  INDEX `ACT_FK_EXE_SUPER`(`SUPER_EXEC_`) USING BTREE,
  INDEX `ACT_FK_EXE_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------
INSERT INTO `act_ru_execution` VALUES ('5', 3, '5', '26019871997431808', NULL, 'leave:1:4', NULL, '5', NULL, 1, 0, 1, 0, 0, 1, NULL, 'CSLC', '请假2021-09-10 09:41:31', 'startevent1', '2021-09-10 09:41:31.230', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` VALUES ('7', 3, '5', NULL, '5', 'leave:1:4', NULL, '5', 'usertask1', 1, 0, 0, 0, 0, 1, NULL, 'CSLC', NULL, NULL, '2021-09-10 09:41:31.234', NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for act_ru_external_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_external_job`;
CREATE TABLE `act_ru_external_job`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RETRIES_` int(11) NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
  INDEX `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
  INDEX `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
  INDEX `ACT_IDX_EJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_EJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_EJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RETRIES_` int(11) NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ADV_HANDLER_CFG_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_USER`(`USER_ID_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_GROUP`(`GROUP_ID_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_ATHRZ_PROCEDEF`(`PROC_DEF_ID_`) USING BTREE,
  INDEX `ACT_FK_TSKASS_TASK`(`TASK_ID_`) USING BTREE,
  INDEX `ACT_FK_IDL_PROCINST`(`PROC_INST_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------
INSERT INTO `act_ru_identitylink` VALUES ('13', 1, NULL, 'participant', '1', NULL, '5', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` VALUES ('14', 1, '+110+', 'candidate', NULL, '11', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` VALUES ('6', 1, NULL, 'starter', '1', NULL, '5', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RETRIES_` int(11) NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
  INDEX `ACT_IDX_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
  INDEX `ACT_IDX_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
  INDEX `ACT_IDX_JOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_JOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_JOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_FK_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_FK_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
  INDEX `ACT_FK_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RETRIES_` int(11) NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
  INDEX `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
  INDEX `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
  INDEX `ACT_IDX_SJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_SJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_SJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_FK_SUSPENDED_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
  INDEX `ACT_FK_SUSPENDED_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DELEGATION_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PRIORITY_` int(11) NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  `FORM_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) NULL DEFAULT NULL,
  `VAR_COUNT_` int(11) NULL DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) NULL DEFAULT NULL,
  `SUB_TASK_COUNT_` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_TASK_CREATE`(`CREATE_TIME_`) USING BTREE,
  INDEX `ACT_IDX_TASK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_FK_TASK_EXE`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_FK_TASK_PROCINST`(`PROC_INST_ID_`) USING BTREE,
  INDEX `ACT_FK_TASK_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------
INSERT INTO `act_ru_task` VALUES ('11', 3, '7', '5', 'leave:1:4', NULL, NULL, NULL, NULL, NULL, NULL, '提交人', NULL, NULL, 'usertask1', NULL, '1', NULL, 50, '2021-09-10 09:41:31.241', NULL, NULL, 1, 'CSLC', NULL, NULL, 1, 0, 1, 0);

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RETRIES_` int(11) NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
  INDEX `ACT_IDX_TJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_TJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_TJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_FK_TIMER_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_FK_TIMER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
  INDEX `ACT_FK_TIMER_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint(20) NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_IDX_RU_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
  INDEX `ACT_FK_VAR_BYTEARRAY`(`BYTEARRAY_ID_`) USING BTREE,
  INDEX `ACT_IDX_VARIABLE_TASK_ID`(`TASK_ID_`) USING BTREE,
  INDEX `ACT_FK_VAR_EXE`(`EXECUTION_ID_`) USING BTREE,
  INDEX `ACT_FK_VAR_PROCINST`(`PROC_INST_ID_`) USING BTREE,
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dict_data
-- ----------------------------
DROP TABLE IF EXISTS `dict_data`;
CREATE TABLE `dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dict_type
-- ----------------------------
DROP TABLE IF EXISTS `dict_type`;
CREATE TABLE `dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_channel_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_channel_definition`;
CREATE TABLE `flw_channel_definition`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `VERSION_` int(11) NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_CHANNEL_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_ev_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
CREATE TABLE `flw_ev_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DATEEXECUTED` datetime(0) NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ev_databasechangelog
-- ----------------------------
INSERT INTO `flw_ev_databasechangelog` VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2021-09-03 10:17:27', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.3.5', NULL, NULL, '0664247274');

-- ----------------------------
-- Table structure for flw_ev_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
CREATE TABLE `flw_ev_databasechangeloglock`  (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ev_databasechangeloglock
-- ----------------------------
INSERT INTO `flw_ev_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for flw_event_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_definition`;
CREATE TABLE `flw_event_definition`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `VERSION_` int(11) NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_EVENT_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_event_deployment
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_deployment`;
CREATE TABLE `flw_event_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_event_resource
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_resource`;
CREATE TABLE `flw_event_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_ru_batch
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch`;
CREATE TABLE `flw_ru_batch`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `SEARCH_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NOT NULL,
  `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
  `STATUS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `BATCH_DOC_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_ru_batch_part
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch_part`;
CREATE TABLE `flw_ru_batch_part`  (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `BATCH_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SEARCH_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NOT NULL,
  `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
  `STATUS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `RESULT_DOC_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `FLW_IDX_BATCH_PART`(`BATCH_ID_`) USING BTREE,
  CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('workflowScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('workflowScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('workflowScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.workflow.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E776F726B666C6F772E71756172747A2E646F6D61696E2E656E746974792E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E00097872002A636F6D2E776F726B666C6F772E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BCDE83F3878707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.workflow.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E776F726B666C6F772E71756172747A2E646F6D61696E2E656E746974792E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E00097872002A636F6D2E776F726B666C6F772E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BCDE83F3878707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.workflow.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E776F726B666C6F772E71756172747A2E646F6D61696E2E656E746974792E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E00097872002A636F6D2E776F726B666C6F772E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BCDE83F3878707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('workflowScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.workflow.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E776F726B666C6F772E71756172747A2E646F6D61696E2E656E746974792E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E00097872002A636F6D2E776F726B666C6F772E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BCDE83F3878707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('workflowScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.workflow.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E776F726B666C6F772E71756172747A2E646F6D61696E2E656E746974792E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E00097872002A636F6D2E776F726B666C6F772E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BCDE83F3878707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('workflowScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.workflow.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720028636F6D2E776F726B666C6F772E71756172747A2E646F6D61696E2E656E746974792E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E00097872002A636F6D2E776F726B666C6F772E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BCDE83F3878707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('workflowScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('workflowScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'LAPTOP-VESM13MU1631451572824', 1631457312158, 15000);
INSERT INTO `qrtz_scheduler_state` VALUES ('workflowScheduler', 'LAPTOP-VESM13MU1631501143413', 1631505201819, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1631451580000, -1, 5, 'PAUSED', 'CRON', 1631451572000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1631451585000, -1, 5, 'PAUSED', 'CRON', 1631451573000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1631451580000, -1, 5, 'PAUSED', 'CRON', 1631451573000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('workflowScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1631501150000, -1, 5, 'PAUSED', 'CRON', 1631501143000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('workflowScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1631501145000, -1, 5, 'PAUSED', 'CRON', 1631501143000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('workflowScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1631501160000, -1, 5, 'PAUSED', 'CRON', 1631501143000, 0, NULL, 2, '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-09-10 12:12:35', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-09-10 12:12:35', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-09-10 12:12:35', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2021-09-10 12:12:35', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2021-09-10 12:12:35', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '土豆科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-09-10 12:12:35', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-09-10 12:12:35', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-09-10 12:12:35', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-09-10 12:12:35', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-11 15:30:43');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 02:12:08');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 03:21:30');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '退出成功', '2021-09-12 03:53:43');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '1', '验证码错误', '2021-09-12 03:55:36');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 03:55:40');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 05:06:07');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 11:07:09');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 12:37:38');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '1', '验证码错误', '2021-09-12 14:12:38');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-12 14:12:41');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '1', '验证码错误', '2021-09-13 02:59:53');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2021-09-13 02:59:57');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2021-09-13 03:21:07');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2021-09-13 03:39:43');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2021-09-13 03:39:56');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '退出成功', '2021-09-13 03:42:45');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10', '0', '登录成功', '2021-09-13 03:48:10');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2026 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-09-10 12:12:34', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-09-10 12:12:34', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-09-10 12:12:34', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '数据迁移', 0, 5, 'http://localhost', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-09-10 12:12:34', 'admin', '2021-09-12 14:33:05', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-09-10 12:12:34', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-09-10 12:12:34', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-09-10 12:12:34', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-09-10 12:12:34', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-09-10 12:12:34', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-09-10 12:12:34', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-09-10 12:12:34', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-09-10 12:12:34', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-09-10 12:12:34', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-09-10 12:12:34', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-09-10 12:12:34', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-09-10 12:12:34', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-09-10 12:12:34', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-09-10 12:12:34', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 2007, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-09-10 12:12:34', 'admin', '2021-09-12 13:00:27', '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-09-10 12:12:34', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-09-10 12:12:34', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-09-10 12:12:34', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-09-10 12:12:34', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '流程工作台', 0, 0, 'workMenu', NULL, NULL, 1, 0, 'M', '0', '0', '', 'education', 'admin', '2021-09-12 03:23:47', 'admin', '2021-09-12 03:24:14', '');
INSERT INTO `sys_menu` VALUES (2001, '个人工作台', 2000, 1, '/personal/workBench', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'tab', 'admin', '2021-09-12 03:25:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '管理工作台', 2000, 2, '/management/workBench', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'table', 'admin', '2021-09-12 03:25:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '工作台首页', 2001, 0, 'homePage', 'workBench/homePage/index', NULL, 1, 1, 'C', '0', '0', NULL, 'job', 'admin', '2021-09-12 03:28:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '发起流程', 2001, 2, 'homePageAdd', 'workBench/homePage/add', NULL, 1, 1, 'C', '1', '0', '', '#', 'admin', '2021-09-12 03:29:41', 'admin', '2021-09-12 03:29:51', '');
INSERT INTO `sys_menu` VALUES (2005, '流程引擎', 0, 4, 'processCore', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'example', 'admin', '2021-09-12 05:09:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '流程模型设计', 2005, 1, 'processModel', NULL, NULL, 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-09-12 05:10:45', 'admin', '2021-09-12 13:41:02', '');
INSERT INTO `sys_menu` VALUES (2007, '自定义表单设计', 2005, 2, 'formModel', NULL, NULL, 1, 0, 'M', '0', '0', '', 'build', 'admin', '2021-09-12 05:11:43', 'admin', '2021-09-12 13:41:09', '');
INSERT INTO `sys_menu` VALUES (2008, '引擎设置', 2005, 4, 'processConfig', NULL, NULL, 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-09-12 05:16:34', 'admin', '2021-09-12 12:52:32', '');
INSERT INTO `sys_menu` VALUES (2009, '引擎运行时信息', 2005, 3, 'processMeta', NULL, NULL, 1, 0, 'M', '0', '0', '', 'input', 'admin', '2021-09-12 05:17:53', 'admin', '2021-09-12 12:07:41', '');
INSERT INTO `sys_menu` VALUES (2010, '引擎服务', 2005, 0, 'processServiceManagement', NULL, NULL, 1, 0, 'M', '0', '0', '', 'dict', 'admin', '2021-09-12 05:20:55', 'admin', '2021-09-12 13:40:54', '');
INSERT INTO `sys_menu` VALUES (2011, '服务分类', 2010, 1, 'processServiceCategory/index', 'processCore/processService/processSerivceCategory/index', NULL, 1, 1, 'C', '0', '0', '', 'cascader', 'admin', '2021-09-12 05:30:46', 'admin', '2021-09-12 13:41:34', '');
INSERT INTO `sys_menu` VALUES (2012, '服务配置', 2010, 2, 'processSerivceConfig/index', 'processCore/processService/processServiceConfig/index', NULL, 1, 1, 'C', '0', '0', '', 'date-range', 'admin', '2021-09-12 11:10:40', 'admin', '2021-09-12 11:15:59', '');
INSERT INTO `sys_menu` VALUES (2013, '待办个人任务', 2002, 1, 'workMenuTodo', 'workBench/todo/PersonalMission', NULL, 1, 1, 'C', '0', '0', NULL, 'edit', 'admin', '2021-09-12 11:18:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '待办组任务', 2002, 2, 'workMenuGroup', 'workBench/group/GroupMission', NULL, 1, 1, 'C', '0', '0', NULL, 'button', 'admin', '2021-09-12 11:19:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '已办任务', 2002, 3, 'workMenuDone', 'workBench/done/DoneMission', NULL, 1, 0, 'C', '0', '0', NULL, 'skill', 'admin', '2021-09-12 11:20:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '限时任务', 2002, 4, 'workMenu/overTime', 'workBench/overTime/overTime', NULL, 1, 1, 'C', '0', '0', NULL, 'time', 'admin', '2021-09-12 11:21:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '我发起的流程', 2002, 5, 'workMenuMyProcess', 'workBench/sent/SentMission', NULL, 1, 1, 'C', '0', '0', NULL, 'post', 'admin', '2021-09-12 11:22:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '流程分类', 2006, 1, 'processCategory', 'processCore/processService/processCategory/index', NULL, 1, 1, 'C', '0', '0', '', 'cascader', 'admin', '2021-09-12 11:28:55', 'admin', '2021-09-12 13:42:11', '');
INSERT INTO `sys_menu` VALUES (2019, '流程模型', 2006, 2, 'processModelInfo', 'processCore/processService/processModelInfo/index', NULL, 1, 1, 'C', '0', '0', '', 'example', 'admin', '2021-09-12 11:29:56', 'admin', '2021-09-12 13:42:51', '');
INSERT INTO `sys_menu` VALUES (2020, '流程模型设计器', 2006, 3, 'processModelDesign', 'processCore/processService/processModelDesign/index', NULL, 1, 1, 'C', '1', '0', '', '#', 'admin', '2021-09-12 11:31:20', 'admin', '2021-09-12 13:43:00', '');
INSERT INTO `sys_menu` VALUES (2021, '流程表达式', 2006, 4, 'processExpression', 'processCore/processService/processExpression/index', NULL, 1, 1, 'C', '0', '0', '', 'language', 'admin', '2021-09-12 11:32:15', 'admin', '2021-09-12 13:43:11', '');
INSERT INTO `sys_menu` VALUES (2022, '流程监听器', 2006, 5, 'processListener', 'processCore/processService/processListener/index', NULL, 1, 1, 'C', '0', '0', '', 'message', 'admin', '2021-09-12 11:33:56', 'admin', '2021-09-12 13:43:19', '');
INSERT INTO `sys_menu` VALUES (2023, '流程审核按钮', 2006, 6, 'processButton', 'processCore/processService/processButton/index', NULL, 1, 1, 'C', '0', '0', '', 'button', 'admin', '2021-09-12 11:34:41', 'admin', '2021-09-12 13:43:27', '');
INSERT INTO `sys_menu` VALUES (2024, '流程定义', 2009, 1, 'processMeta/processDef', 'processCore/processMeta/definition/index', NULL, 1, 1, 'C', '0', '0', '', 'icon', 'admin', '2021-09-12 12:08:40', 'admin', '2021-09-12 13:04:21', '');
INSERT INTO `sys_menu` VALUES (2025, '租户管理', 2008, 1, 'processConfig/processTenant', 'processCore/processConfig/processTenant/index', NULL, 1, 1, 'C', '0', '0', '', 'international', 'admin', '2021-09-12 12:47:28', 'admin', '2021-09-12 13:04:00', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2021-09-13 流程引擎新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2021-09-10 12:12:35', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-09-13 流程引擎凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2021-09-10 12:12:35', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 3, 'com.workflow.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2021-09-12 02:16:24');
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"guide\",\"orderNum\":\"4\",\"menuName\":\"数据迁移\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"localhost\",\"children\":[],\"createTime\":1631247154000,\"isFrame\":\"0\",\"menuId\":4,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"修改菜单\'数据迁移\'失败，地址必须以http(s)://开头\",\"code\":500}', 0, NULL, '2021-09-12 02:17:09');
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"guide\",\"orderNum\":\"4\",\"menuName\":\"数据迁移\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"http://localhost\",\"children\":[],\"createTime\":1631247154000,\"updateBy\":\"admin\",\"isFrame\":\"0\",\"menuId\":4,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 02:17:17');
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"dashboard\",\"orderNum\":\"0\",\"menuName\":\"流程工作台\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"workMenu\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:23:47');
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"education\",\"orderNum\":\"0\",\"menuName\":\"流程工作台\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"workMenu\",\"children\":[],\"createTime\":1631388227000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2000,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:24:14');
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"tab\",\"orderNum\":\"1\",\"menuName\":\"个人工作台\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"/personal/workBench\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:25:15');
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"table\",\"orderNum\":\"2\",\"menuName\":\"管理工作台\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"/management/workBench\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:25:55');
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"job\",\"orderNum\":\"0\",\"menuName\":\"工作台首页\",\"params\":{},\"parentId\":2001,\"isCache\":\"1\",\"path\":\"homePage\",\"component\":\"workBench/homePage/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:28:08');
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"2\",\"menuName\":\"发起流程\",\"params\":{},\"parentId\":2001,\"isCache\":\"1\",\"path\":\"homePageAdd\",\"component\":\"workBench/homePage/add\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:29:41');
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"1\",\"icon\":\"#\",\"orderNum\":\"2\",\"menuName\":\"发起流程\",\"params\":{},\"parentId\":2001,\"isCache\":\"1\",\"path\":\"homePageAdd\",\"component\":\"workBench/homePage/add\",\"children\":[],\"createTime\":1631388581000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2004,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 03:29:51');
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"example\",\"orderNum\":\"4\",\"menuName\":\"流程引擎\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"processCore\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:09:00');
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"guide\",\"orderNum\":\"1\",\"menuName\":\"流程模型设计\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processCore/processModel\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:10:45');
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"2\",\"menuName\":\"自定义表单设计\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processCore/formModel\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:11:43');
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"system\",\"orderNum\":\"2\",\"menuName\":\"引擎设置\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"workflowConfig\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:16:34');
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"input\",\"orderNum\":\"4\",\"menuName\":\"引擎运行时信息\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processMeta\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:17:53');
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"2\",\"menuName\":\"自定义表单设计\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processCore/formModel\",\"children\":[],\"createTime\":1631394703000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:18:36');
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"dict\",\"orderNum\":\"0\",\"menuName\":\"引擎服务\",\"params\":{},\"parentId\":4,\"isCache\":\"0\",\"path\":\"processCore/processServiceManagement\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"M\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:20:55');
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"dict\",\"orderNum\":\"0\",\"menuName\":\"引擎服务\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processCore/processServiceManagement\",\"children\":[],\"createTime\":1631395255000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2010,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:22:04');
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processServiceManagement/processSerivceCategory\",\"component\":\"processService/processSerivceCategory/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:30:46');
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2005,\"isCache\":\"1\",\"path\":\"processServiceManagement/processSerivceCategory\",\"component\":\"processService/processSerivceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:46:49');
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2005,\"isCache\":\"1\",\"path\":\"processServiceManagement/processSerivceCategory\",\"component\":\"processservice/processSerivceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:48:43');
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2005,\"isCache\":\"1\",\"path\":\"processServiceManagement/processSerivceCategory\",\"component\":\"processService/processSerivceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:49:22');
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2005,\"isCache\":\"1\",\"path\":\"processServiceManagement/processSerivceCategory\",\"component\":\"processService/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:50:05');
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2005,\"isCache\":\"1\",\"path\":\"processService/processServiceCategory/index\",\"component\":\"processCore/processService/processServiceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:53:34');
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processService/processServiceCategory/index\",\"component\":\"processCore/processService/processServiceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 05:55:04');
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processService/processServiceCategory/index\",\"component\":\"processCore/processService/processSerivceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 06:18:15');
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"date-range\",\"orderNum\":\"2\",\"menuName\":\"服务配置\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processSerivceConfig/index\",\"component\":\"processCore/processService/processSerivceConfig/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:10:40');
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"date-range\",\"orderNum\":\"2\",\"menuName\":\"服务配置\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processSerivceConfig/index\",\"component\":\"processCore/processService/processServiceConfig/index\",\"children\":[],\"createTime\":1631416240000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2012,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:15:59');
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"edit\",\"orderNum\":\"1\",\"menuName\":\"待办个人任务\",\"params\":{},\"parentId\":2002,\"isCache\":\"1\",\"path\":\"workMenuTodo\",\"component\":\"workBench/todo/PersonalMission\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:18:30');
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"button\",\"orderNum\":\"2\",\"menuName\":\"待办组任务\",\"params\":{},\"parentId\":2002,\"isCache\":\"1\",\"path\":\"workMenuGroup\",\"component\":\"workBench/group/GroupMission\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:19:13');
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"skill\",\"orderNum\":\"3\",\"menuName\":\"已办任务\",\"params\":{},\"parentId\":2002,\"isCache\":\"0\",\"path\":\"workMenuDone\",\"component\":\"workBench/done/DoneMission\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:20:11');
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"time\",\"orderNum\":\"4\",\"menuName\":\"限时任务\",\"params\":{},\"parentId\":2002,\"isCache\":\"1\",\"path\":\"workMenu/overTime\",\"component\":\"workBench/overTime/overTime\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:21:07');
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"post\",\"orderNum\":\"5\",\"menuName\":\"我发起的流程\",\"params\":{},\"parentId\":2002,\"isCache\":\"1\",\"path\":\"workMenuMyProcess\",\"component\":\"workBench/sent/SentMission\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:22:19');
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"1\",\"menuName\":\"流程分类\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processCategory\",\"component\":\"processCategory/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:28:55');
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"2\",\"menuName\":\"流程模型\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processModelInfo\",\"component\":\"processmanager/processModelInfo/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:29:56');
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"3\",\"menuName\":\"流程模型设计器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processModelDesign\",\"component\":\"processmanager/processModelDesign/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:31:20');
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"4\",\"menuName\":\"流程表达式\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processExpression\",\"component\":\"processmanager/processExpression/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:32:15');
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"1\",\"icon\":\"#\",\"orderNum\":\"3\",\"menuName\":\"流程模型设计器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processModelDesign\",\"component\":\"processmanager/processModelDesign/index\",\"children\":[],\"createTime\":1631417480000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2020,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:32:37');
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"5\",\"menuName\":\"流程监听器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processListener\",\"component\":\"processmanager/processListener/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:33:56');
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"6\",\"menuName\":\"流程审核按钮\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processButton\",\"component\":\"processmanager/processButton/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:34:41');
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"5\",\"menuName\":\"流程监听器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processListener\",\"component\":\"processCore/processService/processListener/index\",\"children\":[],\"createTime\":1631417636000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2022,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:53:52');
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"6\",\"menuName\":\"流程审核按钮\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processButton\",\"component\":\"processCore/processService/processButton/index\",\"children\":[],\"createTime\":1631417681000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2023,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:54:23');
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"4\",\"menuName\":\"流程表达式\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processExpression\",\"component\":\"processCore/processService/processExpression/index\",\"children\":[],\"createTime\":1631417535000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2021,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:54:53');
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"2\",\"menuName\":\"流程模型\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processModelInfo\",\"component\":\"processCore/processService/processModelInfo/index\",\"children\":[],\"createTime\":1631417396000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2019,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 11:55:39');
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"流程分类\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processCategory\",\"component\":\"processCore/processService/processCategory/index\",\"children\":[],\"createTime\":1631417335000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2018,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:01:23');
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"system\",\"orderNum\":\"4\",\"menuName\":\"引擎设置\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"workflowConfig\",\"children\":[],\"createTime\":1631394994000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2008,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:07:36');
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"input\",\"orderNum\":\"3\",\"menuName\":\"引擎运行时信息\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processMeta\",\"children\":[],\"createTime\":1631395073000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2009,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:07:41');
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"1\",\"menuName\":\"流程定义\",\"params\":{},\"parentId\":2009,\"isCache\":\"1\",\"path\":\"processMeta/processDef\",\"component\":\"processMeta/processDef\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:08:40');
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"流程定义\",\"params\":{},\"parentId\":2009,\"isCache\":\"1\",\"path\":\"processMeta/processDef\",\"component\":\"processCore/processMeta/definition/index\",\"children\":[],\"createTime\":1631419720000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2024,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:38:54');
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 1, 'com.workflow.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"1\",\"menuName\":\"租户管理\",\"params\":{},\"parentId\":2008,\"isCache\":\"1\",\"path\":\"processTenant\",\"component\":\"processmanager/processTenant/index\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:47:28');
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"租户管理\",\"params\":{},\"parentId\":2008,\"isCache\":\"1\",\"path\":\"workflowConfig/workflowTenant\",\"component\":\"processmanager/processTenant/index\",\"children\":[],\"createTime\":1631422048000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2025,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:48:06');
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"租户管理\",\"params\":{},\"parentId\":2008,\"isCache\":\"1\",\"path\":\"processConfig/processTenant\",\"component\":\"processCore/processConfig/processTenant/index\",\"children\":[],\"createTime\":1631422048000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2025,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:52:21');
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"system\",\"orderNum\":\"4\",\"menuName\":\"引擎设置\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processConfig\",\"children\":[],\"createTime\":1631394994000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2008,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 12:52:32');
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"build\",\"orderNum\":\"1\",\"menuName\":\"表单构建\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"path\":\"build\",\"component\":\"tool/build/index\",\"children\":[],\"createTime\":1631247154000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":114,\"menuType\":\"C\",\"perms\":\"tool:build:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:00:27');
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"cascader\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processService/processServiceCategory/index\",\"component\":\"processCore/processService/processSerivceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:01:59');
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"cascader\",\"orderNum\":\"1\",\"menuName\":\"流程分类\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processCategory\",\"component\":\"processCore/processService/processCategory/index\",\"children\":[],\"createTime\":1631417335000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2018,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:02:09');
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"example\",\"orderNum\":\"2\",\"menuName\":\"流程模型\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processModelInfo\",\"component\":\"processCore/processService/processModelInfo/index\",\"children\":[],\"createTime\":1631417396000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2019,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:02:24');
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"language\",\"orderNum\":\"4\",\"menuName\":\"流程表达式\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processExpression\",\"component\":\"processCore/processService/processExpression/index\",\"children\":[],\"createTime\":1631417535000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2021,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:02:52');
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"message\",\"orderNum\":\"5\",\"menuName\":\"流程监听器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processListener\",\"component\":\"processCore/processService/processListener/index\",\"children\":[],\"createTime\":1631417636000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2022,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:03:02');
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"button\",\"orderNum\":\"6\",\"menuName\":\"流程审核按钮\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processButton\",\"component\":\"processCore/processService/processButton/index\",\"children\":[],\"createTime\":1631417681000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2023,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:03:09');
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"international\",\"orderNum\":\"1\",\"menuName\":\"租户管理\",\"params\":{},\"parentId\":2008,\"isCache\":\"1\",\"path\":\"processConfig/processTenant\",\"component\":\"processCore/processConfig/processTenant/index\",\"children\":[],\"createTime\":1631422048000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2025,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:04:00');
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"icon\",\"orderNum\":\"1\",\"menuName\":\"流程定义\",\"params\":{},\"parentId\":2009,\"isCache\":\"1\",\"path\":\"processMeta/processDef\",\"component\":\"processCore/processMeta/definition/index\",\"children\":[],\"createTime\":1631419720000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2024,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:04:21');
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"1\",\"icon\":\"#\",\"orderNum\":\"3\",\"menuName\":\"流程模型设计器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCore/processModel/processModelDesign\",\"component\":\"processCore/processService/processModelDesign/index\",\"children\":[],\"createTime\":1631417480000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2020,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:38:06');
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"dict\",\"orderNum\":\"0\",\"menuName\":\"引擎服务\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processServiceManagement\",\"children\":[],\"createTime\":1631395255000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2010,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:40:54');
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"guide\",\"orderNum\":\"1\",\"menuName\":\"流程模型设计\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"processModel\",\"children\":[],\"createTime\":1631394645000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2006,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:41:02');
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"2\",\"menuName\":\"自定义表单设计\",\"params\":{},\"parentId\":2005,\"isCache\":\"0\",\"path\":\"formModel\",\"children\":[],\"createTime\":1631394703000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2007,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:41:09');
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"cascader\",\"orderNum\":\"1\",\"menuName\":\"服务分类\",\"params\":{},\"parentId\":2010,\"isCache\":\"1\",\"path\":\"processServiceCategory/index\",\"component\":\"processCore/processService/processSerivceCategory/index\",\"children\":[],\"createTime\":1631395846000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2011,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:41:34');
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"cascader\",\"orderNum\":\"1\",\"menuName\":\"流程分类\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processCategory\",\"component\":\"processCore/processService/processCategory/index\",\"children\":[],\"createTime\":1631417335000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2018,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:42:11');
INSERT INTO `sys_oper_log` VALUES (168, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"example\",\"orderNum\":\"2\",\"menuName\":\"流程模型\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processModelInfo\",\"component\":\"processCore/processService/processModelInfo/index\",\"children\":[],\"createTime\":1631417396000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2019,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:42:51');
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"1\",\"icon\":\"#\",\"orderNum\":\"3\",\"menuName\":\"流程模型设计器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processModelDesign\",\"component\":\"processCore/processService/processModelDesign/index\",\"children\":[],\"createTime\":1631417480000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2020,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:43:00');
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"language\",\"orderNum\":\"4\",\"menuName\":\"流程表达式\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processExpression\",\"component\":\"processCore/processService/processExpression/index\",\"children\":[],\"createTime\":1631417535000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2021,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:43:11');
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"message\",\"orderNum\":\"5\",\"menuName\":\"流程监听器\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processListener\",\"component\":\"processCore/processService/processListener/index\",\"children\":[],\"createTime\":1631417636000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2022,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:43:19');
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"button\",\"orderNum\":\"6\",\"menuName\":\"流程审核按钮\",\"params\":{},\"parentId\":2006,\"isCache\":\"1\",\"path\":\"processButton\",\"component\":\"processCore/processService/processButton/index\",\"children\":[],\"createTime\":1631417681000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2023,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 13:43:27');
INSERT INTO `sys_oper_log` VALUES (173, '菜单管理', 2, 'com.workflow.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"query\":\"\",\"icon\":\"guide\",\"orderNum\":\"5\",\"menuName\":\"数据迁移\",\"params\":{},\"parentId\":0,\"isCache\":\"0\",\"path\":\"http://localhost\",\"children\":[],\"createTime\":1631247154000,\"updateBy\":\"admin\",\"isFrame\":\"0\",\"menuId\":4,\"menuType\":\"M\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-09-12 14:33:05');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-09-10 12:12:34', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-09-10 12:12:34', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2021-09-10 12:12:34', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '管理员', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2021-09-13 11:48:11', 'admin', '2021-09-10 12:12:34', '', '2021-09-13 03:48:10', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '管理员', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2021-09-10 12:12:34', 'admin', '2021-09-10 12:12:34', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Table structure for work_flow_button
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_button`;
CREATE TABLE `work_flow_button`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `button_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮名称',
  `button_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `button_type` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮类型',
  `system_button` int(1) NULL DEFAULT 1 COMMENT '是否为系统按钮，0：否，1：是',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述信息',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '按钮排序',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识0表示删除1表示存在',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `un_button_code`(`button_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程按钮' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_button
-- ----------------------------
INSERT INTO `work_flow_button` VALUES (1, '任务审批同意', '_flow_task_complete', '/flowable/task/complete', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:26:43', '2021-07-21 07:26:43', NULL, 0);
INSERT INTO `work_flow_button` VALUES (2, '任务审批拒绝', '_flow_task_reject', NULL, 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:26:46', '2021-07-21 07:26:46', NULL, 1);
INSERT INTO `work_flow_button` VALUES (3, '任务指定驳回', '_flow_task_back_step', '/flowable/task/doBackStep', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:27:25', NULL, NULL, 0);
INSERT INTO `work_flow_button` VALUES (4, '任务转办', '_flow_task_turn', '/flowable/task/turnTask', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:28:02', NULL, NULL, 0);
INSERT INTO `work_flow_button` VALUES (5, '任务委派', '_flow_task_delegate', '/flowable/task/delegateTask', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:28:41', NULL, NULL, 0);
INSERT INTO `work_flow_button` VALUES (6, '签章', '_flow_sign', NULL, 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:29:15', '2021-07-21 07:29:15', NULL, 1);
INSERT INTO `work_flow_button` VALUES (7, '任务向前加签', '_flow_task_before_add_sign', '/flowable/task/beforeAddSignTask', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:30:09', NULL, NULL, 0);
INSERT INTO `work_flow_button` VALUES (8, '任务向后加签', '_flow_task_after_add_sign', '/flowable/task/afterAddSignTask', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:30:43', NULL, NULL, 0);
INSERT INTO `work_flow_button` VALUES (9, '流程强制结束', '_flow_process_stop', '/flowable/task/stopProcess', 'PROCESS', 1, NULL, 0, NULL, '2021-07-23 13:53:53', '2021-07-23 13:53:53', NULL, 0);
INSERT INTO `work_flow_button` VALUES (10, '流程撤销', '_flow_process_revoke', '/flowable/task/revokeProcess', 'PROCESS', 1, NULL, 0, NULL, '2021-07-23 13:54:03', '2021-07-23 13:54:03', NULL, 0);
INSERT INTO `work_flow_button` VALUES (11, '归还任务', '_flow_task_un_claim', '/flowable/task/unClaimTask', 'TODO', 1, NULL, 0, NULL, '2021-07-21 07:36:52', '2021-07-21 07:36:52', NULL, 0);
INSERT INTO `work_flow_button` VALUES (12, '撤回任务', '_flow_task_rollback', '/flowable/task/rollback', 'DONE', 1, NULL, 0, NULL, '2021-07-21 07:37:58', '2021-07-21 07:37:58', NULL, 0);
INSERT INTO `work_flow_button` VALUES (13, '协同', '_flow_task_synergy', '/flowable/task/synergyTask', 'TODO', 1, '1', 12, 'admin', '2021-07-23 16:28:15', '2021-07-23 16:28:15', 'admin', 0);

-- ----------------------------
-- Table structure for work_flow_category
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_category`;
CREATE TABLE `work_flow_category`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `parent_id` int(32) NULL DEFAULT 0 COMMENT '父编号',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_category
-- ----------------------------
INSERT INTO `work_flow_category` VALUES (1, '土豆科技流程测试1', 0, '测试', NULL, '2021-07-22 09:02:35', '2021-09-03 21:33:59', 'admin', 0);
INSERT INTO `work_flow_category` VALUES (2, '土豆科技流程测试2', 0, '测试', NULL, '2021-07-22 09:03:07', '2021-09-03 21:33:55', 'admin', 0);
INSERT INTO `work_flow_category` VALUES (3, '土豆科技流程测试3', 0, '测试', NULL, '2021-07-22 09:03:25', '2021-09-03 21:34:06', 'admin', 0);
INSERT INTO `work_flow_category` VALUES (4, '土豆科技流程测试4', 1, '测试', NULL, '2021-07-22 09:03:57', '2021-09-03 21:34:14', 'admin', 0);
INSERT INTO `work_flow_category` VALUES (5, '土豆科技流程测试5', 2, '测试', NULL, '2021-07-22 09:04:23', '2021-09-03 21:34:23', 'admin', 0);
INSERT INTO `work_flow_category` VALUES (6, '土豆科技流程测试6', 3, '测试', NULL, '2021-07-22 09:04:52', '2021-09-03 21:34:31', 'admin', 0);
INSERT INTO `work_flow_category` VALUES (7, '111', 0, '111', 'admin', '2021-08-12 09:26:38', '2021-08-12 09:26:38', 'admin', 1);

-- ----------------------------
-- Table structure for work_flow_email
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_email`;
CREATE TABLE `work_flow_email`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tennat_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '租户标示',
  `mail_server_host` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱服务eg:smtp.163.com',
  `mail_server_port` int(11) NULL DEFAULT 0 COMMENT '邮箱服务端口eg:465',
  `mail_default_from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱服务默认发送邮箱',
  `mail_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱服务',
  `mail_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统url前缀',
  `mail_ssl` int(11) NULL DEFAULT 0 COMMENT '是否使用SSL-0-是  1-否',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱备注',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '租户邮箱服务配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_email
-- ----------------------------
INSERT INTO `work_flow_email` VALUES (1, 'ZZMT', 'smtp.163.com', 465, '17757144205@163.com', '17757144205@163.com', 'RSSTMECTOYKCWAZC', 1, NULL, NULL, '2021-09-06 06:19:08', '2021-09-06 06:19:08', NULL, 0);

-- ----------------------------
-- Table structure for work_flow_expression
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_expression`;
CREATE TABLE `work_flow_expression`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `expression_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表达式名称',
  `expression_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表达式内容',
  `system_expression` tinyint(1) NULL DEFAULT 0 COMMENT '是否为系统表达式,0:是，1:否',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述信息',
  `creator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识0表示删除1表示存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '流程表达式' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_expression
-- ----------------------------
INSERT INTO `work_flow_expression` VALUES (4, 'ss', 'ss', 1, 'ss', NULL, '2021-09-01 07:56:20', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (5, '333', '333', 0, '333', NULL, '2021-09-01 08:05:12', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (6, 'aa', 'aa', 0, 'aa', NULL, '2021-09-03 14:10:09', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (7, 'bb', 'bb', 0, 'bb', NULL, '2021-09-03 14:10:17', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (8, 'cc', 'cc', 0, 'cc', NULL, '2021-09-03 14:10:24', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (9, 'dd', 'dd', 0, 'dd', NULL, '2021-09-03 14:10:31', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (10, 'ee', 'ee', 0, 'ee', NULL, '2021-09-03 14:10:39', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (11, 'ff', 'ff', 0, 'ff', NULL, '2021-09-03 14:10:47', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (12, 'gg', 'gg', 0, 'gg', NULL, '2021-09-03 14:10:56', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (13, 'qq', 'qq', 0, 'qq', NULL, '2021-09-03 14:11:11', NULL, NULL, 0);
INSERT INTO `work_flow_expression` VALUES (14, 'rr', 'rr', 0, 'rr', NULL, '2021-09-03 14:11:22', NULL, NULL, 0);

-- ----------------------------
-- Table structure for work_flow_extend_hisprocinst
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_extend_hisprocinst`;
CREATE TABLE `work_flow_extend_hisprocinst`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` int(32) NULL DEFAULT NULL COMMENT '服务ID',
  `model_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型key',
  `process_instance_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例ID',
  `process_definition_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程定义ID',
  `business_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务单据KEY',
  `process_name` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程名称',
  `process_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `tenant_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '租户id(系统标识)',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识0表示删除1表示存在',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `process_instance_id_index`(`process_instance_id`) USING BTREE,
  INDEX `creator_index`(`creator`) USING BTREE,
  INDEX `model_key_index`(`model_key`) USING BTREE,
  INDEX `process_definition_id_index`(`process_definition_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程引擎扩展表-主要记录流程实例运行状态' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_extend_hisprocinst
-- ----------------------------
INSERT INTO `work_flow_extend_hisprocinst` VALUES (1, 1, 'ZZMT01', '2501', 'ZZMT01:1:4', '7622356239519744', '株洲矛盾调解流程【2021-07-21 15:16:21】', 'SPZ', 'ZZMT', 'admin', '2021-07-24 14:26:16', '2021-07-24 14:26:16', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (2, 1, 'ZZMT01', '5001', 'ZZMT01:1:4', '7624571171770368', '株洲矛盾调解流程【2021-07-21 15:25:09】', 'SPZ', 'ZZMT', 'admin', '2021-07-24 14:26:44', '2021-07-24 14:26:44', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (3, 1, 'ZZMT01', '5010', 'ZZMT01:1:4', '7625621639401472', '株洲矛盾调解流程【2021-07-21 15:29:20】', 'SPZ', 'ZZMT', 'admin', '2021-08-26 09:03:01', '2021-08-26 09:03:01', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (4, 1, 'ZZMT01', '5019', 'ZZMT01:1:4', '7625626374770688', '株洲矛盾调解流程【2021-07-21 15:29:21】', 'SPZ', 'ZZMT', 'admin', '2021-07-24 14:27:24', '2021-07-24 14:27:24', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (5, 1, 'ZZMT01', '5028', 'ZZMT01:1:4', '7625631147888640', '株洲矛盾调解流程【2021-07-21 15:29:22】', 'BJ', 'ZZMT', 'admin', '2021-08-21 07:52:11', '2021-08-21 07:52:11', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (6, 1, 'ZZMT01', '5037', 'ZZMT01:1:4', '7625638731190272', '株洲矛盾调解流程【2021-07-21 15:29:24】', 'ZZ', 'ZZMT', 'admin', '2021-07-23 11:36:31', '2021-07-23 11:36:31', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (7, 1, 'ZZMT01', '7501', 'ZZMT01:1:4', '7636346831245312', '株洲矛盾调解流程【2021-07-21 16:11:57】', 'ZZ', 'ZZMT', 'admin', '2021-07-23 11:37:50', '2021-07-23 11:37:50', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (8, 1, 'ZZMT01', '10001', 'ZZMT01:1:4', '7637590484324352', '株洲矛盾调解流程【2021-07-21 16:16:53】', 'SPZ', 'ZZMT', 'admin', '2021-07-24 14:20:26', '2021-07-24 14:20:26', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (9, 3, 'ZZMT01', '37501', 'ZZMT01:1:4', '8278593557893120', '株洲矛盾调解流程【2021-07-23 10:44:00】', 'QZJS', 'ZZMT', 'admin', '2021-07-23 14:15:47', '2021-07-23 14:15:47', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (10, 3, 'ZZMT01', '37510', 'ZZMT01:1:4', '8278768762359808', '株洲矛盾调解流程【2021-07-23 10:44:42】', 'QZJS', 'ZZMT', 'admin', '2021-07-23 13:55:59', '2021-07-23 13:55:59', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (11, 3, 'ZZMT01', '37519', 'ZZMT01:1:4', '8279492695035904', '株洲矛盾调解流程【2021-07-23 10:47:35】', 'SPZ', 'ZZMT', 'admin', '2021-07-23 10:44:19', '2021-07-23 10:44:19', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (12, 3, 'ZZMT01', '37528', 'ZZMT01:1:4', '8280064634523648', '株洲矛盾调解流程【2021-07-23 10:49:51】', 'SPZ', 'ZZMT', 'admin', '2021-07-23 10:44:21', '2021-07-23 10:44:21', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (13, 3, 'ZZMT01', '37537', 'ZZMT01:1:4', '8280356226732032', '株洲矛盾调解流程【2021-07-23 10:51:01】', 'QZJS', 'ZZMT', 'admin', '2021-07-23 13:55:54', '2021-07-23 13:55:54', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (14, 3, 'ZZMT01', '37546', 'ZZMT01:1:4', '8281415368183808', '株洲矛盾调解流程【2021-07-23 10:55:13】', 'ZZ', 'ZZMT', 'admin', '2021-07-23 10:49:56', '2021-07-23 10:49:56', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (15, 1, 'ZZMT01', '37555', 'ZZMT01:1:4', '8327077384294400', '株洲矛盾调解流程【2021-07-23 13:56:40】', 'SPZ', 'ZZMT', 'admin', '2021-07-23 10:44:25', '2021-07-23 10:44:25', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (16, 3, 'ZZMT01', '37564', 'ZZMT01:1:4', '8327726243123200', '株洲矛盾调解流程【2021-07-23 13:59:14】', 'ZZ', 'ZZMT', 'admin', '2021-07-23 11:29:24', '2021-07-23 11:29:24', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (17, 3, 'ZZMT01', '37574', 'ZZMT01:1:4', '8328332219387904', '株洲矛盾调解流程【2021-07-23 14:01:39】', 'ZZ', 'ZZMT', 'admin', '2021-07-23 11:29:39', '2021-07-23 11:29:39', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (18, 3, 'ZZMT01', '42508', 'ZZMT01:1:4', '8393757015805952', '株洲矛盾调解流程【2021-07-23 18:21:37】', 'BJ', 'ZZMT', 'admin', '2021-07-23 10:46:03', '2021-07-23 10:46:03', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (19, 3, 'ZZMT01', '45001', 'ZZMT01:1:4', '8411681776603136', '株洲矛盾调解流程【2021-07-23 19:32:51】', 'QZJS', 'ZZMT', 'admin', '2021-07-23 13:56:02', '2021-07-23 13:56:02', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (20, 1, 'ZZMT01', '47501', 'ZZMT01:1:4', '8464901576200192', '株洲矛盾调解流程【2021-07-23 23:04:20】', 'SPZ', 'ZZMT', 'zhangsan', '2021-07-24 14:27:41', '2021-07-24 14:27:41', 'zhangsan', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (21, 1, 'ZZMT01', '50005', 'ZZMT01:2:50004', '8725872169324544', '株洲矛盾调解流程【2021-07-24 16:21:20】', 'BJ', 'ZZMT', 'admin', '2021-07-24 09:34:22', '2021-07-24 09:34:22', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (22, 1, 'ZZMT01', '60004', 'ZZMT01:3:52511', '8744500109381632', '株洲矛盾调解流程【2021-07-24 17:35:21】', 'SPZ', 'ZZMT', 'admin', '2021-07-24 09:36:16', '2021-07-24 09:36:16', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (23, 2, 'CSQJ01', '62505', 'CSQJ01:2:62504', '8979001750196224', '请假【2021-07-25 09:07:11】', 'SPZ', 'CSLC', 'admin', '2021-07-25 09:07:11', '2021-07-25 09:07:11', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (24, 1, 'ZZMT01', '67507', 'ZZMT01:3:52511', '9392654412550144', '株洲矛盾调解流程【2021-07-26 12:30:53】', 'BJ', 'ZZMT', 'admin', '2021-07-26 05:07:15', '2021-07-26 05:07:15', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (25, 1, 'ZZMT01', '67549', 'ZZMT01:4:67506', '9425742362447872', '株洲矛盾调解流程【2021-07-26 14:42:22】', 'BJ', 'ZZMT', 'admin', '2021-07-26 06:46:08', '2021-07-26 06:46:08', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (26, 1, 'ZZMT01', '67578', 'ZZMT01:4:67506', '9426854918361088', '株洲矛盾调解流程【2021-07-26 14:46:47】', 'SPZ', 'ZZMT', 'zhangsan', '2021-08-09 07:41:42', '2021-08-09 07:41:42', 'zhangsan', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (27, 1, 'ZZMT01', '70007', 'ZZMT01:4:67506', '9447877948608512', '株洲矛盾调解流程【2021-07-26 16:10:19】', 'SPZ', 'ZZMT', 'admin', '2021-07-26 16:10:20', '2021-07-26 16:10:20', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (28, 1, 'ZZMT01', '72506', 'ZZMT01:5:72505', '9512344875044864', '株洲矛盾调解流程【2021-07-26 20:26:30】', 'SPZ', 'ZZMT', 'admin', '2021-07-26 20:26:30', '2021-07-26 20:26:30', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (29, 2, 'CSQJ01', '75013', 'CSQJ01:3:75012', '10259994054365184', '请假【2021-07-28 21:57:23】', 'SPZ', 'CSLC', 'admin', '2021-07-28 21:57:24', '2021-07-28 21:57:24', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (30, 2, 'CSQJ01', '75028', 'CSQJ01:3:75012', '10264829050884096', '请假【2021-07-28 22:16:36】', 'SPZ', 'CSLC', 'lisi', '2021-07-28 22:16:36', '2021-07-28 22:16:36', 'lisi', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (31, 4, 'xueyanceshi', '80013', 'xueyanceshi:1:80012', '11983735096479744', 'xueyan测试监听器【2021-08-02 16:06:55】', 'BJ', 'ZZMT', 'admin', '2021-08-02 08:41:18', '2021-08-02 08:41:18', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (32, 5, 'TJLCMX', '85005', 'TJLCMX:1:85004', '12681595588841472', '调解流程模型【2021-08-04 14:19:58】', 'SPZ', 'ZZMT', 'admin', '2021-08-04 14:19:59', '2021-08-04 14:19:59', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (33, 6, 'CSJTQ', '87522', 'CSJTQ:2:87521', '14880649194377216', '111【2021-08-10 15:58:13】', 'SPZ', 'CSLC', 'admin', '2021-08-10 15:58:14', '2021-08-10 15:58:14', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (34, 6, 'CSJTQ', '87533', 'CSJTQ:3:87532', '14881431192997888', '111【2021-08-10 16:01:20】', 'SPZ', 'CSLC', 'admin', '2021-08-10 16:01:20', '2021-08-10 16:01:20', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (35, 6, 'CSJTQ', '87540', 'CSJTQ:3:87532', '14884108488544256', '111【2021-08-10 16:11:58】', 'SPZ', 'CSLC', 'admin', '2021-08-10 16:11:58', '2021-08-10 16:11:58', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (36, 5, 'TJLCMX', '87547', 'TJLCMX:1:85004', '14887976781877248', '调解流程模型【2021-08-10 16:27:20】', 'SPZ', 'ZZMT', 'admin', '2021-08-10 16:27:21', '2021-08-10 16:27:21', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (37, 1, 'ZZMT01', '87556', 'ZZMT01:6:75008', '14887998156050432', '株洲矛盾调解流程【2021-08-10 16:27:25】', 'SPZ', 'ZZMT', 'admin', '2021-08-10 16:27:26', '2021-08-10 16:27:26', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (38, 6, 'cs81002', '87569', 'cs81002:1:87568', '14894806698430464', '株洲矛盾调解流程【2021-08-10 16:54:28】', 'SPZ', 'ZZMT', 'admin', '2021-08-10 16:54:29', '2021-08-10 16:54:29', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (39, 6, 'CSJTQ', '87580', 'CSJTQ:3:87532', '14905437287747584', '111【2021-08-10 17:36:43】', 'SPZ', 'CSLC', 'admin', '2021-08-10 17:36:44', '2021-08-10 17:36:44', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (40, 6, 'CSJTQ', '87591', 'CSJTQ:5:87590', '14905777919758336', '111【2021-08-10 17:38:04】', 'SPZ', 'CSLC', 'admin', '2021-08-10 17:38:05', '2021-08-10 17:38:05', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (41, 5, 'TJLCMX', '92505', 'TJLCMX:2:92504', '15695296378048512', '调解流程模型【2021-08-12 21:55:20】', 'SPZ', 'ZZMT', 'admin', '2021-08-12 21:55:21', '2021-08-12 21:55:21', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (42, 5, 'TJLCMX', '92527', 'TJLCMX:2:92504', '15890871622963200', '调解流程模型【2021-08-13 10:52:29】', 'SPZ', 'ZZMT', 'admin', '2021-08-13 14:08:06', '2021-08-13 14:08:06', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (43, 6, 'CSJTQ', '92558', 'CSJTQ:5:87590', '17422568055246848', '111【2021-08-17 16:18:54】', 'SPZ', 'CSLC', 'admin', '2021-08-17 16:18:55', '2021-08-17 16:18:55', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (44, 7, 'CSJTQ', '92573', 'CSJTQ:6:92572', '17423179140173824', '111【2021-08-17 16:21:19】', 'SPZ', 'CSLC', 'admin', '2021-08-17 16:21:20', '2021-08-17 16:21:20', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (45, 2, 'leave', '5', 'leave:1:4', '20981245748056064', '请假【2021-08-27 11:59:49】', 'SPZ', 'CSLC', 'admin', '2021-08-27 11:59:49', '2021-08-27 11:59:49', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (46, 10, 'Process_1630139906507', '5005', 'Process_1630139906507:3:5004', '21730119769001984', '业务流程_1630139906507【2021-08-29 13:35:34】', 'SPZ', 'CSLC', 'admin', '2021-08-29 13:35:35', '2021-08-29 13:35:35', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (47, 11, 'Process_1629944446452', '7515', 'Process_1629944446452:2:7514', '22164802659028992', '业务流程_1629944446452【2021-08-30 18:22:51】', 'SPZ', 'CSLC', 'admin', '2021-08-30 18:22:51', '2021-08-30 18:22:51', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (48, 11, 'Process_1629944446452', '7524', 'Process_1629944446452:2:7514', '22164887388164096', '业务流程_1629944446452【2021-08-30 18:23:11】', 'SPZ', 'CSLC', 'admin', '2021-08-30 18:23:11', '2021-08-30 18:23:11', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (49, 11, 'Process_1629944446452', '10014', 'Process_1629944446452:5:10013', '22186853641883648', '业务流程_1629944446452【2021-08-30 19:50:28】', 'SPZ', 'CSLC', 'admin', '2021-08-30 19:50:29', '2021-08-30 19:50:29', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (50, 11, 'Process_1629944446452', '10023', 'Process_1629944446452:5:10013', '22186930427006976', '业务流程_1629944446452【2021-08-30 19:50:46】', 'SPZ', 'CSLC', 'admin', '2021-08-30 19:50:47', '2021-08-30 19:50:47', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (51, 11, 'Process_1629944446452', '12509', 'Process_1629944446452:7:12508', '23188296922435584', '测试监听器【2021-09-02 14:09:51】', 'SPZ', 'CSLC', 'admin', '2021-09-02 14:09:52', '2021-09-02 14:09:52', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (52, 11, 'Process_1629944446452', '12518', 'Process_1629944446452:7:12508', '23188744370786304', '测试监听器【2021-09-02 14:11:37】', 'SPZ', 'CSLC', 'admin', '2021-09-02 14:11:38', '2021-09-02 14:11:38', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (53, 11, 'Process_1629944446452', '12531', 'Process_1629944446452:8:12530', '23189493834190848', '测试监听器【2021-09-02 14:14:36】', 'SPZ', 'CSLC', 'admin', '2021-09-02 14:14:37', '2021-09-02 14:14:37', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (54, 11, 'Process_1629944446452', '15001', 'Process_1629944446452:8:12530', '23190937161306112', '测试监听器【2021-09-02 14:20:20】', 'SPZ', 'CSLC', 'admin', '2021-09-02 14:20:21', '2021-09-02 14:20:21', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (55, 11, 'Process_1629944446452', '15010', 'Process_1629944446452:8:12530', '23491233989136384', '测试监听器【2021-09-03 10:13:36】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:13:37', '2021-09-03 10:13:37', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (56, 11, 'Process_1629944446452', '17501', 'Process_1629944446452:8:12530', '23492129665978368', '测试监听器【2021-09-03 10:17:10】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:17:12', '2021-09-03 10:17:12', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (57, 11, 'Process_1629944446452', '20001', 'Process_1629944446452:8:12530', '23492957692891136', '测试监听器【2021-09-03 10:20:36】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:20:59', '2021-09-03 10:20:59', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (58, 11, 'Process_1629944446452', '15023', 'Process_1629944446452:9:15022', '23494790226251776', '测试监听器【2021-09-03 10:27:44】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:27:45', '2021-09-03 10:27:45', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (59, 11, 'Process_1629944446452', '15032', 'Process_1629944446452:9:15022', '23494915048738816', '测试监听器【2021-09-03 10:28:14】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:28:15', '2021-09-03 10:28:15', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (60, 11, 'Process_1629944446452', '22501', 'Process_1629944446452:9:15022', '23495373440028672', '测试监听器【2021-09-03 10:30:08】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:31:43', '2021-09-03 10:31:43', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (61, 11, 'Process_1629944446452', '25001', 'Process_1629944446452:9:15022', '23496374343569408', '测试监听器【2021-09-03 10:34:02】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:34:54', '2021-09-03 10:34:54', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (62, 11, 'Process_1629944446452', '25010', 'Process_1629944446452:9:15022', '23497521850617856', '测试监听器【2021-09-03 10:38:36】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:44:20', '2021-09-03 10:44:20', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (63, 11, 'Process_1629944446452', '27501', 'Process_1629944446452:9:15022', '23499796027412480', '测试监听器【2021-09-03 10:47:38】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:48:25', '2021-09-03 10:48:25', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (64, 11, 'Process_1629944446452', '30001', 'Process_1629944446452:9:15022', '23500783077167104', '测试监听器【2021-09-03 10:51:33】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:56:04', '2021-09-03 10:56:04', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (65, 11, 'Process_1629944446452', '30010', 'Process_1629944446452:9:15022', '23501934245842944', '测试监听器【2021-09-03 10:56:08】', 'SPZ', 'CSLC', 'admin', '2021-09-03 10:58:35', '2021-09-03 10:58:35', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (66, 11, 'Process_1629944446452', '35001', 'Process_1629944446452:9:15022', '23504239447904256', '测试监听器【2021-09-03 11:05:17】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:06:04', '2021-09-03 11:06:04', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (67, 11, 'Process_1629944446452', '35010', 'Process_1629944446452:9:15022', '23504455823659008', '测试监听器【2021-09-03 11:06:09】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:06:20', '2021-09-03 11:06:20', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (68, 11, 'Process_1629944446452', '40001', 'Process_1629944446452:9:15022', '23507153155395584', '测试监听器【2021-09-03 11:16:53】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:17:48', '2021-09-03 11:17:48', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (69, 11, 'Process_1629944446452', '42501', 'Process_1629944446452:9:15022', '23512435520573440', '测试监听器【2021-09-03 11:37:52】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:37:53', '2021-09-03 11:37:53', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (70, 11, 'Process_1629944446452', '45001', 'Process_1629944446452:9:15022', '23512870973214720', '测试监听器【2021-09-03 11:39:35】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:40:50', '2021-09-03 11:40:50', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (71, 11, 'Process_1629944446452', '47501', 'Process_1629944446452:9:15022', '23515254248050688', '测试监听器【2021-09-03 11:49:04】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:50:19', '2021-09-03 11:50:19', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (72, 11, 'Process_1629944446452', '47510', 'Process_1629944446452:9:15022', '23515579440828416', '测试监听器【2021-09-03 11:50:21】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:51:41', '2021-09-03 11:51:41', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (73, 11, 'Process_1629944446452', '50001', 'Process_1629944446452:9:15022', '23516234280734720', '测试监听器【2021-09-03 11:52:57】', 'SPZ', 'CSLC', 'admin', '2021-09-03 11:52:59', '2021-09-03 11:52:59', 'admin', 0);
INSERT INTO `work_flow_extend_hisprocinst` VALUES (74, 2, 'leave', '5', 'leave:1:4', '26019871997431808', '请假【2021-09-10 09:41:31】', 'SPZ', 'CSLC', 'admin', '2021-09-10 09:41:31', '2021-09-10 09:41:31', 'admin', 0);

-- ----------------------------
-- Table structure for work_flow_form_category
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_form_category`;
CREATE TABLE `work_flow_form_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类编码',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '上级分类id',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '表单分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_form_model
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_form_model`;
CREATE TABLE `work_flow_form_model`  (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_info_id` int(11) NULL DEFAULT NULL COMMENT '表单模型id',
  `form_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单唯一标识Key：用于关联流程',
  `form_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '表单配置json',
  `form_type` tinyint(1) NULL DEFAULT 0 COMMENT '状态值-0：pc表单 1：移动端表单',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态1-未发布，2-已发布',
  `main_version` tinyint(1) NULL DEFAULT 0 COMMENT '是否为主版本',
  `config_json` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '表单表头字段配置',
  `release_note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版本说明',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本号',
  `creator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`model_id`) USING BTREE,
  UNIQUE INDEX `idx_unique_form_key`(`form_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '自定义表单模型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_form_model
-- ----------------------------
INSERT INTO `work_flow_form_model` VALUES (1, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '2021-08-05 11:27:13', NULL, NULL);

-- ----------------------------
-- Table structure for work_flow_form_model_info
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_form_model_info`;
CREATE TABLE `work_flow_form_model_info`  (
  `model_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表单模型信息主键',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '表单分类ID',
  `category_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单分类名称',
  `form_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单名称',
  `form_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主版本formKey=》用于关联工作流',
  `version` int(11) NULL DEFAULT 1 COMMENT '主版本版本号',
  `form_model_type` tinyint(1) NULL DEFAULT 0 COMMENT '默认：0-外部表单 1-自定义表单',
  `creator` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`model_info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '表单模型信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_hi_comment`;
CREATE TABLE `work_flow_hi_comment`  (
  `id` int(40) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '类型',
  `user_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工工号',
  `user_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '审批时间',
  `task_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务ID',
  `task_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `activity_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动节点ID',
  `activity_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动节点名称',
  `process_ins_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例id',
  `action` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '动作',
  `message` varchar(800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批意见',
  `create_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标识1：删除 0:存在',
  `tenant_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统标识-租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `process_ins_id_index`(`process_ins_id`) USING BTREE,
  INDEX `user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 246 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_hi_comment
-- ----------------------------
INSERT INTO `work_flow_hi_comment` VALUES (1, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:19', NULL, NULL, 'startEvent1', NULL, '5001', NULL, NULL, '2021-07-21 08:34:19', 'admin', '2021-07-21 15:25:10', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (2, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:17', NULL, NULL, 'startEvent1', NULL, '5010', NULL, NULL, '2021-07-21 08:34:17', 'admin', '2021-07-21 15:29:20', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (3, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:16', NULL, NULL, 'startEvent1', NULL, '5019', NULL, NULL, '2021-07-21 08:34:16', 'admin', '2021-07-21 15:29:21', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (4, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:15', NULL, NULL, 'startEvent1', NULL, '5028', NULL, NULL, '2021-07-21 08:34:15', 'admin', '2021-07-21 15:29:23', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (5, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:12', NULL, NULL, 'startEvent1', NULL, '5037', NULL, NULL, '2021-07-21 08:34:12', 'admin', '2021-07-21 15:29:24', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (6, 'SP', '1', '钟明晓', '2021-07-21 08:34:14', '5043', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5037', '', '111', '2021-07-21 08:34:14', 'admin', '2021-07-21 15:47:08', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (7, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:07', NULL, NULL, 'startEvent1', NULL, '7501', NULL, NULL, '2021-07-21 08:34:07', 'admin', '2021-07-21 16:11:58', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (8, 'FQLC', '1', '钟明晓', '2021-07-21 08:34:10', NULL, NULL, 'startEvent1', NULL, '10001', NULL, NULL, '2021-07-21 08:34:10', 'admin', '2021-07-21 16:16:54', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (9, 'SP', '1', '钟明晓', '2021-07-24 14:23:23', '2507', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '2501', '', '任务1同意', '2021-07-24 14:23:23', 'admin', '2021-07-21 16:55:47', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (10, 'SP', '1', '钟明晓', '2021-07-24 14:23:25', '5007', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5001', '', '任务1同意', '2021-07-24 14:23:25', 'admin', '2021-07-21 16:56:32', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (11, 'SP', '1', '钟明晓', '2021-07-24 14:23:27', '12513', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5001', '', '任务1=》任务2=》撤回=》任务再提交', '2021-07-24 14:23:27', 'admin', '2021-07-21 17:36:50', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (12, 'QS', '1', '钟明晓', '2021-07-24 14:23:28', '15003', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5001', '', NULL, '2021-07-24 14:23:28', 'admin', '2021-07-21 17:56:00', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (13, 'QS', '1', '钟明晓', '2021-07-24 14:23:29', '5048', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5037', '', NULL, '2021-07-24 14:23:29', 'admin', '2021-07-21 18:05:44', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (14, 'QJQ', '1', '钟明晓', '2021-07-24 14:23:30', '5016', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '', NULL, '2021-07-24 14:23:30', 'admin', '2021-07-21 18:34:50', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (15, 'HJQ', '4', '钟明晓', '2021-07-24 14:23:32', '9ed76f33-d32e-4723-bc3f-d9582c7034c2', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '', NULL, '2021-07-24 14:23:32', 'zhangsan', '2021-07-21 19:05:20', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (16, 'SP', '1', '钟明晓', '2021-07-24 14:25:34', '5034', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5028', '钟明晓 => 审批 => 任务1-分配单个人', '同意1', '2021-07-24 14:25:34', 'admin', '2021-07-22 14:22:41', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (17, 'QS', '1', '钟明晓', '2021-07-24 14:25:38', '12503', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '2501', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-24 14:25:38', 'admin', '2021-07-22 14:23:00', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (18, 'QS', '1', '钟明晓', '2021-07-24 14:25:42', '25003', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5028', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-24 14:25:42', 'admin', '2021-07-22 14:23:03', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (19, 'SP', '1', '钟明晓', '2021-07-22 15:03:55', '5025', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5019', '钟明晓 => 审批 => 任务1-分配单个人', '同意', '2021-07-22 15:03:56', 'admin', '2021-07-22 15:03:56', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (20, 'QS', '1', '钟明晓', '2021-07-22 15:04:13', '25011', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-22 15:04:13', 'admin', '2021-07-22 15:04:13', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (21, 'QJQ', '1', '钟明晓', '2021-07-22 15:04:51', '25011', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 加签 => 任务2-分配候选角色【张三,李四】', NULL, '2021-07-22 15:04:51', 'admin', '2021-07-22 15:04:51', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (25, 'SP', '4', '张三', '2021-07-22 15:17:51', '43fe8839-f78b-4334-8908-fa4bbb6a1d23', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '张三 => 审批 => 任务2-分配候选角色', '333', '2021-07-22 15:17:51', 'zhangsan', '2021-07-22 15:17:51', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (26, 'SP', '5', '李四', '2021-07-22 15:18:30', 'b1da40bb-a0bb-4e85-ba26-ffe85677f3a7', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '李四 => 审批 => 任务2-分配候选角色', '444', '2021-07-22 15:18:30', 'lisi', '2021-07-22 15:18:30', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (27, 'BH', '1', '钟明晓', '2021-07-22 15:19:26', '25011', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 驳回任务 => 【任务2-分配候选角色=>任务1-分配单个人】', NULL, '2021-07-22 15:19:26', 'admin', '2021-07-22 15:19:26', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (28, 'SP', '1', '钟明晓', '2021-07-22 15:22:11', '27504', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5019', '钟明晓 => 审批 => 任务1-分配单个人', '111', '2021-07-22 15:22:11', 'admin', '2021-07-22 15:22:11', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (29, 'QS', '1', '钟明晓', '2021-07-22 15:22:30', '27508', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-22 15:22:30', 'admin', '2021-07-22 15:22:30', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (30, 'GH', '1', '钟明晓', '2021-07-22 15:42:04', '27508', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 归还任务 => 任务2-分配候选角色', '发', '2021-07-22 15:42:04', 'admin', '2021-07-22 15:42:04', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (31, 'QS', '1', '钟明晓', '2021-07-22 16:13:57', '27508', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-22 16:13:57', 'admin', '2021-07-22 16:13:57', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (32, 'GH', '1', '钟明晓', '2021-07-22 22:19:23', '5048', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5037', '钟明晓 => 归还任务 => 任务2-分配候选角色', NULL, '2021-07-22 22:19:23', 'admin', '2021-07-22 22:19:23', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (33, 'FQLC', '1', '钟明晓', '2021-07-23 10:44:01', NULL, NULL, 'startEvent1', NULL, '37501', NULL, NULL, '2021-07-23 10:44:01', 'admin', '2021-07-23 10:44:01', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (34, 'FQLC', '1', '钟明晓', '2021-07-23 10:44:43', NULL, NULL, 'startEvent1', NULL, '37510', NULL, NULL, '2021-07-23 10:44:43', 'admin', '2021-07-23 10:44:43', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (35, 'FQLC', '1', '钟明晓', '2021-07-23 10:47:35', NULL, NULL, 'startEvent1', NULL, '37519', NULL, NULL, '2021-07-23 10:47:35', 'admin', '2021-07-23 10:47:35', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (36, 'FQLC', '1', '钟明晓', '2021-07-23 10:49:52', NULL, NULL, 'startEvent1', NULL, '37528', NULL, NULL, '2021-07-23 10:49:52', 'admin', '2021-07-23 10:49:52', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (37, 'FQLC', '1', '钟明晓', '2021-07-23 10:51:01', NULL, NULL, 'startEvent1', NULL, '37537', NULL, NULL, '2021-07-23 10:51:01', 'admin', '2021-07-23 10:51:01', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (38, 'FQLC', '1', '钟明晓', '2021-07-23 10:55:14', NULL, NULL, 'startEvent1', NULL, '37546', NULL, NULL, '2021-07-23 10:55:14', 'admin', '2021-07-23 10:55:14', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (39, 'FQLC', '1', '钟明晓', '2021-07-23 13:56:40', NULL, NULL, 'startEvent1', NULL, '37555', NULL, NULL, '2021-07-23 13:56:40', 'admin', '2021-07-23 13:56:40', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (40, 'FQLC', '1', '钟明晓', '2021-07-23 13:59:15', NULL, NULL, 'startEvent1', NULL, '37564', NULL, NULL, '2021-07-23 13:59:15', 'admin', '2021-07-23 13:59:15', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (41, 'CX', '1', '钟明晓', '2021-07-23 14:01:06', NULL, NULL, NULL, NULL, '37564', '钟明晓 => 流程撤回 => ', '111', '2021-07-23 14:01:06', 'admin', '2021-07-23 14:01:06', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (42, 'FQLC', '1', '钟明晓', '2021-07-23 14:01:40', NULL, NULL, 'startEvent1', NULL, '37574', NULL, NULL, '2021-07-23 14:01:40', 'admin', '2021-07-23 14:01:40', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (43, 'BJ', '1', '钟明晓', '2021-07-23 14:25:14', NULL, NULL, NULL, NULL, '37574', NULL, NULL, '2021-07-23 14:25:14', 'admin', '2021-07-23 14:25:14', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (44, 'LCZZ', '1', '钟明晓', '2021-07-23 14:25:14', NULL, NULL, NULL, NULL, '37574', '钟明晓 => 中止流程 ', '111', '2021-07-23 14:25:14', 'admin', '2021-07-23 14:25:14', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (45, 'SP', '1', '钟明晓', '2021-07-23 14:27:27', '37534', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '37528', '钟明晓 => 审批 => 任务1-分配单个人', '111', '2021-07-23 14:27:28', 'admin', '2021-07-23 14:27:28', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (46, 'SP', '1', '钟明晓', '2021-07-23 14:27:51', '37543', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '37537', '钟明晓 => 审批 => 任务1-分配单个人', 'ki', '2021-07-23 14:27:51', 'admin', '2021-07-23 14:27:51', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (47, 'SP', '1', '钟明晓', '2021-07-23 14:29:14', '37552', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '37546', '钟明晓 => 审批 => 任务1-分配单个人', '111', '2021-07-23 14:29:14', 'admin', '2021-07-23 14:29:14', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (48, 'SP', '1', '钟明晓', '2021-07-23 14:31:41', '37561', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '37555', '钟明晓 => 审批 => 任务1-分配单个人', '1111', '2021-07-23 14:31:41', 'admin', '2021-07-23 14:31:41', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (49, 'SP', '1', '钟明晓', '2021-07-23 14:33:06', '37525', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '37519', '钟明晓 => 审批 => 任务1-分配单个人', '112', '2021-07-23 14:33:06', 'admin', '2021-07-23 14:33:06', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (50, 'BJ', '1', '钟明晓', '2021-07-23 14:38:28', NULL, NULL, NULL, NULL, '37501', NULL, NULL, '2021-07-23 14:38:28', 'admin', '2021-07-23 14:38:28', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (51, 'LCZZ', '1', '钟明晓', '2021-07-23 14:38:28', NULL, NULL, NULL, NULL, '37501', '钟明晓 => 中止流程 ', '4545', '2021-07-23 14:38:28', 'admin', '2021-07-23 14:38:28', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (52, 'FQLC', '1', '钟明晓', '2021-07-23 18:21:38', NULL, NULL, 'startEvent1', NULL, '42508', NULL, NULL, '2021-07-23 18:21:38', 'admin', '2021-07-23 18:21:38', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (53, 'SP', '1', '钟明晓', '2021-07-23 18:44:53', '42514', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '42508', '钟明晓 => 审批 => 任务1-分配单个人', '任务1同意', '2021-07-23 18:44:53', 'admin', '2021-07-23 18:44:53', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (54, 'QS', '1', '钟明晓', '2021-07-23 18:45:03', '42519', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '42508', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-23 18:45:03', 'admin', '2021-07-23 18:45:03', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (55, 'SP', '1', '钟明晓', '2021-07-23 18:45:27', '42519', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '42508', '钟明晓 => 审批 => 任务2-分配候选角色', '任务2同意', '2021-07-23 18:45:27', 'admin', '2021-07-23 18:45:27', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (56, 'QS', '1', '钟明晓', '2021-07-23 18:45:43', '42525', '任务3-分配候选角色、人', 'Activity_0w7115l', '任务3-分配候选角色、人', '42508', '钟明晓 => 拾取任务 => 任务3-分配候选角色、人', NULL, '2021-07-23 18:45:43', 'admin', '2021-07-23 18:45:43', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (57, 'SP', '1', '钟明晓', '2021-07-23 18:46:03', '42525', '任务3-分配候选角色、人', 'Activity_0w7115l', '任务3-分配候选角色、人', '42508', '钟明晓 => 审批 => 任务3-分配候选角色、人', '任务3同意', '2021-07-23 18:46:03', 'admin', '2021-07-23 18:46:03', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (58, 'BJ', '1', '钟明晓', '2021-07-23 18:46:03', NULL, NULL, NULL, NULL, '42508', NULL, NULL, '2021-07-23 18:46:03', 'admin', '2021-07-23 18:46:03', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (59, 'BJ', '1', '钟明晓', '2021-07-23 18:49:57', NULL, NULL, NULL, NULL, '37546', NULL, NULL, '2021-07-23 18:49:57', 'admin', '2021-07-23 18:49:57', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (60, 'LCZZ', '1', '钟明晓', '2021-07-23 18:49:57', NULL, NULL, NULL, NULL, '37546', '钟明晓 => 中止流程 ', NULL, '2021-07-23 18:49:57', 'admin', '2021-07-23 18:49:57', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (61, 'CX', '1', '钟明晓', '2021-07-23 18:53:29', NULL, NULL, NULL, NULL, '37537', '钟明晓 => 流程撤回 => ', '1', '2021-07-23 18:53:30', 'admin', '2021-07-23 18:53:30', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (62, 'CX', '1', '钟明晓', '2021-07-23 19:14:08', NULL, NULL, NULL, NULL, '37510', '钟明晓 => 流程撤回 => ', '1', '2021-07-23 19:14:08', 'admin', '2021-07-23 19:14:08', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (63, 'FQLC', '1', '钟明晓', '2021-07-23 19:32:52', NULL, NULL, 'startEvent1', NULL, '45001', NULL, NULL, '2021-07-23 19:32:52', 'admin', '2021-07-23 19:32:52', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (64, 'SP', '1', '钟明晓', '2021-07-23 19:33:02', '45007', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '45001', '钟明晓 => 审批 => 任务1-分配单个人', '1', '2021-07-23 19:33:02', 'admin', '2021-07-23 19:33:02', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (65, 'QS', '1', '钟明晓', '2021-07-23 19:33:13', '45012', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '45001', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-23 19:33:13', 'admin', '2021-07-23 19:33:13', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (66, 'SP', '1', '钟明晓', '2021-07-23 19:33:27', '45012', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '45001', '钟明晓 => 审批 => 任务2-分配候选角色', '2', '2021-07-23 19:33:27', 'admin', '2021-07-23 19:33:27', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (67, 'CX', '1', '钟明晓', '2021-07-23 19:34:43', NULL, NULL, NULL, NULL, '45001', '钟明晓 => 流程撤回 => ', '3', '2021-07-23 19:34:43', 'admin', '2021-07-23 19:34:43', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (68, 'BJ', '1', '钟明晓', '2021-07-23 19:36:31', NULL, NULL, NULL, NULL, '5037', NULL, NULL, '2021-07-23 19:36:31', 'admin', '2021-07-23 19:36:31', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (69, 'LCZZ', '1', '钟明晓', '2021-07-23 19:36:32', NULL, NULL, NULL, NULL, '5037', '钟明晓 => 中止流程 ', 'zz', '2021-07-23 19:36:32', 'admin', '2021-07-23 19:36:32', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (70, 'BJ', '1', '钟明晓', '2021-07-23 19:37:51', NULL, NULL, NULL, NULL, '7501', NULL, NULL, '2021-07-23 19:37:51', 'admin', '2021-07-23 19:37:51', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (71, 'LCZZ', '1', '钟明晓', '2021-07-23 19:37:51', NULL, NULL, NULL, NULL, '7501', '钟明晓 => 中止流程 ', NULL, '2021-07-23 19:37:51', 'admin', '2021-07-23 19:37:51', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (72, 'QJQ', '5', '李四', '2021-07-23 22:19:51', '78cfe4f3-2aa0-4328-84b0-3997a6fbe5b1', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '李四 => 加签 => 任务1-分配单个人【徐九】', NULL, '2021-07-23 22:19:51', 'lisi', '2021-07-23 22:19:51', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (73, 'SP', '10', '徐九', '2021-07-23 22:20:19', 'b56c0a0a-6619-4a59-baa2-3390c130d685', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '徐九 => 审批 => 任务1-分配单个人', '999', '2021-07-23 22:20:19', 'xujiu', '2021-07-23 22:20:19', 'xujiu', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (74, 'QJQ', '7', '赵六', '2021-07-23 22:31:23', '97cf1b2b-74a6-4dac-9929-e5947e5e301e', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '赵六 => 加签 => 任务1-分配单个人【张三】', NULL, '2021-07-23 22:31:23', 'zhaoliu', '2021-07-23 22:31:23', 'zhaoliu', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (75, 'FQLC', '4', '张三', '2021-07-23 23:04:20', NULL, NULL, 'startEvent1', NULL, '47501', NULL, NULL, '2021-07-23 23:04:20', 'zhangsan', '2021-07-23 23:04:20', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (76, 'QJQ', '1', '钟明晓', '2021-07-23 23:05:30', '47507', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '47501', '钟明晓 => 加签 => 任务1-分配单个人【张三】', NULL, '2021-07-23 23:05:30', 'admin', '2021-07-23 23:05:30', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (77, 'SP', '4', '张三', '2021-07-23 23:06:09', '36f12b99-4d52-4dbc-93b9-757ef6b37d55', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '47501', '张三 => 审批 => 任务1-分配单个人', '完成前加签', '2021-07-23 23:06:09', 'zhangsan', '2021-07-23 23:06:09', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (78, 'FQLC', '1', '钟明晓', '2021-07-24 16:21:21', NULL, NULL, 'startEvent1', NULL, '50005', NULL, NULL, '2021-07-24 16:21:21', 'admin', '2021-07-24 16:21:21', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (79, 'SP', '1', '钟明晓', '2021-07-24 16:21:44', '50011', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '50005', '钟明晓 => 审批 => 任务1-分配单个人', '24日测试1', '2021-07-24 16:21:44', 'admin', '2021-07-24 16:21:44', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (80, 'QS', '1', '钟明晓', '2021-07-24 16:30:47', '50016', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '50005', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-24 16:30:47', 'admin', '2021-07-24 16:30:47', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (81, 'SP', '1', '钟明晓', '2021-07-24 16:31:17', '50016', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '50005', '钟明晓 => 审批 => 任务2-分配候选角色', '24日审批2', '2021-07-24 16:31:17', 'admin', '2021-07-24 16:31:17', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (82, 'QS', '1', '钟明晓', '2021-07-24 16:44:54', '52505', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 拾取任务 => 任务3-分配候选部门、人', NULL, '2021-07-24 16:44:54', 'admin', '2021-07-24 16:44:54', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (83, 'QJQ', '1', '钟明晓', '2021-07-24 16:46:32', '52505', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 加签 => 任务3-分配候选部门、人【张三】', NULL, '2021-07-24 16:46:32', 'admin', '2021-07-24 16:46:32', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (84, 'QJQ', '4', '张三', '2021-07-24 16:47:15', 'b28ff5c8-acb7-4bf5-89ab-d8b6772fe2a7', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '张三 => 加签 => 任务3-分配候选部门、人【李四】', NULL, '2021-07-24 16:47:15', 'zhangsan', '2021-07-24 16:47:15', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (85, 'SP', '5', '李四', '2021-07-24 16:47:52', '0bb00da8-b469-4981-8881-aa409b5fdace', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '李四 => 审批 => 任务3-分配候选部门、人', '加签再加签=》李四同意', '2021-07-24 16:47:52', 'lisi', '2021-07-24 16:47:52', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (86, 'QJQ', '1', '钟明晓', '2021-07-24 16:49:11', '52505', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 加签 => 任务3-分配候选部门、人【张三】', NULL, '2021-07-24 16:49:11', 'admin', '2021-07-24 16:49:11', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (87, 'QJQ', '4', '张三', '2021-07-24 16:50:45', 'a1794d8e-6967-4810-bb08-6e1b6698e446', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '张三 => 加签 => 任务3-分配候选部门、人【李四】', NULL, '2021-07-24 16:50:45', 'zhangsan', '2021-07-24 16:50:45', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (88, 'SP', '5', '李四', '2021-07-24 16:57:23', 'b21a527c-9c49-4d90-89ef-76de6ab03794', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '李四 => 审批 => 任务3-分配候选部门、人', NULL, '2021-07-24 16:57:23', 'lisi', '2021-07-24 16:57:23', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (89, 'QJQ', '1', '钟明晓', '2021-07-24 16:58:01', '52505', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 加签 => 任务3-分配候选部门、人【张三】', NULL, '2021-07-24 16:58:01', 'admin', '2021-07-24 16:58:01', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (90, 'QJQ', '4', '张三', '2021-07-24 17:01:46', 'eca417fb-102c-45b0-b11c-6592b662efad', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '张三 => 加签 => 任务3-分配候选部门、人【李四】', NULL, '2021-07-24 17:01:48', 'zhangsan', '2021-07-24 17:01:48', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (91, 'SP', '5', '李四', '2021-07-24 17:13:32', '337f2bfd-0582-4910-9834-b896d7d337ab', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '李四 => 审批 => 任务3-分配候选部门、人', NULL, '2021-07-24 17:13:32', 'lisi', '2021-07-24 17:13:32', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (92, 'QJQ', '1', '钟明晓', '2021-07-24 17:14:10', '52505', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 加签 => 任务3-分配候选部门、人【张三】', NULL, '2021-07-24 17:14:10', 'admin', '2021-07-24 17:14:10', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (93, 'QJQ', '4', '张三', '2021-07-24 17:14:33', 'a5ae9ad3-7f9a-4e9a-90da-0fdee9367515', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '张三 => 加签 => 任务3-分配候选部门、人【李四】', NULL, '2021-07-24 17:14:33', 'zhangsan', '2021-07-24 17:14:33', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (94, 'SP', '4', '张三', '2021-07-24 17:22:07', 'd684e991-6eb0-4579-8d8a-3124da22db24', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '张三 => 审批 => 任务3-分配候选部门、人', NULL, '2021-07-24 17:22:07', 'zhangsan', '2021-07-24 17:22:07', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (95, 'SP', '5', '李四', '2021-07-24 17:22:40', '83927731-c46c-4e20-a67a-03d9f793ed69', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '李四 => 审批 => 任务3-分配候选部门、人', '3-4', '2021-07-24 17:22:40', 'lisi', '2021-07-24 17:22:40', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (96, 'SP', '4', '张三', '2021-07-24 17:31:54', 'a5ae9ad3-7f9a-4e9a-90da-0fdee9367515', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '张三 => 审批 => 任务3-分配候选部门、人', NULL, '2021-07-24 17:31:54', 'zhangsan', '2021-07-24 17:31:54', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (97, 'SP', '1', '钟明晓', '2021-07-24 17:32:40', '4f075650-6694-4296-ad36-c8506dcf34cb', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 审批 => 任务3-分配候选部门、人', NULL, '2021-07-24 17:32:40', 'admin', '2021-07-24 17:32:40', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (98, 'SP', '1', '钟明晓', '2021-07-24 17:34:22', '52505', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '50005', '钟明晓 => 审批 => 任务3-分配候选部门、人', NULL, '2021-07-24 17:34:22', 'admin', '2021-07-24 17:34:22', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (99, 'BJ', '1', '钟明晓', '2021-07-24 17:34:22', NULL, NULL, NULL, NULL, '50005', NULL, NULL, '2021-07-24 17:34:22', 'admin', '2021-07-24 17:34:22', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (100, 'FQLC', '1', '钟明晓', '2021-07-24 17:35:22', NULL, NULL, 'startEvent1', NULL, '60004', NULL, NULL, '2021-07-24 17:35:22', 'admin', '2021-07-24 17:35:22', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (101, 'QJQ', '1', '钟明晓', '2021-07-24 17:35:34', '60010', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '60004', '钟明晓 => 加签 => 任务1-分配单个人【张三】', NULL, '2021-07-24 17:35:34', 'admin', '2021-07-24 17:35:34', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (102, 'QJQ', '4', '张三', '2021-07-24 17:35:58', '8be2d140-ce96-4f56-abc5-f10ccf7d4d85', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '60004', '张三 => 加签 => 任务1-分配单个人【李四】', NULL, '2021-07-24 17:35:58', 'zhangsan', '2021-07-24 17:35:58', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (103, 'SP', '5', '李四', '2021-07-24 17:36:17', '6161ef1a-e045-4263-8562-dbc5f3f29fb1', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '60004', '李四 => 审批 => 任务1-分配单个人', NULL, '2021-07-24 17:36:17', 'lisi', '2021-07-24 17:36:17', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (104, 'SP', '4', '张三', '2021-07-24 17:36:34', '8be2d140-ce96-4f56-abc5-f10ccf7d4d85', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '60004', '张三 => 审批 => 任务1-分配单个人', NULL, '2021-07-24 17:36:34', 'zhangsan', '2021-07-24 17:36:34', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (105, 'SP', '1', '钟明晓', '2021-07-24 17:36:53', '60010', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '60004', '钟明晓 => 审批 => 任务1-分配单个人', NULL, '2021-07-24 17:36:53', 'admin', '2021-07-24 17:36:53', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (106, 'QS', '1', '钟明晓', '2021-07-24 17:37:02', '60023', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '60004', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-24 17:37:02', 'admin', '2021-07-24 17:37:02', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (107, 'ZB', '1', '钟明晓', '2021-07-24 22:20:27', '10007', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '10001', '钟明晓 => 转办 => 任务1-分配单个人【张三】', NULL, '2021-07-24 22:20:27', 'admin', '2021-07-24 22:20:27', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (108, 'ZB', '1', '钟明晓', '2021-07-24 22:26:16', '12503', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '2501', '钟明晓 => 转办 => 任务2-分配候选角色【张三】', NULL, '2021-07-24 22:26:16', 'admin', '2021-07-24 22:26:16', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (109, 'WP', '1', '钟明晓', '2021-07-24 22:26:45', '15003', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5001', '钟明晓 => 代理 => 任务2-分配候选角色【张三】', NULL, '2021-07-24 22:26:45', 'admin', '2021-07-24 22:26:45', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (110, 'WP', '1', '钟明晓', '2021-07-24 22:27:01', '25003', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5028', '钟明晓 => 代理 => 任务2-分配候选角色【张三】', NULL, '2021-07-24 22:27:01', 'admin', '2021-07-24 22:27:01', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (111, 'ZB', '1', '钟明晓', '2021-07-24 22:27:24', '27508', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5019', '钟明晓 => 转办 => 任务2-分配候选角色【张三】', NULL, '2021-07-24 22:27:24', 'admin', '2021-07-24 22:27:24', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (112, 'ZB', '1', '钟明晓', '2021-07-24 22:27:41', '47507', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '47501', '钟明晓 => 转办 => 任务1-分配单个人【张三】', NULL, '2021-07-24 22:27:41', 'admin', '2021-07-24 22:27:41', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (113, 'SP', '4', '张三', '2021-07-24 22:28:47', '47507', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '47501', '张三 => 审批 => 任务1-分配单个人', NULL, '2021-07-24 22:28:47', 'zhangsan', '2021-07-24 22:28:47', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (114, 'SP', '4', '张三', '2021-07-24 22:28:55', '25003', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5028', '张三 => 审批 => 任务2-分配候选角色', NULL, '2021-07-24 22:28:55', 'zhangsan', '2021-07-24 22:28:55', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (115, 'FQLC', '1', '钟明晓', '2021-07-25 09:07:11', NULL, NULL, 'startevent1', 'Start', '62505', NULL, NULL, '2021-07-25 09:07:11', 'admin', '2021-07-25 09:07:11', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (118, 'FQLC', '1', '钟明晓', '2021-07-26 12:30:54', NULL, NULL, 'startEvent1', NULL, '67507', NULL, NULL, '2021-07-26 12:30:54', 'admin', '2021-07-26 12:30:54', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (119, 'SP', '1', '钟明晓', '2021-07-26 13:00:07', '67513', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '67507', '钟明晓 => 审批 => 任务1-分配单个人', '同意', '2021-07-26 13:00:07', 'admin', '2021-07-26 13:00:07', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (120, 'QS', '1', '钟明晓', '2021-07-26 13:00:48', '67518', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67507', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-26 13:00:48', 'admin', '2021-07-26 13:00:48', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (121, 'SP', '1', '钟明晓', '2021-07-26 13:01:10', '67518', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67507', '钟明晓 => 审批 => 任务2-分配候选角色', '新', '2021-07-26 13:01:10', 'admin', '2021-07-26 13:01:10', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (122, 'QS', '1', '钟明晓', '2021-07-26 13:01:40', '67524', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '67507', '钟明晓 => 拾取任务 => 任务3-分配候选部门、人', NULL, '2021-07-26 13:01:40', 'admin', '2021-07-26 13:01:40', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (123, 'BH', '1', '钟明晓', '2021-07-26 13:02:01', '67524', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '67507', '钟明晓 => 驳回任务 => 【任务3-分配候选部门、人=>任务1-分配单个人】', NULL, '2021-07-26 13:02:01', 'admin', '2021-07-26 13:02:01', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (124, 'SP', '1', '钟明晓', '2021-07-26 13:04:35', '67531', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '67507', '钟明晓 => 审批 => 任务1-分配单个人', '同意', '2021-07-26 13:04:35', 'admin', '2021-07-26 13:04:35', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (125, 'QS', '1', '钟明晓', '2021-07-26 13:05:39', '67535', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67507', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-26 13:05:39', 'admin', '2021-07-26 13:05:39', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (126, 'SP', '1', '钟明晓', '2021-07-26 13:05:52', '67535', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67507', '钟明晓 => 审批 => 任务2-分配候选角色', '同意', '2021-07-26 13:05:52', 'admin', '2021-07-26 13:05:52', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (127, 'QS', '4', '张三', '2021-07-26 13:06:59', '67541', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '67507', '张三 => 拾取任务 => 任务3-分配候选部门、人', NULL, '2021-07-26 13:06:59', 'zhangsan', '2021-07-26 13:06:59', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (128, 'SP', '4', '张三', '2021-07-26 13:07:15', '67541', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '67507', '张三 => 审批 => 任务3-分配候选部门、人', '同意', '2021-07-26 13:07:15', 'zhangsan', '2021-07-26 13:07:15', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (129, 'BJ', '4', '张三', '2021-07-26 13:07:15', NULL, NULL, NULL, NULL, '67507', NULL, NULL, '2021-07-26 13:07:15', 'zhangsan', '2021-07-26 13:07:15', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (130, 'FQLC', '1', '钟明晓', '2021-07-26 14:42:23', NULL, NULL, 'startEvent1', NULL, '67549', NULL, NULL, '2021-07-26 14:42:23', 'admin', '2021-07-26 14:42:23', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (131, 'SP', '1', '钟明晓', '2021-07-26 14:43:37', '67555', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '67549', '钟明晓 => 审批 => 任务1-分配单个人', '同意', '2021-07-26 14:43:37', 'admin', '2021-07-26 14:43:37', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (132, 'QS', '1', '钟明晓', '2021-07-26 14:44:04', '67560', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67549', '钟明晓 => 拾取任务 => 任务2-分配候选角色', NULL, '2021-07-26 14:44:04', 'admin', '2021-07-26 14:44:04', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (133, 'ZB', '1', '钟明晓', '2021-07-26 14:44:32', '67560', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67549', '钟明晓 => 转办 => 任务2-分配候选角色【张三】', NULL, '2021-07-26 14:44:32', 'admin', '2021-07-26 14:44:32', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (134, 'SP', '4', '张三', '2021-07-26 14:45:34', '67560', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '67549', '张三 => 审批 => 任务2-分配候选角色', '同意', '2021-07-26 14:45:34', 'zhangsan', '2021-07-26 14:45:34', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (135, 'QS', '4', '张三', '2021-07-26 14:45:56', '67571', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '67549', '张三 => 拾取任务 => 任务3-分配候选部门、人', NULL, '2021-07-26 14:45:56', 'zhangsan', '2021-07-26 14:45:56', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (136, 'SP', '4', '张三', '2021-07-26 14:46:08', '67571', '任务3-分配候选部门、人', 'Activity_0w7115l', '任务3-分配候选部门、人', '67549', '张三 => 审批 => 任务3-分配候选部门、人', '同意', '2021-07-26 14:46:08', 'zhangsan', '2021-07-26 14:46:08', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (137, 'BJ', '4', '张三', '2021-07-26 14:46:08', NULL, NULL, NULL, NULL, '67549', NULL, NULL, '2021-07-26 14:46:08', 'zhangsan', '2021-07-26 14:46:08', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (138, 'FQLC', '4', '张三', '2021-07-26 14:46:48', NULL, NULL, 'startEvent1', NULL, '67578', NULL, NULL, '2021-07-26 14:46:48', 'zhangsan', '2021-07-26 14:46:48', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (139, 'SP', '1', '钟明晓', '2021-07-26 14:47:22', '67584', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '67578', '钟明晓 => 审批 => 任务1-分配单个人', '同意', '2021-07-26 14:47:22', 'admin', '2021-07-26 14:47:22', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (140, 'CH', '1', '钟明晓', '2021-07-26 15:55:56', '67584', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '67578', '任务回撤！', NULL, '2021-07-26 15:55:56', 'admin', '2021-07-26 15:55:56', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (141, 'FQLC', '1', '钟明晓', '2021-07-26 16:10:20', NULL, NULL, 'startEvent1', NULL, '70007', NULL, NULL, '2021-07-26 16:10:20', 'admin', '2021-07-26 16:10:20', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (142, 'SP', '4', '张三', '2021-07-26 17:01:28', 'b0d94a8b-04fd-403f-85ed-671a4fb6b642', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '70007', '张三 => 审批 => 任务1-分配单个人', NULL, '2021-07-26 17:01:28', 'zhangsan', '2021-07-26 17:01:28', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (143, 'FQLC', '1', '钟明晓', '2021-07-26 20:26:30', NULL, NULL, 'startEvent1', NULL, '72506', NULL, NULL, '2021-07-26 20:26:30', 'admin', '2021-07-26 20:26:30', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (144, 'SP', '1', '钟明晓', '2021-07-26 20:33:41', '25003', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '5028', '钟明晓 => 审批 => 任务2-分配候选角色', '1', '2021-07-26 20:33:41', 'admin', '2021-07-26 20:33:41', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (145, 'QS', '1', '钟明晓', '2021-07-28 14:56:53', '72517', '任务3-分配候选角色、人', 'Activity_0w7115l', '任务3-分配候选角色、人', '5028', '钟明晓 => 拾取任务 => 任务3-分配候选角色、人', NULL, '2021-07-28 14:56:53', 'admin', '2021-07-28 14:56:53', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (147, 'FQLC', '1', '钟明晓', '2021-07-28 21:57:24', NULL, NULL, 'startevent1', 'Start', '75013', NULL, NULL, '2021-07-28 21:57:24', 'admin', '2021-07-28 21:57:24', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (150, 'SP', '1', '钟明晓', '2021-07-28 22:02:43', '75019', '提交人', 'usertask1', '提交人', '75013', '钟明晓 => 审批 => 提交人', NULL, '2021-07-28 22:02:47', 'admin', '2021-07-28 22:02:47', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (152, 'FQLC', '5', '李四', '2021-07-28 22:16:36', NULL, NULL, 'startevent1', 'Start', '75028', NULL, NULL, '2021-07-28 22:16:36', 'lisi', '2021-07-28 22:16:36', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (153, 'FQLC', '1', '钟明晓', '2021-08-02 16:06:56', NULL, NULL, 'startEvent1', NULL, '80013', NULL, NULL, '2021-08-02 16:06:56', 'admin', '2021-08-02 16:06:56', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (154, 'SP', '4', '张三', '2021-08-02 16:39:51', '80019', '01', 'Activity_0g99h16', '01', '80013', '张三 => 审批 => 01', '同意', '2021-08-02 16:39:51', 'zhangsan', '2021-08-02 16:39:51', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (155, 'SP', '5', '李四', '2021-08-02 16:40:48', '82503', '02', 'Activity_0jgkyim', '02', '80013', '李四 => 审批 => 02', '同意', '2021-08-02 16:40:48', 'lisi', '2021-08-02 16:40:48', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (156, 'SP', '6', '王五', '2021-08-02 16:41:18', '82508', '03', 'Activity_0wcvmv5', '03', '80013', '王五 => 审批 => 03', '同意5', '2021-08-02 16:41:18', 'wangwu', '2021-08-02 16:41:18', 'wangwu', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (157, 'BJ', '6', '王五', '2021-08-02 16:41:18', NULL, NULL, NULL, NULL, '80013', NULL, NULL, '2021-08-02 16:41:18', 'wangwu', '2021-08-02 16:41:18', 'wangwu', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (158, 'FQLC', '1', '钟明晓', '2021-08-04 14:19:59', NULL, NULL, 'startEvent1', NULL, '85005', NULL, NULL, '2021-08-04 14:19:59', 'admin', '2021-08-04 14:19:59', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (159, 'SP', '1', '钟明晓', '2021-08-09 15:39:46', '60023', '任务2-分配候选角色', 'Activity_16npgqr', '任务2-分配候选角色', '60004', '钟明晓 => 审批 => 任务2-分配候选角色', '11', '2021-08-09 15:39:46', 'admin', '2021-08-09 15:39:46', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (163, 'SP', '1', '钟明晓', '2021-08-09 15:41:43', '70005', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '67578', '钟明晓 => 审批 => 任务1-分配单个人', '111', '2021-08-09 15:41:43', 'admin', '2021-08-09 15:41:43', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (165, 'SP', '1', '钟明晓', '2021-08-09 16:31:40', '70013', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '70007', '钟明晓 => 审批 => 任务1-分配单个人', '11', '2021-08-09 16:31:40', 'admin', '2021-08-09 16:31:40', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (166, 'FQLC', '1', '钟明晓', '2021-08-10 15:58:14', NULL, NULL, 'startEvent1', NULL, '87522', NULL, NULL, '2021-08-10 15:58:14', 'admin', '2021-08-10 15:58:14', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (167, 'FQLC', '1', '钟明晓', '2021-08-10 16:01:20', NULL, NULL, 'startEvent1', NULL, '87533', NULL, NULL, '2021-08-10 16:01:20', 'admin', '2021-08-10 16:01:20', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (168, 'FQLC', '1', '钟明晓', '2021-08-10 16:11:58', NULL, NULL, 'startEvent1', NULL, '87540', NULL, NULL, '2021-08-10 16:11:58', 'admin', '2021-08-10 16:11:58', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (169, 'FQLC', '1', '钟明晓', '2021-08-10 16:27:21', NULL, NULL, 'startEvent1', NULL, '87547', NULL, NULL, '2021-08-10 16:27:21', 'admin', '2021-08-10 16:27:21', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (170, 'FQLC', '1', '钟明晓', '2021-08-10 16:27:26', NULL, NULL, 'startEvent1', NULL, '87556', NULL, NULL, '2021-08-10 16:27:26', 'admin', '2021-08-10 16:27:26', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (171, 'FQLC', '1', '钟明晓', '2021-08-10 16:54:29', NULL, NULL, 'startEvent1', NULL, '87569', NULL, NULL, '2021-08-10 16:54:29', 'admin', '2021-08-10 16:54:29', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (172, 'FQLC', '1', '钟明晓', '2021-08-10 17:36:44', NULL, NULL, 'startEvent1', NULL, '87580', NULL, NULL, '2021-08-10 17:36:44', 'admin', '2021-08-10 17:36:44', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (173, 'FQLC', '1', '钟明晓', '2021-08-10 17:38:05', NULL, NULL, 'startEvent1', NULL, '87591', NULL, NULL, '2021-08-10 17:38:05', 'admin', '2021-08-10 17:38:05', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (174, 'FQLC', '1', '钟明晓', '2021-08-12 21:55:21', NULL, NULL, 'startEvent1', NULL, '92505', NULL, NULL, '2021-08-12 21:55:21', 'admin', '2021-08-12 21:55:21', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (175, 'QS', '1', '钟明晓', '2021-08-12 21:55:48', '92511', '诉求（编辑、提交）', 'Activity_0sjew1q', '诉求（编辑、提交）', '92505', '钟明晓 => 拾取任务 => 诉求（编辑、提交）', NULL, '2021-08-12 21:55:49', 'admin', '2021-08-12 21:55:49', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (176, 'SP', '1', '钟明晓', '2021-08-12 21:56:13', '92511', '诉求（编辑、提交）', 'Activity_0sjew1q', '诉求（编辑、提交）', '92505', '钟明晓 => 审批 => 诉求（编辑、提交）', '11', '2021-08-12 21:56:13', 'admin', '2021-08-12 21:56:13', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (177, 'QS', '4', '张三', '2021-08-12 22:00:03', '92518', '诉求审核', 'Activity_1q077w6', '诉求审核', '92505', '张三 => 拾取任务 => 诉求审核', NULL, '2021-08-12 22:00:03', 'zhangsan', '2021-08-12 22:00:03', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (178, 'SP', '4', '张三', '2021-08-12 22:00:18', '92518', '诉求审核', 'Activity_1q077w6', '诉求审核', '92505', '张三 => 审批 => 诉求审核', '333', '2021-08-12 22:00:18', 'zhangsan', '2021-08-12 22:00:18', 'zhangsan', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (179, 'FQLC', '1', '钟明晓', '2021-08-13 10:52:29', NULL, NULL, 'startEvent1', NULL, '92527', NULL, NULL, '2021-08-13 10:52:29', 'admin', '2021-08-13 10:52:29', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (180, 'QS', '1', '钟明晓', '2021-08-13 10:53:03', '92533', '诉求（编辑、提交）', 'Activity_0sjew1q', '诉求（编辑、提交）', '92527', '钟明晓 => 拾取任务 => 诉求（编辑、提交）', NULL, '2021-08-13 10:53:03', 'admin', '2021-08-13 10:53:03', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (182, 'SP', '1', '钟明晓', '2021-08-13 10:55:33', '92533', '诉求（编辑、提交）', 'Activity_0sjew1q', '诉求（编辑、提交）', '92527', '钟明晓 => 审批 => 诉求（编辑、提交）', '11', '2021-08-13 10:55:33', 'admin', '2021-08-13 10:55:33', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (183, 'CH', '1', '钟明晓', '2021-08-13 22:07:35', '92533', '诉求（编辑、提交）', 'Activity_0sjew1q', '诉求（编辑、提交）', '92527', '任务回撤！', NULL, '2021-08-13 22:07:35', 'admin', '2021-08-13 22:07:35', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (184, 'SP', '1', '钟明晓', '2021-08-13 22:08:07', '92548', '诉求（编辑、提交）', 'Activity_0sjew1q', '诉求（编辑、提交）', '92527', '钟明晓 => 审批 => 诉求（编辑、提交）', NULL, '2021-08-13 22:08:07', 'admin', '2021-08-13 22:08:07', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (187, 'FQLC', '1', '钟明晓', '2021-08-17 16:18:54', NULL, NULL, 'startEvent1', NULL, '92558', NULL, NULL, '2021-08-17 16:18:54', 'admin', '2021-08-17 16:18:54', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (188, 'FQLC', '1', '钟明晓', '2021-08-17 16:21:20', NULL, NULL, 'startEvent1', NULL, '92573', NULL, NULL, '2021-08-17 16:21:20', 'admin', '2021-08-17 16:21:20', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (195, 'SP', '1', '钟明晓', '2021-08-21 14:49:43', '87562', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '87556', '钟明晓 => 审批 => 任务1-分配单个人', '1', '2021-08-21 14:49:43', 'admin', '2021-08-21 14:49:43', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (200, 'SP', '1', '钟明晓', '2021-08-21 15:44:49', '72512', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '72506', '钟明晓 => 审批 => 任务1-分配单个人', '1', '2021-08-21 15:44:49', 'admin', '2021-08-21 15:44:49', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (201, 'SP', '1', '钟明晓', '2021-08-21 15:52:10', '72517', '任务3-分配候选角色、人', 'Activity_0w7115l', '任务3-分配候选角色、人', '5028', '钟明晓 => 审批 => 任务3-分配候选角色、人', '1', '2021-08-21 15:52:10', 'admin', '2021-08-21 15:52:10', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (202, 'BJ', '1', '钟明晓', '2021-08-21 15:52:11', NULL, NULL, NULL, NULL, '5028', NULL, NULL, '2021-08-21 15:52:11', 'admin', '2021-08-21 15:52:11', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (204, 'SP', '1', '钟明晓', '2021-08-23 10:49:32', '62511', '提交人', 'usertask1', '提交人', '62505', '钟明晓 => 审批 => 提交人', '11', '2021-08-23 10:49:32', 'admin', '2021-08-23 10:49:32', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (205, 'SP', '1', '钟明晓', '2021-08-26 17:03:01', '3fc0339c-eff1-4a2f-afcc-758bb1b43e03', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '钟明晓 => 审批 => 任务1-分配单个人', NULL, '2021-08-26 17:03:01', 'admin', '2021-08-26 17:03:01', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (206, 'SP', '1', '钟明晓', '2021-08-26 17:03:08', '8f24ec20-6258-49c0-b65f-fa311c81fe62', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '钟明晓 => 审批 => 任务1-分配单个人', NULL, '2021-08-26 17:03:08', 'admin', '2021-08-26 17:03:08', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (207, 'SP', '1', '钟明晓', '2021-08-26 17:03:12', '8bfe70f9-cb1a-4975-b808-8c47fbc85780', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '钟明晓 => 审批 => 任务1-分配单个人', NULL, '2021-08-26 17:03:12', 'admin', '2021-08-26 17:03:12', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (208, 'SP', '1', '钟明晓', '2021-08-26 17:03:16', '20b05e26-d689-4b5c-a917-fbc67c953d40', '任务1-分配单个人', 'Activity_0mt7co8', '任务1-分配单个人', '5010', '钟明晓 => 审批 => 任务1-分配单个人', NULL, '2021-08-26 17:03:16', 'admin', '2021-08-26 17:03:16', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (209, 'FQLC', '1', '钟明晓', '2021-08-27 11:59:49', NULL, NULL, 'startevent1', 'Start', '5', NULL, NULL, '2021-08-27 11:59:49', 'admin', '2021-08-27 11:59:49', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (210, 'SP', '1', '钟明晓', '2021-08-27 12:02:06', '11', '提交人', 'usertask1', '提交人', '5', '钟明晓 => 审批 => 提交人', '请假三天', '2021-08-27 12:02:06', 'admin', '2021-08-27 12:02:06', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (214, 'SP', '5', '李四', '2021-08-28 22:20:55', '18', '李四', 'usertask3', '李四', '5', '李四 => 审批 => 李四', '11', '2021-08-28 22:20:55', 'lisi', '2021-08-28 22:20:55', 'lisi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (215, 'SP', '6', '王五', '2021-08-28 22:21:59', '2561', '王五,赵六', 'usertask4', '王五,赵六', '5', '王五 => 审批 => 王五,赵六', NULL, '2021-08-28 22:21:59', 'wangwu', '2021-08-28 22:21:59', 'wangwu', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (216, 'BH', '8', '陈七', '2021-08-28 22:23:16', '2572', '陈七', 'usertask7', '陈七', '5', '陈七 => 驳回任务 => 【陈七=>提交人】', NULL, '2021-08-28 22:23:16', 'chenqi', '2021-08-28 22:23:16', 'chenqi', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (217, 'FQLC', '1', '钟明晓', '2021-08-29 13:35:35', NULL, NULL, 'Event_15w2mil', NULL, '5005', NULL, NULL, '2021-08-29 13:35:35', 'admin', '2021-08-29 13:35:35', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (218, 'FQLC', '1', '钟明晓', '2021-08-30 18:22:51', NULL, NULL, 'Event_1u3tfpe', NULL, '7515', NULL, NULL, '2021-08-30 18:22:51', 'admin', '2021-08-30 18:22:51', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (219, 'FQLC', '1', '钟明晓', '2021-08-30 18:23:11', NULL, NULL, 'Event_1u3tfpe', NULL, '7524', NULL, NULL, '2021-08-30 18:23:11', 'admin', '2021-08-30 18:23:11', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (220, 'FQLC', '1', '钟明晓', '2021-08-30 19:50:29', NULL, NULL, 'Event_1u3tfpe', NULL, '10014', NULL, NULL, '2021-08-30 19:50:29', 'admin', '2021-08-30 19:50:29', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (221, 'FQLC', '1', '钟明晓', '2021-08-30 19:50:47', NULL, NULL, 'Event_1u3tfpe', NULL, '10023', NULL, NULL, '2021-08-30 19:50:47', 'admin', '2021-08-30 19:50:47', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (222, 'FQLC', '1', '钟明晓', '2021-09-02 14:09:52', NULL, NULL, 'Event_1u3tfpe', NULL, '12509', NULL, NULL, '2021-09-02 14:09:52', 'admin', '2021-09-02 14:09:52', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (223, 'FQLC', '1', '钟明晓', '2021-09-02 14:11:38', NULL, NULL, 'Event_1u3tfpe', NULL, '12518', NULL, NULL, '2021-09-02 14:11:38', 'admin', '2021-09-02 14:11:38', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (224, 'FQLC', '1', '钟明晓', '2021-09-02 14:14:37', NULL, NULL, 'Event_1u3tfpe', NULL, '12531', NULL, NULL, '2021-09-02 14:14:37', 'admin', '2021-09-02 14:14:37', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (225, 'FQLC', '1', '钟明晓', '2021-09-02 14:20:21', NULL, NULL, 'Event_1u3tfpe', NULL, '15001', NULL, NULL, '2021-09-02 14:20:21', 'admin', '2021-09-02 14:20:21', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (226, 'FQLC', '1', '钟明晓', '2021-09-03 10:13:37', NULL, NULL, 'Event_1u3tfpe', NULL, '15010', NULL, NULL, '2021-09-03 10:13:37', 'admin', '2021-09-03 10:13:37', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (227, 'FQLC', '1', '钟明晓', '2021-09-03 10:17:12', NULL, NULL, 'Event_1u3tfpe', NULL, '17501', NULL, NULL, '2021-09-03 10:17:12', 'admin', '2021-09-03 10:17:12', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (228, 'FQLC', '1', '钟明晓', '2021-09-03 10:20:59', NULL, NULL, 'Event_1u3tfpe', NULL, '20001', NULL, NULL, '2021-09-03 10:20:59', 'admin', '2021-09-03 10:20:59', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (229, 'FQLC', '1', '钟明晓', '2021-09-03 10:27:45', NULL, NULL, 'Event_1u3tfpe', NULL, '15023', NULL, NULL, '2021-09-03 10:27:45', 'admin', '2021-09-03 10:27:45', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (230, 'FQLC', '1', '钟明晓', '2021-09-03 10:28:15', NULL, NULL, 'Event_1u3tfpe', NULL, '15032', NULL, NULL, '2021-09-03 10:28:15', 'admin', '2021-09-03 10:28:15', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (231, 'FQLC', '1', '钟明晓', '2021-09-03 10:31:43', NULL, NULL, 'Event_1u3tfpe', NULL, '22501', NULL, NULL, '2021-09-03 10:31:43', 'admin', '2021-09-03 10:31:43', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (232, 'FQLC', '1', '钟明晓', '2021-09-03 10:34:54', NULL, NULL, 'Event_1u3tfpe', NULL, '25001', NULL, NULL, '2021-09-03 10:34:54', 'admin', '2021-09-03 10:34:54', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (233, 'FQLC', '1', '钟明晓', '2021-09-03 10:44:20', NULL, NULL, 'Event_1u3tfpe', NULL, '25010', NULL, NULL, '2021-09-03 10:44:20', 'admin', '2021-09-03 10:44:20', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (234, 'FQLC', '1', '钟明晓', '2021-09-03 10:48:25', NULL, NULL, 'Event_1u3tfpe', NULL, '27501', NULL, NULL, '2021-09-03 10:48:25', 'admin', '2021-09-03 10:48:25', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (235, 'FQLC', '1', '钟明晓', '2021-09-03 10:56:04', NULL, NULL, 'Event_1u3tfpe', NULL, '30001', NULL, NULL, '2021-09-03 10:56:04', 'admin', '2021-09-03 10:56:04', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (236, 'FQLC', '1', '钟明晓', '2021-09-03 10:58:35', NULL, NULL, 'Event_1u3tfpe', NULL, '30010', NULL, NULL, '2021-09-03 10:58:35', 'admin', '2021-09-03 10:58:35', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (237, 'FQLC', '1', '钟明晓', '2021-09-03 11:06:04', NULL, NULL, 'Event_1u3tfpe', NULL, '35001', NULL, NULL, '2021-09-03 11:06:04', 'admin', '2021-09-03 11:06:04', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (238, 'FQLC', '1', '钟明晓', '2021-09-03 11:06:20', NULL, NULL, 'Event_1u3tfpe', NULL, '35010', NULL, NULL, '2021-09-03 11:06:20', 'admin', '2021-09-03 11:06:20', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (239, 'FQLC', '1', '钟明晓', '2021-09-03 11:17:48', NULL, NULL, 'Event_1u3tfpe', NULL, '40001', NULL, NULL, '2021-09-03 11:17:48', 'admin', '2021-09-03 11:17:48', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (240, 'FQLC', '1', '钟明晓', '2021-09-03 11:37:53', NULL, NULL, 'Event_1u3tfpe', NULL, '42501', NULL, NULL, '2021-09-03 11:37:53', 'admin', '2021-09-03 11:37:53', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (241, 'FQLC', '1', '钟明晓', '2021-09-03 11:40:50', NULL, NULL, 'Event_1u3tfpe', NULL, '45001', NULL, NULL, '2021-09-03 11:40:50', 'admin', '2021-09-03 11:40:50', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (242, 'FQLC', '1', '钟明晓', '2021-09-03 11:50:18', NULL, NULL, 'Event_1u3tfpe', NULL, '47501', NULL, NULL, '2021-09-03 11:50:18', 'admin', '2021-09-03 11:50:18', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (243, 'FQLC', '1', '钟明晓', '2021-09-03 11:51:40', NULL, NULL, 'Event_1u3tfpe', NULL, '47510', NULL, NULL, '2021-09-03 11:51:40', 'admin', '2021-09-03 11:51:40', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (244, 'FQLC', '1', '钟明晓', '2021-09-03 11:52:59', NULL, NULL, 'Event_1u3tfpe', NULL, '50001', NULL, NULL, '2021-09-03 11:52:59', 'admin', '2021-09-03 11:52:59', 'admin', 0, NULL);
INSERT INTO `work_flow_hi_comment` VALUES (245, 'FQLC', '1', '管理员', '2021-09-10 09:41:31', NULL, NULL, 'startevent1', 'Start', '5', NULL, NULL, '2021-09-10 09:41:31', 'admin', '2021-09-10 09:41:31', 'admin', 0, NULL);

-- ----------------------------
-- Table structure for work_flow_listener
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_listener`;
CREATE TABLE `work_flow_listener`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `listener_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监听器名称',
  `listener_type` tinyint(4) NULL DEFAULT NULL COMMENT '监听器类型1-执行监听器，2-任务监听器',
  `event_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '事件类型（create.创建、assignment.指派、complete.完成、delete.删除）（start.开始、end.结束、take.启用）',
  `value_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '值类型classListener-类，expressionListener-表达式，delegateExpressionListener -委托表达式',
  `listener_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监听器值',
  `system_listener` tinyint(1) NULL DEFAULT 0 COMMENT '是否是系统预设监听器（0.是、1.否）',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注-描述',
  `creator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '流程监听器' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_listener
-- ----------------------------
INSERT INTO `work_flow_listener` VALUES (10, '改后', 1, 'start', 'classListener', '值111', 0, '11111', NULL, '2021-09-02 01:46:30', '2021-09-02 01:46:30', NULL, 0);
INSERT INTO `work_flow_listener` VALUES (11, 'Http回调', 2, 'create', 'delegateExpressionListener', '${taskBusinessHttpCallListener}', 0, '勿删', NULL, '2021-08-30 10:10:16', '2021-09-01 06:20:33', NULL, 0);

-- ----------------------------
-- Table structure for work_flow_listener_param
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_listener_param`;
CREATE TABLE `work_flow_listener_param`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `listener_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监听器ID',
  `param_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监听器参数名称',
  `param_type` tinyint(4) NULL DEFAULT 0 COMMENT '监听器参数类型-0.字符串 1.表达式',
  `param_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监听器参数值',
  `required` tinyint(1) NULL DEFAULT NULL COMMENT '是否必填：0-否  1.是',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注-描述',
  `creator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '流程监听器' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_listener_param
-- ----------------------------
INSERT INTO `work_flow_listener_param` VALUES (4, NULL, '123423', 0, '23452345', 0, NULL, NULL, '2021-08-25 03:52:52', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (5, NULL, '123', 0, '234', 1, NULL, NULL, '2021-08-26 08:19:41', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (7, '10', '字段1', 0, '111', 0, NULL, NULL, '2021-08-27 03:43:21', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (8, '10', '字段2', 1, '122222', 0, NULL, NULL, '2021-08-27 03:43:35', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (9, '11', 'remoteUrl', 0, 'http://47.96.74.120:8080/processCenter/workFlowUsers/selectAll?pageNum=1&pageSize=10&pageIndex=1', 0, NULL, NULL, '2021-08-30 10:13:53', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (10, '11', 'method', 0, 'GET', 0, NULL, NULL, '2021-08-30 10:14:33', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (11, '11', 'contentType', 0, 'application/json', 0, NULL, NULL, '2021-08-30 10:14:57', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (12, '11', 'authorization', 0, '1111', 0, NULL, NULL, '2021-08-30 10:15:18', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (13, '11', 'requestBodyFormat', 0, 'JSON', 0, NULL, NULL, '2021-08-30 10:15:46', NULL, NULL, 0);
INSERT INTO `work_flow_listener_param` VALUES (14, '11', 'form:myName', 0, 'zmx', 1, NULL, NULL, '2021-08-30 10:16:21', NULL, NULL, 0);

-- ----------------------------
-- Table structure for work_flow_model
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_model`;
CREATE TABLE `work_flow_model`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `model_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型Key',
  `model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `model_json` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '流程json数据',
  `model_xml` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '流程xml数据',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `version` int(8) NULL DEFAULT 1 COMMENT '版本',
  `creator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识0表示删除1表示存在',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `un_model_key_version`(`model_key`, `version`) USING BTREE COMMENT '唯一索引，防止并发新增出现相同版本号'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '流程模型信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_model
-- ----------------------------
INSERT INTO `work_flow_model` VALUES ('28811b5b46e6c22e90c910c28dce4152', 'CSQJ', '测试请假', NULL, '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" targetNamespace=\"http://www.activiti.org/test\">\n  <process id=\"leave\" name=\"请假\" isExecutable=\"true\">\n    <startEvent id=\"startevent1\" name=\"Start\" />\n    <userTask id=\"usertask1\" name=\"提交人\" flowable:assignee=\"1\" flowable:candidateGroups=\"+110+\" activiti:assignee=\"1\">\n      <extensionElements>\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"1\",\"deptId\":\"103\",\"deptName\":\"研发部门\",\"areaId\":null,\"userName\":\"admin\",\"nickName\":\"管理员\",\"email\":\"ry@163.com\",\"phonenumber\":\"15888888888\",\"sex\":\"1\",\"status\":\"0\",\"password\":\"$2a$10$XrcGtvGSG06P.tcmWowbuuQon38S.BakjKEVuo4aT/JZa/Xr8RfJW\"}]</flowable:idmAssignee>\n        <flowable:formData />\n        <flowable:idmCandidateGroups>[\"|调解机构一|\"]</flowable:idmCandidateGroups>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask3\" name=\"李四\" flowable:assignee=\"5\" activiti:assignee=\"5\">\n      <extensionElements>\n        <flowable:formData />\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:idmCandidateGroups>[]</flowable:idmCandidateGroups>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"5\",\"deptId\":\"100\",\"deptName\":\"城云科技\",\"areaId\":null,\"userName\":\"lisi\",\"nickName\":\"李四\",\"email\":\"\",\"phonenumber\":\"15011111112\",\"sex\":\"0\",\"status\":\"0\",\"password\":\"$2a$10$BHFPlzLHMg.rcbH0ic0IFO2JwXcjl4w.cl1DAj5yjo54f/ODg5/oi\"}]</flowable:idmAssignee>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask4\" name=\"王五,赵六\" flowable:assignee=\"6\" activiti:candidateUsers=\"${userCode}\">\n      <extensionElements>\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:idmCandidateGroups>[]</flowable:idmCandidateGroups>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"6\",\"deptId\":\"100\",\"deptName\":\"城云科技\",\"areaId\":null,\"userName\":\"wangwu\",\"nickName\":\"王五\",\"email\":\"\",\"phonenumber\":\"15011111113\",\"sex\":\"0\",\"status\":\"0\",\"password\":\"$2a$10$49v8gY2hFgU450s2CS0S1OgwQiJ3Q94X1dy.wDf25Ba3zHMGA7voG\"}]</flowable:idmAssignee>\n        <flowable:formData />\n      </extensionElements>\n    </userTask>\n    <userTask id=\"usertask6\" name=\"张三\" flowable:assignee=\"4\" activiti:assignee=\"4\">\n      <extensionElements>\n        <flowable:formData />\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:idmCandidateGroups>[]</flowable:idmCandidateGroups>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"4\",\"deptId\":\"100\",\"deptName\":\"城云科技\",\"areaId\":null,\"userName\":\"zhangsan\",\"nickName\":\"张三\",\"email\":\"111@163.com\",\"phonenumber\":\"15011111111\",\"sex\":\"0\",\"status\":\"0\",\"password\":\"$2a$10$/pD42m5aw2/hWNdqVVuasuNjr3uxru0TA3lwXafL5WsQmWTUIq6mm\"}]</flowable:idmAssignee>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow1\" sourceRef=\"startevent1\" targetRef=\"usertask1\" />\n    <exclusiveGateway id=\"exclusivegateway1\" name=\"Exclusive Gateway\" default=\"flow7\" />\n    <sequenceFlow id=\"flow6\" sourceRef=\"usertask1\" targetRef=\"exclusivegateway1\" />\n    <sequenceFlow id=\"flow7\" name=\"天数&#60;=1\" sourceRef=\"exclusivegateway1\" targetRef=\"usertask6\" />\n    <sequenceFlow id=\"flow8\" name=\"天数&#62;1\" sourceRef=\"exclusivegateway1\" targetRef=\"usertask3\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${conditionParser.parser(\"${days &gt; 1}\",execution)}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow9\" sourceRef=\"usertask3\" targetRef=\"usertask4\" />\n    <sequenceFlow id=\"flow10\" sourceRef=\"usertask6\" targetRef=\"usertask4\" />\n    <parallelGateway id=\"parallelgateway1\" name=\"Parallel Gateway\" />\n    <sequenceFlow id=\"flow11\" sourceRef=\"usertask4\" targetRef=\"parallelgateway1\" />\n    <userTask id=\"usertask7\" name=\"陈七\" flowable:assignee=\"8\" activiti:assignee=\"8\">\n      <extensionElements>\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:idmCandidateGroups>[]</flowable:idmCandidateGroups>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"8\",\"deptId\":\"100\",\"deptName\":\"城云科技\",\"areaId\":null,\"userName\":\"chenqi\",\"nickName\":\"陈七\",\"email\":\"\",\"phonenumber\":\"15011111115\",\"sex\":\"0\",\"status\":\"0\",\"password\":\"$2a$10$Zn.wo1/dnktYydj2ENF.2OeREN1rKZIAMLQo784y4vPhCUSaWucS.\"}]</flowable:idmAssignee>\n        <flowable:formData />\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow12\" sourceRef=\"parallelgateway1\" targetRef=\"usertask7\" />\n    <userTask id=\"usertask8\" name=\"谢八\" flowable:assignee=\"9\" activiti:assignee=\"9\">\n      <extensionElements>\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:idmCandidateGroups>[]</flowable:idmCandidateGroups>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"9\",\"deptId\":\"100\",\"deptName\":\"城云科技\",\"areaId\":null,\"userName\":\"xieba\",\"nickName\":\"谢八\",\"email\":\"\",\"phonenumber\":\"15011111116\",\"sex\":\"0\",\"status\":\"0\",\"password\":\"$2a$10$1GtqQ2sFANaBPW7QrBkhs.Mvb5s2KaO/m7zCdPR/XuOlSCL/1QdQy\"}]</flowable:idmAssignee>\n        <flowable:formData />\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow13\" sourceRef=\"parallelgateway1\" targetRef=\"usertask8\" />\n    <parallelGateway id=\"parallelgateway2\" name=\"Parallel Gateway\" />\n    <sequenceFlow id=\"flow14\" sourceRef=\"usertask7\" targetRef=\"parallelgateway2\" />\n    <sequenceFlow id=\"flow15\" sourceRef=\"usertask8\" targetRef=\"parallelgateway2\" />\n    <userTask id=\"usertask9\" name=\"徐九\" flowable:assignee=\"10\" activiti:assignee=\"10\">\n      <extensionElements>\n        <flowable:formData />\n        <flowable:idmCandidateUsers>[]</flowable:idmCandidateUsers>\n        <flowable:idmCandidateGroups>[]</flowable:idmCandidateGroups>\n        <flowable:assigneeType>1</flowable:assigneeType>\n        <flowable:idmAssignee>[{\"userId\":\"10\",\"deptId\":\"100\",\"deptName\":\"城云科技\",\"areaId\":null,\"userName\":\"xujiu\",\"nickName\":\"徐九\",\"email\":\"\",\"phonenumber\":\"15011111117\",\"sex\":\"0\",\"status\":\"0\",\"password\":\"$2a$10$oqFbdZCU3alzfFypMA/Ca.JSEwY9RwajRsp9onKOyqfXPJ4ftLQK.\"}]</flowable:idmAssignee>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow16\" sourceRef=\"parallelgateway2\" targetRef=\"usertask9\" />\n    <endEvent id=\"endevent1\" name=\"End\" />\n    <sequenceFlow id=\"flow17\" sourceRef=\"usertask9\" targetRef=\"endevent1\" />\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_leave\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_leave\" bpmnElement=\"leave\">\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow17\" bpmnElement=\"flow17\">\n        <omgdi:waypoint x=\"188\" y=\"266\" />\n        <omgdi:waypoint x=\"115\" y=\"266\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow16\" bpmnElement=\"flow16\">\n        <omgdi:waypoint x=\"330\" y=\"268\" />\n        <omgdi:waypoint x=\"293\" y=\"266\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow15\" bpmnElement=\"flow15\">\n        <omgdi:waypoint x=\"420\" y=\"317\" />\n        <omgdi:waypoint x=\"351\" y=\"317\" />\n        <omgdi:waypoint x=\"351\" y=\"287\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow14\" bpmnElement=\"flow14\">\n        <omgdi:waypoint x=\"420\" y=\"221\" />\n        <omgdi:waypoint x=\"349\" y=\"221\" />\n        <omgdi:waypoint x=\"350\" y=\"248\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow13\" bpmnElement=\"flow13\">\n        <omgdi:waypoint x=\"671\" y=\"289\" />\n        <omgdi:waypoint x=\"671\" y=\"317\" />\n        <omgdi:waypoint x=\"525\" y=\"317\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow12\" bpmnElement=\"flow12\">\n        <omgdi:waypoint x=\"671\" y=\"249\" />\n        <omgdi:waypoint x=\"671\" y=\"221\" />\n        <omgdi:waypoint x=\"525\" y=\"221\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow11\" bpmnElement=\"flow11\">\n        <omgdi:waypoint x=\"705\" y=\"81\" />\n        <omgdi:waypoint x=\"775\" y=\"81\" />\n        <omgdi:waypoint x=\"775\" y=\"268\" />\n        <omgdi:waypoint x=\"691\" y=\"269\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow10\" bpmnElement=\"flow10\">\n        <omgdi:waypoint x=\"525\" y=\"35\" />\n        <omgdi:waypoint x=\"653\" y=\"35\" />\n        <omgdi:waypoint x=\"652\" y=\"54\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow9\" bpmnElement=\"flow9\">\n        <omgdi:waypoint x=\"525\" y=\"132\" />\n        <omgdi:waypoint x=\"653\" y=\"132\" />\n        <omgdi:waypoint x=\"652\" y=\"109\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow8\" bpmnElement=\"flow8\">\n        <omgdi:waypoint x=\"350\" y=\"105\" />\n        <omgdi:waypoint x=\"350\" y=\"132\" />\n        <omgdi:waypoint x=\"420\" y=\"132\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"360\" y=\"139\" width=\"100\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow7\" bpmnElement=\"flow7\">\n        <omgdi:waypoint x=\"350\" y=\"65\" />\n        <omgdi:waypoint x=\"350\" y=\"32\" />\n        <omgdi:waypoint x=\"420\" y=\"35\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"351\" y=\"9\" width=\"100\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow6\" bpmnElement=\"flow6\">\n        <omgdi:waypoint x=\"293\" y=\"81\" />\n        <omgdi:waypoint x=\"330\" y=\"85\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_flow1\" bpmnElement=\"flow1\">\n        <omgdi:waypoint x=\"115\" y=\"81\" />\n        <omgdi:waypoint x=\"188\" y=\"81\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"BPMNShape_startevent1\" bpmnElement=\"startevent1\">\n        <omgdc:Bounds x=\"80\" y=\"64\" width=\"35\" height=\"35\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask1\" bpmnElement=\"usertask1\">\n        <omgdc:Bounds x=\"188\" y=\"54\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask3\" bpmnElement=\"usertask3\">\n        <omgdc:Bounds x=\"420\" y=\"105\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask4\" bpmnElement=\"usertask4\">\n        <omgdc:Bounds x=\"600\" y=\"54\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask6\" bpmnElement=\"usertask6\">\n        <omgdc:Bounds x=\"420\" y=\"8\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_exclusivegateway1\" bpmnElement=\"exclusivegateway1\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"330\" y=\"65\" width=\"40\" height=\"40\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_parallelgateway1\" bpmnElement=\"parallelgateway1\">\n        <omgdc:Bounds x=\"651\" y=\"249\" width=\"40\" height=\"40\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask7\" bpmnElement=\"usertask7\">\n        <omgdc:Bounds x=\"420\" y=\"194\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask8\" bpmnElement=\"usertask8\">\n        <omgdc:Bounds x=\"420\" y=\"290\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_parallelgateway2\" bpmnElement=\"parallelgateway2\">\n        <omgdc:Bounds x=\"330\" y=\"248\" width=\"40\" height=\"40\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"380\" y=\"261\" width=\"84\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_usertask9\" bpmnElement=\"usertask9\">\n        <omgdc:Bounds x=\"188\" y=\"239\" width=\"105\" height=\"55\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"BPMNShape_endevent1\" bpmnElement=\"endevent1\">\n        <omgdc:Bounds x=\"80\" y=\"249\" width=\"35\" height=\"35\" />\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n', 'CSQJ.bpmn', 1, NULL, '2021-09-10 01:39:06', '2021-09-10 01:39:06', NULL, 0);

-- ----------------------------
-- Table structure for work_flow_model_info
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_model_info`;
CREATE TABLE `work_flow_model_info`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `model_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型id',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `model_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型key',
  `model_type` int(11) NULL DEFAULT 0 COMMENT '模型类型: 0 自定义流程 1是业务流程',
  `category_id` int(32) NULL DEFAULT NULL COMMENT '分类id',
  `status` int(11) NULL DEFAULT 0 COMMENT '流程图Model状态',
  `own_dept_id` int(32) NULL DEFAULT 0 COMMENT '所属部们id',
  `own_dept_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门名称',
  `apply_company_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '适用公司(多个公司，以逗号隔开)',
  `function_range` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '功能范围(1 允许转办 2允许加签 3允许转阅 4允许打印 5相近节点同一人员自动跳过 可以多选 )',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  `tenant_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '统标识-租户ID',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `un_model_key`(`model_key`) USING BTREE COMMENT '唯一索引',
  UNIQUE INDEX `un_model_name`(`name`) USING BTREE COMMENT '唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模型信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_model_info
-- ----------------------------
INSERT INTO `work_flow_model_info` VALUES (29, '28811b5b46e6c22e90c910c28dce4152', '测试请假', 'CSQJ', 0, 1, 3, 100, NULL, NULL, NULL, 1, 'CSLC', 'admin', '2021-08-27 04:01:40', '2021-09-12 22:31:21', 'admin', 0);

-- ----------------------------
-- Table structure for work_flow_model_re_form
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_model_re_form`;
CREATE TABLE `work_flow_model_re_form`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模型关联表单主键',
  `pro_def_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型ID',
  `form_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单名称',
  `form_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单formKey',
  `type` int(11) NULL DEFAULT 0 COMMENT '表单配置类型：0-节点启动表单 1-节点任务表单 2-全局表单',
  `creator` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `un_def_form`(`pro_def_id`, `form_key`) USING BTREE COMMENT '流程-表单key-唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '流程模型关联表单（先只控制到表级读写权限=》后期再扩展到表内字段的读写权限）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_model_re_form_re_activity
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_model_re_form_re_activity`;
CREATE TABLE `work_flow_model_re_form_re_activity`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `model_re_form_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型关联表单ID',
  `form_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '冗余字段-表单formKey-后期关联表内字段权限',
  `activity_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型节点ID',
  `auth_level` int(11) NULL DEFAULT 1 COMMENT '权限级别：0-无 1-可读 2-可写',
  `creator` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点对流程模型关联的表单的权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_service
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_service`;
CREATE TABLE `work_flow_service`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务id',
  `service_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务名称',
  `service_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务编码',
  `icon_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标图片',
  `service_category_id` int(50) NULL DEFAULT NULL COMMENT '服务分类ID',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '服务类型，1：内部表单服务；2，外部调用服务',
  `process_def_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程定义id',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否发布，0：不发布，1：发布',
  `open_way` tinyint(4) NULL DEFAULT 0 COMMENT '打开方式,0-当前页面,1-新窗口打开',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统标识-租户ID',
  `creator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `un_service_code`(`service_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_service
-- ----------------------------
INSERT INTO `work_flow_service` VALUES (2, '测试请假', 'CSQJ01', 'https://oscimg.oschina.net/oscnet/up-eb83b8d00104b97842d19dbadeec90fbb54.JPEG', 1, 1, 'leave:1:4', 1, 0, 1, '111', 'CSLC', 'admin', '2021-07-21 23:43:35', 'admin', '2021-09-10 09:40:25', 0);

-- ----------------------------
-- Table structure for work_flow_service_category
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_service_category`;
CREATE TABLE `work_flow_service_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `category_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类编码',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '上级分类id',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '状态，1：关闭，0：开启',
  `icon_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标名称',
  `creator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `del_flag` int(255) NULL DEFAULT 0 COMMENT '1-删除 0-保存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_service_category
-- ----------------------------
INSERT INTO `work_flow_service_category` VALUES (1, '土豆科技流程服务', 'ZZ', 0, 1, '1111', 1, NULL, 'admin', '2021-07-21 15:04:13', 'yckj', '2021-09-03 22:27:56', 0);
INSERT INTO `work_flow_service_category` VALUES (2, '土豆科技物流管理服务', 'ZZMDTJFW01', 1, 0, '111', 1, NULL, NULL, '2021-07-22 09:10:28', 'yckj', '2021-09-03 22:28:01', 0);

-- ----------------------------
-- Table structure for work_flow_service_collect
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_service_collect`;
CREATE TABLE `work_flow_service_collect`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `service_id` int(11) NULL DEFAULT NULL COMMENT '服务id',
  `collect_status` tinyint(1) NULL DEFAULT NULL COMMENT '0-未收藏,1-收藏',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `tenant_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统标识-租户ID',
  `creator` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `updator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `SERVICE_ID_USER_ID_TENANT_ID`(`service_id`, `user_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_service_guide
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_service_guide`;
CREATE TABLE `work_flow_service_guide`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `service_id` int(11) NULL DEFAULT NULL COMMENT '服务id',
  `service_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务名称',
  `basic_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '基本信息',
  `processing_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '办理流程',
  `attention_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '注意事项',
  `question_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '注意事项',
  `consultation` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '咨询方式',
  `creator` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `updator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务指南配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_service_rel_category
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_service_rel_category`;
CREATE TABLE `work_flow_service_rel_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `service_id` int(11) NULL DEFAULT NULL COMMENT '服务id',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '分类id',
  `creator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `SERVICE_ID_CATEGORY_ID`(`service_id`, `category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务与服务分类关联表-服务可以配置在多个分类下' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_flow_tenant
-- ----------------------------
DROP TABLE IF EXISTS `work_flow_tenant`;
CREATE TABLE `work_flow_tenant`  (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tennat_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统标示',
  `tenant_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `status` int(11) NULL DEFAULT 0 COMMENT '租户状态值',
  `secret_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '租户密钥',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统url前缀',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统的图标',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统备注',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '租户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_flow_tenant
-- ----------------------------
INSERT INTO `work_flow_tenant` VALUES (1, 'ZZMT', '土豆科技人事管理', 0, NULL, NULL, NULL, NULL, NULL, '2021-07-21 06:47:13', '2021-09-03 21:36:19', 'admin', 0);
INSERT INTO `work_flow_tenant` VALUES (2, 'CSLC', '土豆科技物流管理', 0, NULL, NULL, NULL, NULL, NULL, '2021-07-21 06:51:11', '2021-09-03 21:35:40', 'admin', 0);
INSERT INTO `work_flow_tenant` VALUES (3, '111', '0', 1, '111', '111', 'http://47.96.74.120:9090/process/2021/08/12/98802c00-045f-47ef-a2a5-d70820285f38.gif', '111', 'admin', '2021-08-12 09:21:58', '2021-08-12 09:21:58', 'admin', 1);
INSERT INTO `work_flow_tenant` VALUES (4, '1', '1', 0, NULL, NULL, NULL, NULL, NULL, '2021-09-03 13:35:12', '2021-09-03 13:35:12', NULL, 1);


CREATE TABLE `work_flow_form_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL COMMENT '分类编码',
  `category_name` varchar(100) DEFAULT NULL COMMENT '分类名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级分类id',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='表单分类表'



CREATE TABLE `work_flow_form_model` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_info_id` int(11) DEFAULT NULL COMMENT '表单模型id',
  `form_key` varchar(200) DEFAULT NULL COMMENT '表单唯一标识Key：用于关联流程',
  `form_json` longtext COMMENT '表单配置json',
  `form_type` tinyint(1) DEFAULT '0' COMMENT '状态值-0：pc表单 1：移动端表单',
  `status` varchar(255) DEFAULT NULL COMMENT '状态1-未发布，2-已发布',
  `main_version` tinyint(1) DEFAULT '0' COMMENT '是否为主版本',
  `config_json` longtext CHARACTER SET utf8 COMMENT '表单表头字段配置',
  `release_note` varchar(255) DEFAULT NULL COMMENT '版本说明',
  `version` int(11) DEFAULT NULL COMMENT '版本号',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`model_id`) USING BTREE,
  UNIQUE KEY `idx_unique_form_key` (`form_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='自定义表单模型表'


CREATE TABLE `work_flow_form_model_info` (
  `model_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表单模型信息主键',
  `category_id` int(11) DEFAULT NULL COMMENT '表单分类ID',
  `category_name` varchar(200) DEFAULT NULL COMMENT '表单分类名称',
  `form_name` varchar(200) DEFAULT NULL COMMENT '表单名称',
  `form_key` varchar(255) DEFAULT NULL COMMENT '主版本formKey=》用于关联工作流',
  `version` int(11) DEFAULT '1' COMMENT '主版本版本号',
  `form_model_type` tinyint(1) DEFAULT '0' COMMENT '默认：0-外部表单 1-自定义表单',
  `creator` varchar(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` int(1) DEFAULT '0' COMMENT '删除标识1表示删除0表示存在',
  PRIMARY KEY (`model_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='表单模型信息表'



--字典表

CREATE TABLE `dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='字典类型表'

CREATE TABLE `dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='字典数据表'

SET FOREIGN_KEY_CHECKS = 1;
