-- 一期添加字段
ALTER TABLE `yz_goods`
ADD COLUMN ` original_price`  decimal UNSIGNED NULL DEFAULT 0 COMMENT '商品原价' ,
ADD COLUMN `sale_price`  decimal UNSIGNED NULL ;
ADD COLUMN ` weight`  float UNSIGNED NULL DEFAULT 0 COMMENT '商品重量' ;
ADD COLUMN `brand_id`  int UNSIGNED NULL DEFAULT 0 COMMENT '品牌名称' ;
ADD COLUMN `process_money`  decimal UNSIGNED NULL DEFAULT 0 COMMENT '加工费' ;

ALTER TABLE `yz_goods_norms`
ADD COLUMN `sale_price`  double(11,2) UNSIGNED NULL DEFAULT 0 COMMENT '折扣价' ,
ADD COLUMN `weight`  double(11,2) NULL DEFAULT 0 COMMENT '重量' ;

ALTER TABLE `yz_shopping_cart`
ADD COLUMN `process_id`  int NULL DEFAULT 0 COMMENT '加工编号id' ;

ALTER TABLE `yz_order_goods`
ADD COLUMN `process_id`  int NULL DEFAULT 0 COMMENT '加工表id' ,
ADD COLUMN `process_name`  varchar(255) NULL DEFAULT '' COMMENT '加工名称' ,
ADD COLUMN `process_price`  decimal NULL DEFAULT 0 COMMENT '加工费用' ;

-- 2017/2/6 自动生成商品标识位
ALTER TABLE `yz_goods`
ADD COLUMN `auto_type`  tinyint NULL DEFAULT 0 COMMENT '1：为自动生成商品；' ;

ALTER TABLE `yz_goods`
MODIFY COLUMN `original_price`  double(10,2) UNSIGNED NULL DEFAULT 0 COMMENT '商品原价' ,
MODIFY COLUMN `sale_price`  double(10,2) UNSIGNED NULL DEFAULT 0 COMMENT '折扣价';

-- 二期字段添加
ALTER TABLE `yz_activity_seller`
ADD COLUMN `goods_id`  int UNSIGNED NULL DEFAULT 0 COMMENT '商品id:促销和秒杀使用';

CREATE TABLE `yz_index_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '模块的名字',
  `produce` varchar(255) DEFAULT '' COMMENT '说明',
  `url` varchar(255) DEFAULT NULL COMMENT '模块链接',
  `image` varchar(200) DEFAULT NULL COMMENT '模块图标',
  `type` tinyint(1) DEFAULT NULL COMMENT '链接类型 1金融超市 2 物流公司 3 秒杀活动 4：优惠券',
  `sort` int(5) DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 1启用 0关闭',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


insert into `yz_system_config` (`code`,`name`,`show_type`,`is_show`,`sort`) VALUES ('seckill_banner','秒杀banner','image','1','10');
insert into `yz_system_config` (`code`,`name`,`show_type`,`is_show`,`sort`) VALUES ('seckill_produce','活动介绍','editor','1','10');
ALTER TABLE `yz_activity`
ADD COLUMN `curren_time`  int UNSIGNED NULL DEFAULT 0 COMMENT '活动当天开始的时间';

ALTER TABLE `yz_goods`
MODIFY COLUMN `auto_type`  tinyint(4) NULL DEFAULT 0 COMMENT '1：为促销商品；2：秒杀商品';

ALTER TABLE `yz_goods_cate`
ADD COLUMN `auto_type`  tinyint UNSIGNED NULL DEFAULT 0 COMMENT '1:为自动生成-促销';

ALTER TABLE `yz_activity`
MODIFY COLUMN `type`  smallint(1) NULL DEFAULT 1 COMMENT '1:分享活动 2:注册活动 3:线下优惠券发放活动 4:首单立减 5:满X减Y 6:产品特价7:秒杀8：促销 ';

ALTER TABLE `yz_order`
ADD COLUMN `activity_first_id`  int UNSIGNED NULL DEFAULT NULL COMMENT '首单立减活动编号';

ALTER TABLE `yz_adv`
ADD COLUMN `image1` varchar(255) DEFAULT '' COMMENT '顶部广告',
ADD COLUMN `type1` tinyint(4) DEFAULT '0' COMMENT '顶部广告类型',
ADD COLUMN  `arg1` text,
ADD COLUMN  `image2` varchar(255) DEFAULT '' COMMENT '第一广告',
ADD COLUMN  `type2` tinyint(4) DEFAULT '0' COMMENT '第一广告类型',
ADD COLUMN  `arg2` text,
ADD COLUMN  `image3` varchar(255) DEFAULT '' COMMENT '第二广告',
ADD COLUMN  `type3` tinyint(4) DEFAULT '0' COMMENT '第二广告类型',
ADD COLUMN  `arg3` text,
ADD COLUMN  `image4` varchar(255) DEFAULT '' COMMENT '第三广告',
ADD COLUMN  `arg4` text,
ADD COLUMN `flage`  tinyint(1) NULL DEFAULT 0 COMMENT '0:单个广告 1:1+3广告',
ADD COLUMN  `type4` tinyint(4) DEFAULT '0' COMMENT '第三广告类型';