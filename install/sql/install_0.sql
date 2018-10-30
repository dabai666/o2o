
--
-- 表的结构 `%DB_PREFIX%activity`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity` (
  `id` int(11) NOT NULL,
  `type` smallint(1) DEFAULT '1' COMMENT '1:分享活动 2:注册活动 3:线下优惠券发放活动 4:首单立减 5:满X减Y',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `name_match` text COMMENT '名称索引',
  `image` varchar(255) DEFAULT NULL COMMENT '图片',
  `start_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  `brief` text COMMENT '简介',
  `share_promotion_num` int(11) DEFAULT '0' COMMENT '单次分享优惠券数量',
  `share_terms` text COMMENT '分享用户',
  `detail` varchar(100) DEFAULT NULL COMMENT '内容',
  `status` smallint(1) DEFAULT '1' COMMENT '状态',
  `sort` smallint(5) DEFAULT '100' COMMENT '排序',
  `send_type` smallint(1) DEFAULT '1' COMMENT '1:兑换码不同 2:兑换码相同',
  `promotion_sn` varchar(20) DEFAULT NULL COMMENT '兑换码',
  `create_time` int(11) unsigned DEFAULT '0' COMMENT '创建时间',
  `title` varchar(60) DEFAULT '' COMMENT '分享链接标题',
  `bgimage` varchar(255) DEFAULT '' COMMENT '背景图',
  `money` mediumint(8) unsigned DEFAULT '0' COMMENT '钱 大于等于多少金额才可以分享优惠券',
  `button_name` varchar(50) DEFAULT '' COMMENT '按钮名称',
  `button_url` varchar(255) DEFAULT '' COMMENT '按钮链接',
  `count` mediumint(8) unsigned DEFAULT '0' COMMENT '每人分享次数',
  `full_money` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '消费满X减金额',
  `cut_money` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '消费满减金额Y',
  `use_seller` int(11) NOT NULL DEFAULT '0' COMMENT '适用范围:0：全部商家 1：部分商家',
  `join_number` int(11) DEFAULT NULL COMMENT '参与次数',
  `is_system` int(11) NOT NULL DEFAULT '0' COMMENT '1：平台 0：非平台',
  `time_status` int(11) NOT NULL DEFAULT '0' COMMENT '-1：已结束 0：未开始 1：进行中',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家活动编号',
  `sale` double(10,2) DEFAULT NULL COMMENT '折扣比例（0-10）',
  `limit_get` int(11) NOT NULL DEFAULT '0' COMMENT '每人每天限取'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%activity_goods`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_goods` (
  `id` int(11) NOT NULL COMMENT '编号',
  `activity_id` int(11) NOT NULL COMMENT '活动编号',
  `seller_id` int(11) NOT NULL COMMENT '商家编号',
  `goods_id` int(11) NOT NULL COMMENT '商品编号',
  `price` double(10,2) NOT NULL COMMENT '原价',
  `sale_price` double(10,2) NOT NULL COMMENT '折扣价',
  `sale` double(10,2) NOT NULL COMMENT '折扣比例（0-10）',
  `join_number` int(11) DEFAULT NULL COMMENT '参与次数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商家添加特价商品活动关联表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%activity_logs`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_logs` (
  `id` int(11) unsigned NOT NULL,
  `activity_id` int(11) unsigned DEFAULT NULL COMMENT '活动id',
  `order_id` int(11) unsigned DEFAULT NULL COMMENT '订单id',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户id',
  `create_time` int(11) unsigned DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%activity_promotion`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_promotion` (
  `id` int(11) NOT NULL,
  `activity_id` int(11) DEFAULT '0' COMMENT '活动编号',
  `promotion_id` int(11) DEFAULT '0' COMMENT '优惠券编号',
  `num` int(11) DEFAULT '0' COMMENT '数量',
  `probability` smallint(3) DEFAULT '0' COMMENT '概率'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%activity_seller`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%activity_seller` (
  `id` int(11) NOT NULL COMMENT '编号',
  `activity_id` int(11) NOT NULL COMMENT '活动编号',
  `seller_id` int(11) NOT NULL COMMENT '商家编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台添加指定商家活动关联表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%admin_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin_log` (
  `id` int(10) NOT NULL COMMENT '编号',
  `admin_id` smallint(6) DEFAULT NULL COMMENT '操作管理员',
  `model` varchar(30) DEFAULT NULL COMMENT '操作模块',
  `action` varchar(30) DEFAULT NULL COMMENT '操作方法',
  `data_id` varchar(64) DEFAULT NULL COMMENT '关联编号',
  `ip` varchar(20) DEFAULT NULL COMMENT '操作IP',
  `log_result` tinyint(1) DEFAULT '0' COMMENT '操作结果',
  `log_msg` text COMMENT '日志详细',
  `log_request` text COMMENT '请求详细',
  `log_day` int(10) DEFAULT NULL COMMENT '记录时间(天)',
  `log_time` int(10) DEFAULT NULL COMMENT '记录时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%admin_role`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin_role` (
  `id` smallint(6) NOT NULL COMMENT '编号',
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='管理组';

--
-- 转存表中的数据 `%DB_PREFIX%admin_role`
--

INSERT INTO `%DB_PREFIX%admin_role` (`id`, `name`, `status`) VALUES
(1, '超级管理员', 1),
(7, '国足垃圾', 0);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%admin_role_access`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin_role_access` (
  `rid` int(11) DEFAULT NULL COMMENT '管理组编号',
  `controller` varchar(32) DEFAULT '' COMMENT '授权模块',
  `action` varchar(32) DEFAULT '' COMMENT '授权方法',
  `api` varchar(64) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理组权限';

--
-- 转存表中的数据 `%DB_PREFIX%admin_role_access`
--

INSERT INTO `%DB_PREFIX%admin_role_access` (`rid`, `controller`, `action`, `api`) VALUES
(1, 'Index', 'index', ''),
(1, 'AdminUser', 'repwd', ''),
(1, 'AdminUser', 'index', ''),
(1, 'AdminUser', 'create', ''),
(1, 'AdminUser', 'edit', ''),
(1, 'AdminUser', 'destroy', ''),
(1, 'AdminRole', 'index', ''),
(1, 'AdminRole', 'create', ''),
(1, 'AdminRole', 'edit', ''),
(1, 'AdminRole', 'destroy', ''),
(1, 'OneselfConfig', 'index', ''),
(1, 'OneselfConfig', 'create', ''),
(1, 'OneselfConfig', 'edit', ''),
(1, 'OneselfConfig', 'save', ''),
(1, 'OneselfConfig', 'destroy', ''),
(1, 'OneselfConfig', 'showtime', ''),
(1, 'OneselfConfig', 'deldatatime', ''),
(1, 'OneselfConfig', 'addtime', ''),
(1, 'OneselfConfig', 'updatetime', ''),
(1, 'OneselfConfig', 'gettimes', ''),
(1, 'OneselfMenu', 'index', ''),
(1, 'OneselfMenu', 'create', ''),
(1, 'OneselfMenu', 'edit', ''),
(1, 'OneselfMenu', 'destroy', ''),
(1, 'OneselfAdv', 'index', ''),
(1, 'OneselfAdv', 'create', ''),
(1, 'OneselfAdv', 'edit', ''),
(1, 'OneselfAdv', 'destroy', ''),
(1, 'OneselfGoods', 'index', ''),
(1, 'OneselfGoods', 'create', ''),
(1, 'OneselfGoods', 'edit', ''),
(1, 'OneselfGoods', 'destroy', ''),
(1, 'OneselfGoods', 'serviceSave', ''),
(1, 'OneselfGoods', 'systemGoods', ''),
(1, 'OneselfService', 'index', ''),
(1, 'OneselfService', 'create', ''),
(1, 'OneselfService', 'edit', ''),
(1, 'OneselfService', 'serviceSave', ''),
(1, 'OneselfService', 'destroy', ''),
(1, 'OneselfService', 'search', ''),
(1, 'OneselfStaff', 'index', ''),
(1, 'OneselfStaff', 'create', ''),
(1, 'OneselfStaff', 'edit', ''),
(1, 'OneselfStaff', 'destroy', ''),
(1, 'OneselfTagList', 'index', ''),
(1, 'OneselfTagList', 'create', ''),
(1, 'OneselfTagList', 'edit', ''),
(1, 'OneselfTagList', 'destroy', ''),
(1, 'OneselfTagList', 'isWapStatus', ''),
(1, 'OneselfNotice', 'index', ''),
(1, 'OneselfNotice', 'create', ''),
(1, 'OneselfNotice', 'edit', ''),
(1, 'OneselfNotice', 'destroy', ''),
(1, 'Service', 'index', ''),
(1, 'Service', 'create', ''),
(1, 'Service', 'createGoods', ''),
(1, 'Service', 'createService', ''),
(1, 'Service', 'updatebalance', ''),
(1, 'Service', 'edit', ''),
(1, 'Service', 'destroy', ''),
(1, 'Service', 'export', ''),
(1, 'Service', 'systemGoods', ''),
(1, 'Service', 'systemgoodsedit', ''),
(1, 'Service', 'cateLists', ''),
(1, 'Service', 'cateedit', ''),
(1, 'Service', 'serviceLists', ''),
(1, 'Service', 'serviceEdit', ''),
(1, 'Service', 'goodsLists', ''),
(1, 'Service', 'goodsEdit', ''),
(1, 'Service', 'creategoodscate', ''),
(1, 'Service', 'goodsDestroy', ''),
(1, 'Staff', 'index', ''),
(1, 'Staff', 'create', ''),
(1, 'Staff', 'edit', ''),
(1, 'Staff', 'destroy', ''),
(1, 'SellerAuthIcon', 'index', ''),
(1, 'SellerAuthIcon', 'create', ''),
(1, 'SellerAuthIcon', 'edit', ''),
(1, 'SellerAuthIcon', 'destroy', ''),
(1, 'SellerApply', 'index', ''),
(1, 'SellerApply', 'edit', ''),
(1, 'SellerApply', 'destroy', ''),
(1, 'SellerCate', 'index', ''),
(1, 'SellerCate', 'create', ''),
(1, 'SellerCate', 'edit', ''),
(1, 'SellerCate', 'destroy', ''),
(1, 'SystemGoods', 'index', ''),
(1, 'SystemGoods', 'create', ''),
(1, 'SystemGoods', 'edit', ''),
(1, 'SystemGoods', 'destroy', ''),
(1, 'SystemTagList', 'index', ''),
(1, 'SystemTagList', 'create', ''),
(1, 'SystemTagList', 'edit', ''),
(1, 'SystemTagList', 'destroy', ''),
(1, 'SystemTagList', 'secondLevel', ''),
(1, 'SystemTag', 'index', ''),
(1, 'SystemTag', 'create', ''),
(1, 'SystemTag', 'edit', ''),
(1, 'SystemTag', 'destroy', ''),
(1, 'Property', 'index', ''),
(1, 'Property', 'create', ''),
(1, 'Property', 'edit', ''),
(1, 'Property', 'destroy', ''),
(1, 'Property', 'export', ''),
(1, 'Property', 'dooropenlog', ''),
(1, 'Property', 'dooraccess', ''),
(1, 'Property', 'dooredit', ''),
(1, 'Property', 'buildingindex', ''),
(1, 'Property', 'buildingcreate', ''),
(1, 'Property', 'buildingedit', ''),
(1, 'Property', 'buildingdestroy', ''),
(1, 'Property', 'roomindex', ''),
(1, 'Property', 'roomcreate', ''),
(1, 'Property', 'roomedit', ''),
(1, 'Property', 'roomdestroy', ''),
(1, 'Property', 'puserindex', ''),
(1, 'Property', 'pusercheck', ''),
(1, 'Property', 'pusercreate', ''),
(1, 'Property', 'puseredit', ''),
(1, 'Property', 'puserdestroyaccess', ''),
(1, 'Property', 'puserdestroy', ''),
(1, 'Property', 'repairindex', ''),
(1, 'Property', 'repairdetail', ''),
(1, 'Property', 'repairsave', ''),
(1, 'Property', 'articleindex', ''),
(1, 'Property', 'articlecreate', ''),
(1, 'Property', 'articleedit', ''),
(1, 'Property', 'articledestroy', ''),
(1, 'Property', 'propertysystemindex', ''),
(1, 'Property', 'propertysystemcreate', ''),
(1, 'Property', 'propertysystemedit', ''),
(1, 'Property', 'propertysystemdestroy', ''),
(1, 'PropertyApply', 'index', ''),
(1, 'PropertyApply', 'detail', ''),
(1, 'RepairType', 'index', ''),
(1, 'RepairType', 'create', ''),
(1, 'RepairType', 'edit', ''),
(1, 'RepairType', 'destroy', ''),
(1, 'District', 'index', ''),
(1, 'District', 'create', ''),
(1, 'District', 'destroy', ''),
(1, 'District', 'edit', ''),
(1, 'District', 'search', ''),
(1, 'UserAppAdvPosition', 'index', ''),
(1, 'UserAppAdvPosition', 'create', ''),
(1, 'UserAppAdvPosition', 'edit', ''),
(1, 'UserAppAdvPosition', 'destroy', ''),
(1, 'UserAppAdv', 'index', ''),
(1, 'UserAppAdv', 'create', ''),
(1, 'UserAppAdv', 'edit', ''),
(1, 'UserAppAdv', 'destroy', ''),
(1, 'Menu', 'index', ''),
(1, 'Menu', 'create', ''),
(1, 'Menu', 'edit', ''),
(1, 'Menu', 'destroy', ''),
(1, 'Order', 'index', ''),
(1, 'Order', 'detail', ''),
(1, 'Order', 'export', ''),
(1, 'Order', 'destroy', ''),
(1, 'ServiceOrder', 'index', ''),
(1, 'ServiceOrder', 'detail', ''),
(1, 'ServiceOrder', 'export', ''),
(1, 'ServiceOrder', 'destroy', ''),
(1, 'AllOrder', 'index', ''),
(1, 'AllOrder', 'detail', ''),
(1, 'AllOrder', 'export', ''),
(1, 'AllOrder', 'destroy', ''),
(1, 'OneselfOrder', 'index', ''),
(1, 'OneselfOrder', 'edit', ''),
(1, 'OneselfOrder', 'destroy', ''),
(1, 'OneselfOrderService', 'index', ''),
(1, 'OneselfOrderService', 'edit', ''),
(1, 'OneselfOrderService', 'destroy', ''),
(1, 'IntegralOrder', 'index', ''),
(1, 'IntegralOrder', 'detail', ''),
(1, 'IntegralOrder', 'export', ''),
(1, 'IntegralOrder', 'destroy', ''),
(1, 'OrderRate', 'index', ''),
(1, 'OrderRate', 'detail', ''),
(1, 'OrderRate', 'rateReply', ''),
(1, 'OrderRate', 'destroy', ''),
(1, 'OrderStatistics', 'index', ''),
(1, 'OrderConfig', 'index', ''),
(1, 'InvitationSet', 'index', ''),
(1, 'InvitationSet', 'save', ''),
(1, 'InvitationOrder', 'index', ''),
(1, 'InvitationUser', 'index', ''),
(1, 'InvitationUser', 'invitationList', ''),
(1, 'IntegralConfig', 'edit', ''),
(1, 'IntegralConfig', 'save', ''),
(1, 'UserIntegral', 'index', ''),
(1, 'Integral', 'create', ''),
(1, 'Integral', 'edit', ''),
(1, 'Integral', 'index', ''),
(1, 'Integral', 'save', ''),
(1, 'Integral', 'destroy', ''),
(1, 'Integral', 'saveIntegral', ''),
(1, 'Promotion', 'index', ''),
(1, 'Promotion', 'create', ''),
(1, 'Promotion', 'edit', ''),
(1, 'Promotion', 'sendsn', ''),
(1, 'Promotion', 'sendsnlist', ''),
(1, 'Promotion', 'updatestatus', ''),
(1, 'Promotion', 'destroy', ''),
(1, 'Promotion', 'searchUser', ''),
(1, 'Promotion', 'send', ''),
(1, 'Promotion', 'searchSeller', ''),
(1, 'PromotionSn', 'index', ''),
(1, 'PromotionSn', 'destroy', ''),
(1, 'Activity', 'index', ''),
(1, 'Activity', 'create', ''),
(1, 'Activity', 'add', ''),
(1, 'Activity', 'edit', ''),
(1, 'Activity', 'destroy', ''),
(1, 'Activity', 'addSeller', ''),
(1, 'Activity', 'save_register_activity', ''),
(1, 'Activity', 'getpromotion', ''),
(1, 'Activity', 'share_activity', ''),
(1, 'Activity', 'save_full_activity', ''),
(1, 'Activity', 'save_new_activity', ''),
(1, 'Activity', 'save_full_data', ''),
(1, 'Activity', 'saveSellerIds', ''),
(1, 'Activity', 'deleteSellerIds', ''),
(1, 'Activity', 'cancellation', ''),
(1, 'Activity', 'save_share_activity', ''),
(1, 'User', 'index', ''),
(1, 'User', 'create', ''),
(1, 'User', 'edit', ''),
(1, 'User', 'destroy', ''),
(1, 'User', 'updatebalance', ''),
(1, 'User', 'export', ''),
(1, 'User', 'paylog', ''),
(1, 'User', 'paylogExport', ''),
(1, 'ForumPlate', 'index', ''),
(1, 'ForumPlate', 'create', ''),
(1, 'ForumPlate', 'destroy', ''),
(1, 'ForumPlate', 'edit', ''),
(1, 'ForumPosts', 'index', ''),
(1, 'ForumPosts', 'destroy', ''),
(1, 'ForumPosts', 'edit', ''),
(1, 'ForumPosts', 'detail', ''),
(1, 'PostsCheck', 'index', ''),
(1, 'KeyWords', 'index', ''),
(1, 'KeyWords', 'save', ''),
(1, 'ForumComplain', 'index', ''),
(1, 'ForumComplain', 'dispose', ''),
(1, 'ForumComplain', 'destroy', ''),
(1, 'ForumMessage', 'index', ''),
(1, 'ForumMessage', 'destroy', ''),
(1, 'UserAppMessageSend', 'index', ''),
(1, 'UserAppMessageSend', 'create', ''),
(1, 'UserAppMessageSend', 'destroy', ''),
(1, 'UserAppMessageSend', 'search', ''),
(1, 'StaffAppMessageSend', 'index', ''),
(1, 'StaffAppMessageSend', 'create', ''),
(1, 'StaffAppMessageSend', 'destroy', ''),
(1, 'UserAppFeedback', 'index', ''),
(1, 'UserAppFeedback', 'edit', ''),
(1, 'UserAppFeedback', 'destroy', ''),
(1, 'StaffAppFeedback', 'index', ''),
(1, 'StaffAppFeedback', 'edit', ''),
(1, 'StaffAppFeedback', 'destroy', ''),
(1, 'BusinessStatistics', 'index', ''),
(1, 'BusinessStatistics', 'monthAccount', ''),
(1, 'BusinessStatistics', 'dayAccount', ''),
(1, 'BusinessStatistics', 'export', ''),
(1, 'BusinessStatistics', 'monthaccountexport', ''),
(1, 'BusinessStatistics', 'dayaccountexport', ''),
(1, 'PlatformStatistics', 'index', ''),
(1, 'PlatformStatistics', 'export', ''),
(1, 'ProxyStatistics', 'index', ''),
(1, 'ProxyStatistics', 'sellerLists', ''),
(1, 'ProxyStatistics', 'monthAccount', ''),
(1, 'ProxyStatistics', 'dayAccount', ''),
(1, 'ProxyStatistics', 'export', ''),
(1, 'ProxyStatistics', 'sellerexport', ''),
(1, 'ProxyStatistics', 'monthaccountexport', ''),
(1, 'ProxyStatistics', 'dayaccountexport', ''),
(1, 'OneselfStatistics', 'index', ''),
(1, 'OneselfBusinessStatistics', 'index', ''),
(1, 'OneselfBusinessStatistics', 'export', ''),
(1, 'UserRefund', 'index', ''),
(1, 'UserRefund', 'dispose', ''),
(1, 'Nationwide', 'index', ''),
(1, 'Nationwide', 'dispose', ''),
(1, 'PayLog', 'index', ''),
(1, 'PayLog', 'export', ''),
(1, 'SellerPayLog', 'index', ''),
(1, 'SellerWithdraw', 'index', ''),
(1, 'SellerWithdraw', 'edit', ''),
(1, 'SellerWithdraw', 'dispose', ''),
(1, 'SellerWithdraw', 'export', ''),
(1, 'SellerWithdraw', 'getWithdrawMessage', ''),
(1, 'UserWithdraw', 'index', ''),
(1, 'UserWithdraw', 'edit', ''),
(1, 'UserWithdraw', 'dispose', ''),
(1, 'UserWithdraw', 'export', ''),
(1, 'UserWithdraw', 'getWithdrawMessage', ''),
(1, 'UserWithdraw', 'actions', ''),
(1, 'SellerStaffWithdraw', 'index', ''),
(1, 'SellerStaffWithdraw', 'edit', ''),
(1, 'SellerStaffWithdraw', 'dispose', ''),
(1, 'SellerStaffWithdraw', 'export', ''),
(1, 'SellerStaffWithdraw', 'getWithdrawMessage', ''),
(1, 'Payment', 'index', ''),
(1, 'Payment', 'edit', ''),
(1, 'Payment', 'update', ''),
(1, 'UserAppConfig', 'index', ''),
(1, 'StaffAppConfig', 'index', ''),
(1, 'StaffAppConfig', 'edit', ''),
(1, 'Config', 'index', ''),
(1, 'HotLists', 'index', ''),
(1, 'HotLists', 'create', ''),
(1, 'HotLists', 'edit', ''),
(1, 'HotLists', 'destroy', ''),
(1, 'IndexNav', 'index', ''),
(1, 'IndexNav', 'create', ''),
(1, 'IndexNav', 'edit', ''),
(1, 'IndexNav', 'destroy', ''),
(1, 'Watermark', 'index', ''),
(1, 'VcodeSet', 'index', ''),
(1, 'MsgModel', 'index', ''),
(1, 'MsgModel', 'getId', ''),
(1, 'MsgModel', 'save', ''),
(1, 'SmsConfig', 'index', ''),
(1, 'SmsConfig', 'save', ''),
(1, 'SmsConfig', 'surplus', ''),
(1, 'Article', 'index', ''),
(1, 'Article', 'create', ''),
(1, 'Article', 'edit', ''),
(1, 'Article', 'destroy', ''),
(1, 'ArticleCate', 'index', ''),
(1, 'ArticleCate', 'create', ''),
(1, 'ArticleCate', 'edit', ''),
(1, 'ArticleCate', 'destroy', ''),
(1, 'Proxy', 'index', ''),
(1, 'Proxy', 'create', ''),
(1, 'Proxy', 'destroy', ''),
(1, 'Proxy', 'edit', ''),
(1, 'Proxy', 'export', ''),
(1, 'ProxyAudit', 'index', ''),
(1, 'ProxyAudit', 'destroy', ''),
(1, 'ProxyAudit', 'edit', ''),
(1, 'ProxyAudit', 'audit', ''),
(1, 'City', 'index', ''),
(1, 'City', 'create', ''),
(1, 'City', 'destroy', ''),
(1, 'City', 'open', ''),
(1, 'Cache', 'index', ''),
(1, 'Dispatch', 'index', ''),
(1, 'Dispatch', 'getsendstaff', ''),
(1, 'Dispatch', 'changestaffsystem', ''),
(1, 'DispatchOrder', 'index', ''),
(1, 'DispatchOrder', 'getsendstaff', ''),
(1, 'DispatchOrder', 'changestaffsystem', ''),
(1, 'SystemStaff', 'index', ''),
(1, 'SystemStaff', 'create', ''),
(1, 'SystemStaff', 'edit', ''),
(1, 'SystemStaff', 'destroy', ''),
(1, 'SendDataSet', 'index', ''),
(1, 'SendDataSet', 'save', ''),
(1, 'SendDataStaff', 'index', ''),
(1, 'SendDataInfo', 'index', ''),
(1, 'FxExchange', 'index', ''),
(1, 'FxExchange', 'save', ''),
(1, 'FxManageUrl', 'index', ''),
(1, 'Sharechapman', 'index', ''),
(1, 'Sharechapman', 'dispose', '');

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%admin_user`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin_user` (
  `id` smallint(6) NOT NULL COMMENT '编号',
  `rid` smallint(6) DEFAULT NULL COMMENT '所属管理组',
  `name` varchar(30) DEFAULT NULL COMMENT '登陆名称',
  `crypt` char(6) DEFAULT '',
  `pwd` char(32) DEFAULT NULL COMMENT '登陆密码',
  `login_time` int(10) DEFAULT NULL COMMENT '最后登陆时间',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '最后登陆IP',
  `login_count` mediumint(8) DEFAULT NULL COMMENT '累计登陆次数',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员';

--
-- 转存表中的数据 `%DB_PREFIX%admin_user`
--

INSERT INTO `%DB_PREFIX%admin_user` (`id`, `rid`, `name`, `crypt`, `pwd`, `login_time`, `login_ip`, `login_count`, `create_time`, `status`) VALUES
(1, 1, 'admin', 'JqOZfe', '7c98995d372737672da9f496b7a5b5fd', 1482791167, '127.0.0.1', 1, NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%admin_user_city`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%admin_user_city` (
  `admin_user_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%adv`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%adv` (
  `id` int(10) unsigned NOT NULL,
  `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '城市编号,0 为所有城市',
  `position_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '广告位编号',
  `name` varchar(60) DEFAULT '' COMMENT '广告名称',
  `image` varchar(255) DEFAULT '' COMMENT '图片',
  `bg_color` varchar(8) DEFAULT '',
  `type` smallint(5) DEFAULT '0' COMMENT '链接类型',
  `arg` text COMMENT '链接参数',
  `sort` smallint(3) DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `seller_cate_id` int(11) NOT NULL DEFAULT '0' COMMENT '商家分类编号'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%adv_position`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%adv_position` (
  `id` int(10) unsigned NOT NULL,
  `code` varchar(32) DEFAULT NULL COMMENT '广告位唯一代码',
  `name` varchar(60) DEFAULT '' COMMENT '位置名称',
  `client_type` varchar(30) DEFAULT '' COMMENT '客户端类型',
  `width` smallint(5) unsigned DEFAULT '0' COMMENT '广告宽度',
  `height` smallint(5) unsigned DEFAULT '0' COMMENT '广告高度',
  `brief` varchar(255) DEFAULT '' COMMENT '位置描述',
  `style` text COMMENT '样式',
  `is_system` tinyint(1) DEFAULT '0' COMMENT '是否为系统内置'
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `%DB_PREFIX%adv_position`
--

INSERT INTO `%DB_PREFIX%adv_position` (`id`, `code`, `name`, `client_type`, `width`, `height`, `brief`, `style`, `is_system`) VALUES
(1, 'BUYER_INDEX_BANNER', '买家APP首页轮播', 'buyer', 640, 268, '', '', 1),
(2, 'BUYER_INDEX_MENU', '买家APP首页菜单', 'buyer', 320, 388, NULL, NULL, 1),
(25, 'BUYER_UDHVQBIC', '商家分类', 'buyer', 0, 0, NULL, NULL, 0),
(22, 'STAFF_BAGCURHT', '首页轮播', 'staff', 0, 0, NULL, NULL, 0),
(23, 'STAFF_NFDGSEKC', '首页分类', 'staff', 0, 0, NULL, NULL, 0),
(24, 'STAFF_MHNXFCGB', '首页列表', 'staff', 0, 0, NULL, NULL, 0),
(27, 'BUYER_SELLER_BANNER', '商家列表页广告位', 'buyer', 0, 0, NULL, NULL, 0),
(28, 'BUYER_INTEGRAL_BANNER', '积分商城', 'buyer', 640, 328, NULL, NULL, 0),
(29, 'BUYER_START_BANNER', 'APP启动广告页', 'buyer', 750, 1334, NULL, NULL, 0),
(30, 'BUYER_SYSTEM_ONESELF', '平台自营轮播', 'oneself', 640, 328, NULL, NULL, 1),
(31, 'BUYER_SYSTEM_ONESELF_MENU', '平台自营菜单', 'oneself', 640, 328, '', NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%article`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%article` (
  `id` int(11) NOT NULL COMMENT '编号',
  `cate_id` int(11) DEFAULT NULL COMMENT '分类编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `title` varchar(80) DEFAULT NULL COMMENT '标题',
  `brief` varchar(500) DEFAULT NULL COMMENT '简介',
  `image` varchar(255) DEFAULT NULL COMMENT '图片',
  `content` text COMMENT '内容',
  `sort` smallint(3) DEFAULT NULL COMMENT '排序',
  `create_time` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `read_time` int(11) DEFAULT NULL COMMENT '阅读时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章公告';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%article_cate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%article_cate` (
  `id` int(11) NOT NULL COMMENT '编号',
  `pid` int(11) DEFAULT NULL COMMENT '父分类',
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `sort` smallint(3) DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章分类';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%city_location`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%city_location` (
  `id` int(11) unsigned NOT NULL,
  `cityname` varchar(50) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  `lng` varchar(50) DEFAULT NULL,
  `lat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%city_open`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%city_open` (
  `id` int(11) NOT NULL DEFAULT '0',
  `province_id` mediumint(8) DEFAULT NULL COMMENT '所在省',
  `city_id` mediumint(8) DEFAULT NULL COMMENT '所在市',
  `area_id` mediumint(8) DEFAULT NULL COMMENT '所在县',
  `sort` smallint(3) DEFAULT '100' COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%district`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%district` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT '0' COMMENT '物业编号',
  `name` varchar(50) DEFAULT NULL COMMENT '小区名称',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `house_num` int(11) DEFAULT '0' COMMENT '户数',
  `area_num` int(11) DEFAULT '0' COMMENT '面积',
  `house_type` tinyint(2) DEFAULT NULL COMMENT '房产类型',
  `province_id` mediumint(8) DEFAULT NULL,
  `city_id` mediumint(8) DEFAULT NULL,
  `area_id` mediumint(8) DEFAULT NULL,
  `map_point` point DEFAULT NULL,
  `map_point_str` varchar(60) DEFAULT NULL,
  `map_pos` polygon DEFAULT NULL,
  `map_pos_str` varchar(60) DEFAULT NULL,
  `departid` varchar(20) DEFAULT NULL COMMENT '小区编号',
  `depart_tel` varchar(20) DEFAULT NULL COMMENT '小区负责人电话',
  `depart_mail` varchar(50) DEFAULT NULL COMMENT '小区负责人邮件',
  `depart_street` varchar(200) DEFAULT NULL COMMENT '小区街道',
  `depart_address` varchar(200) DEFAULT NULL COMMENT '地址',
  `depart_common` varchar(200) DEFAULT NULL COMMENT '说明',
  `first_level` int(11) DEFAULT NULL COMMENT '一级代理',
  `second_level` int(11) DEFAULT NULL COMMENT '二级代理',
  `third_level` int(11) DEFAULT NULL COMMENT '三级代理'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%door_access`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%door_access` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT NULL COMMENT '物业公司编号',
  `district_id` int(11) DEFAULT NULL COMMENT '小区编号',
  `name` varchar(50) DEFAULT NULL COMMENT '门禁名称',
  `pid` varchar(50) DEFAULT NULL COMMENT '门禁api编号',
  `type` tinyint(1) DEFAULT '1' COMMENT '0楼宇大门1小区大门',
  `build_id` int(11) DEFAULT '0' COMMENT '楼栋号',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `install_address` varchar(200) DEFAULT NULL COMMENT '安装位置',
  `install_gps` varchar(50) DEFAULT NULL COMMENT 'GPS',
  `install_work` varchar(20) DEFAULT NULL COMMENT '安装人',
  `install_telete` varchar(20) DEFAULT NULL COMMENT '安装人电话',
  `install_comm` varchar(200) DEFAULT NULL COMMENT '安装说明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='门禁';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%door_open_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%door_open_log` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `door_id` int(11) DEFAULT NULL COMMENT '门禁编号',
  `build_id` int(11) DEFAULT NULL COMMENT '楼栋编号',
  `room_id` int(11) DEFAULT NULL COMMENT '房间编号 ',
  `puser_id` int(11) DEFAULT NULL COMMENT '业主编号',
  `error_code` varchar(50) DEFAULT NULL COMMENT '错误码',
  `create_time` int(11) DEFAULT NULL,
  `create_day` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='开门记录';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%feedback`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%feedback` (
  `id` int(11) NOT NULL COMMENT '编号',
  `type` enum('buyer','staff','seller') DEFAULT NULL COMMENT '类型',
  `user_id` int(11) DEFAULT NULL COMMENT '反馈人',
  `seller_id` int(11) DEFAULT NULL COMMENT '反馈人',
  `staff_id` int(11) DEFAULT NULL COMMENT '员工编号',
  `client_type` varchar(500) DEFAULT NULL COMMENT '客户端类',
  `client_info` varchar(500) DEFAULT NULL COMMENT '客户端信息',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `dispose_time` int(11) DEFAULT '0' COMMENT '处理时间',
  `dispose_result` varchar(500) DEFAULT '' COMMENT '处理备注',
  `dispose_admin_id` int(11) DEFAULT '0' COMMENT '处理人员编号',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意见反馈';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%forum_complain`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_complain` (
  `id` int(11) NOT NULL COMMENT '编号',
  `user_id` int(11) DEFAULT NULL COMMENT '反馈人',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `dispose_time` int(11) DEFAULT '0' COMMENT '处理时间',
  `dispose_result` varchar(500) DEFAULT '' COMMENT '处理备注',
  `dispose_admin_id` int(11) DEFAULT '0' COMMENT '处理人员编号',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `post_id` int(11) DEFAULT '0' COMMENT '帖子编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛帖子举报';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%forum_message`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_message` (
  `id` int(11) NOT NULL,
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '类型 1:系统消息 2:其他 (后续待增加) ',
  `title` varchar(60) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `relate_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '发送会员编号',
  `user_id` int(11) NOT NULL COMMENT '接收会员编号',
  `posts_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联编号(帖子编号)',
  `send_time` int(11) NOT NULL DEFAULT '0' COMMENT '发送时间',
  `send_type` smallint(1) NOT NULL DEFAULT '1' COMMENT '1:普通消息 2:html页面 args为url 3:订单消息 args为订单ID',
  `read_time` int(11) NOT NULL DEFAULT '0' COMMENT '阅读时间',
  `relate_id` int(11) NOT NULL DEFAULT '0',
  `args` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%forum_plate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_plate` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL COMMENT '板块名称',
  `icon` varchar(100) DEFAULT NULL,
  `is_system` tinyint(1) DEFAULT '0' COMMENT '1、系统内置 0、自定义',
  `sort` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%forum_posts`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%forum_posts` (
  `id` int(11) NOT NULL,
  `pid` int(11) DEFAULT '0' COMMENT '0 表示帖子， 大于0回复编号为pid的帖子',
  `reply_id` int(11) DEFAULT NULL COMMENT '帖子/回复的编号',
  `user_id` int(11) DEFAULT NULL COMMENT '创建者',
  `reply_user_id` int(11) DEFAULT NULL COMMENT '帖子拥有者/回复的拥有者编号',
  `plate_id` int(11) DEFAULT NULL COMMENT '所属板块',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `reply_content` text COMMENT '回复的内容',
  `images` text COMMENT '图片',
  `address_id` varchar(11) DEFAULT NULL COMMENT '联系方式',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `create_date` int(11) DEFAULT NULL COMMENT '创建日期',
  `rate_num` int(11) DEFAULT '0' COMMENT '好评数',
  `good_num` int(11) DEFAULT '0' COMMENT '点赞数量',
  `top` tinyint(1) DEFAULT '0' COMMENT '0不顶置，1顶置',
  `hot` tinyint(1) DEFAULT '0' COMMENT '0不热门，1热门',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态1开启，0关闭',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '0未删除，1删除',
  `is_check` tinyint(1) DEFAULT '0' COMMENT '审核状态0未审核1通过-1拒绝'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%freight_tmp`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%freight_tmp` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL COMMENT '商家编号',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT 'X件商品内',
  `money` double(10,2) NOT NULL DEFAULT '0.00' COMMENT 'X件商品内运费',
  `add_num` int(11) NOT NULL DEFAULT '0' COMMENT '增加Y件商品（X已满足的情况下）',
  `add_money` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '增加Y件商品运费（X已满足的情况下）',
  `is_default` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否是默认'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家运费模版';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%freight_tmp_city`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%freight_tmp_city` (
  `freight_tmp_id` int(11) NOT NULL COMMENT '商家运费模版编号',
  `seller_id` int(11) NOT NULL COMMENT '商家编号',
  `region_id` int(11) NOT NULL COMMENT '城市编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家运费模版城市关联表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%goods`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods` (
  `id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL COMMENT '分类编号',
  `goods_sn` varchar(32) DEFAULT NULL COMMENT '商品编码',
  `system_goods_id` int(11) DEFAULT '0' COMMENT '通用商品id',
  `seller_id` int(11) NOT NULL COMMENT '服务站编号',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '1:商品，2：服务',
  `name` varchar(60) DEFAULT NULL COMMENT '服务/商品名称',
  `unit` tinyint(1) DEFAULT '0' COMMENT '时长单位，0:分钟，1:小时',
  `duration` int(11) DEFAULT '0' COMMENT '预约时长',
  `images` text COMMENT '菜品图片',
  `price` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '现价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `total_stock` int(11) DEFAULT '0' COMMENT '总库存',
  `brief` text COMMENT '描述',
  `buy_limit` int(11) DEFAULT '0' COMMENT '购买限制',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '上架状态 0：下架 1：上架',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `dispose_time` int(11) DEFAULT NULL COMMENT '处理时间',
  `dispose_result` varchar(500) DEFAULT NULL COMMENT '处理结果',
  `dispose_status` int(2) DEFAULT NULL COMMENT '处理状态 0：待审核 1：审核通过 -1：审核未通过',
  `sort` smallint(6) DEFAULT '100',
  `deduct_type` tinyint(1) DEFAULT '1' COMMENT '提成方式1固定2百分比',
  `deduct_val` char(5) DEFAULT '0' COMMENT '提成值',
  `exchange_integral` int(11) DEFAULT NULL COMMENT '可兑换商品积分',
  `is_integral` smallint(4) DEFAULT '0' COMMENT '是否是积分商品',
  `is_virtual` smallint(4) DEFAULT '0' COMMENT '0不是,1是',
  `system_tag_list_pid` int(11) DEFAULT NULL COMMENT '商品标签分类（一级）',
  `system_tag_list_id` int(11) DEFAULT NULL COMMENT '商品标签分类（二级）',
  `is_updata` tinyint(1) DEFAULT '0' COMMENT '0更新 ，1未更新'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%goods_cate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_cate` (
  `id` int(11) NOT NULL COMMENT '编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `trade_id` int(11) DEFAULT NULL COMMENT '商家行业分类',
  `pid` int(11) DEFAULT '0' COMMENT '父编号',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:商品，2：服务',
  `name` varchar(20) DEFAULT '' COMMENT '名称',
  `img` varchar(255) DEFAULT NULL COMMENT '图片',
  `sort` smallint(3) DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `is_wap_status` tinyint(1) DEFAULT '0' COMMENT '推荐到首页'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%goods_extend`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_extend` (
  `goods_id` int(11) NOT NULL COMMENT '商品编号',
  `seller_id` int(11) DEFAULT NULL COMMENT '卖家编号',
  `restaurant_id` int(11) DEFAULT '0',
  `collect_count` int(11) DEFAULT '0' COMMENT '被收藏数量',
  `browse_count` int(11) DEFAULT '0' COMMENT '浏览数',
  `comment_total_count` int(11) DEFAULT '0' COMMENT '评价总次数',
  `comment_good_count` int(11) DEFAULT '0' COMMENT '评价-好评数',
  `comment_neutral_count` int(11) DEFAULT '0' COMMENT '评价-中评数',
  `comment_bad_count` int(11) DEFAULT '0' COMMENT '评价-差评数',
  `sales_volume` int(11) DEFAULT '0' COMMENT '销量',
  `share_num` int(11) DEFAULT '0' COMMENT '分享数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品扩展表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%goods_norms`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_norms` (
  `id` int(11) NOT NULL COMMENT '编号',
  `goods_id` int(11) NOT NULL COMMENT '商品编号',
  `seller_id` int(11) NOT NULL COMMENT '卖家编号',
  `name` varchar(50) NOT NULL COMMENT '规格名称',
  `price` double(11,2) DEFAULT NULL COMMENT '价格',
  `stock` int(11) DEFAULT NULL COMMENT '库存'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%goods_staff`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%goods_staff` (
  `staff_id` int(11) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%hot_words`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%hot_words` (
  `id` int(11) NOT NULL COMMENT '主键',
  `hotwords` varchar(50) DEFAULT NULL COMMENT '热门搜索词',
  `province_id` int(11) DEFAULT '0' COMMENT '省id',
  `city_id` int(11) DEFAULT '0' COMMENT '市id',
  `area_id` int(11) DEFAULT '0' COMMENT '区县id',
  `sort` int(11) DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `create_time` int(11) DEFAULT '0' COMMENT '时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%index_nav`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%index_nav` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '名称',
  `city_id` int(11) DEFAULT NULL COMMENT '城市ID',
  `icon` varchar(200) CHARACTER SET latin1 DEFAULT NULL COMMENT '图标',
  `type` tinyint(1) DEFAULT NULL COMMENT '1、加盟首页，2、商品分类，3、平台自营商城，4、购物车，5、生活圈，6、物业，7、个人中心，8、签到，9、积分商城',
  `sort` int(5) DEFAULT '100' COMMENT '排序',
  `is_system` tinyint(1) DEFAULT '0' COMMENT '是否是系统设置 1 是 0 否',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 1 启用 0 关闭'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='首页底部导航管理';

--
-- 转存表中的数据 `%DB_PREFIX%index_nav`
--

INSERT INTO `%DB_PREFIX%index_nav` (`id`, `name`, `city_id`, `icon`, `type`, `sort`, `is_system`, `status`) VALUES
(1, '首页', 0, '&#xf603,&#xf605', 1, 1, 0, 1),
(2, '购物车', 0, '&#xf602,&#xf604', 4, 2, 0, 1),
(3, '消息', 0, '&#xf607,&#xf706', 10, 3, 0, 1),
(4, '我的', 0, '&#xf707,&#xf708', 7, 4, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%invitation`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%invitation` (
  `id` int(11) NOT NULL COMMENT '编号',
  `user_status` tinyint(4) DEFAULT '0' COMMENT '是否开启会员邀请功能：0=不开启 1=开启',
  `user_percent` double(10,2) DEFAULT '0.00' COMMENT '会员一级返佣比率（%）',
  `user_percent_second` double(10,2) DEFAULT '0.00' COMMENT '会员二级返佣比率（%）',
  `user_percent_third` double(10,2) DEFAULT '0.00' COMMENT '会员三级返佣比率（%）',
  `is_all_user_primary` double(10,2) DEFAULT '0.00' COMMENT '会员初级返佣比率（%）',
  `is_all_user_percent` double(10,2) DEFAULT '0.00' COMMENT '会员一级返佣比率（%）',
  `is_all_user_percent_second` double(10,2) DEFAULT '0.00' COMMENT '会员二级返佣比率（%）',
  `is_all_user_percent_third` double(10,2) DEFAULT '0.00' COMMENT '会员三级返佣比率（%）',
  `seller_status` tinyint(4) DEFAULT '0' COMMENT '是否开启商家邀请功能：0=不开启 1=开启',
  `seller_percent` double(10,2) DEFAULT '0.00' COMMENT '商家一级返佣比率（%）',
  `seller_percent_second` double(10,2) DEFAULT '0.00' COMMENT '商家二级返佣比率（%）',
  `seller_percent_third` double(10,2) DEFAULT '0.00' COMMENT '商家三级返佣比率（%）',
  `full_money` double(10,2) DEFAULT '0.00' COMMENT '消费金额满X元 返现',
  `share_title` varchar(255) DEFAULT NULL COMMENT '链接标题',
  `share_content` varchar(255) DEFAULT NULL COMMENT '链接内容',
  `share_logo` varchar(500) DEFAULT NULL COMMENT '分享图标',
  `invite_logo` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '邀请分享logo',
  `share_explain` text COMMENT '活动说明',
  `share_describe` text COMMENT '分享说明',
  `points_no_explain` text COMMENT '分拥说明'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='邀请返现设置';

--
-- 转存表中的数据 `%DB_PREFIX%invitation`
--

INSERT INTO `%DB_PREFIX%invitation` (`id`, `user_status`, `user_percent`, `user_percent_second`, `user_percent_third`, `is_all_user_primary`, `is_all_user_percent`, `is_all_user_percent_second`, `is_all_user_percent_third`, `seller_status`, `seller_percent`, `seller_percent_second`, `seller_percent_third`, `full_money`, `share_title`, `share_content`, `share_logo`, `invite_logo`, `share_explain`, `share_describe`, `points_no_explain`) VALUES
(1, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%invitation_back_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%invitation_back_log` (
  `id` int(11) NOT NULL COMMENT '编号',
  `order_id` int(11) DEFAULT NULL COMMENT '订单编号',
  `status` int(11) DEFAULT NULL COMMENT '日志状态',
  `user_id` int(11) DEFAULT NULL COMMENT '购买用户编号',
  `level` tinyint(1) DEFAULT '1' COMMENT '分佣等级',
  `invitation_type` varchar(20) DEFAULT NULL COMMENT '推荐人类型 seller,user,staff',
  `invitation_id` int(11) DEFAULT NULL COMMENT '推荐人编号',
  `percent` double(10,2) DEFAULT '0.00' COMMENT '当前返现比率（%）',
  `return_fee` double(10,2) DEFAULT '0.00' COMMENT '返现金额',
  `is_refund` tinyint(4) DEFAULT '0' COMMENT '是否有退款 1=有 0=无',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `create_day` int(11) DEFAULT NULL COMMENT '创建时间（天）',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `share_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '分享人的订单Id',
  `is_show` tinyint(1) DEFAULT '0' COMMENT '是否显示数字/未读'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邀请返现订单日志';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%live_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%live_log` (
  `id` int(11) unsigned NOT NULL COMMENT '只增id',
  `content` varchar(80) CHARACTER SET utf8 DEFAULT '',
  `money` float(8,2) unsigned DEFAULT '0.00' COMMENT '0',
  `is_pay` tinyint(1) DEFAULT NULL COMMENT '是否支付',
  `user_id` int(11) unsigned DEFAULT NULL,
  `sn` char(22) CHARACTER SET utf8 DEFAULT '',
  `create_time` int(11) unsigned DEFAULT '0',
  `create_day` int(11) unsigned DEFAULT '0',
  `extend` text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%logistics_refund`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%logistics_refund` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `order_id` int(11) DEFAULT '0' COMMENT '订单编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `images` text,
  `refund_type` tinyint(1) DEFAULT NULL COMMENT '退货类型',
  `refund_explain` text,
  `seller_dispose_time` int(11) DEFAULT NULL COMMENT '商家处理时间',
  `seller_address` text COMMENT '收地址',
  `seller_dispose_content` text,
  `seller_dispose_images` text,
  `seller_dispose_explain` text,
  `user_dispose_images` text,
  `user_dispose_number` text,
  `user_dispose_name` text,
  `user_dispose_code` text,
  `user_dispose_time` int(11) DEFAULT NULL,
  `staff_dispose_time` int(11) DEFAULT NULL,
  `refund_id` int(11) DEFAULT NULL,
  `admin_dispose_time` int(11) DEFAULT NULL,
  `admin_dispose_content` text,
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%menu`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%menu` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(20) DEFAULT '',
  `city_id` int(11) unsigned DEFAULT '0' COMMENT '所在市',
  `menu_icon` varchar(255) DEFAULT NULL,
  `type` tinyint(1) unsigned DEFAULT '1' COMMENT '类型',
  `arg` varchar(255) DEFAULT '',
  `sort` int(11) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '状态',
  `platform_type` char(255) DEFAULT 'common' COMMENT ' ''common       通用版\\r\\npersonal     个人加盟版\\r\\norganization 机构加盟版\\r\\noneself		自营版''',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%message_send`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%message_send` (
  `id` int(11) NOT NULL COMMENT '编号',
  `type` varchar(20) DEFAULT NULL COMMENT '类型',
  `title` varchar(80) DEFAULT NULL COMMENT '标题',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `args` text COMMENT '参数',
  `users` text COMMENT '接收人',
  `send_time` int(11) DEFAULT NULL COMMENT '发送时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息推送';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%msg_model`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%msg_model` (
  `id` int(11) NOT NULL COMMENT '编号',
  `name` varchar(250) DEFAULT NULL,
  `content` text NOT NULL COMMENT '内容',
  `title` tinytext COMMENT '标题',
  `type` char(50) DEFAULT NULL COMMENT '类型',
  `code` varchar(100) DEFAULT NULL COMMENT '模板内容',
  `tip` text COMMENT '说明',
  `is_send_msg` tinyint(4) DEFAULT '1' COMMENT '是否发送短息通知',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='短信模板配置';

--
-- 转存表中的数据 `%DB_PREFIX%msg_model`
--

INSERT INTO `%DB_PREFIX%msg_model` (`id`, `name`, `content`, `title`, `type`, `code`, `tip`, `is_send_msg`, `status`) VALUES
(1, '接受订单', '您的订单编号为{{$sn}}已经由卖家{{$seller[''name'']}}电话{{$seller[''mobile'']}}受理\r\n', '商家已接受您的订单', 'order', 'order.accept.content', '{{$sn}}订单SN码 {{$seller[''name'']}}商家名称 {{$seller[''mobile'']}}商家电话', 1, 1),
(2, '订单取消', '买家取消了编号为 {{ $sn }} 的订单111', '  买家取消了订单', 'order', 'order.cancel.content', '  {{ $sn }} 订单SN码', 1, 1),
(3, '订单确认', '买家确认了编号为 {{ $sn }} 的订单为完成', ' 买家确认订单为完成', 'order', 'order.confirm.content', ' {{ $sn }}订单编号', 0, 1),
(4, '订单创建', '您有一个新的订单 {{ $sn }}，请及时配送！', ' 您有一个新的订单，请及时配送！', 'order', 'order.create.content', ' {{ $sn }}订单SN码', 1, 1),
(5, '订单指派', '您有一个新的订单 {{ $sn }}，请及时配送！', '  您有一个新的配送任务', 'order', 'order.designate.content', '   {{ $sn }}订单SN码', 1, 1),
(6, '缴费', '您的{{$type}}费户号为{{$account}}缴费{{$state}}', '   您有一个新的消息', 'order', 'order.message.content', ' {{$type}}类型{{$account}}帐号{{$state}}编号', 1, 1),
(7, '新用户注册', '恭喜您！新注册用户获得{{ $num }}张优惠券，总金额{{ $money }}元，点击查看>>', ' 您有一个新的消息', 'order', 'order.live.content', ' {{ $num }}优惠券数量  {{ $money }}优惠券总金额；', 1, 1),
(8, '订单支付', '买家成功支付编号为 {{ $sn }} 的订单，请及时配送', '  买家成功支付订单', 'order', 'order.pay.content', '  {{ $sn }} 订单SN码', 1, 1),
(9, '订单拒绝', '商家已拒绝您编号为 {{ $sn }} 的订单。', '   商家已拒绝您的订单', 'order', 'order.refund.content', '  {{ $sn }} 订单SN码', 1, 1),
(10, '订单退款', '您编号为 {{ $sn }} 的订单退款成功', '  退款成功', 'order', 'order.refundpay.content', '  {{ $sn }} 订单SN码', 1, 1),
(11, '订单配送', '您编号为 {{ $sn }}的订单,已由配送员{{ $staff[''name''] }},电话{{ $staff[''mobile''] }},为您提供配送服务。', ' 您的订单已在配送中...', 'order', 'order.staff.content', '  {{ $sn }} 订单SN码 {{ $staff[''name''] }} 配送人员名称 {{ $staff[''mobile''] }}配送人员电话', 1, 1),
(12, '订单催单', '买家正在催促编号为 {{ $sn }} 的订单，请尽快处理', '  买家催单提醒', 'order', 'order.urge.content', '  {{ $sn }} 订单SN码', 1, 0),
(13, '用户取消订单', '您编号为 {{ $sn }} 的订单已取消', '  您成功取消了一个订单', 'order', 'order.usercancel.content', '  {{ $sn }} 订单SN码', 1, 1),
(14, '商家注册失败', '入驻失败：亲爱的{{ $mobile }}，很遗憾通知您的开店申请由于“{{ $content }}”申请失败。请重新提交。感谢您的对{{ $site_name }}的信任与支持！', '亲爱的商家，你的开启审核未通过', 'seller', 'seller.reg.reject.content', '亲爱的商家，你的开店审核未通过', 1, 1),
(15, '获得优惠券', '恭喜，您获得{{ $number }}张{{ $money }}元的优惠券！', '新优惠券提醒', 'promotion', 'promotion.user.content', '获得新优惠券', 0, 1),
(16, '商家注册成功', '入驻成功：亲爱的{{ $mobile }}，您的开店申请已通过！请到个人中心里面下载商家app,感谢您的对{{ $site_name }}的信任与支持！', '恭喜您开店成功', 'seller', 'seller.reg.success.content', '恭喜您开店成功', 1, 1),
(17, '优惠券将过期', '你有{{ $num }}张优惠券即将过期,总价值{{$money}}元,快去使用吧！', '优惠券提醒', 'promotion', 'promotion.sendmessage.content', '{{ $num }}张数 {{$money}}总金额 ', 1, 1),
(18, '物业消息', '您有一条新的物业账单，点击查看。', '物业消息', 'message', 'message.propertybill.content', '物业消息', 1, 1),
(19, '订单配送更改', '您的订单编号为{{$sn}}已经改派，请不用再跟进!', '您的订单已改派', 'order', 'order.changesellerstaff', '{{ $sn }} 订单SN码', 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%order`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%order` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT '订单号',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `seller_staff_id` int(11) DEFAULT NULL COMMENT '人员编号',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `duration` int(11) DEFAULT NULL COMMENT '总时长 （分钟）',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动编号',
  `order_type` int(11) DEFAULT NULL COMMENT '1:商品类 2:服务类',
  `total_fee` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `seller_fee` double(10,2) DEFAULT '0.00' COMMENT '商家金额',
  `goods_fee` double(10,2) DEFAULT '0.00' COMMENT '商品/服务总价格',
  `discount_fee` double(10,2) DEFAULT '0.00' COMMENT '优惠金额',
  `pay_fee` double(10,2) DEFAULT '0.00' COMMENT '支付金额',
  `refund_fee` double(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `freight` double(10,2) DEFAULT '0.00' COMMENT '配送费',
  `freight_info` varchar(255) DEFAULT NULL COMMENT '配送费优惠信息',
  `staff_fee` double(10,2) DEFAULT '0.00' COMMENT '服务人员佣金',
  `drawn_fee` double(10,2) DEFAULT '0.00' COMMENT '平台抽成金额',
  `pay_money` double(10,2) DEFAULT '0.00' COMMENT '余额支付已支付金额',
  `name` varchar(30) DEFAULT '' COMMENT '联系人',
  `name_match` text,
  `mobile` char(12) DEFAULT '' COMMENT '联系手机',
  `address_id` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT '' COMMENT '地址',
  `map_point` varchar(100) DEFAULT NULL COMMENT '地图坐标',
  `province_id` int(11) DEFAULT NULL COMMENT '省编号',
  `province` varchar(60) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `city` varchar(60) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `area` varchar(60) DEFAULT NULL,
  `buy_remark` varchar(500) DEFAULT '' COMMENT '买家备注',
  `invoice_remark` varchar(500) DEFAULT NULL COMMENT '发票抬头',
  `gift_remark` varchar(500) DEFAULT NULL COMMENT '贺卡内容',
  `app_time` int(11) DEFAULT NULL COMMENT '预约时间',
  `app_day` int(11) DEFAULT NULL COMMENT '预约时间（天）',
  `is_rate` tinyint(1) DEFAULT '0' COMMENT '会员是否已经评价',
  `status` int(10) DEFAULT '0' COMMENT '订单状态',
  `pay_type` char(30) DEFAULT '',
  `pay_status` tinyint(1) DEFAULT '0' COMMENT '支付状态',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `refund_images` text COMMENT '退款图片集',
  `refund_content` text COMMENT '退款理由',
  `refund_time` int(11) DEFAULT NULL COMMENT '退款申请时间',
  `dispose_refund_admin` int(11) DEFAULT NULL,
  `dispose_refund_time` int(11) DEFAULT NULL COMMENT '退款处理时间',
  `dispose_refund_remark` text COMMENT '处理退款备注',
  `dispose_refund_seller_time` int(11) DEFAULT NULL COMMENT '商家处理退款时间',
  `dispose_refund_seller_remark` text COMMENT '商家处理退款备注',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `seller_confirm_time` int(11) DEFAULT NULL COMMENT '商家接单时间',
  `cancel_time` int(11) DEFAULT NULL COMMENT '取消订单时间',
  `staff_finish_time` int(11) DEFAULT NULL COMMENT '服务人员确认完成时间',
  `buyer_finish_time` int(11) DEFAULT NULL COMMENT '买家确认完成时间',
  `cancel_remark` varchar(500) DEFAULT NULL COMMENT '取消订单备注',
  `fre_time` int(11) DEFAULT NULL COMMENT '配送/服务时间',
  `fre_type` varchar(50) DEFAULT NULL COMMENT '配送方式',
  `count` int(11) DEFAULT '0' COMMENT '合计数量',
  `auto_cancel_time` int(11) DEFAULT NULL COMMENT '自动取消时间',
  `auto_finish_time` int(11) DEFAULT NULL COMMENT '自动完成时间',
  `promotion_sn_id` int(11) DEFAULT '0' COMMENT '优惠券码编号',
  `promotion_is_show` tinyint(1) unsigned DEFAULT '0' COMMENT '优惠信息显示了没有 0没显示 1显示了',
  `first_level` int(11) DEFAULT NULL COMMENT '一级代理',
  `second_level` int(11) DEFAULT NULL COMMENT '二级代理',
  `third_level` int(11) DEFAULT NULL COMMENT '三级代理',
  `send_way` tinyint(4) DEFAULT NULL COMMENT '配送方式',
  `auth_code` varchar(255) DEFAULT NULL COMMENT '订单验证码：用于门店自提和到店验证，自动完成订单使用，会员可见，商家不可见',
  `auth_code_use` tinyint(4) DEFAULT NULL COMMENT '是否使用验证码：-1=已使用 1=未使用 ',
  `auth_code_use_time` int(11) NOT NULL DEFAULT '0' COMMENT '消费码使用时间',
  `is_now` tinyint(4) DEFAULT '0' COMMENT '是否立即送出 0=否 1=是',
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT '抵扣积分',
  `integral_fee` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '积分抵扣金额',
  `is_integral_goods` int(11) NOT NULL DEFAULT '0' COMMENT '是否为积分商品 1:是 0:不是',
  `seller_withdraw_time` int(11) NOT NULL DEFAULT '0' COMMENT '商家可提现时间',
  `is_invitation` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否是邀请返现订单： 1：是（查询返现日志写资金流水） 0：否'',',
  `return_fee` double(10,2) DEFAULT '0.00' COMMENT '0.00',
  `activity_full_id` int(11) DEFAULT NULL COMMENT '参加满减的活动编号',
  `activity_goods_id` varchar(500) DEFAULT NULL COMMENT '参加特价的商品的编号',
  `system_full_subsidy` double(10,2) DEFAULT '0.00' COMMENT '平台满减补贴金额(平台)',
  `seller_full_subsidy` double(10,2) DEFAULT '0.00' COMMENT '商家满减补贴金额(商家)',
  `activity_full_money` double(10,2) DEFAULT NULL COMMENT '满减活动金额(平台/商家)',
  `activity_goods_money` double(10,2) DEFAULT NULL COMMENT '特价商品优惠金额(商家)',
  `activity_new_money` double(10,2) DEFAULT NULL COMMENT '首单立减金额(平台)',
  `is_all` tinyint(4) DEFAULT '0' COMMENT '1：全国店订单 0：周边店订单',
  `auto_rate_time` varchar(11) DEFAULT NULL COMMENT '订单自动评价时间',
  `fanwefx_data` text COMMENT '方维分销数据',
  `fanwefx_status` tinyint(4) DEFAULT NULL COMMENT '结算状态：0-未结算;1-已结算;2-已取消',
  `share_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '分享人的订单Id',
  `send_fee` double(10,2) unsigned DEFAULT '0.00' COMMENT '配送服务费',
  `send_staff_fee` double(10,2) unsigned DEFAULT '0.00' COMMENT '服务人员得的配送服务费',
  `send_system_fee` double(10,2) unsigned DEFAULT '0.00' COMMENT '系统得的服务配送费',
  `is_cancel_call` tinyint(1) unsigned DEFAULT '0' COMMENT '是否取消过呼叫配送 0=未使用 1=使用过了'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%order_goods`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%order_goods` (
  `id` int(10) NOT NULL COMMENT '订单商品ID',
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '商家编号',
  `order_id` int(10) NOT NULL COMMENT '订单ID',
  `goods_name` varchar(60) DEFAULT NULL COMMENT '商品',
  `goods_duration` int(11) DEFAULT NULL,
  `goods_images` varchar(255) DEFAULT NULL COMMENT '图片',
  `goods_norms` varchar(50) DEFAULT NULL COMMENT '规格',
  `goods_id` int(10) NOT NULL COMMENT '商品ID',
  `goods_norms_id` int(11) NOT NULL COMMENT '商品规格编号',
  `price` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `num` int(11) NOT NULL COMMENT '数量',
  `comment_score` int(11) DEFAULT '0' COMMENT '评价得分',
  `comment_remark` varchar(500) DEFAULT '' COMMENT '评价备注',
  `comment_time` int(11) DEFAULT '0' COMMENT '评价时间',
  `reply` varchar(500) DEFAULT '' COMMENT '回复内容',
  `reply_time` int(11) DEFAULT '0' COMMENT '回复时间',
  `is_rate` int(1) DEFAULT '0',
  `sale_price` double(10,2) DEFAULT '0.00' COMMENT '折扣价'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%order_promotion`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%order_promotion` (
  `id` int(11) NOT NULL COMMENT '编号',
  `order_id` int(11) DEFAULT '0' COMMENT '订单编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `promotion_id` int(11) DEFAULT '0' COMMENT '优惠编号',
  `promotion_sn_id` int(11) DEFAULT '0' COMMENT '优惠发放表ID',
  `discount_fee` double(10,2) DEFAULT '0.00' COMMENT '优惠金额',
  `promotion_name` varchar(80) DEFAULT '' COMMENT '优惠名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单优惠详细';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%order_rate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%order_rate` (
  `id` int(11) NOT NULL COMMENT '编号',
  `order_id` int(11) DEFAULT '0' COMMENT '订单编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `staff_id` int(11) DEFAULT NULL COMMENT '员工编号',
  `user_id` int(11) DEFAULT '0' COMMENT '评价人编号',
  `star` smallint(1) DEFAULT NULL COMMENT '评论星级(1-5星)',
  `content` varchar(500) DEFAULT NULL COMMENT '评价内容',
  `images` text COMMENT '评介图片集',
  `reply` varchar(500) DEFAULT '' COMMENT '回复内容',
  `reply_time` int(11) DEFAULT '0' COMMENT '回复时间',
  `result` enum('good','neutral','bad') DEFAULT NULL COMMENT '结果',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `is_ano` smallint(1) DEFAULT '0' COMMENT '是否匿名 1 是 0否',
  `is_all` tinyint(4) DEFAULT '0' COMMENT '是否是全国店评价 1：是 0：否',
  `goods_id` int(11) DEFAULT NULL COMMENT '商品编号',
  `goods_star` tinyint(4) DEFAULT NULL COMMENT '商品评分'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单评价';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%order_track`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%order_track` (
  `id` int(11) NOT NULL COMMENT '编号',
  `seller_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL COMMENT '订单编号',
  `express_company` varchar(20) DEFAULT NULL COMMENT '快递公司',
  `express_code` varchar(20) DEFAULT NULL COMMENT '快递公司代码',
  `express_number` varchar(32) DEFAULT NULL COMMENT '快递单号',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '当前状态:0 在途中、1 已揽收、2 疑难、3 已签收、4 退签、5 同城 派送中、6 退回、7 转单',
  `ischeck` int(11) DEFAULT '0' COMMENT '是否签收',
  `data` text COMMENT '状态详细',
  `type` tinyint(1) unsigned DEFAULT '0' COMMENT '0物流公司 1其他物流 2无需物流',
  `remark` text COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单跟踪';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%payment`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%payment` (
  `code` char(30) NOT NULL DEFAULT '',
  `name` varchar(80) DEFAULT '',
  `config` text,
  `content` text,
  `status` tinyint(1) DEFAULT '1',
  `type` varchar(100) DEFAULT NULL,
  `sort` int(11) DEFAULT '100' COMMENT '排序'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `%DB_PREFIX%payment`
--

INSERT INTO `%DB_PREFIX%payment` (`code`, `name`, `config`, `content`, `status`, `type`, `sort`) VALUES
('alipay', '支付宝', '{"sellerId":"","partnerId":"","partnerKey":"","partnerPubKey":"","partnerPrivKey":"","id":""}', '程序使用即时到账交易接口，申请地址：http://bizpartner.alipay.com/shopex/index.htm', 1, ',app,', 100),
('weixin', '微信支付', '{"originalId":"","partnerId":"","appId":"","appSecret":"","partnerKey":"","id":""}', NULL, 1, ',app,', 100),
('weixinJs', '微信支付', '{"originalId":"","partnerId":"","appId":"","appSecret":"","partnerKey":"","id":""}', NULL, 1, ',wxweb,', 100),
('alipayWap', '支付宝', '{"sellerId":"","partnerId":"","partnerKey":"","partnerPubKey":"","partnerPrivKey":"","id":""}', '程序使用即时到账交易接口，申请地址：http://bizpartner.alipay.com/shopex/index.htm', 1, ',web,', 100),
('cashOnDelivery', '货到付款', 'null', NULL, 0, ',app,wxweb,webpc,web,', 100),
('weixinSeller', '微信商家', '{"originalId":"","partnerId":"","appId":"","appSecret":"","partnerKey":"","id":""}', '', 1, ',seller,', 100),
('balancePay', '余额支付', 'null', NULL, 1, ',app,web,', 1),
('unionpay', '银联支付', '{"merId":"","id":""}', '', 1, ',web,', 100),
('unionapp', '银联支付', '{"merId":"","id":""}', '', 1, ',app,', 100);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%pay_item`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%pay_item` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT '0' COMMENT '物业公司编号',
  `name` varchar(30) DEFAULT NULL COMMENT '收费名称',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '单价（元）',
  `charging_item` tinyint(1) DEFAULT '0' COMMENT '计费方式',
  `charging_unit` tinyint(1) DEFAULT '0' COMMENT '计费单位'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%promotion`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%promotion` (
  `id` int(11) NOT NULL,
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `name_match` text COMMENT '名称全文索引',
  `money` double(10,1) DEFAULT '0.0' COMMENT '金额',
  `type` smallint(1) DEFAULT '1' COMMENT '有效期类型 1:固定有效期 2:发放之日起算',
  `begin_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  `expire_day` int(11) DEFAULT '0' COMMENT '过期天数',
  `use_type` smallint(1) DEFAULT '1' COMMENT '使用条件类型 1:无限制 2:指定分类 3:指定商家',
  `seller_id` int(11) DEFAULT '0' COMMENT '关联商家编号',
  `limit_money` double(10,2) DEFAULT '0.00' COMMENT '消费满减',
  `brief` text COMMENT '描述',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `status` smallint(1) DEFAULT '1' COMMENT '状态',
  `sort` smallint(5) DEFAULT '100' COMMENT '排序',
  `is_store` tinyint(1) DEFAULT '0' COMMENT '优惠券是否是全国店和周边店'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%promotion_seller_cate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%promotion_seller_cate` (
  `promotion_id` int(11) DEFAULT '0' COMMENT '优惠券编号',
  `seller_cate_id` int(11) DEFAULT '0' COMMENT '商家分类编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='优惠券指定分类';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%promotion_sn`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%promotion_sn` (
  `id` int(11) NOT NULL,
  `sn` varchar(20) NOT NULL COMMENT '兑换码',
  `user_id` int(11) DEFAULT '0' COMMENT '用户编号',
  `promotion_id` int(11) DEFAULT '0' COMMENT '优惠券编号',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `send_time` int(11) DEFAULT '0' COMMENT '发放/兑换时间',
  `use_time` int(11) DEFAULT '0' COMMENT '使用时间',
  `begin_time` int(11) DEFAULT '0' COMMENT '开始时间',
  `expire_time` int(11) DEFAULT '0' COMMENT '过期时间',
  `activity_id` int(11) DEFAULT '0' COMMENT '活动编号',
  `is_del` smallint(1) DEFAULT '0' COMMENT '是否已删除',
  `money` double(10,1) DEFAULT '0.0' COMMENT '金额',
  `is_send_msg` tinyint(2) DEFAULT '0' COMMENT '是否发送优惠券0未发,1发送一次,2发送二次',
  `is_check` tinyint(1) DEFAULT '0' COMMENT '是否查看',
  `check_day` int(11) NOT NULL DEFAULT '0' COMMENT '查看时间天'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%promotion_unable_date`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%promotion_unable_date` (
  `promotion_id` int(11) DEFAULT '0' COMMENT '优惠券编号',
  `date_time` int(11) DEFAULT '0' COMMENT '不可用日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='优惠券不可用日期';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_bind_deivce`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_bind_deivce` (
  `id` int(11) NOT NULL,
  `device_id` varchar(500) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `mobile` char(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '1绑定 0未绑定',
  `ticket` char(225) DEFAULT NULL,
  `openid` char(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='绑定';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_building`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_building` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业编号',
  `district_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区编号',
  `remark` text COMMENT '备注',
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物业楼宇';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_fee`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_fee` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业公司编号',
  `district_id` int(11) DEFAULT '0' COMMENT '小区编号',
  `build_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼栋编号',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间编号',
  `roomfee_id` int(11) DEFAULT '0' COMMENT '收费项目编号',
  `puser_id` int(11) DEFAULT '0' COMMENT '物业的业主编号',
  `fee` decimal(10,2) DEFAULT '0.00' COMMENT '缴费金额',
  `begin_time` int(11) DEFAULT '0' COMMENT '缴费开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '缴费结束时间',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `create_month` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '支付状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物业费';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_order`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_order` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT '订单号',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `puser_id` int(11) DEFAULT '0' COMMENT '会员小区物业信息',
  `district_id` int(11) DEFAULT '0' COMMENT '小区编号',
  `pay_fee` double(10,2) DEFAULT '0.00' COMMENT '支付金额',
  `pay_money` double(10,2) DEFAULT '0.00' COMMENT '已支付金额',
  `pay_type` char(30) DEFAULT '' COMMENT '支付方式''offline''线下支付，''alipay''支付宝，''wxpay''微信支付',
  `pay_status` tinyint(1) DEFAULT '0' COMMENT '支付状态',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `create_time` int(11) DEFAULT '0' COMMENT '创建订单时间',
  `first_level` int(11) DEFAULT NULL COMMENT '一级代理',
  `second_level` int(11) DEFAULT NULL COMMENT '二级代理',
  `third_level` int(11) DEFAULT NULL COMMENT '三级代理'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物业订单';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_order_item`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_order_item` (
  `id` int(10) NOT NULL COMMENT '订单商品ID',
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '商家编号',
  `order_id` int(10) NOT NULL COMMENT '订单ID',
  `propertyfee_id` int(10) NOT NULL COMMENT '商品ID',
  `price` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `num` int(11) NOT NULL COMMENT '数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物业订单商品表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_room`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_room` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业编号',
  `district_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区编号',
  `room_num` varchar(20) DEFAULT NULL COMMENT '房间号',
  `owner` varchar(200) DEFAULT NULL COMMENT '业主',
  `mobile` char(12) DEFAULT NULL,
  `property_fee` double(10,2) DEFAULT NULL COMMENT '物业费',
  `room_area` double(10,2) DEFAULT NULL COMMENT '套内面积（平方米）',
  `structure_area` double(10,2) DEFAULT NULL COMMENT '建筑面积（平方米）',
  `intake_time` int(11) DEFAULT NULL COMMENT '入住时间',
  `remark` text,
  `build_id` int(11) DEFAULT NULL COMMENT '楼栋号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物业房间';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%property_user`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%property_user` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT '0',
  `build_id` int(11) DEFAULT '0' COMMENT '楼宇编号',
  `room_id` int(11) DEFAULT '0',
  `district_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `mobile` char(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '身份认证状态0待审核1通过-1拒绝',
  `access_status` tinyint(1) DEFAULT '0' COMMENT '门禁申请状态0 1通过， -1 拒绝',
  `content` text COMMENT '审核原因',
  `create_time` int(11) DEFAULT NULL COMMENT '申请时间',
  `show_status` tinyint(1) DEFAULT '1' COMMENT '显示状态1显示0隐藏',
  `is_default` tinyint(1) DEFAULT '0',
  `shakeswitch` tinyint(1) DEFAULT '1' COMMENT '是否开启摇一摇开门'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业主';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%proxy`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%proxy` (
  `id` int(11) NOT NULL COMMENT '编号',
  `pid` int(11) DEFAULT '0' COMMENT '父代理，0表示一级代理',
  `level` tinyint(1) DEFAULT '1' COMMENT '代理级别',
  `name` varchar(20) DEFAULT NULL COMMENT '账户',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(20) NOT NULL COMMENT '联系电话',
  `crypt` char(6) DEFAULT NULL,
  `pwd` char(32) DEFAULT NULL COMMENT '密码',
  `province_id` int(11) DEFAULT '0' COMMENT '省份编号',
  `city_id` int(11) DEFAULT '0' COMMENT '城市编号',
  `area_id` int(11) DEFAULT '0' COMMENT '区域编号',
  `third_area` varchar(20) DEFAULT NULL COMMENT '三级代理区域',
  `login_time` int(11) DEFAULT NULL COMMENT '登录时间',
  `login_ip` varchar(30) DEFAULT NULL COMMENT '登录IP',
  `login_count` int(11) DEFAULT '0' COMMENT '登录次数',
  `create_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `error_login_times` int(11) DEFAULT '0' COMMENT '错误登录次数',
  `check_val` varchar(500) DEFAULT NULL COMMENT '审核原因',
  `is_check` tinyint(1) DEFAULT '0' COMMENT '审核状态0待审核1通过-1拒绝',
  `status` int(11) DEFAULT '1' COMMENT ' 状态-0关闭/1开启'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%puser_door`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%puser_door` (
  `id` int(11) NOT NULL,
  `puser_id` int(11) NOT NULL,
  `door_id` int(11) DEFAULT NULL,
  `app_key` varchar(50) DEFAULT NULL COMMENT '服务端认证key',
  `community` varchar(50) DEFAULT NULL COMMENT '小区安装标识',
  `lock_id` text COMMENT ' 钥匙凭证数据',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `end_time` int(11) DEFAULT NULL COMMENT '门禁截止日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业主门禁关联表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%push_message`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%push_message` (
  `id` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '类型',
  `title` varchar(60) DEFAULT '' COMMENT '标题',
  `content` text COMMENT '内容',
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '要推送的会员类型',
  `users` text COMMENT '要推送的会员手机号',
  `args` varchar(255) DEFAULT '' COMMENT '推送参数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推送时间',
  `send_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:普通消息 2:html页面 args为url 3:订单消息 args为订单ID4，5新优惠券提示，6团队消息',
  `create_type` int(11) DEFAULT '1' COMMENT '1:平台，2:商家',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `status` int(10) unsigned DEFAULT '0' COMMENT '状态',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT '订单'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%read_message`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%read_message` (
  `id` int(11) unsigned NOT NULL,
  `message_id` int(11) NOT NULL DEFAULT '0' COMMENT '消息编号',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '买家编号',
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '卖家编号',
  `staff_id` int(11) NOT NULL DEFAULT '0' COMMENT '员工编号',
  `read_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '阅读时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%refund`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%refund` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `order_id` int(11) DEFAULT '0' COMMENT '订单编号',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '原付款流水号',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `payment_type` char(20) DEFAULT '' COMMENT '支付方式',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%region`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%region` (
  `id` mediumint(8) NOT NULL,
  `pid` mediumint(8) DEFAULT '0',
  `no` varchar(20) DEFAULT NULL,
  `name` varchar(60) CHARACTER SET gbk DEFAULT '',
  `level` tinyint(2) unsigned DEFAULT '0',
  `code` varchar(10) DEFAULT '',
  `type` varchar(10) DEFAULT '',
  `sort` smallint(6) DEFAULT '100',
  `py` varchar(255) DEFAULT '',
  `matchs` varchar(500) DEFAULT '',
  `is_default` tinyint(1) DEFAULT '0',
  `is_service` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=3339 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `%DB_PREFIX%region`
--

INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(1, 0, '110000', '北京市', 1, '010', '省', 100, 'bei jing shi', 'ux98 ux101 ux105 ux106 ux110 ux103 ux115 ux104 ux21271 ux20140 ux24066', 0, 0),
(2, 1, '110101', '东城区', 2, '010', '区', 100, 'dong cheng qu', 'ux100 ux111 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux19996 ux22478 ux21306', 0, 0),
(3, 1, '110102', '西城区', 2, '010', '区', 100, 'xi cheng qu', 'ux120 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux35199 ux22478 ux21306', 0, 0),
(4, 1, '110105', '朝阳区', 2, '010', '区', 100, 'zhao yang qu', 'ux122 ux104 ux97 ux111 ux121 ux110 ux103 ux113 ux117 ux26397 ux38451 ux21306', 0, 0),
(5, 1, '110106', '丰台区', 2, '010', '区', 100, 'feng tai qu', 'ux102 ux101 ux110 ux103 ux116 ux97 ux105 ux113 ux117 ux20016 ux21488 ux21306', 0, 0),
(6, 1, '110107', '石景山区', 2, '010', '区', 100, 'shi jing shan qu', 'ux115 ux104 ux105 ux106 ux110 ux103 ux97 ux113 ux117 ux30707 ux26223 ux23665 ux21306', 0, 0),
(7, 1, '110108', '海淀区', 2, '010', '区', 100, 'hai dian qu', 'ux104 ux97 ux105 ux100 ux110 ux113 ux117 ux28023 ux28096 ux21306', 0, 0),
(8, 1, '110109', '门头沟区', 2, '010', '区', 100, 'men tou gou qu', 'ux109 ux101 ux110 ux116 ux111 ux117 ux103 ux113 ux38376 ux22836 ux27807 ux21306', 0, 0),
(9, 1, '110111', '房山区', 2, '010', '区', 100, 'fang shan qu', 'ux102 ux97 ux110 ux103 ux115 ux104 ux113 ux117 ux25151 ux23665 ux21306', 0, 0),
(10, 1, '110112', '通州区', 2, '010', '区', 100, 'tong zhou qu', 'ux116 ux111 ux110 ux103 ux122 ux104 ux117 ux113 ux36890 ux24030 ux21306', 0, 0),
(11, 1, '110113', '顺义区', 2, '010', '区', 100, 'shun yi qu', 'ux115 ux104 ux117 ux110 ux121 ux105 ux113 ux39034 ux20041 ux21306', 0, 0),
(12, 1, '110114', '昌平区', 2, '010', '区', 100, 'chang ping qu', 'ux99 ux104 ux97 ux110 ux103 ux112 ux105 ux113 ux117 ux26124 ux24179 ux21306', 0, 0),
(13, 1, '110115', '大兴区', 2, '010', '区', 100, 'da xing qu', 'ux100 ux97 ux120 ux105 ux110 ux103 ux113 ux117 ux22823 ux20852 ux21306', 0, 0),
(14, 1, '110116', '怀柔区', 2, '010', '区', 100, 'huai rou qu', 'ux104 ux117 ux97 ux105 ux114 ux111 ux113 ux24576 ux26580 ux21306', 0, 0),
(15, 1, '110117', '平谷区', 2, '010', '区', 100, 'ping gu qu', 'ux112 ux105 ux110 ux103 ux117 ux113 ux24179 ux35895 ux21306', 0, 0),
(16, 1, '110228', '密云县', 2, '010', '区', 100, 'mi yun xian', 'ux109 ux105 ux121 ux117 ux110 ux120 ux97 ux23494 ux20113 ux21439', 0, 0),
(17, 1, '110229', '延庆县', 2, '010', '区', 100, 'yan qing xian', 'ux121 ux97 ux110 ux113 ux105 ux103 ux120 ux24310 ux24198 ux21439', 0, 0),
(18, 0, '120000', '天津市', 1, '022', '市', 100, 'tian jin shi', 'ux116 ux105 ux97 ux110 ux106 ux115 ux104 ux22825 ux27941 ux24066', 0, 0),
(19, 18, '120101', '和平区', 2, '022', '区', 100, 'he ping qu', 'ux104 ux101 ux112 ux105 ux110 ux103 ux113 ux117 ux21644 ux24179 ux21306', 0, 0),
(20, 18, '120102', '河东区', 2, '022', '区', 100, 'he dong qu', 'ux104 ux101 ux100 ux111 ux110 ux103 ux113 ux117 ux27827 ux19996 ux21306', 0, 0),
(21, 18, '120103', '河西区', 2, '022', '区', 100, 'he xi qu', 'ux104 ux101 ux120 ux105 ux113 ux117 ux27827 ux35199 ux21306', 0, 0),
(22, 18, '120104', '南开区', 2, '022', '区', 100, 'nan kai qu', 'ux110 ux97 ux107 ux105 ux113 ux117 ux21335 ux24320 ux21306', 0, 0),
(23, 18, '120105', '河北区', 2, '022', '区', 100, 'he bei qu', 'ux104 ux101 ux98 ux105 ux113 ux117 ux27827 ux21271 ux21306', 0, 0),
(24, 18, '120106', '红桥区', 2, '022', '区', 100, 'hong qiao qu', 'ux104 ux111 ux110 ux103 ux113 ux105 ux97 ux117 ux32418 ux26725 ux21306', 0, 0),
(25, 18, '120110', '东丽区', 2, '022', '区', 100, 'dong li qu', 'ux100 ux111 ux110 ux103 ux108 ux105 ux113 ux117 ux19996 ux20029 ux21306', 0, 0),
(26, 18, '120111', '西青区', 2, '022', '区', 100, 'xi qing qu', 'ux120 ux105 ux113 ux110 ux103 ux117 ux35199 ux38738 ux21306', 0, 0),
(27, 18, '120112', '津南区', 2, '022', '区', 100, 'jin nan qu', 'ux106 ux105 ux110 ux97 ux113 ux117 ux27941 ux21335 ux21306', 0, 0),
(28, 18, '120113', '北辰区', 2, '022', '区', 100, 'bei chen qu', 'ux98 ux101 ux105 ux99 ux104 ux110 ux113 ux117 ux21271 ux36784 ux21306', 0, 0),
(29, 18, '120114', '武清区', 2, '022', '区', 100, 'wu qing qu', 'ux119 ux117 ux113 ux105 ux110 ux103 ux27494 ux28165 ux21306', 0, 0),
(30, 18, '120115', '宝坻区', 2, '022', '区', 100, 'bao di qu', 'ux98 ux97 ux111 ux100 ux105 ux113 ux117 ux23453 ux22395 ux21306', 0, 0),
(31, 18, '120116', '滨海新区', 2, '022', '区', 100, 'bin hai xin qu', 'ux98 ux105 ux110 ux104 ux97 ux120 ux113 ux117 ux28392 ux28023 ux26032 ux21306', 0, 0),
(32, 18, '120221', '宁河县', 2, '022', '区', 100, 'ning he xian', 'ux110 ux105 ux103 ux104 ux101 ux120 ux97 ux23425 ux27827 ux21439', 0, 0),
(33, 18, '120223', '静海县', 2, '022', '区', 100, 'jing hai xian', 'ux106 ux105 ux110 ux103 ux104 ux97 ux120 ux38745 ux28023 ux21439', 0, 0),
(34, 18, '120225', '蓟县', 2, '022', '区', 100, 'ji xian', 'ux106 ux105 ux120 ux97 ux110 ux34015 ux21439', 0, 0),
(35, 0, '130000', '河北省', 1, '', '省', 100, 'he bei sheng', 'ux104 ux101 ux98 ux105 ux115 ux110 ux103 ux27827 ux21271 ux30465', 0, 0),
(36, 35, '130100', '石家庄市', 2, '0311', '市', 100, 'shi jia zhuang shi', 'ux115 ux104 ux105 ux106 ux97 ux122 ux117 ux110 ux103 ux30707 ux23478 ux24196 ux24066', 0, 0),
(37, 36, '130102', '长安区', 3, '0311', '区', 100, 'chang an qu', 'ux99 ux104 ux97 ux110 ux103 ux113 ux117 ux38271 ux23433 ux21306', 0, 0),
(38, 36, '130103', '桥东区', 3, '0311', '区', 100, 'qiao dong qu', 'ux113 ux105 ux97 ux111 ux100 ux110 ux103 ux117 ux26725 ux19996 ux21306', 0, 0),
(39, 36, '130104', '桥西区', 3, '0311', '区', 100, 'qiao xi qu', 'ux113 ux105 ux97 ux111 ux120 ux117 ux26725 ux35199 ux21306', 0, 0),
(40, 36, '130105', '新华区', 3, '0311', '区', 100, 'xin hua qu', 'ux120 ux105 ux110 ux104 ux117 ux97 ux113 ux26032 ux21326 ux21306', 0, 0),
(41, 36, '130107', '井陉矿区', 3, '0311', '区', 100, 'jing xing kuang qu', 'ux106 ux105 ux110 ux103 ux120 ux107 ux117 ux97 ux113 ux20117 ux38473 ux30719 ux21306', 0, 0),
(42, 36, '130108', '裕华区', 3, '0311', '区', 100, 'yu hua qu', 'ux121 ux117 ux104 ux97 ux113 ux35029 ux21326 ux21306', 0, 0),
(43, 36, '130121', '井陉县', 3, '0311', '区', 100, 'jing xing xian', 'ux106 ux105 ux110 ux103 ux120 ux97 ux20117 ux38473 ux21439', 0, 0),
(44, 36, '130123', '正定县', 3, '0311', '区', 100, 'zheng ding xian', 'ux122 ux104 ux101 ux110 ux103 ux100 ux105 ux120 ux97 ux27491 ux23450 ux21439', 0, 0),
(45, 36, '130124', '栾城县', 3, '0311', '区', 100, 'luan cheng xian', 'ux108 ux117 ux97 ux110 ux99 ux104 ux101 ux103 ux120 ux105 ux26686 ux22478 ux21439', 0, 0),
(46, 36, '130125', '行唐县', 3, '0311', '区', 100, 'xing tang xian', 'ux120 ux105 ux110 ux103 ux116 ux97 ux34892 ux21776 ux21439', 0, 0),
(47, 36, '130126', '灵寿县', 3, '0311', '区', 100, 'ling shou xian', 'ux108 ux105 ux110 ux103 ux115 ux104 ux111 ux117 ux120 ux97 ux28789 ux23551 ux21439', 0, 0),
(48, 36, '130127', '高邑县', 3, '0311', '区', 100, 'gao yi xian', 'ux103 ux97 ux111 ux121 ux105 ux120 ux110 ux39640 ux37009 ux21439', 0, 0),
(49, 36, '130128', '深泽县', 3, '0311', '区', 100, 'shen ze xian', 'ux115 ux104 ux101 ux110 ux122 ux120 ux105 ux97 ux28145 ux27901 ux21439', 0, 0),
(50, 36, '130129', '赞皇县', 3, '0311', '区', 100, 'zan huang xian', 'ux122 ux97 ux110 ux104 ux117 ux103 ux120 ux105 ux36190 ux30343 ux21439', 0, 0),
(51, 36, '130130', '无极县', 3, '0311', '区', 100, 'wu ji xian', 'ux119 ux117 ux106 ux105 ux120 ux97 ux110 ux26080 ux26497 ux21439', 0, 0),
(52, 36, '130131', '平山县', 3, '0311', '区', 100, 'ping shan xian', 'ux112 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux24179 ux23665 ux21439', 0, 0),
(53, 36, '130132', '元氏县', 3, '0311', '区', 100, 'yuan shi xian', 'ux121 ux117 ux97 ux110 ux115 ux104 ux105 ux120 ux20803 ux27663 ux21439', 0, 0),
(54, 36, '130133', '赵县', 3, '0311', '区', 100, 'zhao xian', 'ux122 ux104 ux97 ux111 ux120 ux105 ux110 ux36213 ux21439', 0, 0),
(55, 36, '130181', '辛集市', 3, '0311', '区', 100, 'xin ji shi', 'ux120 ux105 ux110 ux106 ux115 ux104 ux36763 ux38598 ux24066', 0, 0),
(56, 36, '130182', '藁城市', 3, '0311', '区', 100, 'gao cheng shi', 'ux103 ux97 ux111 ux99 ux104 ux101 ux110 ux115 ux105 ux34241 ux22478 ux24066', 0, 0),
(57, 36, '130183', '晋州市', 3, '0311', '区', 100, 'jin zhou shi', 'ux106 ux105 ux110 ux122 ux104 ux111 ux117 ux115 ux26187 ux24030 ux24066', 0, 0),
(58, 36, '130184', '新乐市', 3, '0311', '区', 100, 'xin le shi', 'ux120 ux105 ux110 ux108 ux101 ux115 ux104 ux26032 ux20048 ux24066', 0, 0),
(59, 36, '130185', '鹿泉市', 3, '0311', '区', 100, 'lu quan shi', 'ux108 ux117 ux113 ux97 ux110 ux115 ux104 ux105 ux40575 ux27849 ux24066', 0, 0),
(60, 35, '130200', '唐山市', 2, '0315', '市', 100, 'tang shan shi', 'ux116 ux97 ux110 ux103 ux115 ux104 ux105 ux21776 ux23665 ux24066', 0, 0),
(61, 60, '130202', '路南区', 3, '0315', '区', 100, 'lu nan qu', 'ux108 ux117 ux110 ux97 ux113 ux36335 ux21335 ux21306', 0, 0),
(62, 60, '130203', '路北区', 3, '0315', '区', 100, 'lu bei qu', 'ux108 ux117 ux98 ux101 ux105 ux113 ux36335 ux21271 ux21306', 0, 0),
(63, 60, '130204', '古冶区', 3, '0315', '区', 100, 'gu ye qu', 'ux103 ux117 ux121 ux101 ux113 ux21476 ux20918 ux21306', 0, 0),
(64, 60, '130205', '开平区', 3, '0315', '区', 100, 'kai ping qu', 'ux107 ux97 ux105 ux112 ux110 ux103 ux113 ux117 ux24320 ux24179 ux21306', 0, 0),
(65, 60, '130207', '丰南区', 3, '0315', '区', 100, 'feng nan qu', 'ux102 ux101 ux110 ux103 ux97 ux113 ux117 ux20016 ux21335 ux21306', 0, 0),
(66, 60, '130208', '丰润区', 3, '0315', '区', 100, 'feng run qu', 'ux102 ux101 ux110 ux103 ux114 ux117 ux113 ux20016 ux28070 ux21306', 0, 0),
(67, 60, '130223', '滦县', 3, '0315', '区', 100, 'luan xian', 'ux108 ux117 ux97 ux110 ux120 ux105 ux28390 ux21439', 0, 0),
(68, 60, '130224', '滦南县', 3, '0315', '区', 100, 'luan nan xian', 'ux108 ux117 ux97 ux110 ux120 ux105 ux28390 ux21335 ux21439', 0, 0),
(69, 60, '130225', '乐亭县', 3, '0315', '区', 100, 'le ting xian', 'ux108 ux101 ux116 ux105 ux110 ux103 ux120 ux97 ux20048 ux20141 ux21439', 0, 0),
(70, 60, '130227', '迁西县', 3, '0315', '区', 100, 'qian xi xian', 'ux113 ux105 ux97 ux110 ux120 ux36801 ux35199 ux21439', 0, 0),
(71, 60, '130229', '玉田县', 3, '0315', '区', 100, 'yu tian xian', 'ux121 ux117 ux116 ux105 ux97 ux110 ux120 ux29577 ux30000 ux21439', 0, 0),
(72, 60, '130230', '曹妃甸区', 3, '0315', '区', 100, 'cao fei dian qu', 'ux99 ux97 ux111 ux102 ux101 ux105 ux100 ux110 ux113 ux117 ux26361 ux22915 ux30008 ux21306', 0, 0),
(73, 60, '130281', '遵化市', 3, '0315', '区', 100, 'zun hua shi', 'ux122 ux117 ux110 ux104 ux97 ux115 ux105 ux36981 ux21270 ux24066', 0, 0),
(74, 60, '130283', '迁安市', 3, '0315', '区', 100, 'qian an shi', 'ux113 ux105 ux97 ux110 ux115 ux104 ux36801 ux23433 ux24066', 0, 0),
(75, 35, '130300', '秦皇岛市', 2, '0335', '市', 100, 'qin huang dao shi', 'ux113 ux105 ux110 ux104 ux117 ux97 ux103 ux100 ux111 ux115 ux31206 ux30343 ux23707 ux24066', 0, 0),
(76, 75, '130302', '海港区', 3, '0335', '区', 100, 'hai gang qu', 'ux104 ux97 ux105 ux103 ux110 ux113 ux117 ux28023 ux28207 ux21306', 0, 0),
(77, 75, '130303', '山海关区', 3, '0335', '区', 100, 'shan hai guan qu', 'ux115 ux104 ux97 ux110 ux105 ux103 ux117 ux113 ux23665 ux28023 ux20851 ux21306', 0, 0),
(78, 75, '130304', '北戴河区', 3, '0335', '区', 100, 'bei dai he qu', 'ux98 ux101 ux105 ux100 ux97 ux104 ux113 ux117 ux21271 ux25140 ux27827 ux21306', 0, 0),
(79, 75, '130321', '青龙满族自治县', 3, '0335', '区', 100, 'qing long man zu zi zhi xian', 'ux113 ux105 ux110 ux103 ux108 ux111 ux109 ux97 ux122 ux117 ux104 ux120 ux38738 ux40857 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(80, 75, '130322', '昌黎县', 3, '0335', '区', 100, 'chang li xian', 'ux99 ux104 ux97 ux110 ux103 ux108 ux105 ux120 ux26124 ux40654 ux21439', 0, 0),
(81, 75, '130323', '抚宁县', 3, '0335', '区', 100, 'fu ning xian', 'ux102 ux117 ux110 ux105 ux103 ux120 ux97 ux25242 ux23425 ux21439', 0, 0),
(82, 75, '130324', '卢龙县', 3, '0335', '区', 100, 'lu long xian', 'ux108 ux117 ux111 ux110 ux103 ux120 ux105 ux97 ux21346 ux40857 ux21439', 0, 0),
(83, 35, '130400', '邯郸市', 2, '0310', '市', 100, 'han dan shi', 'ux104 ux97 ux110 ux100 ux115 ux105 ux37039 ux37112 ux24066', 0, 0),
(84, 83, '130402', '邯山区', 3, '0310', '区', 100, 'han shan qu', 'ux104 ux97 ux110 ux115 ux113 ux117 ux37039 ux23665 ux21306', 0, 0),
(85, 83, '130403', '丛台区', 3, '0310', '区', 100, 'cong tai qu', 'ux99 ux111 ux110 ux103 ux116 ux97 ux105 ux113 ux117 ux19995 ux21488 ux21306', 0, 0),
(86, 83, '130404', '复兴区', 3, '0310', '区', 100, 'fu xing qu', 'ux102 ux117 ux120 ux105 ux110 ux103 ux113 ux22797 ux20852 ux21306', 0, 0),
(87, 83, '130406', '峰峰矿区', 3, '0310', '区', 100, 'feng feng kuang qu', 'ux102 ux101 ux110 ux103 ux107 ux117 ux97 ux113 ux23792 ux30719 ux21306', 0, 0),
(88, 83, '130421', '邯郸县', 3, '0310', '区', 100, 'han dan xian', 'ux104 ux97 ux110 ux100 ux120 ux105 ux37039 ux37112 ux21439', 0, 0),
(89, 83, '130423', '临漳县', 3, '0310', '区', 100, 'lin zhang xian', 'ux108 ux105 ux110 ux122 ux104 ux97 ux103 ux120 ux20020 ux28467 ux21439', 0, 0),
(90, 83, '130424', '成安县', 3, '0310', '区', 100, 'cheng an xian', 'ux99 ux104 ux101 ux110 ux103 ux97 ux120 ux105 ux25104 ux23433 ux21439', 0, 0),
(91, 83, '130425', '大名县', 3, '0310', '区', 100, 'da ming xian', 'ux100 ux97 ux109 ux105 ux110 ux103 ux120 ux22823 ux21517 ux21439', 0, 0),
(92, 83, '130426', '涉县', 3, '0310', '区', 100, 'she xian', 'ux115 ux104 ux101 ux120 ux105 ux97 ux110 ux28041 ux21439', 0, 0),
(93, 83, '130427', '磁县', 3, '0310', '区', 100, 'ci xian', 'ux99 ux105 ux120 ux97 ux110 ux30913 ux21439', 0, 0),
(94, 83, '130428', '肥乡县', 3, '0310', '区', 100, 'fei xiang xian', 'ux102 ux101 ux105 ux120 ux97 ux110 ux103 ux32933 ux20065 ux21439', 0, 0),
(95, 83, '130429', '永年县', 3, '0310', '区', 100, 'yong nian xian', 'ux121 ux111 ux110 ux103 ux105 ux97 ux120 ux27704 ux24180 ux21439', 0, 0),
(96, 83, '130430', '邱县', 3, '0310', '区', 100, 'qiu xian', 'ux113 ux105 ux117 ux120 ux97 ux110 ux37041 ux21439', 0, 0),
(97, 83, '130431', '鸡泽县', 3, '0310', '区', 100, 'ji ze xian', 'ux106 ux105 ux122 ux101 ux120 ux97 ux110 ux40481 ux27901 ux21439', 0, 0),
(98, 83, '130432', '广平县', 3, '0310', '区', 100, 'guang ping xian', 'ux103 ux117 ux97 ux110 ux112 ux105 ux120 ux24191 ux24179 ux21439', 0, 0),
(99, 83, '130433', '馆陶县', 3, '0310', '区', 100, 'guan tao xian', 'ux103 ux117 ux97 ux110 ux116 ux111 ux120 ux105 ux39302 ux38518 ux21439', 0, 0),
(100, 83, '130434', '魏县', 3, '0310', '区', 100, 'wei xian', 'ux119 ux101 ux105 ux120 ux97 ux110 ux39759 ux21439', 0, 0),
(101, 83, '130435', '曲周县', 3, '0310', '区', 100, 'qu zhou xian', 'ux113 ux117 ux122 ux104 ux111 ux120 ux105 ux97 ux110 ux26354 ux21608 ux21439', 0, 0),
(102, 83, '130481', '武安市', 3, '0310', '区', 100, 'wu an shi', 'ux119 ux117 ux97 ux110 ux115 ux104 ux105 ux27494 ux23433 ux24066', 0, 0),
(103, 35, '130500', '邢台市', 2, '0319', '市', 100, 'xing tai shi', 'ux120 ux105 ux110 ux103 ux116 ux97 ux115 ux104 ux37026 ux21488 ux24066', 0, 0),
(104, 103, '130502', '桥东区', 3, '0319', '区', 100, 'qiao dong qu', 'ux113 ux105 ux97 ux111 ux100 ux110 ux103 ux117 ux26725 ux19996 ux21306', 0, 0),
(105, 103, '130503', '桥西区', 3, '0319', '区', 100, 'qiao xi qu', 'ux113 ux105 ux97 ux111 ux120 ux117 ux26725 ux35199 ux21306', 0, 0),
(106, 103, '130521', '邢台县', 3, '0319', '区', 100, 'xing tai xian', 'ux120 ux105 ux110 ux103 ux116 ux97 ux37026 ux21488 ux21439', 0, 0),
(107, 103, '130522', '临城县', 3, '0319', '区', 100, 'lin cheng xian', 'ux108 ux105 ux110 ux99 ux104 ux101 ux103 ux120 ux97 ux20020 ux22478 ux21439', 0, 0),
(108, 103, '130523', '内丘县', 3, '0319', '区', 100, 'nei qiu xian', 'ux110 ux101 ux105 ux113 ux117 ux120 ux97 ux20869 ux19992 ux21439', 0, 0),
(109, 103, '130524', '柏乡县', 3, '0319', '区', 100, 'bai xiang xian', 'ux98 ux97 ux105 ux120 ux110 ux103 ux26575 ux20065 ux21439', 0, 0),
(110, 103, '130525', '隆尧县', 3, '0319', '区', 100, 'long yao xian', 'ux108 ux111 ux110 ux103 ux121 ux97 ux120 ux105 ux38534 ux23591 ux21439', 0, 0),
(111, 103, '130526', '任县', 3, '0319', '区', 100, 'ren xian', 'ux114 ux101 ux110 ux120 ux105 ux97 ux20219 ux21439', 0, 0),
(112, 103, '130527', '南和县', 3, '0319', '区', 100, 'nan he xian', 'ux110 ux97 ux104 ux101 ux120 ux105 ux21335 ux21644 ux21439', 0, 0),
(113, 103, '130528', '宁晋县', 3, '0319', '区', 100, 'ning jin xian', 'ux110 ux105 ux103 ux106 ux120 ux97 ux23425 ux26187 ux21439', 0, 0),
(114, 103, '130529', '巨鹿县', 3, '0319', '区', 100, 'ju lu xian', 'ux106 ux117 ux108 ux120 ux105 ux97 ux110 ux24040 ux40575 ux21439', 0, 0),
(115, 103, '130530', '新河县', 3, '0319', '区', 100, 'xin he xian', 'ux120 ux105 ux110 ux104 ux101 ux97 ux26032 ux27827 ux21439', 0, 0),
(116, 103, '130531', '广宗县', 3, '0319', '区', 100, 'guang zong xian', 'ux103 ux117 ux97 ux110 ux122 ux111 ux120 ux105 ux24191 ux23447 ux21439', 0, 0),
(117, 103, '130532', '平乡县', 3, '0319', '区', 100, 'ping xiang xian', 'ux112 ux105 ux110 ux103 ux120 ux97 ux24179 ux20065 ux21439', 0, 0),
(118, 103, '130533', '威县', 3, '0319', '区', 100, 'wei xian', 'ux119 ux101 ux105 ux120 ux97 ux110 ux23041 ux21439', 0, 0),
(119, 103, '130534', '清河县', 3, '0319', '区', 100, 'qing he xian', 'ux113 ux105 ux110 ux103 ux104 ux101 ux120 ux97 ux28165 ux27827 ux21439', 0, 0),
(120, 103, '130535', '临西县', 3, '0319', '区', 100, 'lin xi xian', 'ux108 ux105 ux110 ux120 ux97 ux20020 ux35199 ux21439', 0, 0),
(121, 103, '130581', '南宫市', 3, '0319', '区', 100, 'nan gong shi', 'ux110 ux97 ux103 ux111 ux115 ux104 ux105 ux21335 ux23467 ux24066', 0, 0),
(122, 103, '130582', '沙河市', 3, '0319', '区', 100, 'sha he shi', 'ux115 ux104 ux97 ux101 ux105 ux27801 ux27827 ux24066', 0, 0),
(123, 35, '130600', '保定市', 2, '0312', '市', 100, 'bao ding shi', 'ux98 ux97 ux111 ux100 ux105 ux110 ux103 ux115 ux104 ux20445 ux23450 ux24066', 0, 0),
(124, 123, '130602', '新市区', 3, '0312', '区', 100, 'xin shi qu', 'ux120 ux105 ux110 ux115 ux104 ux113 ux117 ux26032 ux24066 ux21306', 0, 0),
(125, 123, '130603', '北市区', 3, '0312', '区', 100, 'bei shi qu', 'ux98 ux101 ux105 ux115 ux104 ux113 ux117 ux21271 ux24066 ux21306', 0, 0),
(126, 123, '130604', '南市区', 3, '0312', '区', 100, 'nan shi qu', 'ux110 ux97 ux115 ux104 ux105 ux113 ux117 ux21335 ux24066 ux21306', 0, 0),
(127, 123, '130621', '满城县', 3, '0312', '区', 100, 'man cheng xian', 'ux109 ux97 ux110 ux99 ux104 ux101 ux103 ux120 ux105 ux28385 ux22478 ux21439', 0, 0),
(128, 123, '130622', '清苑县', 3, '0312', '区', 100, 'qing yuan xian', 'ux113 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux28165 ux33489 ux21439', 0, 0),
(129, 123, '130623', '涞水县', 3, '0312', '区', 100, 'lai shui xian', 'ux108 ux97 ux105 ux115 ux104 ux117 ux120 ux110 ux28062 ux27700 ux21439', 0, 0),
(130, 123, '130624', '阜平县', 3, '0312', '区', 100, 'fu ping xian', 'ux102 ux117 ux112 ux105 ux110 ux103 ux120 ux97 ux38428 ux24179 ux21439', 0, 0),
(131, 123, '130625', '徐水县', 3, '0312', '区', 100, 'xu shui xian', 'ux120 ux117 ux115 ux104 ux105 ux97 ux110 ux24464 ux27700 ux21439', 0, 0),
(132, 123, '130626', '定兴县', 3, '0312', '区', 100, 'ding xing xian', 'ux100 ux105 ux110 ux103 ux120 ux97 ux23450 ux20852 ux21439', 0, 0),
(133, 123, '130627', '唐县', 3, '0312', '区', 100, 'tang xian', 'ux116 ux97 ux110 ux103 ux120 ux105 ux21776 ux21439', 0, 0),
(134, 123, '130628', '高阳县', 3, '0312', '区', 100, 'gao yang xian', 'ux103 ux97 ux111 ux121 ux110 ux120 ux105 ux39640 ux38451 ux21439', 0, 0),
(135, 123, '130629', '容城县', 3, '0312', '区', 100, 'rong cheng xian', 'ux114 ux111 ux110 ux103 ux99 ux104 ux101 ux120 ux105 ux97 ux23481 ux22478 ux21439', 0, 0),
(136, 123, '130630', '涞源县', 3, '0312', '区', 100, 'lai yuan xian', 'ux108 ux97 ux105 ux121 ux117 ux110 ux120 ux28062 ux28304 ux21439', 0, 0),
(137, 123, '130631', '望都县', 3, '0312', '区', 100, 'wang du xian', 'ux119 ux97 ux110 ux103 ux100 ux117 ux120 ux105 ux26395 ux37117 ux21439', 0, 0),
(138, 123, '130632', '安新县', 3, '0312', '区', 100, 'an xin xian', 'ux97 ux110 ux120 ux105 ux23433 ux26032 ux21439', 0, 0),
(139, 123, '130633', '易县', 3, '0312', '区', 100, 'yi xian', 'ux121 ux105 ux120 ux97 ux110 ux26131 ux21439', 0, 0),
(140, 123, '130634', '曲阳县', 3, '0312', '区', 100, 'qu yang xian', 'ux113 ux117 ux121 ux97 ux110 ux103 ux120 ux105 ux26354 ux38451 ux21439', 0, 0),
(141, 123, '130635', '蠡县', 3, '0312', '区', 100, 'li xian', 'ux108 ux105 ux120 ux97 ux110 ux34849 ux21439', 0, 0),
(142, 123, '130636', '顺平县', 3, '0312', '区', 100, 'shun ping xian', 'ux115 ux104 ux117 ux110 ux112 ux105 ux103 ux120 ux97 ux39034 ux24179 ux21439', 0, 0),
(143, 123, '130637', '博野县', 3, '0312', '区', 100, 'bo ye xian', 'ux98 ux111 ux121 ux101 ux120 ux105 ux97 ux110 ux21338 ux37326 ux21439', 0, 0),
(144, 123, '130638', '雄县', 3, '0312', '区', 100, 'xiong xian', 'ux120 ux105 ux111 ux110 ux103 ux97 ux38596 ux21439', 0, 0),
(145, 123, '130681', '涿州市', 3, '0312', '区', 100, 'zhuo zhou shi', 'ux122 ux104 ux117 ux111 ux115 ux105 ux28095 ux24030 ux24066', 0, 0),
(146, 123, '130682', '定州市', 3, '0312', '区', 100, 'ding zhou shi', 'ux100 ux105 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux23450 ux24030 ux24066', 0, 0),
(147, 123, '130683', '安国市', 3, '0312', '区', 100, 'an guo shi', 'ux97 ux110 ux103 ux117 ux111 ux115 ux104 ux105 ux23433 ux22269 ux24066', 0, 0),
(148, 123, '130684', '高碑店市', 3, '0312', '区', 100, 'gao bei dian shi', 'ux103 ux97 ux111 ux98 ux101 ux105 ux100 ux110 ux115 ux104 ux39640 ux30865 ux24215 ux24066', 0, 0),
(149, 35, '130700', '张家口市', 2, '0313', '市', 100, 'zhang jia kou shi', 'ux122 ux104 ux97 ux110 ux103 ux106 ux105 ux107 ux111 ux117 ux115 ux24352 ux23478 ux21475 ux24066', 0, 0),
(150, 149, '130702', '桥东区', 3, '0313', '区', 100, 'qiao dong qu', 'ux113 ux105 ux97 ux111 ux100 ux110 ux103 ux117 ux26725 ux19996 ux21306', 0, 0),
(151, 149, '130703', '桥西区', 3, '0313', '区', 100, 'qiao xi qu', 'ux113 ux105 ux97 ux111 ux120 ux117 ux26725 ux35199 ux21306', 0, 0),
(152, 149, '130705', '宣化区', 3, '0313', '区', 100, 'xuan hua qu', 'ux120 ux117 ux97 ux110 ux104 ux113 ux23459 ux21270 ux21306', 0, 0),
(153, 149, '130706', '下花园区', 3, '0313', '区', 100, 'xia hua yuan qu', 'ux120 ux105 ux97 ux104 ux117 ux121 ux110 ux113 ux19979 ux33457 ux22253 ux21306', 0, 0),
(154, 149, '130721', '宣化县', 3, '0313', '区', 100, 'xuan hua xian', 'ux120 ux117 ux97 ux110 ux104 ux105 ux23459 ux21270 ux21439', 0, 0),
(155, 149, '130722', '张北县', 3, '0313', '区', 100, 'zhang bei xian', 'ux122 ux104 ux97 ux110 ux103 ux98 ux101 ux105 ux120 ux24352 ux21271 ux21439', 0, 0),
(156, 149, '130723', '康保县', 3, '0313', '区', 100, 'kang bao xian', 'ux107 ux97 ux110 ux103 ux98 ux111 ux120 ux105 ux24247 ux20445 ux21439', 0, 0),
(157, 149, '130724', '沽源县', 3, '0313', '区', 100, 'gu yuan xian', 'ux103 ux117 ux121 ux97 ux110 ux120 ux105 ux27837 ux28304 ux21439', 0, 0),
(158, 149, '130725', '尚义县', 3, '0313', '区', 100, 'shang yi xian', 'ux115 ux104 ux97 ux110 ux103 ux121 ux105 ux120 ux23578 ux20041 ux21439', 0, 0),
(159, 149, '130726', '蔚县', 3, '0313', '区', 100, 'wei xian', 'ux119 ux101 ux105 ux120 ux97 ux110 ux34074 ux21439', 0, 0),
(160, 149, '130727', '阳原县', 3, '0313', '区', 100, 'yang yuan xian', 'ux121 ux97 ux110 ux103 ux117 ux120 ux105 ux38451 ux21407 ux21439', 0, 0),
(161, 149, '130728', '怀安县', 3, '0313', '区', 100, 'huai an xian', 'ux104 ux117 ux97 ux105 ux110 ux120 ux24576 ux23433 ux21439', 0, 0),
(162, 149, '130729', '万全县', 3, '0313', '区', 100, 'wan quan xian', 'ux119 ux97 ux110 ux113 ux117 ux120 ux105 ux19975 ux20840 ux21439', 0, 0),
(163, 149, '130730', '怀来县', 3, '0313', '区', 100, 'huai lai xian', 'ux104 ux117 ux97 ux105 ux108 ux120 ux110 ux24576 ux26469 ux21439', 0, 0),
(164, 149, '130731', '涿鹿县', 3, '0313', '区', 100, 'zhuo lu xian', 'ux122 ux104 ux117 ux111 ux108 ux120 ux105 ux97 ux110 ux28095 ux40575 ux21439', 0, 0),
(165, 149, '130732', '赤城县', 3, '0313', '区', 100, 'chi cheng xian', 'ux99 ux104 ux105 ux101 ux110 ux103 ux120 ux97 ux36196 ux22478 ux21439', 0, 0),
(166, 149, '130733', '崇礼县', 3, '0313', '区', 100, 'chong li xian', 'ux99 ux104 ux111 ux110 ux103 ux108 ux105 ux120 ux97 ux23815 ux31036 ux21439', 0, 0),
(167, 35, '130800', '承德市', 2, '0314', '市', 100, 'cheng de shi', 'ux99 ux104 ux101 ux110 ux103 ux100 ux115 ux105 ux25215 ux24503 ux24066', 0, 0),
(168, 167, '130802', '双桥区', 3, '0314', '区', 100, 'shuang qiao qu', 'ux115 ux104 ux117 ux97 ux110 ux103 ux113 ux105 ux111 ux21452 ux26725 ux21306', 0, 0),
(169, 167, '130803', '双滦区', 3, '0314', '区', 100, 'shuang luan qu', 'ux115 ux104 ux117 ux97 ux110 ux103 ux108 ux113 ux21452 ux28390 ux21306', 0, 0),
(170, 167, '130804', '鹰手营子矿区', 3, '0314', '区', 100, 'ying shou ying zi kuang qu', 'ux121 ux105 ux110 ux103 ux115 ux104 ux111 ux117 ux122 ux107 ux97 ux113 ux40560 ux25163 ux33829 ux23376 ux30719 ux21306', 0, 0),
(171, 167, '130821', '承德县', 3, '0314', '区', 100, 'cheng de xian', 'ux99 ux104 ux101 ux110 ux103 ux100 ux120 ux105 ux97 ux25215 ux24503 ux21439', 0, 0),
(172, 167, '130822', '兴隆县', 3, '0314', '区', 100, 'xing long xian', 'ux120 ux105 ux110 ux103 ux108 ux111 ux97 ux20852 ux38534 ux21439', 0, 0),
(173, 167, '130823', '平泉县', 3, '0314', '区', 100, 'ping quan xian', 'ux112 ux105 ux110 ux103 ux113 ux117 ux97 ux120 ux24179 ux27849 ux21439', 0, 0),
(174, 167, '130824', '滦平县', 3, '0314', '区', 100, 'luan ping xian', 'ux108 ux117 ux97 ux110 ux112 ux105 ux103 ux120 ux28390 ux24179 ux21439', 0, 0),
(175, 167, '130825', '隆化县', 3, '0314', '区', 100, 'long hua xian', 'ux108 ux111 ux110 ux103 ux104 ux117 ux97 ux120 ux105 ux38534 ux21270 ux21439', 0, 0),
(176, 167, '130826', '丰宁满族自治县', 3, '0314', '区', 100, 'feng ning man zu zi zhi xian', 'ux102 ux101 ux110 ux103 ux105 ux109 ux97 ux122 ux117 ux104 ux120 ux20016 ux23425 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(177, 167, '130827', '宽城满族自治县', 3, '0314', '区', 100, 'kuan cheng man zu zi zhi xian', 'ux107 ux117 ux97 ux110 ux99 ux104 ux101 ux103 ux109 ux122 ux105 ux120 ux23485 ux22478 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(178, 167, '130828', '围场满族蒙古族自治县', 3, '0314', '区', 100, 'wei chang man zu meng gu zu zi zhi xian', 'ux119 ux101 ux105 ux99 ux104 ux97 ux110 ux103 ux109 ux122 ux117 ux120 ux22260 ux22330 ux28385 ux26063 ux33945 ux21476 ux33258 ux27835 ux21439', 0, 0),
(179, 35, '130900', '沧州市', 2, '0317', '市', 100, 'cang zhou shi', 'ux99 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux105 ux27815 ux24030 ux24066', 0, 0),
(180, 179, '130902', '新华区', 3, '0317', '区', 100, 'xin hua qu', 'ux120 ux105 ux110 ux104 ux117 ux97 ux113 ux26032 ux21326 ux21306', 0, 0),
(181, 179, '130903', '运河区', 3, '0317', '区', 100, 'yun he qu', 'ux121 ux117 ux110 ux104 ux101 ux113 ux36816 ux27827 ux21306', 0, 0),
(182, 179, '130921', '沧县', 3, '0317', '区', 100, 'cang xian', 'ux99 ux97 ux110 ux103 ux120 ux105 ux27815 ux21439', 0, 0),
(183, 179, '130922', '青县', 3, '0317', '区', 100, 'qing xian', 'ux113 ux105 ux110 ux103 ux120 ux97 ux38738 ux21439', 0, 0),
(184, 179, '130923', '东光县', 3, '0317', '区', 100, 'dong guang xian', 'ux100 ux111 ux110 ux103 ux117 ux97 ux120 ux105 ux19996 ux20809 ux21439', 0, 0),
(185, 179, '130924', '海兴县', 3, '0317', '区', 100, 'hai xing xian', 'ux104 ux97 ux105 ux120 ux110 ux103 ux28023 ux20852 ux21439', 0, 0),
(186, 179, '130925', '盐山县', 3, '0317', '区', 100, 'yan shan xian', 'ux121 ux97 ux110 ux115 ux104 ux120 ux105 ux30416 ux23665 ux21439', 0, 0),
(187, 179, '130926', '肃宁县', 3, '0317', '区', 100, 'su ning xian', 'ux115 ux117 ux110 ux105 ux103 ux120 ux97 ux32899 ux23425 ux21439', 0, 0),
(188, 179, '130927', '南皮县', 3, '0317', '区', 100, 'nan pi xian', 'ux110 ux97 ux112 ux105 ux120 ux21335 ux30382 ux21439', 0, 0),
(189, 179, '130928', '吴桥县', 3, '0317', '区', 100, 'wu qiao xian', 'ux119 ux117 ux113 ux105 ux97 ux111 ux120 ux110 ux21556 ux26725 ux21439', 0, 0),
(190, 179, '130929', '献县', 3, '0317', '区', 100, 'xian xian', 'ux120 ux105 ux97 ux110 ux29486 ux21439', 0, 0),
(191, 179, '130930', '孟村回族自治县', 3, '0317', '区', 100, 'meng cun hui zu zi zhi xian', 'ux109 ux101 ux110 ux103 ux99 ux117 ux104 ux105 ux122 ux120 ux97 ux23391 ux26449 ux22238 ux26063 ux33258 ux27835 ux21439', 0, 0),
(192, 179, '130981', '泊头市', 3, '0317', '区', 100, 'bo tou shi', 'ux98 ux111 ux116 ux117 ux115 ux104 ux105 ux27850 ux22836 ux24066', 0, 0),
(193, 179, '130982', '任丘市', 3, '0317', '区', 100, 'ren qiu shi', 'ux114 ux101 ux110 ux113 ux105 ux117 ux115 ux104 ux20219 ux19992 ux24066', 0, 0),
(194, 179, '130983', '黄骅市', 3, '0317', '区', 100, 'huang hua shi', 'ux104 ux117 ux97 ux110 ux103 ux115 ux105 ux40644 ux39557 ux24066', 0, 0),
(195, 179, '130984', '河间市', 3, '0317', '区', 100, 'he jian shi', 'ux104 ux101 ux106 ux105 ux97 ux110 ux115 ux27827 ux38388 ux24066', 0, 0),
(196, 35, '131000', '廊坊市', 2, '0316', '市', 100, 'lang fang shi', 'ux108 ux97 ux110 ux103 ux102 ux115 ux104 ux105 ux24266 ux22346 ux24066', 0, 0),
(197, 196, '131002', '安次区', 3, '0316', '区', 100, 'an ci qu', 'ux97 ux110 ux99 ux105 ux113 ux117 ux23433 ux27425 ux21306', 0, 0),
(198, 196, '131003', '广阳区', 3, '0316', '区', 100, 'guang yang qu', 'ux103 ux117 ux97 ux110 ux121 ux113 ux24191 ux38451 ux21306', 0, 0),
(199, 196, '131022', '固安县', 3, '0316', '区', 100, 'gu an xian', 'ux103 ux117 ux97 ux110 ux120 ux105 ux22266 ux23433 ux21439', 0, 0),
(200, 196, '131023', '永清县', 3, '0316', '区', 100, 'yong qing xian', 'ux121 ux111 ux110 ux103 ux113 ux105 ux120 ux97 ux27704 ux28165 ux21439', 0, 0),
(201, 196, '131024', '香河县', 3, '0316', '区', 100, 'xiang he xian', 'ux120 ux105 ux97 ux110 ux103 ux104 ux101 ux39321 ux27827 ux21439', 0, 0),
(202, 196, '131025', '大城县', 3, '0316', '区', 100, 'da cheng xian', 'ux100 ux97 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux22823 ux22478 ux21439', 0, 0),
(203, 196, '131026', '文安县', 3, '0316', '区', 100, 'wen an xian', 'ux119 ux101 ux110 ux97 ux120 ux105 ux25991 ux23433 ux21439', 0, 0),
(204, 196, '131028', '大厂回族自治县', 3, '0316', '区', 100, 'da chang hui zu zi zhi xian', 'ux100 ux97 ux99 ux104 ux110 ux103 ux117 ux105 ux122 ux120 ux22823 ux21378 ux22238 ux26063 ux33258 ux27835 ux21439', 0, 0),
(205, 196, '131081', '霸州市', 3, '0316', '区', 100, 'ba zhou shi', 'ux98 ux97 ux122 ux104 ux111 ux117 ux115 ux105 ux38712 ux24030 ux24066', 0, 0),
(206, 196, '131082', '三河市', 3, '0316', '区', 100, 'san he shi', 'ux115 ux97 ux110 ux104 ux101 ux105 ux19977 ux27827 ux24066', 0, 0),
(207, 35, '131100', '衡水市', 2, '0318', '市', 100, 'heng shui shi', 'ux104 ux101 ux110 ux103 ux115 ux117 ux105 ux34913 ux27700 ux24066', 0, 0),
(208, 207, '131102', '桃城区', 3, '0318', '区', 100, 'tao cheng qu', 'ux116 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux26691 ux22478 ux21306', 0, 0),
(209, 207, '131121', '枣强县', 3, '0318', '区', 100, 'zao qiang xian', 'ux122 ux97 ux111 ux113 ux105 ux110 ux103 ux120 ux26531 ux24378 ux21439', 0, 0),
(210, 207, '131122', '武邑县', 3, '0318', '区', 100, 'wu yi xian', 'ux119 ux117 ux121 ux105 ux120 ux97 ux110 ux27494 ux37009 ux21439', 0, 0),
(211, 207, '131123', '武强县', 3, '0318', '区', 100, 'wu qiang xian', 'ux119 ux117 ux113 ux105 ux97 ux110 ux103 ux120 ux27494 ux24378 ux21439', 0, 0),
(212, 207, '131124', '饶阳县', 3, '0318', '区', 100, 'rao yang xian', 'ux114 ux97 ux111 ux121 ux110 ux103 ux120 ux105 ux39286 ux38451 ux21439', 0, 0),
(213, 207, '131125', '安平县', 3, '0318', '区', 100, 'an ping xian', 'ux97 ux110 ux112 ux105 ux103 ux120 ux23433 ux24179 ux21439', 0, 0),
(214, 207, '131126', '故城县', 3, '0318', '区', 100, 'gu cheng xian', 'ux103 ux117 ux99 ux104 ux101 ux110 ux120 ux105 ux97 ux25925 ux22478 ux21439', 0, 0),
(215, 207, '131127', '景县', 3, '0318', '区', 100, 'jing xian', 'ux106 ux105 ux110 ux103 ux120 ux97 ux26223 ux21439', 0, 0),
(216, 207, '131128', '阜城县', 3, '0318', '区', 100, 'fu cheng xian', 'ux102 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux38428 ux22478 ux21439', 0, 0),
(217, 207, '131181', '冀州市', 3, '0318', '区', 100, 'ji zhou shi', 'ux106 ux105 ux122 ux104 ux111 ux117 ux115 ux20864 ux24030 ux24066', 0, 0),
(218, 207, '131182', '深州市', 3, '0318', '区', 100, 'shen zhou shi', 'ux115 ux104 ux101 ux110 ux122 ux111 ux117 ux105 ux28145 ux24030 ux24066', 0, 0),
(219, 0, '140000', '山西省', 1, '', '省', 100, 'shan xi sheng', 'ux115 ux104 ux97 ux110 ux120 ux105 ux101 ux103 ux23665 ux35199 ux30465', 0, 0),
(220, 219, '140100', '太原市', 2, '0351', '市', 100, 'tai yuan shi', 'ux116 ux97 ux105 ux121 ux117 ux110 ux115 ux104 ux22826 ux21407 ux24066', 0, 0),
(221, 220, '140105', '小店区', 3, '0351', '区', 100, 'xiao dian qu', 'ux120 ux105 ux97 ux111 ux100 ux110 ux113 ux117 ux23567 ux24215 ux21306', 0, 0),
(222, 220, '140106', '迎泽区', 3, '0351', '区', 100, 'ying ze qu', 'ux121 ux105 ux110 ux103 ux122 ux101 ux113 ux117 ux36814 ux27901 ux21306', 0, 0),
(223, 220, '140107', '杏花岭区', 3, '0351', '区', 100, 'xing hua ling qu', 'ux120 ux105 ux110 ux103 ux104 ux117 ux97 ux108 ux113 ux26447 ux33457 ux23725 ux21306', 0, 0),
(224, 220, '140108', '尖草坪区', 3, '0351', '区', 100, 'jian cao ping qu', 'ux106 ux105 ux97 ux110 ux99 ux111 ux112 ux103 ux113 ux117 ux23574 ux33609 ux22378 ux21306', 0, 0),
(225, 220, '140109', '万柏林区', 3, '0351', '区', 100, 'wan bai lin qu', 'ux119 ux97 ux110 ux98 ux105 ux108 ux113 ux117 ux19975 ux26575 ux26519 ux21306', 0, 0),
(226, 220, '140110', '晋源区', 3, '0351', '区', 100, 'jin yuan qu', 'ux106 ux105 ux110 ux121 ux117 ux97 ux113 ux26187 ux28304 ux21306', 0, 0),
(227, 220, '140121', '清徐县', 3, '0351', '区', 100, 'qing xu xian', 'ux113 ux105 ux110 ux103 ux120 ux117 ux97 ux28165 ux24464 ux21439', 0, 0),
(228, 220, '140122', '阳曲县', 3, '0351', '区', 100, 'yang qu xian', 'ux121 ux97 ux110 ux103 ux113 ux117 ux120 ux105 ux38451 ux26354 ux21439', 0, 0),
(229, 220, '140123', '娄烦县', 3, '0351', '区', 100, 'lou fan xian', 'ux108 ux111 ux117 ux102 ux97 ux110 ux120 ux105 ux23044 ux28902 ux21439', 0, 0),
(230, 220, '140181', '古交市', 3, '0351', '区', 100, 'gu jiao shi', 'ux103 ux117 ux106 ux105 ux97 ux111 ux115 ux104 ux21476 ux20132 ux24066', 0, 0),
(231, 219, '140200', '大同市', 2, '0352', '市', 100, 'da tong shi', 'ux100 ux97 ux116 ux111 ux110 ux103 ux115 ux104 ux105 ux22823 ux21516 ux24066', 0, 0),
(232, 231, '140202', '城区', 3, '0352', '区', 100, 'cheng qu', 'ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux22478 ux21306', 0, 0),
(233, 231, '140203', '矿区', 3, '0352', '区', 100, 'kuang qu', 'ux107 ux117 ux97 ux110 ux103 ux113 ux30719 ux21306', 0, 0),
(234, 231, '140211', '南郊区', 3, '0352', '区', 100, 'nan jiao qu', 'ux110 ux97 ux106 ux105 ux111 ux113 ux117 ux21335 ux37066 ux21306', 0, 0),
(235, 231, '140212', '新荣区', 3, '0352', '区', 100, 'xin rong qu', 'ux120 ux105 ux110 ux114 ux111 ux103 ux113 ux117 ux26032 ux33635 ux21306', 0, 0),
(236, 231, '140221', '阳高县', 3, '0352', '区', 100, 'yang gao xian', 'ux121 ux97 ux110 ux103 ux111 ux120 ux105 ux38451 ux39640 ux21439', 0, 0),
(237, 231, '140222', '天镇县', 3, '0352', '区', 100, 'tian zhen xian', 'ux116 ux105 ux97 ux110 ux122 ux104 ux101 ux120 ux22825 ux38215 ux21439', 0, 0),
(238, 231, '140223', '广灵县', 3, '0352', '区', 100, 'guang ling xian', 'ux103 ux117 ux97 ux110 ux108 ux105 ux120 ux24191 ux28789 ux21439', 0, 0),
(239, 231, '140224', '灵丘县', 3, '0352', '区', 100, 'ling qiu xian', 'ux108 ux105 ux110 ux103 ux113 ux117 ux120 ux97 ux28789 ux19992 ux21439', 0, 0),
(240, 231, '140225', '浑源县', 3, '0352', '区', 100, 'hun yuan xian', 'ux104 ux117 ux110 ux121 ux97 ux120 ux105 ux27985 ux28304 ux21439', 0, 0),
(241, 231, '140226', '左云县', 3, '0352', '区', 100, 'zuo yun xian', 'ux122 ux117 ux111 ux121 ux110 ux120 ux105 ux97 ux24038 ux20113 ux21439', 0, 0),
(242, 231, '140227', '大同县', 3, '0352', '区', 100, 'da tong xian', 'ux100 ux97 ux116 ux111 ux110 ux103 ux120 ux105 ux22823 ux21516 ux21439', 0, 0),
(243, 219, '140300', '阳泉市', 2, '0353', '市', 100, 'yang quan shi', 'ux121 ux97 ux110 ux103 ux113 ux117 ux115 ux104 ux105 ux38451 ux27849 ux24066', 0, 0),
(244, 243, '140302', '城区', 3, '0353', '区', 100, 'cheng qu', 'ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux22478 ux21306', 0, 0),
(245, 243, '140303', '矿区', 3, '0353', '区', 100, 'kuang qu', 'ux107 ux117 ux97 ux110 ux103 ux113 ux30719 ux21306', 0, 0),
(246, 243, '140311', '郊区', 3, '0353', '区', 100, 'jiao qu', 'ux106 ux105 ux97 ux111 ux113 ux117 ux37066 ux21306', 0, 0),
(247, 243, '140321', '平定县', 3, '0353', '区', 100, 'ping ding xian', 'ux112 ux105 ux110 ux103 ux100 ux120 ux97 ux24179 ux23450 ux21439', 0, 0),
(248, 243, '140322', '盂县', 3, '0353', '区', 100, 'yu xian', 'ux121 ux117 ux120 ux105 ux97 ux110 ux30402 ux21439', 0, 0),
(249, 219, '140400', '长治市', 2, '0355', '市', 100, 'chang zhi shi', 'ux99 ux104 ux97 ux110 ux103 ux122 ux105 ux115 ux38271 ux27835 ux24066', 0, 0),
(250, 249, '140402', '城区', 3, '0355', '区', 100, 'cheng qu', 'ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux22478 ux21306', 0, 0),
(251, 249, '140411', '郊区', 3, '0355', '区', 100, 'jiao qu', 'ux106 ux105 ux97 ux111 ux113 ux117 ux37066 ux21306', 0, 0),
(252, 249, '140421', '长治县', 3, '0355', '区', 100, 'chang zhi xian', 'ux99 ux104 ux97 ux110 ux103 ux122 ux105 ux120 ux38271 ux27835 ux21439', 0, 0),
(253, 249, '140423', '襄垣县', 3, '0355', '区', 100, 'xiang yuan xian', 'ux120 ux105 ux97 ux110 ux103 ux121 ux117 ux35140 ux22435 ux21439', 0, 0),
(254, 249, '140424', '屯留县', 3, '0355', '区', 100, 'tun liu xian', 'ux116 ux117 ux110 ux108 ux105 ux120 ux97 ux23663 ux30041 ux21439', 0, 0),
(255, 249, '140425', '平顺县', 3, '0355', '区', 100, 'ping shun xian', 'ux112 ux105 ux110 ux103 ux115 ux104 ux117 ux120 ux97 ux24179 ux39034 ux21439', 0, 0),
(256, 249, '140426', '黎城县', 3, '0355', '区', 100, 'li cheng xian', 'ux108 ux105 ux99 ux104 ux101 ux110 ux103 ux120 ux97 ux40654 ux22478 ux21439', 0, 0),
(257, 249, '140427', '壶关县', 3, '0355', '区', 100, 'hu guan xian', 'ux104 ux117 ux103 ux97 ux110 ux120 ux105 ux22774 ux20851 ux21439', 0, 0),
(258, 249, '140428', '长子县', 3, '0355', '区', 100, 'chang zi xian', 'ux99 ux104 ux97 ux110 ux103 ux122 ux105 ux120 ux38271 ux23376 ux21439', 0, 0),
(259, 249, '140429', '武乡县', 3, '0355', '区', 100, 'wu xiang xian', 'ux119 ux117 ux120 ux105 ux97 ux110 ux103 ux27494 ux20065 ux21439', 0, 0),
(260, 249, '140430', '沁县', 3, '0355', '区', 100, 'qin xian', 'ux113 ux105 ux110 ux120 ux97 ux27777 ux21439', 0, 0),
(261, 249, '140431', '沁源县', 3, '0355', '区', 100, 'qin yuan xian', 'ux113 ux105 ux110 ux121 ux117 ux97 ux120 ux27777 ux28304 ux21439', 0, 0),
(262, 249, '140481', '潞城市', 3, '0355', '区', 100, 'lu cheng shi', 'ux108 ux117 ux99 ux104 ux101 ux110 ux103 ux115 ux105 ux28510 ux22478 ux24066', 0, 0),
(263, 219, '140500', '晋城市', 2, '0356', '市', 100, 'jin cheng shi', 'ux106 ux105 ux110 ux99 ux104 ux101 ux103 ux115 ux26187 ux22478 ux24066', 0, 0),
(264, 263, '140502', '城区', 3, '0356', '区', 100, 'cheng qu', 'ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux22478 ux21306', 0, 0),
(265, 263, '140521', '沁水县', 3, '0356', '区', 100, 'qin shui xian', 'ux113 ux105 ux110 ux115 ux104 ux117 ux120 ux97 ux27777 ux27700 ux21439', 0, 0),
(266, 263, '140522', '阳城县', 3, '0356', '区', 100, 'yang cheng xian', 'ux121 ux97 ux110 ux103 ux99 ux104 ux101 ux120 ux105 ux38451 ux22478 ux21439', 0, 0),
(267, 263, '140524', '陵川县', 3, '0356', '区', 100, 'ling chuan xian', 'ux108 ux105 ux110 ux103 ux99 ux104 ux117 ux97 ux120 ux38517 ux24029 ux21439', 0, 0),
(268, 263, '140525', '泽州县', 3, '0356', '区', 100, 'ze zhou xian', 'ux122 ux101 ux104 ux111 ux117 ux120 ux105 ux97 ux110 ux27901 ux24030 ux21439', 0, 0),
(269, 263, '140581', '高平市', 3, '0356', '区', 100, 'gao ping shi', 'ux103 ux97 ux111 ux112 ux105 ux110 ux115 ux104 ux39640 ux24179 ux24066', 0, 0),
(270, 219, '140600', '朔州市', 2, '0349', '市', 100, 'shuo zhou shi', 'ux115 ux104 ux117 ux111 ux122 ux105 ux26388 ux24030 ux24066', 0, 0),
(271, 270, '140602', '朔城区', 3, '0349', '区', 100, 'shuo cheng qu', 'ux115 ux104 ux117 ux111 ux99 ux101 ux110 ux103 ux113 ux26388 ux22478 ux21306', 0, 0),
(272, 270, '140603', '平鲁区', 3, '0349', '区', 100, 'ping lu qu', 'ux112 ux105 ux110 ux103 ux108 ux117 ux113 ux24179 ux40065 ux21306', 0, 0),
(273, 270, '140621', '山阴县', 3, '0349', '区', 100, 'shan yin xian', 'ux115 ux104 ux97 ux110 ux121 ux105 ux120 ux23665 ux38452 ux21439', 0, 0),
(274, 270, '140622', '应县', 3, '0349', '区', 100, 'ying xian', 'ux121 ux105 ux110 ux103 ux120 ux97 ux24212 ux21439', 0, 0),
(275, 270, '140623', '右玉县', 3, '0349', '区', 100, 'you yu xian', 'ux121 ux111 ux117 ux120 ux105 ux97 ux110 ux21491 ux29577 ux21439', 0, 0),
(276, 270, '140624', '怀仁县', 3, '0349', '区', 100, 'huai ren xian', 'ux104 ux117 ux97 ux105 ux114 ux101 ux110 ux120 ux24576 ux20161 ux21439', 0, 0),
(277, 219, '140700', '晋中市', 2, '0354', '市', 100, 'jin zhong shi', 'ux106 ux105 ux110 ux122 ux104 ux111 ux103 ux115 ux26187 ux20013 ux24066', 0, 0),
(278, 277, '140702', '榆次区', 3, '0354', '区', 100, 'yu ci qu', 'ux121 ux117 ux99 ux105 ux113 ux27014 ux27425 ux21306', 0, 0),
(279, 277, '140721', '榆社县', 3, '0354', '区', 100, 'yu she xian', 'ux121 ux117 ux115 ux104 ux101 ux120 ux105 ux97 ux110 ux27014 ux31038 ux21439', 0, 0),
(280, 277, '140722', '左权县', 3, '0354', '区', 100, 'zuo quan xian', 'ux122 ux117 ux111 ux113 ux97 ux110 ux120 ux105 ux24038 ux26435 ux21439', 0, 0),
(281, 277, '140723', '和顺县', 3, '0354', '区', 100, 'he shun xian', 'ux104 ux101 ux115 ux117 ux110 ux120 ux105 ux97 ux21644 ux39034 ux21439', 0, 0),
(282, 277, '140724', '昔阳县', 3, '0354', '区', 100, 'xi yang xian', 'ux120 ux105 ux121 ux97 ux110 ux103 ux26132 ux38451 ux21439', 0, 0),
(283, 277, '140725', '寿阳县', 3, '0354', '区', 100, 'shou yang xian', 'ux115 ux104 ux111 ux117 ux121 ux97 ux110 ux103 ux120 ux105 ux23551 ux38451 ux21439', 0, 0),
(284, 277, '140726', '太谷县', 3, '0354', '区', 100, 'tai gu xian', 'ux116 ux97 ux105 ux103 ux117 ux120 ux110 ux22826 ux35895 ux21439', 0, 0),
(285, 277, '140727', '祁县', 3, '0354', '区', 100, 'qi xian', 'ux113 ux105 ux120 ux97 ux110 ux31041 ux21439', 0, 0),
(286, 277, '140728', '平遥县', 3, '0354', '区', 100, 'ping yao xian', 'ux112 ux105 ux110 ux103 ux121 ux97 ux111 ux120 ux24179 ux36965 ux21439', 0, 0),
(287, 277, '140729', '灵石县', 3, '0354', '区', 100, 'ling shi xian', 'ux108 ux105 ux110 ux103 ux115 ux104 ux120 ux97 ux28789 ux30707 ux21439', 0, 0),
(288, 277, '140781', '介休市', 3, '0354', '区', 100, 'jie xiu shi', 'ux106 ux105 ux101 ux120 ux117 ux115 ux104 ux20171 ux20241 ux24066', 0, 0),
(289, 219, '140800', '运城市', 2, '0359', '市', 100, 'yun cheng shi', 'ux121 ux117 ux110 ux99 ux104 ux101 ux103 ux115 ux105 ux36816 ux22478 ux24066', 0, 0),
(290, 289, '140802', '盐湖区', 3, '0359', '区', 100, 'yan hu qu', 'ux121 ux97 ux110 ux104 ux117 ux113 ux30416 ux28246 ux21306', 0, 0),
(291, 289, '140821', '临猗县', 3, '0359', '区', 100, 'lin yi xian', 'ux108 ux105 ux110 ux121 ux120 ux97 ux20020 ux29463 ux21439', 0, 0),
(292, 289, '140822', '万荣县', 3, '0359', '区', 100, 'wan rong xian', 'ux119 ux97 ux110 ux114 ux111 ux103 ux120 ux105 ux19975 ux33635 ux21439', 0, 0),
(293, 289, '140823', '闻喜县', 3, '0359', '区', 100, 'wen xi xian', 'ux119 ux101 ux110 ux120 ux105 ux97 ux38395 ux21916 ux21439', 0, 0),
(294, 289, '140824', '稷山县', 3, '0359', '区', 100, 'ji shan xian', 'ux106 ux105 ux115 ux104 ux97 ux110 ux120 ux31287 ux23665 ux21439', 0, 0),
(295, 289, '140825', '新绛县', 3, '0359', '区', 100, 'xin jiang xian', 'ux120 ux105 ux110 ux106 ux97 ux103 ux26032 ux32475 ux21439', 0, 0),
(296, 289, '140826', '绛县', 3, '0359', '区', 100, 'jiang xian', 'ux106 ux105 ux97 ux110 ux103 ux120 ux32475 ux21439', 0, 0),
(297, 289, '140827', '垣曲县', 3, '0359', '区', 100, 'yuan qu xian', 'ux121 ux117 ux97 ux110 ux113 ux120 ux105 ux22435 ux26354 ux21439', 0, 0),
(298, 289, '140828', '夏县', 3, '0359', '区', 100, 'xia xian', 'ux120 ux105 ux97 ux110 ux22799 ux21439', 0, 0),
(299, 289, '140829', '平陆县', 3, '0359', '区', 100, 'ping lu xian', 'ux112 ux105 ux110 ux103 ux108 ux117 ux120 ux97 ux24179 ux38470 ux21439', 0, 0),
(300, 289, '140830', '芮城县', 3, '0359', '区', 100, 'rui cheng xian', 'ux114 ux117 ux105 ux99 ux104 ux101 ux110 ux103 ux120 ux97 ux33454 ux22478 ux21439', 0, 0),
(301, 289, '140881', '永济市', 3, '0359', '区', 100, 'yong ji shi', 'ux121 ux111 ux110 ux103 ux106 ux105 ux115 ux104 ux27704 ux27982 ux24066', 0, 0),
(302, 289, '140882', '河津市', 3, '0359', '区', 100, 'he jin shi', 'ux104 ux101 ux106 ux105 ux110 ux115 ux27827 ux27941 ux24066', 0, 0),
(303, 219, '140900', '忻州市', 2, '0350', '市', 100, 'xin zhou shi', 'ux120 ux105 ux110 ux122 ux104 ux111 ux117 ux115 ux24571 ux24030 ux24066', 0, 0),
(304, 303, '140902', '忻府区', 3, '0350', '区', 100, 'xin fu qu', 'ux120 ux105 ux110 ux102 ux117 ux113 ux24571 ux24220 ux21306', 0, 0),
(305, 303, '140921', '定襄县', 3, '0350', '区', 100, 'ding xiang xian', 'ux100 ux105 ux110 ux103 ux120 ux97 ux23450 ux35140 ux21439', 0, 0),
(306, 303, '140922', '五台县', 3, '0350', '区', 100, 'wu tai xian', 'ux119 ux117 ux116 ux97 ux105 ux120 ux110 ux20116 ux21488 ux21439', 0, 0),
(307, 303, '140923', '代县', 3, '0350', '区', 100, 'dai xian', 'ux100 ux97 ux105 ux120 ux110 ux20195 ux21439', 0, 0),
(308, 303, '140924', '繁峙县', 3, '0350', '区', 100, 'fan zhi xian', 'ux102 ux97 ux110 ux122 ux104 ux105 ux120 ux32321 ux23769 ux21439', 0, 0),
(309, 303, '140925', '宁武县', 3, '0350', '区', 100, 'ning wu xian', 'ux110 ux105 ux103 ux119 ux117 ux120 ux97 ux23425 ux27494 ux21439', 0, 0),
(310, 303, '140926', '静乐县', 3, '0350', '区', 100, 'jing le xian', 'ux106 ux105 ux110 ux103 ux108 ux101 ux120 ux97 ux38745 ux20048 ux21439', 0, 0),
(311, 303, '140927', '神池县', 3, '0350', '区', 100, 'shen chi xian', 'ux115 ux104 ux101 ux110 ux99 ux105 ux120 ux97 ux31070 ux27744 ux21439', 0, 0),
(312, 303, '140928', '五寨县', 3, '0350', '区', 100, 'wu zhai xian', 'ux119 ux117 ux122 ux104 ux97 ux105 ux120 ux110 ux20116 ux23528 ux21439', 0, 0),
(313, 303, '140929', '岢岚县', 3, '0350', '区', 100, 'ke lan xian', 'ux107 ux101 ux108 ux97 ux110 ux120 ux105 ux23714 ux23706 ux21439', 0, 0),
(314, 303, '140930', '河曲县', 3, '0350', '区', 100, 'he qu xian', 'ux104 ux101 ux113 ux117 ux120 ux105 ux97 ux110 ux27827 ux26354 ux21439', 0, 0),
(315, 303, '140931', '保德县', 3, '0350', '区', 100, 'bao de xian', 'ux98 ux97 ux111 ux100 ux101 ux120 ux105 ux110 ux20445 ux24503 ux21439', 0, 0),
(316, 303, '140932', '偏关县', 3, '0350', '区', 100, 'pian guan xian', 'ux112 ux105 ux97 ux110 ux103 ux117 ux120 ux20559 ux20851 ux21439', 0, 0),
(317, 303, '140981', '原平市', 3, '0350', '区', 100, 'yuan ping shi', 'ux121 ux117 ux97 ux110 ux112 ux105 ux103 ux115 ux104 ux21407 ux24179 ux24066', 0, 0),
(318, 219, '141000', '临汾市', 2, '0357', '市', 100, 'lin fen shi', 'ux108 ux105 ux110 ux102 ux101 ux115 ux104 ux20020 ux27774 ux24066', 0, 0),
(319, 318, '141002', '尧都区', 3, '0357', '区', 100, 'yao du qu', 'ux121 ux97 ux111 ux100 ux117 ux113 ux23591 ux37117 ux21306', 0, 0),
(320, 318, '141021', '曲沃县', 3, '0357', '区', 100, 'qu wo xian', 'ux113 ux117 ux119 ux111 ux120 ux105 ux97 ux110 ux26354 ux27779 ux21439', 0, 0),
(321, 318, '141022', '翼城县', 3, '0357', '区', 100, 'yi cheng xian', 'ux121 ux105 ux99 ux104 ux101 ux110 ux103 ux120 ux97 ux32764 ux22478 ux21439', 0, 0),
(322, 318, '141023', '襄汾县', 3, '0357', '区', 100, 'xiang fen xian', 'ux120 ux105 ux97 ux110 ux103 ux102 ux101 ux35140 ux27774 ux21439', 0, 0),
(323, 318, '141024', '洪洞县', 3, '0357', '区', 100, 'hong dong xian', 'ux104 ux111 ux110 ux103 ux100 ux120 ux105 ux97 ux27946 ux27934 ux21439', 0, 0),
(324, 318, '141025', '古县', 3, '0357', '区', 100, 'gu xian', 'ux103 ux117 ux120 ux105 ux97 ux110 ux21476 ux21439', 0, 0),
(325, 318, '141026', '安泽县', 3, '0357', '区', 100, 'an ze xian', 'ux97 ux110 ux122 ux101 ux120 ux105 ux23433 ux27901 ux21439', 0, 0),
(326, 318, '141027', '浮山县', 3, '0357', '区', 100, 'fu shan xian', 'ux102 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux28014 ux23665 ux21439', 0, 0),
(327, 318, '141028', '吉县', 3, '0357', '区', 100, 'ji xian', 'ux106 ux105 ux120 ux97 ux110 ux21513 ux21439', 0, 0),
(328, 318, '141029', '乡宁县', 3, '0357', '区', 100, 'xiang ning xian', 'ux120 ux105 ux97 ux110 ux103 ux20065 ux23425 ux21439', 0, 0),
(329, 318, '141030', '大宁县', 3, '0357', '区', 100, 'da ning xian', 'ux100 ux97 ux110 ux105 ux103 ux120 ux22823 ux23425 ux21439', 0, 0),
(330, 318, '141031', '隰县', 3, '0357', '区', 100, 'xi xian', 'ux120 ux105 ux97 ux110 ux38576 ux21439', 0, 0),
(331, 318, '141032', '永和县', 3, '0357', '区', 100, 'yong he xian', 'ux121 ux111 ux110 ux103 ux104 ux101 ux120 ux105 ux97 ux27704 ux21644 ux21439', 0, 0),
(332, 318, '141033', '蒲县', 3, '0357', '区', 100, 'pu xian', 'ux112 ux117 ux120 ux105 ux97 ux110 ux33970 ux21439', 0, 0),
(333, 318, '141034', '汾西县', 3, '0357', '区', 100, 'fen xi xian', 'ux102 ux101 ux110 ux120 ux105 ux97 ux27774 ux35199 ux21439', 0, 0),
(334, 318, '141081', '侯马市', 3, '0357', '区', 100, 'hou ma shi', 'ux104 ux111 ux117 ux109 ux97 ux115 ux105 ux20399 ux39532 ux24066', 0, 0),
(335, 318, '141082', '霍州市', 3, '0357', '区', 100, 'huo zhou shi', 'ux104 ux117 ux111 ux122 ux115 ux105 ux38669 ux24030 ux24066', 0, 0),
(336, 219, '141100', '吕梁市', 2, '0358', '市', 100, 'lv liang shi', 'ux108 ux118 ux105 ux97 ux110 ux103 ux115 ux104 ux21525 ux26753 ux24066', 0, 0),
(337, 336, '141102', '离石区', 3, '0358', '区', 100, 'li shi qu', 'ux108 ux105 ux115 ux104 ux113 ux117 ux31163 ux30707 ux21306', 0, 0),
(338, 336, '141121', '文水县', 3, '0358', '区', 100, 'wen shui xian', 'ux119 ux101 ux110 ux115 ux104 ux117 ux105 ux120 ux97 ux25991 ux27700 ux21439', 0, 0),
(339, 336, '141122', '交城县', 3, '0358', '区', 100, 'jiao cheng xian', 'ux106 ux105 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux120 ux20132 ux22478 ux21439', 0, 0),
(340, 336, '141123', '兴县', 3, '0358', '区', 100, 'xing xian', 'ux120 ux105 ux110 ux103 ux97 ux20852 ux21439', 0, 0),
(341, 336, '141124', '临县', 3, '0358', '区', 100, 'lin xian', 'ux108 ux105 ux110 ux120 ux97 ux20020 ux21439', 0, 0),
(342, 336, '141125', '柳林县', 3, '0358', '区', 100, 'liu lin xian', 'ux108 ux105 ux117 ux110 ux120 ux97 ux26611 ux26519 ux21439', 0, 0),
(343, 336, '141126', '石楼县', 3, '0358', '区', 100, 'shi lou xian', 'ux115 ux104 ux105 ux108 ux111 ux117 ux120 ux97 ux110 ux30707 ux27004 ux21439', 0, 0),
(344, 336, '141127', '岚县', 3, '0358', '区', 100, 'lan xian', 'ux108 ux97 ux110 ux120 ux105 ux23706 ux21439', 0, 0),
(345, 336, '141128', '方山县', 3, '0358', '区', 100, 'fang shan xian', 'ux102 ux97 ux110 ux103 ux115 ux104 ux120 ux105 ux26041 ux23665 ux21439', 0, 0),
(346, 336, '141129', '中阳县', 3, '0358', '区', 100, 'zhong yang xian', 'ux122 ux104 ux111 ux110 ux103 ux121 ux97 ux120 ux105 ux20013 ux38451 ux21439', 0, 0),
(347, 336, '141130', '交口县', 3, '0358', '区', 100, 'jiao kou xian', 'ux106 ux105 ux97 ux111 ux107 ux117 ux120 ux110 ux20132 ux21475 ux21439', 0, 0),
(348, 336, '141181', '孝义市', 3, '0358', '区', 100, 'xiao yi shi', 'ux120 ux105 ux97 ux111 ux121 ux115 ux104 ux23389 ux20041 ux24066', 0, 0),
(349, 336, '141182', '汾阳市', 3, '0358', '区', 100, 'fen yang shi', 'ux102 ux101 ux110 ux121 ux97 ux103 ux115 ux104 ux105 ux27774 ux38451 ux24066', 0, 0),
(350, 0, '150000', '内蒙古自治区', 1, '', '省', 100, 'nei meng gu zi zhi qu', 'ux110 ux101 ux105 ux109 ux103 ux117 ux122 ux104 ux113 ux20869 ux33945 ux21476 ux33258 ux27835 ux21306', 0, 0),
(351, 350, '150100', '呼和浩特市', 2, '0471', '市', 100, 'hu he hao te shi', 'ux104 ux117 ux101 ux97 ux111 ux116 ux115 ux105 ux21628 ux21644 ux28009 ux29305 ux24066', 0, 0),
(352, 351, '150102', '新城区', 3, '0471', '区', 100, 'xin cheng qu', 'ux120 ux105 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux26032 ux22478 ux21306', 0, 0),
(353, 351, '150103', '回民区', 3, '0471', '区', 100, 'hui min qu', 'ux104 ux117 ux105 ux109 ux110 ux113 ux22238 ux27665 ux21306', 0, 0),
(354, 351, '150104', '玉泉区', 3, '0471', '区', 100, 'yu quan qu', 'ux121 ux117 ux113 ux97 ux110 ux29577 ux27849 ux21306', 0, 0),
(355, 351, '150105', '赛罕区', 3, '0471', '区', 100, 'sai han qu', 'ux115 ux97 ux105 ux104 ux110 ux113 ux117 ux36187 ux32597 ux21306', 0, 0),
(356, 351, '150121', '土默特左旗', 3, '0471', '区', 100, 'tu mo te zuo qi', 'ux116 ux117 ux109 ux111 ux101 ux122 ux113 ux105 ux22303 ux40664 ux29305 ux24038 ux26071', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(357, 351, '150122', '托克托县', 3, '0471', '区', 100, 'tuo ke tuo xian', 'ux116 ux117 ux111 ux107 ux101 ux120 ux105 ux97 ux110 ux25176 ux20811 ux21439', 0, 0),
(358, 351, '150123', '和林格尔县', 3, '0471', '区', 100, 'he lin ge er xian', 'ux104 ux101 ux108 ux105 ux110 ux103 ux114 ux120 ux97 ux21644 ux26519 ux26684 ux23572 ux21439', 0, 0),
(359, 351, '150124', '清水河县', 3, '0471', '区', 100, 'qing shui he xian', 'ux113 ux105 ux110 ux103 ux115 ux104 ux117 ux101 ux120 ux97 ux28165 ux27700 ux27827 ux21439', 0, 0),
(360, 351, '150125', '武川县', 3, '0471', '区', 100, 'wu chuan xian', 'ux119 ux117 ux99 ux104 ux97 ux110 ux120 ux105 ux27494 ux24029 ux21439', 0, 0),
(361, 350, '150200', '包头市', 2, '0472', '市', 100, 'bao tou shi', 'ux98 ux97 ux111 ux116 ux117 ux115 ux104 ux105 ux21253 ux22836 ux24066', 0, 0),
(362, 361, '150202', '东河区', 3, '0472', '区', 100, 'dong he qu', 'ux100 ux111 ux110 ux103 ux104 ux101 ux113 ux117 ux19996 ux27827 ux21306', 0, 0),
(363, 361, '150203', '昆都仑区', 3, '0472', '区', 100, 'kun du lun qu', 'ux107 ux117 ux110 ux100 ux108 ux113 ux26118 ux37117 ux20177 ux21306', 0, 0),
(364, 361, '150204', '青山区', 3, '0472', '区', 100, 'qing shan qu', 'ux113 ux105 ux110 ux103 ux115 ux104 ux97 ux117 ux38738 ux23665 ux21306', 0, 0),
(365, 361, '150205', '石拐区', 3, '0472', '区', 100, 'shi guai qu', 'ux115 ux104 ux105 ux103 ux117 ux97 ux113 ux30707 ux25296 ux21306', 0, 0),
(366, 361, '150206', '白云鄂博矿区', 3, '0472', '区', 100, 'bai yun e bo kuang qu', 'ux98 ux97 ux105 ux121 ux117 ux110 ux101 ux111 ux107 ux103 ux113 ux30333 ux20113 ux37122 ux21338 ux30719 ux21306', 0, 0),
(367, 361, '150207', '九原区', 3, '0472', '区', 100, 'jiu yuan qu', 'ux106 ux105 ux117 ux121 ux97 ux110 ux113 ux20061 ux21407 ux21306', 0, 0),
(368, 361, '150221', '土默特右旗', 3, '0472', '区', 100, 'tu mo te you qi', 'ux116 ux117 ux109 ux111 ux101 ux121 ux113 ux105 ux22303 ux40664 ux29305 ux21491 ux26071', 0, 0),
(369, 361, '150222', '固阳县', 3, '0472', '区', 100, 'gu yang xian', 'ux103 ux117 ux121 ux97 ux110 ux120 ux105 ux22266 ux38451 ux21439', 0, 0),
(370, 361, '150223', '达尔罕茂明安联合旗', 3, '0472', '区', 100, 'da er han mao ming an lian he qi', 'ux100 ux97 ux101 ux114 ux104 ux110 ux109 ux111 ux105 ux103 ux108 ux113 ux36798 ux23572 ux32597 ux33538 ux26126 ux23433 ux32852 ux21512 ux26071', 0, 0),
(371, 350, '150300', '乌海市', 2, '0473', '市', 100, 'wu hai shi', 'ux119 ux117 ux104 ux97 ux105 ux115 ux20044 ux28023 ux24066', 0, 0),
(372, 371, '150302', '海勃湾区', 3, '0473', '区', 100, 'hai bo wan qu', 'ux104 ux97 ux105 ux98 ux111 ux119 ux110 ux113 ux117 ux28023 ux21187 ux28286 ux21306', 0, 0),
(373, 371, '150303', '海南区', 3, '0473', '区', 100, 'hai nan qu', 'ux104 ux97 ux105 ux110 ux113 ux117 ux28023 ux21335 ux21306', 0, 0),
(374, 371, '150304', '乌达区', 3, '0473', '区', 100, 'wu da qu', 'ux119 ux117 ux100 ux97 ux113 ux20044 ux36798 ux21306', 0, 0),
(375, 350, '150400', '赤峰市', 2, '0476', '市', 100, 'chi feng shi', 'ux99 ux104 ux105 ux102 ux101 ux110 ux103 ux115 ux36196 ux23792 ux24066', 0, 0),
(376, 375, '150402', '红山区', 3, '0476', '区', 100, 'hong shan qu', 'ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux32418 ux23665 ux21306', 0, 0),
(377, 375, '150403', '元宝山区', 3, '0476', '区', 100, 'yuan bao shan qu', 'ux121 ux117 ux97 ux110 ux98 ux111 ux115 ux104 ux113 ux20803 ux23453 ux23665 ux21306', 0, 0),
(378, 375, '150404', '松山区', 3, '0476', '区', 100, 'song shan qu', 'ux115 ux111 ux110 ux103 ux104 ux97 ux113 ux117 ux26494 ux23665 ux21306', 0, 0),
(379, 375, '150421', '阿鲁科尔沁旗', 3, '0476', '区', 100, 'a lu ke er qin qi', 'ux97 ux108 ux117 ux107 ux101 ux114 ux113 ux105 ux110 ux38463 ux40065 ux31185 ux23572 ux27777 ux26071', 0, 0),
(380, 375, '150422', '巴林左旗', 3, '0476', '区', 100, 'ba lin zuo qi', 'ux98 ux97 ux108 ux105 ux110 ux122 ux117 ux111 ux113 ux24052 ux26519 ux24038 ux26071', 0, 0),
(381, 375, '150423', '巴林右旗', 3, '0476', '区', 100, 'ba lin you qi', 'ux98 ux97 ux108 ux105 ux110 ux121 ux111 ux117 ux113 ux24052 ux26519 ux21491 ux26071', 0, 0),
(382, 375, '150424', '林西县', 3, '0476', '区', 100, 'lin xi xian', 'ux108 ux105 ux110 ux120 ux97 ux26519 ux35199 ux21439', 0, 0),
(383, 375, '150425', '克什克腾旗', 3, '0476', '区', 100, 'ke shi ke teng qi', 'ux107 ux101 ux115 ux104 ux105 ux116 ux110 ux103 ux113 ux20811 ux20160 ux33150 ux26071', 0, 0),
(384, 375, '150426', '翁牛特旗', 3, '0476', '区', 100, 'weng niu te qi', 'ux119 ux101 ux110 ux103 ux105 ux117 ux116 ux113 ux32705 ux29275 ux29305 ux26071', 0, 0),
(385, 375, '150428', '喀喇沁旗', 3, '0476', '区', 100, 'ka la qin qi', 'ux107 ux97 ux108 ux113 ux105 ux110 ux21888 ux21895 ux27777 ux26071', 0, 0),
(386, 375, '150429', '宁城县', 3, '0476', '区', 100, 'ning cheng xian', 'ux110 ux105 ux103 ux99 ux104 ux101 ux120 ux97 ux23425 ux22478 ux21439', 0, 0),
(387, 375, '150430', '敖汉旗', 3, '0476', '区', 100, 'ao han qi', 'ux97 ux111 ux104 ux110 ux113 ux105 ux25942 ux27721 ux26071', 0, 0),
(388, 350, '150500', '通辽市', 2, '0475', '市', 100, 'tong liao shi', 'ux116 ux111 ux110 ux103 ux108 ux105 ux97 ux115 ux104 ux36890 ux36797 ux24066', 0, 0),
(389, 388, '150502', '科尔沁区', 3, '0475', '区', 100, 'ke er qin qu', 'ux107 ux101 ux114 ux113 ux105 ux110 ux117 ux31185 ux23572 ux27777 ux21306', 0, 0),
(390, 388, '150521', '科尔沁左翼中旗', 3, '0475', '区', 100, 'ke er qin zuo yi zhong qi', 'ux107 ux101 ux114 ux113 ux105 ux110 ux122 ux117 ux111 ux121 ux104 ux103 ux31185 ux23572 ux27777 ux24038 ux32764 ux20013 ux26071', 0, 0),
(391, 388, '150522', '科尔沁左翼后旗', 3, '0475', '区', 100, 'ke er qin zuo yi hou qi', 'ux107 ux101 ux114 ux113 ux105 ux110 ux122 ux117 ux111 ux121 ux104 ux31185 ux23572 ux27777 ux24038 ux32764 ux21518 ux26071', 0, 0),
(392, 388, '150523', '开鲁县', 3, '0475', '区', 100, 'kai lu xian', 'ux107 ux97 ux105 ux108 ux117 ux120 ux110 ux24320 ux40065 ux21439', 0, 0),
(393, 388, '150524', '库伦旗', 3, '0475', '区', 100, 'ku lun qi', 'ux107 ux117 ux108 ux110 ux113 ux105 ux24211 ux20262 ux26071', 0, 0),
(394, 388, '150525', '奈曼旗', 3, '0475', '区', 100, 'nai man qi', 'ux110 ux97 ux105 ux109 ux113 ux22856 ux26364 ux26071', 0, 0),
(395, 388, '150526', '扎鲁特旗', 3, '0475', '区', 100, 'za lu te qi', 'ux122 ux97 ux108 ux117 ux116 ux101 ux113 ux105 ux25166 ux40065 ux29305 ux26071', 0, 0),
(396, 388, '150581', '霍林郭勒市', 3, '0475', '区', 100, 'huo lin guo le shi', 'ux104 ux117 ux111 ux108 ux105 ux110 ux103 ux101 ux115 ux38669 ux26519 ux37101 ux21202 ux24066', 0, 0),
(397, 350, '150600', '鄂尔多斯市', 2, '0477', '市', 100, 'e er duo si shi', 'ux101 ux114 ux100 ux117 ux111 ux115 ux105 ux104 ux37122 ux23572 ux22810 ux26031 ux24066', 0, 0),
(398, 397, '150602', '东胜区', 3, '0477', '区', 100, 'dong sheng qu', 'ux100 ux111 ux110 ux103 ux115 ux104 ux101 ux113 ux117 ux19996 ux32988 ux21306', 0, 0),
(399, 397, '150621', '达拉特旗', 3, '0477', '区', 100, 'da la te qi', 'ux100 ux97 ux108 ux116 ux101 ux113 ux105 ux36798 ux25289 ux29305 ux26071', 0, 0),
(400, 397, '150622', '准格尔旗', 3, '0477', '区', 100, 'zhun ge er qi', 'ux122 ux104 ux117 ux110 ux103 ux101 ux114 ux113 ux105 ux20934 ux26684 ux23572 ux26071', 0, 0),
(401, 397, '150623', '鄂托克前旗', 3, '0477', '区', 100, 'e tuo ke qian qi', 'ux101 ux116 ux117 ux111 ux107 ux113 ux105 ux97 ux110 ux37122 ux25176 ux20811 ux21069 ux26071', 0, 0),
(402, 397, '150624', '鄂托克旗', 3, '0477', '区', 100, 'e tuo ke qi', 'ux101 ux116 ux117 ux111 ux107 ux113 ux105 ux37122 ux25176 ux20811 ux26071', 0, 0),
(403, 397, '150625', '杭锦旗', 3, '0477', '区', 100, 'hang jin qi', 'ux104 ux97 ux110 ux103 ux106 ux105 ux113 ux26477 ux38182 ux26071', 0, 0),
(404, 397, '150626', '乌审旗', 3, '0477', '区', 100, 'wu shen qi', 'ux119 ux117 ux115 ux104 ux101 ux110 ux113 ux105 ux20044 ux23457 ux26071', 0, 0),
(405, 397, '150627', '伊金霍洛旗', 3, '0477', '区', 100, 'yi jin huo luo qi', 'ux121 ux105 ux106 ux110 ux104 ux117 ux111 ux108 ux113 ux20234 ux37329 ux38669 ux27931 ux26071', 0, 0),
(406, 350, '150700', '呼伦贝尔市', 2, '0470', '市', 100, 'hu lun bei er shi', 'ux104 ux117 ux108 ux110 ux98 ux101 ux105 ux114 ux115 ux21628 ux20262 ux36125 ux23572 ux24066', 0, 0),
(407, 406, '150702', '海拉尔区', 3, '0470', '区', 100, 'hai la er qu', 'ux104 ux97 ux105 ux108 ux101 ux114 ux113 ux117 ux28023 ux25289 ux23572 ux21306', 0, 0),
(408, 406, '150721', '阿荣旗', 3, '0470', '区', 100, 'a rong qi', 'ux97 ux114 ux111 ux110 ux103 ux113 ux105 ux38463 ux33635 ux26071', 0, 0),
(409, 406, '150722', '莫力达瓦达斡尔族自治旗', 3, '0470', '区', 100, 'mo li da wa da wo er zu zi zhi qi', 'ux109 ux111 ux108 ux105 ux100 ux97 ux119 ux101 ux114 ux122 ux117 ux104 ux113 ux33707 ux21147 ux36798 ux29926 ux26017 ux23572 ux26063 ux33258 ux27835 ux26071', 0, 0),
(410, 406, '150723', '鄂伦春自治旗', 3, '0470', '区', 100, 'e lun chun zi zhi qi', 'ux101 ux108 ux117 ux110 ux99 ux104 ux122 ux105 ux113 ux37122 ux20262 ux26149 ux33258 ux27835 ux26071', 0, 0),
(411, 406, '150724', '鄂温克族自治旗', 3, '0470', '区', 100, 'e wen ke zu zi zhi qi', 'ux101 ux119 ux110 ux107 ux122 ux117 ux105 ux104 ux113 ux37122 ux28201 ux20811 ux26063 ux33258 ux27835 ux26071', 0, 0),
(412, 406, '150725', '陈巴尔虎旗', 3, '0470', '区', 100, 'chen ba er hu qi', 'ux99 ux104 ux101 ux110 ux98 ux97 ux114 ux117 ux113 ux105 ux38472 ux24052 ux23572 ux34382 ux26071', 0, 0),
(413, 406, '150726', '新巴尔虎左旗', 3, '0470', '区', 100, 'xin ba er hu zuo qi', 'ux120 ux105 ux110 ux98 ux97 ux101 ux114 ux104 ux117 ux122 ux111 ux113 ux26032 ux24052 ux23572 ux34382 ux24038 ux26071', 0, 0),
(414, 406, '150727', '新巴尔虎右旗', 3, '0470', '区', 100, 'xin ba er hu you qi', 'ux120 ux105 ux110 ux98 ux97 ux101 ux114 ux104 ux117 ux121 ux111 ux113 ux26032 ux24052 ux23572 ux34382 ux21491 ux26071', 0, 0),
(415, 406, '150781', '满洲里市', 3, '0470', '区', 100, 'man zhou li shi', 'ux109 ux97 ux110 ux122 ux104 ux111 ux117 ux108 ux105 ux115 ux28385 ux27954 ux37324 ux24066', 0, 0),
(416, 406, '150782', '牙克石市', 3, '0470', '区', 100, 'ya ke shi shi', 'ux121 ux97 ux107 ux101 ux115 ux104 ux105 ux29273 ux20811 ux30707 ux24066', 0, 0),
(417, 406, '150783', '扎兰屯市', 3, '0470', '区', 100, 'za lan tun shi', 'ux122 ux97 ux108 ux110 ux116 ux117 ux115 ux104 ux105 ux25166 ux20848 ux23663 ux24066', 0, 0),
(418, 406, '150784', '额尔古纳市', 3, '0470', '区', 100, 'e er gu na shi', 'ux101 ux114 ux103 ux117 ux110 ux97 ux115 ux104 ux105 ux39069 ux23572 ux21476 ux32435 ux24066', 0, 0),
(419, 406, '150785', '根河市', 3, '0470', '区', 100, 'gen he shi', 'ux103 ux101 ux110 ux104 ux115 ux105 ux26681 ux27827 ux24066', 0, 0),
(420, 350, '150800', '巴彦淖尔市', 2, '0478', '市', 100, 'ba yan nao er shi', 'ux98 ux97 ux121 ux110 ux111 ux101 ux114 ux115 ux104 ux105 ux24052 ux24422 ux28118 ux23572 ux24066', 0, 0),
(421, 420, '150802', '临河区', 3, '0478', '区', 100, 'lin he qu', 'ux108 ux105 ux110 ux104 ux101 ux113 ux117 ux20020 ux27827 ux21306', 0, 0),
(422, 420, '150821', '五原县', 3, '0478', '区', 100, 'wu yuan xian', 'ux119 ux117 ux121 ux97 ux110 ux120 ux105 ux20116 ux21407 ux21439', 0, 0),
(423, 420, '150822', '磴口县', 3, '0478', '区', 100, 'deng kou xian', 'ux100 ux101 ux110 ux103 ux107 ux111 ux117 ux120 ux105 ux97 ux30964 ux21475 ux21439', 0, 0),
(424, 420, '150823', '乌拉特前旗', 3, '0478', '区', 100, 'wu la te qian qi', 'ux119 ux117 ux108 ux97 ux116 ux101 ux113 ux105 ux110 ux20044 ux25289 ux29305 ux21069 ux26071', 0, 0),
(425, 420, '150824', '乌拉特中旗', 3, '0478', '区', 100, 'wu la te zhong qi', 'ux119 ux117 ux108 ux97 ux116 ux101 ux122 ux104 ux111 ux110 ux103 ux113 ux105 ux20044 ux25289 ux29305 ux20013 ux26071', 0, 0),
(426, 420, '150825', '乌拉特后旗', 3, '0478', '区', 100, 'wu la te hou qi', 'ux119 ux117 ux108 ux97 ux116 ux101 ux104 ux111 ux113 ux105 ux20044 ux25289 ux29305 ux21518 ux26071', 0, 0),
(427, 420, '150826', '杭锦后旗', 3, '0478', '区', 100, 'hang jin hou qi', 'ux104 ux97 ux110 ux103 ux106 ux105 ux111 ux117 ux113 ux26477 ux38182 ux21518 ux26071', 0, 0),
(428, 350, '150900', '乌兰察布市', 2, '0474', '市', 100, 'wu lan cha bu shi', 'ux119 ux117 ux108 ux97 ux110 ux99 ux104 ux98 ux115 ux105 ux20044 ux20848 ux23519 ux24067 ux24066', 0, 0),
(429, 428, '150902', '集宁区', 3, '0474', '区', 100, 'ji ning qu', 'ux106 ux105 ux110 ux103 ux113 ux117 ux38598 ux23425 ux21306', 0, 0),
(430, 428, '150921', '卓资县', 3, '0474', '区', 100, 'zhuo zi xian', 'ux122 ux104 ux117 ux111 ux105 ux120 ux97 ux110 ux21331 ux36164 ux21439', 0, 0),
(431, 428, '150922', '化德县', 3, '0474', '区', 100, 'hua de xian', 'ux104 ux117 ux97 ux100 ux101 ux120 ux105 ux110 ux21270 ux24503 ux21439', 0, 0),
(432, 428, '150923', '商都县', 3, '0474', '区', 100, 'shang du xian', 'ux115 ux104 ux97 ux110 ux103 ux100 ux117 ux120 ux105 ux21830 ux37117 ux21439', 0, 0),
(433, 428, '150924', '兴和县', 3, '0474', '区', 100, 'xing he xian', 'ux120 ux105 ux110 ux103 ux104 ux101 ux97 ux20852 ux21644 ux21439', 0, 0),
(434, 428, '150925', '凉城县', 3, '0474', '区', 100, 'liang cheng xian', 'ux108 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux120 ux20937 ux22478 ux21439', 0, 0),
(435, 428, '150926', '察哈尔右翼前旗', 3, '0474', '区', 100, 'cha ha er you yi qian qi', 'ux99 ux104 ux97 ux101 ux114 ux121 ux111 ux117 ux105 ux113 ux110 ux23519 ux21704 ux23572 ux21491 ux32764 ux21069 ux26071', 0, 0),
(436, 428, '150927', '察哈尔右翼中旗', 3, '0474', '区', 100, 'cha ha er you yi zhong qi', 'ux99 ux104 ux97 ux101 ux114 ux121 ux111 ux117 ux105 ux122 ux110 ux103 ux113 ux23519 ux21704 ux23572 ux21491 ux32764 ux20013 ux26071', 0, 0),
(437, 428, '150928', '察哈尔右翼后旗', 3, '0474', '区', 100, 'cha ha er you yi hou qi', 'ux99 ux104 ux97 ux101 ux114 ux121 ux111 ux117 ux105 ux113 ux23519 ux21704 ux23572 ux21491 ux32764 ux21518 ux26071', 0, 0),
(438, 428, '150929', '四子王旗', 3, '0474', '区', 100, 'si zi wang qi', 'ux115 ux105 ux122 ux119 ux97 ux110 ux103 ux113 ux22235 ux23376 ux29579 ux26071', 0, 0),
(439, 428, '150981', '丰镇市', 3, '0474', '区', 100, 'feng zhen shi', 'ux102 ux101 ux110 ux103 ux122 ux104 ux115 ux105 ux20016 ux38215 ux24066', 0, 0),
(440, 350, '152200', '兴安盟', 2, '0482', '市', 100, 'xing an meng', 'ux120 ux105 ux110 ux103 ux97 ux109 ux101 ux20852 ux23433 ux30431', 0, 0),
(441, 440, '152201', '乌兰浩特市', 3, '0482', '区', 100, 'wu lan hao te shi', 'ux119 ux117 ux108 ux97 ux110 ux104 ux111 ux116 ux101 ux115 ux105 ux20044 ux20848 ux28009 ux29305 ux24066', 0, 0),
(442, 440, '152202', '阿尔山市', 3, '0482', '区', 100, 'a er shan shi', 'ux97 ux101 ux114 ux115 ux104 ux110 ux105 ux38463 ux23572 ux23665 ux24066', 0, 0),
(443, 440, '152221', '科尔沁右翼前旗', 3, '0482', '区', 100, 'ke er qin you yi qian qi', 'ux107 ux101 ux114 ux113 ux105 ux110 ux121 ux111 ux117 ux97 ux31185 ux23572 ux27777 ux21491 ux32764 ux21069 ux26071', 0, 0),
(444, 440, '152222', '科尔沁右翼中旗', 3, '0482', '区', 100, 'ke er qin you yi zhong qi', 'ux107 ux101 ux114 ux113 ux105 ux110 ux121 ux111 ux117 ux122 ux104 ux103 ux31185 ux23572 ux27777 ux21491 ux32764 ux20013 ux26071', 0, 0),
(445, 440, '152223', '扎赉特旗', 3, '0482', '区', 100, 'za lai te qi', 'ux122 ux97 ux108 ux105 ux116 ux101 ux113 ux25166 ux36169 ux29305 ux26071', 0, 0),
(446, 440, '152224', '突泉县', 3, '0482', '区', 100, 'tu quan xian', 'ux116 ux117 ux113 ux97 ux110 ux120 ux105 ux31361 ux27849 ux21439', 0, 0),
(447, 350, '152500', '锡林郭勒盟', 2, '0479', '市', 100, 'xi lin guo le meng', 'ux120 ux105 ux108 ux110 ux103 ux117 ux111 ux101 ux109 ux38177 ux26519 ux37101 ux21202 ux30431', 0, 0),
(448, 447, '152501', '二连浩特市', 3, '0479', '区', 100, 'er lian hao te shi', 'ux101 ux114 ux108 ux105 ux97 ux110 ux104 ux111 ux116 ux115 ux20108 ux36830 ux28009 ux29305 ux24066', 0, 0),
(449, 447, '152502', '锡林浩特市', 3, '0479', '区', 100, 'xi lin hao te shi', 'ux120 ux105 ux108 ux110 ux104 ux97 ux111 ux116 ux101 ux115 ux38177 ux26519 ux28009 ux29305 ux24066', 0, 0),
(450, 447, '152522', '阿巴嘎旗', 3, '0479', '区', 100, 'a ba ga qi', 'ux97 ux98 ux103 ux113 ux105 ux38463 ux24052 ux22030 ux26071', 0, 0),
(451, 447, '152523', '苏尼特左旗', 3, '0479', '区', 100, 'su ni te zuo qi', 'ux115 ux117 ux110 ux105 ux116 ux101 ux122 ux111 ux113 ux33487 ux23612 ux29305 ux24038 ux26071', 0, 0),
(452, 447, '152524', '苏尼特右旗', 3, '0479', '区', 100, 'su ni te you qi', 'ux115 ux117 ux110 ux105 ux116 ux101 ux121 ux111 ux113 ux33487 ux23612 ux29305 ux21491 ux26071', 0, 0),
(453, 447, '152525', '东乌珠穆沁旗', 3, '0479', '区', 100, 'dong wu zhu mu qin qi', 'ux100 ux111 ux110 ux103 ux119 ux117 ux122 ux104 ux109 ux113 ux105 ux19996 ux20044 ux29664 ux31302 ux27777 ux26071', 0, 0),
(454, 447, '152526', '西乌珠穆沁旗', 3, '0479', '区', 100, 'xi wu zhu mu qin qi', 'ux120 ux105 ux119 ux117 ux122 ux104 ux109 ux113 ux110 ux35199 ux20044 ux29664 ux31302 ux27777 ux26071', 0, 0),
(455, 447, '152527', '太仆寺旗', 3, '0479', '区', 100, 'tai pu si qi', 'ux116 ux97 ux105 ux112 ux117 ux115 ux113 ux22826 ux20166 ux23546 ux26071', 0, 0),
(456, 447, '152528', '镶黄旗', 3, '0479', '区', 100, 'xiang huang qi', 'ux120 ux105 ux97 ux110 ux103 ux104 ux117 ux113 ux38262 ux40644 ux26071', 0, 0),
(457, 447, '152529', '正镶白旗', 3, '0479', '区', 100, 'zheng xiang bai qi', 'ux122 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux98 ux113 ux27491 ux38262 ux30333 ux26071', 0, 0),
(458, 447, '152530', '正蓝旗', 3, '0479', '区', 100, 'zheng lan qi', 'ux122 ux104 ux101 ux110 ux103 ux108 ux97 ux113 ux105 ux27491 ux34013 ux26071', 0, 0),
(459, 447, '152531', '多伦县', 3, '0479', '区', 100, 'duo lun xian', 'ux100 ux117 ux111 ux108 ux110 ux120 ux105 ux97 ux22810 ux20262 ux21439', 0, 0),
(460, 350, '152900', '阿拉善盟', 2, '0483', '市', 100, 'a la shan meng', 'ux97 ux108 ux115 ux104 ux110 ux109 ux101 ux103 ux38463 ux25289 ux21892 ux30431', 0, 0),
(461, 460, '152921', '阿拉善左旗', 3, '0483', '区', 100, 'a la shan zuo qi', 'ux97 ux108 ux115 ux104 ux110 ux122 ux117 ux111 ux113 ux105 ux38463 ux25289 ux21892 ux24038 ux26071', 0, 0),
(462, 460, '152922', '阿拉善右旗', 3, '0483', '区', 100, 'a la shan you qi', 'ux97 ux108 ux115 ux104 ux110 ux121 ux111 ux117 ux113 ux105 ux38463 ux25289 ux21892 ux21491 ux26071', 0, 0),
(463, 460, '152923', '额济纳旗', 3, '0483', '区', 100, 'e ji na qi', 'ux101 ux106 ux105 ux110 ux97 ux113 ux39069 ux27982 ux32435 ux26071', 0, 0),
(464, 0, '210000', '辽宁省', 1, '', '省', 100, 'liao ning sheng', 'ux108 ux105 ux97 ux111 ux110 ux103 ux115 ux104 ux101 ux36797 ux23425 ux30465', 0, 0),
(465, 464, '210100', '沈阳市', 2, '024', '市', 100, 'shen yang shi', 'ux115 ux104 ux101 ux110 ux121 ux97 ux103 ux105 ux27784 ux38451 ux24066', 0, 0),
(466, 465, '210102', '和平区', 3, '024', '区', 100, 'he ping qu', 'ux104 ux101 ux112 ux105 ux110 ux103 ux113 ux117 ux21644 ux24179 ux21306', 0, 0),
(467, 465, '210103', '沈河区', 3, '024', '区', 100, 'shen he qu', 'ux115 ux104 ux101 ux110 ux113 ux117 ux27784 ux27827 ux21306', 0, 0),
(468, 465, '210104', '大东区', 3, '024', '区', 100, 'da dong qu', 'ux100 ux97 ux111 ux110 ux103 ux113 ux117 ux22823 ux19996 ux21306', 0, 0),
(469, 465, '210105', '皇姑区', 3, '024', '区', 100, 'huang gu qu', 'ux104 ux117 ux97 ux110 ux103 ux113 ux30343 ux22993 ux21306', 0, 0),
(470, 465, '210106', '铁西区', 3, '024', '区', 100, 'tie xi qu', 'ux116 ux105 ux101 ux120 ux113 ux117 ux38081 ux35199 ux21306', 0, 0),
(471, 465, '210111', '苏家屯区', 3, '024', '区', 100, 'su jia tun qu', 'ux115 ux117 ux106 ux105 ux97 ux116 ux110 ux113 ux33487 ux23478 ux23663 ux21306', 0, 0),
(472, 465, '210112', '东陵区', 3, '024', '区', 100, 'dong ling qu', 'ux100 ux111 ux110 ux103 ux108 ux105 ux113 ux117 ux19996 ux38517 ux21306', 0, 0),
(473, 465, '210113', '沈北新区', 3, '024', '区', 100, 'shen bei xin qu', 'ux115 ux104 ux101 ux110 ux98 ux105 ux120 ux113 ux117 ux27784 ux21271 ux26032 ux21306', 0, 0),
(474, 465, '210114', '于洪区', 3, '024', '区', 100, 'yu hong qu', 'ux121 ux117 ux104 ux111 ux110 ux103 ux113 ux20110 ux27946 ux21306', 0, 0),
(475, 465, '210122', '辽中县', 3, '024', '区', 100, 'liao zhong xian', 'ux108 ux105 ux97 ux111 ux122 ux104 ux110 ux103 ux120 ux36797 ux20013 ux21439', 0, 0),
(476, 465, '210123', '康平县', 3, '024', '区', 100, 'kang ping xian', 'ux107 ux97 ux110 ux103 ux112 ux105 ux120 ux24247 ux24179 ux21439', 0, 0),
(477, 465, '210124', '法库县', 3, '024', '区', 100, 'fa ku xian', 'ux102 ux97 ux107 ux117 ux120 ux105 ux110 ux27861 ux24211 ux21439', 0, 0),
(478, 465, '210181', '新民市', 3, '024', '区', 100, 'xin min shi', 'ux120 ux105 ux110 ux109 ux115 ux104 ux26032 ux27665 ux24066', 0, 0),
(479, 464, '210200', '大连市', 2, '0411', '市', 100, 'da lian shi', 'ux100 ux97 ux108 ux105 ux110 ux115 ux104 ux22823 ux36830 ux24066', 0, 0),
(480, 479, '210202', '中山区', 3, '0411', '区', 100, 'zhong shan qu', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux20013 ux23665 ux21306', 0, 0),
(481, 479, '210203', '西岗区', 3, '0411', '区', 100, 'xi gang qu', 'ux120 ux105 ux103 ux97 ux110 ux113 ux117 ux35199 ux23703 ux21306', 0, 0),
(482, 479, '210204', '沙河口区', 3, '0411', '区', 100, 'sha he kou qu', 'ux115 ux104 ux97 ux101 ux107 ux111 ux117 ux113 ux27801 ux27827 ux21475 ux21306', 0, 0),
(483, 479, '210211', '甘井子区', 3, '0411', '区', 100, 'gan jing zi qu', 'ux103 ux97 ux110 ux106 ux105 ux122 ux113 ux117 ux29976 ux20117 ux23376 ux21306', 0, 0),
(484, 479, '210212', '旅顺口区', 3, '0411', '区', 100, 'lv shun kou qu', 'ux108 ux118 ux115 ux104 ux117 ux110 ux107 ux111 ux113 ux26053 ux39034 ux21475 ux21306', 0, 0),
(485, 479, '210213', '金州区', 3, '0411', '区', 100, 'jin zhou qu', 'ux106 ux105 ux110 ux122 ux104 ux111 ux117 ux113 ux37329 ux24030 ux21306', 0, 0),
(486, 479, '210224', '长海县', 3, '0411', '区', 100, 'chang hai xian', 'ux99 ux104 ux97 ux110 ux103 ux105 ux120 ux38271 ux28023 ux21439', 0, 0),
(487, 479, '210281', '瓦房店市', 3, '0411', '区', 100, 'wa fang dian shi', 'ux119 ux97 ux102 ux110 ux103 ux100 ux105 ux115 ux104 ux29926 ux25151 ux24215 ux24066', 0, 0),
(488, 479, '210282', '普兰店市', 3, '0411', '区', 100, 'pu lan dian shi', 'ux112 ux117 ux108 ux97 ux110 ux100 ux105 ux115 ux104 ux26222 ux20848 ux24215 ux24066', 0, 0),
(489, 479, '210283', '庄河市', 3, '0411', '区', 100, 'zhuang he shi', 'ux122 ux104 ux117 ux97 ux110 ux103 ux101 ux115 ux105 ux24196 ux27827 ux24066', 0, 0),
(490, 464, '210300', '鞍山市', 2, '0412', '市', 100, 'an shan shi', 'ux97 ux110 ux115 ux104 ux105 ux38797 ux23665 ux24066', 0, 0),
(491, 490, '210302', '铁东区', 3, '0412', '区', 100, 'tie dong qu', 'ux116 ux105 ux101 ux100 ux111 ux110 ux103 ux113 ux117 ux38081 ux19996 ux21306', 0, 0),
(492, 490, '210303', '铁西区', 3, '0412', '区', 100, 'tie xi qu', 'ux116 ux105 ux101 ux120 ux113 ux117 ux38081 ux35199 ux21306', 0, 0),
(493, 490, '210304', '立山区', 3, '0412', '区', 100, 'li shan qu', 'ux108 ux105 ux115 ux104 ux97 ux110 ux113 ux117 ux31435 ux23665 ux21306', 0, 0),
(494, 490, '210311', '千山区', 3, '0412', '区', 100, 'qian shan qu', 'ux113 ux105 ux97 ux110 ux115 ux104 ux117 ux21315 ux23665 ux21306', 0, 0),
(495, 490, '210321', '台安县', 3, '0412', '区', 100, 'tai an xian', 'ux116 ux97 ux105 ux110 ux120 ux21488 ux23433 ux21439', 0, 0),
(496, 490, '210323', '岫岩满族自治县', 3, '0412', '区', 100, 'xiu yan man zu zi zhi xian', 'ux120 ux105 ux117 ux121 ux97 ux110 ux109 ux122 ux104 ux23723 ux23721 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(497, 490, '210381', '海城市', 3, '0412', '区', 100, 'hai cheng shi', 'ux104 ux97 ux105 ux99 ux101 ux110 ux103 ux115 ux28023 ux22478 ux24066', 0, 0),
(498, 464, '210400', '抚顺市', 2, '0413', '市', 100, 'fu shun shi', 'ux102 ux117 ux115 ux104 ux110 ux105 ux25242 ux39034 ux24066', 0, 0),
(499, 498, '210402', '新抚区', 3, '0413', '区', 100, 'xin fu qu', 'ux120 ux105 ux110 ux102 ux117 ux113 ux26032 ux25242 ux21306', 0, 0),
(500, 498, '210403', '东洲区', 3, '0413', '区', 100, 'dong zhou qu', 'ux100 ux111 ux110 ux103 ux122 ux104 ux117 ux113 ux19996 ux27954 ux21306', 0, 0),
(501, 498, '210404', '望花区', 3, '0413', '区', 100, 'wang hua qu', 'ux119 ux97 ux110 ux103 ux104 ux117 ux113 ux26395 ux33457 ux21306', 0, 0),
(502, 498, '210411', '顺城区', 3, '0413', '区', 100, 'shun cheng qu', 'ux115 ux104 ux117 ux110 ux99 ux101 ux103 ux113 ux39034 ux22478 ux21306', 0, 0),
(503, 498, '210421', '抚顺县', 3, '0413', '区', 100, 'fu shun xian', 'ux102 ux117 ux115 ux104 ux110 ux120 ux105 ux97 ux25242 ux39034 ux21439', 0, 0),
(504, 498, '210422', '新宾满族自治县', 3, '0413', '区', 100, 'xin bin man zu zi zhi xian', 'ux120 ux105 ux110 ux98 ux109 ux97 ux122 ux117 ux104 ux26032 ux23486 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(505, 498, '210423', '清原满族自治县', 3, '0413', '区', 100, 'qing yuan man zu zi zhi xian', 'ux113 ux105 ux110 ux103 ux121 ux117 ux97 ux109 ux122 ux104 ux120 ux28165 ux21407 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(506, 464, '210500', '本溪市', 2, '0414', '市', 100, 'ben xi shi', 'ux98 ux101 ux110 ux120 ux105 ux115 ux104 ux26412 ux28330 ux24066', 0, 0),
(507, 506, '210502', '平山区', 3, '0414', '区', 100, 'ping shan qu', 'ux112 ux105 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux24179 ux23665 ux21306', 0, 0),
(508, 506, '210503', '溪湖区', 3, '0414', '区', 100, 'xi hu qu', 'ux120 ux105 ux104 ux117 ux113 ux28330 ux28246 ux21306', 0, 0),
(509, 506, '210504', '明山区', 3, '0414', '区', 100, 'ming shan qu', 'ux109 ux105 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux26126 ux23665 ux21306', 0, 0),
(510, 506, '210505', '南芬区', 3, '0414', '区', 100, 'nan fen qu', 'ux110 ux97 ux102 ux101 ux113 ux117 ux21335 ux33452 ux21306', 0, 0),
(511, 506, '210521', '本溪满族自治县', 3, '0414', '区', 100, 'ben xi man zu zi zhi xian', 'ux98 ux101 ux110 ux120 ux105 ux109 ux97 ux122 ux117 ux104 ux26412 ux28330 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(512, 506, '210522', '桓仁满族自治县', 3, '0414', '区', 100, 'huan ren man zu zi zhi xian', 'ux104 ux117 ux97 ux110 ux114 ux101 ux109 ux122 ux105 ux120 ux26707 ux20161 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(513, 464, '210600', '丹东市', 2, '0415', '市', 100, 'dan dong shi', 'ux100 ux97 ux110 ux111 ux103 ux115 ux104 ux105 ux20025 ux19996 ux24066', 0, 0),
(514, 513, '210602', '元宝区', 3, '0415', '区', 100, 'yuan bao qu', 'ux121 ux117 ux97 ux110 ux98 ux111 ux113 ux20803 ux23453 ux21306', 0, 0),
(515, 513, '210603', '振兴区', 3, '0415', '区', 100, 'zhen xing qu', 'ux122 ux104 ux101 ux110 ux120 ux105 ux103 ux113 ux117 ux25391 ux20852 ux21306', 0, 0),
(516, 513, '210604', '振安区', 3, '0415', '区', 100, 'zhen an qu', 'ux122 ux104 ux101 ux110 ux97 ux113 ux117 ux25391 ux23433 ux21306', 0, 0),
(517, 513, '210624', '宽甸满族自治县', 3, '0415', '区', 100, 'kuan dian man zu zi zhi xian', 'ux107 ux117 ux97 ux110 ux100 ux105 ux109 ux122 ux104 ux120 ux23485 ux30008 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(518, 513, '210681', '东港市', 3, '0415', '区', 100, 'dong gang shi', 'ux100 ux111 ux110 ux103 ux97 ux115 ux104 ux105 ux19996 ux28207 ux24066', 0, 0),
(519, 513, '210682', '凤城市', 3, '0415', '区', 100, 'feng cheng shi', 'ux102 ux101 ux110 ux103 ux99 ux104 ux115 ux105 ux20964 ux22478 ux24066', 0, 0),
(520, 464, '210700', '锦州市', 2, '0416', '市', 100, 'jin zhou shi', 'ux106 ux105 ux110 ux122 ux104 ux111 ux117 ux115 ux38182 ux24030 ux24066', 0, 0),
(521, 520, '210702', '古塔区', 3, '0416', '区', 100, 'gu ta qu', 'ux103 ux117 ux116 ux97 ux113 ux21476 ux22612 ux21306', 0, 0),
(522, 520, '210703', '凌河区', 3, '0416', '区', 100, 'ling he qu', 'ux108 ux105 ux110 ux103 ux104 ux101 ux113 ux117 ux20940 ux27827 ux21306', 0, 0),
(523, 520, '210711', '太和区', 3, '0416', '区', 100, 'tai he qu', 'ux116 ux97 ux105 ux104 ux101 ux113 ux117 ux22826 ux21644 ux21306', 0, 0),
(524, 520, '210726', '黑山县', 3, '0416', '区', 100, 'hei shan xian', 'ux104 ux101 ux105 ux115 ux97 ux110 ux120 ux40657 ux23665 ux21439', 0, 0),
(525, 520, '210727', '义县', 3, '0416', '区', 100, 'yi xian', 'ux121 ux105 ux120 ux97 ux110 ux20041 ux21439', 0, 0),
(526, 520, '210781', '凌海市', 3, '0416', '区', 100, 'ling hai shi', 'ux108 ux105 ux110 ux103 ux104 ux97 ux115 ux20940 ux28023 ux24066', 0, 0),
(527, 520, '210782', '北镇市', 3, '0416', '区', 100, 'bei zhen shi', 'ux98 ux101 ux105 ux122 ux104 ux110 ux115 ux21271 ux38215 ux24066', 0, 0),
(528, 464, '210800', '营口市', 2, '0417', '市', 100, 'ying kou shi', 'ux121 ux105 ux110 ux103 ux107 ux111 ux117 ux115 ux104 ux33829 ux21475 ux24066', 0, 0),
(529, 528, '210802', '站前区', 3, '0417', '区', 100, 'zhan qian qu', 'ux122 ux104 ux97 ux110 ux113 ux105 ux117 ux31449 ux21069 ux21306', 0, 0),
(530, 528, '210803', '西市区', 3, '0417', '区', 100, 'xi shi qu', 'ux120 ux105 ux115 ux104 ux113 ux117 ux35199 ux24066 ux21306', 0, 0),
(531, 528, '210804', '鲅鱼圈区', 3, '0417', '区', 100, 'ba yu quan qu', 'ux98 ux97 ux121 ux117 ux113 ux110 ux40069 ux40060 ux22280 ux21306', 0, 0),
(532, 528, '210811', '老边区', 3, '0417', '区', 100, 'lao bian qu', 'ux108 ux97 ux111 ux98 ux105 ux110 ux113 ux117 ux32769 ux36793 ux21306', 0, 0),
(533, 528, '210881', '盖州市', 3, '0417', '区', 100, 'gai zhou shi', 'ux103 ux97 ux105 ux122 ux104 ux111 ux117 ux115 ux30422 ux24030 ux24066', 0, 0),
(534, 528, '210882', '大石桥市', 3, '0417', '区', 100, 'da shi qiao shi', 'ux100 ux97 ux115 ux104 ux105 ux113 ux111 ux22823 ux30707 ux26725 ux24066', 0, 0),
(535, 464, '210900', '阜新市', 2, '0418', '市', 100, 'fu xin shi', 'ux102 ux117 ux120 ux105 ux110 ux115 ux104 ux38428 ux26032 ux24066', 0, 0),
(536, 535, '210902', '海州区', 3, '0418', '区', 100, 'hai zhou qu', 'ux104 ux97 ux105 ux122 ux111 ux117 ux113 ux28023 ux24030 ux21306', 0, 0),
(537, 535, '210903', '新邱区', 3, '0418', '区', 100, 'xin qiu qu', 'ux120 ux105 ux110 ux113 ux117 ux26032 ux37041 ux21306', 0, 0),
(538, 535, '210904', '太平区', 3, '0418', '区', 100, 'tai ping qu', 'ux116 ux97 ux105 ux112 ux110 ux103 ux113 ux117 ux22826 ux24179 ux21306', 0, 0),
(539, 535, '210905', '清河门区', 3, '0418', '区', 100, 'qing he men qu', 'ux113 ux105 ux110 ux103 ux104 ux101 ux109 ux117 ux28165 ux27827 ux38376 ux21306', 0, 0),
(540, 535, '210911', '细河区', 3, '0418', '区', 100, 'xi he qu', 'ux120 ux105 ux104 ux101 ux113 ux117 ux32454 ux27827 ux21306', 0, 0),
(541, 535, '210921', '阜新蒙古族自治县', 3, '0418', '区', 100, 'fu xin meng gu zu zi zhi xian', 'ux102 ux117 ux120 ux105 ux110 ux109 ux101 ux103 ux122 ux104 ux97 ux38428 ux26032 ux33945 ux21476 ux26063 ux33258 ux27835 ux21439', 0, 0),
(542, 535, '210922', '彰武县', 3, '0418', '区', 100, 'zhang wu xian', 'ux122 ux104 ux97 ux110 ux103 ux119 ux117 ux120 ux105 ux24432 ux27494 ux21439', 0, 0),
(543, 464, '211000', '辽阳市', 2, '0419', '市', 100, 'liao yang shi', 'ux108 ux105 ux97 ux111 ux121 ux110 ux103 ux115 ux104 ux36797 ux38451 ux24066', 0, 0),
(544, 543, '211002', '白塔区', 3, '0419', '区', 100, 'bai ta qu', 'ux98 ux97 ux105 ux116 ux113 ux117 ux30333 ux22612 ux21306', 0, 0),
(545, 543, '211003', '文圣区', 3, '0419', '区', 100, 'wen sheng qu', 'ux119 ux101 ux110 ux115 ux104 ux103 ux113 ux117 ux25991 ux22307 ux21306', 0, 0),
(546, 543, '211004', '宏伟区', 3, '0419', '区', 100, 'hong wei qu', 'ux104 ux111 ux110 ux103 ux119 ux101 ux105 ux113 ux117 ux23439 ux20255 ux21306', 0, 0),
(547, 543, '211005', '弓长岭区', 3, '0419', '区', 100, 'gong chang ling qu', 'ux103 ux111 ux110 ux99 ux104 ux97 ux108 ux105 ux113 ux117 ux24339 ux38271 ux23725 ux21306', 0, 0),
(548, 543, '211011', '太子河区', 3, '0419', '区', 100, 'tai zi he qu', 'ux116 ux97 ux105 ux122 ux104 ux101 ux113 ux117 ux22826 ux23376 ux27827 ux21306', 0, 0),
(549, 543, '211021', '辽阳县', 3, '0419', '区', 100, 'liao yang xian', 'ux108 ux105 ux97 ux111 ux121 ux110 ux103 ux120 ux36797 ux38451 ux21439', 0, 0),
(550, 543, '211081', '灯塔市', 3, '0419', '区', 100, 'deng ta shi', 'ux100 ux101 ux110 ux103 ux116 ux97 ux115 ux104 ux105 ux28783 ux22612 ux24066', 0, 0),
(551, 464, '211100', '盘锦市', 2, '0427', '市', 100, 'pan jin shi', 'ux112 ux97 ux110 ux106 ux105 ux115 ux104 ux30424 ux38182 ux24066', 0, 0),
(552, 551, '211102', '双台子区', 3, '0427', '区', 100, 'shuang tai zi qu', 'ux115 ux104 ux117 ux97 ux110 ux103 ux116 ux105 ux122 ux113 ux21452 ux21488 ux23376 ux21306', 0, 0),
(553, 551, '211103', '兴隆台区', 3, '0427', '区', 100, 'xing long tai qu', 'ux120 ux105 ux110 ux103 ux108 ux111 ux116 ux97 ux113 ux117 ux20852 ux38534 ux21488 ux21306', 0, 0),
(554, 551, '211121', '大洼县', 3, '0427', '区', 100, 'da wa xian', 'ux100 ux97 ux119 ux120 ux105 ux110 ux22823 ux27964 ux21439', 0, 0),
(555, 551, '211122', '盘山县', 3, '0427', '区', 100, 'pan shan xian', 'ux112 ux97 ux110 ux115 ux104 ux120 ux105 ux30424 ux23665 ux21439', 0, 0),
(556, 464, '211200', '铁岭市', 2, '0410', '市', 100, 'tie ling shi', 'ux116 ux105 ux101 ux108 ux110 ux103 ux115 ux104 ux38081 ux23725 ux24066', 0, 0),
(557, 556, '211202', '银州区', 3, '0410', '区', 100, 'yin zhou qu', 'ux121 ux105 ux110 ux122 ux104 ux111 ux117 ux113 ux38134 ux24030 ux21306', 0, 0),
(558, 556, '211204', '清河区', 3, '0410', '区', 100, 'qing he qu', 'ux113 ux105 ux110 ux103 ux104 ux101 ux117 ux28165 ux27827 ux21306', 0, 0),
(559, 556, '211221', '铁岭县', 3, '0410', '区', 100, 'tie ling xian', 'ux116 ux105 ux101 ux108 ux110 ux103 ux120 ux97 ux38081 ux23725 ux21439', 0, 0),
(560, 556, '211223', '西丰县', 3, '0410', '区', 100, 'xi feng xian', 'ux120 ux105 ux102 ux101 ux110 ux103 ux97 ux35199 ux20016 ux21439', 0, 0),
(561, 556, '211224', '昌图县', 3, '0410', '区', 100, 'chang tu xian', 'ux99 ux104 ux97 ux110 ux103 ux116 ux117 ux120 ux105 ux26124 ux22270 ux21439', 0, 0),
(562, 556, '211281', '调兵山市', 3, '0410', '区', 100, 'diao bing shan shi', 'ux100 ux105 ux97 ux111 ux98 ux110 ux103 ux115 ux104 ux35843 ux20853 ux23665 ux24066', 0, 0),
(563, 556, '211282', '开原市', 3, '0410', '区', 100, 'kai yuan shi', 'ux107 ux97 ux105 ux121 ux117 ux110 ux115 ux104 ux24320 ux21407 ux24066', 0, 0),
(564, 464, '211300', '朝阳市', 2, '0421', '市', 100, 'zhao yang shi', 'ux122 ux104 ux97 ux111 ux121 ux110 ux103 ux115 ux105 ux26397 ux38451 ux24066', 0, 0),
(565, 564, '211302', '双塔区', 3, '0421', '区', 100, 'shuang ta qu', 'ux115 ux104 ux117 ux97 ux110 ux103 ux116 ux113 ux21452 ux22612 ux21306', 0, 0),
(566, 564, '211303', '龙城区', 3, '0421', '区', 100, 'long cheng qu', 'ux108 ux111 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux40857 ux22478 ux21306', 0, 0),
(567, 564, '211321', '朝阳县', 3, '0421', '区', 100, 'zhao yang xian', 'ux122 ux104 ux97 ux111 ux121 ux110 ux103 ux120 ux105 ux26397 ux38451 ux21439', 0, 0),
(568, 564, '211322', '建平县', 3, '0421', '区', 100, 'jian ping xian', 'ux106 ux105 ux97 ux110 ux112 ux103 ux120 ux24314 ux24179 ux21439', 0, 0),
(569, 564, '211324', '喀喇沁左翼蒙古族自治县', 3, '0421', '区', 100, 'ka la qin zuo yi meng gu zu zi zhi xian', 'ux107 ux97 ux108 ux113 ux105 ux110 ux122 ux117 ux111 ux121 ux109 ux101 ux103 ux104 ux120 ux21888 ux21895 ux27777 ux24038 ux32764 ux33945 ux21476 ux26063 ux33258 ux27835 ux21439', 0, 0),
(570, 564, '211381', '北票市', 3, '0421', '区', 100, 'bei piao shi', 'ux98 ux101 ux105 ux112 ux97 ux111 ux115 ux104 ux21271 ux31080 ux24066', 0, 0),
(571, 564, '211382', '凌源市', 3, '0421', '区', 100, 'ling yuan shi', 'ux108 ux105 ux110 ux103 ux121 ux117 ux97 ux115 ux104 ux20940 ux28304 ux24066', 0, 0),
(572, 464, '211400', '葫芦岛市', 2, '0429', '市', 100, 'hu lu dao shi', 'ux104 ux117 ux108 ux100 ux97 ux111 ux115 ux105 ux33899 ux33446 ux23707 ux24066', 0, 0),
(573, 572, '211402', '连山区', 3, '0429', '区', 100, 'lian shan qu', 'ux108 ux105 ux97 ux110 ux115 ux104 ux113 ux117 ux36830 ux23665 ux21306', 0, 0),
(574, 572, '211403', '龙港区', 3, '0429', '区', 100, 'long gang qu', 'ux108 ux111 ux110 ux103 ux97 ux113 ux117 ux40857 ux28207 ux21306', 0, 0),
(575, 572, '211404', '南票区', 3, '0429', '区', 100, 'nan piao qu', 'ux110 ux97 ux112 ux105 ux111 ux113 ux117 ux21335 ux31080 ux21306', 0, 0),
(576, 572, '211421', '绥中县', 3, '0429', '区', 100, 'sui zhong xian', 'ux115 ux117 ux105 ux122 ux104 ux111 ux110 ux103 ux120 ux97 ux32485 ux20013 ux21439', 0, 0),
(577, 572, '211422', '建昌县', 3, '0429', '区', 100, 'jian chang xian', 'ux106 ux105 ux97 ux110 ux99 ux104 ux103 ux120 ux24314 ux26124 ux21439', 0, 0),
(578, 572, '211481', '兴城市', 3, '0429', '区', 100, 'xing cheng shi', 'ux120 ux105 ux110 ux103 ux99 ux104 ux101 ux115 ux20852 ux22478 ux24066', 0, 0),
(579, 0, '220000', '吉林省', 1, '', '省', 100, 'ji lin sheng', 'ux106 ux105 ux108 ux110 ux115 ux104 ux101 ux103 ux21513 ux26519 ux30465', 0, 0),
(580, 579, '220100', '长春市', 2, '0431', '市', 100, 'chang chun shi', 'ux99 ux104 ux97 ux110 ux103 ux117 ux115 ux105 ux38271 ux26149 ux24066', 1, 0),
(581, 580, '220102', '南关区', 3, '0431', '区', 100, 'nan guan qu', 'ux110 ux97 ux103 ux117 ux113 ux21335 ux20851 ux21306', 0, 0),
(582, 580, '220103', '宽城区', 3, '0431', '区', 100, 'kuan cheng qu', 'ux107 ux117 ux97 ux110 ux99 ux104 ux101 ux103 ux113 ux23485 ux22478 ux21306', 0, 0),
(583, 580, '220104', '朝阳区', 3, '0431', '区', 100, 'zhao yang qu', 'ux122 ux104 ux97 ux111 ux121 ux110 ux103 ux113 ux117 ux26397 ux38451 ux21306', 0, 0),
(584, 580, '220105', '二道区', 3, '0431', '区', 100, 'er dao qu', 'ux101 ux114 ux100 ux97 ux111 ux113 ux117 ux20108 ux36947 ux21306', 0, 0),
(585, 580, '220106', '绿园区', 3, '0431', '区', 100, 'lv yuan qu', 'ux108 ux118 ux121 ux117 ux97 ux110 ux113 ux32511 ux22253 ux21306', 0, 0),
(586, 580, '220112', '双阳区', 3, '0431', '区', 100, 'shuang yang qu', 'ux115 ux104 ux117 ux97 ux110 ux103 ux121 ux113 ux21452 ux38451 ux21306', 0, 0),
(587, 580, '220122', '农安县', 3, '0431', '区', 100, 'nong an xian', 'ux110 ux111 ux103 ux97 ux120 ux105 ux20892 ux23433 ux21439', 0, 0),
(588, 580, '220181', '九台市', 3, '0431', '区', 100, 'jiu tai shi', 'ux106 ux105 ux117 ux116 ux97 ux115 ux104 ux20061 ux21488 ux24066', 0, 0),
(589, 580, '220182', '榆树市', 3, '0431', '区', 100, 'yu shu shi', 'ux121 ux117 ux115 ux104 ux105 ux27014 ux26641 ux24066', 0, 0),
(590, 580, '220183', '德惠市', 3, '0431', '区', 100, 'de hui shi', 'ux100 ux101 ux104 ux117 ux105 ux115 ux24503 ux24800 ux24066', 0, 0),
(591, 579, '220200', '吉林市', 2, '0432', '市', 100, 'ji lin shi', 'ux106 ux105 ux108 ux110 ux115 ux104 ux21513 ux26519 ux24066', 0, 0),
(592, 591, '220202', '昌邑区', 3, '0432', '区', 100, 'chang yi qu', 'ux99 ux104 ux97 ux110 ux103 ux121 ux105 ux113 ux117 ux26124 ux37009 ux21306', 0, 0),
(593, 591, '220203', '龙潭区', 3, '0432', '区', 100, 'long tan qu', 'ux108 ux111 ux110 ux103 ux116 ux97 ux113 ux117 ux40857 ux28525 ux21306', 0, 0),
(594, 591, '220204', '船营区', 3, '0432', '区', 100, 'chuan ying qu', 'ux99 ux104 ux117 ux97 ux110 ux121 ux105 ux103 ux113 ux33337 ux33829 ux21306', 0, 0),
(595, 591, '220211', '丰满区', 3, '0432', '区', 100, 'feng man qu', 'ux102 ux101 ux110 ux103 ux109 ux97 ux113 ux117 ux20016 ux28385 ux21306', 0, 0),
(596, 591, '220221', '永吉县', 3, '0432', '区', 100, 'yong ji xian', 'ux121 ux111 ux110 ux103 ux106 ux105 ux120 ux97 ux27704 ux21513 ux21439', 0, 0),
(597, 591, '220281', '蛟河市', 3, '0432', '区', 100, 'jiao he shi', 'ux106 ux105 ux97 ux111 ux104 ux101 ux115 ux34527 ux27827 ux24066', 0, 0),
(598, 591, '220282', '桦甸市', 3, '0432', '区', 100, 'hua dian shi', 'ux104 ux117 ux97 ux100 ux105 ux110 ux115 ux26726 ux30008 ux24066', 0, 0),
(599, 591, '220283', '舒兰市', 3, '0432', '区', 100, 'shu lan shi', 'ux115 ux104 ux117 ux108 ux97 ux110 ux105 ux33298 ux20848 ux24066', 0, 0),
(600, 591, '220284', '磐石市', 3, '0432', '区', 100, 'pan shi shi', 'ux112 ux97 ux110 ux115 ux104 ux105 ux30928 ux30707 ux24066', 0, 0),
(601, 579, '220300', '四平市', 2, '0434', '市', 100, 'si ping shi', 'ux115 ux105 ux112 ux110 ux103 ux104 ux22235 ux24179 ux24066', 0, 0),
(602, 601, '220302', '铁西区', 3, '0434', '区', 100, 'tie xi qu', 'ux116 ux105 ux101 ux120 ux113 ux117 ux38081 ux35199 ux21306', 0, 0),
(603, 601, '220303', '铁东区', 3, '0434', '区', 100, 'tie dong qu', 'ux116 ux105 ux101 ux100 ux111 ux110 ux103 ux113 ux117 ux38081 ux19996 ux21306', 0, 0),
(604, 601, '220322', '梨树县', 3, '0434', '区', 100, 'li shu xian', 'ux108 ux105 ux115 ux104 ux117 ux120 ux97 ux110 ux26792 ux26641 ux21439', 0, 0),
(605, 601, '220323', '伊通满族自治县', 3, '0434', '区', 100, 'yi tong man zu zi zhi xian', 'ux121 ux105 ux116 ux111 ux110 ux103 ux109 ux97 ux122 ux117 ux104 ux120 ux20234 ux36890 ux28385 ux26063 ux33258 ux27835 ux21439', 0, 0),
(606, 601, '220381', '公主岭市', 3, '0434', '区', 100, 'gong zhu ling shi', 'ux103 ux111 ux110 ux122 ux104 ux117 ux108 ux105 ux115 ux20844 ux20027 ux23725 ux24066', 0, 0),
(607, 601, '220382', '双辽市', 3, '0434', '区', 100, 'shuang liao shi', 'ux115 ux104 ux117 ux97 ux110 ux103 ux108 ux105 ux111 ux21452 ux36797 ux24066', 0, 0),
(608, 579, '220400', '辽源市', 2, '0437', '市', 100, 'liao yuan shi', 'ux108 ux105 ux97 ux111 ux121 ux117 ux110 ux115 ux104 ux36797 ux28304 ux24066', 0, 0),
(609, 608, '220402', '龙山区', 3, '0437', '区', 100, 'long shan qu', 'ux108 ux111 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux40857 ux23665 ux21306', 0, 0),
(610, 608, '220403', '西安区', 3, '0437', '区', 100, 'xi an qu', 'ux120 ux105 ux97 ux110 ux113 ux117 ux35199 ux23433 ux21306', 0, 0),
(611, 608, '220421', '东丰县', 3, '0437', '区', 100, 'dong feng xian', 'ux100 ux111 ux110 ux103 ux102 ux101 ux120 ux105 ux97 ux19996 ux20016 ux21439', 0, 0),
(612, 608, '220422', '东辽县', 3, '0437', '区', 100, 'dong liao xian', 'ux100 ux111 ux110 ux103 ux108 ux105 ux97 ux120 ux19996 ux36797 ux21439', 0, 0),
(613, 579, '220500', '通化市', 2, '0435', '市', 100, 'tong hua shi', 'ux116 ux111 ux110 ux103 ux104 ux117 ux97 ux115 ux105 ux36890 ux21270 ux24066', 0, 0),
(614, 613, '220502', '东昌区', 3, '0435', '区', 100, 'dong chang qu', 'ux100 ux111 ux110 ux103 ux99 ux104 ux97 ux113 ux117 ux19996 ux26124 ux21306', 0, 0),
(615, 613, '220503', '二道江区', 3, '0435', '区', 100, 'er dao jiang qu', 'ux101 ux114 ux100 ux97 ux111 ux106 ux105 ux110 ux103 ux113 ux117 ux20108 ux36947 ux27743 ux21306', 0, 0),
(616, 613, '220521', '通化县', 3, '0435', '区', 100, 'tong hua xian', 'ux116 ux111 ux110 ux103 ux104 ux117 ux97 ux120 ux105 ux36890 ux21270 ux21439', 0, 0),
(617, 613, '220523', '辉南县', 3, '0435', '区', 100, 'hui nan xian', 'ux104 ux117 ux105 ux110 ux97 ux120 ux36745 ux21335 ux21439', 0, 0),
(618, 613, '220524', '柳河县', 3, '0435', '区', 100, 'liu he xian', 'ux108 ux105 ux117 ux104 ux101 ux120 ux97 ux110 ux26611 ux27827 ux21439', 0, 0),
(619, 613, '220581', '梅河口市', 3, '0435', '区', 100, 'mei he kou shi', 'ux109 ux101 ux105 ux104 ux107 ux111 ux117 ux115 ux26757 ux27827 ux21475 ux24066', 0, 0),
(620, 613, '220582', '集安市', 3, '0435', '区', 100, 'ji an shi', 'ux106 ux105 ux97 ux110 ux115 ux104 ux38598 ux23433 ux24066', 0, 0),
(621, 579, '220600', '白山市', 2, '0439', '市', 100, 'bai shan shi', 'ux98 ux97 ux105 ux115 ux104 ux110 ux30333 ux23665 ux24066', 0, 0),
(622, 621, '220602', '浑江区', 3, '0439', '区', 100, 'hun jiang qu', 'ux104 ux117 ux110 ux106 ux105 ux97 ux103 ux113 ux27985 ux27743 ux21306', 0, 0),
(623, 621, '220605', '江源区', 3, '0439', '区', 100, 'jiang yuan qu', 'ux106 ux105 ux97 ux110 ux103 ux121 ux117 ux113 ux27743 ux28304 ux21306', 0, 0),
(624, 621, '220621', '抚松县', 3, '0439', '区', 100, 'fu song xian', 'ux102 ux117 ux115 ux111 ux110 ux103 ux120 ux105 ux97 ux25242 ux26494 ux21439', 0, 0),
(625, 621, '220622', '靖宇县', 3, '0439', '区', 100, 'jing yu xian', 'ux106 ux105 ux110 ux103 ux121 ux117 ux120 ux97 ux38742 ux23431 ux21439', 0, 0),
(626, 621, '220623', '长白朝鲜族自治县', 3, '0439', '区', 100, 'chang bai zhao xian zu zi zhi xian', 'ux99 ux104 ux97 ux110 ux103 ux98 ux105 ux122 ux111 ux120 ux117 ux38271 ux30333 ux26397 ux40092 ux26063 ux33258 ux27835 ux21439', 0, 0),
(627, 621, '220681', '临江市', 3, '0439', '区', 100, 'lin jiang shi', 'ux108 ux105 ux110 ux106 ux97 ux103 ux115 ux104 ux20020 ux27743 ux24066', 0, 0),
(628, 579, '220700', '松原市', 2, '0438', '市', 100, 'song yuan shi', 'ux115 ux111 ux110 ux103 ux121 ux117 ux97 ux104 ux105 ux26494 ux21407 ux24066', 0, 0),
(629, 628, '220702', '宁江区', 3, '0438', '区', 100, 'ning jiang qu', 'ux110 ux105 ux103 ux106 ux97 ux113 ux117 ux23425 ux27743 ux21306', 0, 0),
(630, 628, '220721', '前郭尔罗斯蒙古族自治县', 3, '0438', '区', 100, 'qian guo er luo si meng gu zu zi zhi xian', 'ux113 ux105 ux97 ux110 ux103 ux117 ux111 ux101 ux114 ux108 ux115 ux109 ux122 ux104 ux120 ux21069 ux37101 ux23572 ux32599 ux26031 ux33945 ux21476 ux26063 ux33258 ux27835 ux21439', 0, 0),
(631, 628, '220722', '长岭县', 3, '0438', '区', 100, 'chang ling xian', 'ux99 ux104 ux97 ux110 ux103 ux108 ux105 ux120 ux38271 ux23725 ux21439', 0, 0),
(632, 628, '220723', '乾安县', 3, '0438', '区', 100, 'qian an xian', 'ux113 ux105 ux97 ux110 ux120 ux20094 ux23433 ux21439', 0, 0),
(633, 628, '220724', '扶余县', 3, '0438', '区', 100, 'fu yu xian', 'ux102 ux117 ux121 ux120 ux105 ux97 ux110 ux25206 ux20313 ux21439', 0, 0),
(634, 579, '220800', '白城市', 2, '0436', '市', 100, 'bai cheng shi', 'ux98 ux97 ux105 ux99 ux104 ux101 ux110 ux103 ux115 ux30333 ux22478 ux24066', 0, 0),
(635, 634, '220802', '洮北区', 3, '0436', '区', 100, 'tao bei qu', 'ux116 ux97 ux111 ux98 ux101 ux105 ux113 ux117 ux27950 ux21271 ux21306', 0, 0),
(636, 634, '220821', '镇赉县', 3, '0436', '区', 100, 'zhen lai xian', 'ux122 ux104 ux101 ux110 ux108 ux97 ux105 ux120 ux38215 ux36169 ux21439', 0, 0),
(637, 634, '220822', '通榆县', 3, '0436', '区', 100, 'tong yu xian', 'ux116 ux111 ux110 ux103 ux121 ux117 ux120 ux105 ux97 ux36890 ux27014 ux21439', 0, 0),
(638, 634, '220881', '洮南市', 3, '0436', '区', 100, 'tao nan shi', 'ux116 ux97 ux111 ux110 ux115 ux104 ux105 ux27950 ux21335 ux24066', 0, 0),
(639, 634, '220882', '大安市', 3, '0436', '区', 100, 'da an shi', 'ux100 ux97 ux110 ux115 ux104 ux105 ux22823 ux23433 ux24066', 0, 0),
(640, 579, '222400', '延边朝鲜族自治州', 2, '0433', '市', 100, 'yan bian zhao xian zu zi zhi zhou', 'ux121 ux97 ux110 ux98 ux105 ux122 ux104 ux111 ux120 ux117 ux24310 ux36793 ux26397 ux40092 ux26063 ux33258 ux27835 ux24030', 0, 0),
(641, 640, '222401', '延吉市', 3, '0433', '区', 100, 'yan ji shi', 'ux121 ux97 ux110 ux106 ux105 ux115 ux104 ux24310 ux21513 ux24066', 0, 0),
(642, 640, '222402', '图们市', 3, '0433', '区', 100, 'tu men shi', 'ux116 ux117 ux109 ux101 ux110 ux115 ux104 ux105 ux22270 ux20204 ux24066', 0, 0),
(643, 640, '222403', '敦化市', 3, '0433', '区', 100, 'dun hua shi', 'ux100 ux117 ux110 ux104 ux97 ux115 ux105 ux25958 ux21270 ux24066', 0, 0),
(644, 640, '222404', '珲春市', 3, '0440', '区', 100, 'hun chun shi', 'ux104 ux117 ux110 ux99 ux115 ux105 ux29682 ux26149 ux24066', 0, 0),
(645, 640, '222405', '龙井市', 3, '0433', '区', 100, 'long jing shi', 'ux108 ux111 ux110 ux103 ux106 ux105 ux115 ux104 ux40857 ux20117 ux24066', 0, 0),
(646, 640, '222406', '和龙市', 3, '0433', '区', 100, 'he long shi', 'ux104 ux101 ux108 ux111 ux110 ux103 ux115 ux105 ux21644 ux40857 ux24066', 0, 0),
(647, 640, '222424', '汪清县', 3, '0433', '区', 100, 'wang qing xian', 'ux119 ux97 ux110 ux103 ux113 ux105 ux120 ux27754 ux28165 ux21439', 0, 0),
(648, 640, '222426', '安图县', 3, '0433', '区', 100, 'an tu xian', 'ux97 ux110 ux116 ux117 ux120 ux105 ux23433 ux22270 ux21439', 0, 0),
(649, 0, '230000', '黑龙江省', 1, '', '省', 100, 'hei long jiang sheng', 'ux104 ux101 ux105 ux108 ux111 ux110 ux103 ux106 ux97 ux115 ux40657 ux40857 ux27743 ux30465', 0, 0),
(650, 649, '230100', '哈尔滨市', 2, '0451', '市', 100, 'ha er bin shi', 'ux104 ux97 ux101 ux114 ux98 ux105 ux110 ux115 ux21704 ux23572 ux28392 ux24066', 0, 0),
(651, 650, '230102', '道里区', 3, '0451', '区', 100, 'dao li qu', 'ux100 ux97 ux111 ux108 ux105 ux113 ux117 ux36947 ux37324 ux21306', 0, 0),
(652, 650, '230103', '南岗区', 3, '0451', '区', 100, 'nan gang qu', 'ux110 ux97 ux103 ux113 ux117 ux21335 ux23703 ux21306', 0, 0),
(653, 650, '230104', '道外区', 3, '0451', '区', 100, 'dao wai qu', 'ux100 ux97 ux111 ux119 ux105 ux113 ux117 ux36947 ux22806 ux21306', 0, 0),
(654, 650, '230108', '平房区', 3, '0451', '区', 100, 'ping fang qu', 'ux112 ux105 ux110 ux103 ux102 ux97 ux113 ux117 ux24179 ux25151 ux21306', 0, 0),
(655, 650, '230109', '松北区', 3, '0451', '区', 100, 'song bei qu', 'ux115 ux111 ux110 ux103 ux98 ux101 ux105 ux113 ux117 ux26494 ux21271 ux21306', 0, 0),
(656, 650, '230110', '香坊区', 3, '0451', '区', 100, 'xiang fang qu', 'ux120 ux105 ux97 ux110 ux103 ux102 ux113 ux117 ux39321 ux22346 ux21306', 0, 0),
(657, 650, '230111', '呼兰区', 3, '0451', '区', 100, 'hu lan qu', 'ux104 ux117 ux108 ux97 ux110 ux113 ux21628 ux20848 ux21306', 0, 0),
(658, 650, '230112', '阿城区', 3, '0451', '区', 100, 'a cheng qu', 'ux97 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux38463 ux22478 ux21306', 0, 0),
(659, 650, '230123', '依兰县', 3, '0451', '区', 100, 'yi lan xian', 'ux121 ux105 ux108 ux97 ux110 ux120 ux20381 ux20848 ux21439', 0, 0),
(660, 650, '230124', '方正县', 3, '0451', '区', 100, 'fang zheng xian', 'ux102 ux97 ux110 ux103 ux122 ux104 ux101 ux120 ux105 ux26041 ux27491 ux21439', 0, 0),
(661, 650, '230125', '宾县', 3, '0451', '区', 100, 'bin xian', 'ux98 ux105 ux110 ux120 ux97 ux23486 ux21439', 0, 0),
(662, 650, '230126', '巴彦县', 3, '0451', '区', 100, 'ba yan xian', 'ux98 ux97 ux121 ux110 ux120 ux105 ux24052 ux24422 ux21439', 0, 0),
(663, 650, '230127', '木兰县', 3, '0451', '区', 100, 'mu lan xian', 'ux109 ux117 ux108 ux97 ux110 ux120 ux105 ux26408 ux20848 ux21439', 0, 0),
(664, 650, '230128', '通河县', 3, '0451', '区', 100, 'tong he xian', 'ux116 ux111 ux110 ux103 ux104 ux101 ux120 ux105 ux97 ux36890 ux27827 ux21439', 0, 0),
(665, 650, '230129', '延寿县', 3, '0451', '区', 100, 'yan shou xian', 'ux121 ux97 ux110 ux115 ux104 ux111 ux117 ux120 ux105 ux24310 ux23551 ux21439', 0, 0),
(666, 650, '230182', '双城市', 3, '0451', '区', 100, 'shuang cheng shi', 'ux115 ux104 ux117 ux97 ux110 ux103 ux99 ux101 ux105 ux21452 ux22478 ux24066', 0, 0),
(667, 650, '230183', '尚志市', 3, '0451', '区', 100, 'shang zhi shi', 'ux115 ux104 ux97 ux110 ux103 ux122 ux105 ux23578 ux24535 ux24066', 0, 0),
(668, 650, '230184', '五常市', 3, '0451', '区', 100, 'wu chang shi', 'ux119 ux117 ux99 ux104 ux97 ux110 ux103 ux115 ux105 ux20116 ux24120 ux24066', 0, 0),
(669, 649, '230200', '齐齐哈尔市', 2, '0452', '市', 100, 'qi qi ha er shi', 'ux113 ux105 ux104 ux97 ux101 ux114 ux115 ux40784 ux21704 ux23572 ux24066', 0, 0),
(670, 669, '230202', '龙沙区', 3, '0452', '区', 100, 'long sha qu', 'ux108 ux111 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux40857 ux27801 ux21306', 0, 0),
(671, 669, '230203', '建华区', 3, '0452', '区', 100, 'jian hua qu', 'ux106 ux105 ux97 ux110 ux104 ux117 ux113 ux24314 ux21326 ux21306', 0, 0),
(672, 669, '230204', '铁锋区', 3, '0452', '区', 100, 'tie feng qu', 'ux116 ux105 ux101 ux102 ux110 ux103 ux113 ux117 ux38081 ux38155 ux21306', 0, 0),
(673, 669, '230205', '昂昂溪区', 3, '0452', '区', 100, 'ang ang xi qu', 'ux97 ux110 ux103 ux120 ux105 ux113 ux117 ux26114 ux28330 ux21306', 0, 0),
(674, 669, '230206', '富拉尔基区', 3, '0452', '区', 100, 'fu la er ji qu', 'ux102 ux117 ux108 ux97 ux101 ux114 ux106 ux105 ux113 ux23500 ux25289 ux23572 ux22522 ux21306', 0, 0),
(675, 669, '230207', '碾子山区', 3, '0452', '区', 100, 'nian zi shan qu', 'ux110 ux105 ux97 ux122 ux115 ux104 ux113 ux117 ux30910 ux23376 ux23665 ux21306', 0, 0),
(676, 669, '230208', '梅里斯达斡尔族区', 3, '0452', '区', 100, 'mei li si da wo er zu qu', 'ux109 ux101 ux105 ux108 ux115 ux100 ux97 ux119 ux111 ux114 ux122 ux117 ux113 ux26757 ux37324 ux26031 ux36798 ux26017 ux23572 ux26063 ux21306', 0, 0),
(677, 669, '230221', '龙江县', 3, '0452', '区', 100, 'long jiang xian', 'ux108 ux111 ux110 ux103 ux106 ux105 ux97 ux120 ux40857 ux27743 ux21439', 0, 0),
(678, 669, '230223', '依安县', 3, '0452', '区', 100, 'yi an xian', 'ux121 ux105 ux97 ux110 ux120 ux20381 ux23433 ux21439', 0, 0),
(679, 669, '230224', '泰来县', 3, '0452', '区', 100, 'tai lai xian', 'ux116 ux97 ux105 ux108 ux120 ux110 ux27888 ux26469 ux21439', 0, 0),
(680, 669, '230225', '甘南县', 3, '0452', '区', 100, 'gan nan xian', 'ux103 ux97 ux110 ux120 ux105 ux29976 ux21335 ux21439', 0, 0),
(681, 669, '230227', '富裕县', 3, '0452', '区', 100, 'fu yu xian', 'ux102 ux117 ux121 ux120 ux105 ux97 ux110 ux23500 ux35029 ux21439', 0, 0),
(682, 669, '230229', '克山县', 3, '0452', '区', 100, 'ke shan xian', 'ux107 ux101 ux115 ux104 ux97 ux110 ux120 ux105 ux20811 ux23665 ux21439', 0, 0),
(683, 669, '230230', '克东县', 3, '0452', '区', 100, 'ke dong xian', 'ux107 ux101 ux100 ux111 ux110 ux103 ux120 ux105 ux97 ux20811 ux19996 ux21439', 0, 0),
(684, 669, '230231', '拜泉县', 3, '0452', '区', 100, 'bai quan xian', 'ux98 ux97 ux105 ux113 ux117 ux110 ux120 ux25308 ux27849 ux21439', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(685, 669, '230281', '讷河市', 3, '0452', '区', 100, 'ne he shi', 'ux110 ux101 ux104 ux115 ux105 ux35767 ux27827 ux24066', 0, 0),
(686, 649, '230300', '鸡西市', 2, '0467', '市', 100, 'ji xi shi', 'ux106 ux105 ux120 ux115 ux104 ux40481 ux35199 ux24066', 0, 0),
(687, 686, '230302', '鸡冠区', 3, '0467', '区', 100, 'ji guan qu', 'ux106 ux105 ux103 ux117 ux97 ux110 ux113 ux40481 ux20896 ux21306', 0, 0),
(688, 686, '230303', '恒山区', 3, '0467', '区', 100, 'heng shan qu', 'ux104 ux101 ux110 ux103 ux115 ux97 ux113 ux117 ux24658 ux23665 ux21306', 0, 0),
(689, 686, '230304', '滴道区', 3, '0467', '区', 100, 'di dao qu', 'ux100 ux105 ux97 ux111 ux113 ux117 ux28404 ux36947 ux21306', 0, 0),
(690, 686, '230305', '梨树区', 3, '0467', '区', 100, 'li shu qu', 'ux108 ux105 ux115 ux104 ux117 ux113 ux26792 ux26641 ux21306', 0, 0),
(691, 686, '230306', '城子河区', 3, '0467', '区', 100, 'cheng zi he qu', 'ux99 ux104 ux101 ux110 ux103 ux122 ux105 ux113 ux117 ux22478 ux23376 ux27827 ux21306', 0, 0),
(692, 686, '230307', '麻山区', 3, '0467', '区', 100, 'ma shan qu', 'ux109 ux97 ux115 ux104 ux110 ux113 ux117 ux40635 ux23665 ux21306', 0, 0),
(693, 686, '230321', '鸡东县', 3, '0467', '区', 100, 'ji dong xian', 'ux106 ux105 ux100 ux111 ux110 ux103 ux120 ux97 ux40481 ux19996 ux21439', 0, 0),
(694, 686, '230381', '虎林市', 3, '0467', '区', 100, 'hu lin shi', 'ux104 ux117 ux108 ux105 ux110 ux115 ux34382 ux26519 ux24066', 0, 0),
(695, 686, '230382', '密山市', 3, '0467', '区', 100, 'mi shan shi', 'ux109 ux105 ux115 ux104 ux97 ux110 ux23494 ux23665 ux24066', 0, 0),
(696, 649, '230400', '鹤岗市', 2, '0468', '市', 100, 'he gang shi', 'ux104 ux101 ux103 ux97 ux110 ux115 ux105 ux40548 ux23703 ux24066', 0, 0),
(697, 696, '230402', '向阳区', 3, '0468', '区', 100, 'xiang yang qu', 'ux120 ux105 ux97 ux110 ux103 ux121 ux113 ux117 ux21521 ux38451 ux21306', 0, 0),
(698, 696, '230403', '工农区', 3, '0468', '区', 100, 'gong nong qu', 'ux103 ux111 ux110 ux113 ux117 ux24037 ux20892 ux21306', 0, 0),
(699, 696, '230404', '南山区', 3, '0468', '区', 100, 'nan shan qu', 'ux110 ux97 ux115 ux104 ux113 ux117 ux21335 ux23665 ux21306', 0, 0),
(700, 696, '230405', '兴安区', 3, '0468', '区', 100, 'xing an qu', 'ux120 ux105 ux110 ux103 ux97 ux113 ux117 ux20852 ux23433 ux21306', 0, 0),
(701, 696, '230406', '东山区', 3, '0468', '区', 100, 'dong shan qu', 'ux100 ux111 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux19996 ux23665 ux21306', 0, 0),
(702, 696, '230407', '兴山区', 3, '0468', '区', 100, 'xing shan qu', 'ux120 ux105 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux20852 ux23665 ux21306', 0, 0),
(703, 696, '230421', '萝北县', 3, '0468', '区', 100, 'luo bei xian', 'ux108 ux117 ux111 ux98 ux101 ux105 ux120 ux97 ux110 ux33821 ux21271 ux21439', 0, 0),
(704, 696, '230422', '绥滨县', 3, '0468', '区', 100, 'sui bin xian', 'ux115 ux117 ux105 ux98 ux110 ux120 ux97 ux32485 ux28392 ux21439', 0, 0),
(705, 649, '230500', '双鸭山市', 2, '0469', '市', 100, 'shuang ya shan shi', 'ux115 ux104 ux117 ux97 ux110 ux103 ux121 ux105 ux21452 ux40493 ux23665 ux24066', 0, 0),
(706, 705, '230502', '尖山区', 3, '0469', '区', 100, 'jian shan qu', 'ux106 ux105 ux97 ux110 ux115 ux104 ux113 ux117 ux23574 ux23665 ux21306', 0, 0),
(707, 705, '230503', '岭东区', 3, '0469', '区', 100, 'ling dong qu', 'ux108 ux105 ux110 ux103 ux100 ux111 ux113 ux117 ux23725 ux19996 ux21306', 0, 0),
(708, 705, '230505', '四方台区', 3, '0469', '区', 100, 'si fang tai qu', 'ux115 ux105 ux102 ux97 ux110 ux103 ux116 ux113 ux117 ux22235 ux26041 ux21488 ux21306', 0, 0),
(709, 705, '230506', '宝山区', 3, '0469', '区', 100, 'bao shan qu', 'ux98 ux97 ux111 ux115 ux104 ux110 ux113 ux117 ux23453 ux23665 ux21306', 0, 0),
(710, 705, '230521', '集贤县', 3, '0469', '区', 100, 'ji xian xian', 'ux106 ux105 ux120 ux97 ux110 ux38598 ux36132 ux21439', 0, 0),
(711, 705, '230522', '友谊县', 3, '0469', '区', 100, 'you yi xian', 'ux121 ux111 ux117 ux105 ux120 ux97 ux110 ux21451 ux35850 ux21439', 0, 0),
(712, 705, '230523', '宝清县', 3, '0469', '区', 100, 'bao qing xian', 'ux98 ux97 ux111 ux113 ux105 ux110 ux103 ux120 ux23453 ux28165 ux21439', 0, 0),
(713, 705, '230524', '饶河县', 3, '0469', '区', 100, 'rao he xian', 'ux114 ux97 ux111 ux104 ux101 ux120 ux105 ux110 ux39286 ux27827 ux21439', 0, 0),
(714, 649, '230600', '大庆市', 2, '0459', '市', 100, 'da qing shi', 'ux100 ux97 ux113 ux105 ux110 ux103 ux115 ux104 ux22823 ux24198 ux24066', 0, 0),
(715, 714, '230602', '萨尔图区', 3, '0459', '区', 100, 'sa er tu qu', 'ux115 ux97 ux101 ux114 ux116 ux117 ux113 ux33832 ux23572 ux22270 ux21306', 0, 0),
(716, 714, '230603', '龙凤区', 3, '0459', '区', 100, 'long feng qu', 'ux108 ux111 ux110 ux103 ux102 ux101 ux113 ux117 ux40857 ux20964 ux21306', 0, 0),
(717, 714, '230604', '让胡路区', 3, '0459', '区', 100, 'rang hu lu qu', 'ux114 ux97 ux110 ux103 ux104 ux117 ux108 ux113 ux35753 ux32993 ux36335 ux21306', 0, 0),
(718, 714, '230605', '红岗区', 3, '0459', '区', 100, 'hong gang qu', 'ux104 ux111 ux110 ux103 ux97 ux113 ux117 ux32418 ux23703 ux21306', 0, 0),
(719, 714, '230606', '大同区', 3, '0459', '区', 100, 'da tong qu', 'ux100 ux97 ux116 ux111 ux110 ux103 ux113 ux117 ux22823 ux21516 ux21306', 0, 0),
(720, 714, '230621', '肇州县', 3, '0459', '区', 100, 'zhao zhou xian', 'ux122 ux104 ux97 ux111 ux117 ux120 ux105 ux110 ux32903 ux24030 ux21439', 0, 0),
(721, 714, '230622', '肇源县', 3, '0459', '区', 100, 'zhao yuan xian', 'ux122 ux104 ux97 ux111 ux121 ux117 ux110 ux120 ux105 ux32903 ux28304 ux21439', 0, 0),
(722, 714, '230623', '林甸县', 3, '0459', '区', 100, 'lin dian xian', 'ux108 ux105 ux110 ux100 ux97 ux120 ux26519 ux30008 ux21439', 0, 0),
(723, 714, '230624', '杜尔伯特蒙古族自治县', 3, '0459', '区', 100, 'du er bo te meng gu zu zi zhi xian', 'ux100 ux117 ux101 ux114 ux98 ux111 ux116 ux109 ux110 ux103 ux122 ux105 ux104 ux120 ux97 ux26460 ux23572 ux20271 ux29305 ux33945 ux21476 ux26063 ux33258 ux27835 ux21439', 0, 0),
(724, 649, '230700', '伊春市', 2, '0458', '市', 100, 'yi chun shi', 'ux121 ux105 ux99 ux104 ux117 ux110 ux115 ux20234 ux26149 ux24066', 0, 0),
(725, 724, '230702', '伊春区', 3, '0458', '区', 100, 'yi chun qu', 'ux121 ux105 ux99 ux104 ux117 ux110 ux113 ux20234 ux26149 ux21306', 0, 0),
(726, 724, '230703', '南岔区', 3, '0458', '区', 100, 'nan cha qu', 'ux110 ux97 ux99 ux104 ux113 ux117 ux21335 ux23700 ux21306', 0, 0),
(727, 724, '230704', '友好区', 3, '0458', '区', 100, 'you hao qu', 'ux121 ux111 ux117 ux104 ux97 ux113 ux21451 ux22909 ux21306', 0, 0),
(728, 724, '230705', '西林区', 3, '0458', '区', 100, 'xi lin qu', 'ux120 ux105 ux108 ux110 ux113 ux117 ux35199 ux26519 ux21306', 0, 0),
(729, 724, '230706', '翠峦区', 3, '0458', '区', 100, 'cui luan qu', 'ux99 ux117 ux105 ux108 ux97 ux110 ux113 ux32736 ux23782 ux21306', 0, 0),
(730, 724, '230707', '新青区', 3, '0458', '区', 100, 'xin qing qu', 'ux120 ux105 ux110 ux113 ux103 ux117 ux26032 ux38738 ux21306', 0, 0),
(731, 724, '230708', '美溪区', 3, '0458', '区', 100, 'mei xi qu', 'ux109 ux101 ux105 ux120 ux113 ux117 ux32654 ux28330 ux21306', 0, 0),
(732, 724, '230709', '金山屯区', 3, '0458', '区', 100, 'jin shan tun qu', 'ux106 ux105 ux110 ux115 ux104 ux97 ux116 ux117 ux113 ux37329 ux23665 ux23663 ux21306', 0, 0),
(733, 724, '230710', '五营区', 3, '0458', '区', 100, 'wu ying qu', 'ux119 ux117 ux121 ux105 ux110 ux103 ux113 ux20116 ux33829 ux21306', 0, 0),
(734, 724, '230711', '乌马河区', 3, '0458', '区', 100, 'wu ma he qu', 'ux119 ux117 ux109 ux97 ux104 ux101 ux113 ux20044 ux39532 ux27827 ux21306', 0, 0),
(735, 724, '230712', '汤旺河区', 3, '0458', '区', 100, 'tang wang he qu', 'ux116 ux97 ux110 ux103 ux119 ux104 ux101 ux113 ux117 ux27748 ux26106 ux27827 ux21306', 0, 0),
(736, 724, '230713', '带岭区', 3, '0458', '区', 100, 'dai ling qu', 'ux100 ux97 ux105 ux108 ux110 ux103 ux113 ux117 ux24102 ux23725 ux21306', 0, 0),
(737, 724, '230714', '乌伊岭区', 3, '0458', '区', 100, 'wu yi ling qu', 'ux119 ux117 ux121 ux105 ux108 ux110 ux103 ux113 ux20044 ux20234 ux23725 ux21306', 0, 0),
(738, 724, '230715', '红星区', 3, '0458', '区', 100, 'hong xing qu', 'ux104 ux111 ux110 ux103 ux120 ux105 ux113 ux117 ux32418 ux26143 ux21306', 0, 0),
(739, 724, '230716', '上甘岭区', 3, '0458', '区', 100, 'shang gan ling qu', 'ux115 ux104 ux97 ux110 ux103 ux108 ux105 ux113 ux117 ux19978 ux29976 ux23725 ux21306', 0, 0),
(740, 724, '230722', '嘉荫县', 3, '0458', '区', 100, 'jia yin xian', 'ux106 ux105 ux97 ux121 ux110 ux120 ux22025 ux33643 ux21439', 0, 0),
(741, 724, '230781', '铁力市', 3, '0458', '区', 100, 'tie li shi', 'ux116 ux105 ux101 ux108 ux115 ux104 ux38081 ux21147 ux24066', 0, 0),
(742, 649, '230800', '佳木斯市', 2, '0454', '市', 100, 'jia mu si shi', 'ux106 ux105 ux97 ux109 ux117 ux115 ux104 ux20339 ux26408 ux26031 ux24066', 0, 0),
(743, 742, '230803', '向阳区', 3, '0454', '区', 100, 'xiang yang qu', 'ux120 ux105 ux97 ux110 ux103 ux121 ux113 ux117 ux21521 ux38451 ux21306', 0, 0),
(744, 742, '230804', '前进区', 3, '0454', '区', 100, 'qian jin qu', 'ux113 ux105 ux97 ux110 ux106 ux117 ux21069 ux36827 ux21306', 0, 0),
(745, 742, '230805', '东风区', 3, '0454', '区', 100, 'dong feng qu', 'ux100 ux111 ux110 ux103 ux102 ux101 ux113 ux117 ux19996 ux39118 ux21306', 0, 0),
(746, 742, '230811', '郊区', 3, '0454', '区', 100, 'jiao qu', 'ux106 ux105 ux97 ux111 ux113 ux117 ux37066 ux21306', 0, 0),
(747, 742, '230822', '桦南县', 3, '0454', '区', 100, 'hua nan xian', 'ux104 ux117 ux97 ux110 ux120 ux105 ux26726 ux21335 ux21439', 0, 0),
(748, 742, '230826', '桦川县', 3, '0454', '区', 100, 'hua chuan xian', 'ux104 ux117 ux97 ux99 ux110 ux120 ux105 ux26726 ux24029 ux21439', 0, 0),
(749, 742, '230828', '汤原县', 3, '0454', '区', 100, 'tang yuan xian', 'ux116 ux97 ux110 ux103 ux121 ux117 ux120 ux105 ux27748 ux21407 ux21439', 0, 0),
(750, 742, '230833', '抚远县', 3, '0454', '区', 100, 'fu yuan xian', 'ux102 ux117 ux121 ux97 ux110 ux120 ux105 ux25242 ux36828 ux21439', 0, 0),
(751, 742, '230881', '同江市', 3, '0454', '区', 100, 'tong jiang shi', 'ux116 ux111 ux110 ux103 ux106 ux105 ux97 ux115 ux104 ux21516 ux27743 ux24066', 0, 0),
(752, 742, '230882', '富锦市', 3, '0454', '区', 100, 'fu jin shi', 'ux102 ux117 ux106 ux105 ux110 ux115 ux104 ux23500 ux38182 ux24066', 0, 0),
(753, 649, '230900', '七台河市', 2, '0464', '市', 100, 'qi tai he shi', 'ux113 ux105 ux116 ux97 ux104 ux101 ux115 ux19971 ux21488 ux27827 ux24066', 0, 0),
(754, 753, '230902', '新兴区', 3, '0464', '区', 100, 'xin xing qu', 'ux120 ux105 ux110 ux103 ux113 ux117 ux26032 ux20852 ux21306', 0, 0),
(755, 753, '230903', '桃山区', 3, '0464', '区', 100, 'tao shan qu', 'ux116 ux97 ux111 ux115 ux104 ux110 ux113 ux117 ux26691 ux23665 ux21306', 0, 0),
(756, 753, '230904', '茄子河区', 3, '0464', '区', 100, 'qie zi he qu', 'ux113 ux105 ux101 ux122 ux104 ux117 ux33540 ux23376 ux27827 ux21306', 0, 0),
(757, 753, '230921', '勃利县', 3, '0464', '区', 100, 'bo li xian', 'ux98 ux111 ux108 ux105 ux120 ux97 ux110 ux21187 ux21033 ux21439', 0, 0),
(758, 649, '231000', '牡丹江市', 2, '0453', '市', 100, 'mu dan jiang shi', 'ux109 ux117 ux100 ux97 ux110 ux106 ux105 ux103 ux115 ux104 ux29281 ux20025 ux27743 ux24066', 0, 0),
(759, 758, '231002', '东安区', 3, '0453', '区', 100, 'dong an qu', 'ux100 ux111 ux110 ux103 ux97 ux113 ux117 ux19996 ux23433 ux21306', 0, 0),
(760, 758, '231003', '阳明区', 3, '0453', '区', 100, 'yang ming qu', 'ux121 ux97 ux110 ux103 ux109 ux105 ux113 ux117 ux38451 ux26126 ux21306', 0, 0),
(761, 758, '231004', '爱民区', 3, '0453', '区', 100, 'ai min qu', 'ux97 ux105 ux109 ux110 ux113 ux117 ux29233 ux27665 ux21306', 0, 0),
(762, 758, '231005', '西安区', 3, '0453', '区', 100, 'xi an qu', 'ux120 ux105 ux97 ux110 ux113 ux117 ux35199 ux23433 ux21306', 0, 0),
(763, 758, '231024', '东宁县', 3, '0453', '区', 100, 'dong ning xian', 'ux100 ux111 ux110 ux103 ux105 ux120 ux97 ux19996 ux23425 ux21439', 0, 0),
(764, 758, '231025', '林口县', 3, '0453', '区', 100, 'lin kou xian', 'ux108 ux105 ux110 ux107 ux111 ux117 ux120 ux97 ux26519 ux21475 ux21439', 0, 0),
(765, 758, '231081', '绥芬河市', 3, '0453', '区', 100, 'sui fen he shi', 'ux115 ux117 ux105 ux102 ux101 ux110 ux104 ux32485 ux33452 ux27827 ux24066', 0, 0),
(766, 758, '231083', '海林市', 3, '0453', '区', 100, 'hai lin shi', 'ux104 ux97 ux105 ux108 ux110 ux115 ux28023 ux26519 ux24066', 0, 0),
(767, 758, '231084', '宁安市', 3, '0453', '区', 100, 'ning an shi', 'ux110 ux105 ux103 ux97 ux115 ux104 ux23425 ux23433 ux24066', 0, 0),
(768, 758, '231085', '穆棱市', 3, '0453', '区', 100, 'mu leng shi', 'ux109 ux117 ux108 ux101 ux110 ux103 ux115 ux104 ux105 ux31302 ux26865 ux24066', 0, 0),
(769, 649, '231100', '黑河市', 2, '0456', '市', 100, 'hei he shi', 'ux104 ux101 ux105 ux115 ux40657 ux27827 ux24066', 0, 0),
(770, 769, '231102', '爱辉区', 3, '0456', '区', 100, 'ai hui qu', 'ux97 ux105 ux104 ux117 ux113 ux29233 ux36745 ux21306', 0, 0),
(771, 769, '231121', '嫩江县', 3, '0456', '区', 100, 'nen jiang xian', 'ux110 ux101 ux106 ux105 ux97 ux103 ux120 ux23273 ux27743 ux21439', 0, 0),
(772, 769, '231123', '逊克县', 3, '0456', '区', 100, 'xun ke xian', 'ux120 ux117 ux110 ux107 ux101 ux105 ux97 ux36874 ux20811 ux21439', 0, 0),
(773, 769, '231124', '孙吴县', 3, '0456', '区', 100, 'sun wu xian', 'ux115 ux117 ux110 ux119 ux120 ux105 ux97 ux23385 ux21556 ux21439', 0, 0),
(774, 769, '231181', '北安市', 3, '0456', '区', 100, 'bei an shi', 'ux98 ux101 ux105 ux97 ux110 ux115 ux104 ux21271 ux23433 ux24066', 0, 0),
(775, 769, '231182', '五大连池市', 3, '0456', '区', 100, 'wu da lian chi shi', 'ux119 ux117 ux100 ux97 ux108 ux105 ux110 ux99 ux104 ux115 ux20116 ux22823 ux36830 ux27744 ux24066', 0, 0),
(776, 649, '231200', '绥化市', 2, '0455', '市', 100, 'sui hua shi', 'ux115 ux117 ux105 ux104 ux97 ux32485 ux21270 ux24066', 0, 0),
(777, 776, '231202', '北林区', 3, '0455', '区', 100, 'bei lin qu', 'ux98 ux101 ux105 ux108 ux110 ux113 ux117 ux21271 ux26519 ux21306', 0, 0),
(778, 776, '231221', '望奎县', 3, '0455', '区', 100, 'wang kui xian', 'ux119 ux97 ux110 ux103 ux107 ux117 ux105 ux120 ux26395 ux22862 ux21439', 0, 0),
(779, 776, '231222', '兰西县', 3, '0455', '区', 100, 'lan xi xian', 'ux108 ux97 ux110 ux120 ux105 ux20848 ux35199 ux21439', 0, 0),
(780, 776, '231223', '青冈县', 3, '0455', '区', 100, 'qing gang xian', 'ux113 ux105 ux110 ux103 ux97 ux120 ux38738 ux20872 ux21439', 0, 0),
(781, 776, '231224', '庆安县', 3, '0455', '区', 100, 'qing an xian', 'ux113 ux105 ux110 ux103 ux97 ux120 ux24198 ux23433 ux21439', 0, 0),
(782, 776, '231225', '明水县', 3, '0455', '区', 100, 'ming shui xian', 'ux109 ux105 ux110 ux103 ux115 ux104 ux117 ux120 ux97 ux26126 ux27700 ux21439', 0, 0),
(783, 776, '231226', '绥棱县', 3, '0455', '区', 100, 'sui leng xian', 'ux115 ux117 ux105 ux108 ux101 ux110 ux103 ux120 ux97 ux32485 ux26865 ux21439', 0, 0),
(784, 776, '231281', '安达市', 3, '0455', '区', 100, 'an da shi', 'ux97 ux110 ux100 ux115 ux104 ux105 ux23433 ux36798 ux24066', 0, 0),
(785, 776, '231282', '肇东市', 3, '0455', '区', 100, 'zhao dong shi', 'ux122 ux104 ux97 ux111 ux100 ux110 ux103 ux115 ux105 ux32903 ux19996 ux24066', 0, 0),
(786, 776, '231283', '海伦市', 3, '0455', '区', 100, 'hai lun shi', 'ux104 ux97 ux105 ux108 ux117 ux110 ux115 ux28023 ux20262 ux24066', 0, 0),
(787, 649, '232700', '大兴安岭地区', 2, '0457', '市', 100, 'da xing an ling di qu', 'ux100 ux97 ux120 ux105 ux110 ux103 ux108 ux113 ux117 ux22823 ux20852 ux23433 ux23725 ux22320 ux21306', 0, 0),
(788, 787, '232701', '加格达奇区', 3, '0457', '区', 100, 'jia ge da qi qu', 'ux106 ux105 ux97 ux103 ux101 ux100 ux113 ux117 ux21152 ux26684 ux36798 ux22855 ux21306', 0, 0),
(789, 787, '232702', '松岭区', 3, '0457', '区', 100, 'song ling qu', 'ux115 ux111 ux110 ux103 ux108 ux105 ux113 ux117 ux26494 ux23725 ux21306', 0, 0),
(790, 787, '232703', '新林区', 3, '0457', '区', 100, 'xin lin qu', 'ux120 ux105 ux110 ux108 ux113 ux117 ux26032 ux26519 ux21306', 0, 0),
(791, 787, '232704', '呼中区', 3, '0457', '区', 100, 'hu zhong qu', 'ux104 ux117 ux122 ux111 ux110 ux103 ux113 ux21628 ux20013 ux21306', 0, 0),
(792, 787, '232721', '呼玛县', 3, '0457', '区', 100, 'hu ma xian', 'ux104 ux117 ux109 ux97 ux120 ux105 ux110 ux21628 ux29595 ux21439', 0, 0),
(793, 787, '232722', '塔河县', 3, '0457', '区', 100, 'ta he xian', 'ux116 ux97 ux104 ux101 ux120 ux105 ux110 ux22612 ux27827 ux21439', 0, 0),
(794, 787, '232723', '漠河县', 3, '0457', '区', 100, 'mo he xian', 'ux109 ux111 ux104 ux101 ux120 ux105 ux97 ux110 ux28448 ux27827 ux21439', 0, 0),
(795, 0, '310000', '上海市', 1, '021', '市', 100, 'shang hai shi', 'ux115 ux104 ux97 ux110 ux103 ux105 ux19978 ux28023 ux24066', 0, 0),
(796, 795, '310101', '黄浦区', 2, '021', '区', 100, 'huang pu qu', 'ux104 ux117 ux97 ux110 ux103 ux112 ux113 ux40644 ux28006 ux21306', 0, 0),
(797, 795, '310104', '徐汇区', 2, '021', '区', 100, 'xu hui qu', 'ux120 ux117 ux104 ux105 ux113 ux24464 ux27719 ux21306', 0, 0),
(798, 795, '310105', '长宁区', 2, '021', '区', 100, 'chang ning qu', 'ux99 ux104 ux97 ux110 ux103 ux105 ux113 ux117 ux38271 ux23425 ux21306', 0, 0),
(799, 795, '310106', '静安区', 2, '021', '区', 100, 'jing an qu', 'ux106 ux105 ux110 ux103 ux97 ux113 ux117 ux38745 ux23433 ux21306', 0, 0),
(800, 795, '310107', '普陀区', 2, '021', '区', 100, 'pu tuo qu', 'ux112 ux117 ux116 ux111 ux113 ux26222 ux38464 ux21306', 0, 0),
(801, 795, '310108', '闸北区', 2, '021', '区', 100, 'zha bei qu', 'ux122 ux104 ux97 ux98 ux101 ux105 ux113 ux117 ux38392 ux21271 ux21306', 0, 0),
(802, 795, '310109', '虹口区', 2, '021', '区', 100, 'hong kou qu', 'ux104 ux111 ux110 ux103 ux107 ux117 ux113 ux34425 ux21475 ux21306', 0, 0),
(803, 795, '310110', '杨浦区', 2, '021', '区', 100, 'yang pu qu', 'ux121 ux97 ux110 ux103 ux112 ux117 ux113 ux26472 ux28006 ux21306', 0, 0),
(804, 795, '310112', '闵行区', 2, '021', '区', 100, 'min xing qu', 'ux109 ux105 ux110 ux120 ux103 ux113 ux117 ux38389 ux34892 ux21306', 0, 0),
(805, 795, '310113', '宝山区', 2, '021', '区', 100, 'bao shan qu', 'ux98 ux97 ux111 ux115 ux104 ux110 ux113 ux117 ux23453 ux23665 ux21306', 0, 0),
(806, 795, '310114', '嘉定区', 2, '021', '区', 100, 'jia ding qu', 'ux106 ux105 ux97 ux100 ux110 ux103 ux113 ux117 ux22025 ux23450 ux21306', 0, 0),
(807, 795, '310115', '浦东新区', 2, '021', '区', 100, 'pu dong xin qu', 'ux112 ux117 ux100 ux111 ux110 ux103 ux120 ux105 ux113 ux28006 ux19996 ux26032 ux21306', 0, 0),
(808, 795, '310116', '金山区', 2, '021', '区', 100, 'jin shan qu', 'ux106 ux105 ux110 ux115 ux104 ux97 ux113 ux117 ux37329 ux23665 ux21306', 0, 0),
(809, 795, '310117', '松江区', 2, '021', '区', 100, 'song jiang qu', 'ux115 ux111 ux110 ux103 ux106 ux105 ux97 ux113 ux117 ux26494 ux27743 ux21306', 0, 0),
(810, 795, '310118', '青浦区', 2, '021', '区', 100, 'qing pu qu', 'ux113 ux105 ux110 ux103 ux112 ux117 ux38738 ux28006 ux21306', 0, 0),
(811, 795, '310120', '奉贤区', 2, '021', '区', 100, 'feng xian qu', 'ux102 ux101 ux110 ux103 ux120 ux105 ux97 ux113 ux117 ux22857 ux36132 ux21306', 0, 0),
(812, 795, '310230', '崇明县', 2, '021', '区', 100, 'chong ming xian', 'ux99 ux104 ux111 ux110 ux103 ux109 ux105 ux120 ux97 ux23815 ux26126 ux21439', 0, 0),
(813, 0, '320000', '江苏省', 1, '', '省', 100, 'jiang su sheng', 'ux106 ux105 ux97 ux110 ux103 ux115 ux117 ux104 ux101 ux27743 ux33487 ux30465', 0, 0),
(814, 813, '320100', '南京市', 2, '025', '市', 100, 'nan jing shi', 'ux110 ux97 ux106 ux105 ux103 ux115 ux104 ux21335 ux20140 ux24066', 0, 0),
(815, 814, '320102', '玄武区', 3, '025', '区', 100, 'xuan wu qu', 'ux120 ux117 ux97 ux110 ux119 ux113 ux29572 ux27494 ux21306', 0, 0),
(816, 814, '320103', '白下区', 3, '025', '区', 100, 'bai xia qu', 'ux98 ux97 ux105 ux120 ux113 ux117 ux30333 ux19979 ux21306', 0, 0),
(817, 814, '320104', '秦淮区', 3, '025', '区', 100, 'qin huai qu', 'ux113 ux105 ux110 ux104 ux117 ux97 ux31206 ux28142 ux21306', 0, 0),
(818, 814, '320105', '建邺区', 3, '025', '区', 100, 'jian ye qu', 'ux106 ux105 ux97 ux110 ux121 ux101 ux113 ux117 ux24314 ux37050 ux21306', 0, 0),
(819, 814, '320106', '鼓楼区', 3, '025', '区', 100, 'gu lou qu', 'ux103 ux117 ux108 ux111 ux113 ux40723 ux27004 ux21306', 0, 0),
(820, 814, '320107', '下关区', 3, '025', '区', 100, 'xia guan qu', 'ux120 ux105 ux97 ux103 ux117 ux110 ux113 ux19979 ux20851 ux21306', 0, 0),
(821, 814, '320111', '浦口区', 3, '025', '区', 100, 'pu kou qu', 'ux112 ux117 ux107 ux111 ux113 ux28006 ux21475 ux21306', 0, 0),
(822, 814, '320113', '栖霞区', 3, '025', '区', 100, 'qi xia qu', 'ux113 ux105 ux120 ux97 ux117 ux26646 ux38686 ux21306', 0, 0),
(823, 814, '320114', '雨花台区', 3, '025', '区', 100, 'yu hua tai qu', 'ux121 ux117 ux104 ux97 ux116 ux105 ux113 ux38632 ux33457 ux21488 ux21306', 0, 0),
(824, 814, '320115', '江宁区', 3, '025', '区', 100, 'jiang ning qu', 'ux106 ux105 ux97 ux110 ux103 ux113 ux117 ux27743 ux23425 ux21306', 0, 0),
(825, 814, '320116', '六合区', 3, '025', '区', 100, 'liu he qu', 'ux108 ux105 ux117 ux104 ux101 ux113 ux20845 ux21512 ux21306', 0, 0),
(826, 814, '320124', '溧水县', 3, '025', '区', 100, 'li shui xian', 'ux108 ux105 ux115 ux104 ux117 ux120 ux97 ux110 ux28327 ux27700 ux21439', 0, 0),
(827, 814, '320125', '高淳县', 3, '025', '区', 100, 'gao chun xian', 'ux103 ux97 ux111 ux99 ux104 ux117 ux110 ux120 ux105 ux39640 ux28147 ux21439', 0, 0),
(828, 813, '320200', '无锡市', 2, '0510', '市', 100, 'wu xi shi', 'ux119 ux117 ux120 ux105 ux115 ux104 ux26080 ux38177 ux24066', 0, 0),
(829, 828, '320202', '崇安区', 3, '0510', '区', 100, 'chong an qu', 'ux99 ux104 ux111 ux110 ux103 ux97 ux113 ux117 ux23815 ux23433 ux21306', 0, 0),
(830, 828, '320203', '南长区', 3, '0510', '区', 100, 'nan chang qu', 'ux110 ux97 ux99 ux104 ux103 ux113 ux117 ux21335 ux38271 ux21306', 0, 0),
(831, 828, '320204', '北塘区', 3, '0510', '区', 100, 'bei tang qu', 'ux98 ux101 ux105 ux116 ux97 ux110 ux103 ux113 ux117 ux21271 ux22616 ux21306', 0, 0),
(832, 828, '320205', '锡山区', 3, '0510', '区', 100, 'xi shan qu', 'ux120 ux105 ux115 ux104 ux97 ux110 ux113 ux117 ux38177 ux23665 ux21306', 0, 0),
(833, 828, '320206', '惠山区', 3, '0510', '区', 100, 'hui shan qu', 'ux104 ux117 ux105 ux115 ux97 ux110 ux113 ux24800 ux23665 ux21306', 0, 0),
(834, 828, '320211', '滨湖区', 3, '0510', '区', 100, 'bin hu qu', 'ux98 ux105 ux110 ux104 ux117 ux113 ux28392 ux28246 ux21306', 0, 0),
(835, 828, '320281', '江阴市', 3, '0510', '区', 100, 'jiang yin shi', 'ux106 ux105 ux97 ux110 ux103 ux121 ux115 ux104 ux27743 ux38452 ux24066', 0, 0),
(836, 828, '320282', '宜兴市', 3, '0510', '区', 100, 'yi xing shi', 'ux121 ux105 ux120 ux110 ux103 ux115 ux104 ux23452 ux20852 ux24066', 0, 0),
(837, 813, '320300', '徐州市', 2, '0516', '市', 100, 'xu zhou shi', 'ux120 ux117 ux122 ux104 ux111 ux115 ux105 ux24464 ux24030 ux24066', 0, 0),
(838, 837, '320302', '鼓楼区', 3, '0516', '区', 100, 'gu lou qu', 'ux103 ux117 ux108 ux111 ux113 ux40723 ux27004 ux21306', 0, 0),
(839, 837, '320303', '云龙区', 3, '0516', '区', 100, 'yun long qu', 'ux121 ux117 ux110 ux108 ux111 ux103 ux113 ux20113 ux40857 ux21306', 0, 0),
(840, 837, '320305', '贾汪区', 3, '0516', '区', 100, 'jia wang qu', 'ux106 ux105 ux97 ux119 ux110 ux103 ux113 ux117 ux36158 ux27754 ux21306', 0, 0),
(841, 837, '320311', '泉山区', 3, '0516', '区', 100, 'quan shan qu', 'ux113 ux117 ux97 ux110 ux115 ux104 ux27849 ux23665 ux21306', 0, 0),
(842, 837, '320312', '铜山区', 3, '0516', '区', 100, 'tong shan qu', 'ux116 ux111 ux110 ux103 ux115 ux104 ux97 ux113 ux117 ux38108 ux23665 ux21306', 0, 0),
(843, 837, '320321', '丰县', 3, '0516', '区', 100, 'feng xian', 'ux102 ux101 ux110 ux103 ux120 ux105 ux97 ux20016 ux21439', 0, 0),
(844, 837, '320322', '沛县', 3, '0516', '区', 100, 'pei xian', 'ux112 ux101 ux105 ux120 ux97 ux110 ux27803 ux21439', 0, 0),
(845, 837, '320324', '睢宁县', 3, '0516', '区', 100, 'sui ning xian', 'ux115 ux117 ux105 ux110 ux103 ux120 ux97 ux30562 ux23425 ux21439', 0, 0),
(846, 837, '320381', '新沂市', 3, '0516', '区', 100, 'xin yi shi', 'ux120 ux105 ux110 ux121 ux115 ux104 ux26032 ux27778 ux24066', 0, 0),
(847, 837, '320382', '邳州市', 3, '0516', '区', 100, 'pi zhou shi', 'ux112 ux105 ux122 ux104 ux111 ux117 ux115 ux37043 ux24030 ux24066', 0, 0),
(848, 813, '320400', '常州市', 2, '0519', '市', 100, 'chang zhou shi', 'ux99 ux104 ux97 ux110 ux103 ux122 ux111 ux117 ux115 ux105 ux24120 ux24030 ux24066', 0, 0),
(849, 848, '320402', '天宁区', 3, '0519', '区', 100, 'tian ning qu', 'ux116 ux105 ux97 ux110 ux103 ux113 ux117 ux22825 ux23425 ux21306', 0, 0),
(850, 848, '320404', '钟楼区', 3, '0519', '区', 100, 'zhong lou qu', 'ux122 ux104 ux111 ux110 ux103 ux108 ux117 ux113 ux38047 ux27004 ux21306', 0, 0),
(851, 848, '320405', '戚墅堰区', 3, '0519', '区', 100, 'qi shu yan qu', 'ux113 ux105 ux115 ux104 ux117 ux121 ux97 ux110 ux25114 ux22661 ux22576 ux21306', 0, 0),
(852, 848, '320411', '新北区', 3, '0519', '区', 100, 'xin bei qu', 'ux120 ux105 ux110 ux98 ux101 ux113 ux117 ux26032 ux21271 ux21306', 0, 0),
(853, 848, '320412', '武进区', 3, '0519', '区', 100, 'wu jin qu', 'ux119 ux117 ux106 ux105 ux110 ux113 ux27494 ux36827 ux21306', 0, 0),
(854, 848, '320481', '溧阳市', 3, '0519', '区', 100, 'li yang shi', 'ux108 ux105 ux121 ux97 ux110 ux103 ux115 ux104 ux28327 ux38451 ux24066', 0, 0),
(855, 848, '320482', '金坛市', 3, '0519', '区', 100, 'jin tan shi', 'ux106 ux105 ux110 ux116 ux97 ux115 ux104 ux37329 ux22363 ux24066', 0, 0),
(856, 813, '320500', '苏州市', 2, '0512', '市', 100, 'su zhou shi', 'ux115 ux117 ux122 ux104 ux111 ux105 ux33487 ux24030 ux24066', 0, 0),
(857, 856, '320503', '姑苏区', 3, '0512', '区', 100, 'gu su qu', 'ux103 ux117 ux115 ux113 ux22993 ux33487 ux21306', 0, 0),
(858, 856, '320505', '虎丘区', 3, '0512', '区', 100, 'hu qiu qu', 'ux104 ux117 ux113 ux105 ux34382 ux19992 ux21306', 0, 0),
(859, 856, '320506', '吴中区', 3, '0512', '区', 100, 'wu zhong qu', 'ux119 ux117 ux122 ux104 ux111 ux110 ux103 ux113 ux21556 ux20013 ux21306', 0, 0),
(860, 856, '320507', '相城区', 3, '0512', '区', 100, 'xiang cheng qu', 'ux120 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux30456 ux22478 ux21306', 0, 0),
(861, 856, '320581', '常熟市', 3, '0512', '区', 100, 'chang shu shi', 'ux99 ux104 ux97 ux110 ux103 ux115 ux117 ux105 ux24120 ux29087 ux24066', 0, 0),
(862, 856, '320582', '张家港市', 3, '0512', '区', 100, 'zhang jia gang shi', 'ux122 ux104 ux97 ux110 ux103 ux106 ux105 ux115 ux24352 ux23478 ux28207 ux24066', 0, 0),
(863, 856, '320583', '昆山市', 3, '0512', '区', 100, 'kun shan shi', 'ux107 ux117 ux110 ux115 ux104 ux97 ux105 ux26118 ux23665 ux24066', 0, 0),
(864, 856, '320584', '吴江区', 3, '0512', '区', 100, 'wu jiang qu', 'ux119 ux117 ux106 ux105 ux97 ux110 ux103 ux113 ux21556 ux27743 ux21306', 0, 0),
(865, 856, '320585', '太仓市', 3, '0512', '区', 100, 'tai cang shi', 'ux116 ux97 ux105 ux99 ux110 ux103 ux115 ux104 ux22826 ux20179 ux24066', 0, 0),
(866, 813, '320600', '南通市', 2, '0513', '市', 100, 'nan tong shi', 'ux110 ux97 ux116 ux111 ux103 ux115 ux104 ux105 ux21335 ux36890 ux24066', 0, 0),
(867, 866, '320602', '崇川区', 3, '0513', '区', 100, 'chong chuan qu', 'ux99 ux104 ux111 ux110 ux103 ux117 ux97 ux113 ux23815 ux24029 ux21306', 0, 0),
(868, 866, '320611', '港闸区', 3, '0513', '区', 100, 'gang zha qu', 'ux103 ux97 ux110 ux122 ux104 ux113 ux117 ux28207 ux38392 ux21306', 0, 0),
(869, 866, '320612', '通州区', 3, '0513', '区', 100, 'tong zhou qu', 'ux116 ux111 ux110 ux103 ux122 ux104 ux117 ux113 ux36890 ux24030 ux21306', 0, 0),
(870, 866, '320621', '海安县', 3, '0513', '区', 100, 'hai an xian', 'ux104 ux97 ux105 ux110 ux120 ux28023 ux23433 ux21439', 0, 0),
(871, 866, '320623', '如东县', 3, '0513', '区', 100, 'ru dong xian', 'ux114 ux117 ux100 ux111 ux110 ux103 ux120 ux105 ux97 ux22914 ux19996 ux21439', 0, 0),
(872, 866, '320681', '启东市', 3, '0513', '区', 100, 'qi dong shi', 'ux113 ux105 ux100 ux111 ux110 ux103 ux115 ux104 ux21551 ux19996 ux24066', 0, 0),
(873, 866, '320682', '如皋市', 3, '0513', '区', 100, 'ru gao shi', 'ux114 ux117 ux103 ux97 ux111 ux115 ux104 ux105 ux22914 ux30347 ux24066', 0, 0),
(874, 866, '320684', '海门市', 3, '0513', '区', 100, 'hai men shi', 'ux104 ux97 ux105 ux109 ux101 ux110 ux115 ux28023 ux38376 ux24066', 0, 0),
(875, 813, '320700', '连云港市', 2, '0518', '市', 100, 'lian yun gang shi', 'ux108 ux105 ux97 ux110 ux121 ux117 ux103 ux115 ux104 ux36830 ux20113 ux28207 ux24066', 0, 0),
(876, 875, '320703', '连云区', 3, '0518', '区', 100, 'lian yun qu', 'ux108 ux105 ux97 ux110 ux121 ux117 ux113 ux36830 ux20113 ux21306', 0, 0),
(877, 875, '320705', '新浦区', 3, '0518', '区', 100, 'xin pu qu', 'ux120 ux105 ux110 ux112 ux117 ux113 ux26032 ux28006 ux21306', 0, 0),
(878, 875, '320706', '海州区', 3, '0518', '区', 100, 'hai zhou qu', 'ux104 ux97 ux105 ux122 ux111 ux117 ux113 ux28023 ux24030 ux21306', 0, 0),
(879, 875, '320721', '赣榆县', 3, '0518', '区', 100, 'gan yu xian', 'ux103 ux97 ux110 ux121 ux117 ux120 ux105 ux36195 ux27014 ux21439', 0, 0),
(880, 875, '320722', '东海县', 3, '0518', '区', 100, 'dong hai xian', 'ux100 ux111 ux110 ux103 ux104 ux97 ux105 ux120 ux19996 ux28023 ux21439', 0, 0),
(881, 875, '320723', '灌云县', 3, '0518', '区', 100, 'guan yun xian', 'ux103 ux117 ux97 ux110 ux121 ux120 ux105 ux28748 ux20113 ux21439', 0, 0),
(882, 875, '320724', '灌南县', 3, '0518', '区', 100, 'guan nan xian', 'ux103 ux117 ux97 ux110 ux120 ux105 ux28748 ux21335 ux21439', 0, 0),
(883, 813, '320800', '淮安市', 2, '0517', '市', 100, 'huai an shi', 'ux104 ux117 ux97 ux105 ux110 ux115 ux28142 ux23433 ux24066', 0, 0),
(884, 883, '320802', '清河区', 3, '0517', '区', 100, 'qing he qu', 'ux113 ux105 ux110 ux103 ux104 ux101 ux117 ux28165 ux27827 ux21306', 0, 0),
(885, 883, '320803', '淮安区', 3, '0517', '区', 100, 'huai an qu', 'ux104 ux117 ux97 ux105 ux110 ux113 ux28142 ux23433 ux21306', 0, 0),
(886, 883, '320804', '淮阴区', 3, '0517', '区', 100, 'huai yin qu', 'ux104 ux117 ux97 ux105 ux121 ux110 ux113 ux28142 ux38452 ux21306', 0, 0),
(887, 883, '320811', '青浦区', 3, '0517', '区', 100, 'qing pu qu', 'ux113 ux105 ux110 ux103 ux112 ux117 ux38738 ux28006 ux21306', 0, 0),
(888, 883, '320826', '涟水县', 3, '0517', '区', 100, 'lian shui xian', 'ux108 ux105 ux97 ux110 ux115 ux104 ux117 ux120 ux28063 ux27700 ux21439', 0, 0),
(889, 883, '320829', '洪泽县', 3, '0517', '区', 100, 'hong ze xian', 'ux104 ux111 ux110 ux103 ux122 ux101 ux120 ux105 ux97 ux27946 ux27901 ux21439', 0, 0),
(890, 883, '320830', '盱眙县', 3, '0517', '区', 100, 'xu yi xian', 'ux120 ux117 ux121 ux105 ux97 ux110 ux30449 ux30489 ux21439', 0, 0),
(891, 883, '320831', '金湖县', 3, '0517', '区', 100, 'jin hu xian', 'ux106 ux105 ux110 ux104 ux117 ux120 ux97 ux37329 ux28246 ux21439', 0, 0),
(892, 813, '320900', '盐城市', 2, '0515', '市', 100, 'yan cheng shi', 'ux121 ux97 ux110 ux99 ux104 ux101 ux103 ux115 ux105 ux30416 ux22478 ux24066', 0, 0),
(893, 892, '320902', '亭湖区', 3, '0515', '区', 100, 'ting hu qu', 'ux116 ux105 ux110 ux103 ux104 ux117 ux113 ux20141 ux28246 ux21306', 0, 0),
(894, 892, '320903', '盐都区', 3, '0515', '区', 100, 'yan du qu', 'ux121 ux97 ux110 ux100 ux117 ux113 ux30416 ux37117 ux21306', 0, 0),
(895, 892, '320921', '响水县', 3, '0515', '区', 100, 'xiang shui xian', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux117 ux21709 ux27700 ux21439', 0, 0),
(896, 892, '320922', '滨海县', 3, '0515', '区', 100, 'bin hai xian', 'ux98 ux105 ux110 ux104 ux97 ux120 ux28392 ux28023 ux21439', 0, 0),
(897, 892, '320923', '阜宁县', 3, '0515', '区', 100, 'fu ning xian', 'ux102 ux117 ux110 ux105 ux103 ux120 ux97 ux38428 ux23425 ux21439', 0, 0),
(898, 892, '320924', '射阳县', 3, '0515', '区', 100, 'she yang xian', 'ux115 ux104 ux101 ux121 ux97 ux110 ux103 ux120 ux105 ux23556 ux38451 ux21439', 0, 0),
(899, 892, '320925', '建湖县', 3, '0515', '区', 100, 'jian hu xian', 'ux106 ux105 ux97 ux110 ux104 ux117 ux120 ux24314 ux28246 ux21439', 0, 0),
(900, 892, '320981', '东台市', 3, '0515', '区', 100, 'dong tai shi', 'ux100 ux111 ux110 ux103 ux116 ux97 ux105 ux115 ux104 ux19996 ux21488 ux24066', 0, 0),
(901, 892, '320982', '大丰市', 3, '0515', '区', 100, 'da feng shi', 'ux100 ux97 ux102 ux101 ux110 ux103 ux115 ux104 ux105 ux22823 ux20016 ux24066', 0, 0),
(902, 813, '321000', '扬州市', 2, '0514', '市', 100, 'yang zhou shi', 'ux121 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux105 ux25196 ux24030 ux24066', 0, 0),
(903, 902, '321002', '广陵区', 3, '0514', '区', 100, 'guang ling qu', 'ux103 ux117 ux97 ux110 ux108 ux105 ux113 ux24191 ux38517 ux21306', 0, 0),
(904, 902, '321003', '邗江区', 3, '0514', '区', 100, 'han jiang qu', 'ux104 ux97 ux110 ux106 ux105 ux103 ux113 ux117 ux37015 ux27743 ux21306', 0, 0),
(905, 902, '321023', '宝应县', 3, '0514', '区', 100, 'bao ying xian', 'ux98 ux97 ux111 ux121 ux105 ux110 ux103 ux120 ux23453 ux24212 ux21439', 0, 0),
(906, 902, '321081', '仪征市', 3, '0514', '区', 100, 'yi zheng shi', 'ux121 ux105 ux122 ux104 ux101 ux110 ux103 ux115 ux20202 ux24449 ux24066', 0, 0),
(907, 902, '321084', '高邮市', 3, '0514', '区', 100, 'gao you shi', 'ux103 ux97 ux111 ux121 ux117 ux115 ux104 ux105 ux39640 ux37038 ux24066', 0, 0),
(908, 902, '321088', '江都市', 3, '0514', '区', 100, 'jiang du shi', 'ux106 ux105 ux97 ux110 ux103 ux100 ux117 ux115 ux104 ux27743 ux37117 ux24066', 0, 0),
(909, 813, '321100', '镇江市', 2, '0511', '市', 100, 'zhen jiang shi', 'ux122 ux104 ux101 ux110 ux106 ux105 ux97 ux103 ux115 ux38215 ux27743 ux24066', 0, 0),
(910, 909, '321102', '京口区', 3, '0511', '区', 100, 'jing kou qu', 'ux106 ux105 ux110 ux103 ux107 ux111 ux117 ux113 ux20140 ux21475 ux21306', 0, 0),
(911, 909, '321111', '润州区', 3, '0511', '区', 100, 'run zhou qu', 'ux114 ux117 ux110 ux122 ux104 ux111 ux113 ux28070 ux24030 ux21306', 0, 0),
(912, 909, '321112', '丹徒区', 3, '0511', '区', 100, 'dan tu qu', 'ux100 ux97 ux110 ux116 ux117 ux113 ux20025 ux24466 ux21306', 0, 0),
(913, 909, '321181', '丹阳市', 3, '0511', '区', 100, 'dan yang shi', 'ux100 ux97 ux110 ux121 ux103 ux115 ux104 ux105 ux20025 ux38451 ux24066', 0, 0),
(914, 909, '321182', '扬中市', 3, '0511', '区', 100, 'yang zhong shi', 'ux121 ux97 ux110 ux103 ux122 ux104 ux111 ux115 ux105 ux25196 ux20013 ux24066', 0, 0),
(915, 909, '321183', '句容市', 3, '0511', '区', 100, 'ju rong shi', 'ux106 ux117 ux114 ux111 ux110 ux103 ux115 ux104 ux105 ux21477 ux23481 ux24066', 0, 0),
(916, 813, '321200', '泰州市', 2, '0523', '市', 100, 'tai zhou shi', 'ux116 ux97 ux105 ux122 ux104 ux111 ux117 ux115 ux27888 ux24030 ux24066', 0, 0),
(917, 916, '321202', '海陵区', 3, '0523', '区', 100, 'hai ling qu', 'ux104 ux97 ux105 ux108 ux110 ux103 ux113 ux117 ux28023 ux38517 ux21306', 0, 0),
(918, 916, '321203', '高港区', 3, '0523', '区', 100, 'gao gang qu', 'ux103 ux97 ux111 ux110 ux113 ux117 ux39640 ux28207 ux21306', 0, 0),
(919, 916, '321281', '兴化市', 3, '0523', '区', 100, 'xing hua shi', 'ux120 ux105 ux110 ux103 ux104 ux117 ux97 ux115 ux20852 ux21270 ux24066', 0, 0),
(920, 916, '321282', '靖江市', 3, '0523', '区', 100, 'jing jiang shi', 'ux106 ux105 ux110 ux103 ux97 ux115 ux104 ux38742 ux27743 ux24066', 0, 0),
(921, 916, '321283', '泰兴市', 3, '0523', '区', 100, 'tai xing shi', 'ux116 ux97 ux105 ux120 ux110 ux103 ux115 ux104 ux27888 ux20852 ux24066', 0, 0),
(922, 916, '321284', '姜堰市', 3, '0523', '区', 100, 'jiang yan shi', 'ux106 ux105 ux97 ux110 ux103 ux121 ux115 ux104 ux23004 ux22576 ux24066', 0, 0),
(923, 813, '321300', '宿迁市', 2, '0527', '市', 100, 'su qian shi', 'ux115 ux117 ux113 ux105 ux97 ux110 ux104 ux23487 ux36801 ux24066', 0, 0),
(924, 923, '321302', '宿城区', 3, '0527', '区', 100, 'su cheng qu', 'ux115 ux117 ux99 ux104 ux101 ux110 ux103 ux113 ux23487 ux22478 ux21306', 0, 0),
(925, 923, '321311', '宿豫区', 3, '0527', '区', 100, 'su yu qu', 'ux115 ux117 ux121 ux113 ux23487 ux35947 ux21306', 0, 0),
(926, 923, '321322', '沭阳县', 3, '0527', '区', 100, 'shu yang xian', 'ux115 ux104 ux117 ux121 ux97 ux110 ux103 ux120 ux105 ux27821 ux38451 ux21439', 0, 0),
(927, 923, '321323', '泗阳县', 3, '0527', '区', 100, 'si yang xian', 'ux115 ux105 ux121 ux97 ux110 ux103 ux120 ux27863 ux38451 ux21439', 0, 0),
(928, 923, '321324', '泗洪县', 3, '0527', '区', 100, 'si hong xian', 'ux115 ux105 ux104 ux111 ux110 ux103 ux120 ux97 ux27863 ux27946 ux21439', 0, 0),
(929, 0, '330000', '浙江省', 1, '', '省', 100, 'zhe jiang sheng', 'ux122 ux104 ux101 ux106 ux105 ux97 ux110 ux103 ux115 ux27993 ux27743 ux30465', 0, 0),
(930, 929, '330100', '杭州市', 2, '0571', '市', 100, 'hang zhou shi', 'ux104 ux97 ux110 ux103 ux122 ux111 ux117 ux115 ux105 ux26477 ux24030 ux24066', 0, 0),
(931, 930, '330102', '上城区', 3, '0571', '区', 100, 'shang cheng qu', 'ux115 ux104 ux97 ux110 ux103 ux99 ux101 ux113 ux117 ux19978 ux22478 ux21306', 0, 0),
(932, 930, '330103', '下城区', 3, '0571', '区', 100, 'xia cheng qu', 'ux120 ux105 ux97 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux19979 ux22478 ux21306', 0, 0),
(933, 930, '330104', '江干区', 3, '0571', '区', 100, 'jiang gan qu', 'ux106 ux105 ux97 ux110 ux103 ux113 ux117 ux27743 ux24178 ux21306', 0, 0),
(934, 930, '330105', '拱墅区', 3, '0571', '区', 100, 'gong shu qu', 'ux103 ux111 ux110 ux115 ux104 ux117 ux113 ux25329 ux22661 ux21306', 0, 0),
(935, 930, '330106', '西湖区', 3, '0571', '区', 100, 'xi hu qu', 'ux120 ux105 ux104 ux117 ux113 ux35199 ux28246 ux21306', 0, 0),
(936, 930, '330108', '滨江区', 3, '0571', '区', 100, 'bin jiang qu', 'ux98 ux105 ux110 ux106 ux97 ux103 ux113 ux117 ux28392 ux27743 ux21306', 0, 0),
(937, 930, '330109', '萧山区', 3, '0571', '区', 100, 'xiao shan qu', 'ux120 ux105 ux97 ux111 ux115 ux104 ux110 ux113 ux117 ux33831 ux23665 ux21306', 0, 0),
(938, 930, '330110', '余杭区', 3, '0571', '区', 100, 'yu hang qu', 'ux121 ux117 ux104 ux97 ux110 ux103 ux113 ux20313 ux26477 ux21306', 0, 0),
(939, 930, '330122', '桐庐县', 3, '0571', '区', 100, 'tong lu xian', 'ux116 ux111 ux110 ux103 ux108 ux117 ux120 ux105 ux97 ux26704 ux24208 ux21439', 0, 0),
(940, 930, '330127', '淳安县', 3, '0571', '区', 100, 'chun an xian', 'ux99 ux104 ux117 ux110 ux97 ux120 ux105 ux28147 ux23433 ux21439', 0, 0),
(941, 930, '330182', '建德市', 3, '0571', '区', 100, 'jian de shi', 'ux106 ux105 ux97 ux110 ux100 ux101 ux115 ux104 ux24314 ux24503 ux24066', 0, 0),
(942, 930, '330183', '富阳市', 3, '0571', '区', 100, 'fu yang shi', 'ux102 ux117 ux121 ux97 ux110 ux103 ux115 ux104 ux105 ux23500 ux38451 ux24066', 0, 0),
(943, 930, '330185', '临安市', 3, '0571', '区', 100, 'lin an shi', 'ux108 ux105 ux110 ux97 ux115 ux104 ux20020 ux23433 ux24066', 0, 0),
(944, 929, '330200', '宁波市', 2, '0574', '市', 100, 'ning bo shi', 'ux110 ux105 ux103 ux98 ux111 ux115 ux104 ux23425 ux27874 ux24066', 0, 0),
(945, 944, '330203', '海曙区', 3, '0574', '区', 100, 'hai shu qu', 'ux104 ux97 ux105 ux115 ux117 ux113 ux28023 ux26329 ux21306', 0, 0),
(946, 944, '330204', '江东区', 3, '0574', '区', 100, 'jiang dong qu', 'ux106 ux105 ux97 ux110 ux103 ux100 ux111 ux113 ux117 ux27743 ux19996 ux21306', 0, 0),
(947, 944, '330205', '江北区', 3, '0574', '区', 100, 'jiang bei qu', 'ux106 ux105 ux97 ux110 ux103 ux98 ux101 ux113 ux117 ux27743 ux21271 ux21306', 0, 0),
(948, 944, '330206', '北仑区', 3, '0574', '区', 100, 'bei lun qu', 'ux98 ux101 ux105 ux108 ux117 ux110 ux113 ux21271 ux20177 ux21306', 0, 0),
(949, 944, '330211', '镇海区', 3, '0574', '区', 100, 'zhen hai qu', 'ux122 ux104 ux101 ux110 ux97 ux105 ux113 ux117 ux38215 ux28023 ux21306', 0, 0),
(950, 944, '330212', '鄞州区', 3, '0574', '区', 100, 'yin zhou qu', 'ux121 ux105 ux110 ux122 ux104 ux111 ux117 ux113 ux37150 ux24030 ux21306', 0, 0),
(951, 944, '330225', '象山县', 3, '0574', '区', 100, 'xiang shan xian', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux35937 ux23665 ux21439', 0, 0),
(952, 944, '330226', '宁海县', 3, '0574', '区', 100, 'ning hai xian', 'ux110 ux105 ux103 ux104 ux97 ux120 ux23425 ux28023 ux21439', 0, 0),
(953, 944, '330281', '余姚市', 3, '0574', '区', 100, 'yu yao shi', 'ux121 ux117 ux97 ux111 ux115 ux104 ux105 ux20313 ux23002 ux24066', 0, 0),
(954, 944, '330282', '慈溪市', 3, '0574', '区', 100, 'ci xi shi', 'ux99 ux105 ux120 ux115 ux104 ux24904 ux28330 ux24066', 0, 0),
(955, 944, '330283', '奉化市', 3, '0574', '区', 100, 'feng hua shi', 'ux102 ux101 ux110 ux103 ux104 ux117 ux97 ux115 ux105 ux22857 ux21270 ux24066', 0, 0),
(956, 929, '330300', '温州市', 2, '0577', '市', 100, 'wen zhou shi', 'ux119 ux101 ux110 ux122 ux104 ux111 ux117 ux115 ux105 ux28201 ux24030 ux24066', 0, 0),
(957, 956, '330302', '鹿城区', 3, '0577', '区', 100, 'lu cheng qu', 'ux108 ux117 ux99 ux104 ux101 ux110 ux103 ux113 ux40575 ux22478 ux21306', 0, 0),
(958, 956, '330303', '龙湾区', 3, '0577', '区', 100, 'long wan qu', 'ux108 ux111 ux110 ux103 ux119 ux97 ux113 ux117 ux40857 ux28286 ux21306', 0, 0),
(959, 956, '330304', '瓯海区', 3, '0577', '区', 100, 'ou hai qu', 'ux111 ux117 ux104 ux97 ux105 ux113 ux29935 ux28023 ux21306', 0, 0),
(960, 956, '330322', '洞头县', 3, '0577', '区', 100, 'dong tou xian', 'ux100 ux111 ux110 ux103 ux116 ux117 ux120 ux105 ux97 ux27934 ux22836 ux21439', 0, 0),
(961, 956, '330324', '永嘉县', 3, '0577', '区', 100, 'yong jia xian', 'ux121 ux111 ux110 ux103 ux106 ux105 ux97 ux120 ux27704 ux22025 ux21439', 0, 0),
(962, 956, '330326', '平阳县', 3, '0577', '区', 100, 'ping yang xian', 'ux112 ux105 ux110 ux103 ux121 ux97 ux120 ux24179 ux38451 ux21439', 0, 0),
(963, 956, '330327', '苍南县', 3, '0577', '区', 100, 'cang nan xian', 'ux99 ux97 ux110 ux103 ux120 ux105 ux33485 ux21335 ux21439', 0, 0),
(964, 956, '330328', '文成县', 3, '0577', '区', 100, 'wen cheng xian', 'ux119 ux101 ux110 ux99 ux104 ux103 ux120 ux105 ux97 ux25991 ux25104 ux21439', 0, 0),
(965, 956, '330329', '泰顺县', 3, '0577', '区', 100, 'tai shun xian', 'ux116 ux97 ux105 ux115 ux104 ux117 ux110 ux120 ux27888 ux39034 ux21439', 0, 0),
(966, 956, '330381', '瑞安市', 3, '0577', '区', 100, 'rui an shi', 'ux114 ux117 ux105 ux97 ux110 ux115 ux104 ux29790 ux23433 ux24066', 0, 0),
(967, 956, '330382', '乐清市', 3, '0577', '区', 100, 'le qing shi', 'ux108 ux101 ux113 ux105 ux110 ux103 ux115 ux104 ux20048 ux28165 ux24066', 0, 0),
(968, 929, '330400', '嘉兴市', 2, '0573', '市', 100, 'jia xing shi', 'ux106 ux105 ux97 ux120 ux110 ux103 ux115 ux104 ux22025 ux20852 ux24066', 0, 0),
(969, 968, '330402', '南湖区', 3, '0573', '区', 100, 'nan hu qu', 'ux110 ux97 ux104 ux117 ux113 ux21335 ux28246 ux21306', 0, 0),
(970, 968, '330411', '秀洲区', 3, '0573', '区', 100, 'xiu zhou qu', 'ux120 ux105 ux117 ux122 ux104 ux111 ux113 ux31168 ux27954 ux21306', 0, 0),
(971, 968, '330421', '嘉善县', 3, '0573', '区', 100, 'jia shan xian', 'ux106 ux105 ux97 ux115 ux104 ux110 ux120 ux22025 ux21892 ux21439', 0, 0),
(972, 968, '330424', '海盐县', 3, '0573', '区', 100, 'hai yan xian', 'ux104 ux97 ux105 ux121 ux110 ux120 ux28023 ux30416 ux21439', 0, 0),
(973, 968, '330481', '海宁市', 3, '0573', '区', 100, 'hai ning shi', 'ux104 ux97 ux105 ux110 ux103 ux115 ux28023 ux23425 ux24066', 0, 0),
(974, 968, '330482', '平湖市', 3, '0573', '区', 100, 'ping hu shi', 'ux112 ux105 ux110 ux103 ux104 ux117 ux115 ux24179 ux28246 ux24066', 0, 0),
(975, 968, '330483', '桐乡市', 3, '0573', '区', 100, 'tong xiang shi', 'ux116 ux111 ux110 ux103 ux120 ux105 ux97 ux115 ux104 ux26704 ux20065 ux24066', 0, 0),
(976, 929, '330500', '湖州市', 2, '0572', '市', 100, 'hu zhou shi', 'ux104 ux117 ux122 ux111 ux115 ux105 ux28246 ux24030 ux24066', 0, 0),
(977, 976, '330502', '吴兴区', 3, '0572', '区', 100, 'wu xing qu', 'ux119 ux117 ux120 ux105 ux110 ux103 ux113 ux21556 ux20852 ux21306', 0, 0),
(978, 976, '330503', '南浔区', 3, '0572', '区', 100, 'nan xun qu', 'ux110 ux97 ux120 ux117 ux113 ux21335 ux27988 ux21306', 0, 0),
(979, 976, '330521', '德清县', 3, '0572', '区', 100, 'de qing xian', 'ux100 ux101 ux113 ux105 ux110 ux103 ux120 ux97 ux24503 ux28165 ux21439', 0, 0),
(980, 976, '330522', '长兴县', 3, '0572', '区', 100, 'chang xing xian', 'ux99 ux104 ux97 ux110 ux103 ux120 ux105 ux38271 ux20852 ux21439', 0, 0),
(981, 976, '330523', '安吉县', 3, '0572', '区', 100, 'an ji xian', 'ux97 ux110 ux106 ux105 ux120 ux23433 ux21513 ux21439', 0, 0),
(982, 929, '330600', '绍兴市', 2, '0575', '市', 100, 'shao xing shi', 'ux115 ux104 ux97 ux111 ux120 ux105 ux110 ux103 ux32461 ux20852 ux24066', 0, 0),
(983, 982, '330602', '越城区', 3, '0575', '区', 100, 'yue cheng qu', 'ux121 ux117 ux101 ux99 ux104 ux110 ux103 ux113 ux36234 ux22478 ux21306', 0, 0),
(984, 982, '330621', '绍兴县', 3, '0575', '区', 100, 'shao xing xian', 'ux115 ux104 ux97 ux111 ux120 ux105 ux110 ux103 ux32461 ux20852 ux21439', 0, 0),
(985, 982, '330624', '新昌县', 3, '0575', '区', 100, 'xin chang xian', 'ux120 ux105 ux110 ux99 ux104 ux97 ux103 ux26032 ux26124 ux21439', 0, 0),
(986, 982, '330681', '诸暨市', 3, '0575', '区', 100, 'zhu ji shi', 'ux122 ux104 ux117 ux106 ux105 ux115 ux35832 ux26280 ux24066', 0, 0),
(987, 982, '330682', '上虞市', 3, '0575', '区', 100, 'shang yu shi', 'ux115 ux104 ux97 ux110 ux103 ux121 ux117 ux105 ux19978 ux34398 ux24066', 0, 0),
(988, 982, '330683', '嵊州市', 3, '0575', '区', 100, 'sheng zhou shi', 'ux115 ux104 ux101 ux110 ux103 ux122 ux111 ux117 ux105 ux23882 ux24030 ux24066', 0, 0),
(989, 929, '330700', '金华市', 2, '0579', '市', 100, 'jin hua shi', 'ux106 ux105 ux110 ux104 ux117 ux97 ux115 ux37329 ux21326 ux24066', 0, 0),
(990, 989, '330702', '婺城区', 3, '0579', '区', 100, 'wu cheng qu', 'ux119 ux117 ux99 ux104 ux101 ux110 ux103 ux113 ux23162 ux22478 ux21306', 0, 0),
(991, 989, '330703', '金东区', 3, '0579', '区', 100, 'jin dong qu', 'ux106 ux105 ux110 ux100 ux111 ux103 ux113 ux117 ux37329 ux19996 ux21306', 0, 0),
(992, 989, '330723', '武义县', 3, '0579', '区', 100, 'wu yi xian', 'ux119 ux117 ux121 ux105 ux120 ux97 ux110 ux27494 ux20041 ux21439', 0, 0),
(993, 989, '330726', '浦江县', 3, '0579', '区', 100, 'pu jiang xian', 'ux112 ux117 ux106 ux105 ux97 ux110 ux103 ux120 ux28006 ux27743 ux21439', 0, 0),
(994, 989, '330727', '磐安县', 3, '0579', '区', 100, 'pan an xian', 'ux112 ux97 ux110 ux120 ux105 ux30928 ux23433 ux21439', 0, 0),
(995, 989, '330781', '兰溪市', 3, '0579', '区', 100, 'lan xi shi', 'ux108 ux97 ux110 ux120 ux105 ux115 ux104 ux20848 ux28330 ux24066', 0, 0),
(996, 989, '330782', '义乌市', 3, '0579', '区', 100, 'yi wu shi', 'ux121 ux105 ux119 ux117 ux115 ux104 ux20041 ux20044 ux24066', 0, 0),
(997, 989, '330783', '东阳市', 3, '0579', '区', 100, 'dong yang shi', 'ux100 ux111 ux110 ux103 ux121 ux97 ux115 ux104 ux105 ux19996 ux38451 ux24066', 0, 0),
(998, 989, '330784', '永康市', 3, '0579', '区', 100, 'yong kang shi', 'ux121 ux111 ux110 ux103 ux107 ux97 ux115 ux104 ux105 ux27704 ux24247 ux24066', 0, 0),
(999, 929, '330800', '衢州市', 2, '0570', '市', 100, 'qu zhou shi', 'ux113 ux117 ux122 ux104 ux111 ux115 ux105 ux34914 ux24030 ux24066', 0, 0),
(1000, 999, '330802', '柯城区', 3, '0570', '区', 100, 'ke cheng qu', 'ux107 ux101 ux99 ux104 ux110 ux103 ux113 ux117 ux26607 ux22478 ux21306', 0, 0),
(1001, 999, '330803', '衢江区', 3, '0570', '区', 100, 'qu jiang qu', 'ux113 ux117 ux106 ux105 ux97 ux110 ux103 ux34914 ux27743 ux21306', 0, 0),
(1002, 999, '330822', '常山县', 3, '0570', '区', 100, 'chang shan xian', 'ux99 ux104 ux97 ux110 ux103 ux115 ux120 ux105 ux24120 ux23665 ux21439', 0, 0),
(1003, 999, '330824', '开化县', 3, '0570', '区', 100, 'kai hua xian', 'ux107 ux97 ux105 ux104 ux117 ux120 ux110 ux24320 ux21270 ux21439', 0, 0),
(1004, 999, '330825', '龙游县', 3, '0570', '区', 100, 'long you xian', 'ux108 ux111 ux110 ux103 ux121 ux117 ux120 ux105 ux97 ux40857 ux28216 ux21439', 0, 0),
(1005, 999, '330881', '江山市', 3, '0570', '区', 100, 'jiang shan shi', 'ux106 ux105 ux97 ux110 ux103 ux115 ux104 ux27743 ux23665 ux24066', 0, 0),
(1006, 929, '330900', '舟山市', 2, '0580', '市', 100, 'zhou shan shi', 'ux122 ux104 ux111 ux117 ux115 ux97 ux110 ux105 ux33311 ux23665 ux24066', 0, 0),
(1007, 1006, '330902', '定海区', 3, '0580', '区', 100, 'ding hai qu', 'ux100 ux105 ux110 ux103 ux104 ux97 ux113 ux117 ux23450 ux28023 ux21306', 0, 0),
(1008, 1006, '330903', '普陀区', 3, '0580', '区', 100, 'pu tuo qu', 'ux112 ux117 ux116 ux111 ux113 ux26222 ux38464 ux21306', 0, 0),
(1009, 1006, '330921', '岱山县', 3, '0580', '区', 100, 'dai shan xian', 'ux100 ux97 ux105 ux115 ux104 ux110 ux120 ux23729 ux23665 ux21439', 0, 0),
(1010, 1006, '330922', '嵊泗县', 3, '0580', '区', 100, 'sheng si xian', 'ux115 ux104 ux101 ux110 ux103 ux105 ux120 ux97 ux23882 ux27863 ux21439', 0, 0),
(1011, 929, '331000', '台州市', 2, '0576', '市', 100, 'tai zhou shi', 'ux116 ux97 ux105 ux122 ux104 ux111 ux117 ux115 ux21488 ux24030 ux24066', 0, 0),
(1012, 1011, '331002', '椒江区', 3, '0576', '区', 100, 'jiao jiang qu', 'ux106 ux105 ux97 ux111 ux110 ux103 ux113 ux117 ux26898 ux27743 ux21306', 0, 0),
(1013, 1011, '331003', '黄岩区', 3, '0576', '区', 100, 'huang yan qu', 'ux104 ux117 ux97 ux110 ux103 ux121 ux113 ux40644 ux23721 ux21306', 0, 0),
(1014, 1011, '331004', '路桥区', 3, '0576', '区', 100, 'lu qiao qu', 'ux108 ux117 ux113 ux105 ux97 ux111 ux36335 ux26725 ux21306', 0, 0),
(1015, 1011, '331021', '玉环县', 3, '0576', '区', 100, 'yu huan xian', 'ux121 ux117 ux104 ux97 ux110 ux120 ux105 ux29577 ux29615 ux21439', 0, 0),
(1016, 1011, '331022', '三门县', 3, '0576', '区', 100, 'san men xian', 'ux115 ux97 ux110 ux109 ux101 ux120 ux105 ux19977 ux38376 ux21439', 0, 0),
(1017, 1011, '331023', '天台县', 3, '0576', '区', 100, 'tian tai xian', 'ux116 ux105 ux97 ux110 ux120 ux22825 ux21488 ux21439', 0, 0),
(1018, 1011, '331024', '仙居县', 3, '0576', '区', 100, 'xian ju xian', 'ux120 ux105 ux97 ux110 ux106 ux117 ux20185 ux23621 ux21439', 0, 0),
(1019, 1011, '331081', '温岭市', 3, '0576', '区', 100, 'wen ling shi', 'ux119 ux101 ux110 ux108 ux105 ux103 ux115 ux104 ux28201 ux23725 ux24066', 0, 0),
(1020, 1011, '331082', '临海市', 3, '0576', '区', 100, 'lin hai shi', 'ux108 ux105 ux110 ux104 ux97 ux115 ux20020 ux28023 ux24066', 0, 0),
(1021, 929, '331100', '丽水市', 2, '0578', '市', 100, 'li shui shi', 'ux108 ux105 ux115 ux104 ux117 ux20029 ux27700 ux24066', 0, 0),
(1022, 1021, '331102', '莲都区', 3, '0578', '区', 100, 'lian du qu', 'ux108 ux105 ux97 ux110 ux100 ux117 ux113 ux33714 ux37117 ux21306', 0, 0),
(1023, 1021, '331121', '青田县', 3, '0578', '区', 100, 'qing tian xian', 'ux113 ux105 ux110 ux103 ux116 ux97 ux120 ux38738 ux30000 ux21439', 0, 0),
(1024, 1021, '331122', '缙云县', 3, '0578', '区', 100, 'jin yun xian', 'ux106 ux105 ux110 ux121 ux117 ux120 ux97 ux32537 ux20113 ux21439', 0, 0),
(1025, 1021, '331123', '遂昌县', 3, '0578', '区', 100, 'sui chang xian', 'ux115 ux117 ux105 ux99 ux104 ux97 ux110 ux103 ux120 ux36930 ux26124 ux21439', 0, 0),
(1026, 1021, '331124', '松阳县', 3, '0578', '区', 100, 'song yang xian', 'ux115 ux111 ux110 ux103 ux121 ux97 ux120 ux105 ux26494 ux38451 ux21439', 0, 0),
(1027, 1021, '331125', '云和县', 3, '0578', '区', 100, 'yun he xian', 'ux121 ux117 ux110 ux104 ux101 ux120 ux105 ux97 ux20113 ux21644 ux21439', 0, 0),
(1028, 1021, '331126', '庆元县', 3, '0578', '区', 100, 'qing yuan xian', 'ux113 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux24198 ux20803 ux21439', 0, 0),
(1029, 1021, '331127', '景宁畲族自治县', 3, '0578', '区', 100, 'jing ning she zu zi zhi xian', 'ux106 ux105 ux110 ux103 ux115 ux104 ux101 ux122 ux117 ux120 ux97 ux26223 ux23425 ux30066 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1030, 1021, '331181', '龙泉市', 3, '0578', '区', 100, 'long quan shi', 'ux108 ux111 ux110 ux103 ux113 ux117 ux97 ux115 ux104 ux105 ux40857 ux27849 ux24066', 0, 0),
(1031, 0, '340000', '安徽省', 1, '', '省', 100, 'an hui sheng', 'ux97 ux110 ux104 ux117 ux105 ux115 ux101 ux103 ux23433 ux24509 ux30465', 0, 0),
(1032, 1031, '340100', '合肥市', 2, '0551', '市', 100, 'he fei shi', 'ux104 ux101 ux102 ux105 ux115 ux21512 ux32933 ux24066', 0, 0),
(1033, 1032, '340102', '瑶海区', 3, '0551', '区', 100, 'yao hai qu', 'ux121 ux97 ux111 ux104 ux105 ux113 ux117 ux29814 ux28023 ux21306', 0, 0),
(1034, 1032, '340103', '庐阳区', 3, '0551', '区', 100, 'lu yang qu', 'ux108 ux117 ux121 ux97 ux110 ux103 ux113 ux24208 ux38451 ux21306', 0, 0),
(1035, 1032, '340104', '蜀山区', 3, '0551', '区', 100, 'shu shan qu', 'ux115 ux104 ux117 ux97 ux110 ux113 ux34560 ux23665 ux21306', 0, 0),
(1036, 1032, '340111', '包河区', 3, '0551', '区', 100, 'bao he qu', 'ux98 ux97 ux111 ux104 ux101 ux113 ux117 ux21253 ux27827 ux21306', 0, 0),
(1037, 1032, '340121', '长丰县', 3, '0551', '区', 100, 'chang feng xian', 'ux99 ux104 ux97 ux110 ux103 ux102 ux101 ux120 ux105 ux38271 ux20016 ux21439', 0, 0),
(1038, 1032, '340122', '肥东县', 3, '0551', '区', 100, 'fei dong xian', 'ux102 ux101 ux105 ux100 ux111 ux110 ux103 ux120 ux97 ux32933 ux19996 ux21439', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(1039, 1032, '340123', '肥西县', 3, '0551', '区', 100, 'fei xi xian', 'ux102 ux101 ux105 ux120 ux97 ux110 ux32933 ux35199 ux21439', 0, 0),
(1040, 1032, '340124', '庐江县', 3, '0551', '区', 100, 'lu jiang xian', 'ux108 ux117 ux106 ux105 ux97 ux110 ux103 ux120 ux24208 ux27743 ux21439', 0, 0),
(1041, 1032, '340181', '巢湖市', 3, '0565', '区', 100, 'chao hu shi', 'ux99 ux104 ux97 ux111 ux117 ux115 ux105 ux24034 ux28246 ux24066', 0, 0),
(1042, 1031, '340200', '芜湖市', 2, '0553', '市', 100, 'wu hu shi', 'ux119 ux117 ux104 ux115 ux105 ux33436 ux28246 ux24066', 0, 0),
(1043, 1042, '340202', '镜湖区', 3, '0553', '区', 100, 'jing hu qu', 'ux106 ux105 ux110 ux103 ux104 ux117 ux113 ux38236 ux28246 ux21306', 0, 0),
(1044, 1042, '340203', '弋江区', 3, '0553', '区', 100, 'yi jiang qu', 'ux121 ux105 ux106 ux97 ux110 ux103 ux113 ux117 ux24331 ux27743 ux21306', 0, 0),
(1045, 1042, '340207', '鸠江区', 3, '0553', '区', 100, 'jiu jiang qu', 'ux106 ux105 ux117 ux97 ux110 ux103 ux113 ux40480 ux27743 ux21306', 0, 0),
(1046, 1042, '340208', '三山区', 3, '0553', '区', 100, 'san shan qu', 'ux115 ux97 ux110 ux104 ux113 ux117 ux19977 ux23665 ux21306', 0, 0),
(1047, 1042, '340221', '芜湖县', 3, '0553', '区', 100, 'wu hu xian', 'ux119 ux117 ux104 ux120 ux105 ux97 ux110 ux33436 ux28246 ux21439', 0, 0),
(1048, 1042, '340222', '繁昌县', 3, '0553', '区', 100, 'fan chang xian', 'ux102 ux97 ux110 ux99 ux104 ux103 ux120 ux105 ux32321 ux26124 ux21439', 0, 0),
(1049, 1042, '340223', '南陵县', 3, '0553', '区', 100, 'nan ling xian', 'ux110 ux97 ux108 ux105 ux103 ux120 ux21335 ux38517 ux21439', 0, 0),
(1050, 1042, '340225', '无为县', 3, '0553', '区', 100, 'wu wei xian', 'ux119 ux117 ux101 ux105 ux120 ux97 ux110 ux26080 ux20026 ux21439', 0, 0),
(1051, 1031, '340300', '蚌埠市', 2, '0552', '市', 100, 'bang bu shi', 'ux98 ux97 ux110 ux103 ux117 ux115 ux104 ux105 ux34444 ux22496 ux24066', 0, 0),
(1052, 1051, '340302', '龙子湖区', 3, '0552', '区', 100, 'long zi hu qu', 'ux108 ux111 ux110 ux103 ux122 ux105 ux104 ux117 ux113 ux40857 ux23376 ux28246 ux21306', 0, 0),
(1053, 1051, '340303', '蚌山区', 3, '0552', '区', 100, 'bang shan qu', 'ux98 ux97 ux110 ux103 ux115 ux104 ux113 ux117 ux34444 ux23665 ux21306', 0, 0),
(1054, 1051, '340304', '禹会区', 3, '0552', '区', 100, 'yu hui qu', 'ux121 ux117 ux104 ux105 ux113 ux31161 ux20250 ux21306', 0, 0),
(1055, 1051, '340311', '淮上区', 3, '0552', '区', 100, 'huai shang qu', 'ux104 ux117 ux97 ux105 ux115 ux110 ux103 ux113 ux28142 ux19978 ux21306', 0, 0),
(1056, 1051, '340321', '怀远县', 3, '0552', '区', 100, 'huai yuan xian', 'ux104 ux117 ux97 ux105 ux121 ux110 ux120 ux24576 ux36828 ux21439', 0, 0),
(1057, 1051, '340322', '五河县', 3, '0552', '区', 100, 'wu he xian', 'ux119 ux117 ux104 ux101 ux120 ux105 ux97 ux110 ux20116 ux27827 ux21439', 0, 0),
(1058, 1051, '340323', '固镇县', 3, '0552', '区', 100, 'gu zhen xian', 'ux103 ux117 ux122 ux104 ux101 ux110 ux120 ux105 ux97 ux22266 ux38215 ux21439', 0, 0),
(1059, 1031, '340400', '淮南市', 2, '0554', '市', 100, 'huai nan shi', 'ux104 ux117 ux97 ux105 ux110 ux115 ux28142 ux21335 ux24066', 0, 0),
(1060, 1059, '340402', '大通区', 3, '0554', '区', 100, 'da tong qu', 'ux100 ux97 ux116 ux111 ux110 ux103 ux113 ux117 ux22823 ux36890 ux21306', 0, 0),
(1061, 1059, '340403', '田家庵区', 3, '0554', '区', 100, 'tian jia an qu', 'ux116 ux105 ux97 ux110 ux106 ux113 ux117 ux30000 ux23478 ux24245 ux21306', 0, 0),
(1062, 1059, '340404', '谢家集区', 3, '0554', '区', 100, 'xie jia ji qu', 'ux120 ux105 ux101 ux106 ux97 ux113 ux117 ux35874 ux23478 ux38598 ux21306', 0, 0),
(1063, 1059, '340405', '八公山区', 3, '0554', '区', 100, 'ba gong shan qu', 'ux98 ux97 ux103 ux111 ux110 ux115 ux104 ux113 ux117 ux20843 ux20844 ux23665 ux21306', 0, 0),
(1064, 1059, '340406', '潘集区', 3, '0554', '区', 100, 'pan ji qu', 'ux112 ux97 ux110 ux106 ux105 ux113 ux117 ux28504 ux38598 ux21306', 0, 0),
(1065, 1059, '340421', '凤台县', 3, '0554', '区', 100, 'feng tai xian', 'ux102 ux101 ux110 ux103 ux116 ux97 ux105 ux120 ux20964 ux21488 ux21439', 0, 0),
(1066, 1031, '340500', '马鞍山市', 2, '0555', '市', 100, 'ma an shan shi', 'ux109 ux97 ux110 ux115 ux104 ux105 ux39532 ux38797 ux23665 ux24066', 0, 0),
(1067, 1066, '340503', '花山区', 3, '0555', '区', 100, 'hua shan qu', 'ux104 ux117 ux97 ux115 ux110 ux113 ux33457 ux23665 ux21306', 0, 0),
(1068, 1066, '340504', '雨山区', 3, '0555', '区', 100, 'yu shan qu', 'ux121 ux117 ux115 ux104 ux97 ux110 ux113 ux38632 ux23665 ux21306', 0, 0),
(1069, 1066, '340521', '当涂县', 3, '0555', '区', 100, 'dang tu xian', 'ux100 ux97 ux110 ux103 ux116 ux117 ux120 ux105 ux24403 ux28034 ux21439', 0, 0),
(1070, 1066, '340522', '含山县', 3, '0555', '区', 100, 'han shan xian', 'ux104 ux97 ux110 ux115 ux120 ux105 ux21547 ux23665 ux21439', 0, 0),
(1071, 1066, '340523', '和县', 3, '0555', '区', 100, 'he xian', 'ux104 ux101 ux120 ux105 ux97 ux110 ux21644 ux21439', 0, 0),
(1072, 1066, '340596', '博望区', 3, '0555', '区', 100, 'bo wang qu', 'ux98 ux111 ux119 ux97 ux110 ux103 ux113 ux117 ux21338 ux26395 ux21306', 0, 0),
(1073, 1031, '340600', '淮北市', 2, '0561', '市', 100, 'huai bei shi', 'ux104 ux117 ux97 ux105 ux98 ux101 ux115 ux28142 ux21271 ux24066', 0, 0),
(1074, 1073, '340602', '杜集区', 3, '0561', '区', 100, 'du ji qu', 'ux100 ux117 ux106 ux105 ux113 ux26460 ux38598 ux21306', 0, 0),
(1075, 1073, '340603', '相山区', 3, '0561', '区', 100, 'xiang shan qu', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux113 ux117 ux30456 ux23665 ux21306', 0, 0),
(1076, 1073, '340604', '烈山区', 3, '0561', '区', 100, 'lie shan qu', 'ux108 ux105 ux101 ux115 ux104 ux97 ux110 ux113 ux117 ux28872 ux23665 ux21306', 0, 0),
(1077, 1073, '340621', '濉溪县', 3, '0561', '区', 100, 'sui xi xian', 'ux115 ux117 ux105 ux120 ux97 ux110 ux28617 ux28330 ux21439', 0, 0),
(1078, 1031, '340700', '铜陵市', 2, '0562', '市', 100, 'tong ling shi', 'ux116 ux111 ux110 ux103 ux108 ux105 ux115 ux104 ux38108 ux38517 ux24066', 0, 0),
(1079, 1078, '340702', '铜官山区', 3, '0562', '区', 100, 'tong guan shan qu', 'ux116 ux111 ux110 ux103 ux117 ux97 ux115 ux104 ux113 ux38108 ux23448 ux23665 ux21306', 0, 0),
(1080, 1078, '340703', '狮子山区', 3, '0562', '区', 100, 'shi zi shan qu', 'ux115 ux104 ux105 ux122 ux97 ux110 ux113 ux117 ux29422 ux23376 ux23665 ux21306', 0, 0),
(1081, 1078, '340711', '郊区', 3, '0562', '区', 100, 'jiao qu', 'ux106 ux105 ux97 ux111 ux113 ux117 ux37066 ux21306', 0, 0),
(1082, 1078, '340721', '铜陵县', 3, '0562', '区', 100, 'tong ling xian', 'ux116 ux111 ux110 ux103 ux108 ux105 ux120 ux97 ux38108 ux38517 ux21439', 0, 0),
(1083, 1031, '340800', '安庆市', 2, '0556', '市', 100, 'an qing shi', 'ux97 ux110 ux113 ux105 ux103 ux115 ux104 ux23433 ux24198 ux24066', 0, 0),
(1084, 1083, '340802', '迎江区', 3, '0556', '区', 100, 'ying jiang qu', 'ux121 ux105 ux110 ux103 ux106 ux97 ux113 ux117 ux36814 ux27743 ux21306', 0, 0),
(1085, 1083, '340803', '大观区', 3, '0556', '区', 100, 'da guan qu', 'ux100 ux97 ux103 ux117 ux110 ux113 ux22823 ux35266 ux21306', 0, 0),
(1086, 1083, '340811', '宜秀区', 3, '0556', '区', 100, 'yi xiu qu', 'ux121 ux105 ux120 ux117 ux113 ux23452 ux31168 ux21306', 0, 0),
(1087, 1083, '340822', '怀宁县', 3, '0556', '区', 100, 'huai ning xian', 'ux104 ux117 ux97 ux105 ux110 ux103 ux120 ux24576 ux23425 ux21439', 0, 0),
(1088, 1083, '340823', '枞阳县', 3, '0556', '区', 100, 'cong yang xian', 'ux99 ux111 ux110 ux103 ux121 ux97 ux120 ux105 ux26526 ux38451 ux21439', 0, 0),
(1089, 1083, '340824', '潜山县', 3, '0556', '区', 100, 'qian shan xian', 'ux113 ux105 ux97 ux110 ux115 ux104 ux120 ux28508 ux23665 ux21439', 0, 0),
(1090, 1083, '340825', '太湖县', 3, '0556', '区', 100, 'tai hu xian', 'ux116 ux97 ux105 ux104 ux117 ux120 ux110 ux22826 ux28246 ux21439', 0, 0),
(1091, 1083, '340826', '宿松县', 3, '0556', '区', 100, 'su song xian', 'ux115 ux117 ux111 ux110 ux103 ux120 ux105 ux97 ux23487 ux26494 ux21439', 0, 0),
(1092, 1083, '340827', '望江县', 3, '0556', '区', 100, 'wang jiang xian', 'ux119 ux97 ux110 ux103 ux106 ux105 ux120 ux26395 ux27743 ux21439', 0, 0),
(1093, 1083, '340828', '岳西县', 3, '0556', '区', 100, 'yue xi xian', 'ux121 ux117 ux101 ux120 ux105 ux97 ux110 ux23731 ux35199 ux21439', 0, 0),
(1094, 1083, '340881', '桐城市', 3, '0556', '区', 100, 'tong cheng shi', 'ux116 ux111 ux110 ux103 ux99 ux104 ux101 ux115 ux105 ux26704 ux22478 ux24066', 0, 0),
(1095, 1031, '341000', '黄山市', 2, '0559', '市', 100, 'huang shan shi', 'ux104 ux117 ux97 ux110 ux103 ux115 ux105 ux40644 ux23665 ux24066', 0, 0),
(1096, 1095, '341002', '屯溪区', 3, '0559', '区', 100, 'tun xi qu', 'ux116 ux117 ux110 ux120 ux105 ux113 ux23663 ux28330 ux21306', 0, 0),
(1097, 1095, '341003', '黄山区', 3, '0559', '区', 100, 'huang shan qu', 'ux104 ux117 ux97 ux110 ux103 ux115 ux113 ux40644 ux23665 ux21306', 0, 0),
(1098, 1095, '341004', '徽州区', 3, '0559', '区', 100, 'hui zhou qu', 'ux104 ux117 ux105 ux122 ux111 ux113 ux24509 ux24030 ux21306', 0, 0),
(1099, 1095, '341021', '歙县', 3, '0559', '区', 100, 'xi xian', 'ux120 ux105 ux97 ux110 ux27481 ux21439', 0, 0),
(1100, 1095, '341022', '休宁县', 3, '0559', '区', 100, 'xiu ning xian', 'ux120 ux105 ux117 ux110 ux103 ux97 ux20241 ux23425 ux21439', 0, 0),
(1101, 1095, '341023', '黟县', 3, '0559', '区', 100, 'yi xian', 'ux121 ux105 ux120 ux97 ux110 ux40671 ux21439', 0, 0),
(1102, 1095, '341024', '祁门县', 3, '0559', '区', 100, 'qi men xian', 'ux113 ux105 ux109 ux101 ux110 ux120 ux97 ux31041 ux38376 ux21439', 0, 0),
(1103, 1031, '341100', '滁州市', 2, '0550', '市', 100, 'chu zhou shi', 'ux99 ux104 ux117 ux122 ux111 ux115 ux105 ux28353 ux24030 ux24066', 0, 0),
(1104, 1103, '341102', '琅琊区', 3, '0550', '区', 100, 'lang ya qu', 'ux108 ux97 ux110 ux103 ux121 ux113 ux117 ux29701 ux29706 ux21306', 0, 0),
(1105, 1103, '341103', '南谯区', 3, '0550', '区', 100, 'nan qiao qu', 'ux110 ux97 ux113 ux105 ux111 ux117 ux21335 ux35887 ux21306', 0, 0),
(1106, 1103, '341122', '来安县', 3, '0550', '区', 100, 'lai an xian', 'ux108 ux97 ux105 ux110 ux120 ux26469 ux23433 ux21439', 0, 0),
(1107, 1103, '341124', '全椒县', 3, '0550', '区', 100, 'quan jiao xian', 'ux113 ux117 ux97 ux110 ux106 ux105 ux111 ux120 ux20840 ux26898 ux21439', 0, 0),
(1108, 1103, '341125', '定远县', 3, '0550', '区', 100, 'ding yuan xian', 'ux100 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux23450 ux36828 ux21439', 0, 0),
(1109, 1103, '341126', '凤阳县', 3, '0550', '区', 100, 'feng yang xian', 'ux102 ux101 ux110 ux103 ux121 ux97 ux120 ux105 ux20964 ux38451 ux21439', 0, 0),
(1110, 1103, '341181', '天长市', 3, '0550', '区', 100, 'tian chang shi', 'ux116 ux105 ux97 ux110 ux99 ux104 ux103 ux115 ux22825 ux38271 ux24066', 0, 0),
(1111, 1103, '341182', '明光市', 3, '0550', '区', 100, 'ming guang shi', 'ux109 ux105 ux110 ux103 ux117 ux97 ux115 ux104 ux26126 ux20809 ux24066', 0, 0),
(1112, 1031, '341200', '阜阳市', 2, '0558', '市', 100, 'fu yang shi', 'ux102 ux117 ux121 ux97 ux110 ux103 ux115 ux104 ux105 ux38428 ux38451 ux24066', 0, 0),
(1113, 1112, '341202', '颍州区', 3, '0558', '区', 100, 'ying zhou qu', 'ux121 ux105 ux110 ux103 ux122 ux104 ux111 ux117 ux113 ux39053 ux24030 ux21306', 0, 0),
(1114, 1112, '341203', '颍东区', 3, '0558', '区', 100, 'ying dong qu', 'ux121 ux105 ux110 ux103 ux100 ux111 ux113 ux117 ux39053 ux19996 ux21306', 0, 0),
(1115, 1112, '341204', '颍泉区', 3, '0558', '区', 100, 'ying quan qu', 'ux121 ux105 ux110 ux103 ux113 ux117 ux97 ux39053 ux27849 ux21306', 0, 0),
(1116, 1112, '341221', '临泉县', 3, '0558', '区', 100, 'lin quan xian', 'ux108 ux105 ux110 ux113 ux117 ux97 ux120 ux20020 ux27849 ux21439', 0, 0),
(1117, 1112, '341222', '太和县', 3, '0558', '区', 100, 'tai he xian', 'ux116 ux97 ux105 ux104 ux101 ux120 ux110 ux22826 ux21644 ux21439', 0, 0),
(1118, 1112, '341225', '阜南县', 3, '0558', '区', 100, 'fu nan xian', 'ux102 ux117 ux110 ux97 ux120 ux105 ux38428 ux21335 ux21439', 0, 0),
(1119, 1112, '341226', '颍上县', 3, '0558', '区', 100, 'ying shang xian', 'ux121 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux39053 ux19978 ux21439', 0, 0),
(1120, 1112, '341282', '界首市', 3, '0558', '区', 100, 'jie shou shi', 'ux106 ux105 ux101 ux115 ux104 ux111 ux117 ux30028 ux39318 ux24066', 0, 0),
(1121, 1031, '341300', '宿州市', 2, '0557', '市', 100, 'su zhou shi', 'ux115 ux117 ux122 ux104 ux111 ux105 ux23487 ux24030 ux24066', 0, 0),
(1122, 1121, '341302', '埇桥区', 3, '0557', '区', 100, 'yong qiao qu', 'ux121 ux111 ux110 ux103 ux113 ux105 ux97 ux117 ux22471 ux26725 ux21306', 0, 0),
(1123, 1121, '341321', '砀山县', 3, '0557', '区', 100, 'dang shan xian', 'ux100 ux97 ux110 ux103 ux115 ux104 ux120 ux105 ux30720 ux23665 ux21439', 0, 0),
(1124, 1121, '341322', '萧县', 3, '0557', '区', 100, 'xiao xian', 'ux120 ux105 ux97 ux111 ux110 ux33831 ux21439', 0, 0),
(1125, 1121, '341323', '灵璧县', 3, '0557', '区', 100, 'ling bi xian', 'ux108 ux105 ux110 ux103 ux98 ux120 ux97 ux28789 ux29863 ux21439', 0, 0),
(1126, 1121, '341324', '泗县', 3, '0557', '区', 100, 'si xian', 'ux115 ux105 ux120 ux97 ux110 ux27863 ux21439', 0, 0),
(1127, 1031, '341500', '六安市', 2, '0564', '市', 100, 'liu an shi', 'ux108 ux105 ux117 ux97 ux110 ux115 ux104 ux20845 ux23433 ux24066', 0, 0),
(1128, 1127, '341502', '金安区', 3, '0564', '区', 100, 'jin an qu', 'ux106 ux105 ux110 ux97 ux113 ux117 ux37329 ux23433 ux21306', 0, 0),
(1129, 1127, '341503', '裕安区', 3, '0564', '区', 100, 'yu an qu', 'ux121 ux117 ux97 ux110 ux113 ux35029 ux23433 ux21306', 0, 0),
(1130, 1127, '341521', '寿县', 3, '0564', '区', 100, 'shou xian', 'ux115 ux104 ux111 ux117 ux120 ux105 ux97 ux110 ux23551 ux21439', 0, 0),
(1131, 1127, '341522', '霍邱县', 3, '0564', '区', 100, 'huo qiu xian', 'ux104 ux117 ux111 ux113 ux105 ux120 ux97 ux110 ux38669 ux37041 ux21439', 0, 0),
(1132, 1127, '341523', '舒城县', 3, '0564', '区', 100, 'shu cheng xian', 'ux115 ux104 ux117 ux99 ux101 ux110 ux103 ux120 ux105 ux97 ux33298 ux22478 ux21439', 0, 0),
(1133, 1127, '341524', '金寨县', 3, '0564', '区', 100, 'jin zhai xian', 'ux106 ux105 ux110 ux122 ux104 ux97 ux120 ux37329 ux23528 ux21439', 0, 0),
(1134, 1127, '341525', '霍山县', 3, '0564', '区', 100, 'huo shan xian', 'ux104 ux117 ux111 ux115 ux97 ux110 ux120 ux105 ux38669 ux23665 ux21439', 0, 0),
(1135, 1031, '341600', '亳州市', 2, '0558', '市', 100, 'bo zhou shi', 'ux98 ux111 ux122 ux104 ux117 ux115 ux105 ux20147 ux24030 ux24066', 0, 0),
(1136, 1135, '341602', '谯城区', 3, '0558', '区', 100, 'qiao cheng qu', 'ux113 ux105 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux117 ux35887 ux22478 ux21306', 0, 0),
(1137, 1135, '341621', '涡阳县', 3, '0558', '区', 100, 'wo yang xian', 'ux119 ux111 ux121 ux97 ux110 ux103 ux120 ux105 ux28065 ux38451 ux21439', 0, 0),
(1138, 1135, '341622', '蒙城县', 3, '0558', '区', 100, 'meng cheng xian', 'ux109 ux101 ux110 ux103 ux99 ux104 ux120 ux105 ux97 ux33945 ux22478 ux21439', 0, 0),
(1139, 1135, '341623', '利辛县', 3, '0558', '区', 100, 'li xin xian', 'ux108 ux105 ux120 ux110 ux97 ux21033 ux36763 ux21439', 0, 0),
(1140, 1031, '341700', '池州市', 2, '0566', '市', 100, 'chi zhou shi', 'ux99 ux104 ux105 ux122 ux111 ux117 ux115 ux27744 ux24030 ux24066', 0, 0),
(1141, 1140, '341702', '贵池区', 3, '0566', '区', 100, 'gui chi qu', 'ux103 ux117 ux105 ux99 ux104 ux113 ux36149 ux27744 ux21306', 0, 0),
(1142, 1140, '341721', '东至县', 3, '0566', '区', 100, 'dong zhi xian', 'ux100 ux111 ux110 ux103 ux122 ux104 ux105 ux120 ux97 ux19996 ux33267 ux21439', 0, 0),
(1143, 1140, '341722', '石台县', 3, '0566', '区', 100, 'shi tai xian', 'ux115 ux104 ux105 ux116 ux97 ux120 ux110 ux30707 ux21488 ux21439', 0, 0),
(1144, 1140, '341723', '青阳县', 3, '0566', '区', 100, 'qing yang xian', 'ux113 ux105 ux110 ux103 ux121 ux97 ux120 ux38738 ux38451 ux21439', 0, 0),
(1145, 1031, '341800', '宣城市', 2, '0563', '市', 100, 'xuan cheng shi', 'ux120 ux117 ux97 ux110 ux99 ux104 ux101 ux103 ux115 ux105 ux23459 ux22478 ux24066', 0, 0),
(1146, 1145, '341802', '宣州区', 3, '0563', '区', 100, 'xuan zhou qu', 'ux120 ux117 ux97 ux110 ux122 ux104 ux111 ux113 ux23459 ux24030 ux21306', 0, 0),
(1147, 1145, '341821', '郎溪县', 3, '0563', '区', 100, 'lang xi xian', 'ux108 ux97 ux110 ux103 ux120 ux105 ux37070 ux28330 ux21439', 0, 0),
(1148, 1145, '341822', '广德县', 3, '0563', '区', 100, 'guang de xian', 'ux103 ux117 ux97 ux110 ux100 ux101 ux120 ux105 ux24191 ux24503 ux21439', 0, 0),
(1149, 1145, '341823', '泾县', 3, '0563', '区', 100, 'jing xian', 'ux106 ux105 ux110 ux103 ux120 ux97 ux27902 ux21439', 0, 0),
(1150, 1145, '341824', '绩溪县', 3, '0563', '区', 100, 'ji xi xian', 'ux106 ux105 ux120 ux97 ux110 ux32489 ux28330 ux21439', 0, 0),
(1151, 1145, '341825', '旌德县', 3, '0563', '区', 100, 'jing de xian', 'ux106 ux105 ux110 ux103 ux100 ux101 ux120 ux97 ux26060 ux24503 ux21439', 0, 0),
(1152, 1145, '341881', '宁国市', 3, '0563', '区', 100, 'ning guo shi', 'ux110 ux105 ux103 ux117 ux111 ux115 ux104 ux23425 ux22269 ux24066', 0, 0),
(1153, 0, '350000', '福建省', 1, '', '省', 100, 'fu jian sheng', 'ux102 ux117 ux106 ux105 ux97 ux110 ux115 ux104 ux101 ux103 ux31119 ux24314 ux30465', 0, 0),
(1154, 1153, '350100', '福州市', 2, '0591', '市', 100, 'fu zhou shi', 'ux102 ux117 ux122 ux104 ux111 ux115 ux105 ux31119 ux24030 ux24066', 0, 0),
(1155, 1154, '350102', '鼓楼区', 3, '0591', '区', 100, 'gu lou qu', 'ux103 ux117 ux108 ux111 ux113 ux40723 ux27004 ux21306', 0, 0),
(1156, 1154, '350103', '台江区', 3, '0591', '区', 100, 'tai jiang qu', 'ux116 ux97 ux105 ux106 ux110 ux103 ux113 ux117 ux21488 ux27743 ux21306', 0, 0),
(1157, 1154, '350104', '仓山区', 3, '0591', '区', 100, 'cang shan qu', 'ux99 ux97 ux110 ux103 ux115 ux104 ux113 ux117 ux20179 ux23665 ux21306', 0, 0),
(1158, 1154, '350105', '马尾区', 3, '0591', '区', 100, 'ma wei qu', 'ux109 ux97 ux119 ux101 ux105 ux113 ux117 ux39532 ux23614 ux21306', 0, 0),
(1159, 1154, '350111', '晋安区', 3, '0591', '区', 100, 'jin an qu', 'ux106 ux105 ux110 ux97 ux113 ux117 ux26187 ux23433 ux21306', 0, 0),
(1160, 1154, '350121', '闽侯县', 3, '0591', '区', 100, 'min hou xian', 'ux109 ux105 ux110 ux104 ux111 ux117 ux120 ux97 ux38397 ux20399 ux21439', 0, 0),
(1161, 1154, '350122', '连江县', 3, '0591', '区', 100, 'lian jiang xian', 'ux108 ux105 ux97 ux110 ux106 ux103 ux120 ux36830 ux27743 ux21439', 0, 0),
(1162, 1154, '350123', '罗源县', 3, '0591', '区', 100, 'luo yuan xian', 'ux108 ux117 ux111 ux121 ux97 ux110 ux120 ux105 ux32599 ux28304 ux21439', 0, 0),
(1163, 1154, '350124', '闽清县', 3, '0591', '区', 100, 'min qing xian', 'ux109 ux105 ux110 ux113 ux103 ux120 ux97 ux38397 ux28165 ux21439', 0, 0),
(1164, 1154, '350125', '永泰县', 3, '0591', '区', 100, 'yong tai xian', 'ux121 ux111 ux110 ux103 ux116 ux97 ux105 ux120 ux27704 ux27888 ux21439', 0, 0),
(1165, 1154, '350128', '平潭县', 3, '0591', '区', 100, 'ping tan xian', 'ux112 ux105 ux110 ux103 ux116 ux97 ux120 ux24179 ux28525 ux21439', 0, 0),
(1166, 1154, '350181', '福清市', 3, '0591', '区', 100, 'fu qing shi', 'ux102 ux117 ux113 ux105 ux110 ux103 ux115 ux104 ux31119 ux28165 ux24066', 0, 0),
(1167, 1154, '350182', '长乐市', 3, '0591', '区', 100, 'chang le shi', 'ux99 ux104 ux97 ux110 ux103 ux108 ux101 ux115 ux105 ux38271 ux20048 ux24066', 0, 0),
(1168, 1153, '350200', '厦门市', 2, '0592', '市', 100, 'sha men shi', 'ux115 ux104 ux97 ux109 ux101 ux110 ux105 ux21414 ux38376 ux24066', 0, 0),
(1169, 1168, '350203', '思明区', 3, '0592', '区', 100, 'si ming qu', 'ux115 ux105 ux109 ux110 ux103 ux113 ux117 ux24605 ux26126 ux21306', 0, 0),
(1170, 1168, '350205', '海沧区', 3, '0592', '区', 100, 'hai cang qu', 'ux104 ux97 ux105 ux99 ux110 ux103 ux113 ux117 ux28023 ux27815 ux21306', 0, 0),
(1171, 1168, '350206', '湖里区', 3, '0592', '区', 100, 'hu li qu', 'ux104 ux117 ux108 ux105 ux113 ux28246 ux37324 ux21306', 0, 0),
(1172, 1168, '350211', '集美区', 3, '0592', '区', 100, 'ji mei qu', 'ux106 ux105 ux109 ux101 ux113 ux117 ux38598 ux32654 ux21306', 0, 0),
(1173, 1168, '350212', '同安区', 3, '0592', '区', 100, 'tong an qu', 'ux116 ux111 ux110 ux103 ux97 ux113 ux117 ux21516 ux23433 ux21306', 0, 0),
(1174, 1168, '350213', '翔安区', 3, '0592', '区', 100, 'xiang an qu', 'ux120 ux105 ux97 ux110 ux103 ux113 ux117 ux32724 ux23433 ux21306', 0, 0),
(1175, 1153, '350300', '莆田市', 2, '0594', '市', 100, 'pu tian shi', 'ux112 ux117 ux116 ux105 ux97 ux110 ux115 ux104 ux33670 ux30000 ux24066', 0, 0),
(1176, 1175, '350302', '城厢区', 3, '0594', '区', 100, 'cheng xiang qu', 'ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux113 ux117 ux22478 ux21410 ux21306', 0, 0),
(1177, 1175, '350303', '涵江区', 3, '0594', '区', 100, 'han jiang qu', 'ux104 ux97 ux110 ux106 ux105 ux103 ux113 ux117 ux28085 ux27743 ux21306', 0, 0),
(1178, 1175, '350304', '荔城区', 3, '0594', '区', 100, 'li cheng qu', 'ux108 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux33620 ux22478 ux21306', 0, 0),
(1179, 1175, '350305', '秀屿区', 3, '0594', '区', 100, 'xiu yu qu', 'ux120 ux105 ux117 ux121 ux113 ux31168 ux23679 ux21306', 0, 0),
(1180, 1175, '350322', '仙游县', 3, '0594', '区', 100, 'xian you xian', 'ux120 ux105 ux97 ux110 ux121 ux111 ux117 ux20185 ux28216 ux21439', 0, 0),
(1181, 1153, '350400', '三明市', 2, '0598', '市', 100, 'san ming shi', 'ux115 ux97 ux110 ux109 ux105 ux103 ux104 ux19977 ux26126 ux24066', 0, 0),
(1182, 1181, '350402', '梅列区', 3, '0598', '区', 100, 'mei lie qu', 'ux109 ux101 ux105 ux108 ux113 ux117 ux26757 ux21015 ux21306', 0, 0),
(1183, 1181, '350403', '三元区', 3, '0598', '区', 100, 'san yuan qu', 'ux115 ux97 ux110 ux121 ux117 ux113 ux19977 ux20803 ux21306', 0, 0),
(1184, 1181, '350421', '明溪县', 3, '0598', '区', 100, 'ming xi xian', 'ux109 ux105 ux110 ux103 ux120 ux97 ux26126 ux28330 ux21439', 0, 0),
(1185, 1181, '350423', '清流县', 3, '0598', '区', 100, 'qing liu xian', 'ux113 ux105 ux110 ux103 ux108 ux117 ux120 ux97 ux28165 ux27969 ux21439', 0, 0),
(1186, 1181, '350424', '宁化县', 3, '0598', '区', 100, 'ning hua xian', 'ux110 ux105 ux103 ux104 ux117 ux97 ux120 ux23425 ux21270 ux21439', 0, 0),
(1187, 1181, '350425', '大田县', 3, '0598', '区', 100, 'da tian xian', 'ux100 ux97 ux116 ux105 ux110 ux120 ux22823 ux30000 ux21439', 0, 0),
(1188, 1181, '350426', '尤溪县', 3, '0598', '区', 100, 'you xi xian', 'ux121 ux111 ux117 ux120 ux105 ux97 ux110 ux23588 ux28330 ux21439', 0, 0),
(1189, 1181, '350427', '沙县', 3, '0598', '区', 100, 'sha xian', 'ux115 ux104 ux97 ux120 ux105 ux110 ux27801 ux21439', 0, 0),
(1190, 1181, '350428', '将乐县', 3, '0598', '区', 100, 'jiang le xian', 'ux106 ux105 ux97 ux110 ux103 ux108 ux101 ux120 ux23558 ux20048 ux21439', 0, 0),
(1191, 1181, '350429', '泰宁县', 3, '0598', '区', 100, 'tai ning xian', 'ux116 ux97 ux105 ux110 ux103 ux120 ux27888 ux23425 ux21439', 0, 0),
(1192, 1181, '350430', '建宁县', 3, '0598', '区', 100, 'jian ning xian', 'ux106 ux105 ux97 ux110 ux103 ux120 ux24314 ux23425 ux21439', 0, 0),
(1193, 1181, '350481', '永安市', 3, '0598', '区', 100, 'yong an shi', 'ux121 ux111 ux110 ux103 ux97 ux115 ux104 ux105 ux27704 ux23433 ux24066', 0, 0),
(1194, 1153, '350500', '泉州市', 2, '0595', '市', 100, 'quan zhou shi', 'ux113 ux117 ux97 ux110 ux122 ux104 ux111 ux115 ux105 ux27849 ux24030 ux24066', 0, 0),
(1195, 1194, '350502', '鲤城区', 3, '0595', '区', 100, 'li cheng qu', 'ux108 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux40100 ux22478 ux21306', 0, 0),
(1196, 1194, '350503', '丰泽区', 3, '0595', '区', 100, 'feng ze qu', 'ux102 ux101 ux110 ux103 ux122 ux113 ux117 ux20016 ux27901 ux21306', 0, 0),
(1197, 1194, '350504', '洛江区', 3, '0595', '区', 100, 'luo jiang qu', 'ux108 ux117 ux111 ux106 ux105 ux97 ux110 ux103 ux113 ux27931 ux27743 ux21306', 0, 0),
(1198, 1194, '350505', '泉港区', 3, '0595', '区', 100, 'quan gang qu', 'ux113 ux117 ux97 ux110 ux103 ux27849 ux28207 ux21306', 0, 0),
(1199, 1194, '350521', '惠安县', 3, '0595', '区', 100, 'hui an xian', 'ux104 ux117 ux105 ux97 ux110 ux120 ux24800 ux23433 ux21439', 0, 0),
(1200, 1194, '350524', '安溪县', 3, '0595', '区', 100, 'an xi xian', 'ux97 ux110 ux120 ux105 ux23433 ux28330 ux21439', 0, 0),
(1201, 1194, '350525', '永春县', 3, '0595', '区', 100, 'yong chun xian', 'ux121 ux111 ux110 ux103 ux99 ux104 ux117 ux120 ux105 ux97 ux27704 ux26149 ux21439', 0, 0),
(1202, 1194, '350526', '德化县', 3, '0595', '区', 100, 'de hua xian', 'ux100 ux101 ux104 ux117 ux97 ux120 ux105 ux110 ux24503 ux21270 ux21439', 0, 0),
(1203, 1194, '350527', '金门县', 3, '0595', '区', 100, 'jin men xian', 'ux106 ux105 ux110 ux109 ux101 ux120 ux97 ux37329 ux38376 ux21439', 0, 0),
(1204, 1194, '350581', '石狮市', 3, '0595', '区', 100, 'shi shi shi', 'ux115 ux104 ux105 ux30707 ux29422 ux24066', 0, 0),
(1205, 1194, '350582', '晋江市', 3, '0595', '区', 100, 'jin jiang shi', 'ux106 ux105 ux110 ux97 ux103 ux115 ux104 ux26187 ux27743 ux24066', 0, 0),
(1206, 1194, '350583', '南安市', 3, '0595', '区', 100, 'nan an shi', 'ux110 ux97 ux115 ux104 ux105 ux21335 ux23433 ux24066', 0, 0),
(1207, 1153, '350600', '漳州市', 2, '0596', '市', 100, 'zhang zhou shi', 'ux122 ux104 ux97 ux110 ux103 ux111 ux117 ux115 ux105 ux28467 ux24030 ux24066', 0, 0),
(1208, 1207, '350602', '芗城区', 3, '0596', '区', 100, 'xiang cheng qu', 'ux120 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux33431 ux22478 ux21306', 0, 0),
(1209, 1207, '350603', '龙文区', 3, '0596', '区', 100, 'long wen qu', 'ux108 ux111 ux110 ux103 ux119 ux101 ux113 ux117 ux40857 ux25991 ux21306', 0, 0),
(1210, 1207, '350622', '云霄县', 3, '0596', '区', 100, 'yun xiao xian', 'ux121 ux117 ux110 ux120 ux105 ux97 ux111 ux20113 ux38660 ux21439', 0, 0),
(1211, 1207, '350623', '漳浦县', 3, '0596', '区', 100, 'zhang pu xian', 'ux122 ux104 ux97 ux110 ux103 ux112 ux117 ux120 ux105 ux28467 ux28006 ux21439', 0, 0),
(1212, 1207, '350624', '诏安县', 3, '0596', '区', 100, 'zhao an xian', 'ux122 ux104 ux97 ux111 ux110 ux120 ux105 ux35791 ux23433 ux21439', 0, 0),
(1213, 1207, '350625', '长泰县', 3, '0596', '区', 100, 'chang tai xian', 'ux99 ux104 ux97 ux110 ux103 ux116 ux105 ux120 ux38271 ux27888 ux21439', 0, 0),
(1214, 1207, '350626', '东山县', 3, '0596', '区', 100, 'dong shan xian', 'ux100 ux111 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux19996 ux23665 ux21439', 0, 0),
(1215, 1207, '350627', '南靖县', 3, '0596', '区', 100, 'nan jing xian', 'ux110 ux97 ux106 ux105 ux103 ux120 ux21335 ux38742 ux21439', 0, 0),
(1216, 1207, '350628', '平和县', 3, '0596', '区', 100, 'ping he xian', 'ux112 ux105 ux110 ux103 ux104 ux101 ux120 ux97 ux24179 ux21644 ux21439', 0, 0),
(1217, 1207, '350629', '华安县', 3, '0596', '区', 100, 'hua an xian', 'ux104 ux117 ux97 ux110 ux120 ux105 ux21326 ux23433 ux21439', 0, 0),
(1218, 1207, '350681', '龙海市', 3, '0596', '区', 100, 'long hai shi', 'ux108 ux111 ux110 ux103 ux104 ux97 ux105 ux115 ux40857 ux28023 ux24066', 0, 0),
(1219, 1153, '350700', '南平市', 2, '0599', '市', 100, 'nan ping shi', 'ux110 ux97 ux112 ux105 ux103 ux115 ux104 ux21335 ux24179 ux24066', 0, 0),
(1220, 1219, '350702', '延平区', 3, '0599', '区', 100, 'yan ping qu', 'ux121 ux97 ux110 ux112 ux105 ux103 ux113 ux117 ux24310 ux24179 ux21306', 0, 0),
(1221, 1219, '350721', '顺昌县', 3, '0599', '区', 100, 'shun chang xian', 'ux115 ux104 ux117 ux110 ux99 ux97 ux103 ux120 ux105 ux39034 ux26124 ux21439', 0, 0),
(1222, 1219, '350722', '浦城县', 3, '0599', '区', 100, 'pu cheng xian', 'ux112 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux28006 ux22478 ux21439', 0, 0),
(1223, 1219, '350723', '光泽县', 3, '0599', '区', 100, 'guang ze xian', 'ux103 ux117 ux97 ux110 ux122 ux101 ux120 ux105 ux20809 ux27901 ux21439', 0, 0),
(1224, 1219, '350724', '松溪县', 3, '0599', '区', 100, 'song xi xian', 'ux115 ux111 ux110 ux103 ux120 ux105 ux97 ux26494 ux28330 ux21439', 0, 0),
(1225, 1219, '350725', '政和县', 3, '0599', '区', 100, 'zheng he xian', 'ux122 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux25919 ux21644 ux21439', 0, 0),
(1226, 1219, '350781', '邵武市', 3, '0599', '区', 100, 'shao wu shi', 'ux115 ux104 ux97 ux111 ux119 ux117 ux105 ux37045 ux27494 ux24066', 0, 0),
(1227, 1219, '350782', '武夷山市', 3, '0599', '区', 100, 'wu yi shan shi', 'ux119 ux117 ux121 ux105 ux115 ux104 ux97 ux110 ux27494 ux22839 ux23665 ux24066', 0, 0),
(1228, 1219, '350783', '建瓯市', 3, '0599', '区', 100, 'jian ou shi', 'ux106 ux105 ux97 ux110 ux111 ux117 ux115 ux104 ux24314 ux29935 ux24066', 0, 0),
(1229, 1219, '350784', '建阳市', 3, '0599', '区', 100, 'jian yang shi', 'ux106 ux105 ux97 ux110 ux121 ux103 ux115 ux104 ux24314 ux38451 ux24066', 0, 0),
(1230, 1153, '350800', '龙岩市', 2, '0597', '市', 100, 'long yan shi', 'ux108 ux111 ux110 ux103 ux121 ux97 ux115 ux104 ux105 ux40857 ux23721 ux24066', 0, 0),
(1231, 1230, '350802', '新罗区', 3, '0597', '区', 100, 'xin luo qu', 'ux120 ux105 ux110 ux108 ux117 ux111 ux113 ux26032 ux32599 ux21306', 0, 0),
(1232, 1230, '350821', '长汀县', 3, '0597', '区', 100, 'chang ting xian', 'ux99 ux104 ux97 ux110 ux103 ux116 ux105 ux120 ux38271 ux27712 ux21439', 0, 0),
(1233, 1230, '350822', '永定县', 3, '0597', '区', 100, 'yong ding xian', 'ux121 ux111 ux110 ux103 ux100 ux105 ux120 ux97 ux27704 ux23450 ux21439', 0, 0),
(1234, 1230, '350823', '上杭县', 3, '0597', '区', 100, 'shang hang xian', 'ux115 ux104 ux97 ux110 ux103 ux120 ux105 ux19978 ux26477 ux21439', 0, 0),
(1235, 1230, '350824', '武平县', 3, '0597', '区', 100, 'wu ping xian', 'ux119 ux117 ux112 ux105 ux110 ux103 ux120 ux97 ux27494 ux24179 ux21439', 0, 0),
(1236, 1230, '350825', '连城县', 3, '0597', '区', 100, 'lian cheng xian', 'ux108 ux105 ux97 ux110 ux99 ux104 ux101 ux103 ux120 ux36830 ux22478 ux21439', 0, 0),
(1237, 1230, '350881', '漳平市', 3, '0597', '区', 100, 'zhang ping shi', 'ux122 ux104 ux97 ux110 ux103 ux112 ux105 ux115 ux28467 ux24179 ux24066', 0, 0),
(1238, 1153, '350900', '宁德市', 2, '0593', '市', 100, 'ning de shi', 'ux110 ux105 ux103 ux100 ux101 ux115 ux104 ux23425 ux24503 ux24066', 0, 0),
(1239, 1238, '350902', '蕉城区', 3, '0593', '区', 100, 'jiao cheng qu', 'ux106 ux105 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux34121 ux22478 ux21306', 0, 0),
(1240, 1238, '350921', '霞浦县', 3, '0593', '区', 100, 'xia pu xian', 'ux120 ux105 ux97 ux112 ux117 ux110 ux38686 ux28006 ux21439', 0, 0),
(1241, 1238, '350922', '古田县', 3, '0593', '区', 100, 'gu tian xian', 'ux103 ux117 ux116 ux105 ux97 ux110 ux120 ux21476 ux30000 ux21439', 0, 0),
(1242, 1238, '350923', '屏南县', 3, '0593', '区', 100, 'ping nan xian', 'ux112 ux105 ux110 ux103 ux97 ux120 ux23631 ux21335 ux21439', 0, 0),
(1243, 1238, '350924', '寿宁县', 3, '0593', '区', 100, 'shou ning xian', 'ux115 ux104 ux111 ux117 ux110 ux105 ux103 ux120 ux97 ux23551 ux23425 ux21439', 0, 0),
(1244, 1238, '350925', '周宁县', 3, '0593', '区', 100, 'zhou ning xian', 'ux122 ux104 ux111 ux117 ux110 ux105 ux103 ux120 ux97 ux21608 ux23425 ux21439', 0, 0),
(1245, 1238, '350926', '柘荣县', 3, '0593', '区', 100, 'zhe rong xian', 'ux122 ux104 ux101 ux114 ux111 ux110 ux103 ux120 ux105 ux97 ux26584 ux33635 ux21439', 0, 0),
(1246, 1238, '350981', '福安市', 3, '0593', '区', 100, 'fu an shi', 'ux102 ux117 ux97 ux110 ux115 ux104 ux105 ux31119 ux23433 ux24066', 0, 0),
(1247, 1238, '350982', '福鼎市', 3, '0593', '区', 100, 'fu ding shi', 'ux102 ux117 ux100 ux105 ux110 ux103 ux115 ux104 ux31119 ux40718 ux24066', 0, 0),
(1248, 0, '360000', '江西省', 1, '', '省', 100, 'jiang xi sheng', 'ux106 ux105 ux97 ux110 ux103 ux120 ux115 ux104 ux101 ux27743 ux35199 ux30465', 0, 0),
(1249, 1248, '360100', '南昌市', 2, '0791', '市', 100, 'nan chang shi', 'ux110 ux97 ux99 ux104 ux103 ux115 ux105 ux21335 ux26124 ux24066', 0, 0),
(1250, 1249, '360102', '东湖区', 3, '0791', '区', 100, 'dong hu qu', 'ux100 ux111 ux110 ux103 ux104 ux117 ux113 ux19996 ux28246 ux21306', 0, 0),
(1251, 1249, '360103', '西湖区', 3, '0791', '区', 100, 'xi hu qu', 'ux120 ux105 ux104 ux117 ux113 ux35199 ux28246 ux21306', 0, 0),
(1252, 1249, '360104', '青云谱区', 3, '0791', '区', 100, 'qing yun pu qu', 'ux113 ux105 ux110 ux103 ux121 ux117 ux112 ux38738 ux20113 ux35889 ux21306', 0, 0),
(1253, 1249, '360105', '湾里区', 3, '0791', '区', 100, 'wan li qu', 'ux119 ux97 ux110 ux108 ux105 ux113 ux117 ux28286 ux37324 ux21306', 0, 0),
(1254, 1249, '360111', '青山湖区', 3, '0791', '区', 100, 'qing shan hu qu', 'ux113 ux105 ux110 ux103 ux115 ux104 ux97 ux117 ux38738 ux23665 ux28246 ux21306', 0, 0),
(1255, 1249, '360121', '南昌县', 3, '0791', '区', 100, 'nan chang xian', 'ux110 ux97 ux99 ux104 ux103 ux120 ux105 ux21335 ux26124 ux21439', 0, 0),
(1256, 1249, '360122', '新建县', 3, '0791', '区', 100, 'xin jian xian', 'ux120 ux105 ux110 ux106 ux97 ux26032 ux24314 ux21439', 0, 0),
(1257, 1249, '360123', '安义县', 3, '0791', '区', 100, 'an yi xian', 'ux97 ux110 ux121 ux105 ux120 ux23433 ux20041 ux21439', 0, 0),
(1258, 1249, '360124', '进贤县', 3, '0791', '区', 100, 'jin xian xian', 'ux106 ux105 ux110 ux120 ux97 ux36827 ux36132 ux21439', 0, 0),
(1259, 1248, '360200', '景德镇市', 2, '0798', '市', 100, 'jing de zhen shi', 'ux106 ux105 ux110 ux103 ux100 ux101 ux122 ux104 ux115 ux26223 ux24503 ux38215 ux24066', 0, 0),
(1260, 1259, '360202', '昌江区', 3, '0798', '区', 100, 'chang jiang qu', 'ux99 ux104 ux97 ux110 ux103 ux106 ux105 ux113 ux117 ux26124 ux27743 ux21306', 0, 0),
(1261, 1259, '360203', '珠山区', 3, '0798', '区', 100, 'zhu shan qu', 'ux122 ux104 ux117 ux115 ux97 ux110 ux113 ux29664 ux23665 ux21306', 0, 0),
(1262, 1259, '360222', '浮梁县', 3, '0798', '区', 100, 'fu liang xian', 'ux102 ux117 ux108 ux105 ux97 ux110 ux103 ux120 ux28014 ux26753 ux21439', 0, 0),
(1263, 1259, '360281', '乐平市', 3, '0798', '区', 100, 'le ping shi', 'ux108 ux101 ux112 ux105 ux110 ux103 ux115 ux104 ux20048 ux24179 ux24066', 0, 0),
(1264, 1248, '360300', '萍乡市', 2, '0799', '市', 100, 'ping xiang shi', 'ux112 ux105 ux110 ux103 ux120 ux97 ux115 ux104 ux33805 ux20065 ux24066', 0, 0),
(1265, 1264, '360302', '安源区', 3, '0799', '区', 100, 'an yuan qu', 'ux97 ux110 ux121 ux117 ux113 ux23433 ux28304 ux21306', 0, 0),
(1266, 1264, '360313', '湘东区', 3, '0799', '区', 100, 'xiang dong qu', 'ux120 ux105 ux97 ux110 ux103 ux100 ux111 ux113 ux117 ux28248 ux19996 ux21306', 0, 0),
(1267, 1264, '360321', '莲花县', 3, '0799', '区', 100, 'lian hua xian', 'ux108 ux105 ux97 ux110 ux104 ux117 ux120 ux33714 ux33457 ux21439', 0, 0),
(1268, 1264, '360322', '上栗县', 3, '0799', '区', 100, 'shang li xian', 'ux115 ux104 ux97 ux110 ux103 ux108 ux105 ux120 ux19978 ux26647 ux21439', 0, 0),
(1269, 1264, '360323', '芦溪县', 3, '0799', '区', 100, 'lu xi xian', 'ux108 ux117 ux120 ux105 ux97 ux110 ux33446 ux28330 ux21439', 0, 0),
(1270, 1248, '360400', '九江市', 2, '0792', '市', 100, 'jiu jiang shi', 'ux106 ux105 ux117 ux97 ux110 ux103 ux115 ux104 ux20061 ux27743 ux24066', 0, 0),
(1271, 1270, '360402', '庐山区', 3, '0792', '区', 100, 'lu shan qu', 'ux108 ux117 ux115 ux104 ux97 ux110 ux113 ux24208 ux23665 ux21306', 0, 0),
(1272, 1270, '360403', '浔阳区', 3, '0792', '区', 100, 'xun yang qu', 'ux120 ux117 ux110 ux121 ux97 ux103 ux113 ux27988 ux38451 ux21306', 0, 0),
(1273, 1270, '360421', '九江县', 3, '0792', '区', 100, 'jiu jiang xian', 'ux106 ux105 ux117 ux97 ux110 ux103 ux120 ux20061 ux27743 ux21439', 0, 0),
(1274, 1270, '360423', '武宁县', 3, '0792', '区', 100, 'wu ning xian', 'ux119 ux117 ux110 ux105 ux103 ux120 ux97 ux27494 ux23425 ux21439', 0, 0),
(1275, 1270, '360424', '修水县', 3, '0792', '区', 100, 'xiu shui xian', 'ux120 ux105 ux117 ux115 ux104 ux97 ux110 ux20462 ux27700 ux21439', 0, 0),
(1276, 1270, '360425', '永修县', 3, '0792', '区', 100, 'yong xiu xian', 'ux121 ux111 ux110 ux103 ux120 ux105 ux117 ux97 ux27704 ux20462 ux21439', 0, 0),
(1277, 1270, '360426', '德安县', 3, '0792', '区', 100, 'de an xian', 'ux100 ux101 ux97 ux110 ux120 ux105 ux24503 ux23433 ux21439', 0, 0),
(1278, 1270, '360427', '星子县', 3, '0792', '区', 100, 'xing zi xian', 'ux120 ux105 ux110 ux103 ux122 ux97 ux26143 ux23376 ux21439', 0, 0),
(1279, 1270, '360428', '都昌县', 3, '0792', '区', 100, 'du chang xian', 'ux100 ux117 ux99 ux104 ux97 ux110 ux103 ux120 ux105 ux37117 ux26124 ux21439', 0, 0),
(1280, 1270, '360429', '湖口县', 3, '0792', '区', 100, 'hu kou xian', 'ux104 ux117 ux107 ux111 ux120 ux105 ux97 ux110 ux28246 ux21475 ux21439', 0, 0),
(1281, 1270, '360430', '彭泽县', 3, '0792', '区', 100, 'peng ze xian', 'ux112 ux101 ux110 ux103 ux122 ux120 ux105 ux97 ux24429 ux27901 ux21439', 0, 0),
(1282, 1270, '360481', '瑞昌市', 3, '0792', '区', 100, 'rui chang shi', 'ux114 ux117 ux105 ux99 ux104 ux97 ux110 ux103 ux115 ux29790 ux26124 ux24066', 0, 0),
(1283, 1270, '360482', '共青城市', 3, '0792', '区', 100, 'gong qing cheng shi', 'ux103 ux111 ux110 ux113 ux105 ux99 ux104 ux101 ux115 ux20849 ux38738 ux22478 ux24066', 0, 0),
(1284, 1248, '360500', '新余市', 2, '0790', '市', 100, 'xin yu shi', 'ux120 ux105 ux110 ux121 ux117 ux115 ux104 ux26032 ux20313 ux24066', 0, 0),
(1285, 1284, '360502', '渝水区', 3, '0790', '区', 100, 'yu shui qu', 'ux121 ux117 ux115 ux104 ux105 ux113 ux28189 ux27700 ux21306', 0, 0),
(1286, 1284, '360521', '分宜县', 3, '0790', '区', 100, 'fen yi xian', 'ux102 ux101 ux110 ux121 ux105 ux120 ux97 ux20998 ux23452 ux21439', 0, 0),
(1287, 1248, '360600', '鹰潭市', 2, '0701', '市', 100, 'ying tan shi', 'ux121 ux105 ux110 ux103 ux116 ux97 ux115 ux104 ux40560 ux28525 ux24066', 0, 0),
(1288, 1287, '360602', '月湖区', 3, '0701', '区', 100, 'yue hu qu', 'ux121 ux117 ux101 ux104 ux113 ux26376 ux28246 ux21306', 0, 0),
(1289, 1287, '360622', '余江县', 3, '0701', '区', 100, 'yu jiang xian', 'ux121 ux117 ux106 ux105 ux97 ux110 ux103 ux120 ux20313 ux27743 ux21439', 0, 0),
(1290, 1287, '360681', '贵溪市', 3, '0701', '区', 100, 'gui xi shi', 'ux103 ux117 ux105 ux120 ux115 ux104 ux36149 ux28330 ux24066', 0, 0),
(1291, 1248, '360700', '赣州市', 2, '0797', '市', 100, 'gan zhou shi', 'ux103 ux97 ux110 ux122 ux104 ux111 ux117 ux115 ux105 ux36195 ux24030 ux24066', 0, 0),
(1292, 1291, '360702', '章贡区', 3, '0797', '区', 100, 'zhang gong qu', 'ux122 ux104 ux97 ux110 ux103 ux111 ux113 ux117 ux31456 ux36129 ux21306', 0, 0),
(1293, 1291, '360721', '赣县', 3, '0797', '区', 100, 'gan xian', 'ux103 ux97 ux110 ux120 ux105 ux36195 ux21439', 0, 0),
(1294, 1291, '360722', '信丰县', 3, '0797', '区', 100, 'xin feng xian', 'ux120 ux105 ux110 ux102 ux101 ux103 ux97 ux20449 ux20016 ux21439', 0, 0),
(1295, 1291, '360723', '大余县', 3, '0797', '区', 100, 'da yu xian', 'ux100 ux97 ux121 ux117 ux120 ux105 ux110 ux22823 ux20313 ux21439', 0, 0),
(1296, 1291, '360724', '上犹县', 3, '0797', '区', 100, 'shang you xian', 'ux115 ux104 ux97 ux110 ux103 ux121 ux111 ux117 ux120 ux105 ux19978 ux29369 ux21439', 0, 0),
(1297, 1291, '360725', '崇义县', 3, '0797', '区', 100, 'chong yi xian', 'ux99 ux104 ux111 ux110 ux103 ux121 ux105 ux120 ux97 ux23815 ux20041 ux21439', 0, 0),
(1298, 1291, '360726', '安远县', 3, '0797', '区', 100, 'an yuan xian', 'ux97 ux110 ux121 ux117 ux120 ux105 ux23433 ux36828 ux21439', 0, 0),
(1299, 1291, '360727', '龙南县', 3, '0797', '区', 100, 'long nan xian', 'ux108 ux111 ux110 ux103 ux97 ux120 ux105 ux40857 ux21335 ux21439', 0, 0),
(1300, 1291, '360728', '定南县', 3, '0797', '区', 100, 'ding nan xian', 'ux100 ux105 ux110 ux103 ux97 ux120 ux23450 ux21335 ux21439', 0, 0),
(1301, 1291, '360729', '全南县', 3, '0797', '区', 100, 'quan nan xian', 'ux113 ux117 ux97 ux110 ux120 ux105 ux20840 ux21335 ux21439', 0, 0),
(1302, 1291, '360730', '宁都县', 3, '0797', '区', 100, 'ning du xian', 'ux110 ux105 ux103 ux100 ux117 ux120 ux97 ux23425 ux37117 ux21439', 0, 0),
(1303, 1291, '360731', '于都县', 3, '0797', '区', 100, 'yu du xian', 'ux121 ux117 ux100 ux120 ux105 ux97 ux110 ux20110 ux37117 ux21439', 0, 0),
(1304, 1291, '360732', '兴国县', 3, '0797', '区', 100, 'xing guo xian', 'ux120 ux105 ux110 ux103 ux117 ux111 ux97 ux20852 ux22269 ux21439', 0, 0),
(1305, 1291, '360733', '会昌县', 3, '0797', '区', 100, 'hui chang xian', 'ux104 ux117 ux105 ux99 ux97 ux110 ux103 ux120 ux20250 ux26124 ux21439', 0, 0),
(1306, 1291, '360734', '寻乌县', 3, '0797', '区', 100, 'xun wu xian', 'ux120 ux117 ux110 ux119 ux105 ux97 ux23547 ux20044 ux21439', 0, 0),
(1307, 1291, '360735', '石城县', 3, '0797', '区', 100, 'shi cheng xian', 'ux115 ux104 ux105 ux99 ux101 ux110 ux103 ux120 ux97 ux30707 ux22478 ux21439', 0, 0),
(1308, 1291, '360781', '瑞金市', 3, '0797', '区', 100, 'rui jin shi', 'ux114 ux117 ux105 ux106 ux110 ux115 ux104 ux29790 ux37329 ux24066', 0, 0),
(1309, 1291, '360782', '南康市', 3, '0797', '区', 100, 'nan kang shi', 'ux110 ux97 ux107 ux103 ux115 ux104 ux105 ux21335 ux24247 ux24066', 0, 0),
(1310, 1248, '360800', '吉安市', 2, '0796', '市', 100, 'ji an shi', 'ux106 ux105 ux97 ux110 ux115 ux104 ux21513 ux23433 ux24066', 0, 0),
(1311, 1310, '360802', '吉州区', 3, '0796', '区', 100, 'ji zhou qu', 'ux106 ux105 ux122 ux104 ux111 ux117 ux113 ux21513 ux24030 ux21306', 0, 0),
(1312, 1310, '360803', '青原区', 3, '0796', '区', 100, 'qing yuan qu', 'ux113 ux105 ux110 ux103 ux121 ux117 ux97 ux38738 ux21407 ux21306', 0, 0),
(1313, 1310, '360821', '吉安县', 3, '0796', '区', 100, 'ji an xian', 'ux106 ux105 ux97 ux110 ux120 ux21513 ux23433 ux21439', 0, 0),
(1314, 1310, '360822', '吉水县', 3, '0796', '区', 100, 'ji shui xian', 'ux106 ux105 ux115 ux104 ux117 ux120 ux97 ux110 ux21513 ux27700 ux21439', 0, 0),
(1315, 1310, '360823', '峡江县', 3, '0796', '区', 100, 'xia jiang xian', 'ux120 ux105 ux97 ux106 ux110 ux103 ux23777 ux27743 ux21439', 0, 0),
(1316, 1310, '360824', '新干县', 3, '0796', '区', 100, 'xin gan xian', 'ux120 ux105 ux110 ux103 ux97 ux26032 ux24178 ux21439', 0, 0),
(1317, 1310, '360825', '永丰县', 3, '0796', '区', 100, 'yong feng xian', 'ux121 ux111 ux110 ux103 ux102 ux101 ux120 ux105 ux97 ux27704 ux20016 ux21439', 0, 0),
(1318, 1310, '360826', '泰和县', 3, '0796', '区', 100, 'tai he xian', 'ux116 ux97 ux105 ux104 ux101 ux120 ux110 ux27888 ux21644 ux21439', 0, 0),
(1319, 1310, '360827', '遂川县', 3, '0796', '区', 100, 'sui chuan xian', 'ux115 ux117 ux105 ux99 ux104 ux97 ux110 ux120 ux36930 ux24029 ux21439', 0, 0),
(1320, 1310, '360828', '万安县', 3, '0796', '区', 100, 'wan an xian', 'ux119 ux97 ux110 ux120 ux105 ux19975 ux23433 ux21439', 0, 0),
(1321, 1310, '360829', '安福县', 3, '0796', '区', 100, 'an fu xian', 'ux97 ux110 ux102 ux117 ux120 ux105 ux23433 ux31119 ux21439', 0, 0),
(1322, 1310, '360830', '永新县', 3, '0796', '区', 100, 'yong xin xian', 'ux121 ux111 ux110 ux103 ux120 ux105 ux97 ux27704 ux26032 ux21439', 0, 0),
(1323, 1310, '360881', '井冈山市', 3, '0796', '区', 100, 'jing gang shan shi', 'ux106 ux105 ux110 ux103 ux97 ux115 ux104 ux20117 ux20872 ux23665 ux24066', 0, 0),
(1324, 1248, '360900', '宜春市', 2, '0795', '市', 100, 'yi chun shi', 'ux121 ux105 ux99 ux104 ux117 ux110 ux115 ux23452 ux26149 ux24066', 0, 0),
(1325, 1324, '360902', '袁州区', 3, '0795', '区', 100, 'yuan zhou qu', 'ux121 ux117 ux97 ux110 ux122 ux104 ux111 ux113 ux34945 ux24030 ux21306', 0, 0),
(1326, 1324, '360921', '奉新县', 3, '0795', '区', 100, 'feng xin xian', 'ux102 ux101 ux110 ux103 ux120 ux105 ux97 ux22857 ux26032 ux21439', 0, 0),
(1327, 1324, '360922', '万载县', 3, '0795', '区', 100, 'wan zai xian', 'ux119 ux97 ux110 ux122 ux105 ux120 ux19975 ux36733 ux21439', 0, 0),
(1328, 1324, '360923', '上高县', 3, '0795', '区', 100, 'shang gao xian', 'ux115 ux104 ux97 ux110 ux103 ux111 ux120 ux105 ux19978 ux39640 ux21439', 0, 0),
(1329, 1324, '360924', '宜丰县', 3, '0795', '区', 100, 'yi feng xian', 'ux121 ux105 ux102 ux101 ux110 ux103 ux120 ux97 ux23452 ux20016 ux21439', 0, 0),
(1330, 1324, '360925', '靖安县', 3, '0795', '区', 100, 'jing an xian', 'ux106 ux105 ux110 ux103 ux97 ux120 ux38742 ux23433 ux21439', 0, 0),
(1331, 1324, '360926', '铜鼓县', 3, '0795', '区', 100, 'tong gu xian', 'ux116 ux111 ux110 ux103 ux117 ux120 ux105 ux97 ux38108 ux40723 ux21439', 0, 0),
(1332, 1324, '360981', '丰城市', 3, '0795', '区', 100, 'feng cheng shi', 'ux102 ux101 ux110 ux103 ux99 ux104 ux115 ux105 ux20016 ux22478 ux24066', 0, 0),
(1333, 1324, '360982', '樟树市', 3, '0795', '区', 100, 'zhang shu shi', 'ux122 ux104 ux97 ux110 ux103 ux115 ux117 ux105 ux27167 ux26641 ux24066', 0, 0),
(1334, 1324, '360983', '高安市', 3, '0795', '区', 100, 'gao an shi', 'ux103 ux97 ux111 ux110 ux115 ux104 ux105 ux39640 ux23433 ux24066', 0, 0),
(1335, 1248, '361000', '抚州市', 2, '0794', '市', 100, 'fu zhou shi', 'ux102 ux117 ux122 ux104 ux111 ux115 ux105 ux25242 ux24030 ux24066', 0, 0),
(1336, 1335, '361002', '临川区', 3, '0794', '区', 100, 'lin chuan qu', 'ux108 ux105 ux110 ux99 ux104 ux117 ux97 ux113 ux20020 ux24029 ux21306', 0, 0),
(1337, 1335, '361021', '南城县', 3, '0794', '区', 100, 'nan cheng xian', 'ux110 ux97 ux99 ux104 ux101 ux103 ux120 ux105 ux21335 ux22478 ux21439', 0, 0),
(1338, 1335, '361022', '黎川县', 3, '0794', '区', 100, 'li chuan xian', 'ux108 ux105 ux99 ux104 ux117 ux97 ux110 ux120 ux40654 ux24029 ux21439', 0, 0),
(1339, 1335, '361023', '南丰县', 3, '0794', '区', 100, 'nan feng xian', 'ux110 ux97 ux102 ux101 ux103 ux120 ux105 ux21335 ux20016 ux21439', 0, 0),
(1340, 1335, '361024', '崇仁县', 3, '0794', '区', 100, 'chong ren xian', 'ux99 ux104 ux111 ux110 ux103 ux114 ux101 ux120 ux105 ux97 ux23815 ux20161 ux21439', 0, 0),
(1341, 1335, '361025', '乐安县', 3, '0794', '区', 100, 'le an xian', 'ux108 ux101 ux97 ux110 ux120 ux105 ux20048 ux23433 ux21439', 0, 0),
(1342, 1335, '361026', '宜黄县', 3, '0794', '区', 100, 'yi huang xian', 'ux121 ux105 ux104 ux117 ux97 ux110 ux103 ux120 ux23452 ux40644 ux21439', 0, 0),
(1343, 1335, '361027', '金溪县', 3, '0794', '区', 100, 'jin xi xian', 'ux106 ux105 ux110 ux120 ux97 ux37329 ux28330 ux21439', 0, 0),
(1344, 1335, '361028', '资溪县', 3, '0794', '区', 100, 'zi xi xian', 'ux122 ux105 ux120 ux97 ux110 ux36164 ux28330 ux21439', 0, 0),
(1345, 1335, '361029', '东乡县', 3, '0794', '区', 100, 'dong xiang xian', 'ux100 ux111 ux110 ux103 ux120 ux105 ux97 ux19996 ux20065 ux21439', 0, 0),
(1346, 1335, '361030', '广昌县', 3, '0794', '区', 100, 'guang chang xian', 'ux103 ux117 ux97 ux110 ux99 ux104 ux120 ux105 ux24191 ux26124 ux21439', 0, 0),
(1347, 1248, '361100', '上饶市', 2, '0793', '市', 100, 'shang rao shi', 'ux115 ux104 ux97 ux110 ux103 ux114 ux111 ux105 ux19978 ux39286 ux24066', 0, 0),
(1348, 1347, '361102', '信州区', 3, '0793', '区', 100, 'xin zhou qu', 'ux120 ux105 ux110 ux122 ux104 ux111 ux117 ux113 ux20449 ux24030 ux21306', 0, 0),
(1349, 1347, '361121', '上饶县', 3, '0793', '区', 100, 'shang rao xian', 'ux115 ux104 ux97 ux110 ux103 ux114 ux111 ux120 ux105 ux19978 ux39286 ux21439', 0, 0),
(1350, 1347, '361122', '广丰县', 3, '0793', '区', 100, 'guang feng xian', 'ux103 ux117 ux97 ux110 ux102 ux101 ux120 ux105 ux24191 ux20016 ux21439', 0, 0),
(1351, 1347, '361123', '玉山县', 3, '0793', '区', 100, 'yu shan xian', 'ux121 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux29577 ux23665 ux21439', 0, 0),
(1352, 1347, '361124', '铅山县', 3, '0793', '区', 100, 'qian shan xian', 'ux113 ux105 ux97 ux110 ux115 ux104 ux120 ux38085 ux23665 ux21439', 0, 0),
(1353, 1347, '361125', '横峰县', 3, '0793', '区', 100, 'heng feng xian', 'ux104 ux101 ux110 ux103 ux102 ux120 ux105 ux97 ux27178 ux23792 ux21439', 0, 0),
(1354, 1347, '361126', '弋阳县', 3, '0793', '区', 100, 'yi yang xian', 'ux121 ux105 ux97 ux110 ux103 ux120 ux24331 ux38451 ux21439', 0, 0),
(1355, 1347, '361127', '余干县', 3, '0793', '区', 100, 'yu gan xian', 'ux121 ux117 ux103 ux97 ux110 ux120 ux105 ux20313 ux24178 ux21439', 0, 0),
(1356, 1347, '361128', '鄱阳县', 3, '0793', '区', 100, 'po yang xian', 'ux112 ux111 ux121 ux97 ux110 ux103 ux120 ux105 ux37169 ux38451 ux21439', 0, 0),
(1357, 1347, '361129', '万年县', 3, '0793', '区', 100, 'wan nian xian', 'ux119 ux97 ux110 ux105 ux120 ux19975 ux24180 ux21439', 0, 0),
(1358, 1347, '361130', '婺源县', 3, '0793', '区', 100, 'wu yuan xian', 'ux119 ux117 ux121 ux97 ux110 ux120 ux105 ux23162 ux28304 ux21439', 0, 0),
(1359, 1347, '361181', '德兴市', 3, '0793', '区', 100, 'de xing shi', 'ux100 ux101 ux120 ux105 ux110 ux103 ux115 ux104 ux24503 ux20852 ux24066', 0, 0),
(1360, 0, '370000', '山东省', 1, '', '省', 100, 'shan dong sheng', 'ux115 ux104 ux97 ux110 ux100 ux111 ux103 ux101 ux23665 ux19996 ux30465', 0, 0),
(1361, 1360, '370100', '济南市', 2, '0531', '市', 100, 'ji nan shi', 'ux106 ux105 ux110 ux97 ux115 ux104 ux27982 ux21335 ux24066', 0, 0),
(1362, 1361, '370102', '历下区', 3, '0531', '区', 100, 'li xia qu', 'ux108 ux105 ux120 ux97 ux113 ux117 ux21382 ux19979 ux21306', 0, 0),
(1363, 1361, '370103', '市中区', 3, '0531', '区', 100, 'shi zhong qu', 'ux115 ux104 ux105 ux122 ux111 ux110 ux103 ux113 ux117 ux24066 ux20013 ux21306', 0, 0),
(1364, 1361, '370104', '槐荫区', 3, '0531', '区', 100, 'huai yin qu', 'ux104 ux117 ux97 ux105 ux121 ux110 ux113 ux27088 ux33643 ux21306', 0, 0),
(1365, 1361, '370105', '天桥区', 3, '0531', '区', 100, 'tian qiao qu', 'ux116 ux105 ux97 ux110 ux113 ux111 ux117 ux22825 ux26725 ux21306', 0, 0),
(1366, 1361, '370112', '历城区', 3, '0531', '区', 100, 'li cheng qu', 'ux108 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux21382 ux22478 ux21306', 0, 0),
(1367, 1361, '370113', '长清区', 3, '0531', '区', 100, 'chang qing qu', 'ux99 ux104 ux97 ux110 ux103 ux113 ux105 ux117 ux38271 ux28165 ux21306', 0, 0),
(1368, 1361, '370124', '平阴县', 3, '0531', '区', 100, 'ping yin xian', 'ux112 ux105 ux110 ux103 ux121 ux120 ux97 ux24179 ux38452 ux21439', 0, 0),
(1369, 1361, '370125', '济阳县', 3, '0531', '区', 100, 'ji yang xian', 'ux106 ux105 ux121 ux97 ux110 ux103 ux120 ux27982 ux38451 ux21439', 0, 0),
(1370, 1361, '370126', '商河县', 3, '0531', '区', 100, 'shang he xian', 'ux115 ux104 ux97 ux110 ux103 ux101 ux120 ux105 ux21830 ux27827 ux21439', 0, 0),
(1371, 1361, '370181', '章丘市', 3, '0531', '区', 100, 'zhang qiu shi', 'ux122 ux104 ux97 ux110 ux103 ux113 ux105 ux117 ux115 ux31456 ux19992 ux24066', 0, 0),
(1372, 1360, '370200', '青岛市', 2, '0532', '市', 100, 'qing dao shi', 'ux113 ux105 ux110 ux103 ux100 ux97 ux111 ux115 ux104 ux38738 ux23707 ux24066', 0, 0),
(1373, 1372, '370202', '市南区', 3, '0532', '区', 100, 'shi nan qu', 'ux115 ux104 ux105 ux110 ux97 ux113 ux117 ux24066 ux21335 ux21306', 0, 0),
(1374, 1372, '370203', '市北区', 3, '0532', '区', 100, 'shi bei qu', 'ux115 ux104 ux105 ux98 ux101 ux113 ux117 ux24066 ux21271 ux21306', 0, 0),
(1375, 1372, '370205', '四方区', 3, '0532', '区', 100, 'si fang qu', 'ux115 ux105 ux102 ux97 ux110 ux103 ux113 ux117 ux22235 ux26041 ux21306', 0, 0),
(1376, 1372, '370211', '黄岛区', 3, '0532', '区', 100, 'huang dao qu', 'ux104 ux117 ux97 ux110 ux103 ux100 ux111 ux113 ux40644 ux23707 ux21306', 0, 0),
(1377, 1372, '370212', '崂山区', 3, '0532', '区', 100, 'lao shan qu', 'ux108 ux97 ux111 ux115 ux104 ux110 ux113 ux117 ux23810 ux23665 ux21306', 0, 0),
(1378, 1372, '370213', '李沧区', 3, '0532', '区', 100, 'li cang qu', 'ux108 ux105 ux99 ux97 ux110 ux103 ux113 ux117 ux26446 ux27815 ux21306', 0, 0),
(1379, 1372, '370214', '城阳区', 3, '0532', '区', 100, 'cheng yang qu', 'ux99 ux104 ux101 ux110 ux103 ux121 ux97 ux113 ux117 ux22478 ux38451 ux21306', 0, 0),
(1380, 1372, '370281', '胶州市', 3, '0532', '区', 100, 'jiao zhou shi', 'ux106 ux105 ux97 ux111 ux122 ux104 ux117 ux115 ux33014 ux24030 ux24066', 0, 0),
(1381, 1372, '370282', '即墨市', 3, '0532', '区', 100, 'ji mo shi', 'ux106 ux105 ux109 ux111 ux115 ux104 ux21363 ux22696 ux24066', 0, 0),
(1382, 1372, '370283', '平度市', 3, '0532', '区', 100, 'ping du shi', 'ux112 ux105 ux110 ux103 ux100 ux117 ux115 ux104 ux24179 ux24230 ux24066', 0, 0),
(1383, 1372, '370284', '胶南市', 3, '0532', '区', 100, 'jiao nan shi', 'ux106 ux105 ux97 ux111 ux110 ux115 ux104 ux33014 ux21335 ux24066', 0, 0),
(1384, 1372, '370285', '莱西市', 3, '0532', '区', 100, 'lai xi shi', 'ux108 ux97 ux105 ux120 ux115 ux104 ux33713 ux35199 ux24066', 0, 0),
(1385, 1360, '370300', '淄博市', 2, '0533', '市', 100, 'zi bo shi', 'ux122 ux105 ux98 ux111 ux115 ux104 ux28100 ux21338 ux24066', 0, 0),
(1386, 1385, '370302', '淄川区', 3, '0533', '区', 100, 'zi chuan qu', 'ux122 ux105 ux99 ux104 ux117 ux97 ux110 ux113 ux28100 ux24029 ux21306', 0, 0),
(1387, 1385, '370303', '张店区', 3, '0533', '区', 100, 'zhang dian qu', 'ux122 ux104 ux97 ux110 ux103 ux100 ux105 ux113 ux117 ux24352 ux24215 ux21306', 0, 0),
(1388, 1385, '370304', '博山区', 3, '0533', '区', 100, 'bo shan qu', 'ux98 ux111 ux115 ux104 ux97 ux110 ux113 ux117 ux21338 ux23665 ux21306', 0, 0),
(1389, 1385, '370305', '临淄区', 3, '0533', '区', 100, 'lin zi qu', 'ux108 ux105 ux110 ux122 ux113 ux117 ux20020 ux28100 ux21306', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(1390, 1385, '370306', '周村区', 3, '0533', '区', 100, 'zhou cun qu', 'ux122 ux104 ux111 ux117 ux99 ux110 ux113 ux21608 ux26449 ux21306', 0, 0),
(1391, 1385, '370321', '桓台县', 3, '0533', '区', 100, 'huan tai xian', 'ux104 ux117 ux97 ux110 ux116 ux105 ux120 ux26707 ux21488 ux21439', 0, 0),
(1392, 1385, '370322', '高青县', 3, '0533', '区', 100, 'gao qing xian', 'ux103 ux97 ux111 ux113 ux105 ux110 ux120 ux39640 ux38738 ux21439', 0, 0),
(1393, 1385, '370323', '沂源县', 3, '0533', '区', 100, 'yi yuan xian', 'ux121 ux105 ux117 ux97 ux110 ux120 ux27778 ux28304 ux21439', 0, 0),
(1394, 1360, '370400', '枣庄市', 2, '0632', '市', 100, 'zao zhuang shi', 'ux122 ux97 ux111 ux104 ux117 ux110 ux103 ux115 ux105 ux26531 ux24196 ux24066', 0, 0),
(1395, 1394, '370402', '市中区', 3, '0632', '区', 100, 'shi zhong qu', 'ux115 ux104 ux105 ux122 ux111 ux110 ux103 ux113 ux117 ux24066 ux20013 ux21306', 0, 0),
(1396, 1394, '370403', '薛城区', 3, '0632', '区', 100, 'xue cheng qu', 'ux120 ux117 ux101 ux99 ux104 ux110 ux103 ux113 ux34203 ux22478 ux21306', 0, 0),
(1397, 1394, '370404', '峄城区', 3, '0632', '区', 100, 'yi cheng qu', 'ux121 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux23748 ux22478 ux21306', 0, 0),
(1398, 1394, '370405', '台儿庄区', 3, '0632', '区', 100, 'tai er zhuang qu', 'ux116 ux97 ux105 ux101 ux114 ux122 ux104 ux117 ux110 ux103 ux113 ux21488 ux20799 ux24196 ux21306', 0, 0),
(1399, 1394, '370406', '山亭区', 3, '0632', '区', 100, 'shan ting qu', 'ux115 ux104 ux97 ux110 ux116 ux105 ux103 ux113 ux117 ux23665 ux20141 ux21306', 0, 0),
(1400, 1394, '370481', '滕州市', 3, '0632', '区', 100, 'teng zhou shi', 'ux116 ux101 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux105 ux28373 ux24030 ux24066', 0, 0),
(1401, 1360, '370500', '东营市', 2, '0546', '市', 100, 'dong ying shi', 'ux100 ux111 ux110 ux103 ux121 ux105 ux115 ux104 ux19996 ux33829 ux24066', 0, 0),
(1402, 1401, '370502', '东营区', 3, '0546', '区', 100, 'dong ying qu', 'ux100 ux111 ux110 ux103 ux121 ux105 ux113 ux117 ux19996 ux33829 ux21306', 0, 0),
(1403, 1401, '370503', '河口区', 3, '0546', '区', 100, 'he kou qu', 'ux104 ux101 ux107 ux111 ux117 ux113 ux27827 ux21475 ux21306', 0, 0),
(1404, 1401, '370521', '垦利县', 3, '0546', '区', 100, 'ken li xian', 'ux107 ux101 ux110 ux108 ux105 ux120 ux97 ux22438 ux21033 ux21439', 0, 0),
(1405, 1401, '370522', '利津县', 3, '0546', '区', 100, 'li jin xian', 'ux108 ux105 ux106 ux110 ux120 ux97 ux21033 ux27941 ux21439', 0, 0),
(1406, 1401, '370523', '广饶县', 3, '0546', '区', 100, 'guang rao xian', 'ux103 ux117 ux97 ux110 ux114 ux111 ux120 ux105 ux24191 ux39286 ux21439', 0, 0),
(1407, 1360, '370600', '烟台市', 2, '0535', '市', 100, 'yan tai shi', 'ux121 ux97 ux110 ux116 ux105 ux115 ux104 ux28895 ux21488 ux24066', 0, 0),
(1408, 1407, '370602', '芝罘区', 3, '0535', '区', 100, 'zhi fu qu', 'ux122 ux104 ux105 ux102 ux117 ux113 ux33437 ux32600 ux21306', 0, 0),
(1409, 1407, '370611', '福山区', 3, '0535', '区', 100, 'fu shan qu', 'ux102 ux117 ux115 ux104 ux97 ux110 ux113 ux31119 ux23665 ux21306', 0, 0),
(1410, 1407, '370612', '牟平区', 3, '0535', '区', 100, 'mou ping qu', 'ux109 ux111 ux117 ux112 ux105 ux110 ux103 ux113 ux29279 ux24179 ux21306', 0, 0),
(1411, 1407, '370613', '莱山区', 3, '0535', '区', 100, 'lai shan qu', 'ux108 ux97 ux105 ux115 ux104 ux110 ux113 ux117 ux33713 ux23665 ux21306', 0, 0),
(1412, 1407, '370634', '长岛县', 3, '0535', '区', 100, 'chang dao xian', 'ux99 ux104 ux97 ux110 ux103 ux100 ux111 ux120 ux105 ux38271 ux23707 ux21439', 0, 0),
(1413, 1407, '370681', '龙口市', 3, '0535', '区', 100, 'long kou shi', 'ux108 ux111 ux110 ux103 ux107 ux117 ux115 ux104 ux105 ux40857 ux21475 ux24066', 0, 0),
(1414, 1407, '370682', '莱阳市', 3, '0535', '区', 100, 'lai yang shi', 'ux108 ux97 ux105 ux121 ux110 ux103 ux115 ux104 ux33713 ux38451 ux24066', 0, 0),
(1415, 1407, '370683', '莱州市', 3, '0535', '区', 100, 'lai zhou shi', 'ux108 ux97 ux105 ux122 ux104 ux111 ux117 ux115 ux33713 ux24030 ux24066', 0, 0),
(1416, 1407, '370684', '蓬莱市', 3, '0535', '区', 100, 'peng lai shi', 'ux112 ux101 ux110 ux103 ux108 ux97 ux105 ux115 ux104 ux34028 ux33713 ux24066', 0, 0),
(1417, 1407, '370685', '招远市', 3, '0535', '区', 100, 'zhao yuan shi', 'ux122 ux104 ux97 ux111 ux121 ux117 ux110 ux115 ux105 ux25307 ux36828 ux24066', 0, 0),
(1418, 1407, '370686', '栖霞市', 3, '0535', '区', 100, 'qi xia shi', 'ux113 ux105 ux120 ux97 ux115 ux104 ux26646 ux38686 ux24066', 0, 0),
(1419, 1407, '370687', '海阳市', 3, '0535', '区', 100, 'hai yang shi', 'ux104 ux97 ux105 ux121 ux110 ux103 ux115 ux28023 ux38451 ux24066', 0, 0),
(1420, 1360, '370700', '潍坊市', 2, '0536', '市', 100, 'wei fang shi', 'ux119 ux101 ux105 ux102 ux97 ux110 ux103 ux115 ux104 ux28493 ux22346 ux24066', 0, 0),
(1421, 1420, '370702', '潍城区', 3, '0536', '区', 100, 'wei cheng qu', 'ux119 ux101 ux105 ux99 ux104 ux110 ux103 ux113 ux117 ux28493 ux22478 ux21306', 0, 0),
(1422, 1420, '370703', '寒亭区', 3, '0536', '区', 100, 'han ting qu', 'ux104 ux97 ux110 ux116 ux105 ux103 ux113 ux117 ux23506 ux20141 ux21306', 0, 0),
(1423, 1420, '370704', '坊子区', 3, '0536', '区', 100, 'fang zi qu', 'ux102 ux97 ux110 ux103 ux122 ux105 ux113 ux117 ux22346 ux23376 ux21306', 0, 0),
(1424, 1420, '370705', '奎文区', 3, '0536', '区', 100, 'kui wen qu', 'ux107 ux117 ux105 ux119 ux101 ux110 ux113 ux22862 ux25991 ux21306', 0, 0),
(1425, 1420, '370724', '临朐县', 3, '0536', '区', 100, 'lin qu xian', 'ux108 ux105 ux110 ux113 ux117 ux120 ux97 ux20020 ux26384 ux21439', 0, 0),
(1426, 1420, '370725', '昌乐县', 3, '0536', '区', 100, 'chang le xian', 'ux99 ux104 ux97 ux110 ux103 ux108 ux101 ux120 ux105 ux26124 ux20048 ux21439', 0, 0),
(1427, 1420, '370781', '青州市', 3, '0536', '区', 100, 'qing zhou shi', 'ux113 ux105 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux38738 ux24030 ux24066', 0, 0),
(1428, 1420, '370782', '诸城市', 3, '0536', '区', 100, 'zhu cheng shi', 'ux122 ux104 ux117 ux99 ux101 ux110 ux103 ux115 ux105 ux35832 ux22478 ux24066', 0, 0),
(1429, 1420, '370783', '寿光市', 3, '0536', '区', 100, 'shou guang shi', 'ux115 ux104 ux111 ux117 ux103 ux97 ux110 ux105 ux23551 ux20809 ux24066', 0, 0),
(1430, 1420, '370784', '安丘市', 3, '0536', '区', 100, 'an qiu shi', 'ux97 ux110 ux113 ux105 ux117 ux115 ux104 ux23433 ux19992 ux24066', 0, 0),
(1431, 1420, '370785', '高密市', 3, '0536', '区', 100, 'gao mi shi', 'ux103 ux97 ux111 ux109 ux105 ux115 ux104 ux39640 ux23494 ux24066', 0, 0),
(1432, 1420, '370786', '昌邑市', 3, '0536', '区', 100, 'chang yi shi', 'ux99 ux104 ux97 ux110 ux103 ux121 ux105 ux115 ux26124 ux37009 ux24066', 0, 0),
(1433, 1360, '370800', '济宁市', 2, '0537', '市', 100, 'ji ning shi', 'ux106 ux105 ux110 ux103 ux115 ux104 ux27982 ux23425 ux24066', 0, 0),
(1434, 1433, '370802', '市中区', 3, '0537', '区', 100, 'shi zhong qu', 'ux115 ux104 ux105 ux122 ux111 ux110 ux103 ux113 ux117 ux24066 ux20013 ux21306', 0, 0),
(1435, 1433, '370811', '任城区', 3, '0537', '区', 100, 'ren cheng qu', 'ux114 ux101 ux110 ux99 ux104 ux103 ux113 ux117 ux20219 ux22478 ux21306', 0, 0),
(1436, 1433, '370826', '微山县', 3, '0537', '区', 100, 'wei shan xian', 'ux119 ux101 ux105 ux115 ux104 ux97 ux110 ux120 ux24494 ux23665 ux21439', 0, 0),
(1437, 1433, '370827', '鱼台县', 3, '0537', '区', 100, 'yu tai xian', 'ux121 ux117 ux116 ux97 ux105 ux120 ux110 ux40060 ux21488 ux21439', 0, 0),
(1438, 1433, '370828', '金乡县', 3, '0537', '区', 100, 'jin xiang xian', 'ux106 ux105 ux110 ux120 ux97 ux103 ux37329 ux20065 ux21439', 0, 0),
(1439, 1433, '370829', '嘉祥县', 3, '0537', '区', 100, 'jia xiang xian', 'ux106 ux105 ux97 ux120 ux110 ux103 ux22025 ux31077 ux21439', 0, 0),
(1440, 1433, '370830', '汶上县', 3, '0537', '区', 100, 'wen shang xian', 'ux119 ux101 ux110 ux115 ux104 ux97 ux103 ux120 ux105 ux27766 ux19978 ux21439', 0, 0),
(1441, 1433, '370831', '泗水县', 3, '0537', '区', 100, 'si shui xian', 'ux115 ux105 ux104 ux117 ux120 ux97 ux110 ux27863 ux27700 ux21439', 0, 0),
(1442, 1433, '370832', '梁山县', 3, '0537', '区', 100, 'liang shan xian', 'ux108 ux105 ux97 ux110 ux103 ux115 ux104 ux120 ux26753 ux23665 ux21439', 0, 0),
(1443, 1433, '370881', '曲阜市', 3, '0537', '区', 100, 'qu fu shi', 'ux113 ux117 ux102 ux115 ux104 ux105 ux26354 ux38428 ux24066', 0, 0),
(1444, 1433, '370882', '兖州市', 3, '0537', '区', 100, 'yan zhou shi', 'ux121 ux97 ux110 ux122 ux104 ux111 ux117 ux115 ux105 ux20822 ux24030 ux24066', 0, 0),
(1445, 1433, '370883', '邹城市', 3, '0537', '区', 100, 'zou cheng shi', 'ux122 ux111 ux117 ux99 ux104 ux101 ux110 ux103 ux115 ux105 ux37049 ux22478 ux24066', 0, 0),
(1446, 1360, '370900', '泰安市', 2, '0538', '市', 100, 'tai an shi', 'ux116 ux97 ux105 ux110 ux115 ux104 ux27888 ux23433 ux24066', 0, 0),
(1447, 1446, '370902', '泰山区', 3, '0538', '区', 100, 'tai shan qu', 'ux116 ux97 ux105 ux115 ux104 ux110 ux113 ux117 ux27888 ux23665 ux21306', 0, 0),
(1448, 1446, '370911', '岱岳区', 3, '0538', '区', 100, 'dai yue qu', 'ux100 ux97 ux105 ux121 ux117 ux101 ux113 ux23729 ux23731 ux21306', 0, 0),
(1449, 1446, '370921', '宁阳县', 3, '0538', '区', 100, 'ning yang xian', 'ux110 ux105 ux103 ux121 ux97 ux120 ux23425 ux38451 ux21439', 0, 0),
(1450, 1446, '370923', '东平县', 3, '0538', '区', 100, 'dong ping xian', 'ux100 ux111 ux110 ux103 ux112 ux105 ux120 ux97 ux19996 ux24179 ux21439', 0, 0),
(1451, 1446, '370982', '新泰市', 3, '0538', '区', 100, 'xin tai shi', 'ux120 ux105 ux110 ux116 ux97 ux115 ux104 ux26032 ux27888 ux24066', 0, 0),
(1452, 1446, '370983', '肥城市', 3, '0538', '区', 100, 'fei cheng shi', 'ux102 ux101 ux105 ux99 ux104 ux110 ux103 ux115 ux32933 ux22478 ux24066', 0, 0),
(1453, 1360, '371000', '威海市', 2, '0631', '市', 100, 'wei hai shi', 'ux119 ux101 ux105 ux104 ux97 ux115 ux23041 ux28023 ux24066', 0, 0),
(1454, 1453, '371002', '环翠区', 3, '0631', '区', 100, 'huan cui qu', 'ux104 ux117 ux97 ux110 ux99 ux105 ux113 ux29615 ux32736 ux21306', 0, 0),
(1455, 1453, '371081', '文登市', 3, '0631', '区', 100, 'wen deng shi', 'ux119 ux101 ux110 ux100 ux103 ux115 ux104 ux105 ux25991 ux30331 ux24066', 0, 0),
(1456, 1453, '371082', '荣成市', 3, '0631', '区', 100, 'rong cheng shi', 'ux114 ux111 ux110 ux103 ux99 ux104 ux101 ux115 ux105 ux33635 ux25104 ux24066', 0, 0),
(1457, 1453, '371083', '乳山市', 3, '0631', '区', 100, 'ru shan shi', 'ux114 ux117 ux115 ux104 ux97 ux110 ux105 ux20083 ux23665 ux24066', 0, 0),
(1458, 1360, '371100', '日照市', 2, '0633', '市', 100, 'ri zhao shi', 'ux114 ux105 ux122 ux104 ux97 ux111 ux115 ux26085 ux29031 ux24066', 0, 0),
(1459, 1458, '371102', '东港区', 3, '0633', '区', 100, 'dong gang qu', 'ux100 ux111 ux110 ux103 ux97 ux113 ux117 ux19996 ux28207 ux21306', 0, 0),
(1460, 1458, '371103', '岚山区', 3, '0633', '区', 100, 'lan shan qu', 'ux108 ux97 ux110 ux115 ux104 ux113 ux117 ux23706 ux23665 ux21306', 0, 0),
(1461, 1458, '371121', '五莲县', 3, '0633', '区', 100, 'wu lian xian', 'ux119 ux117 ux108 ux105 ux97 ux110 ux120 ux20116 ux33714 ux21439', 0, 0),
(1462, 1458, '371122', '莒县', 3, '0633', '区', 100, 'ju xian', 'ux106 ux117 ux120 ux105 ux97 ux110 ux33682 ux21439', 0, 0),
(1463, 1360, '371200', '莱芜市', 2, '0634', '市', 100, 'lai wu shi', 'ux108 ux97 ux105 ux119 ux117 ux115 ux104 ux33713 ux33436 ux24066', 0, 0),
(1464, 1463, '371202', '莱城区', 3, '0634', '区', 100, 'lai cheng qu', 'ux108 ux97 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux33713 ux22478 ux21306', 0, 0),
(1465, 1463, '371203', '钢城区', 3, '0634', '区', 100, 'gang cheng qu', 'ux103 ux97 ux110 ux99 ux104 ux101 ux113 ux117 ux38050 ux22478 ux21306', 0, 0),
(1466, 1360, '371300', '临沂市', 2, '0539', '市', 100, 'lin yi shi', 'ux108 ux105 ux110 ux121 ux115 ux104 ux20020 ux27778 ux24066', 0, 0),
(1467, 1466, '371302', '兰山区', 3, '0539', '区', 100, 'lan shan qu', 'ux108 ux97 ux110 ux115 ux104 ux113 ux117 ux20848 ux23665 ux21306', 0, 0),
(1468, 1466, '371311', '罗庄区', 3, '0539', '区', 100, 'luo zhuang qu', 'ux108 ux117 ux111 ux122 ux104 ux97 ux110 ux103 ux113 ux32599 ux24196 ux21306', 0, 0),
(1469, 1466, '371312', '河东区', 3, '0539', '区', 100, 'he dong qu', 'ux104 ux101 ux100 ux111 ux110 ux103 ux113 ux117 ux27827 ux19996 ux21306', 0, 0),
(1470, 1466, '371321', '沂南县', 3, '0539', '区', 100, 'yi nan xian', 'ux121 ux105 ux110 ux97 ux120 ux27778 ux21335 ux21439', 0, 0),
(1471, 1466, '371322', '郯城县', 3, '0539', '区', 100, 'tan cheng xian', 'ux116 ux97 ux110 ux99 ux104 ux101 ux103 ux120 ux105 ux37103 ux22478 ux21439', 0, 0),
(1472, 1466, '371323', '沂水县', 3, '0539', '区', 100, 'yi shui xian', 'ux121 ux105 ux115 ux104 ux117 ux120 ux97 ux110 ux27778 ux27700 ux21439', 0, 0),
(1473, 1466, '371324', '苍山县', 3, '0539', '区', 100, 'cang shan xian', 'ux99 ux97 ux110 ux103 ux115 ux104 ux120 ux105 ux33485 ux23665 ux21439', 0, 0),
(1474, 1466, '371325', '费县', 3, '0539', '区', 100, 'fei xian', 'ux102 ux101 ux105 ux120 ux97 ux110 ux36153 ux21439', 0, 0),
(1475, 1466, '371326', '平邑县', 3, '0539', '区', 100, 'ping yi xian', 'ux112 ux105 ux110 ux103 ux121 ux120 ux97 ux24179 ux37009 ux21439', 0, 0),
(1476, 1466, '371327', '莒南县', 3, '0539', '区', 100, 'ju nan xian', 'ux106 ux117 ux110 ux97 ux120 ux105 ux33682 ux21335 ux21439', 0, 0),
(1477, 1466, '371328', '蒙阴县', 3, '0539', '区', 100, 'meng yin xian', 'ux109 ux101 ux110 ux103 ux121 ux105 ux120 ux97 ux33945 ux38452 ux21439', 0, 0),
(1478, 1466, '371329', '临沭县', 3, '0539', '区', 100, 'lin shu xian', 'ux108 ux105 ux110 ux115 ux104 ux117 ux120 ux97 ux20020 ux27821 ux21439', 0, 0),
(1479, 1360, '371400', '德州市', 2, '0534', '市', 100, 'de zhou shi', 'ux100 ux101 ux122 ux104 ux111 ux117 ux115 ux105 ux24503 ux24030 ux24066', 0, 0),
(1480, 1479, '371402', '德城区', 3, '0534', '区', 100, 'de cheng qu', 'ux100 ux101 ux99 ux104 ux110 ux103 ux113 ux117 ux24503 ux22478 ux21306', 0, 0),
(1481, 1479, '371421', '陵县', 3, '0534', '区', 100, 'ling xian', 'ux108 ux105 ux110 ux103 ux120 ux97 ux38517 ux21439', 0, 0),
(1482, 1479, '371422', '宁津县', 3, '0534', '区', 100, 'ning jin xian', 'ux110 ux105 ux103 ux106 ux120 ux97 ux23425 ux27941 ux21439', 0, 0),
(1483, 1479, '371423', '庆云县', 3, '0534', '区', 100, 'qing yun xian', 'ux113 ux105 ux110 ux103 ux121 ux117 ux120 ux97 ux24198 ux20113 ux21439', 0, 0),
(1484, 1479, '371424', '临邑县', 3, '0534', '区', 100, 'lin yi xian', 'ux108 ux105 ux110 ux121 ux120 ux97 ux20020 ux37009 ux21439', 0, 0),
(1485, 1479, '371425', '齐河县', 3, '0534', '区', 100, 'qi he xian', 'ux113 ux105 ux104 ux101 ux120 ux97 ux110 ux40784 ux27827 ux21439', 0, 0),
(1486, 1479, '371426', '平原县', 3, '0534', '区', 100, 'ping yuan xian', 'ux112 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux24179 ux21407 ux21439', 0, 0),
(1487, 1479, '371427', '夏津县', 3, '0534', '区', 100, 'xia jin xian', 'ux120 ux105 ux97 ux106 ux110 ux22799 ux27941 ux21439', 0, 0),
(1488, 1479, '371428', '武城县', 3, '0534', '区', 100, 'wu cheng xian', 'ux119 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux27494 ux22478 ux21439', 0, 0),
(1489, 1479, '371481', '乐陵市', 3, '0534', '区', 100, 'le ling shi', 'ux108 ux101 ux105 ux110 ux103 ux115 ux104 ux20048 ux38517 ux24066', 0, 0),
(1490, 1479, '371482', '禹城市', 3, '0534', '区', 100, 'yu cheng shi', 'ux121 ux117 ux99 ux104 ux101 ux110 ux103 ux115 ux105 ux31161 ux22478 ux24066', 0, 0),
(1491, 1360, '371500', '聊城市', 2, '0635', '市', 100, 'liao cheng shi', 'ux108 ux105 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux115 ux32842 ux22478 ux24066', 0, 0),
(1492, 1491, '371502', '东昌府区', 3, '0635', '区', 100, 'dong chang fu qu', 'ux100 ux111 ux110 ux103 ux99 ux104 ux97 ux102 ux117 ux113 ux19996 ux26124 ux24220 ux21306', 0, 0),
(1493, 1491, '371521', '阳谷县', 3, '0635', '区', 100, 'yang gu xian', 'ux121 ux97 ux110 ux103 ux117 ux120 ux105 ux38451 ux35895 ux21439', 0, 0),
(1494, 1491, '371522', '莘县', 3, '0635', '区', 100, 'shen xian', 'ux115 ux104 ux101 ux110 ux120 ux105 ux97 ux33688 ux21439', 0, 0),
(1495, 1491, '371523', '茌平县', 3, '0635', '区', 100, 'chi ping xian', 'ux99 ux104 ux105 ux112 ux110 ux103 ux120 ux97 ux33548 ux24179 ux21439', 0, 0),
(1496, 1491, '371524', '东阿县', 3, '0635', '区', 100, 'dong a xian', 'ux100 ux111 ux110 ux103 ux97 ux120 ux105 ux19996 ux38463 ux21439', 0, 0),
(1497, 1491, '371525', '冠县', 3, '0635', '区', 100, 'guan xian', 'ux103 ux117 ux97 ux110 ux120 ux105 ux20896 ux21439', 0, 0),
(1498, 1491, '371526', '高唐县', 3, '0635', '区', 100, 'gao tang xian', 'ux103 ux97 ux111 ux116 ux110 ux120 ux105 ux39640 ux21776 ux21439', 0, 0),
(1499, 1491, '371581', '临清市', 3, '0635', '区', 100, 'lin qing shi', 'ux108 ux105 ux110 ux113 ux103 ux115 ux104 ux20020 ux28165 ux24066', 0, 0),
(1500, 1360, '371600', '滨州市', 2, '0543', '市', 100, 'bin zhou shi', 'ux98 ux105 ux110 ux122 ux104 ux111 ux117 ux115 ux28392 ux24030 ux24066', 0, 0),
(1501, 1500, '371602', '滨城区', 3, '0543', '区', 100, 'bin cheng qu', 'ux98 ux105 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux28392 ux22478 ux21306', 0, 0),
(1502, 1500, '371621', '惠民县', 3, '0543', '区', 100, 'hui min xian', 'ux104 ux117 ux105 ux109 ux110 ux120 ux97 ux24800 ux27665 ux21439', 0, 0),
(1503, 1500, '371622', '阳信县', 3, '0543', '区', 100, 'yang xin xian', 'ux121 ux97 ux110 ux103 ux120 ux105 ux38451 ux20449 ux21439', 0, 0),
(1504, 1500, '371623', '无棣县', 3, '0543', '区', 100, 'wu di xian', 'ux119 ux117 ux100 ux105 ux120 ux97 ux110 ux26080 ux26851 ux21439', 0, 0),
(1505, 1500, '371624', '沾化县', 3, '0543', '区', 100, 'zhan hua xian', 'ux122 ux104 ux97 ux110 ux117 ux120 ux105 ux27838 ux21270 ux21439', 0, 0),
(1506, 1500, '371625', '博兴县', 3, '0543', '区', 100, 'bo xing xian', 'ux98 ux111 ux120 ux105 ux110 ux103 ux97 ux21338 ux20852 ux21439', 0, 0),
(1507, 1500, '371626', '邹平县', 3, '0543', '区', 100, 'zou ping xian', 'ux122 ux111 ux117 ux112 ux105 ux110 ux103 ux120 ux97 ux37049 ux24179 ux21439', 0, 0),
(1508, 1360, '371700', '菏泽市', 2, '0530', '市', 100, 'he ze shi', 'ux104 ux101 ux122 ux115 ux105 ux33743 ux27901 ux24066', 0, 0),
(1509, 1508, '371702', '牡丹区', 3, '0530', '区', 100, 'mu dan qu', 'ux109 ux117 ux100 ux97 ux110 ux113 ux29281 ux20025 ux21306', 0, 0),
(1510, 1508, '371721', '曹县', 3, '0530', '区', 100, 'cao xian', 'ux99 ux97 ux111 ux120 ux105 ux110 ux26361 ux21439', 0, 0),
(1511, 1508, '371722', '单县', 3, '0530', '区', 100, 'dan xian', 'ux100 ux97 ux110 ux120 ux105 ux21333 ux21439', 0, 0),
(1512, 1508, '371723', '成武县', 3, '0530', '区', 100, 'cheng wu xian', 'ux99 ux104 ux101 ux110 ux103 ux119 ux117 ux120 ux105 ux97 ux25104 ux27494 ux21439', 0, 0),
(1513, 1508, '371724', '巨野县', 3, '0530', '区', 100, 'ju ye xian', 'ux106 ux117 ux121 ux101 ux120 ux105 ux97 ux110 ux24040 ux37326 ux21439', 0, 0),
(1514, 1508, '371725', '郓城县', 3, '0530', '区', 100, 'yun cheng xian', 'ux121 ux117 ux110 ux99 ux104 ux101 ux103 ux120 ux105 ux97 ux37075 ux22478 ux21439', 0, 0),
(1515, 1508, '371726', '鄄城县', 3, '0530', '区', 100, 'juan cheng xian', 'ux106 ux117 ux97 ux110 ux99 ux104 ux101 ux103 ux120 ux105 ux37124 ux22478 ux21439', 0, 0),
(1516, 1508, '371727', '定陶县', 3, '0530', '区', 100, 'ding tao xian', 'ux100 ux105 ux110 ux103 ux116 ux97 ux111 ux120 ux23450 ux38518 ux21439', 0, 0),
(1517, 1508, '371728', '东明县', 3, '0530', '区', 100, 'dong ming xian', 'ux100 ux111 ux110 ux103 ux109 ux105 ux120 ux97 ux19996 ux26126 ux21439', 0, 0),
(1518, 0, '410000', '河南省', 1, '', '省', 100, 'he nan sheng', 'ux104 ux101 ux110 ux97 ux115 ux103 ux27827 ux21335 ux30465', 0, 0),
(1519, 1518, '410100', '郑州市', 2, '0371', '市', 100, 'zheng zhou shi', 'ux122 ux104 ux101 ux110 ux103 ux111 ux117 ux115 ux105 ux37073 ux24030 ux24066', 0, 0),
(1520, 1519, '410102', '中原区', 3, '0371', '区', 100, 'zhong yuan qu', 'ux122 ux104 ux111 ux110 ux103 ux121 ux117 ux97 ux113 ux20013 ux21407 ux21306', 0, 0),
(1521, 1519, '410103', '二七区', 3, '0371', '区', 100, 'er qi qu', 'ux101 ux114 ux113 ux105 ux117 ux20108 ux19971 ux21306', 0, 0),
(1522, 1519, '410104', '管城回族区', 3, '0371', '区', 100, 'guan cheng hui zu qu', 'ux103 ux117 ux97 ux110 ux99 ux104 ux101 ux105 ux122 ux113 ux31649 ux22478 ux22238 ux26063 ux21306', 0, 0),
(1523, 1519, '410105', '金水区', 3, '0371', '区', 100, 'jin shui qu', 'ux106 ux105 ux110 ux115 ux104 ux117 ux113 ux37329 ux27700 ux21306', 0, 0),
(1524, 1519, '410106', '上街区', 3, '0371', '区', 100, 'shang jie qu', 'ux115 ux104 ux97 ux110 ux103 ux106 ux105 ux101 ux113 ux117 ux19978 ux34903 ux21306', 0, 0),
(1525, 1519, '410108', '惠济区', 3, '0371', '区', 100, 'hui ji qu', 'ux104 ux117 ux105 ux106 ux113 ux24800 ux27982 ux21306', 0, 0),
(1526, 1519, '410122', '中牟县', 3, '0371', '区', 100, 'zhong mou xian', 'ux122 ux104 ux111 ux110 ux103 ux109 ux117 ux120 ux105 ux97 ux20013 ux29279 ux21439', 0, 0),
(1527, 1519, '410181', '巩义市', 3, '0371', '区', 100, 'gong yi shi', 'ux103 ux111 ux110 ux121 ux105 ux115 ux104 ux24041 ux20041 ux24066', 0, 0),
(1528, 1519, '410182', '荥阳市', 3, '0371', '区', 100, 'xing yang shi', 'ux120 ux105 ux110 ux103 ux121 ux97 ux115 ux104 ux33637 ux38451 ux24066', 0, 0),
(1529, 1519, '410183', '新密市', 3, '0371', '区', 100, 'xin mi shi', 'ux120 ux105 ux110 ux109 ux115 ux104 ux26032 ux23494 ux24066', 0, 0),
(1530, 1519, '410184', '新郑市', 3, '0371', '区', 100, 'xin zheng shi', 'ux120 ux105 ux110 ux122 ux104 ux101 ux103 ux115 ux26032 ux37073 ux24066', 0, 0),
(1531, 1519, '410185', '登封市', 3, '0371', '区', 100, 'deng feng shi', 'ux100 ux101 ux110 ux103 ux102 ux115 ux104 ux105 ux30331 ux23553 ux24066', 0, 0),
(1532, 1518, '410200', '开封市', 2, '0378', '市', 100, 'kai feng shi', 'ux107 ux97 ux105 ux102 ux101 ux110 ux103 ux115 ux104 ux24320 ux23553 ux24066', 0, 0),
(1533, 1532, '410202', '龙亭区', 3, '0378', '区', 100, 'long ting qu', 'ux108 ux111 ux110 ux103 ux116 ux105 ux113 ux117 ux40857 ux20141 ux21306', 0, 0),
(1534, 1532, '410203', '顺河回族区', 3, '0378', '区', 100, 'shun he hui zu qu', 'ux115 ux104 ux117 ux110 ux101 ux105 ux122 ux113 ux39034 ux27827 ux22238 ux26063 ux21306', 0, 0),
(1535, 1532, '410204', '鼓楼区', 3, '0378', '区', 100, 'gu lou qu', 'ux103 ux117 ux108 ux111 ux113 ux40723 ux27004 ux21306', 0, 0),
(1536, 1532, '410205', '禹王台区', 3, '0378', '区', 100, 'yu wang tai qu', 'ux121 ux117 ux119 ux97 ux110 ux103 ux116 ux105 ux113 ux31161 ux29579 ux21488 ux21306', 0, 0),
(1537, 1532, '410211', '金明区', 3, '0378', '区', 100, 'jin ming qu', 'ux106 ux105 ux110 ux109 ux103 ux113 ux117 ux37329 ux26126 ux21306', 0, 0),
(1538, 1532, '410221', '杞县', 3, '0378', '区', 100, 'qi xian', 'ux113 ux105 ux120 ux97 ux110 ux26462 ux21439', 0, 0),
(1539, 1532, '410222', '通许县', 3, '0378', '区', 100, 'tong xu xian', 'ux116 ux111 ux110 ux103 ux120 ux117 ux105 ux97 ux36890 ux35768 ux21439', 0, 0),
(1540, 1532, '410223', '尉氏县', 3, '0378', '区', 100, 'wei shi xian', 'ux119 ux101 ux105 ux115 ux104 ux120 ux97 ux110 ux23561 ux27663 ux21439', 0, 0),
(1541, 1532, '410224', '开封县', 3, '0378', '区', 100, 'kai feng xian', 'ux107 ux97 ux105 ux102 ux101 ux110 ux103 ux120 ux24320 ux23553 ux21439', 0, 0),
(1542, 1532, '410225', '兰考县', 3, '0378', '区', 100, 'lan kao xian', 'ux108 ux97 ux110 ux107 ux111 ux120 ux105 ux20848 ux32771 ux21439', 0, 0),
(1543, 1518, '410300', '洛阳市', 2, '0379', '市', 100, 'luo yang shi', 'ux108 ux117 ux111 ux121 ux97 ux110 ux103 ux115 ux104 ux105 ux27931 ux38451 ux24066', 0, 0),
(1544, 1543, '410302', '老城区', 3, '0379', '区', 100, 'lao cheng qu', 'ux108 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux32769 ux22478 ux21306', 0, 0),
(1545, 1543, '410303', '西工区', 3, '0379', '区', 100, 'xi gong qu', 'ux120 ux105 ux103 ux111 ux110 ux113 ux117 ux35199 ux24037 ux21306', 0, 0),
(1546, 1543, '410304', '瀍河回族区', 3, '0379', '区', 100, 'chan he hui zu qu', 'ux99 ux104 ux97 ux110 ux101 ux117 ux105 ux122 ux113 ux28685 ux27827 ux22238 ux26063 ux21306', 0, 0),
(1547, 1543, '410305', '涧西区', 3, '0379', '区', 100, 'jian xi qu', 'ux106 ux105 ux97 ux110 ux120 ux113 ux117 ux28071 ux35199 ux21306', 0, 0),
(1548, 1543, '410306', '吉利区', 3, '0379', '区', 100, 'ji li qu', 'ux106 ux105 ux108 ux113 ux117 ux21513 ux21033 ux21306', 0, 0),
(1549, 1543, '410311', '洛龙区', 3, '0379', '区', 100, 'luo long qu', 'ux108 ux117 ux111 ux110 ux103 ux113 ux27931 ux40857 ux21306', 0, 0),
(1550, 1543, '410322', '孟津县', 3, '0379', '区', 100, 'meng jin xian', 'ux109 ux101 ux110 ux103 ux106 ux105 ux120 ux97 ux23391 ux27941 ux21439', 0, 0),
(1551, 1543, '410323', '新安县', 3, '0379', '区', 100, 'xin an xian', 'ux120 ux105 ux110 ux97 ux26032 ux23433 ux21439', 0, 0),
(1552, 1543, '410324', '栾川县', 3, '0379', '区', 100, 'luan chuan xian', 'ux108 ux117 ux97 ux110 ux99 ux104 ux120 ux105 ux26686 ux24029 ux21439', 0, 0),
(1553, 1543, '410325', '嵩县', 3, '0379', '区', 100, 'song xian', 'ux115 ux111 ux110 ux103 ux120 ux105 ux97 ux23913 ux21439', 0, 0),
(1554, 1543, '410326', '汝阳县', 3, '0379', '区', 100, 'ru yang xian', 'ux114 ux117 ux121 ux97 ux110 ux103 ux120 ux105 ux27741 ux38451 ux21439', 0, 0),
(1555, 1543, '410327', '宜阳县', 3, '0379', '区', 100, 'yi yang xian', 'ux121 ux105 ux97 ux110 ux103 ux120 ux23452 ux38451 ux21439', 0, 0),
(1556, 1543, '410328', '洛宁县', 3, '0379', '区', 100, 'luo ning xian', 'ux108 ux117 ux111 ux110 ux105 ux103 ux120 ux97 ux27931 ux23425 ux21439', 0, 0),
(1557, 1543, '410329', '伊川县', 3, '0379', '区', 100, 'yi chuan xian', 'ux121 ux105 ux99 ux104 ux117 ux97 ux110 ux120 ux20234 ux24029 ux21439', 0, 0),
(1558, 1543, '410381', '偃师市', 3, '0379', '区', 100, 'yan shi shi', 'ux121 ux97 ux110 ux115 ux104 ux105 ux20547 ux24072 ux24066', 0, 0),
(1559, 1518, '410400', '平顶山市', 2, '0375', '市', 100, 'ping ding shan shi', 'ux112 ux105 ux110 ux103 ux100 ux115 ux104 ux97 ux24179 ux39030 ux23665 ux24066', 0, 0),
(1560, 1559, '410402', '新华区', 3, '0375', '区', 100, 'xin hua qu', 'ux120 ux105 ux110 ux104 ux117 ux97 ux113 ux26032 ux21326 ux21306', 0, 0),
(1561, 1559, '410403', '卫东区', 3, '0375', '区', 100, 'wei dong qu', 'ux119 ux101 ux105 ux100 ux111 ux110 ux103 ux113 ux117 ux21355 ux19996 ux21306', 0, 0),
(1562, 1559, '410404', '石龙区', 3, '0375', '区', 100, 'shi long qu', 'ux115 ux104 ux105 ux108 ux111 ux110 ux103 ux113 ux117 ux30707 ux40857 ux21306', 0, 0),
(1563, 1559, '410411', '湛河区', 3, '0375', '区', 100, 'zhan he qu', 'ux122 ux104 ux97 ux110 ux101 ux113 ux117 ux28251 ux27827 ux21306', 0, 0),
(1564, 1559, '410421', '宝丰县', 3, '0375', '区', 100, 'bao feng xian', 'ux98 ux97 ux111 ux102 ux101 ux110 ux103 ux120 ux105 ux23453 ux20016 ux21439', 0, 0),
(1565, 1559, '410422', '叶县', 3, '0375', '区', 100, 'ye xian', 'ux121 ux101 ux120 ux105 ux97 ux110 ux21494 ux21439', 0, 0),
(1566, 1559, '410423', '鲁山县', 3, '0375', '区', 100, 'lu shan xian', 'ux108 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux40065 ux23665 ux21439', 0, 0),
(1567, 1559, '410425', '郏县', 3, '0375', '区', 100, 'jia xian', 'ux106 ux105 ux97 ux120 ux110 ux37071 ux21439', 0, 0),
(1568, 1559, '410481', '舞钢市', 3, '0375', '区', 100, 'wu gang shi', 'ux119 ux117 ux103 ux97 ux110 ux115 ux104 ux105 ux33310 ux38050 ux24066', 0, 0),
(1569, 1559, '410482', '汝州市', 3, '0375', '区', 100, 'ru zhou shi', 'ux114 ux117 ux122 ux104 ux111 ux115 ux105 ux27741 ux24030 ux24066', 0, 0),
(1570, 1518, '410500', '安阳市', 2, '0372', '市', 100, 'an yang shi', 'ux97 ux110 ux121 ux103 ux115 ux104 ux105 ux23433 ux38451 ux24066', 0, 0),
(1571, 1570, '410502', '文峰区', 3, '0372', '区', 100, 'wen feng qu', 'ux119 ux101 ux110 ux102 ux103 ux113 ux117 ux25991 ux23792 ux21306', 0, 0),
(1572, 1570, '410503', '北关区', 3, '0372', '区', 100, 'bei guan qu', 'ux98 ux101 ux105 ux103 ux117 ux97 ux110 ux113 ux21271 ux20851 ux21306', 0, 0),
(1573, 1570, '410505', '殷都区', 3, '0372', '区', 100, 'yin du qu', 'ux121 ux105 ux110 ux100 ux117 ux113 ux27575 ux37117 ux21306', 0, 0),
(1574, 1570, '410506', '龙安区', 3, '0372', '区', 100, 'long an qu', 'ux108 ux111 ux110 ux103 ux97 ux113 ux117 ux40857 ux23433 ux21306', 0, 0),
(1575, 1570, '410522', '安阳县', 3, '0372', '区', 100, 'an yang xian', 'ux97 ux110 ux121 ux103 ux120 ux105 ux23433 ux38451 ux21439', 0, 0),
(1576, 1570, '410523', '汤阴县', 3, '0372', '区', 100, 'tang yin xian', 'ux116 ux97 ux110 ux103 ux121 ux105 ux120 ux27748 ux38452 ux21439', 0, 0),
(1577, 1570, '410526', '滑县', 3, '0372', '区', 100, 'hua xian', 'ux104 ux117 ux97 ux120 ux105 ux110 ux28369 ux21439', 0, 0),
(1578, 1570, '410527', '内黄县', 3, '0372', '区', 100, 'nei huang xian', 'ux110 ux101 ux105 ux104 ux117 ux97 ux103 ux120 ux20869 ux40644 ux21439', 0, 0),
(1579, 1570, '410581', '林州市', 3, '0372', '区', 100, 'lin zhou shi', 'ux108 ux105 ux110 ux122 ux104 ux111 ux117 ux115 ux26519 ux24030 ux24066', 0, 0),
(1580, 1518, '410600', '鹤壁市', 2, '0392', '市', 100, 'he bi shi', 'ux104 ux101 ux98 ux105 ux115 ux40548 ux22721 ux24066', 0, 0),
(1581, 1580, '410602', '鹤山区', 3, '0392', '区', 100, 'he shan qu', 'ux104 ux101 ux115 ux97 ux110 ux113 ux117 ux40548 ux23665 ux21306', 0, 0),
(1582, 1580, '410603', '山城区', 3, '0392', '区', 100, 'shan cheng qu', 'ux115 ux104 ux97 ux110 ux99 ux101 ux103 ux113 ux117 ux23665 ux22478 ux21306', 0, 0),
(1583, 1580, '410611', '淇滨区', 3, '0392', '区', 100, 'qi bin qu', 'ux113 ux105 ux98 ux110 ux117 ux28103 ux28392 ux21306', 0, 0),
(1584, 1580, '410621', '浚县', 3, '0392', '区', 100, 'jun xian', 'ux106 ux117 ux110 ux120 ux105 ux97 ux27994 ux21439', 0, 0),
(1585, 1580, '410622', '淇县', 3, '0392', '区', 100, 'qi xian', 'ux113 ux105 ux120 ux97 ux110 ux28103 ux21439', 0, 0),
(1586, 1518, '410700', '新乡市', 2, '0373', '市', 100, 'xin xiang shi', 'ux120 ux105 ux110 ux97 ux103 ux115 ux104 ux26032 ux20065 ux24066', 0, 0),
(1587, 1586, '410702', '红旗区', 3, '0373', '区', 100, 'hong qi qu', 'ux104 ux111 ux110 ux103 ux113 ux105 ux117 ux32418 ux26071 ux21306', 0, 0),
(1588, 1586, '410703', '卫滨区', 3, '0373', '区', 100, 'wei bin qu', 'ux119 ux101 ux105 ux98 ux110 ux113 ux117 ux21355 ux28392 ux21306', 0, 0),
(1589, 1586, '410704', '凤泉区', 3, '0373', '区', 100, 'feng quan qu', 'ux102 ux101 ux110 ux103 ux113 ux117 ux97 ux20964 ux27849 ux21306', 0, 0),
(1590, 1586, '410711', '牧野区', 3, '0373', '区', 100, 'mu ye qu', 'ux109 ux117 ux121 ux101 ux113 ux29287 ux37326 ux21306', 0, 0),
(1591, 1586, '410721', '新乡县', 3, '0373', '区', 100, 'xin xiang xian', 'ux120 ux105 ux110 ux97 ux103 ux26032 ux20065 ux21439', 0, 0),
(1592, 1586, '410724', '获嘉县', 3, '0373', '区', 100, 'huo jia xian', 'ux104 ux117 ux111 ux106 ux105 ux97 ux120 ux110 ux33719 ux22025 ux21439', 0, 0),
(1593, 1586, '410725', '原阳县', 3, '0373', '区', 100, 'yuan yang xian', 'ux121 ux117 ux97 ux110 ux103 ux120 ux105 ux21407 ux38451 ux21439', 0, 0),
(1594, 1586, '410726', '延津县', 3, '0373', '区', 100, 'yan jin xian', 'ux121 ux97 ux110 ux106 ux105 ux120 ux24310 ux27941 ux21439', 0, 0),
(1595, 1586, '410727', '封丘县', 3, '0373', '区', 100, 'feng qiu xian', 'ux102 ux101 ux110 ux103 ux113 ux105 ux117 ux120 ux97 ux23553 ux19992 ux21439', 0, 0),
(1596, 1586, '410728', '长垣县', 3, '0373', '区', 100, 'chang yuan xian', 'ux99 ux104 ux97 ux110 ux103 ux121 ux117 ux120 ux105 ux38271 ux22435 ux21439', 0, 0),
(1597, 1586, '410781', '卫辉市', 3, '0373', '区', 100, 'wei hui shi', 'ux119 ux101 ux105 ux104 ux117 ux115 ux21355 ux36745 ux24066', 0, 0),
(1598, 1586, '410782', '辉县市', 3, '0373', '区', 100, 'hui xian shi', 'ux104 ux117 ux105 ux120 ux97 ux110 ux115 ux36745 ux21439 ux24066', 0, 0),
(1599, 1518, '410800', '焦作市', 2, '0391', '市', 100, 'jiao zuo shi', 'ux106 ux105 ux97 ux111 ux122 ux117 ux115 ux104 ux28966 ux20316 ux24066', 0, 0),
(1600, 1599, '410802', '解放区', 3, '0391', '区', 100, 'jie fang qu', 'ux106 ux105 ux101 ux102 ux97 ux110 ux103 ux113 ux117 ux35299 ux25918 ux21306', 0, 0),
(1601, 1599, '410803', '中站区', 3, '0391', '区', 100, 'zhong zhan qu', 'ux122 ux104 ux111 ux110 ux103 ux97 ux113 ux117 ux20013 ux31449 ux21306', 0, 0),
(1602, 1599, '410804', '马村区', 3, '0391', '区', 100, 'ma cun qu', 'ux109 ux97 ux99 ux117 ux110 ux113 ux39532 ux26449 ux21306', 0, 0),
(1603, 1599, '410811', '山阳区', 3, '0391', '区', 100, 'shan yang qu', 'ux115 ux104 ux97 ux110 ux121 ux103 ux113 ux117 ux23665 ux38451 ux21306', 0, 0),
(1604, 1599, '410821', '修武县', 3, '0391', '区', 100, 'xiu wu xian', 'ux120 ux105 ux117 ux119 ux97 ux110 ux20462 ux27494 ux21439', 0, 0),
(1605, 1599, '410822', '博爱县', 3, '0391', '区', 100, 'bo ai xian', 'ux98 ux111 ux97 ux105 ux120 ux110 ux21338 ux29233 ux21439', 0, 0),
(1606, 1599, '410823', '武陟县', 3, '0391', '区', 100, 'wu zhi xian', 'ux119 ux117 ux122 ux104 ux105 ux120 ux97 ux110 ux27494 ux38495 ux21439', 0, 0),
(1607, 1599, '410825', '温县', 3, '0391', '区', 100, 'wen xian', 'ux119 ux101 ux110 ux120 ux105 ux97 ux28201 ux21439', 0, 0),
(1608, 1599, '410882', '沁阳市', 3, '0391', '区', 100, 'qin yang shi', 'ux113 ux105 ux110 ux121 ux97 ux103 ux115 ux104 ux27777 ux38451 ux24066', 0, 0),
(1609, 1599, '410883', '孟州市', 3, '0391', '区', 100, 'meng zhou shi', 'ux109 ux101 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux105 ux23391 ux24030 ux24066', 0, 0),
(1610, 1518, '410900', '濮阳市', 2, '0393', '市', 100, 'pu yang shi', 'ux112 ux117 ux121 ux97 ux110 ux103 ux115 ux104 ux105 ux28654 ux38451 ux24066', 0, 0),
(1611, 1610, '410902', '华龙区', 3, '0393', '区', 100, 'hua long qu', 'ux104 ux117 ux97 ux108 ux111 ux110 ux103 ux113 ux21326 ux40857 ux21306', 0, 0),
(1612, 1610, '410922', '清丰县', 3, '0393', '区', 100, 'qing feng xian', 'ux113 ux105 ux110 ux103 ux102 ux101 ux120 ux97 ux28165 ux20016 ux21439', 0, 0),
(1613, 1610, '410923', '南乐县', 3, '0393', '区', 100, 'nan le xian', 'ux110 ux97 ux108 ux101 ux120 ux105 ux21335 ux20048 ux21439', 0, 0),
(1614, 1610, '410926', '范县', 3, '0393', '区', 100, 'fan xian', 'ux102 ux97 ux110 ux120 ux105 ux33539 ux21439', 0, 0),
(1615, 1610, '410927', '台前县', 3, '0393', '区', 100, 'tai qian xian', 'ux116 ux97 ux105 ux113 ux110 ux120 ux21488 ux21069 ux21439', 0, 0),
(1616, 1610, '410928', '濮阳县', 3, '0393', '区', 100, 'pu yang xian', 'ux112 ux117 ux121 ux97 ux110 ux103 ux120 ux105 ux28654 ux38451 ux21439', 0, 0),
(1617, 1518, '411000', '许昌市', 2, '0374', '市', 100, 'xu chang shi', 'ux120 ux117 ux99 ux104 ux97 ux110 ux103 ux115 ux105 ux35768 ux26124 ux24066', 0, 0),
(1618, 1617, '411002', '魏都区', 3, '0374', '区', 100, 'wei du qu', 'ux119 ux101 ux105 ux100 ux117 ux113 ux39759 ux37117 ux21306', 0, 0),
(1619, 1617, '411023', '许昌县', 3, '0374', '区', 100, 'xu chang xian', 'ux120 ux117 ux99 ux104 ux97 ux110 ux103 ux105 ux35768 ux26124 ux21439', 0, 0),
(1620, 1617, '411024', '鄢陵县', 3, '0374', '区', 100, 'yan ling xian', 'ux121 ux97 ux110 ux108 ux105 ux103 ux120 ux37154 ux38517 ux21439', 0, 0),
(1621, 1617, '411025', '襄城县', 3, '0374', '区', 100, 'xiang cheng xian', 'ux120 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux35140 ux22478 ux21439', 0, 0),
(1622, 1617, '411081', '禹州市', 3, '0374', '区', 100, 'yu zhou shi', 'ux121 ux117 ux122 ux104 ux111 ux115 ux105 ux31161 ux24030 ux24066', 0, 0),
(1623, 1617, '411082', '长葛市', 3, '0374', '区', 100, 'chang ge shi', 'ux99 ux104 ux97 ux110 ux103 ux101 ux115 ux105 ux38271 ux33883 ux24066', 0, 0),
(1624, 1518, '411100', '漯河市', 2, '0395', '市', 100, 'luo he shi', 'ux108 ux117 ux111 ux104 ux101 ux115 ux105 ux28463 ux27827 ux24066', 0, 0),
(1625, 1624, '411102', '源汇区', 3, '0395', '区', 100, 'yuan hui qu', 'ux121 ux117 ux97 ux110 ux104 ux105 ux113 ux28304 ux27719 ux21306', 0, 0),
(1626, 1624, '411103', '郾城区', 3, '0395', '区', 100, 'yan cheng qu', 'ux121 ux97 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux37118 ux22478 ux21306', 0, 0),
(1627, 1624, '411104', '召陵区', 3, '0395', '区', 100, 'zhao ling qu', 'ux122 ux104 ux97 ux111 ux108 ux105 ux110 ux103 ux113 ux117 ux21484 ux38517 ux21306', 0, 0),
(1628, 1624, '411121', '舞阳县', 3, '0395', '区', 100, 'wu yang xian', 'ux119 ux117 ux121 ux97 ux110 ux103 ux120 ux105 ux33310 ux38451 ux21439', 0, 0),
(1629, 1624, '411122', '临颍县', 3, '0395', '区', 100, 'lin ying xian', 'ux108 ux105 ux110 ux121 ux103 ux120 ux97 ux20020 ux39053 ux21439', 0, 0),
(1630, 1518, '411200', '三门峡市', 2, '0398', '市', 100, 'san men xia shi', 'ux115 ux97 ux110 ux109 ux101 ux120 ux105 ux104 ux19977 ux38376 ux23777 ux24066', 0, 0),
(1631, 1630, '411202', '湖滨区', 3, '0398', '区', 100, 'hu bin qu', 'ux104 ux117 ux98 ux105 ux110 ux113 ux28246 ux28392 ux21306', 0, 0),
(1632, 1630, '411221', '渑池县', 3, '0398', '区', 100, 'mian chi xian', 'ux109 ux105 ux97 ux110 ux99 ux104 ux120 ux28177 ux27744 ux21439', 0, 0),
(1633, 1630, '411222', '陕县', 3, '0398', '区', 100, 'shan xian', 'ux115 ux104 ux97 ux110 ux120 ux105 ux38485 ux21439', 0, 0),
(1634, 1630, '411224', '卢氏县', 3, '0398', '区', 100, 'lu shi xian', 'ux108 ux117 ux115 ux104 ux105 ux120 ux97 ux110 ux21346 ux27663 ux21439', 0, 0),
(1635, 1630, '411281', '义马市', 3, '0398', '区', 100, 'yi ma shi', 'ux121 ux105 ux109 ux97 ux115 ux104 ux20041 ux39532 ux24066', 0, 0),
(1636, 1630, '411282', '灵宝市', 3, '0398', '区', 100, 'ling bao shi', 'ux108 ux105 ux110 ux103 ux98 ux97 ux111 ux115 ux104 ux28789 ux23453 ux24066', 0, 0),
(1637, 1518, '411300', '南阳市', 2, '0377', '市', 100, 'nan yang shi', 'ux110 ux97 ux121 ux103 ux115 ux104 ux105 ux21335 ux38451 ux24066', 0, 0),
(1638, 1637, '411302', '宛城区', 3, '0377', '区', 100, 'wan cheng qu', 'ux119 ux97 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux23451 ux22478 ux21306', 0, 0),
(1639, 1637, '411303', '卧龙区', 3, '0377', '区', 100, 'wo long qu', 'ux119 ux111 ux108 ux110 ux103 ux113 ux117 ux21351 ux40857 ux21306', 0, 0),
(1640, 1637, '411321', '南召县', 3, '0377', '区', 100, 'nan zhao xian', 'ux110 ux97 ux122 ux104 ux111 ux120 ux105 ux21335 ux21484 ux21439', 0, 0),
(1641, 1637, '411322', '方城县', 3, '0377', '区', 100, 'fang cheng xian', 'ux102 ux97 ux110 ux103 ux99 ux104 ux101 ux120 ux105 ux26041 ux22478 ux21439', 0, 0),
(1642, 1637, '411323', '西峡县', 3, '0377', '区', 100, 'xi xia xian', 'ux120 ux105 ux97 ux110 ux35199 ux23777 ux21439', 0, 0),
(1643, 1637, '411324', '镇平县', 3, '0377', '区', 100, 'zhen ping xian', 'ux122 ux104 ux101 ux110 ux112 ux105 ux103 ux120 ux97 ux38215 ux24179 ux21439', 0, 0),
(1644, 1637, '411325', '内乡县', 3, '0377', '区', 100, 'nei xiang xian', 'ux110 ux101 ux105 ux120 ux97 ux103 ux20869 ux20065 ux21439', 0, 0),
(1645, 1637, '411326', '淅川县', 3, '0377', '区', 100, 'xi chuan xian', 'ux120 ux105 ux99 ux104 ux117 ux97 ux110 ux28101 ux24029 ux21439', 0, 0),
(1646, 1637, '411327', '社旗县', 3, '0377', '区', 100, 'she qi xian', 'ux115 ux104 ux101 ux113 ux105 ux120 ux97 ux110 ux31038 ux26071 ux21439', 0, 0),
(1647, 1637, '411328', '唐河县', 3, '0377', '区', 100, 'tang he xian', 'ux116 ux97 ux110 ux103 ux104 ux101 ux120 ux105 ux21776 ux27827 ux21439', 0, 0),
(1648, 1637, '411329', '新野县', 3, '0377', '区', 100, 'xin ye xian', 'ux120 ux105 ux110 ux121 ux101 ux97 ux26032 ux37326 ux21439', 0, 0),
(1649, 1637, '411330', '桐柏县', 3, '0377', '区', 100, 'tong bai xian', 'ux116 ux111 ux110 ux103 ux98 ux97 ux105 ux120 ux26704 ux26575 ux21439', 0, 0),
(1650, 1637, '411381', '邓州市', 3, '0377', '区', 100, 'deng zhou shi', 'ux100 ux101 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux105 ux37011 ux24030 ux24066', 0, 0),
(1651, 1518, '411400', '商丘市', 2, '0370', '市', 100, 'shang qiu shi', 'ux115 ux104 ux97 ux110 ux103 ux113 ux105 ux117 ux21830 ux19992 ux24066', 0, 0),
(1652, 1651, '411402', '梁园区', 3, '0370', '区', 100, 'liang yuan qu', 'ux108 ux105 ux97 ux110 ux103 ux121 ux117 ux113 ux26753 ux22253 ux21306', 0, 0),
(1653, 1651, '411403', '睢阳区', 3, '0370', '区', 100, 'sui yang qu', 'ux115 ux117 ux105 ux121 ux97 ux110 ux103 ux113 ux30562 ux38451 ux21306', 0, 0),
(1654, 1651, '411421', '民权县', 3, '0370', '区', 100, 'min quan xian', 'ux109 ux105 ux110 ux113 ux117 ux97 ux120 ux27665 ux26435 ux21439', 0, 0),
(1655, 1651, '411422', '睢县', 3, '0370', '区', 100, 'sui xian', 'ux115 ux117 ux105 ux120 ux97 ux110 ux30562 ux21439', 0, 0),
(1656, 1651, '411423', '宁陵县', 3, '0370', '区', 100, 'ning ling xian', 'ux110 ux105 ux103 ux108 ux120 ux97 ux23425 ux38517 ux21439', 0, 0),
(1657, 1651, '411424', '柘城县', 3, '0370', '区', 100, 'zhe cheng xian', 'ux122 ux104 ux101 ux99 ux110 ux103 ux120 ux105 ux97 ux26584 ux22478 ux21439', 0, 0),
(1658, 1651, '411425', '虞城县', 3, '0370', '区', 100, 'yu cheng xian', 'ux121 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux34398 ux22478 ux21439', 0, 0),
(1659, 1651, '411426', '夏邑县', 3, '0370', '区', 100, 'xia yi xian', 'ux120 ux105 ux97 ux121 ux110 ux22799 ux37009 ux21439', 0, 0),
(1660, 1651, '411481', '永城市', 3, '0370', '区', 100, 'yong cheng shi', 'ux121 ux111 ux110 ux103 ux99 ux104 ux101 ux115 ux105 ux27704 ux22478 ux24066', 0, 0),
(1661, 1518, '411500', '信阳市', 2, '0376', '市', 100, 'xin yang shi', 'ux120 ux105 ux110 ux121 ux97 ux103 ux115 ux104 ux20449 ux38451 ux24066', 0, 0),
(1662, 1661, '411502', '浉河区', 3, '0376', '区', 100, 'shi he qu', 'ux115 ux104 ux105 ux101 ux113 ux117 ux27977 ux27827 ux21306', 0, 0),
(1663, 1661, '411503', '平桥区', 3, '0376', '区', 100, 'ping qiao qu', 'ux112 ux105 ux110 ux103 ux113 ux97 ux111 ux117 ux24179 ux26725 ux21306', 0, 0),
(1664, 1661, '411521', '罗山县', 3, '0376', '区', 100, 'luo shan xian', 'ux108 ux117 ux111 ux115 ux104 ux97 ux110 ux120 ux105 ux32599 ux23665 ux21439', 0, 0),
(1665, 1661, '411522', '光山县', 3, '0376', '区', 100, 'guang shan xian', 'ux103 ux117 ux97 ux110 ux115 ux104 ux120 ux105 ux20809 ux23665 ux21439', 0, 0),
(1666, 1661, '411523', '新县', 3, '0376', '区', 100, 'xin xian', 'ux120 ux105 ux110 ux97 ux26032 ux21439', 0, 0),
(1667, 1661, '411524', '商城县', 3, '0376', '区', 100, 'shang cheng xian', 'ux115 ux104 ux97 ux110 ux103 ux99 ux101 ux120 ux105 ux21830 ux22478 ux21439', 0, 0),
(1668, 1661, '411525', '固始县', 3, '0376', '区', 100, 'gu shi xian', 'ux103 ux117 ux115 ux104 ux105 ux120 ux97 ux110 ux22266 ux22987 ux21439', 0, 0),
(1669, 1661, '411526', '潢川县', 3, '0376', '区', 100, 'huang chuan xian', 'ux104 ux117 ux97 ux110 ux103 ux99 ux120 ux105 ux28514 ux24029 ux21439', 0, 0),
(1670, 1661, '411527', '淮滨县', 3, '0376', '区', 100, 'huai bin xian', 'ux104 ux117 ux97 ux105 ux98 ux110 ux120 ux28142 ux28392 ux21439', 0, 0),
(1671, 1661, '411528', '息县', 3, '0376', '区', 100, 'xi xian', 'ux120 ux105 ux97 ux110 ux24687 ux21439', 0, 0),
(1672, 1518, '411600', '周口市', 2, '0394', '市', 100, 'zhou kou shi', 'ux122 ux104 ux111 ux117 ux107 ux115 ux105 ux21608 ux21475 ux24066', 0, 0),
(1673, 1672, '411602', '川汇区', 3, '0394', '区', 100, 'chuan hui qu', 'ux99 ux104 ux117 ux97 ux110 ux105 ux113 ux24029 ux27719 ux21306', 0, 0),
(1674, 1672, '411621', '扶沟县', 3, '0394', '区', 100, 'fu gou xian', 'ux102 ux117 ux103 ux111 ux120 ux105 ux97 ux110 ux25206 ux27807 ux21439', 0, 0),
(1675, 1672, '411622', '西华县', 3, '0394', '区', 100, 'xi hua xian', 'ux120 ux105 ux104 ux117 ux97 ux110 ux35199 ux21326 ux21439', 0, 0),
(1676, 1672, '411623', '商水县', 3, '0394', '区', 100, 'shang shui xian', 'ux115 ux104 ux97 ux110 ux103 ux117 ux105 ux120 ux21830 ux27700 ux21439', 0, 0),
(1677, 1672, '411624', '沈丘县', 3, '0394', '区', 100, 'shen qiu xian', 'ux115 ux104 ux101 ux110 ux113 ux105 ux117 ux120 ux97 ux27784 ux19992 ux21439', 0, 0),
(1678, 1672, '411625', '郸城县', 3, '0394', '区', 100, 'dan cheng xian', 'ux100 ux97 ux110 ux99 ux104 ux101 ux103 ux120 ux105 ux37112 ux22478 ux21439', 0, 0),
(1679, 1672, '411626', '淮阳县', 3, '0394', '区', 100, 'huai yang xian', 'ux104 ux117 ux97 ux105 ux121 ux110 ux103 ux120 ux28142 ux38451 ux21439', 0, 0),
(1680, 1672, '411627', '太康县', 3, '0394', '区', 100, 'tai kang xian', 'ux116 ux97 ux105 ux107 ux110 ux103 ux120 ux22826 ux24247 ux21439', 0, 0),
(1681, 1672, '411628', '鹿邑县', 3, '0394', '区', 100, 'lu yi xian', 'ux108 ux117 ux121 ux105 ux120 ux97 ux110 ux40575 ux37009 ux21439', 0, 0),
(1682, 1672, '411681', '项城市', 3, '0394', '区', 100, 'xiang cheng shi', 'ux120 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux115 ux39033 ux22478 ux24066', 0, 0),
(1683, 1518, '411700', '驻马店市', 2, '0396', '市', 100, 'zhu ma dian shi', 'ux122 ux104 ux117 ux109 ux97 ux100 ux105 ux110 ux115 ux39547 ux39532 ux24215 ux24066', 0, 0),
(1684, 1683, '411702', '驿城区', 3, '0396', '区', 100, 'yi cheng qu', 'ux121 ux105 ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux39551 ux22478 ux21306', 0, 0),
(1685, 1683, '411721', '西平县', 3, '0396', '区', 100, 'xi ping xian', 'ux120 ux105 ux112 ux110 ux103 ux97 ux35199 ux24179 ux21439', 0, 0),
(1686, 1683, '411722', '上蔡县', 3, '0396', '区', 100, 'shang cai xian', 'ux115 ux104 ux97 ux110 ux103 ux99 ux105 ux120 ux19978 ux34081 ux21439', 0, 0),
(1687, 1683, '411723', '平舆县', 3, '0396', '区', 100, 'ping yu xian', 'ux112 ux105 ux110 ux103 ux121 ux117 ux120 ux97 ux24179 ux33286 ux21439', 0, 0),
(1688, 1683, '411724', '正阳县', 3, '0396', '区', 100, 'zheng yang xian', 'ux122 ux104 ux101 ux110 ux103 ux121 ux97 ux120 ux105 ux27491 ux38451 ux21439', 0, 0),
(1689, 1683, '411725', '确山县', 3, '0396', '区', 100, 'que shan xian', 'ux113 ux117 ux101 ux115 ux104 ux97 ux110 ux120 ux105 ux30830 ux23665 ux21439', 0, 0),
(1690, 1683, '411726', '泌阳县', 3, '0396', '区', 100, 'mi yang xian', 'ux109 ux105 ux121 ux97 ux110 ux103 ux120 ux27852 ux38451 ux21439', 0, 0),
(1691, 1683, '411727', '汝南县', 3, '0396', '区', 100, 'ru nan xian', 'ux114 ux117 ux110 ux97 ux120 ux105 ux27741 ux21335 ux21439', 0, 0),
(1692, 1683, '411728', '遂平县', 3, '0396', '区', 100, 'sui ping xian', 'ux115 ux117 ux105 ux112 ux110 ux103 ux120 ux97 ux36930 ux24179 ux21439', 0, 0),
(1693, 1683, '411729', '新蔡县', 3, '0396', '区', 100, 'xin cai xian', 'ux120 ux105 ux110 ux99 ux97 ux26032 ux34081 ux21439', 0, 0),
(1694, 1518, '419000', '省直辖', 2, '', '市', 100, 'sheng zhi xia', 'ux115 ux104 ux101 ux110 ux103 ux122 ux105 ux120 ux97 ux30465 ux30452 ux36758', 0, 0),
(1695, 1694, '419001', '济源市', 3, '0391', '区', 100, 'ji yuan shi', 'ux106 ux105 ux121 ux117 ux97 ux110 ux115 ux104 ux27982 ux28304 ux24066', 0, 0),
(1696, 0, '420000', '湖北省', 1, '', '省', 100, 'hu bei sheng', 'ux104 ux117 ux98 ux101 ux105 ux115 ux110 ux103 ux28246 ux21271 ux30465', 0, 0),
(1697, 1696, '420100', '武汉市', 2, '027', '市', 100, 'wu han shi', 'ux119 ux117 ux104 ux97 ux110 ux115 ux105 ux27494 ux27721 ux24066', 0, 0),
(1698, 1697, '420102', '江岸区', 3, '027', '区', 100, 'jiang an qu', 'ux106 ux105 ux97 ux110 ux103 ux113 ux117 ux27743 ux23736 ux21306', 0, 0),
(1699, 1697, '420103', '江汉区', 3, '0728', '区', 100, 'jiang han qu', 'ux106 ux105 ux97 ux110 ux103 ux104 ux113 ux117 ux27743 ux27721 ux21306', 0, 0),
(1700, 1697, '420104', '硚口区', 3, '027', '区', 100, 'qiao kou qu', 'ux113 ux105 ux97 ux111 ux107 ux117 ux30810 ux21475 ux21306', 0, 0),
(1701, 1697, '420105', '汉阳区', 3, '027', '区', 100, 'han yang qu', 'ux104 ux97 ux110 ux121 ux103 ux113 ux117 ux27721 ux38451 ux21306', 0, 0),
(1702, 1697, '420106', '武昌区', 3, '027', '区', 100, 'wu chang qu', 'ux119 ux117 ux99 ux104 ux97 ux110 ux103 ux113 ux27494 ux26124 ux21306', 0, 0),
(1703, 1697, '420107', '青山区', 3, '027', '区', 100, 'qing shan qu', 'ux113 ux105 ux110 ux103 ux115 ux104 ux97 ux117 ux38738 ux23665 ux21306', 0, 0),
(1704, 1697, '420111', '洪山区', 3, '027', '区', 100, 'hong shan qu', 'ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux27946 ux23665 ux21306', 0, 0),
(1705, 1697, '420112', '东西湖区', 3, '027', '区', 100, 'dong xi hu qu', 'ux100 ux111 ux110 ux103 ux120 ux105 ux104 ux117 ux113 ux19996 ux35199 ux28246 ux21306', 0, 0),
(1706, 1697, '420113', '汉南区', 3, '027', '区', 100, 'han nan qu', 'ux104 ux97 ux110 ux113 ux117 ux27721 ux21335 ux21306', 0, 0),
(1707, 1697, '420114', '蔡甸区', 3, '027', '区', 100, 'cai dian qu', 'ux99 ux97 ux105 ux100 ux110 ux113 ux117 ux34081 ux30008 ux21306', 0, 0),
(1708, 1697, '420115', '江夏区', 3, '027', '区', 100, 'jiang xia qu', 'ux106 ux105 ux97 ux110 ux103 ux120 ux113 ux117 ux27743 ux22799 ux21306', 0, 0),
(1709, 1697, '420116', '黄陂区', 3, '027', '区', 100, 'huang bei qu', 'ux104 ux117 ux97 ux110 ux103 ux98 ux101 ux105 ux113 ux40644 ux38466 ux21306', 0, 0),
(1710, 1697, '420117', '新洲区', 3, '027', '区', 100, 'xin zhou qu', 'ux120 ux105 ux110 ux122 ux104 ux111 ux117 ux113 ux26032 ux27954 ux21306', 0, 0),
(1711, 1696, '420200', '黄石市', 2, '0714', '市', 100, 'huang shi shi', 'ux104 ux117 ux97 ux110 ux103 ux115 ux105 ux40644 ux30707 ux24066', 0, 0),
(1712, 1711, '420202', '黄石港区', 3, '0714', '区', 100, 'huang shi gang qu', 'ux104 ux117 ux97 ux110 ux103 ux115 ux105 ux113 ux40644 ux30707 ux28207 ux21306', 0, 0),
(1713, 1711, '420203', '西塞山区', 3, '0714', '区', 100, 'xi sai shan qu', 'ux120 ux105 ux115 ux97 ux104 ux110 ux113 ux117 ux35199 ux22622 ux23665 ux21306', 0, 0),
(1714, 1711, '420204', '下陆区', 3, '0714', '区', 100, 'xia lu qu', 'ux120 ux105 ux97 ux108 ux117 ux113 ux19979 ux38470 ux21306', 0, 0),
(1715, 1711, '420205', '铁山区', 3, '0714', '区', 100, 'tie shan qu', 'ux116 ux105 ux101 ux115 ux104 ux97 ux110 ux113 ux117 ux38081 ux23665 ux21306', 0, 0),
(1716, 1711, '420222', '阳新县', 3, '0714', '区', 100, 'yang xin xian', 'ux121 ux97 ux110 ux103 ux120 ux105 ux38451 ux26032 ux21439', 0, 0),
(1717, 1711, '420281', '大冶市', 3, '0714', '区', 100, 'da ye shi', 'ux100 ux97 ux121 ux101 ux115 ux104 ux105 ux22823 ux20918 ux24066', 0, 0),
(1718, 1696, '420300', '十堰市', 2, '0719', '市', 100, 'shi yan shi', 'ux115 ux104 ux105 ux121 ux97 ux110 ux21313 ux22576 ux24066', 0, 0),
(1719, 1718, '420302', '茅箭区', 3, '0719', '区', 100, 'mao jian qu', 'ux109 ux97 ux111 ux106 ux105 ux110 ux113 ux117 ux33541 ux31661 ux21306', 0, 0),
(1720, 1718, '420303', '张湾区', 3, '0719', '区', 100, 'zhang wan qu', 'ux122 ux104 ux97 ux110 ux103 ux119 ux113 ux117 ux24352 ux28286 ux21306', 0, 0),
(1721, 1718, '420321', '郧县', 3, '0719', '区', 100, 'yun xian', 'ux121 ux117 ux110 ux120 ux105 ux97 ux37095 ux21439', 0, 0),
(1722, 1718, '420322', '郧西县', 3, '0719', '区', 100, 'yun xi xian', 'ux121 ux117 ux110 ux120 ux105 ux97 ux37095 ux35199 ux21439', 0, 0),
(1723, 1718, '420323', '竹山县', 3, '0719', '区', 100, 'zhu shan xian', 'ux122 ux104 ux117 ux115 ux97 ux110 ux120 ux105 ux31481 ux23665 ux21439', 0, 0),
(1724, 1718, '420324', '竹溪县', 3, '0719', '区', 100, 'zhu xi xian', 'ux122 ux104 ux117 ux120 ux105 ux97 ux110 ux31481 ux28330 ux21439', 0, 0),
(1725, 1718, '420325', '房县', 3, '0719', '区', 100, 'fang xian', 'ux102 ux97 ux110 ux103 ux120 ux105 ux25151 ux21439', 0, 0),
(1726, 1718, '420381', '丹江口市', 3, '0719', '区', 100, 'dan jiang kou shi', 'ux100 ux97 ux110 ux106 ux105 ux103 ux107 ux111 ux117 ux115 ux104 ux20025 ux27743 ux21475 ux24066', 0, 0),
(1727, 1696, '420500', '宜昌市', 2, '0717', '市', 100, 'yi chang shi', 'ux121 ux105 ux99 ux104 ux97 ux110 ux103 ux115 ux23452 ux26124 ux24066', 0, 0),
(1728, 1727, '420502', '西陵区', 3, '0717', '区', 100, 'xi ling qu', 'ux120 ux105 ux108 ux110 ux103 ux113 ux117 ux35199 ux38517 ux21306', 0, 0),
(1729, 1727, '420503', '伍家岗区', 3, '0717', '区', 100, 'wu jia gang qu', 'ux119 ux117 ux106 ux105 ux97 ux103 ux110 ux113 ux20237 ux23478 ux23703 ux21306', 0, 0),
(1730, 1727, '420504', '点军区', 3, '0717', '区', 100, 'dian jun qu', 'ux100 ux105 ux97 ux110 ux106 ux117 ux113 ux28857 ux20891 ux21306', 0, 0),
(1731, 1727, '420505', '猇亭区', 3, '0717', '区', 100, 'xiao ting qu', 'ux120 ux105 ux97 ux111 ux116 ux110 ux103 ux113 ux117 ux29447 ux20141 ux21306', 0, 0),
(1732, 1727, '420506', '夷陵区', 3, '0717', '区', 100, 'yi ling qu', 'ux121 ux105 ux108 ux110 ux103 ux113 ux117 ux22839 ux38517 ux21306', 0, 0),
(1733, 1727, '420525', '远安县', 3, '0717', '区', 100, 'yuan an xian', 'ux121 ux117 ux97 ux110 ux120 ux105 ux36828 ux23433 ux21439', 0, 0),
(1734, 1727, '420526', '兴山县', 3, '0717', '区', 100, 'xing shan xian', 'ux120 ux105 ux110 ux103 ux115 ux104 ux97 ux20852 ux23665 ux21439', 0, 0),
(1735, 1727, '420527', '秭归县', 3, '0717', '区', 100, 'zi gui xian', 'ux122 ux105 ux103 ux117 ux120 ux97 ux110 ux31213 ux24402 ux21439', 0, 0),
(1736, 1727, '420528', '长阳土家族自治县', 3, '0717', '区', 100, 'chang yang tu jia zu zi zhi xian', 'ux99 ux104 ux97 ux110 ux103 ux121 ux116 ux117 ux106 ux105 ux122 ux120 ux38271 ux38451 ux22303 ux23478 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1737, 1727, '420529', '五峰土家族自治县', 3, '0717', '区', 100, 'wu feng tu jia zu zi zhi xian', 'ux119 ux117 ux102 ux101 ux110 ux103 ux116 ux106 ux105 ux97 ux122 ux104 ux120 ux20116 ux23792 ux22303 ux23478 ux26063 ux33258 ux27835 ux21439', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(1738, 1727, '420581', '宜都市', 3, '0717', '区', 100, 'yi du shi', 'ux121 ux105 ux100 ux117 ux115 ux104 ux23452 ux37117 ux24066', 0, 0),
(1739, 1727, '420582', '当阳市', 3, '0717', '区', 100, 'dang yang shi', 'ux100 ux97 ux110 ux103 ux121 ux115 ux104 ux105 ux24403 ux38451 ux24066', 0, 0),
(1740, 1727, '420583', '枝江市', 3, '0717', '区', 100, 'zhi jiang shi', 'ux122 ux104 ux105 ux106 ux97 ux110 ux103 ux115 ux26525 ux27743 ux24066', 0, 0),
(1741, 1696, '420600', '襄阳市', 2, '0710', '市', 100, 'xiang yang shi', 'ux120 ux105 ux97 ux110 ux103 ux121 ux115 ux104 ux35140 ux38451 ux24066', 0, 0),
(1742, 1741, '420602', '襄城区', 3, '0710', '区', 100, 'xiang cheng qu', 'ux120 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux35140 ux22478 ux21306', 0, 0),
(1743, 1741, '420606', '樊城区', 3, '0710', '区', 100, 'fan cheng qu', 'ux102 ux97 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux27146 ux22478 ux21306', 0, 0),
(1744, 1741, '420607', '襄州区', 3, '0710', '区', 100, 'xiang zhou qu', 'ux120 ux105 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux113 ux35140 ux24030 ux21306', 0, 0),
(1745, 1741, '420624', '南漳县', 3, '0710', '区', 100, 'nan zhang xian', 'ux110 ux97 ux122 ux104 ux103 ux120 ux105 ux21335 ux28467 ux21439', 0, 0),
(1746, 1741, '420625', '谷城县', 3, '0710', '区', 100, 'gu cheng xian', 'ux103 ux117 ux99 ux104 ux101 ux110 ux120 ux105 ux97 ux35895 ux22478 ux21439', 0, 0),
(1747, 1741, '420626', '保康县', 3, '0710', '区', 100, 'bao kang xian', 'ux98 ux97 ux111 ux107 ux110 ux103 ux120 ux105 ux20445 ux24247 ux21439', 0, 0),
(1748, 1741, '420682', '老河口市', 3, '0710', '区', 100, 'lao he kou shi', 'ux108 ux97 ux111 ux104 ux101 ux107 ux117 ux115 ux105 ux32769 ux27827 ux21475 ux24066', 0, 0),
(1749, 1741, '420683', '枣阳市', 3, '0710', '区', 100, 'zao yang shi', 'ux122 ux97 ux111 ux121 ux110 ux103 ux115 ux104 ux105 ux26531 ux38451 ux24066', 0, 0),
(1750, 1741, '420684', '宜城市', 3, '0710', '区', 100, 'yi cheng shi', 'ux121 ux105 ux99 ux104 ux101 ux110 ux103 ux115 ux23452 ux22478 ux24066', 0, 0),
(1751, 1696, '420700', '鄂州市', 2, '0711', '市', 100, 'e zhou shi', 'ux101 ux122 ux104 ux111 ux117 ux115 ux105 ux37122 ux24030 ux24066', 0, 0),
(1752, 1751, '420702', '梁子湖区', 3, '0711', '区', 100, 'liang zi hu qu', 'ux108 ux105 ux97 ux110 ux103 ux122 ux104 ux117 ux113 ux26753 ux23376 ux28246 ux21306', 0, 0),
(1753, 1751, '420703', '华容区', 3, '0711', '区', 100, 'hua rong qu', 'ux104 ux117 ux97 ux114 ux111 ux110 ux103 ux113 ux21326 ux23481 ux21306', 0, 0),
(1754, 1751, '420704', '鄂城区', 3, '0711', '区', 100, 'e cheng qu', 'ux101 ux99 ux104 ux110 ux103 ux113 ux117 ux37122 ux22478 ux21306', 0, 0),
(1755, 1696, '420800', '荆门市', 2, '0724', '市', 100, 'jing men shi', 'ux106 ux105 ux110 ux103 ux109 ux101 ux115 ux104 ux33606 ux38376 ux24066', 0, 0),
(1756, 1755, '420802', '东宝区', 3, '0724', '区', 100, 'dong bao qu', 'ux100 ux111 ux110 ux103 ux98 ux97 ux113 ux117 ux19996 ux23453 ux21306', 0, 0),
(1757, 1755, '420804', '掇刀区', 3, '0724', '区', 100, 'duo dao qu', 'ux100 ux117 ux111 ux97 ux113 ux25479 ux20992 ux21306', 0, 0),
(1758, 1755, '420821', '京山县', 3, '0724', '区', 100, 'jing shan xian', 'ux106 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux20140 ux23665 ux21439', 0, 0),
(1759, 1755, '420822', '沙洋县', 3, '0724', '区', 100, 'sha yang xian', 'ux115 ux104 ux97 ux121 ux110 ux103 ux120 ux105 ux27801 ux27915 ux21439', 0, 0),
(1760, 1755, '420881', '钟祥市', 3, '0724', '区', 100, 'zhong xiang shi', 'ux122 ux104 ux111 ux110 ux103 ux120 ux105 ux97 ux115 ux38047 ux31077 ux24066', 0, 0),
(1761, 1696, '420900', '孝感市', 2, '0712', '市', 100, 'xiao gan shi', 'ux120 ux105 ux97 ux111 ux103 ux110 ux115 ux104 ux23389 ux24863 ux24066', 0, 0),
(1762, 1761, '420902', '孝南区', 3, '0712', '区', 100, 'xiao nan qu', 'ux120 ux105 ux97 ux111 ux110 ux113 ux117 ux23389 ux21335 ux21306', 0, 0),
(1763, 1761, '420921', '孝昌县', 3, '0712', '区', 100, 'xiao chang xian', 'ux120 ux105 ux97 ux111 ux99 ux104 ux110 ux103 ux23389 ux26124 ux21439', 0, 0),
(1764, 1761, '420922', '大悟县', 3, '0712', '区', 100, 'da wu xian', 'ux100 ux97 ux119 ux117 ux120 ux105 ux110 ux22823 ux24735 ux21439', 0, 0),
(1765, 1761, '420923', '云梦县', 3, '0712', '区', 100, 'yun meng xian', 'ux121 ux117 ux110 ux109 ux101 ux103 ux120 ux105 ux97 ux20113 ux26790 ux21439', 0, 0),
(1766, 1761, '420981', '应城市', 3, '0712', '区', 100, 'ying cheng shi', 'ux121 ux105 ux110 ux103 ux99 ux104 ux101 ux115 ux24212 ux22478 ux24066', 0, 0),
(1767, 1761, '420982', '安陆市', 3, '0712', '区', 100, 'an lu shi', 'ux97 ux110 ux108 ux117 ux115 ux104 ux105 ux23433 ux38470 ux24066', 0, 0),
(1768, 1761, '420984', '汉川市', 3, '0712', '区', 100, 'han chuan shi', 'ux104 ux97 ux110 ux99 ux117 ux115 ux105 ux27721 ux24029 ux24066', 0, 0),
(1769, 1696, '421000', '荆州市', 2, '0716', '市', 100, 'jing zhou shi', 'ux106 ux105 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux33606 ux24030 ux24066', 0, 0),
(1770, 1769, '421002', '沙市区', 3, '0716', '区', 100, 'sha shi qu', 'ux115 ux104 ux97 ux105 ux113 ux117 ux27801 ux24066 ux21306', 0, 0),
(1771, 1769, '421003', '荆州区', 3, '0716', '区', 100, 'jing zhou qu', 'ux106 ux105 ux110 ux103 ux122 ux104 ux111 ux117 ux113 ux33606 ux24030 ux21306', 0, 0),
(1772, 1769, '421022', '公安县', 3, '0716', '区', 100, 'gong an xian', 'ux103 ux111 ux110 ux97 ux120 ux105 ux20844 ux23433 ux21439', 0, 0),
(1773, 1769, '421023', '监利县', 3, '0716', '区', 100, 'jian li xian', 'ux106 ux105 ux97 ux110 ux108 ux120 ux30417 ux21033 ux21439', 0, 0),
(1774, 1769, '421024', '江陵县', 3, '0716', '区', 100, 'jiang ling xian', 'ux106 ux105 ux97 ux110 ux103 ux108 ux120 ux27743 ux38517 ux21439', 0, 0),
(1775, 1769, '421081', '石首市', 3, '0716', '区', 100, 'shi shou shi', 'ux115 ux104 ux105 ux111 ux117 ux30707 ux39318 ux24066', 0, 0),
(1776, 1769, '421083', '洪湖市', 3, '0716', '区', 100, 'hong hu shi', 'ux104 ux111 ux110 ux103 ux117 ux115 ux105 ux27946 ux28246 ux24066', 0, 0),
(1777, 1769, '421087', '松滋市', 3, '0716', '区', 100, 'song zi shi', 'ux115 ux111 ux110 ux103 ux122 ux105 ux104 ux26494 ux28363 ux24066', 0, 0),
(1778, 1696, '421100', '黄冈市', 2, '0713', '市', 100, 'huang gang shi', 'ux104 ux117 ux97 ux110 ux103 ux115 ux105 ux40644 ux20872 ux24066', 0, 0),
(1779, 1778, '421102', '黄州区', 3, '0713', '区', 100, 'huang zhou qu', 'ux104 ux117 ux97 ux110 ux103 ux122 ux111 ux113 ux40644 ux24030 ux21306', 0, 0),
(1780, 1778, '421121', '团风县', 3, '0713', '区', 100, 'tuan feng xian', 'ux116 ux117 ux97 ux110 ux102 ux101 ux103 ux120 ux105 ux22242 ux39118 ux21439', 0, 0),
(1781, 1778, '421122', '红安县', 3, '0713', '区', 100, 'hong an xian', 'ux104 ux111 ux110 ux103 ux97 ux120 ux105 ux32418 ux23433 ux21439', 0, 0),
(1782, 1778, '421123', '罗田县', 3, '0713', '区', 100, 'luo tian xian', 'ux108 ux117 ux111 ux116 ux105 ux97 ux110 ux120 ux32599 ux30000 ux21439', 0, 0),
(1783, 1778, '421124', '英山县', 3, '0713', '区', 100, 'ying shan xian', 'ux121 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux33521 ux23665 ux21439', 0, 0),
(1784, 1778, '421125', '浠水县', 3, '0713', '区', 100, 'xi shui xian', 'ux120 ux105 ux115 ux104 ux117 ux97 ux110 ux28000 ux27700 ux21439', 0, 0),
(1785, 1778, '421126', '蕲春县', 3, '0713', '区', 100, 'qi chun xian', 'ux113 ux105 ux99 ux104 ux117 ux110 ux120 ux97 ux34162 ux26149 ux21439', 0, 0),
(1786, 1778, '421127', '黄梅县', 3, '0713', '区', 100, 'huang mei xian', 'ux104 ux117 ux97 ux110 ux103 ux109 ux101 ux105 ux120 ux40644 ux26757 ux21439', 0, 0),
(1787, 1778, '421181', '麻城市', 3, '0713', '区', 100, 'ma cheng shi', 'ux109 ux97 ux99 ux104 ux101 ux110 ux103 ux115 ux105 ux40635 ux22478 ux24066', 0, 0),
(1788, 1778, '421182', '武穴市', 3, '0713', '区', 100, 'wu xue shi', 'ux119 ux117 ux120 ux101 ux115 ux104 ux105 ux27494 ux31348 ux24066', 0, 0),
(1789, 1696, '421200', '咸宁市', 2, '0715', '市', 100, 'xian ning shi', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux21688 ux23425 ux24066', 0, 0),
(1790, 1789, '421202', '咸安区', 3, '0715', '区', 100, 'xian an qu', 'ux120 ux105 ux97 ux110 ux113 ux117 ux21688 ux23433 ux21306', 0, 0),
(1791, 1789, '421221', '嘉鱼县', 3, '0715', '区', 100, 'jia yu xian', 'ux106 ux105 ux97 ux121 ux117 ux120 ux110 ux22025 ux40060 ux21439', 0, 0),
(1792, 1789, '421222', '通城县', 3, '0715', '区', 100, 'tong cheng xian', 'ux116 ux111 ux110 ux103 ux99 ux104 ux101 ux120 ux105 ux97 ux36890 ux22478 ux21439', 0, 0),
(1793, 1789, '421223', '崇阳县', 3, '0715', '区', 100, 'chong yang xian', 'ux99 ux104 ux111 ux110 ux103 ux121 ux97 ux120 ux105 ux23815 ux38451 ux21439', 0, 0),
(1794, 1789, '421224', '通山县', 3, '0715', '区', 100, 'tong shan xian', 'ux116 ux111 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux36890 ux23665 ux21439', 0, 0),
(1795, 1789, '421281', '赤壁市', 3, '0715', '区', 100, 'chi bi shi', 'ux99 ux104 ux105 ux98 ux115 ux36196 ux22721 ux24066', 0, 0),
(1796, 1696, '421300', '随州市', 2, '0722', '市', 100, 'sui zhou shi', 'ux115 ux117 ux105 ux122 ux104 ux111 ux38543 ux24030 ux24066', 0, 0),
(1797, 1796, '421303', '曾都区', 3, '0722', '区', 100, 'zeng du qu', 'ux122 ux101 ux110 ux103 ux100 ux117 ux113 ux26366 ux37117 ux21306', 0, 0),
(1798, 1796, '421321', '随县', 3, '0722', '区', 100, 'sui xian', 'ux115 ux117 ux105 ux120 ux97 ux110 ux38543 ux21439', 0, 0),
(1799, 1796, '421381', '广水市', 3, '0722', '区', 100, 'guang shui shi', 'ux103 ux117 ux97 ux110 ux115 ux104 ux105 ux24191 ux27700 ux24066', 0, 0),
(1800, 1696, '422800', '恩施土家族苗族自治州', 2, '0718', '市', 100, 'en shi tu jia zu miao zu zi zhi zhou', 'ux101 ux110 ux115 ux104 ux105 ux116 ux117 ux106 ux97 ux122 ux109 ux111 ux24681 ux26045 ux22303 ux23478 ux26063 ux33495 ux33258 ux27835 ux24030', 0, 0),
(1801, 1800, '422801', '恩施市', 3, '0718', '区', 100, 'en shi shi', 'ux101 ux110 ux115 ux104 ux105 ux24681 ux26045 ux24066', 0, 0),
(1802, 1800, '422802', '利川市', 3, '0718', '区', 100, 'li chuan shi', 'ux108 ux105 ux99 ux104 ux117 ux97 ux110 ux115 ux21033 ux24029 ux24066', 0, 0),
(1803, 1800, '422822', '建始县', 3, '0718', '区', 100, 'jian shi xian', 'ux106 ux105 ux97 ux110 ux115 ux104 ux120 ux24314 ux22987 ux21439', 0, 0),
(1804, 1800, '422823', '巴东县', 3, '0718', '区', 100, 'ba dong xian', 'ux98 ux97 ux100 ux111 ux110 ux103 ux120 ux105 ux24052 ux19996 ux21439', 0, 0),
(1805, 1800, '422825', '宣恩县', 3, '0718', '区', 100, 'xuan en xian', 'ux120 ux117 ux97 ux110 ux101 ux105 ux23459 ux24681 ux21439', 0, 0),
(1806, 1800, '422826', '咸丰县', 3, '0718', '区', 100, 'xian feng xian', 'ux120 ux105 ux97 ux110 ux102 ux101 ux103 ux21688 ux20016 ux21439', 0, 0),
(1807, 1800, '422827', '来凤县', 3, '0718', '区', 100, 'lai feng xian', 'ux108 ux97 ux105 ux102 ux101 ux110 ux103 ux120 ux26469 ux20964 ux21439', 0, 0),
(1808, 1800, '422828', '鹤峰县', 3, '0718', '区', 100, 'he feng xian', 'ux104 ux101 ux102 ux110 ux103 ux120 ux105 ux97 ux40548 ux23792 ux21439', 0, 0),
(1809, 1696, '429000', '省直辖', 2, '', '市', 100, 'sheng zhi xia', 'ux115 ux104 ux101 ux110 ux103 ux122 ux105 ux120 ux97 ux30465 ux30452 ux36758', 0, 0),
(1810, 1809, '429004', '仙桃市', 3, '0728', '区', 100, 'xian tao shi', 'ux120 ux105 ux97 ux110 ux116 ux111 ux115 ux104 ux20185 ux26691 ux24066', 0, 0),
(1811, 1809, '429005', '潜江市', 3, '0728', '区', 100, 'qian jiang shi', 'ux113 ux105 ux97 ux110 ux106 ux103 ux115 ux104 ux28508 ux27743 ux24066', 0, 0),
(1812, 1809, '429006', '天门市', 3, '0728', '区', 100, 'tian men shi', 'ux116 ux105 ux97 ux110 ux109 ux101 ux115 ux104 ux22825 ux38376 ux24066', 0, 0),
(1813, 1809, '429021', '神农架林区', 3, '0719', '区', 100, 'shen nong jia lin qu', 'ux115 ux104 ux101 ux110 ux111 ux103 ux106 ux105 ux97 ux108 ux113 ux117 ux31070 ux20892 ux26550 ux26519 ux21306', 0, 0),
(1814, 0, '430000', '湖南省', 1, '', '省', 100, 'hu nan sheng', 'ux104 ux117 ux110 ux97 ux115 ux101 ux103 ux28246 ux21335 ux30465', 0, 0),
(1815, 1814, '430100', '长沙市', 2, '0731', '市', 100, 'chang sha shi', 'ux99 ux104 ux97 ux110 ux103 ux115 ux105 ux38271 ux27801 ux24066', 0, 0),
(1816, 1815, '430102', '芙蓉区', 3, '0731', '区', 100, 'fu rong qu', 'ux102 ux117 ux114 ux111 ux110 ux103 ux113 ux33433 ux33993 ux21306', 0, 0),
(1817, 1815, '430103', '天心区', 3, '0731', '区', 100, 'tian xin qu', 'ux116 ux105 ux97 ux110 ux120 ux113 ux117 ux22825 ux24515 ux21306', 0, 0),
(1818, 1815, '430104', '岳麓区', 3, '0731', '区', 100, 'yue lu qu', 'ux121 ux117 ux101 ux108 ux113 ux23731 ux40595 ux21306', 0, 0),
(1819, 1815, '430105', '开福区', 3, '0731', '区', 100, 'kai fu qu', 'ux107 ux97 ux105 ux102 ux117 ux113 ux24320 ux31119 ux21306', 0, 0),
(1820, 1815, '430111', '雨花区', 3, '0731', '区', 100, 'yu hua qu', 'ux121 ux117 ux104 ux97 ux113 ux38632 ux33457 ux21306', 0, 0),
(1821, 1815, '430112', '望城区', 3, '0731', '区', 100, 'wang cheng qu', 'ux119 ux97 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux26395 ux22478 ux21306', 0, 0),
(1822, 1815, '430121', '长沙县', 3, '0731', '区', 100, 'chang sha xian', 'ux99 ux104 ux97 ux110 ux103 ux115 ux120 ux105 ux38271 ux27801 ux21439', 0, 0),
(1823, 1815, '430124', '宁乡县', 3, '0731', '区', 100, 'ning xiang xian', 'ux110 ux105 ux103 ux120 ux97 ux23425 ux20065 ux21439', 0, 0),
(1824, 1815, '430181', '浏阳市', 3, '0731', '区', 100, 'liu yang shi', 'ux108 ux105 ux117 ux121 ux97 ux110 ux103 ux115 ux104 ux27983 ux38451 ux24066', 0, 0),
(1825, 1814, '430200', '株洲市', 2, '0733', '市', 100, 'zhu zhou shi', 'ux122 ux104 ux117 ux111 ux115 ux105 ux26666 ux27954 ux24066', 0, 0),
(1826, 1825, '430202', '荷塘区', 3, '0733', '区', 100, 'he tang qu', 'ux104 ux101 ux116 ux97 ux110 ux103 ux113 ux117 ux33655 ux22616 ux21306', 0, 0),
(1827, 1825, '430203', '芦淞区', 3, '0733', '区', 100, 'lu song qu', 'ux108 ux117 ux115 ux111 ux110 ux103 ux113 ux33446 ux28126 ux21306', 0, 0),
(1828, 1825, '430204', '石峰区', 3, '0733', '区', 100, 'shi feng qu', 'ux115 ux104 ux105 ux102 ux101 ux110 ux103 ux113 ux117 ux30707 ux23792 ux21306', 0, 0),
(1829, 1825, '430211', '天元区', 3, '0733', '区', 100, 'tian yuan qu', 'ux116 ux105 ux97 ux110 ux121 ux117 ux113 ux22825 ux20803 ux21306', 0, 0),
(1830, 1825, '430221', '株洲县', 3, '0733', '区', 100, 'zhu zhou xian', 'ux122 ux104 ux117 ux111 ux120 ux105 ux97 ux110 ux26666 ux27954 ux21439', 0, 0),
(1831, 1825, '430223', '攸县', 3, '0733', '区', 100, 'you xian', 'ux121 ux111 ux117 ux120 ux105 ux97 ux110 ux25912 ux21439', 0, 0),
(1832, 1825, '430224', '茶陵县', 3, '0733', '区', 100, 'cha ling xian', 'ux99 ux104 ux97 ux108 ux105 ux110 ux103 ux120 ux33590 ux38517 ux21439', 0, 0),
(1833, 1825, '430225', '炎陵县', 3, '0733', '区', 100, 'yan ling xian', 'ux121 ux97 ux110 ux108 ux105 ux103 ux120 ux28814 ux38517 ux21439', 0, 0),
(1834, 1825, '430281', '醴陵市', 3, '0733', '区', 100, 'li ling shi', 'ux108 ux105 ux110 ux103 ux115 ux104 ux37300 ux38517 ux24066', 0, 0),
(1835, 1814, '430300', '湘潭市', 2, '0732', '市', 100, 'xiang tan shi', 'ux120 ux105 ux97 ux110 ux103 ux116 ux115 ux104 ux28248 ux28525 ux24066', 0, 0),
(1836, 1835, '430302', '雨湖区', 3, '0732', '区', 100, 'yu hu qu', 'ux121 ux117 ux104 ux113 ux38632 ux28246 ux21306', 0, 0),
(1837, 1835, '430304', '岳塘区', 3, '0732', '区', 100, 'yue tang qu', 'ux121 ux117 ux101 ux116 ux97 ux110 ux103 ux113 ux23731 ux22616 ux21306', 0, 0),
(1838, 1835, '430321', '湘潭县', 3, '0732', '区', 100, 'xiang tan xian', 'ux120 ux105 ux97 ux110 ux103 ux116 ux28248 ux28525 ux21439', 0, 0),
(1839, 1835, '430381', '湘乡市', 3, '0732', '区', 100, 'xiang xiang shi', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux28248 ux20065 ux24066', 0, 0),
(1840, 1835, '430382', '韶山市', 3, '0732', '区', 100, 'shao shan shi', 'ux115 ux104 ux97 ux111 ux110 ux105 ux38902 ux23665 ux24066', 0, 0),
(1841, 1814, '430400', '衡阳市', 2, '0734', '市', 100, 'heng yang shi', 'ux104 ux101 ux110 ux103 ux121 ux97 ux115 ux105 ux34913 ux38451 ux24066', 0, 0),
(1842, 1841, '430405', '珠晖区', 3, '0734', '区', 100, 'zhu hui qu', 'ux122 ux104 ux117 ux105 ux113 ux29664 ux26198 ux21306', 0, 0),
(1843, 1841, '430406', '雁峰区', 3, '0734', '区', 100, 'yan feng qu', 'ux121 ux97 ux110 ux102 ux101 ux103 ux113 ux117 ux38593 ux23792 ux21306', 0, 0),
(1844, 1841, '430407', '石鼓区', 3, '0734', '区', 100, 'shi gu qu', 'ux115 ux104 ux105 ux103 ux117 ux113 ux30707 ux40723 ux21306', 0, 0),
(1845, 1841, '430408', '蒸湘区', 3, '0734', '区', 100, 'zheng xiang qu', 'ux122 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux113 ux117 ux33976 ux28248 ux21306', 0, 0),
(1846, 1841, '430412', '南岳区', 3, '0734', '区', 100, 'nan yue qu', 'ux110 ux97 ux121 ux117 ux101 ux113 ux21335 ux23731 ux21306', 0, 0),
(1847, 1841, '430421', '衡阳县', 3, '0734', '区', 100, 'heng yang xian', 'ux104 ux101 ux110 ux103 ux121 ux97 ux120 ux105 ux34913 ux38451 ux21439', 0, 0),
(1848, 1841, '430422', '衡南县', 3, '0734', '区', 100, 'heng nan xian', 'ux104 ux101 ux110 ux103 ux97 ux120 ux105 ux34913 ux21335 ux21439', 0, 0),
(1849, 1841, '430423', '衡山县', 3, '0734', '区', 100, 'heng shan xian', 'ux104 ux101 ux110 ux103 ux115 ux97 ux120 ux105 ux34913 ux23665 ux21439', 0, 0),
(1850, 1841, '430424', '衡东县', 3, '0734', '区', 100, 'heng dong xian', 'ux104 ux101 ux110 ux103 ux100 ux111 ux120 ux105 ux97 ux34913 ux19996 ux21439', 0, 0),
(1851, 1841, '430426', '祁东县', 3, '0734', '区', 100, 'qi dong xian', 'ux113 ux105 ux100 ux111 ux110 ux103 ux120 ux97 ux31041 ux19996 ux21439', 0, 0),
(1852, 1841, '430481', '耒阳市', 3, '0734', '区', 100, 'lei yang shi', 'ux108 ux101 ux105 ux121 ux97 ux110 ux103 ux115 ux104 ux32786 ux38451 ux24066', 0, 0),
(1853, 1841, '430482', '常宁市', 3, '0734', '区', 100, 'chang ning shi', 'ux99 ux104 ux97 ux110 ux103 ux105 ux115 ux24120 ux23425 ux24066', 0, 0),
(1854, 1814, '430500', '邵阳市', 2, '0739', '市', 100, 'shao yang shi', 'ux115 ux104 ux97 ux111 ux121 ux110 ux103 ux105 ux37045 ux38451 ux24066', 0, 0),
(1855, 1854, '430502', '双清区', 3, '0739', '区', 100, 'shuang qing qu', 'ux115 ux104 ux117 ux97 ux110 ux103 ux113 ux105 ux21452 ux28165 ux21306', 0, 0),
(1856, 1854, '430503', '大祥区', 3, '0739', '区', 100, 'da xiang qu', 'ux100 ux97 ux120 ux105 ux110 ux103 ux113 ux117 ux22823 ux31077 ux21306', 0, 0),
(1857, 1854, '430511', '北塔区', 3, '0739', '区', 100, 'bei ta qu', 'ux98 ux101 ux105 ux116 ux97 ux113 ux117 ux21271 ux22612 ux21306', 0, 0),
(1858, 1854, '430521', '邵东县', 3, '0739', '区', 100, 'shao dong xian', 'ux115 ux104 ux97 ux111 ux100 ux110 ux103 ux120 ux105 ux37045 ux19996 ux21439', 0, 0),
(1859, 1854, '430522', '新邵县', 3, '0739', '区', 100, 'xin shao xian', 'ux120 ux105 ux110 ux115 ux104 ux97 ux111 ux26032 ux37045 ux21439', 0, 0),
(1860, 1854, '430523', '邵阳县', 3, '0739', '区', 100, 'shao yang xian', 'ux115 ux104 ux97 ux111 ux121 ux110 ux103 ux120 ux105 ux37045 ux38451 ux21439', 0, 0),
(1861, 1854, '430524', '隆回县', 3, '0739', '区', 100, 'long hui xian', 'ux108 ux111 ux110 ux103 ux104 ux117 ux105 ux120 ux97 ux38534 ux22238 ux21439', 0, 0),
(1862, 1854, '430525', '洞口县', 3, '0739', '区', 100, 'dong kou xian', 'ux100 ux111 ux110 ux103 ux107 ux117 ux120 ux105 ux97 ux27934 ux21475 ux21439', 0, 0),
(1863, 1854, '430527', '绥宁县', 3, '0739', '区', 100, 'sui ning xian', 'ux115 ux117 ux105 ux110 ux103 ux120 ux97 ux32485 ux23425 ux21439', 0, 0),
(1864, 1854, '430528', '新宁县', 3, '0739', '区', 100, 'xin ning xian', 'ux120 ux105 ux110 ux103 ux97 ux26032 ux23425 ux21439', 0, 0),
(1865, 1854, '430529', '城步苗族自治县', 3, '0739', '区', 100, 'cheng bu miao zu zi zhi xian', 'ux99 ux104 ux101 ux110 ux103 ux98 ux117 ux109 ux105 ux97 ux111 ux122 ux120 ux22478 ux27493 ux33495 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1866, 1854, '430581', '武冈市', 3, '0739', '区', 100, 'wu gang shi', 'ux119 ux117 ux103 ux97 ux110 ux115 ux104 ux105 ux27494 ux20872 ux24066', 0, 0),
(1867, 1814, '430600', '岳阳市', 2, '0730', '市', 100, 'yue yang shi', 'ux121 ux117 ux101 ux97 ux110 ux103 ux115 ux104 ux105 ux23731 ux38451 ux24066', 0, 0),
(1868, 1867, '430602', '岳阳楼区', 3, '0730', '区', 100, 'yue yang lou qu', 'ux121 ux117 ux101 ux97 ux110 ux103 ux108 ux111 ux113 ux23731 ux38451 ux27004 ux21306', 0, 0),
(1869, 1867, '430603', '云溪区', 3, '0730', '区', 100, 'yun xi qu', 'ux121 ux117 ux110 ux120 ux105 ux113 ux20113 ux28330 ux21306', 0, 0),
(1870, 1867, '430611', '君山区', 3, '0730', '区', 100, 'jun shan qu', 'ux106 ux117 ux110 ux115 ux104 ux97 ux113 ux21531 ux23665 ux21306', 0, 0),
(1871, 1867, '430621', '岳阳县', 3, '0730', '区', 100, 'yue yang xian', 'ux121 ux117 ux101 ux97 ux110 ux103 ux120 ux105 ux23731 ux38451 ux21439', 0, 0),
(1872, 1867, '430623', '华容县', 3, '0730', '区', 100, 'hua rong xian', 'ux104 ux117 ux97 ux114 ux111 ux110 ux103 ux120 ux105 ux21326 ux23481 ux21439', 0, 0),
(1873, 1867, '430624', '湘阴县', 3, '0730', '区', 100, 'xiang yin xian', 'ux120 ux105 ux97 ux110 ux103 ux121 ux28248 ux38452 ux21439', 0, 0),
(1874, 1867, '430626', '平江县', 3, '0730', '区', 100, 'ping jiang xian', 'ux112 ux105 ux110 ux103 ux106 ux97 ux120 ux24179 ux27743 ux21439', 0, 0),
(1875, 1867, '430681', '汨罗市', 3, '0730', '区', 100, 'mi luo shi', 'ux109 ux105 ux108 ux117 ux111 ux115 ux104 ux27752 ux32599 ux24066', 0, 0),
(1876, 1867, '430682', '临湘市', 3, '0730', '区', 100, 'lin xiang shi', 'ux108 ux105 ux110 ux120 ux97 ux103 ux115 ux104 ux20020 ux28248 ux24066', 0, 0),
(1877, 1814, '430700', '常德市', 2, '0736', '市', 100, 'chang de shi', 'ux99 ux104 ux97 ux110 ux103 ux100 ux101 ux115 ux105 ux24120 ux24503 ux24066', 0, 0),
(1878, 1877, '430702', '武陵区', 3, '0736', '区', 100, 'wu ling qu', 'ux119 ux117 ux108 ux105 ux110 ux103 ux113 ux27494 ux38517 ux21306', 0, 0),
(1879, 1877, '430703', '鼎城区', 3, '0736', '区', 100, 'ding cheng qu', 'ux100 ux105 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux40718 ux22478 ux21306', 0, 0),
(1880, 1877, '430721', '安乡县', 3, '0736', '区', 100, 'an xiang xian', 'ux97 ux110 ux120 ux105 ux103 ux23433 ux20065 ux21439', 0, 0),
(1881, 1877, '430722', '汉寿县', 3, '0736', '区', 100, 'han shou xian', 'ux104 ux97 ux110 ux115 ux111 ux117 ux120 ux105 ux27721 ux23551 ux21439', 0, 0),
(1882, 1877, '430723', '澧县', 3, '0736', '区', 100, 'li xian', 'ux108 ux105 ux120 ux97 ux110 ux28583 ux21439', 0, 0),
(1883, 1877, '430724', '临澧县', 3, '0736', '区', 100, 'lin li xian', 'ux108 ux105 ux110 ux120 ux97 ux20020 ux28583 ux21439', 0, 0),
(1884, 1877, '430725', '桃源县', 3, '0736', '区', 100, 'tao yuan xian', 'ux116 ux97 ux111 ux121 ux117 ux110 ux120 ux105 ux26691 ux28304 ux21439', 0, 0),
(1885, 1877, '430726', '石门县', 3, '0736', '区', 100, 'shi men xian', 'ux115 ux104 ux105 ux109 ux101 ux110 ux120 ux97 ux30707 ux38376 ux21439', 0, 0),
(1886, 1877, '430781', '津市市', 3, '0736', '区', 100, 'jin shi shi', 'ux106 ux105 ux110 ux115 ux104 ux27941 ux24066', 0, 0),
(1887, 1814, '430800', '张家界市', 2, '0744', '市', 100, 'zhang jia jie shi', 'ux122 ux104 ux97 ux110 ux103 ux106 ux105 ux101 ux115 ux24352 ux23478 ux30028 ux24066', 0, 0),
(1888, 1887, '430802', '永定区', 3, '0744', '区', 100, 'yong ding qu', 'ux121 ux111 ux110 ux103 ux100 ux105 ux113 ux117 ux27704 ux23450 ux21306', 0, 0),
(1889, 1887, '430811', '武陵源区', 3, '0744', '区', 100, 'wu ling yuan qu', 'ux119 ux117 ux108 ux105 ux110 ux103 ux121 ux97 ux113 ux27494 ux38517 ux28304 ux21306', 0, 0),
(1890, 1887, '430821', '慈利县', 3, '0744', '区', 100, 'ci li xian', 'ux99 ux105 ux108 ux120 ux97 ux110 ux24904 ux21033 ux21439', 0, 0),
(1891, 1887, '430822', '桑植县', 3, '0744', '区', 100, 'sang zhi xian', 'ux115 ux97 ux110 ux103 ux122 ux104 ux105 ux120 ux26705 ux26893 ux21439', 0, 0),
(1892, 1814, '430900', '益阳市', 2, '0737', '市', 100, 'yi yang shi', 'ux121 ux105 ux97 ux110 ux103 ux115 ux104 ux30410 ux38451 ux24066', 0, 0),
(1893, 1892, '430902', '资阳区', 3, '0737', '区', 100, 'zi yang qu', 'ux122 ux105 ux121 ux97 ux110 ux103 ux113 ux117 ux36164 ux38451 ux21306', 0, 0),
(1894, 1892, '430903', '赫山区', 3, '0737', '区', 100, 'he shan qu', 'ux104 ux101 ux115 ux97 ux110 ux113 ux117 ux36203 ux23665 ux21306', 0, 0),
(1895, 1892, '430921', '南县', 3, '0737', '区', 100, 'nan xian', 'ux110 ux97 ux120 ux105 ux21335 ux21439', 0, 0),
(1896, 1892, '430922', '桃江县', 3, '0737', '区', 100, 'tao jiang xian', 'ux116 ux97 ux111 ux106 ux105 ux110 ux103 ux120 ux26691 ux27743 ux21439', 0, 0),
(1897, 1892, '430923', '安化县', 3, '0737', '区', 100, 'an hua xian', 'ux97 ux110 ux104 ux117 ux120 ux105 ux23433 ux21270 ux21439', 0, 0),
(1898, 1892, '430981', '沅江市', 3, '0737', '区', 100, 'yuan jiang shi', 'ux121 ux117 ux97 ux110 ux106 ux105 ux103 ux115 ux104 ux27781 ux27743 ux24066', 0, 0),
(1899, 1814, '431000', '郴州市', 2, '0735', '市', 100, 'chen zhou shi', 'ux99 ux104 ux101 ux110 ux122 ux111 ux117 ux115 ux105 ux37108 ux24030 ux24066', 0, 0),
(1900, 1899, '431002', '北湖区', 3, '0735', '区', 100, 'bei hu qu', 'ux98 ux101 ux105 ux104 ux117 ux113 ux21271 ux28246 ux21306', 0, 0),
(1901, 1899, '431003', '苏仙区', 3, '0735', '区', 100, 'su xian qu', 'ux115 ux117 ux120 ux105 ux97 ux110 ux113 ux33487 ux20185 ux21306', 0, 0),
(1902, 1899, '431021', '桂阳县', 3, '0735', '区', 100, 'gui yang xian', 'ux103 ux117 ux105 ux121 ux97 ux110 ux120 ux26690 ux38451 ux21439', 0, 0),
(1903, 1899, '431022', '宜章县', 3, '0735', '区', 100, 'yi zhang xian', 'ux121 ux105 ux122 ux104 ux97 ux110 ux103 ux120 ux23452 ux31456 ux21439', 0, 0),
(1904, 1899, '431023', '永兴县', 3, '0735', '区', 100, 'yong xing xian', 'ux121 ux111 ux110 ux103 ux120 ux105 ux97 ux27704 ux20852 ux21439', 0, 0),
(1905, 1899, '431024', '嘉禾县', 3, '0735', '区', 100, 'jia he xian', 'ux106 ux105 ux97 ux104 ux101 ux120 ux110 ux22025 ux31166 ux21439', 0, 0),
(1906, 1899, '431025', '临武县', 3, '0735', '区', 100, 'lin wu xian', 'ux108 ux105 ux110 ux119 ux117 ux120 ux97 ux20020 ux27494 ux21439', 0, 0),
(1907, 1899, '431026', '汝城县', 3, '0735', '区', 100, 'ru cheng xian', 'ux114 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux27741 ux22478 ux21439', 0, 0),
(1908, 1899, '431027', '桂东县', 3, '0735', '区', 100, 'gui dong xian', 'ux103 ux117 ux105 ux100 ux111 ux110 ux120 ux97 ux26690 ux19996 ux21439', 0, 0),
(1909, 1899, '431028', '安仁县', 3, '0735', '区', 100, 'an ren xian', 'ux97 ux110 ux114 ux101 ux120 ux105 ux23433 ux20161 ux21439', 0, 0),
(1910, 1899, '431081', '资兴市', 3, '0735', '区', 100, 'zi xing shi', 'ux122 ux105 ux120 ux110 ux103 ux115 ux104 ux36164 ux20852 ux24066', 0, 0),
(1911, 1814, '431100', '永州市', 2, '0746', '市', 100, 'yong zhou shi', 'ux121 ux111 ux110 ux103 ux122 ux104 ux117 ux115 ux105 ux27704 ux24030 ux24066', 0, 0),
(1912, 1911, '431102', '零陵区', 3, '0746', '区', 100, 'ling ling qu', 'ux108 ux105 ux110 ux103 ux113 ux117 ux38646 ux38517 ux21306', 0, 0),
(1913, 1911, '431103', '冷水滩区', 3, '0746', '区', 100, 'leng shui tan qu', 'ux108 ux101 ux110 ux103 ux115 ux104 ux117 ux105 ux116 ux97 ux113 ux20919 ux27700 ux28393 ux21306', 0, 0),
(1914, 1911, '431121', '祁阳县', 3, '0746', '区', 100, 'qi yang xian', 'ux113 ux105 ux121 ux97 ux110 ux103 ux120 ux31041 ux38451 ux21439', 0, 0),
(1915, 1911, '431122', '东安县', 3, '0746', '区', 100, 'dong an xian', 'ux100 ux111 ux110 ux103 ux97 ux120 ux105 ux19996 ux23433 ux21439', 0, 0),
(1916, 1911, '431123', '双牌县', 3, '0746', '区', 100, 'shuang pai xian', 'ux115 ux104 ux117 ux97 ux110 ux103 ux112 ux105 ux120 ux21452 ux29260 ux21439', 0, 0),
(1917, 1911, '431124', '道县', 3, '0746', '区', 100, 'dao xian', 'ux100 ux97 ux111 ux120 ux105 ux110 ux36947 ux21439', 0, 0),
(1918, 1911, '431125', '江永县', 3, '0746', '区', 100, 'jiang yong xian', 'ux106 ux105 ux97 ux110 ux103 ux121 ux111 ux120 ux27743 ux27704 ux21439', 0, 0),
(1919, 1911, '431126', '宁远县', 3, '0746', '区', 100, 'ning yuan xian', 'ux110 ux105 ux103 ux121 ux117 ux97 ux120 ux23425 ux36828 ux21439', 0, 0),
(1920, 1911, '431127', '蓝山县', 3, '0746', '区', 100, 'lan shan xian', 'ux108 ux97 ux110 ux115 ux104 ux120 ux105 ux34013 ux23665 ux21439', 0, 0),
(1921, 1911, '431128', '新田县', 3, '0746', '区', 100, 'xin tian xian', 'ux120 ux105 ux110 ux116 ux97 ux26032 ux30000 ux21439', 0, 0),
(1922, 1911, '431129', '江华瑶族自治县', 3, '0746', '区', 100, 'jiang hua yao zu zi zhi xian', 'ux106 ux105 ux97 ux110 ux103 ux104 ux117 ux121 ux111 ux122 ux120 ux27743 ux21326 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1923, 1814, '431200', '怀化市', 2, '0745', '市', 100, 'huai hua shi', 'ux104 ux117 ux97 ux105 ux115 ux24576 ux21270 ux24066', 0, 0),
(1924, 1923, '431202', '鹤城区', 3, '0745', '区', 100, 'he cheng qu', 'ux104 ux101 ux99 ux110 ux103 ux113 ux117 ux40548 ux22478 ux21306', 0, 0),
(1925, 1923, '431221', '中方县', 3, '0745', '区', 100, 'zhong fang xian', 'ux122 ux104 ux111 ux110 ux103 ux102 ux97 ux120 ux105 ux20013 ux26041 ux21439', 0, 0),
(1926, 1923, '431222', '沅陵县', 3, '0745', '区', 100, 'yuan ling xian', 'ux121 ux117 ux97 ux110 ux108 ux105 ux103 ux120 ux27781 ux38517 ux21439', 0, 0),
(1927, 1923, '431223', '辰溪县', 3, '0745', '区', 100, 'chen xi xian', 'ux99 ux104 ux101 ux110 ux120 ux105 ux97 ux36784 ux28330 ux21439', 0, 0),
(1928, 1923, '431224', '溆浦县', 3, '0745', '区', 100, 'xu pu xian', 'ux120 ux117 ux112 ux105 ux97 ux110 ux28294 ux28006 ux21439', 0, 0),
(1929, 1923, '431225', '会同县', 3, '0745', '区', 100, 'hui tong xian', 'ux104 ux117 ux105 ux116 ux111 ux110 ux103 ux120 ux97 ux20250 ux21516 ux21439', 0, 0),
(1930, 1923, '431226', '麻阳苗族自治县', 3, '0745', '区', 100, 'ma yang miao zu zi zhi xian', 'ux109 ux97 ux121 ux110 ux103 ux105 ux111 ux122 ux117 ux104 ux120 ux40635 ux38451 ux33495 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1931, 1923, '431227', '新晃侗族自治县', 3, '0745', '区', 100, 'xin huang dong zu zi zhi xian', 'ux120 ux105 ux110 ux104 ux117 ux97 ux103 ux100 ux111 ux122 ux26032 ux26179 ux20375 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1932, 1923, '431228', '芷江侗族自治县', 3, '0745', '区', 100, 'zhi jiang dong zu zi zhi xian', 'ux122 ux104 ux105 ux106 ux97 ux110 ux103 ux100 ux111 ux117 ux120 ux33463 ux27743 ux20375 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1933, 1923, '431229', '靖州苗族侗族自治县', 3, '0745', '区', 100, 'jing zhou miao zu dong zu zi zhi xian', 'ux106 ux105 ux110 ux103 ux122 ux104 ux111 ux117 ux109 ux97 ux100 ux120 ux38742 ux24030 ux33495 ux26063 ux20375 ux33258 ux27835 ux21439', 0, 0),
(1934, 1923, '431230', '通道侗族自治县', 3, '0745', '区', 100, 'tong dao dong zu zi zhi xian', 'ux116 ux111 ux110 ux103 ux100 ux97 ux122 ux117 ux105 ux104 ux120 ux36890 ux36947 ux20375 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1935, 1923, '431281', '洪江市', 3, '0745', '区', 100, 'hong jiang shi', 'ux104 ux111 ux110 ux103 ux106 ux105 ux97 ux115 ux27946 ux27743 ux24066', 0, 0),
(1936, 1814, '431300', '娄底市', 2, '0738', '市', 100, 'lou di shi', 'ux108 ux111 ux117 ux100 ux105 ux115 ux104 ux23044 ux24213 ux24066', 0, 0),
(1937, 1936, '431302', '娄星区', 3, '0738', '区', 100, 'lou xing qu', 'ux108 ux111 ux117 ux120 ux105 ux110 ux103 ux113 ux23044 ux26143 ux21306', 0, 0),
(1938, 1936, '431321', '双峰县', 3, '0738', '区', 100, 'shuang feng xian', 'ux115 ux104 ux117 ux97 ux110 ux103 ux102 ux101 ux120 ux105 ux21452 ux23792 ux21439', 0, 0),
(1939, 1936, '431322', '新化县', 3, '0738', '区', 100, 'xin hua xian', 'ux120 ux105 ux110 ux104 ux117 ux97 ux26032 ux21270 ux21439', 0, 0),
(1940, 1936, '431381', '冷水江市', 3, '0738', '区', 100, 'leng shui jiang shi', 'ux108 ux101 ux110 ux103 ux115 ux104 ux117 ux105 ux106 ux97 ux20919 ux27700 ux27743 ux24066', 0, 0),
(1941, 1936, '431382', '涟源市', 3, '0738', '区', 100, 'lian yuan shi', 'ux108 ux105 ux97 ux110 ux121 ux117 ux115 ux104 ux28063 ux28304 ux24066', 0, 0),
(1942, 1814, '433100', '湘西土家族苗族自治州', 2, '0743', '市', 100, 'xiang xi tu jia zu miao zu zi zhi zhou', 'ux120 ux105 ux97 ux110 ux103 ux116 ux117 ux106 ux122 ux109 ux111 ux104 ux28248 ux35199 ux22303 ux23478 ux26063 ux33495 ux33258 ux27835 ux24030', 0, 0),
(1943, 1942, '433101', '吉首市', 3, '0743', '区', 100, 'ji shou shi', 'ux106 ux105 ux115 ux104 ux111 ux117 ux21513 ux39318 ux24066', 0, 0),
(1944, 1942, '433122', '泸溪县', 3, '0743', '区', 100, 'lu xi xian', 'ux108 ux117 ux120 ux105 ux97 ux110 ux27896 ux28330 ux21439', 0, 0),
(1945, 1942, '433123', '凤凰县', 3, '0743', '区', 100, 'feng huang xian', 'ux102 ux101 ux110 ux103 ux104 ux117 ux97 ux120 ux105 ux20964 ux20976 ux21439', 0, 0),
(1946, 1942, '433124', '花垣县', 3, '0743', '区', 100, 'hua yuan xian', 'ux104 ux117 ux97 ux121 ux110 ux120 ux105 ux33457 ux22435 ux21439', 0, 0),
(1947, 1942, '433125', '保靖县', 3, '0743', '区', 100, 'bao jing xian', 'ux98 ux97 ux111 ux106 ux105 ux110 ux103 ux120 ux20445 ux38742 ux21439', 0, 0),
(1948, 1942, '433126', '古丈县', 3, '0743', '区', 100, 'gu zhang xian', 'ux103 ux117 ux122 ux104 ux97 ux110 ux120 ux105 ux21476 ux19976 ux21439', 0, 0),
(1949, 1942, '433127', '永顺县', 3, '0743', '区', 100, 'yong shun xian', 'ux121 ux111 ux110 ux103 ux115 ux104 ux117 ux120 ux105 ux97 ux27704 ux39034 ux21439', 0, 0),
(1950, 1942, '433130', '龙山县', 3, '0743', '区', 100, 'long shan xian', 'ux108 ux111 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux40857 ux23665 ux21439', 0, 0),
(1951, 0, '440000', '广东省', 1, '', '省', 100, 'guang dong sheng', 'ux103 ux117 ux97 ux110 ux100 ux111 ux115 ux104 ux101 ux24191 ux19996 ux30465', 0, 0),
(1952, 1951, '440100', '广州市', 2, '020', '市', 100, 'guang zhou shi', 'ux103 ux117 ux97 ux110 ux122 ux104 ux111 ux115 ux105 ux24191 ux24030 ux24066', 0, 0),
(1953, 1952, '440103', '荔湾区', 3, '020', '区', 100, 'li wan qu', 'ux108 ux105 ux119 ux97 ux110 ux113 ux117 ux33620 ux28286 ux21306', 0, 0),
(1954, 1952, '440104', '越秀区', 3, '020', '区', 100, 'yue xiu qu', 'ux121 ux117 ux101 ux120 ux105 ux113 ux36234 ux31168 ux21306', 0, 0),
(1955, 1952, '440105', '海珠区', 3, '020', '区', 100, 'hai zhu qu', 'ux104 ux97 ux105 ux122 ux117 ux113 ux28023 ux29664 ux21306', 0, 0),
(1956, 1952, '440106', '天河区', 3, '020', '区', 100, 'tian he qu', 'ux116 ux105 ux97 ux110 ux104 ux101 ux113 ux117 ux22825 ux27827 ux21306', 0, 0),
(1957, 1952, '440111', '白云区', 3, '020', '区', 100, 'bai yun qu', 'ux98 ux97 ux105 ux121 ux117 ux110 ux113 ux30333 ux20113 ux21306', 0, 0),
(1958, 1952, '440112', '黄埔区', 3, '020', '区', 100, 'huang pu qu', 'ux104 ux117 ux97 ux110 ux103 ux112 ux113 ux40644 ux22484 ux21306', 0, 0),
(1959, 1952, '440113', '番禺区', 3, '020', '区', 100, 'fan yu qu', 'ux102 ux97 ux110 ux121 ux117 ux113 ux30058 ux31162 ux21306', 0, 0),
(1960, 1952, '440114', '花都区', 3, '020', '区', 100, 'hua du qu', 'ux104 ux117 ux97 ux100 ux113 ux33457 ux37117 ux21306', 0, 0),
(1961, 1952, '440115', '南沙区', 3, '020', '区', 100, 'nan sha qu', 'ux110 ux97 ux115 ux104 ux113 ux117 ux21335 ux27801 ux21306', 0, 0),
(1962, 1952, '440116', '萝岗区', 3, '020', '区', 100, 'luo gang qu', 'ux108 ux117 ux111 ux103 ux97 ux110 ux113 ux33821 ux23703 ux21306', 0, 0),
(1963, 1952, '440183', '增城市', 3, '020', '区', 100, 'zeng cheng shi', 'ux122 ux101 ux110 ux103 ux99 ux104 ux115 ux105 ux22686 ux22478 ux24066', 0, 0),
(1964, 1952, '440184', '从化市', 3, '020', '区', 100, 'cong hua shi', 'ux99 ux111 ux110 ux103 ux104 ux117 ux97 ux115 ux105 ux20174 ux21270 ux24066', 0, 0),
(1965, 1951, '440200', '韶关市', 2, '0751', '市', 100, 'shao guan shi', 'ux115 ux104 ux97 ux111 ux103 ux117 ux110 ux105 ux38902 ux20851 ux24066', 0, 0),
(1966, 1965, '440203', '武江区', 3, '0751', '区', 100, 'wu jiang qu', 'ux119 ux117 ux106 ux105 ux97 ux110 ux103 ux113 ux27494 ux27743 ux21306', 0, 0),
(1967, 1965, '440204', '浈江区', 3, '0751', '区', 100, 'zhen jiang qu', 'ux122 ux104 ux101 ux110 ux106 ux105 ux97 ux103 ux113 ux117 ux27976 ux27743 ux21306', 0, 0),
(1968, 1965, '440205', '曲江区', 3, '0751', '区', 100, 'qu jiang qu', 'ux113 ux117 ux106 ux105 ux97 ux110 ux103 ux26354 ux27743 ux21306', 0, 0),
(1969, 1965, '440222', '始兴县', 3, '0751', '区', 100, 'shi xing xian', 'ux115 ux104 ux105 ux120 ux110 ux103 ux97 ux22987 ux20852 ux21439', 0, 0),
(1970, 1965, '440224', '仁化县', 3, '0751', '区', 100, 'ren hua xian', 'ux114 ux101 ux110 ux104 ux117 ux97 ux120 ux105 ux20161 ux21270 ux21439', 0, 0),
(1971, 1965, '440229', '翁源县', 3, '0751', '区', 100, 'weng yuan xian', 'ux119 ux101 ux110 ux103 ux121 ux117 ux97 ux120 ux105 ux32705 ux28304 ux21439', 0, 0),
(1972, 1965, '440232', '乳源瑶族自治县', 3, '0751', '区', 100, 'ru yuan yao zu zi zhi xian', 'ux114 ux117 ux121 ux97 ux110 ux111 ux122 ux105 ux104 ux120 ux20083 ux28304 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(1973, 1965, '440233', '新丰县', 3, '0751', '区', 100, 'xin feng xian', 'ux120 ux105 ux110 ux102 ux101 ux103 ux97 ux26032 ux20016 ux21439', 0, 0),
(1974, 1965, '440281', '乐昌市', 3, '0751', '区', 100, 'le chang shi', 'ux108 ux101 ux99 ux104 ux97 ux110 ux103 ux115 ux105 ux20048 ux26124 ux24066', 0, 0),
(1975, 1965, '440282', '南雄市', 3, '0751', '区', 100, 'nan xiong shi', 'ux110 ux97 ux120 ux105 ux111 ux103 ux115 ux104 ux21335 ux38596 ux24066', 0, 0),
(1976, 1951, '440300', '深圳市', 2, '0755', '市', 100, 'shen zhen shi', 'ux115 ux104 ux101 ux110 ux122 ux105 ux28145 ux22323 ux24066', 0, 0),
(1977, 1976, '440303', '罗湖区', 3, '0755', '区', 100, 'luo hu qu', 'ux108 ux117 ux111 ux104 ux113 ux32599 ux28246 ux21306', 0, 0),
(1978, 1976, '440304', '福田区', 3, '0755', '区', 100, 'fu tian qu', 'ux102 ux117 ux116 ux105 ux97 ux110 ux113 ux31119 ux30000 ux21306', 0, 0),
(1979, 1976, '440305', '南山区', 3, '0755', '区', 100, 'nan shan qu', 'ux110 ux97 ux115 ux104 ux113 ux117 ux21335 ux23665 ux21306', 0, 0),
(1980, 1976, '440306', '宝安区', 3, '0755', '区', 100, 'bao an qu', 'ux98 ux97 ux111 ux110 ux113 ux117 ux23453 ux23433 ux21306', 0, 0),
(1981, 1976, '440307', '龙岗区', 3, '0755', '区', 100, 'long gang qu', 'ux108 ux111 ux110 ux103 ux97 ux113 ux117 ux40857 ux23703 ux21306', 0, 0),
(1982, 1976, '440308', '盐田区', 3, '0755', '区', 100, 'yan tian qu', 'ux121 ux97 ux110 ux116 ux105 ux113 ux117 ux30416 ux30000 ux21306', 0, 0),
(1983, 1951, '440400', '珠海市', 2, '0756', '市', 100, 'zhu hai shi', 'ux122 ux104 ux117 ux97 ux105 ux115 ux29664 ux28023 ux24066', 0, 0),
(1984, 1983, '440402', '香洲区', 3, '0756', '区', 100, 'xiang zhou qu', 'ux120 ux105 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux113 ux39321 ux27954 ux21306', 0, 0),
(1985, 1983, '440403', '斗门区', 3, '0756', '区', 100, 'dou men qu', 'ux100 ux111 ux117 ux109 ux101 ux110 ux113 ux26007 ux38376 ux21306', 0, 0),
(1986, 1983, '440404', '金湾区', 3, '0756', '区', 100, 'jin wan qu', 'ux106 ux105 ux110 ux119 ux97 ux113 ux117 ux37329 ux28286 ux21306', 0, 0),
(1987, 1951, '440500', '汕头市', 2, '0754', '市', 100, 'shan tou shi', 'ux115 ux104 ux97 ux110 ux116 ux111 ux117 ux105 ux27733 ux22836 ux24066', 0, 0),
(1988, 1987, '440507', '龙湖区', 3, '0754', '区', 100, 'long hu qu', 'ux108 ux111 ux110 ux103 ux104 ux117 ux113 ux40857 ux28246 ux21306', 0, 0),
(1989, 1987, '440511', '金平区', 3, '0754', '区', 100, 'jin ping qu', 'ux106 ux105 ux110 ux112 ux103 ux113 ux117 ux37329 ux24179 ux21306', 0, 0),
(1990, 1987, '440512', '濠江区', 3, '0754', '区', 100, 'hao jiang qu', 'ux104 ux97 ux111 ux106 ux105 ux110 ux103 ux113 ux117 ux28640 ux27743 ux21306', 0, 0),
(1991, 1987, '440513', '潮阳区', 3, '0661', '区', 100, 'chao yang qu', 'ux99 ux104 ux97 ux111 ux121 ux110 ux103 ux113 ux117 ux28526 ux38451 ux21306', 0, 0),
(1992, 1987, '440514', '潮南区', 3, '0754', '区', 100, 'chao nan qu', 'ux99 ux104 ux97 ux111 ux110 ux113 ux117 ux28526 ux21335 ux21306', 0, 0),
(1993, 1987, '440515', '澄海区', 3, '0754', '区', 100, 'cheng hai qu', 'ux99 ux104 ux101 ux110 ux103 ux97 ux105 ux113 ux117 ux28548 ux28023 ux21306', 0, 0),
(1994, 1987, '440523', '南澳县', 3, '0754', '区', 100, 'nan ao xian', 'ux110 ux97 ux111 ux120 ux105 ux21335 ux28595 ux21439', 0, 0),
(1995, 1951, '440600', '佛山市', 2, '0757', '市', 100, 'fo shan shi', 'ux102 ux111 ux115 ux104 ux97 ux110 ux105 ux20315 ux23665 ux24066', 0, 0),
(1996, 1995, '440604', '禅城区', 3, '0757', '区', 100, 'chan cheng qu', 'ux99 ux104 ux97 ux110 ux101 ux103 ux113 ux117 ux31109 ux22478 ux21306', 0, 0),
(1997, 1995, '440605', '南海区', 3, '0757', '区', 100, 'nan hai qu', 'ux110 ux97 ux104 ux105 ux113 ux117 ux21335 ux28023 ux21306', 0, 0),
(1998, 1995, '440606', '顺德区', 3, '0765', '区', 100, 'shun de qu', 'ux115 ux104 ux117 ux110 ux100 ux101 ux113 ux39034 ux24503 ux21306', 0, 0),
(1999, 1995, '440607', '三水区', 3, '0757', '区', 100, 'san shui qu', 'ux115 ux97 ux110 ux104 ux117 ux105 ux113 ux19977 ux27700 ux21306', 0, 0),
(2000, 1995, '440608', '高明区', 3, '0757', '区', 100, 'gao ming qu', 'ux103 ux97 ux111 ux109 ux105 ux110 ux113 ux117 ux39640 ux26126 ux21306', 0, 0),
(2001, 1951, '440700', '江门市', 2, '0750', '市', 100, 'jiang men shi', 'ux106 ux105 ux97 ux110 ux103 ux109 ux101 ux115 ux104 ux27743 ux38376 ux24066', 0, 0),
(2002, 2001, '440703', '蓬江区', 3, '0750', '区', 100, 'peng jiang qu', 'ux112 ux101 ux110 ux103 ux106 ux105 ux97 ux113 ux117 ux34028 ux27743 ux21306', 0, 0),
(2003, 2001, '440704', '江海区', 3, '0750', '区', 100, 'jiang hai qu', 'ux106 ux105 ux97 ux110 ux103 ux104 ux113 ux117 ux27743 ux28023 ux21306', 0, 0),
(2004, 2001, '440705', '新会区', 3, '0750', '区', 100, 'xin hui qu', 'ux120 ux105 ux110 ux104 ux117 ux113 ux26032 ux20250 ux21306', 0, 0),
(2005, 2001, '440781', '台山市', 3, '0750', '区', 100, 'tai shan shi', 'ux116 ux97 ux105 ux115 ux104 ux110 ux21488 ux23665 ux24066', 0, 0),
(2006, 2001, '440783', '开平市', 3, '0750', '区', 100, 'kai ping shi', 'ux107 ux97 ux105 ux112 ux110 ux103 ux115 ux104 ux24320 ux24179 ux24066', 0, 0),
(2007, 2001, '440784', '鹤山市', 3, '0750', '区', 100, 'he shan shi', 'ux104 ux101 ux115 ux97 ux110 ux105 ux40548 ux23665 ux24066', 0, 0),
(2008, 2001, '440785', '恩平市', 3, '0750', '区', 100, 'en ping shi', 'ux101 ux110 ux112 ux105 ux103 ux115 ux104 ux24681 ux24179 ux24066', 0, 0),
(2009, 1951, '440800', '湛江市', 2, '0759', '市', 100, 'zhan jiang shi', 'ux122 ux104 ux97 ux110 ux106 ux105 ux103 ux115 ux28251 ux27743 ux24066', 0, 0),
(2010, 2009, '440802', '赤坎区', 3, '0759', '区', 100, 'chi kan qu', 'ux99 ux104 ux105 ux107 ux97 ux110 ux113 ux117 ux36196 ux22350 ux21306', 0, 0),
(2011, 2009, '440803', '霞山区', 3, '0759', '区', 100, 'xia shan qu', 'ux120 ux105 ux97 ux115 ux104 ux110 ux113 ux117 ux38686 ux23665 ux21306', 0, 0),
(2012, 2009, '440804', '坡头区', 3, '0759', '区', 100, 'po tou qu', 'ux112 ux111 ux116 ux117 ux113 ux22369 ux22836 ux21306', 0, 0),
(2013, 2009, '440811', '麻章区', 3, '0759', '区', 100, 'ma zhang qu', 'ux109 ux97 ux122 ux104 ux110 ux103 ux113 ux117 ux40635 ux31456 ux21306', 0, 0),
(2014, 2009, '440823', '遂溪县', 3, '0759', '区', 100, 'sui xi xian', 'ux115 ux117 ux105 ux120 ux97 ux110 ux36930 ux28330 ux21439', 0, 0),
(2015, 2009, '440825', '徐闻县', 3, '0759', '区', 100, 'xu wen xian', 'ux120 ux117 ux119 ux101 ux110 ux105 ux97 ux24464 ux38395 ux21439', 0, 0),
(2016, 2009, '440881', '廉江市', 3, '0759', '区', 100, 'lian jiang shi', 'ux108 ux105 ux97 ux110 ux106 ux103 ux115 ux104 ux24265 ux27743 ux24066', 0, 0),
(2017, 2009, '440882', '雷州市', 3, '0759', '区', 100, 'lei zhou shi', 'ux108 ux101 ux105 ux122 ux104 ux111 ux117 ux115 ux38647 ux24030 ux24066', 0, 0),
(2018, 2009, '440883', '吴川市', 3, '0759', '区', 100, 'wu chuan shi', 'ux119 ux117 ux99 ux104 ux97 ux110 ux115 ux105 ux21556 ux24029 ux24066', 0, 0),
(2019, 1951, '440900', '茂名市', 2, '0668', '市', 100, 'mao ming shi', 'ux109 ux97 ux111 ux105 ux110 ux103 ux115 ux104 ux33538 ux21517 ux24066', 0, 0),
(2020, 2019, '440902', '茂南区', 3, '0668', '区', 100, 'mao nan qu', 'ux109 ux97 ux111 ux110 ux113 ux117 ux33538 ux21335 ux21306', 0, 0),
(2021, 2019, '440903', '茂港区', 3, '0668', '区', 100, 'mao gang qu', 'ux109 ux97 ux111 ux103 ux110 ux113 ux117 ux33538 ux28207 ux21306', 0, 0),
(2022, 2019, '440923', '电白县', 3, '0668', '区', 100, 'dian bai xian', 'ux100 ux105 ux97 ux110 ux98 ux120 ux30005 ux30333 ux21439', 0, 0),
(2023, 2019, '440981', '高州市', 3, '0668', '区', 100, 'gao zhou shi', 'ux103 ux97 ux111 ux122 ux104 ux117 ux115 ux105 ux39640 ux24030 ux24066', 0, 0),
(2024, 2019, '440982', '化州市', 3, '0668', '区', 100, 'hua zhou shi', 'ux104 ux117 ux97 ux122 ux111 ux115 ux105 ux21270 ux24030 ux24066', 0, 0),
(2025, 2019, '440983', '信宜市', 3, '0668', '区', 100, 'xin yi shi', 'ux120 ux105 ux110 ux121 ux115 ux104 ux20449 ux23452 ux24066', 0, 0),
(2026, 1951, '441200', '肇庆市', 2, '0758', '市', 100, 'zhao qing shi', 'ux122 ux104 ux97 ux111 ux113 ux105 ux110 ux103 ux115 ux32903 ux24198 ux24066', 0, 0),
(2027, 2026, '441202', '端州区', 3, '0758', '区', 100, 'duan zhou qu', 'ux100 ux117 ux97 ux110 ux122 ux104 ux111 ux113 ux31471 ux24030 ux21306', 0, 0),
(2028, 2026, '441203', '鼎湖区', 3, '0758', '区', 100, 'ding hu qu', 'ux100 ux105 ux110 ux103 ux104 ux117 ux113 ux40718 ux28246 ux21306', 0, 0),
(2029, 2026, '441223', '广宁县', 3, '0758', '区', 100, 'guang ning xian', 'ux103 ux117 ux97 ux110 ux105 ux120 ux24191 ux23425 ux21439', 0, 0),
(2030, 2026, '441224', '怀集县', 3, '0758', '区', 100, 'huai ji xian', 'ux104 ux117 ux97 ux105 ux106 ux120 ux110 ux24576 ux38598 ux21439', 0, 0),
(2031, 2026, '441225', '封开县', 3, '0758', '区', 100, 'feng kai xian', 'ux102 ux101 ux110 ux103 ux107 ux97 ux105 ux120 ux23553 ux24320 ux21439', 0, 0),
(2032, 2026, '441226', '德庆县', 3, '0758', '区', 100, 'de qing xian', 'ux100 ux101 ux113 ux105 ux110 ux103 ux120 ux97 ux24503 ux24198 ux21439', 0, 0),
(2033, 2026, '441283', '高要市', 3, '0758', '区', 100, 'gao yao shi', 'ux103 ux97 ux111 ux121 ux115 ux104 ux105 ux39640 ux35201 ux24066', 0, 0),
(2034, 2026, '441284', '四会市', 3, '0758', '区', 100, 'si hui shi', 'ux115 ux105 ux104 ux117 ux22235 ux20250 ux24066', 0, 0),
(2035, 1951, '441300', '惠州市', 2, '0752', '市', 100, 'hui zhou shi', 'ux104 ux117 ux105 ux122 ux111 ux115 ux24800 ux24030 ux24066', 0, 0),
(2036, 2035, '441302', '惠城区', 3, '0752', '区', 100, 'hui cheng qu', 'ux104 ux117 ux105 ux99 ux101 ux110 ux103 ux113 ux24800 ux22478 ux21306', 0, 0),
(2037, 2035, '441303', '惠阳区', 3, '0752', '区', 100, 'hui yang qu', 'ux104 ux117 ux105 ux121 ux97 ux110 ux103 ux113 ux24800 ux38451 ux21306', 0, 0),
(2038, 2035, '441322', '博罗县', 3, '0752', '区', 100, 'bo luo xian', 'ux98 ux111 ux108 ux117 ux120 ux105 ux97 ux110 ux21338 ux32599 ux21439', 0, 0),
(2039, 2035, '441323', '惠东县', 3, '0752', '区', 100, 'hui dong xian', 'ux104 ux117 ux105 ux100 ux111 ux110 ux103 ux120 ux97 ux24800 ux19996 ux21439', 0, 0),
(2040, 2035, '441324', '龙门县', 3, '0752', '区', 100, 'long men xian', 'ux108 ux111 ux110 ux103 ux109 ux101 ux120 ux105 ux97 ux40857 ux38376 ux21439', 0, 0),
(2041, 1951, '441400', '梅州市', 2, '0753', '市', 100, 'mei zhou shi', 'ux109 ux101 ux105 ux122 ux104 ux111 ux117 ux115 ux26757 ux24030 ux24066', 0, 0),
(2042, 2041, '441402', '梅江区', 3, '0753', '区', 100, 'mei jiang qu', 'ux109 ux101 ux105 ux106 ux97 ux110 ux103 ux113 ux117 ux26757 ux27743 ux21306', 0, 0),
(2043, 2041, '441421', '梅县', 3, '0753', '区', 100, 'mei xian', 'ux109 ux101 ux105 ux120 ux97 ux110 ux26757 ux21439', 0, 0),
(2044, 2041, '441422', '大埔县', 3, '0753', '区', 100, 'da pu xian', 'ux100 ux97 ux112 ux117 ux120 ux105 ux110 ux22823 ux22484 ux21439', 0, 0),
(2045, 2041, '441423', '丰顺县', 3, '0753', '区', 100, 'feng shun xian', 'ux102 ux101 ux110 ux103 ux115 ux104 ux117 ux120 ux105 ux97 ux20016 ux39034 ux21439', 0, 0),
(2046, 2041, '441424', '五华县', 3, '0753', '区', 100, 'wu hua xian', 'ux119 ux117 ux104 ux97 ux120 ux105 ux110 ux20116 ux21326 ux21439', 0, 0),
(2047, 2041, '441426', '平远县', 3, '0753', '区', 100, 'ping yuan xian', 'ux112 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux24179 ux36828 ux21439', 0, 0),
(2048, 2041, '441427', '蕉岭县', 3, '0753', '区', 100, 'jiao ling xian', 'ux106 ux105 ux97 ux111 ux108 ux110 ux103 ux120 ux34121 ux23725 ux21439', 0, 0),
(2049, 2041, '441481', '兴宁市', 3, '0753', '区', 100, 'xing ning shi', 'ux120 ux105 ux110 ux103 ux115 ux104 ux20852 ux23425 ux24066', 0, 0),
(2050, 1951, '441500', '汕尾市', 2, '0660', '市', 100, 'shan wei shi', 'ux115 ux104 ux97 ux110 ux119 ux101 ux105 ux27733 ux23614 ux24066', 0, 0),
(2051, 2050, '441502', '城区', 3, '0660', '区', 100, 'cheng qu', 'ux99 ux104 ux101 ux110 ux103 ux113 ux117 ux22478 ux21306', 0, 0),
(2052, 2050, '441521', '海丰县', 3, '0660', '区', 100, 'hai feng xian', 'ux104 ux97 ux105 ux102 ux101 ux110 ux103 ux120 ux28023 ux20016 ux21439', 0, 0),
(2053, 2050, '441523', '陆河县', 3, '0660', '区', 100, 'lu he xian', 'ux108 ux117 ux104 ux101 ux120 ux105 ux97 ux110 ux38470 ux27827 ux21439', 0, 0),
(2054, 2050, '441581', '陆丰市', 3, '0660', '区', 100, 'lu feng shi', 'ux108 ux117 ux102 ux101 ux110 ux103 ux115 ux104 ux105 ux38470 ux20016 ux24066', 0, 0),
(2055, 1951, '441600', '河源市', 2, '0762', '市', 100, 'he yuan shi', 'ux104 ux101 ux121 ux117 ux97 ux110 ux115 ux105 ux27827 ux28304 ux24066', 0, 0),
(2056, 2055, '441602', '源城区', 3, '0762', '区', 100, 'yuan cheng qu', 'ux121 ux117 ux97 ux110 ux99 ux104 ux101 ux103 ux113 ux28304 ux22478 ux21306', 0, 0),
(2057, 2055, '441621', '紫金县', 3, '0762', '区', 100, 'zi jin xian', 'ux122 ux105 ux106 ux110 ux120 ux97 ux32043 ux37329 ux21439', 0, 0),
(2058, 2055, '441622', '龙川县', 3, '0762', '区', 100, 'long chuan xian', 'ux108 ux111 ux110 ux103 ux99 ux104 ux117 ux97 ux120 ux105 ux40857 ux24029 ux21439', 0, 0),
(2059, 2055, '441623', '连平县', 3, '0762', '区', 100, 'lian ping xian', 'ux108 ux105 ux97 ux110 ux112 ux103 ux120 ux36830 ux24179 ux21439', 0, 0),
(2060, 2055, '441624', '和平县', 3, '0762', '区', 100, 'he ping xian', 'ux104 ux101 ux112 ux105 ux110 ux103 ux120 ux97 ux21644 ux24179 ux21439', 0, 0),
(2061, 2055, '441625', '东源县', 3, '0762', '区', 100, 'dong yuan xian', 'ux100 ux111 ux110 ux103 ux121 ux117 ux97 ux120 ux105 ux19996 ux28304 ux21439', 0, 0),
(2062, 1951, '441700', '阳江市', 2, '0662', '市', 100, 'yang jiang shi', 'ux121 ux97 ux110 ux103 ux106 ux105 ux115 ux104 ux38451 ux27743 ux24066', 0, 0),
(2063, 2062, '441702', '江城区', 3, '0662', '区', 100, 'jiang cheng qu', 'ux106 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux27743 ux22478 ux21306', 0, 0),
(2064, 2062, '441721', '阳西县', 3, '0662', '区', 100, 'yang xi xian', 'ux121 ux97 ux110 ux103 ux120 ux105 ux38451 ux35199 ux21439', 0, 0),
(2065, 2062, '441723', '阳东县', 3, '0662', '区', 100, 'yang dong xian', 'ux121 ux97 ux110 ux103 ux100 ux111 ux120 ux105 ux38451 ux19996 ux21439', 0, 0),
(2066, 2062, '441781', '阳春市', 3, '0662', '区', 100, 'yang chun shi', 'ux121 ux97 ux110 ux103 ux99 ux104 ux117 ux115 ux105 ux38451 ux26149 ux24066', 0, 0),
(2067, 1951, '441800', '清远市', 2, '0763', '市', 100, 'qing yuan shi', 'ux113 ux105 ux110 ux103 ux121 ux117 ux97 ux115 ux104 ux28165 ux36828 ux24066', 0, 0),
(2068, 2067, '441802', '清城区', 3, '0763', '区', 100, 'qing cheng qu', 'ux113 ux105 ux110 ux103 ux99 ux104 ux101 ux117 ux28165 ux22478 ux21306', 0, 0),
(2069, 2067, '441821', '佛冈县', 3, '0763', '区', 100, 'fo gang xian', 'ux102 ux111 ux103 ux97 ux110 ux120 ux105 ux20315 ux20872 ux21439', 0, 0),
(2070, 2067, '441823', '阳山县', 3, '0763', '区', 100, 'yang shan xian', 'ux121 ux97 ux110 ux103 ux115 ux104 ux120 ux105 ux38451 ux23665 ux21439', 0, 0),
(2071, 2067, '441825', '连山壮族瑶族自治县', 3, '0763', '区', 100, 'lian shan zhuang zu yao zu zi zhi xian', 'ux108 ux105 ux97 ux110 ux115 ux104 ux122 ux117 ux103 ux121 ux111 ux120 ux36830 ux23665 ux22766 ux26063 ux29814 ux33258 ux27835 ux21439', 0, 0),
(2072, 2067, '441826', '连南瑶族自治县', 3, '0763', '区', 100, 'lian nan yao zu zi zhi xian', 'ux108 ux105 ux97 ux110 ux121 ux111 ux122 ux117 ux104 ux120 ux36830 ux21335 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2073, 2067, '441827', '清新县', 3, '0763', '区', 100, 'qing xin xian', 'ux113 ux105 ux110 ux103 ux120 ux97 ux28165 ux26032 ux21439', 0, 0),
(2074, 2067, '441881', '英德市', 3, '0763', '区', 100, 'ying de shi', 'ux121 ux105 ux110 ux103 ux100 ux101 ux115 ux104 ux33521 ux24503 ux24066', 0, 0),
(2075, 2067, '441882', '连州市', 3, '0763', '区', 100, 'lian zhou shi', 'ux108 ux105 ux97 ux110 ux122 ux104 ux111 ux117 ux115 ux36830 ux24030 ux24066', 0, 0),
(2076, 1951, '441900', '东莞市', 2, '0769', '市', 100, 'dong guan shi', 'ux100 ux111 ux110 ux103 ux117 ux97 ux115 ux104 ux105 ux19996 ux33694 ux24066', 0, 0),
(2077, 2076, '441901', '东莞市', 3, '0769', '区', 100, 'dong guan shi', 'ux100 ux111 ux110 ux103 ux117 ux97 ux115 ux104 ux105 ux19996 ux33694 ux24066', 0, 0),
(2078, 1951, '442000', '中山市', 2, '0760', '市', 100, 'zhong shan shi', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux105 ux20013 ux23665 ux24066', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(2079, 2078, '442001', '中山市', 3, '0760', '区', 100, 'zhong shan shi', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux105 ux20013 ux23665 ux24066', 0, 0),
(2080, 1951, '445100', '潮州市', 2, '0768', '市', 100, 'chao zhou shi', 'ux99 ux104 ux97 ux111 ux122 ux117 ux115 ux105 ux28526 ux24030 ux24066', 0, 0),
(2081, 2080, '445102', '湘桥区', 3, '0768', '区', 100, 'xiang qiao qu', 'ux120 ux105 ux97 ux110 ux103 ux113 ux111 ux117 ux28248 ux26725 ux21306', 0, 0),
(2082, 2080, '445121', '潮安县', 3, '0768', '区', 100, 'chao an xian', 'ux99 ux104 ux97 ux111 ux110 ux120 ux105 ux28526 ux23433 ux21439', 0, 0),
(2083, 2080, '445122', '饶平县', 3, '0768', '区', 100, 'rao ping xian', 'ux114 ux97 ux111 ux112 ux105 ux110 ux103 ux120 ux39286 ux24179 ux21439', 0, 0),
(2084, 1951, '445200', '揭阳市', 2, '0663', '市', 100, 'jie yang shi', 'ux106 ux105 ux101 ux121 ux97 ux110 ux103 ux115 ux104 ux25581 ux38451 ux24066', 0, 0),
(2085, 2084, '445202', '榕城区', 3, '0663', '区', 100, 'rong cheng qu', 'ux114 ux111 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux27029 ux22478 ux21306', 0, 0),
(2086, 2084, '445221', '揭东县', 3, '0663', '区', 100, 'jie dong xian', 'ux106 ux105 ux101 ux100 ux111 ux110 ux103 ux120 ux97 ux25581 ux19996 ux21439', 0, 0),
(2087, 2084, '445222', '揭西县', 3, '0663', '区', 100, 'jie xi xian', 'ux106 ux105 ux101 ux120 ux97 ux110 ux25581 ux35199 ux21439', 0, 0),
(2088, 2084, '445224', '惠来县', 3, '0663', '区', 100, 'hui lai xian', 'ux104 ux117 ux105 ux108 ux97 ux120 ux110 ux24800 ux26469 ux21439', 0, 0),
(2089, 2084, '445281', '普宁市', 3, '0663', '区', 100, 'pu ning shi', 'ux112 ux117 ux110 ux105 ux103 ux115 ux104 ux26222 ux23425 ux24066', 0, 0),
(2090, 1951, '445300', '云浮市', 2, '0766', '市', 100, 'yun fu shi', 'ux121 ux117 ux110 ux102 ux115 ux104 ux105 ux20113 ux28014 ux24066', 0, 0),
(2091, 2090, '445302', '云城区', 3, '0766', '区', 100, 'yun cheng qu', 'ux121 ux117 ux110 ux99 ux104 ux101 ux103 ux113 ux20113 ux22478 ux21306', 0, 0),
(2092, 2090, '445321', '新兴县', 3, '0766', '区', 100, 'xin xing xian', 'ux120 ux105 ux110 ux103 ux97 ux26032 ux20852 ux21439', 0, 0),
(2093, 2090, '445322', '郁南县', 3, '0766', '区', 100, 'yu nan xian', 'ux121 ux117 ux110 ux97 ux120 ux105 ux37057 ux21335 ux21439', 0, 0),
(2094, 2090, '445323', '云安县', 3, '0766', '区', 100, 'yun an xian', 'ux121 ux117 ux110 ux97 ux120 ux105 ux20113 ux23433 ux21439', 0, 0),
(2095, 2090, '445381', '罗定市', 3, '0766', '区', 100, 'luo ding shi', 'ux108 ux117 ux111 ux100 ux105 ux110 ux103 ux115 ux104 ux32599 ux23450 ux24066', 0, 0),
(2096, 0, '450000', '广西壮族自治区', 1, '', '省', 100, 'guang xi zhuang zu zi zhi qu', 'ux103 ux117 ux97 ux110 ux120 ux105 ux122 ux104 ux113 ux24191 ux35199 ux22766 ux26063 ux33258 ux27835 ux21306', 0, 0),
(2097, 2096, '450100', '南宁市', 2, '0771', '市', 100, 'nan ning shi', 'ux110 ux97 ux105 ux103 ux115 ux104 ux21335 ux23425 ux24066', 0, 0),
(2098, 2097, '450102', '兴宁区', 3, '0771', '区', 100, 'xing ning qu', 'ux120 ux105 ux110 ux103 ux113 ux117 ux20852 ux23425 ux21306', 0, 0),
(2099, 2097, '450103', '青秀区', 3, '0771', '区', 100, 'qing xiu qu', 'ux113 ux105 ux110 ux103 ux120 ux117 ux38738 ux31168 ux21306', 0, 0),
(2100, 2097, '450105', '江南区', 3, '0771', '区', 100, 'jiang nan qu', 'ux106 ux105 ux97 ux110 ux103 ux113 ux117 ux27743 ux21335 ux21306', 0, 0),
(2101, 2097, '450107', '西乡塘区', 3, '0771', '区', 100, 'xi xiang tang qu', 'ux120 ux105 ux97 ux110 ux103 ux116 ux113 ux117 ux35199 ux20065 ux22616 ux21306', 0, 0),
(2102, 2097, '450108', '良庆区', 3, '0771', '区', 100, 'liang qing qu', 'ux108 ux105 ux97 ux110 ux103 ux113 ux117 ux33391 ux24198 ux21306', 0, 0),
(2103, 2097, '450109', '邕宁区', 3, '0771', '区', 100, 'yong ning qu', 'ux121 ux111 ux110 ux103 ux105 ux113 ux117 ux37013 ux23425 ux21306', 0, 0),
(2104, 2097, '450122', '武鸣县', 3, '0771', '区', 100, 'wu ming xian', 'ux119 ux117 ux109 ux105 ux110 ux103 ux120 ux97 ux27494 ux40483 ux21439', 0, 0),
(2105, 2097, '450123', '隆安县', 3, '0771', '区', 100, 'long an xian', 'ux108 ux111 ux110 ux103 ux97 ux120 ux105 ux38534 ux23433 ux21439', 0, 0),
(2106, 2097, '450124', '马山县', 3, '0771', '区', 100, 'ma shan xian', 'ux109 ux97 ux115 ux104 ux110 ux120 ux105 ux39532 ux23665 ux21439', 0, 0),
(2107, 2097, '450125', '上林县', 3, '0771', '区', 100, 'shang lin xian', 'ux115 ux104 ux97 ux110 ux103 ux108 ux105 ux120 ux19978 ux26519 ux21439', 0, 0),
(2108, 2097, '450126', '宾阳县', 3, '0771', '区', 100, 'bin yang xian', 'ux98 ux105 ux110 ux121 ux97 ux103 ux120 ux23486 ux38451 ux21439', 0, 0),
(2109, 2097, '450127', '横县', 3, '0771', '区', 100, 'heng xian', 'ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux27178 ux21439', 0, 0),
(2110, 2096, '450200', '柳州市', 2, '0772', '市', 100, 'liu zhou shi', 'ux108 ux105 ux117 ux122 ux104 ux111 ux115 ux26611 ux24030 ux24066', 0, 0),
(2111, 2110, '450202', '城中区', 3, '0772', '区', 100, 'cheng zhong qu', 'ux99 ux104 ux101 ux110 ux103 ux122 ux111 ux113 ux117 ux22478 ux20013 ux21306', 0, 0),
(2112, 2110, '450203', '鱼峰区', 3, '0772', '区', 100, 'yu feng qu', 'ux121 ux117 ux102 ux101 ux110 ux103 ux113 ux40060 ux23792 ux21306', 0, 0),
(2113, 2110, '450204', '柳南区', 3, '0772', '区', 100, 'liu nan qu', 'ux108 ux105 ux117 ux110 ux97 ux113 ux26611 ux21335 ux21306', 0, 0),
(2114, 2110, '450205', '柳北区', 3, '0772', '区', 100, 'liu bei qu', 'ux108 ux105 ux117 ux98 ux101 ux113 ux26611 ux21271 ux21306', 0, 0),
(2115, 2110, '450221', '柳江县', 3, '0772', '区', 100, 'liu jiang xian', 'ux108 ux105 ux117 ux106 ux97 ux110 ux103 ux120 ux26611 ux27743 ux21439', 0, 0),
(2116, 2110, '450222', '柳城县', 3, '0772', '区', 100, 'liu cheng xian', 'ux108 ux105 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux97 ux26611 ux22478 ux21439', 0, 0),
(2117, 2110, '450223', '鹿寨县', 3, '0772', '区', 100, 'lu zhai xian', 'ux108 ux117 ux122 ux104 ux97 ux105 ux120 ux110 ux40575 ux23528 ux21439', 0, 0),
(2118, 2110, '450224', '融安县', 3, '0772', '区', 100, 'rong an xian', 'ux114 ux111 ux110 ux103 ux97 ux120 ux105 ux34701 ux23433 ux21439', 0, 0),
(2119, 2110, '450225', '融水苗族自治县', 3, '0772', '区', 100, 'rong shui miao zu zi zhi xian', 'ux114 ux111 ux110 ux103 ux115 ux104 ux117 ux105 ux109 ux97 ux122 ux120 ux34701 ux27700 ux33495 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2120, 2110, '450226', '三江侗族自治县', 3, '0772', '区', 100, 'san jiang dong zu zi zhi xian', 'ux115 ux97 ux110 ux106 ux105 ux103 ux100 ux111 ux122 ux117 ux104 ux120 ux19977 ux27743 ux20375 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2121, 2096, '450300', '桂林市', 2, '0773', '市', 100, 'gui lin shi', 'ux103 ux117 ux105 ux108 ux110 ux115 ux104 ux26690 ux26519 ux24066', 0, 0),
(2122, 2121, '450302', '秀峰区', 3, '0773', '区', 100, 'xiu feng qu', 'ux120 ux105 ux117 ux102 ux101 ux110 ux103 ux113 ux31168 ux23792 ux21306', 0, 0),
(2123, 2121, '450303', '叠彩区', 3, '0773', '区', 100, 'die cai qu', 'ux100 ux105 ux101 ux99 ux97 ux113 ux117 ux21472 ux24425 ux21306', 0, 0),
(2124, 2121, '450304', '象山区', 3, '0773', '区', 100, 'xiang shan qu', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux113 ux117 ux35937 ux23665 ux21306', 0, 0),
(2125, 2121, '450305', '七星区', 3, '0773', '区', 100, 'qi xing qu', 'ux113 ux105 ux120 ux110 ux103 ux117 ux19971 ux26143 ux21306', 0, 0),
(2126, 2121, '450311', '雁山区', 3, '0773', '区', 100, 'yan shan qu', 'ux121 ux97 ux110 ux115 ux104 ux113 ux117 ux38593 ux23665 ux21306', 0, 0),
(2127, 2121, '450321', '阳朔县', 3, '0773', '区', 100, 'yang shuo xian', 'ux121 ux97 ux110 ux103 ux115 ux104 ux117 ux111 ux120 ux105 ux38451 ux26388 ux21439', 0, 0),
(2128, 2121, '450322', '临桂县', 3, '0773', '区', 100, 'lin gui xian', 'ux108 ux105 ux110 ux103 ux117 ux120 ux97 ux20020 ux26690 ux21439', 0, 0),
(2129, 2121, '450323', '灵川县', 3, '0773', '区', 100, 'ling chuan xian', 'ux108 ux105 ux110 ux103 ux99 ux104 ux117 ux97 ux120 ux28789 ux24029 ux21439', 0, 0),
(2130, 2121, '450324', '全州县', 3, '0773', '区', 100, 'quan zhou xian', 'ux113 ux117 ux97 ux110 ux122 ux104 ux111 ux120 ux105 ux20840 ux24030 ux21439', 0, 0),
(2131, 2121, '450325', '兴安县', 3, '0773', '区', 100, 'xing an xian', 'ux120 ux105 ux110 ux103 ux97 ux20852 ux23433 ux21439', 0, 0),
(2132, 2121, '450326', '永福县', 3, '0773', '区', 100, 'yong fu xian', 'ux121 ux111 ux110 ux103 ux102 ux117 ux120 ux105 ux97 ux27704 ux31119 ux21439', 0, 0),
(2133, 2121, '450327', '灌阳县', 3, '0773', '区', 100, 'guan yang xian', 'ux103 ux117 ux97 ux110 ux121 ux120 ux105 ux28748 ux38451 ux21439', 0, 0),
(2134, 2121, '450328', '龙胜各族自治县', 3, '0773', '区', 100, 'long sheng ge zu zi zhi xian', 'ux108 ux111 ux110 ux103 ux115 ux104 ux101 ux122 ux117 ux105 ux120 ux97 ux40857 ux32988 ux21508 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2135, 2121, '450329', '资源县', 3, '0773', '区', 100, 'zi yuan xian', 'ux122 ux105 ux121 ux117 ux97 ux110 ux120 ux36164 ux28304 ux21439', 0, 0),
(2136, 2121, '450330', '平乐县', 3, '0773', '区', 100, 'ping le xian', 'ux112 ux105 ux110 ux103 ux108 ux101 ux120 ux97 ux24179 ux20048 ux21439', 0, 0),
(2137, 2121, '450331', '荔蒲县', 3, '0773', '区', 100, 'li pu xian', 'ux108 ux105 ux112 ux117 ux120 ux97 ux110 ux33620 ux33970 ux21439', 0, 0),
(2138, 2121, '450332', '恭城瑶族自治县', 3, '0773', '区', 100, 'gong cheng yao zu zi zhi xian', 'ux103 ux111 ux110 ux99 ux104 ux101 ux121 ux97 ux122 ux117 ux105 ux120 ux24685 ux22478 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2139, 2096, '450400', '梧州市', 2, '0774', '市', 100, 'wu zhou shi', 'ux119 ux117 ux122 ux104 ux111 ux115 ux105 ux26791 ux24030 ux24066', 0, 0),
(2140, 2139, '450403', '万秀区', 3, '0774', '区', 100, 'wan xiu qu', 'ux119 ux97 ux110 ux120 ux105 ux117 ux113 ux19975 ux31168 ux21306', 0, 0),
(2141, 2139, '450404', '蝶山区', 3, '0774', '区', 100, 'die shan qu', 'ux100 ux105 ux101 ux115 ux104 ux97 ux110 ux113 ux117 ux34678 ux23665 ux21306', 0, 0),
(2142, 2139, '450405', '长洲区', 3, '0774', '区', 100, 'chang zhou qu', 'ux99 ux104 ux97 ux110 ux103 ux122 ux111 ux117 ux113 ux38271 ux27954 ux21306', 0, 0),
(2143, 2139, '450421', '苍梧县', 3, '0774', '区', 100, 'cang wu xian', 'ux99 ux97 ux110 ux103 ux119 ux117 ux120 ux105 ux33485 ux26791 ux21439', 0, 0),
(2144, 2139, '450422', '藤县', 3, '0774', '区', 100, 'teng xian', 'ux116 ux101 ux110 ux103 ux120 ux105 ux97 ux34276 ux21439', 0, 0),
(2145, 2139, '450423', '蒙山县', 3, '0774', '区', 100, 'meng shan xian', 'ux109 ux101 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux33945 ux23665 ux21439', 0, 0),
(2146, 2139, '450481', '岑溪市', 3, '0774', '区', 100, 'cen xi shi', 'ux99 ux101 ux110 ux120 ux105 ux115 ux104 ux23697 ux28330 ux24066', 0, 0),
(2147, 2096, '450500', '北海市', 2, '0779', '市', 100, 'bei hai shi', 'ux98 ux101 ux105 ux104 ux97 ux115 ux21271 ux28023 ux24066', 0, 0),
(2148, 2147, '450502', '海城区', 3, '0779', '区', 100, 'hai cheng qu', 'ux104 ux97 ux105 ux99 ux101 ux110 ux103 ux113 ux117 ux28023 ux22478 ux21306', 0, 0),
(2149, 2147, '450503', '银海区', 3, '0779', '区', 100, 'yin hai qu', 'ux121 ux105 ux110 ux104 ux97 ux113 ux117 ux38134 ux28023 ux21306', 0, 0),
(2150, 2147, '450512', '铁山港区', 3, '0779', '区', 100, 'tie shan gang qu', 'ux116 ux105 ux101 ux115 ux104 ux97 ux110 ux103 ux113 ux117 ux38081 ux23665 ux28207 ux21306', 0, 0),
(2151, 2147, '450521', '合浦县', 3, '0779', '区', 100, 'he pu xian', 'ux104 ux101 ux112 ux117 ux120 ux105 ux97 ux110 ux21512 ux28006 ux21439', 0, 0),
(2152, 2096, '450600', '防城港市', 2, '0770', '市', 100, 'fang cheng gang shi', 'ux102 ux97 ux110 ux103 ux99 ux104 ux101 ux115 ux105 ux38450 ux22478 ux28207 ux24066', 0, 0),
(2153, 2152, '450602', '港口区', 3, '0770', '区', 100, 'gang kou qu', 'ux103 ux97 ux110 ux107 ux111 ux117 ux113 ux28207 ux21475 ux21306', 0, 0),
(2154, 2152, '450603', '防城区', 3, '0770', '区', 100, 'fang cheng qu', 'ux102 ux97 ux110 ux103 ux99 ux104 ux101 ux113 ux117 ux38450 ux22478 ux21306', 0, 0),
(2155, 2152, '450621', '上思县', 3, '0770', '区', 100, 'shang si xian', 'ux115 ux104 ux97 ux110 ux103 ux105 ux120 ux19978 ux24605 ux21439', 0, 0),
(2156, 2152, '450681', '东兴市', 3, '0770', '区', 100, 'dong xing shi', 'ux100 ux111 ux110 ux103 ux120 ux105 ux115 ux104 ux19996 ux20852 ux24066', 0, 0),
(2157, 2096, '450700', '钦州市', 2, '0777', '市', 100, 'qin zhou shi', 'ux113 ux105 ux110 ux122 ux104 ux111 ux117 ux115 ux38054 ux24030 ux24066', 0, 0),
(2158, 2157, '450702', '钦南区', 3, '0777', '区', 100, 'qin nan qu', 'ux113 ux105 ux110 ux97 ux117 ux38054 ux21335 ux21306', 0, 0),
(2159, 2157, '450703', '钦北区', 3, '0777', '区', 100, 'qin bei qu', 'ux113 ux105 ux110 ux98 ux101 ux117 ux38054 ux21271 ux21306', 0, 0),
(2160, 2157, '450721', '灵山县', 3, '0777', '区', 100, 'ling shan xian', 'ux108 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux28789 ux23665 ux21439', 0, 0),
(2161, 2157, '450722', '浦北县', 3, '0777', '区', 100, 'pu bei xian', 'ux112 ux117 ux98 ux101 ux105 ux120 ux97 ux110 ux28006 ux21271 ux21439', 0, 0),
(2162, 2096, '450800', '贵港市', 2, '0775', '市', 100, 'gui gang shi', 'ux103 ux117 ux105 ux97 ux110 ux115 ux104 ux36149 ux28207 ux24066', 0, 0),
(2163, 2162, '450802', '港北区', 3, '0775', '区', 100, 'gang bei qu', 'ux103 ux97 ux110 ux98 ux101 ux105 ux113 ux117 ux28207 ux21271 ux21306', 0, 0),
(2164, 2162, '450803', '港南区', 3, '0775', '区', 100, 'gang nan qu', 'ux103 ux97 ux110 ux113 ux117 ux28207 ux21335 ux21306', 0, 0),
(2165, 2162, '450804', '覃塘区', 3, '0775', '区', 100, 'tan tang qu', 'ux116 ux97 ux110 ux103 ux113 ux117 ux35203 ux22616 ux21306', 0, 0),
(2166, 2162, '450821', '平南县', 3, '0775', '区', 100, 'ping nan xian', 'ux112 ux105 ux110 ux103 ux97 ux120 ux24179 ux21335 ux21439', 0, 0),
(2167, 2162, '450881', '桂平市', 3, '0775', '区', 100, 'gui ping shi', 'ux103 ux117 ux105 ux112 ux110 ux115 ux104 ux26690 ux24179 ux24066', 0, 0),
(2168, 2096, '450900', '玉林市', 2, '0775', '市', 100, 'yu lin shi', 'ux121 ux117 ux108 ux105 ux110 ux115 ux104 ux29577 ux26519 ux24066', 0, 0),
(2169, 2168, '450902', '玉州区', 3, '0775', '区', 100, 'yu zhou qu', 'ux121 ux117 ux122 ux104 ux111 ux113 ux29577 ux24030 ux21306', 0, 0),
(2170, 2168, '450921', '容县', 3, '0775', '区', 100, 'rong xian', 'ux114 ux111 ux110 ux103 ux120 ux105 ux97 ux23481 ux21439', 0, 0),
(2171, 2168, '450922', '陆川县', 3, '0775', '区', 100, 'lu chuan xian', 'ux108 ux117 ux99 ux104 ux97 ux110 ux120 ux105 ux38470 ux24029 ux21439', 0, 0),
(2172, 2168, '450923', '博白县', 3, '0775', '区', 100, 'bo bai xian', 'ux98 ux111 ux97 ux105 ux120 ux110 ux21338 ux30333 ux21439', 0, 0),
(2173, 2168, '450924', '兴业县', 3, '0775', '区', 100, 'xing ye xian', 'ux120 ux105 ux110 ux103 ux121 ux101 ux97 ux20852 ux19994 ux21439', 0, 0),
(2174, 2168, '450981', '北流市', 3, '0775', '区', 100, 'bei liu shi', 'ux98 ux101 ux105 ux108 ux117 ux115 ux104 ux21271 ux27969 ux24066', 0, 0),
(2175, 2096, '451000', '百色市', 2, '0776', '市', 100, 'bai se shi', 'ux98 ux97 ux105 ux115 ux101 ux104 ux30334 ux33394 ux24066', 0, 0),
(2176, 2175, '451002', '右江区', 3, '0776', '区', 100, 'you jiang qu', 'ux121 ux111 ux117 ux106 ux105 ux97 ux110 ux103 ux113 ux21491 ux27743 ux21306', 0, 0),
(2177, 2175, '451021', '田阳县', 3, '0776', '区', 100, 'tian yang xian', 'ux116 ux105 ux97 ux110 ux121 ux103 ux120 ux30000 ux38451 ux21439', 0, 0),
(2178, 2175, '451022', '田东县', 3, '0776', '区', 100, 'tian dong xian', 'ux116 ux105 ux97 ux110 ux100 ux111 ux103 ux120 ux30000 ux19996 ux21439', 0, 0),
(2179, 2175, '451023', '平果县', 3, '0776', '区', 100, 'ping guo xian', 'ux112 ux105 ux110 ux103 ux117 ux111 ux120 ux97 ux24179 ux26524 ux21439', 0, 0),
(2180, 2175, '451024', '德保县', 3, '0776', '区', 100, 'de bao xian', 'ux100 ux101 ux98 ux97 ux111 ux120 ux105 ux110 ux24503 ux20445 ux21439', 0, 0),
(2181, 2175, '451025', '靖西县', 3, '0776', '区', 100, 'jing xi xian', 'ux106 ux105 ux110 ux103 ux120 ux97 ux38742 ux35199 ux21439', 0, 0),
(2182, 2175, '451026', '那坡县', 3, '0776', '区', 100, 'na po xian', 'ux110 ux97 ux112 ux111 ux120 ux105 ux37027 ux22369 ux21439', 0, 0),
(2183, 2175, '451027', '凌云县', 3, '0776', '区', 100, 'ling yun xian', 'ux108 ux105 ux110 ux103 ux121 ux117 ux120 ux97 ux20940 ux20113 ux21439', 0, 0),
(2184, 2175, '451028', '乐业县', 3, '0776', '区', 100, 'le ye xian', 'ux108 ux101 ux121 ux120 ux105 ux97 ux110 ux20048 ux19994 ux21439', 0, 0),
(2185, 2175, '451029', '田林县', 3, '0776', '区', 100, 'tian lin xian', 'ux116 ux105 ux97 ux110 ux108 ux120 ux30000 ux26519 ux21439', 0, 0),
(2186, 2175, '451030', '西林县', 3, '0776', '区', 100, 'xi lin xian', 'ux120 ux105 ux108 ux110 ux97 ux35199 ux26519 ux21439', 0, 0),
(2187, 2175, '451031', '隆林各族自治县', 3, '0776', '区', 100, 'long lin ge zu zi zhi xian', 'ux108 ux111 ux110 ux103 ux105 ux101 ux122 ux117 ux104 ux120 ux97 ux38534 ux26519 ux21508 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2188, 2096, '451100', '贺州市', 2, '0774', '市', 100, 'he zhou shi', 'ux104 ux101 ux122 ux111 ux117 ux115 ux105 ux36154 ux24030 ux24066', 0, 0),
(2189, 2188, '451102', '八步区', 3, '0774', '区', 100, 'ba bu qu', 'ux98 ux97 ux117 ux113 ux20843 ux27493 ux21306', 0, 0),
(2190, 2188, '451119', '平桂管理区', 3, '0774', '区', 100, 'ping gui guan li qu', 'ux112 ux105 ux110 ux103 ux117 ux97 ux108 ux113 ux24179 ux26690 ux31649 ux29702 ux21306', 0, 0),
(2191, 2188, '451121', '昭平县', 3, '0774', '区', 100, 'zhao ping xian', 'ux122 ux104 ux97 ux111 ux112 ux105 ux110 ux103 ux120 ux26157 ux24179 ux21439', 0, 0),
(2192, 2188, '451122', '钟山县', 3, '0774', '区', 100, 'zhong shan xian', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux120 ux105 ux38047 ux23665 ux21439', 0, 0),
(2193, 2188, '451123', '富川瑶族自治县', 3, '0774', '区', 100, 'fu chuan yao zu zi zhi xian', 'ux102 ux117 ux99 ux104 ux97 ux110 ux121 ux111 ux122 ux105 ux120 ux23500 ux24029 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2194, 2096, '451200', '河池市', 2, '0778', '市', 100, 'he chi shi', 'ux104 ux101 ux99 ux105 ux115 ux27827 ux27744 ux24066', 0, 0),
(2195, 2194, '451202', '金城江区', 3, '0778', '区', 100, 'jin cheng jiang qu', 'ux106 ux105 ux110 ux99 ux104 ux101 ux103 ux97 ux113 ux117 ux37329 ux22478 ux27743 ux21306', 0, 0),
(2196, 2194, '451221', '南丹县', 3, '0778', '区', 100, 'nan dan xian', 'ux110 ux97 ux100 ux120 ux105 ux21335 ux20025 ux21439', 0, 0),
(2197, 2194, '451222', '天峨县', 3, '0778', '区', 100, 'tian e xian', 'ux116 ux105 ux97 ux110 ux101 ux120 ux22825 ux23784 ux21439', 0, 0),
(2198, 2194, '451223', '凤山县', 3, '0778', '区', 100, 'feng shan xian', 'ux102 ux101 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux20964 ux23665 ux21439', 0, 0),
(2199, 2194, '451224', '东兰县', 3, '0778', '区', 100, 'dong lan xian', 'ux100 ux111 ux110 ux103 ux108 ux97 ux120 ux105 ux19996 ux20848 ux21439', 0, 0),
(2200, 2194, '451225', '罗城仫佬族自治县', 3, '0778', '区', 100, 'luo cheng mu lao zu zi zhi xian', 'ux108 ux117 ux111 ux99 ux104 ux101 ux110 ux103 ux109 ux97 ux122 ux105 ux120 ux32599 ux22478 ux20203 ux20332 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2201, 2194, '451226', '环江毛南族自治县', 3, '0778', '区', 100, 'huan jiang mao nan zu zi zhi xian', 'ux104 ux117 ux97 ux110 ux106 ux105 ux103 ux109 ux111 ux122 ux120 ux29615 ux27743 ux27611 ux21335 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2202, 2194, '451227', '巴马瑶族自治县', 3, '0778', '区', 100, 'ba ma yao zu zi zhi xian', 'ux98 ux97 ux109 ux121 ux111 ux122 ux117 ux105 ux104 ux120 ux110 ux24052 ux39532 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2203, 2194, '451228', '都安瑶族自治县', 3, '0778', '区', 100, 'du an yao zu zi zhi xian', 'ux100 ux117 ux97 ux110 ux121 ux111 ux122 ux105 ux104 ux120 ux37117 ux23433 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2204, 2194, '451229', '大化瑶族自治县', 3, '0778', '区', 100, 'da hua yao zu zi zhi xian', 'ux100 ux97 ux104 ux117 ux121 ux111 ux122 ux105 ux120 ux110 ux22823 ux21270 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2205, 2194, '451281', '宜州市', 3, '0778', '区', 100, 'yi zhou shi', 'ux121 ux105 ux122 ux104 ux111 ux117 ux115 ux23452 ux24030 ux24066', 0, 0),
(2206, 2096, '451300', '来宾市', 2, '0772', '市', 100, 'lai bin shi', 'ux108 ux97 ux105 ux98 ux110 ux115 ux104 ux26469 ux23486 ux24066', 0, 0),
(2207, 2206, '451302', '兴宾区', 3, '0772', '区', 100, 'xing bin qu', 'ux120 ux105 ux110 ux103 ux98 ux113 ux117 ux20852 ux23486 ux21306', 0, 0),
(2208, 2206, '451321', '忻城县', 3, '0772', '区', 100, 'xin cheng xian', 'ux120 ux105 ux110 ux99 ux104 ux101 ux103 ux97 ux24571 ux22478 ux21439', 0, 0),
(2209, 2206, '451322', '象州县', 3, '0772', '区', 100, 'xiang zhou xian', 'ux120 ux105 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux35937 ux24030 ux21439', 0, 0),
(2210, 2206, '451323', '武宣县', 3, '0772', '区', 100, 'wu xuan xian', 'ux119 ux117 ux120 ux97 ux110 ux105 ux27494 ux23459 ux21439', 0, 0),
(2211, 2206, '451324', '金秀瑶族自治县', 3, '0772', '区', 100, 'jin xiu yao zu zi zhi xian', 'ux106 ux105 ux110 ux120 ux117 ux121 ux97 ux111 ux122 ux104 ux37329 ux31168 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2212, 2206, '451381', '合山市', 3, '0772', '区', 100, 'he shan shi', 'ux104 ux101 ux115 ux97 ux110 ux105 ux21512 ux23665 ux24066', 0, 0),
(2213, 2096, '451400', '崇左市', 2, '0771', '市', 100, 'chong zuo shi', 'ux99 ux104 ux111 ux110 ux103 ux122 ux117 ux115 ux105 ux23815 ux24038 ux24066', 0, 0),
(2214, 2213, '451402', '江洲区', 3, '0771', '区', 100, 'jiang zhou qu', 'ux106 ux105 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux113 ux27743 ux27954 ux21306', 0, 0),
(2215, 2213, '451421', '扶绥县', 3, '0771', '区', 100, 'fu sui xian', 'ux102 ux117 ux115 ux105 ux120 ux97 ux110 ux25206 ux32485 ux21439', 0, 0),
(2216, 2213, '451422', '宁明县', 3, '0771', '区', 100, 'ning ming xian', 'ux110 ux105 ux103 ux109 ux120 ux97 ux23425 ux26126 ux21439', 0, 0),
(2217, 2213, '451423', '龙州县', 3, '0771', '区', 100, 'long zhou xian', 'ux108 ux111 ux110 ux103 ux122 ux104 ux117 ux120 ux105 ux97 ux40857 ux24030 ux21439', 0, 0),
(2218, 2213, '451424', '大新县', 3, '0771', '区', 100, 'da xin xian', 'ux100 ux97 ux120 ux105 ux110 ux22823 ux26032 ux21439', 0, 0),
(2219, 2213, '451425', '天等县', 3, '0771', '区', 100, 'tian deng xian', 'ux116 ux105 ux97 ux110 ux100 ux101 ux103 ux120 ux22825 ux31561 ux21439', 0, 0),
(2220, 2213, '451481', '凭祥市', 3, '0771', '区', 100, 'ping xiang shi', 'ux112 ux105 ux110 ux103 ux120 ux97 ux115 ux104 ux20973 ux31077 ux24066', 0, 0),
(2221, 0, '460000', '海南省', 1, '', '省', 100, 'hai nan sheng', 'ux104 ux97 ux105 ux110 ux115 ux101 ux103 ux28023 ux21335 ux30465', 0, 0),
(2222, 2221, '460100', '海口市', 2, '0898', '市', 100, 'hai kou shi', 'ux104 ux97 ux105 ux107 ux111 ux117 ux115 ux28023 ux21475 ux24066', 0, 0),
(2223, 2222, '460105', '秀英区', 3, '0898', '区', 100, 'xiu ying qu', 'ux120 ux105 ux117 ux121 ux110 ux103 ux113 ux31168 ux33521 ux21306', 0, 0),
(2224, 2222, '460106', '龙华区', 3, '0898', '区', 100, 'long hua qu', 'ux108 ux111 ux110 ux103 ux104 ux117 ux97 ux113 ux40857 ux21326 ux21306', 0, 0),
(2225, 2222, '460107', '琼山区', 3, '0898', '区', 100, 'qiong shan qu', 'ux113 ux105 ux111 ux110 ux103 ux115 ux104 ux97 ux117 ux29756 ux23665 ux21306', 0, 0),
(2226, 2222, '460108', '美兰区', 3, '0898', '区', 100, 'mei lan qu', 'ux109 ux101 ux105 ux108 ux97 ux110 ux113 ux117 ux32654 ux20848 ux21306', 0, 0),
(2227, 2221, '460200', '三亚市', 2, '0899', '市', 100, 'san ya shi', 'ux115 ux97 ux110 ux121 ux104 ux105 ux19977 ux20122 ux24066', 0, 0),
(2228, 2227, '460201', '三亚市', 3, '0899', '区', 100, 'san ya shi', 'ux115 ux97 ux110 ux121 ux104 ux105 ux19977 ux20122 ux24066', 0, 0),
(2229, 2221, '460300', '三沙市', 2, '0898', '市', 100, 'san sha shi', 'ux115 ux97 ux110 ux104 ux105 ux19977 ux27801 ux24066', 0, 0),
(2230, 2229, '460321', '西沙群岛', 3, '0898', '区', 100, 'xi sha qun dao', 'ux120 ux105 ux115 ux104 ux97 ux113 ux117 ux110 ux100 ux111 ux35199 ux27801 ux32676 ux23707', 0, 0),
(2231, 2229, '460322', '南沙群岛', 3, '0898', '区', 100, 'nan sha qun dao', 'ux110 ux97 ux115 ux104 ux113 ux117 ux100 ux111 ux21335 ux27801 ux32676 ux23707', 0, 0),
(2232, 2229, '460323', '中沙群岛', 3, '0898', '区', 100, 'zhong sha qun dao', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux100 ux20013 ux27801 ux32676 ux23707', 0, 0),
(2233, 2221, '469000', '省直辖', 2, '', '市', 100, 'sheng zhi xia', 'ux115 ux104 ux101 ux110 ux103 ux122 ux105 ux120 ux97 ux30465 ux30452 ux36758', 0, 0),
(2234, 2233, '469001', '五指山市', 3, '0898', '区', 100, 'wu zhi shan shi', 'ux119 ux117 ux122 ux104 ux105 ux115 ux97 ux110 ux20116 ux25351 ux23665 ux24066', 0, 0),
(2235, 2233, '469002', '琼海市', 3, '0898', '区', 100, 'qiong hai shi', 'ux113 ux105 ux111 ux110 ux103 ux104 ux97 ux115 ux29756 ux28023 ux24066', 0, 0),
(2236, 2233, '469003', '儋州市', 3, '0890', '区', 100, 'dan zhou shi', 'ux100 ux97 ux110 ux122 ux104 ux111 ux117 ux115 ux105 ux20747 ux24030 ux24066', 0, 0),
(2237, 2233, '469005', '文昌市', 3, '0898', '区', 100, 'wen chang shi', 'ux119 ux101 ux110 ux99 ux104 ux97 ux103 ux115 ux105 ux25991 ux26124 ux24066', 0, 0),
(2238, 2233, '469006', '万宁市', 3, '0898', '区', 100, 'wan ning shi', 'ux119 ux97 ux110 ux105 ux103 ux115 ux104 ux19975 ux23425 ux24066', 0, 0),
(2239, 2233, '469007', '东方市', 3, '0898', '区', 100, 'dong fang shi', 'ux100 ux111 ux110 ux103 ux102 ux97 ux115 ux104 ux105 ux19996 ux26041 ux24066', 0, 0),
(2240, 2233, '469021', '定安县', 3, '0898', '区', 100, 'ding an xian', 'ux100 ux105 ux110 ux103 ux97 ux120 ux23450 ux23433 ux21439', 0, 0),
(2241, 2233, '469022', '屯昌县', 3, '0898', '区', 100, 'tun chang xian', 'ux116 ux117 ux110 ux99 ux104 ux97 ux103 ux120 ux105 ux23663 ux26124 ux21439', 0, 0),
(2242, 2233, '469023', '澄迈县', 3, '0898', '区', 100, 'cheng mai xian', 'ux99 ux104 ux101 ux110 ux103 ux109 ux97 ux105 ux120 ux28548 ux36808 ux21439', 0, 0),
(2243, 2233, '469024', '临高县', 3, '0898', '区', 100, 'lin gao xian', 'ux108 ux105 ux110 ux103 ux97 ux111 ux120 ux20020 ux39640 ux21439', 0, 0),
(2244, 2233, '469025', '白沙黎族自治县', 3, '0898', '区', 100, 'bai sha li zu zi zhi xian', 'ux98 ux97 ux105 ux115 ux104 ux108 ux122 ux117 ux120 ux110 ux30333 ux27801 ux40654 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2245, 2233, '469026', '昌江黎族自治县', 3, '0898', '区', 100, 'chang jiang li zu zi zhi xian', 'ux99 ux104 ux97 ux110 ux103 ux106 ux105 ux108 ux122 ux117 ux120 ux26124 ux27743 ux40654 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2246, 2233, '469027', '乐东黎族自治县', 3, '0898', '区', 100, 'le dong li zu zi zhi xian', 'ux108 ux101 ux100 ux111 ux110 ux103 ux105 ux122 ux117 ux104 ux120 ux97 ux20048 ux19996 ux40654 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2247, 2233, '469028', '陵水黎族自治县', 3, '0898', '区', 100, 'ling shui li zu zi zhi xian', 'ux108 ux105 ux110 ux103 ux115 ux104 ux117 ux122 ux120 ux97 ux38517 ux27700 ux40654 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2248, 2233, '469029', '保亭黎族苗族自治县', 3, '0898', '区', 100, 'bao ting li zu miao zu zi zhi xian', 'ux98 ux97 ux111 ux116 ux105 ux110 ux103 ux108 ux122 ux117 ux109 ux104 ux120 ux20445 ux20141 ux40654 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2249, 2233, '469030', '琼中黎族苗族自治县', 3, '0898', '区', 100, 'qiong zhong li zu miao zu zi zhi xian', 'ux113 ux105 ux111 ux110 ux103 ux122 ux104 ux108 ux117 ux109 ux97 ux120 ux29756 ux20013 ux40654 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2250, 0, '500000', '重庆市', 1, '0811', '市', 100, 'chong qing shi', 'ux122 ux104 ux111 ux110 ux103 ux113 ux105 ux115 ux37325 ux24198 ux24066', 0, 0),
(2251, 2250, '500101', '万州区', 2, '0811', '区', 100, 'wan zhou qu', 'ux119 ux97 ux110 ux122 ux104 ux111 ux117 ux113 ux19975 ux24030 ux21306', 0, 0),
(2252, 2250, '500102', '涪陵区', 2, '0811', '区', 100, 'fu ling qu', 'ux102 ux117 ux108 ux105 ux110 ux103 ux113 ux28074 ux38517 ux21306', 0, 0),
(2253, 2250, '500103', '渝中区', 2, '0811', '区', 100, 'yu zhong qu', 'ux121 ux117 ux122 ux104 ux111 ux110 ux103 ux113 ux28189 ux20013 ux21306', 0, 0),
(2254, 2250, '500104', '大渡口区', 2, '0811', '区', 100, 'da du kou qu', 'ux100 ux97 ux117 ux107 ux111 ux113 ux22823 ux28193 ux21475 ux21306', 0, 0),
(2255, 2250, '500105', '江北区', 2, '0811', '区', 100, 'jiang bei qu', 'ux106 ux105 ux97 ux110 ux103 ux98 ux101 ux113 ux117 ux27743 ux21271 ux21306', 0, 0),
(2256, 2250, '500106', '沙坪坝区', 2, '0811', '区', 100, 'sha ping ba qu', 'ux115 ux104 ux97 ux112 ux105 ux110 ux103 ux98 ux113 ux117 ux27801 ux22378 ux22365 ux21306', 0, 0),
(2257, 2250, '500107', '九龙坡区', 2, '0811', '区', 100, 'jiu long po qu', 'ux106 ux105 ux117 ux108 ux111 ux110 ux103 ux112 ux113 ux20061 ux40857 ux22369 ux21306', 0, 0),
(2258, 2250, '500108', '南岸区', 2, '0811', '区', 100, 'nan an qu', 'ux110 ux97 ux113 ux117 ux21335 ux23736 ux21306', 0, 0),
(2259, 2250, '500109', '北碚区', 2, '0811', '区', 100, 'bei bei qu', 'ux98 ux101 ux105 ux113 ux117 ux21271 ux30874 ux21306', 0, 0),
(2260, 2250, '500110', '綦江区', 2, '0811', '区', 100, 'qi jiang qu', 'ux113 ux105 ux106 ux97 ux110 ux103 ux117 ux32166 ux27743 ux21306', 0, 0),
(2261, 2250, '500111', '大足区', 2, '0811', '区', 100, 'da zu qu', 'ux100 ux97 ux122 ux117 ux113 ux22823 ux36275 ux21306', 0, 0),
(2262, 2250, '500112', '渝北区', 2, '0811', '区', 100, 'yu bei qu', 'ux121 ux117 ux98 ux101 ux105 ux113 ux28189 ux21271 ux21306', 0, 0),
(2263, 2250, '500113', '巴南区', 2, '0811', '区', 100, 'ba nan qu', 'ux98 ux97 ux110 ux113 ux117 ux24052 ux21335 ux21306', 0, 0),
(2264, 2250, '500114', '黔江区', 2, '0811', '区', 100, 'qian jiang qu', 'ux113 ux105 ux97 ux110 ux106 ux103 ux117 ux40660 ux27743 ux21306', 0, 0),
(2265, 2250, '500115', '长寿区', 2, '0811', '区', 100, 'chang shou qu', 'ux99 ux104 ux97 ux110 ux103 ux115 ux111 ux117 ux113 ux38271 ux23551 ux21306', 0, 0),
(2266, 2250, '500116', '江津区', 2, '0811', '区', 100, 'jiang jin qu', 'ux106 ux105 ux97 ux110 ux103 ux113 ux117 ux27743 ux27941 ux21306', 0, 0),
(2267, 2250, '500117', '合川区', 2, '0811', '区', 100, 'he chuan qu', 'ux104 ux101 ux99 ux117 ux97 ux110 ux113 ux21512 ux24029 ux21306', 0, 0),
(2268, 2250, '500118', '永川区', 2, '0814', '区', 100, 'yong chuan qu', 'ux121 ux111 ux110 ux103 ux99 ux104 ux117 ux97 ux113 ux27704 ux24029 ux21306', 0, 0),
(2269, 2250, '500119', '南川区', 2, '0811', '区', 100, 'nan chuan qu', 'ux110 ux97 ux99 ux104 ux117 ux113 ux21335 ux24029 ux21306', 0, 0),
(2270, 2250, '500223', '潼南县', 2, '0811', '区', 100, 'tong nan xian', 'ux116 ux111 ux110 ux103 ux97 ux120 ux105 ux28540 ux21335 ux21439', 0, 0),
(2271, 2250, '500224', '铜梁县', 2, '0811', '区', 100, 'tong liang xian', 'ux116 ux111 ux110 ux103 ux108 ux105 ux97 ux120 ux38108 ux26753 ux21439', 0, 0),
(2272, 2250, '500226', '荣昌县', 2, '0811', '区', 100, 'rong chang xian', 'ux114 ux111 ux110 ux103 ux99 ux104 ux97 ux120 ux105 ux33635 ux26124 ux21439', 0, 0),
(2273, 2250, '500227', '璧山县', 2, '0811', '区', 100, 'bi shan xian', 'ux98 ux105 ux115 ux104 ux97 ux110 ux120 ux29863 ux23665 ux21439', 0, 0),
(2274, 2250, '500228', '梁平县', 2, '0811', '区', 100, 'liang ping xian', 'ux108 ux105 ux97 ux110 ux103 ux112 ux120 ux26753 ux24179 ux21439', 0, 0),
(2275, 2250, '500229', '城口县', 2, '0811', '区', 100, 'cheng kou xian', 'ux99 ux104 ux101 ux110 ux103 ux107 ux111 ux117 ux120 ux105 ux97 ux22478 ux21475 ux21439', 0, 0),
(2276, 2250, '500230', '丰都县', 2, '0811', '区', 100, 'feng du xian', 'ux102 ux101 ux110 ux103 ux100 ux117 ux120 ux105 ux97 ux20016 ux37117 ux21439', 0, 0),
(2277, 2250, '500231', '垫江县', 2, '0811', '区', 100, 'dian jiang xian', 'ux100 ux105 ux97 ux110 ux106 ux103 ux120 ux22443 ux27743 ux21439', 0, 0),
(2278, 2250, '500232', '武隆县', 2, '0811', '区', 100, 'wu long xian', 'ux119 ux117 ux108 ux111 ux110 ux103 ux120 ux105 ux97 ux27494 ux38534 ux21439', 0, 0),
(2279, 2250, '500233', '忠县', 2, '0811', '区', 100, 'zhong xian', 'ux122 ux104 ux111 ux110 ux103 ux120 ux105 ux97 ux24544 ux21439', 0, 0),
(2280, 2250, '500234', '开县', 2, '0811', '区', 100, 'kai xian', 'ux107 ux97 ux105 ux120 ux110 ux24320 ux21439', 0, 0),
(2281, 2250, '500235', '云阳县', 2, '0811', '区', 100, 'yun yang xian', 'ux121 ux117 ux110 ux97 ux103 ux120 ux105 ux20113 ux38451 ux21439', 0, 0),
(2282, 2250, '500236', '奉节县', 2, '0811', '区', 100, 'feng jie xian', 'ux102 ux101 ux110 ux103 ux106 ux105 ux120 ux97 ux22857 ux33410 ux21439', 0, 0),
(2283, 2250, '500237', '巫山县', 2, '0811', '区', 100, 'wu shan xian', 'ux119 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux24043 ux23665 ux21439', 0, 0),
(2284, 2250, '500238', '巫溪县', 2, '0811', '区', 100, 'wu xi xian', 'ux119 ux117 ux120 ux105 ux97 ux110 ux24043 ux28330 ux21439', 0, 0),
(2285, 2250, '500240', '石柱土家族自治县', 2, '0811', '区', 100, 'shi zhu tu jia zu zi zhi xian', 'ux115 ux104 ux105 ux122 ux117 ux116 ux106 ux97 ux120 ux110 ux30707 ux26609 ux22303 ux23478 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2286, 2250, '500241', '秀山土家族苗族自治县', 2, '0811', '区', 100, 'xiu shan tu jia zu miao zu zi zhi xian', 'ux120 ux105 ux117 ux115 ux104 ux97 ux110 ux116 ux106 ux122 ux109 ux111 ux31168 ux23665 ux22303 ux23478 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2287, 2250, '500242', '酉阳土家族苗族自治县', 2, '0811', '区', 100, 'you yang tu jia zu miao zu zi zhi xian', 'ux121 ux111 ux117 ux97 ux110 ux103 ux116 ux106 ux105 ux122 ux109 ux104 ux120 ux37193 ux38451 ux22303 ux23478 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2288, 2250, '500243', '彭水苗族土家族自治县', 2, '0811', '区', 100, 'peng shui miao zu tu jia zu zi zhi xian', 'ux112 ux101 ux110 ux103 ux115 ux104 ux117 ux105 ux109 ux97 ux111 ux122 ux116 ux106 ux120 ux24429 ux27700 ux33495 ux26063 ux22303 ux23478 ux33258 ux27835 ux21439', 0, 0),
(2289, 0, '510000', '四川省', 1, '', '省', 100, 'si chuan sheng', 'ux115 ux105 ux99 ux104 ux117 ux97 ux110 ux101 ux103 ux22235 ux24029 ux30465', 0, 0),
(2290, 2289, '510100', '成都市', 2, '028', '市', 100, 'cheng du shi', 'ux99 ux104 ux101 ux110 ux103 ux100 ux117 ux115 ux105 ux25104 ux37117 ux24066', 0, 0),
(2291, 2290, '510104', '锦江区', 3, '028', '区', 100, 'jin jiang qu', 'ux106 ux105 ux110 ux97 ux103 ux113 ux117 ux38182 ux27743 ux21306', 0, 0),
(2292, 2290, '510105', '青羊区', 3, '028', '区', 100, 'qing yang qu', 'ux113 ux105 ux110 ux103 ux121 ux97 ux117 ux38738 ux32650 ux21306', 0, 0),
(2293, 2290, '510106', '金牛区', 3, '028', '区', 100, 'jin niu qu', 'ux106 ux105 ux110 ux117 ux113 ux37329 ux29275 ux21306', 0, 0),
(2294, 2290, '510107', '武侯区', 3, '028', '区', 100, 'wu hou qu', 'ux119 ux117 ux104 ux111 ux113 ux27494 ux20399 ux21306', 0, 0),
(2295, 2290, '510108', '成华区', 3, '028', '区', 100, 'cheng hua qu', 'ux99 ux104 ux101 ux110 ux103 ux117 ux97 ux113 ux25104 ux21326 ux21306', 0, 0),
(2296, 2290, '510112', '龙泉驿区', 3, '028', '区', 100, 'long quan yi qu', 'ux108 ux111 ux110 ux103 ux113 ux117 ux97 ux121 ux105 ux40857 ux27849 ux39551 ux21306', 0, 0),
(2297, 2290, '510113', '青白江区', 3, '028', '区', 100, 'qing bai jiang qu', 'ux113 ux105 ux110 ux103 ux98 ux97 ux106 ux117 ux38738 ux30333 ux27743 ux21306', 0, 0),
(2298, 2290, '510114', '新都区', 3, '028', '区', 100, 'xin du qu', 'ux120 ux105 ux110 ux100 ux117 ux113 ux26032 ux37117 ux21306', 0, 0),
(2299, 2290, '510115', '温江区', 3, '028', '区', 100, 'wen jiang qu', 'ux119 ux101 ux110 ux106 ux105 ux97 ux103 ux113 ux117 ux28201 ux27743 ux21306', 0, 0),
(2300, 2290, '510121', '金堂县', 3, '028', '区', 100, 'jin tang xian', 'ux106 ux105 ux110 ux116 ux97 ux103 ux120 ux37329 ux22530 ux21439', 0, 0),
(2301, 2290, '510122', '双流县', 3, '028', '区', 100, 'shuang liu xian', 'ux115 ux104 ux117 ux97 ux110 ux103 ux108 ux105 ux120 ux21452 ux27969 ux21439', 0, 0),
(2302, 2290, '510124', '郫县', 3, '028', '区', 100, 'pi xian', 'ux112 ux105 ux120 ux97 ux110 ux37099 ux21439', 0, 0),
(2303, 2290, '510129', '大邑县', 3, '028', '区', 100, 'da yi xian', 'ux100 ux97 ux121 ux105 ux120 ux110 ux22823 ux37009 ux21439', 0, 0),
(2304, 2290, '510131', '蒲江县', 3, '028', '区', 100, 'pu jiang xian', 'ux112 ux117 ux106 ux105 ux97 ux110 ux103 ux120 ux33970 ux27743 ux21439', 0, 0),
(2305, 2290, '510132', '新津县', 3, '028', '区', 100, 'xin jin xian', 'ux120 ux105 ux110 ux106 ux97 ux26032 ux27941 ux21439', 0, 0),
(2306, 2290, '510181', '都江堰市', 3, '028', '区', 100, 'du jiang yan shi', 'ux100 ux117 ux106 ux105 ux97 ux110 ux103 ux121 ux115 ux104 ux37117 ux27743 ux22576 ux24066', 0, 0),
(2307, 2290, '510182', '彭州市', 3, '028', '区', 100, 'peng zhou shi', 'ux112 ux101 ux110 ux103 ux122 ux104 ux111 ux117 ux115 ux105 ux24429 ux24030 ux24066', 0, 0),
(2308, 2290, '510183', '邛崃市', 3, '028', '区', 100, 'qiong lai shi', 'ux113 ux105 ux111 ux110 ux103 ux108 ux97 ux115 ux104 ux37019 ux23811 ux24066', 0, 0),
(2309, 2290, '510184', '崇州市', 3, '028', '区', 100, 'chong zhou shi', 'ux99 ux104 ux111 ux110 ux103 ux122 ux117 ux115 ux105 ux23815 ux24030 ux24066', 0, 0),
(2310, 2289, '510300', '自贡市', 2, '0813', '市', 100, 'zi gong shi', 'ux122 ux105 ux103 ux111 ux110 ux115 ux104 ux33258 ux36129 ux24066', 0, 0),
(2311, 2310, '510302', '自流井区', 3, '0813', '区', 100, 'zi liu jing qu', 'ux122 ux105 ux108 ux117 ux106 ux110 ux103 ux113 ux33258 ux27969 ux20117 ux21306', 0, 0),
(2312, 2310, '510303', '贡井区', 3, '0813', '区', 100, 'gong jing qu', 'ux103 ux111 ux110 ux106 ux105 ux113 ux117 ux36129 ux20117 ux21306', 0, 0),
(2313, 2310, '510304', '大安区', 3, '0813', '区', 100, 'da an qu', 'ux100 ux97 ux110 ux113 ux117 ux22823 ux23433 ux21306', 0, 0),
(2314, 2310, '510311', '沿滩区', 3, '0813', '区', 100, 'yan tan qu', 'ux121 ux97 ux110 ux116 ux113 ux117 ux27839 ux28393 ux21306', 0, 0),
(2315, 2310, '510321', '荣县', 3, '0813', '区', 100, 'rong xian', 'ux114 ux111 ux110 ux103 ux120 ux105 ux97 ux33635 ux21439', 0, 0),
(2316, 2310, '510322', '富顺县', 3, '0813', '区', 100, 'fu shun xian', 'ux102 ux117 ux115 ux104 ux110 ux120 ux105 ux97 ux23500 ux39034 ux21439', 0, 0),
(2317, 2289, '510400', '攀枝花市', 2, '0812', '市', 100, 'pan zhi hua shi', 'ux112 ux97 ux110 ux122 ux104 ux105 ux117 ux115 ux25856 ux26525 ux33457 ux24066', 0, 0),
(2318, 2317, '510402', '东区', 3, '0812', '区', 100, 'dong qu', 'ux100 ux111 ux110 ux103 ux113 ux117 ux19996 ux21306', 0, 0),
(2319, 2317, '510403', '西区', 3, '0812', '区', 100, 'xi qu', 'ux120 ux105 ux113 ux117 ux35199 ux21306', 0, 0),
(2320, 2317, '510411', '仁和区', 3, '0812', '区', 100, 'ren he qu', 'ux114 ux101 ux110 ux104 ux113 ux117 ux20161 ux21644 ux21306', 0, 0),
(2321, 2317, '510421', '米易县', 3, '0812', '区', 100, 'mi yi xian', 'ux109 ux105 ux121 ux120 ux97 ux110 ux31859 ux26131 ux21439', 0, 0),
(2322, 2317, '510422', '盐边县', 3, '0812', '区', 100, 'yan bian xian', 'ux121 ux97 ux110 ux98 ux105 ux120 ux30416 ux36793 ux21439', 0, 0),
(2323, 2289, '510500', '泸州市', 2, '0840', '市', 100, 'lu zhou shi', 'ux108 ux117 ux122 ux104 ux111 ux115 ux105 ux27896 ux24030 ux24066', 0, 0),
(2324, 2323, '510502', '江阳区', 3, '0840', '区', 100, 'jiang yang qu', 'ux106 ux105 ux97 ux110 ux103 ux121 ux113 ux117 ux27743 ux38451 ux21306', 0, 0),
(2325, 2323, '510503', '纳溪区', 3, '0840', '区', 100, 'na xi qu', 'ux110 ux97 ux120 ux105 ux113 ux117 ux32435 ux28330 ux21306', 0, 0),
(2326, 2323, '510504', '龙马潭区', 3, '0840', '区', 100, 'long ma tan qu', 'ux108 ux111 ux110 ux103 ux109 ux97 ux116 ux113 ux117 ux40857 ux39532 ux28525 ux21306', 0, 0),
(2327, 2323, '510521', '泸县', 3, '0840', '区', 100, 'lu xian', 'ux108 ux117 ux120 ux105 ux97 ux110 ux27896 ux21439', 0, 0),
(2328, 2323, '510522', '合江县', 3, '0840', '区', 100, 'he jiang xian', 'ux104 ux101 ux106 ux105 ux97 ux110 ux103 ux120 ux21512 ux27743 ux21439', 0, 0),
(2329, 2323, '510524', '叙永县', 3, '0840', '区', 100, 'xu yong xian', 'ux120 ux117 ux121 ux111 ux110 ux103 ux105 ux97 ux21465 ux27704 ux21439', 0, 0),
(2330, 2323, '510525', '古蔺县', 3, '0840', '区', 100, 'gu lin xian', 'ux103 ux117 ux108 ux105 ux110 ux120 ux97 ux21476 ux34106 ux21439', 0, 0),
(2331, 2289, '510600', '德阳市', 2, '0838', '市', 100, 'de yang shi', 'ux100 ux101 ux121 ux97 ux110 ux103 ux115 ux104 ux105 ux24503 ux38451 ux24066', 0, 0),
(2332, 2331, '510603', '旌阳区', 3, '0838', '区', 100, 'jing yang qu', 'ux106 ux105 ux110 ux103 ux121 ux97 ux113 ux117 ux26060 ux38451 ux21306', 0, 0),
(2333, 2331, '510623', '中江县', 3, '0838', '区', 100, 'zhong jiang xian', 'ux122 ux104 ux111 ux110 ux103 ux106 ux105 ux97 ux120 ux20013 ux27743 ux21439', 0, 0),
(2334, 2331, '510626', '罗江县', 3, '0838', '区', 100, 'luo jiang xian', 'ux108 ux117 ux111 ux106 ux105 ux97 ux110 ux103 ux120 ux32599 ux27743 ux21439', 0, 0),
(2335, 2331, '510681', '广汉市', 3, '0838', '区', 100, 'guang han shi', 'ux103 ux117 ux97 ux110 ux104 ux115 ux105 ux24191 ux27721 ux24066', 0, 0),
(2336, 2331, '510682', '什邡市', 3, '0838', '区', 100, 'shi fang shi', 'ux115 ux104 ux105 ux102 ux97 ux110 ux103 ux20160 ux37025 ux24066', 0, 0),
(2337, 2331, '510683', '绵竹市', 3, '0838', '区', 100, 'mian zhu shi', 'ux109 ux105 ux97 ux110 ux122 ux104 ux117 ux115 ux32501 ux31481 ux24066', 0, 0),
(2338, 2289, '510700', '绵阳市', 2, '0816', '市', 100, 'mian yang shi', 'ux109 ux105 ux97 ux110 ux121 ux103 ux115 ux104 ux32501 ux38451 ux24066', 0, 0),
(2339, 2338, '510703', '涪城区', 3, '0816', '区', 100, 'fu cheng qu', 'ux102 ux117 ux99 ux104 ux101 ux110 ux103 ux113 ux28074 ux22478 ux21306', 0, 0),
(2340, 2338, '510704', '游仙区', 3, '0816', '区', 100, 'you xian qu', 'ux121 ux111 ux117 ux120 ux105 ux97 ux110 ux113 ux28216 ux20185 ux21306', 0, 0),
(2341, 2338, '510722', '三台县', 3, '0816', '区', 100, 'san tai xian', 'ux115 ux97 ux110 ux116 ux105 ux120 ux19977 ux21488 ux21439', 0, 0),
(2342, 2338, '510723', '盐亭县', 3, '0816', '区', 100, 'yan ting xian', 'ux121 ux97 ux110 ux116 ux105 ux103 ux120 ux30416 ux20141 ux21439', 0, 0),
(2343, 2338, '510724', '安县', 3, '0816', '区', 100, 'an xian', 'ux97 ux110 ux120 ux105 ux23433 ux21439', 0, 0),
(2344, 2338, '510725', '梓潼县', 3, '0816', '区', 100, 'zi tong xian', 'ux122 ux105 ux116 ux111 ux110 ux103 ux120 ux97 ux26771 ux28540 ux21439', 0, 0),
(2345, 2338, '510726', '北川羌族自治县', 3, '0816', '区', 100, 'bei chuan qiang zu zi zhi xian', 'ux98 ux101 ux105 ux99 ux104 ux117 ux97 ux110 ux113 ux103 ux122 ux120 ux21271 ux24029 ux32652 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2346, 2338, '510727', '平武县', 3, '0816', '区', 100, 'ping wu xian', 'ux112 ux105 ux110 ux103 ux119 ux117 ux120 ux97 ux24179 ux27494 ux21439', 0, 0),
(2347, 2338, '510781', '江油市', 3, '0816', '区', 100, 'jiang you shi', 'ux106 ux105 ux97 ux110 ux103 ux121 ux111 ux117 ux115 ux104 ux27743 ux27833 ux24066', 0, 0),
(2348, 2289, '510800', '广元市', 2, '0839', '市', 100, 'guang yuan shi', 'ux103 ux117 ux97 ux110 ux121 ux115 ux104 ux105 ux24191 ux20803 ux24066', 0, 0),
(2349, 2348, '510802', '利州区', 3, '0839', '区', 100, 'li zhou qu', 'ux108 ux105 ux122 ux104 ux111 ux117 ux113 ux21033 ux24030 ux21306', 0, 0),
(2350, 2348, '510811', '元坝区', 3, '0839', '区', 100, 'yuan ba qu', 'ux121 ux117 ux97 ux110 ux98 ux113 ux20803 ux22365 ux21306', 0, 0),
(2351, 2348, '510812', '朝天区', 3, '0839', '区', 100, 'zhao tian qu', 'ux122 ux104 ux97 ux111 ux116 ux105 ux110 ux113 ux117 ux26397 ux22825 ux21306', 0, 0),
(2352, 2348, '510821', '旺苍县', 3, '0839', '区', 100, 'wang cang xian', 'ux119 ux97 ux110 ux103 ux99 ux120 ux105 ux26106 ux33485 ux21439', 0, 0),
(2353, 2348, '510822', '青川县', 3, '0839', '区', 100, 'qing chuan xian', 'ux113 ux105 ux110 ux103 ux99 ux104 ux117 ux97 ux120 ux38738 ux24029 ux21439', 0, 0),
(2354, 2348, '510823', '剑阁县', 3, '0839', '区', 100, 'jian ge xian', 'ux106 ux105 ux97 ux110 ux103 ux101 ux120 ux21073 ux38401 ux21439', 0, 0),
(2355, 2348, '510824', '苍溪县', 3, '0839', '区', 100, 'cang xi xian', 'ux99 ux97 ux110 ux103 ux120 ux105 ux33485 ux28330 ux21439', 0, 0),
(2356, 2289, '510900', '遂宁市', 2, '0825', '市', 100, 'sui ning shi', 'ux115 ux117 ux105 ux110 ux103 ux104 ux36930 ux23425 ux24066', 0, 0),
(2357, 2356, '510903', '船山区', 3, '0825', '区', 100, 'chuan shan qu', 'ux99 ux104 ux117 ux97 ux110 ux115 ux113 ux33337 ux23665 ux21306', 0, 0),
(2358, 2356, '510904', '安居区', 3, '0825', '区', 100, 'an ju qu', 'ux97 ux110 ux106 ux117 ux113 ux23433 ux23621 ux21306', 0, 0),
(2359, 2356, '510921', '蓬溪县', 3, '0825', '区', 100, 'peng xi xian', 'ux112 ux101 ux110 ux103 ux120 ux105 ux97 ux34028 ux28330 ux21439', 0, 0),
(2360, 2356, '510922', '射洪县', 3, '0825', '区', 100, 'she hong xian', 'ux115 ux104 ux101 ux111 ux110 ux103 ux120 ux105 ux97 ux23556 ux27946 ux21439', 0, 0),
(2361, 2356, '510923', '大英县', 3, '0825', '区', 100, 'da ying xian', 'ux100 ux97 ux121 ux105 ux110 ux103 ux120 ux22823 ux33521 ux21439', 0, 0),
(2362, 2289, '511000', '内江市', 2, '0832', '市', 100, 'nei jiang shi', 'ux110 ux101 ux105 ux106 ux97 ux103 ux115 ux104 ux20869 ux27743 ux24066', 0, 0),
(2363, 2362, '511002', '市中区', 3, '0832', '区', 100, 'shi zhong qu', 'ux115 ux104 ux105 ux122 ux111 ux110 ux103 ux113 ux117 ux24066 ux20013 ux21306', 0, 0),
(2364, 2362, '511011', '东兴区', 3, '0832', '区', 100, 'dong xing qu', 'ux100 ux111 ux110 ux103 ux120 ux105 ux113 ux117 ux19996 ux20852 ux21306', 0, 0),
(2365, 2362, '511024', '威远县', 3, '0832', '区', 100, 'wei yuan xian', 'ux119 ux101 ux105 ux121 ux117 ux97 ux110 ux120 ux23041 ux36828 ux21439', 0, 0),
(2366, 2362, '511025', '资中县', 3, '0832', '区', 100, 'zi zhong xian', 'ux122 ux105 ux104 ux111 ux110 ux103 ux120 ux97 ux36164 ux20013 ux21439', 0, 0),
(2367, 2362, '511028', '隆昌县', 3, '0832', '区', 100, 'long chang xian', 'ux108 ux111 ux110 ux103 ux99 ux104 ux97 ux120 ux105 ux38534 ux26124 ux21439', 0, 0),
(2368, 2289, '511100', '乐山市', 2, '0833', '市', 100, 'le shan shi', 'ux108 ux101 ux115 ux104 ux97 ux110 ux105 ux20048 ux23665 ux24066', 0, 0),
(2369, 2368, '511102', '市中区', 3, '0833', '区', 100, 'shi zhong qu', 'ux115 ux104 ux105 ux122 ux111 ux110 ux103 ux113 ux117 ux24066 ux20013 ux21306', 0, 0),
(2370, 2368, '511111', '沙湾区', 3, '0833', '区', 100, 'sha wan qu', 'ux115 ux104 ux97 ux119 ux110 ux113 ux117 ux27801 ux28286 ux21306', 0, 0),
(2371, 2368, '511112', '五通桥区', 3, '0833', '区', 100, 'wu tong qiao qu', 'ux119 ux117 ux116 ux111 ux110 ux103 ux113 ux105 ux97 ux20116 ux36890 ux26725 ux21306', 0, 0),
(2372, 2368, '511113', '金口河区', 3, '0833', '区', 100, 'jin kou he qu', 'ux106 ux105 ux110 ux107 ux111 ux117 ux104 ux101 ux113 ux37329 ux21475 ux27827 ux21306', 0, 0),
(2373, 2368, '511123', '犍为县', 3, '0833', '区', 100, 'jian wei xian', 'ux106 ux105 ux97 ux110 ux119 ux101 ux120 ux29325 ux20026 ux21439', 0, 0),
(2374, 2368, '511124', '井研县', 3, '0833', '区', 100, 'jing yan xian', 'ux106 ux105 ux110 ux103 ux121 ux97 ux120 ux20117 ux30740 ux21439', 0, 0),
(2375, 2368, '511126', '夹江县', 3, '0833', '区', 100, 'jia jiang xian', 'ux106 ux105 ux97 ux110 ux103 ux120 ux22841 ux27743 ux21439', 0, 0),
(2376, 2368, '511129', '沐川县', 3, '0833', '区', 100, 'mu chuan xian', 'ux109 ux117 ux99 ux104 ux97 ux110 ux120 ux105 ux27792 ux24029 ux21439', 0, 0),
(2377, 2368, '511132', '峨边彝族自治县', 3, '0833', '区', 100, 'e bian yi zu zi zhi xian', 'ux101 ux98 ux105 ux97 ux110 ux121 ux122 ux117 ux104 ux120 ux23784 ux36793 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2378, 2368, '511133', '马边彝族自治县', 3, '0833', '区', 100, 'ma bian yi zu zi zhi xian', 'ux109 ux97 ux98 ux105 ux110 ux121 ux122 ux117 ux104 ux120 ux39532 ux36793 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2379, 2368, '511181', '峨眉山市', 3, '0833', '区', 100, 'e mei shan shi', 'ux101 ux109 ux105 ux115 ux104 ux97 ux110 ux23784 ux30473 ux23665 ux24066', 0, 0),
(2380, 2289, '511300', '南充市', 2, '0817', '市', 100, 'nan chong shi', 'ux110 ux97 ux99 ux104 ux111 ux103 ux115 ux105 ux21335 ux20805 ux24066', 0, 0),
(2381, 2380, '511302', '顺庆区', 3, '0817', '区', 100, 'shun qing qu', 'ux115 ux104 ux117 ux110 ux113 ux105 ux103 ux39034 ux24198 ux21306', 0, 0),
(2382, 2380, '511303', '高坪区', 3, '0817', '区', 100, 'gao ping qu', 'ux103 ux97 ux111 ux112 ux105 ux110 ux113 ux117 ux39640 ux22378 ux21306', 0, 0),
(2383, 2380, '511304', '嘉陵区', 3, '0817', '区', 100, 'jia ling qu', 'ux106 ux105 ux97 ux108 ux110 ux103 ux113 ux117 ux22025 ux38517 ux21306', 0, 0),
(2384, 2380, '511321', '南部县', 3, '0817', '区', 100, 'nan bu xian', 'ux110 ux97 ux98 ux117 ux120 ux105 ux21335 ux37096 ux21439', 0, 0),
(2385, 2380, '511322', '营山县', 3, '0817', '区', 100, 'ying shan xian', 'ux121 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux33829 ux23665 ux21439', 0, 0),
(2386, 2380, '511323', '蓬安县', 3, '0817', '区', 100, 'peng an xian', 'ux112 ux101 ux110 ux103 ux97 ux120 ux105 ux34028 ux23433 ux21439', 0, 0),
(2387, 2380, '511324', '仪陇县', 3, '0817', '区', 100, 'yi long xian', 'ux121 ux105 ux108 ux111 ux110 ux103 ux120 ux97 ux20202 ux38471 ux21439', 0, 0),
(2388, 2380, '511325', '西充县', 3, '0817', '区', 100, 'xi chong xian', 'ux120 ux105 ux99 ux104 ux111 ux110 ux103 ux97 ux35199 ux20805 ux21439', 0, 0),
(2389, 2380, '511381', '阆中市', 3, '0817', '区', 100, 'lang zhong shi', 'ux108 ux97 ux110 ux103 ux122 ux104 ux111 ux115 ux105 ux38406 ux20013 ux24066', 0, 0),
(2390, 2289, '511400', '眉山市', 2, '028', '市', 100, 'mei shan shi', 'ux109 ux101 ux105 ux115 ux104 ux97 ux110 ux30473 ux23665 ux24066', 0, 0),
(2391, 2390, '511402', '东坡区', 3, '028', '区', 100, 'dong po qu', 'ux100 ux111 ux110 ux103 ux112 ux113 ux117 ux19996 ux22369 ux21306', 0, 0),
(2392, 2390, '511421', '仁寿县', 3, '028', '区', 100, 'ren shou xian', 'ux114 ux101 ux110 ux115 ux104 ux111 ux117 ux120 ux105 ux97 ux20161 ux23551 ux21439', 0, 0),
(2393, 2390, '511422', '彭山县', 3, '028', '区', 100, 'peng shan xian', 'ux112 ux101 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux24429 ux23665 ux21439', 0, 0),
(2394, 2390, '511423', '洪雅县', 3, '028', '区', 100, 'hong ya xian', 'ux104 ux111 ux110 ux103 ux121 ux97 ux120 ux105 ux27946 ux38597 ux21439', 0, 0),
(2395, 2390, '511424', '丹棱县', 3, '028', '区', 100, 'dan leng xian', 'ux100 ux97 ux110 ux108 ux101 ux103 ux120 ux105 ux20025 ux26865 ux21439', 0, 0),
(2396, 2390, '511425', '青神县', 3, '028', '区', 100, 'qing shen xian', 'ux113 ux105 ux110 ux103 ux115 ux104 ux101 ux120 ux97 ux38738 ux31070 ux21439', 0, 0),
(2397, 2289, '511500', '宜宾市', 2, '0831', '市', 100, 'yi bin shi', 'ux121 ux105 ux98 ux110 ux115 ux104 ux23452 ux23486 ux24066', 0, 0),
(2398, 2397, '511502', '翠屏区', 3, '0831', '区', 100, 'cui ping qu', 'ux99 ux117 ux105 ux112 ux110 ux103 ux113 ux32736 ux23631 ux21306', 0, 0),
(2399, 2397, '511521', '宜宾县', 3, '0831', '区', 100, 'yi bin xian', 'ux121 ux105 ux98 ux110 ux120 ux97 ux23452 ux23486 ux21439', 0, 0),
(2400, 2397, '511522', '南溪区', 3, '0831', '区', 100, 'nan xi qu', 'ux110 ux97 ux120 ux105 ux113 ux117 ux21335 ux28330 ux21306', 0, 0),
(2401, 2397, '511523', '江安县', 3, '0831', '区', 100, 'jiang an xian', 'ux106 ux105 ux97 ux110 ux103 ux120 ux27743 ux23433 ux21439', 0, 0),
(2402, 2397, '511524', '长宁县', 3, '0831', '区', 100, 'chang ning xian', 'ux99 ux104 ux97 ux110 ux103 ux105 ux120 ux38271 ux23425 ux21439', 0, 0),
(2403, 2397, '511525', '高县', 3, '0831', '区', 100, 'gao xian', 'ux103 ux97 ux111 ux120 ux105 ux110 ux39640 ux21439', 0, 0),
(2404, 2397, '511526', '珙县', 3, '0831', '区', 100, 'gong xian', 'ux103 ux111 ux110 ux120 ux105 ux97 ux29657 ux21439', 0, 0),
(2405, 2397, '511527', '筠连县', 3, '0831', '区', 100, 'yun lian xian', 'ux121 ux117 ux110 ux108 ux105 ux97 ux120 ux31584 ux36830 ux21439', 0, 0),
(2406, 2397, '511528', '兴文县', 3, '0831', '区', 100, 'xing wen xian', 'ux120 ux105 ux110 ux103 ux119 ux101 ux97 ux20852 ux25991 ux21439', 0, 0),
(2407, 2397, '511529', '屏山县', 3, '0831', '区', 100, 'ping shan xian', 'ux112 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux23631 ux23665 ux21439', 0, 0),
(2408, 2289, '511600', '广安市', 2, '0826', '市', 100, 'guang an shi', 'ux103 ux117 ux97 ux110 ux115 ux104 ux105 ux24191 ux23433 ux24066', 0, 0),
(2409, 2408, '511602', '广安区', 3, '0826', '区', 100, 'guang an qu', 'ux103 ux117 ux97 ux110 ux113 ux24191 ux23433 ux21306', 0, 0),
(2410, 2408, '511621', '岳池县', 3, '0826', '区', 100, 'yue chi xian', 'ux121 ux117 ux101 ux99 ux104 ux105 ux120 ux97 ux110 ux23731 ux27744 ux21439', 0, 0),
(2411, 2408, '511622', '武胜县', 3, '0826', '区', 100, 'wu sheng xian', 'ux119 ux117 ux115 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux27494 ux32988 ux21439', 0, 0),
(2412, 2408, '511623', '邻水县', 3, '0826', '区', 100, 'lin shui xian', 'ux108 ux105 ux110 ux115 ux104 ux117 ux120 ux97 ux37051 ux27700 ux21439', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(2413, 2408, '511681', '华蓥市', 3, '0826', '区', 100, 'hua ying shi', 'ux104 ux117 ux97 ux121 ux105 ux110 ux103 ux115 ux21326 ux34021 ux24066', 0, 0),
(2414, 2289, '511700', '达州市', 2, '0818', '市', 100, 'da zhou shi', 'ux100 ux97 ux122 ux104 ux111 ux117 ux115 ux105 ux36798 ux24030 ux24066', 0, 0),
(2415, 2414, '511702', '通川区', 3, '0818', '区', 100, 'tong chuan qu', 'ux116 ux111 ux110 ux103 ux99 ux104 ux117 ux97 ux113 ux36890 ux24029 ux21306', 0, 0),
(2416, 2414, '511721', '达县', 3, '0818', '区', 100, 'da xian', 'ux100 ux97 ux120 ux105 ux110 ux36798 ux21439', 0, 0),
(2417, 2414, '511722', '宣汉县', 3, '0818', '区', 100, 'xuan han xian', 'ux120 ux117 ux97 ux110 ux104 ux105 ux23459 ux27721 ux21439', 0, 0),
(2418, 2414, '511723', '开江县', 3, '0818', '区', 100, 'kai jiang xian', 'ux107 ux97 ux105 ux106 ux110 ux103 ux120 ux24320 ux27743 ux21439', 0, 0),
(2419, 2414, '511724', '大竹县', 3, '0818', '区', 100, 'da zhu xian', 'ux100 ux97 ux122 ux104 ux117 ux120 ux105 ux110 ux22823 ux31481 ux21439', 0, 0),
(2420, 2414, '511725', '渠县', 3, '0818', '区', 100, 'qu xian', 'ux113 ux117 ux120 ux105 ux97 ux110 ux28192 ux21439', 0, 0),
(2421, 2414, '511781', '万源市', 3, '0818', '区', 100, 'wan yuan shi', 'ux119 ux97 ux110 ux121 ux117 ux115 ux104 ux105 ux19975 ux28304 ux24066', 0, 0),
(2422, 2289, '511800', '雅安市', 2, '0835', '市', 100, 'ya an shi', 'ux121 ux97 ux110 ux115 ux104 ux105 ux38597 ux23433 ux24066', 0, 0),
(2423, 2422, '511802', '雨城区', 3, '0835', '区', 100, 'yu cheng qu', 'ux121 ux117 ux99 ux104 ux101 ux110 ux103 ux113 ux38632 ux22478 ux21306', 0, 0),
(2424, 2422, '511821', '名山县', 3, '0835', '区', 100, 'ming shan xian', 'ux109 ux105 ux110 ux103 ux115 ux104 ux97 ux120 ux21517 ux23665 ux21439', 0, 0),
(2425, 2422, '511822', '荥经县', 3, '0835', '区', 100, 'xing jing xian', 'ux120 ux105 ux110 ux103 ux106 ux97 ux33637 ux32463 ux21439', 0, 0),
(2426, 2422, '511823', '汉源县', 3, '0835', '区', 100, 'han yuan xian', 'ux104 ux97 ux110 ux121 ux117 ux120 ux105 ux27721 ux28304 ux21439', 0, 0),
(2427, 2422, '511824', '石棉县', 3, '0835', '区', 100, 'shi mian xian', 'ux115 ux104 ux105 ux109 ux97 ux110 ux120 ux30707 ux26825 ux21439', 0, 0),
(2428, 2422, '511825', '天全县', 3, '0835', '区', 100, 'tian quan xian', 'ux116 ux105 ux97 ux110 ux113 ux117 ux120 ux22825 ux20840 ux21439', 0, 0),
(2429, 2422, '511826', '芦山县', 3, '0835', '区', 100, 'lu shan xian', 'ux108 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux33446 ux23665 ux21439', 0, 0),
(2430, 2422, '511827', '宝兴县', 3, '0835', '区', 100, 'bao xing xian', 'ux98 ux97 ux111 ux120 ux105 ux110 ux103 ux23453 ux20852 ux21439', 0, 0),
(2431, 2289, '511900', '巴中市', 2, '0827', '市', 100, 'ba zhong shi', 'ux98 ux97 ux122 ux104 ux111 ux110 ux103 ux115 ux105 ux24052 ux20013 ux24066', 0, 0),
(2432, 2431, '511902', '巴州区', 3, '0827', '区', 100, 'ba zhou qu', 'ux98 ux97 ux122 ux104 ux111 ux117 ux113 ux24052 ux24030 ux21306', 0, 0),
(2433, 2431, '511921', '通江县', 3, '0827', '区', 100, 'tong jiang xian', 'ux116 ux111 ux110 ux103 ux106 ux105 ux97 ux120 ux36890 ux27743 ux21439', 0, 0),
(2434, 2431, '511922', '南江县', 3, '0827', '区', 100, 'nan jiang xian', 'ux110 ux97 ux106 ux105 ux103 ux120 ux21335 ux27743 ux21439', 0, 0),
(2435, 2431, '511923', '平昌县', 3, '0827', '区', 100, 'ping chang xian', 'ux112 ux105 ux110 ux103 ux99 ux104 ux97 ux120 ux24179 ux26124 ux21439', 0, 0),
(2436, 2289, '512000', '资阳市', 2, '028', '市', 100, 'zi yang shi', 'ux122 ux105 ux121 ux97 ux110 ux103 ux115 ux104 ux36164 ux38451 ux24066', 0, 0),
(2437, 2436, '512002', '雁江区', 3, '028', '区', 100, 'yan jiang qu', 'ux121 ux97 ux110 ux106 ux105 ux103 ux113 ux117 ux38593 ux27743 ux21306', 0, 0),
(2438, 2436, '512021', '安岳县', 3, '028', '区', 100, 'an yue xian', 'ux97 ux110 ux121 ux117 ux101 ux120 ux105 ux23433 ux23731 ux21439', 0, 0),
(2439, 2436, '512022', '乐至县', 3, '028', '区', 100, 'le zhi xian', 'ux108 ux101 ux122 ux104 ux105 ux120 ux97 ux110 ux20048 ux33267 ux21439', 0, 0),
(2440, 2436, '512081', '简阳市', 3, '028', '区', 100, 'jian yang shi', 'ux106 ux105 ux97 ux110 ux121 ux103 ux115 ux104 ux31616 ux38451 ux24066', 0, 0),
(2441, 2289, '513200', '阿坝藏族羌族自治州', 2, '0837', '市', 100, 'a ba cang zu qiang zu zi zhi zhou', 'ux97 ux98 ux99 ux110 ux103 ux122 ux117 ux113 ux105 ux104 ux111 ux38463 ux22365 ux34255 ux26063 ux32652 ux33258 ux27835 ux24030', 0, 0),
(2442, 2441, '513221', '汶川县', 3, '0837', '区', 100, 'wen chuan xian', 'ux119 ux101 ux110 ux99 ux104 ux117 ux97 ux120 ux105 ux27766 ux24029 ux21439', 0, 0),
(2443, 2441, '513222', '理县', 3, '0837', '区', 100, 'li xian', 'ux108 ux105 ux120 ux97 ux110 ux29702 ux21439', 0, 0),
(2444, 2441, '513223', '茂县', 3, '0837', '区', 100, 'mao xian', 'ux109 ux97 ux111 ux120 ux105 ux110 ux33538 ux21439', 0, 0),
(2445, 2441, '513224', '松潘县', 3, '0837', '区', 100, 'song pan xian', 'ux115 ux111 ux110 ux103 ux112 ux97 ux120 ux105 ux26494 ux28504 ux21439', 0, 0),
(2446, 2441, '513225', '九寨沟县', 3, '0837', '区', 100, 'jiu zhai gou xian', 'ux106 ux105 ux117 ux122 ux104 ux97 ux103 ux111 ux120 ux110 ux20061 ux23528 ux27807 ux21439', 0, 0),
(2447, 2441, '513226', '金川县', 3, '0837', '区', 100, 'jin chuan xian', 'ux106 ux105 ux110 ux99 ux104 ux117 ux97 ux120 ux37329 ux24029 ux21439', 0, 0),
(2448, 2441, '513227', '小金县', 3, '0837', '区', 100, 'xiao jin xian', 'ux120 ux105 ux97 ux111 ux106 ux110 ux23567 ux37329 ux21439', 0, 0),
(2449, 2441, '513228', '黑水县', 3, '0837', '区', 100, 'hei shui xian', 'ux104 ux101 ux105 ux115 ux117 ux120 ux97 ux110 ux40657 ux27700 ux21439', 0, 0),
(2450, 2441, '513229', '马尔康县', 3, '0837', '区', 100, 'ma er kang xian', 'ux109 ux97 ux101 ux114 ux107 ux110 ux103 ux120 ux105 ux39532 ux23572 ux24247 ux21439', 0, 0),
(2451, 2441, '513230', '壤塘县', 3, '0837', '区', 100, 'rang tang xian', 'ux114 ux97 ux110 ux103 ux116 ux120 ux105 ux22756 ux22616 ux21439', 0, 0),
(2452, 2441, '513231', '阿坝县', 3, '0837', '区', 100, 'a ba xian', 'ux97 ux98 ux120 ux105 ux110 ux38463 ux22365 ux21439', 0, 0),
(2453, 2441, '513232', '若尔盖县', 3, '0837', '区', 100, 'ruo er gai xian', 'ux114 ux117 ux111 ux101 ux103 ux97 ux105 ux120 ux110 ux33509 ux23572 ux30422 ux21439', 0, 0),
(2454, 2441, '513233', '红原县', 3, '0837', '区', 100, 'hong yuan xian', 'ux104 ux111 ux110 ux103 ux121 ux117 ux97 ux120 ux105 ux32418 ux21407 ux21439', 0, 0),
(2455, 2289, '513300', '甘孜藏族自治州', 2, '0836', '市', 100, 'gan zi cang zu zi zhi zhou', 'ux103 ux97 ux110 ux122 ux105 ux99 ux117 ux104 ux111 ux29976 ux23388 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2456, 2455, '513321', '康定县', 3, '0836', '区', 100, 'kang ding xian', 'ux107 ux97 ux110 ux103 ux100 ux105 ux120 ux24247 ux23450 ux21439', 0, 0),
(2457, 2455, '513322', '泸定县', 3, '0836', '区', 100, 'lu ding xian', 'ux108 ux117 ux100 ux105 ux110 ux103 ux120 ux97 ux27896 ux23450 ux21439', 0, 0),
(2458, 2455, '513323', '丹巴县', 3, '0836', '区', 100, 'dan ba xian', 'ux100 ux97 ux110 ux98 ux120 ux105 ux20025 ux24052 ux21439', 0, 0),
(2459, 2455, '513324', '九龙县', 3, '0836', '区', 100, 'jiu long xian', 'ux106 ux105 ux117 ux108 ux111 ux110 ux103 ux120 ux97 ux20061 ux40857 ux21439', 0, 0),
(2460, 2455, '513325', '雅江县', 3, '0836', '区', 100, 'ya jiang xian', 'ux121 ux97 ux106 ux105 ux110 ux103 ux120 ux38597 ux27743 ux21439', 0, 0),
(2461, 2455, '513326', '道孚县', 3, '0836', '区', 100, 'dao fu xian', 'ux100 ux97 ux111 ux102 ux117 ux120 ux105 ux110 ux36947 ux23386 ux21439', 0, 0),
(2462, 2455, '513327', '炉霍县', 3, '0836', '区', 100, 'lu huo xian', 'ux108 ux117 ux104 ux111 ux120 ux105 ux97 ux110 ux28809 ux38669 ux21439', 0, 0),
(2463, 2455, '513328', '甘孜县', 3, '0836', '区', 100, 'gan zi xian', 'ux103 ux97 ux110 ux122 ux105 ux120 ux29976 ux23388 ux21439', 0, 0),
(2464, 2455, '513329', '新龙县', 3, '0836', '区', 100, 'xin long xian', 'ux120 ux105 ux110 ux108 ux111 ux103 ux97 ux26032 ux40857 ux21439', 0, 0),
(2465, 2455, '513330', '德格县', 3, '0836', '区', 100, 'de ge xian', 'ux100 ux101 ux103 ux120 ux105 ux97 ux110 ux24503 ux26684 ux21439', 0, 0),
(2466, 2455, '513331', '白玉县', 3, '0836', '区', 100, 'bai yu xian', 'ux98 ux97 ux105 ux121 ux117 ux120 ux110 ux30333 ux29577 ux21439', 0, 0),
(2467, 2455, '513332', '石渠县', 3, '0836', '区', 100, 'shi qu xian', 'ux115 ux104 ux105 ux113 ux117 ux120 ux97 ux110 ux30707 ux28192 ux21439', 0, 0),
(2468, 2455, '513333', '色达县', 3, '0836', '区', 100, 'se da xian', 'ux115 ux101 ux100 ux97 ux120 ux105 ux110 ux33394 ux36798 ux21439', 0, 0),
(2469, 2455, '513334', '理塘县', 3, '0836', '区', 100, 'li tang xian', 'ux108 ux105 ux116 ux97 ux110 ux103 ux120 ux29702 ux22616 ux21439', 0, 0),
(2470, 2455, '513335', '巴塘县', 3, '0836', '区', 100, 'ba tang xian', 'ux98 ux97 ux116 ux110 ux103 ux120 ux105 ux24052 ux22616 ux21439', 0, 0),
(2471, 2455, '513336', '乡城县', 3, '0836', '区', 100, 'xiang cheng xian', 'ux120 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux20065 ux22478 ux21439', 0, 0),
(2472, 2455, '513337', '稻城县', 3, '0836', '区', 100, 'dao cheng xian', 'ux100 ux97 ux111 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux31291 ux22478 ux21439', 0, 0),
(2473, 2455, '513338', '得荣县', 3, '0836', '区', 100, 'de rong xian', 'ux100 ux101 ux114 ux111 ux110 ux103 ux120 ux105 ux97 ux24471 ux33635 ux21439', 0, 0),
(2474, 2289, '513400', '凉山彝族自治州', 2, '0834', '市', 100, 'liang shan yi zu zi zhi zhou', 'ux108 ux105 ux97 ux110 ux103 ux115 ux104 ux121 ux122 ux117 ux111 ux20937 ux23665 ux24413 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2475, 2474, '513401', '西昌市', 3, '0834', '区', 100, 'xi chang shi', 'ux120 ux105 ux99 ux104 ux97 ux110 ux103 ux115 ux35199 ux26124 ux24066', 0, 0),
(2476, 2474, '513422', '木里藏族自治县', 3, '0834', '区', 100, 'mu li cang zu zi zhi xian', 'ux109 ux117 ux108 ux105 ux99 ux97 ux110 ux103 ux122 ux104 ux120 ux26408 ux37324 ux34255 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2477, 2474, '513423', '盐源县', 3, '0834', '区', 100, 'yan yuan xian', 'ux121 ux97 ux110 ux117 ux120 ux105 ux30416 ux28304 ux21439', 0, 0),
(2478, 2474, '513424', '德昌县', 3, '0834', '区', 100, 'de chang xian', 'ux100 ux101 ux99 ux104 ux97 ux110 ux103 ux120 ux105 ux24503 ux26124 ux21439', 0, 0),
(2479, 2474, '513425', '会理县', 3, '0834', '区', 100, 'hui li xian', 'ux104 ux117 ux105 ux108 ux120 ux97 ux110 ux20250 ux29702 ux21439', 0, 0),
(2480, 2474, '513426', '会东县', 3, '0834', '区', 100, 'hui dong xian', 'ux104 ux117 ux105 ux100 ux111 ux110 ux103 ux120 ux97 ux20250 ux19996 ux21439', 0, 0),
(2481, 2474, '513427', '宁南县', 3, '0834', '区', 100, 'ning nan xian', 'ux110 ux105 ux103 ux97 ux120 ux23425 ux21335 ux21439', 0, 0),
(2482, 2474, '513428', '普格县', 3, '0834', '区', 100, 'pu ge xian', 'ux112 ux117 ux103 ux101 ux120 ux105 ux97 ux110 ux26222 ux26684 ux21439', 0, 0),
(2483, 2474, '513429', '布拖县', 3, '0834', '区', 100, 'bu tuo xian', 'ux98 ux117 ux116 ux111 ux120 ux105 ux97 ux110 ux24067 ux25302 ux21439', 0, 0),
(2484, 2474, '513430', '金阳县', 3, '0834', '区', 100, 'jin yang xian', 'ux106 ux105 ux110 ux121 ux97 ux103 ux120 ux37329 ux38451 ux21439', 0, 0),
(2485, 2474, '513431', '昭觉县', 3, '0834', '区', 100, 'zhao jue xian', 'ux122 ux104 ux97 ux111 ux106 ux117 ux101 ux120 ux105 ux110 ux26157 ux35273 ux21439', 0, 0),
(2486, 2474, '513432', '喜德县', 3, '0834', '区', 100, 'xi de xian', 'ux120 ux105 ux100 ux101 ux97 ux110 ux21916 ux24503 ux21439', 0, 0),
(2487, 2474, '513433', '冕宁县', 3, '0834', '区', 100, 'mian ning xian', 'ux109 ux105 ux97 ux110 ux103 ux120 ux20885 ux23425 ux21439', 0, 0),
(2488, 2474, '513434', '越西县', 3, '0834', '区', 100, 'yue xi xian', 'ux121 ux117 ux101 ux120 ux105 ux97 ux110 ux36234 ux35199 ux21439', 0, 0),
(2489, 2474, '513435', '甘洛县', 3, '0834', '区', 100, 'gan luo xian', 'ux103 ux97 ux110 ux108 ux117 ux111 ux120 ux105 ux29976 ux27931 ux21439', 0, 0),
(2490, 2474, '513436', '美姑县', 3, '0834', '区', 100, 'mei gu xian', 'ux109 ux101 ux105 ux103 ux117 ux120 ux97 ux110 ux32654 ux22993 ux21439', 0, 0),
(2491, 2474, '513437', '雷波县', 3, '0834', '区', 100, 'lei bo xian', 'ux108 ux101 ux105 ux98 ux111 ux120 ux97 ux110 ux38647 ux27874 ux21439', 0, 0),
(2492, 0, '520000', '贵州省', 1, '', '省', 100, 'gui zhou sheng', 'ux103 ux117 ux105 ux122 ux104 ux111 ux115 ux101 ux110 ux36149 ux24030 ux30465', 0, 0),
(2493, 2492, '520100', '贵阳市', 2, '0851', '市', 100, 'gui yang shi', 'ux103 ux117 ux105 ux121 ux97 ux110 ux115 ux104 ux36149 ux38451 ux24066', 0, 0),
(2494, 2493, '520102', '南明区', 3, '0851', '区', 100, 'nan ming qu', 'ux110 ux97 ux109 ux105 ux103 ux113 ux117 ux21335 ux26126 ux21306', 0, 0),
(2495, 2493, '520103', '云岩区', 3, '0851', '区', 100, 'yun yan qu', 'ux121 ux117 ux110 ux97 ux113 ux20113 ux23721 ux21306', 0, 0),
(2496, 2493, '520111', '花溪区', 3, '0851', '区', 100, 'hua xi qu', 'ux104 ux117 ux97 ux120 ux105 ux113 ux33457 ux28330 ux21306', 0, 0),
(2497, 2493, '520112', '乌当区', 3, '0851', '区', 100, 'wu dang qu', 'ux119 ux117 ux100 ux97 ux110 ux103 ux113 ux20044 ux24403 ux21306', 0, 0),
(2498, 2493, '520113', '白云区', 3, '0851', '区', 100, 'bai yun qu', 'ux98 ux97 ux105 ux121 ux117 ux110 ux113 ux30333 ux20113 ux21306', 0, 0),
(2499, 2493, '520114', '小河区', 3, '0851', '区', 100, 'xiao he qu', 'ux120 ux105 ux97 ux111 ux104 ux101 ux113 ux117 ux23567 ux27827 ux21306', 0, 0),
(2500, 2493, '520121', '开阳县', 3, '0851', '区', 100, 'kai yang xian', 'ux107 ux97 ux105 ux121 ux110 ux103 ux120 ux24320 ux38451 ux21439', 0, 0),
(2501, 2493, '520122', '息烽县', 3, '0851', '区', 100, 'xi feng xian', 'ux120 ux105 ux102 ux101 ux110 ux103 ux97 ux24687 ux28925 ux21439', 0, 0),
(2502, 2493, '520123', '修文县', 3, '0851', '区', 100, 'xiu wen xian', 'ux120 ux105 ux117 ux119 ux101 ux110 ux97 ux20462 ux25991 ux21439', 0, 0),
(2503, 2493, '520181', '清镇市', 3, '0851', '区', 100, 'qing zhen shi', 'ux113 ux105 ux110 ux103 ux122 ux104 ux101 ux115 ux28165 ux38215 ux24066', 0, 0),
(2504, 2492, '520200', '六盘水市', 2, '0858', '市', 100, 'liu pan shui shi', 'ux108 ux105 ux117 ux112 ux97 ux110 ux115 ux104 ux20845 ux30424 ux27700 ux24066', 0, 0),
(2505, 2504, '520201', '钟山区', 3, '0858', '区', 100, 'zhong shan qu', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux38047 ux23665 ux21306', 0, 0),
(2506, 2504, '520203', '六枝特区', 3, '0858', '区', 100, 'liu zhi te qu', 'ux108 ux105 ux117 ux122 ux104 ux116 ux101 ux113 ux20845 ux26525 ux29305 ux21306', 0, 0),
(2507, 2504, '520221', '水城县', 3, '0858', '区', 100, 'shui cheng xian', 'ux115 ux104 ux117 ux105 ux99 ux101 ux110 ux103 ux120 ux97 ux27700 ux22478 ux21439', 0, 0),
(2508, 2504, '520222', '盘县', 3, '0858', '区', 100, 'pan xian', 'ux112 ux97 ux110 ux120 ux105 ux30424 ux21439', 0, 0),
(2509, 2492, '520300', '遵义市', 2, '0852', '市', 100, 'zun yi shi', 'ux122 ux117 ux110 ux121 ux105 ux115 ux104 ux36981 ux20041 ux24066', 0, 0),
(2510, 2509, '520302', '红花岗区', 3, '0852', '区', 100, 'hong hua gang qu', 'ux104 ux111 ux110 ux103 ux117 ux97 ux113 ux32418 ux33457 ux23703 ux21306', 0, 0),
(2511, 2509, '520303', '汇川区', 3, '0852', '区', 100, 'hui chuan qu', 'ux104 ux117 ux105 ux99 ux97 ux110 ux113 ux27719 ux24029 ux21306', 0, 0),
(2512, 2509, '520321', '遵义县', 3, '0852', '区', 100, 'zun yi xian', 'ux122 ux117 ux110 ux121 ux105 ux120 ux97 ux36981 ux20041 ux21439', 0, 0),
(2513, 2509, '520322', '桐梓县', 3, '0852', '区', 100, 'tong zi xian', 'ux116 ux111 ux110 ux103 ux122 ux105 ux120 ux97 ux26704 ux26771 ux21439', 0, 0),
(2514, 2509, '520323', '绥阳县', 3, '0852', '区', 100, 'sui yang xian', 'ux115 ux117 ux105 ux121 ux97 ux110 ux103 ux120 ux32485 ux38451 ux21439', 0, 0),
(2515, 2509, '520324', '正安县', 3, '0852', '区', 100, 'zheng an xian', 'ux122 ux104 ux101 ux110 ux103 ux97 ux120 ux105 ux27491 ux23433 ux21439', 0, 0),
(2516, 2509, '520325', '道真仡佬族苗族自治县', 3, '0852', '区', 100, 'dao zhen yi lao zu miao zu zi zhi xian', 'ux100 ux97 ux111 ux122 ux104 ux101 ux110 ux121 ux105 ux108 ux117 ux109 ux120 ux36947 ux30495 ux20193 ux20332 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2517, 2509, '520326', '务川仡佬族苗族自治县', 3, '0852', '区', 100, 'wu chuan yi lao zu miao zu zi zhi xian', 'ux119 ux117 ux99 ux104 ux97 ux110 ux121 ux105 ux108 ux111 ux122 ux109 ux120 ux21153 ux24029 ux20193 ux20332 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2518, 2509, '520327', '凤冈县', 3, '0852', '区', 100, 'feng gang xian', 'ux102 ux101 ux110 ux103 ux97 ux120 ux105 ux20964 ux20872 ux21439', 0, 0),
(2519, 2509, '520328', '湄潭县', 3, '0852', '区', 100, 'mei tan xian', 'ux109 ux101 ux105 ux116 ux97 ux110 ux120 ux28228 ux28525 ux21439', 0, 0),
(2520, 2509, '520329', '余庆县', 3, '0852', '区', 100, 'yu qing xian', 'ux121 ux117 ux113 ux105 ux110 ux103 ux120 ux97 ux20313 ux24198 ux21439', 0, 0),
(2521, 2509, '520330', '习水县', 3, '0852', '区', 100, 'xi shui xian', 'ux120 ux105 ux115 ux104 ux117 ux97 ux110 ux20064 ux27700 ux21439', 0, 0),
(2522, 2509, '520381', '赤水市', 3, '0852', '区', 100, 'chi shui shi', 'ux99 ux104 ux105 ux115 ux117 ux36196 ux27700 ux24066', 0, 0),
(2523, 2509, '520382', '仁怀市', 3, '0852', '区', 100, 'ren huai shi', 'ux114 ux101 ux110 ux104 ux117 ux97 ux105 ux115 ux20161 ux24576 ux24066', 0, 0),
(2524, 2492, '520400', '安顺市', 2, '0853', '市', 100, 'an shun shi', 'ux97 ux110 ux115 ux104 ux117 ux105 ux23433 ux39034 ux24066', 0, 0),
(2525, 2524, '520402', '西秀区', 3, '0853', '区', 100, 'xi xiu qu', 'ux120 ux105 ux117 ux113 ux35199 ux31168 ux21306', 0, 0),
(2526, 2524, '520421', '平坝县', 3, '0853', '区', 100, 'ping ba xian', 'ux112 ux105 ux110 ux103 ux98 ux97 ux120 ux24179 ux22365 ux21439', 0, 0),
(2527, 2524, '520422', '普定县', 3, '0853', '区', 100, 'pu ding xian', 'ux112 ux117 ux100 ux105 ux110 ux103 ux120 ux97 ux26222 ux23450 ux21439', 0, 0),
(2528, 2524, '520423', '镇宁布依族苗族自治县', 3, '0853', '区', 100, 'zhen ning bu yi zu miao zu zi zhi xian', 'ux122 ux104 ux101 ux110 ux105 ux103 ux98 ux117 ux121 ux109 ux97 ux111 ux120 ux38215 ux23425 ux24067 ux20381 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2529, 2524, '520424', '关岭布依族苗族自治县', 3, '0853', '区', 100, 'guan ling bu yi zu miao zu zi zhi xian', 'ux103 ux117 ux97 ux110 ux108 ux105 ux98 ux121 ux122 ux109 ux111 ux104 ux120 ux20851 ux23725 ux24067 ux20381 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2530, 2524, '520425', '紫云苗族布依族自治县', 3, '0853', '区', 100, 'zi yun miao zu bu yi zu zi zhi xian', 'ux122 ux105 ux121 ux117 ux110 ux109 ux97 ux111 ux98 ux104 ux120 ux32043 ux20113 ux33495 ux26063 ux24067 ux20381 ux33258 ux27835 ux21439', 0, 0),
(2531, 2492, '520500', '毕节市', 2, '0857', '市', 100, 'bi jie shi', 'ux98 ux105 ux106 ux101 ux115 ux104 ux27605 ux33410 ux24066', 0, 0),
(2532, 2531, '520501', '七星关区', 3, '0857', '区', 100, 'qi xing guan qu', 'ux113 ux105 ux120 ux110 ux103 ux117 ux97 ux19971 ux26143 ux20851 ux21306', 0, 0),
(2533, 2531, '520522', '大方县', 3, '0857', '区', 100, 'da fang xian', 'ux100 ux97 ux102 ux110 ux103 ux120 ux105 ux22823 ux26041 ux21439', 0, 0),
(2534, 2531, '520523', '黔西县', 3, '0857', '区', 100, 'qian xi xian', 'ux113 ux105 ux97 ux110 ux120 ux40660 ux35199 ux21439', 0, 0),
(2535, 2531, '520524', '金沙县', 3, '0857', '区', 100, 'jin sha xian', 'ux106 ux105 ux110 ux115 ux104 ux97 ux120 ux37329 ux27801 ux21439', 0, 0),
(2536, 2531, '520525', '织金县', 3, '0857', '区', 100, 'zhi jin xian', 'ux122 ux104 ux105 ux106 ux110 ux120 ux97 ux32455 ux37329 ux21439', 0, 0),
(2537, 2531, '520526', '纳雍县', 3, '0857', '区', 100, 'na yong xian', 'ux110 ux97 ux121 ux111 ux103 ux120 ux105 ux32435 ux38605 ux21439', 0, 0),
(2538, 2531, '520527', '威宁彝族回族苗族自治县', 3, '0857', '区', 100, 'wei ning yi zu hui zu miao zu zi zhi xian', 'ux119 ux101 ux105 ux110 ux103 ux121 ux122 ux117 ux104 ux109 ux97 ux111 ux120 ux23041 ux23425 ux24413 ux26063 ux22238 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2539, 2531, '520528', '赫章县', 3, '0857', '区', 100, 'he zhang xian', 'ux104 ux101 ux122 ux97 ux110 ux103 ux120 ux105 ux36203 ux31456 ux21439', 0, 0),
(2540, 2492, '520600', '铜仁市', 2, '0856', '市', 100, 'tong ren shi', 'ux116 ux111 ux110 ux103 ux114 ux101 ux115 ux104 ux105 ux38108 ux20161 ux24066', 0, 0),
(2541, 2540, '520601', '碧江区', 3, '0856', '区', 100, 'bi jiang qu', 'ux98 ux105 ux106 ux97 ux110 ux103 ux113 ux117 ux30887 ux27743 ux21306', 0, 0),
(2542, 2540, '520602', '万山区', 3, '0856', '区', 100, 'wan shan qu', 'ux119 ux97 ux110 ux115 ux104 ux113 ux117 ux19975 ux23665 ux21306', 0, 0),
(2543, 2540, '520622', '江口县', 3, '0856', '区', 100, 'jiang kou xian', 'ux106 ux105 ux97 ux110 ux103 ux107 ux111 ux117 ux120 ux27743 ux21475 ux21439', 0, 0),
(2544, 2540, '520623', '玉屏侗族自治县', 3, '0856', '区', 100, 'yu ping dong zu zi zhi xian', 'ux121 ux117 ux112 ux105 ux110 ux103 ux100 ux111 ux122 ux104 ux120 ux97 ux29577 ux23631 ux20375 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2545, 2540, '520624', '石阡县', 3, '0856', '区', 100, 'shi qian xian', 'ux115 ux104 ux105 ux113 ux97 ux110 ux120 ux30707 ux38433 ux21439', 0, 0),
(2546, 2540, '520625', '思南县', 3, '0856', '区', 100, 'si nan xian', 'ux115 ux105 ux110 ux97 ux120 ux24605 ux21335 ux21439', 0, 0),
(2547, 2540, '520626', '印江土家族苗族自治县', 3, '0856', '区', 100, 'yin jiang tu jia zu miao zu zi zhi xian', 'ux121 ux105 ux110 ux106 ux97 ux103 ux116 ux117 ux122 ux109 ux111 ux104 ux120 ux21360 ux27743 ux22303 ux23478 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2548, 2540, '520627', '德江县', 3, '0856', '区', 100, 'de jiang xian', 'ux100 ux101 ux106 ux105 ux97 ux110 ux103 ux120 ux24503 ux27743 ux21439', 0, 0),
(2549, 2540, '520628', '沿河土家族自治县', 3, '0856', '区', 100, 'yan he tu jia zu zi zhi xian', 'ux121 ux97 ux110 ux104 ux101 ux116 ux117 ux106 ux105 ux122 ux120 ux27839 ux27827 ux22303 ux23478 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2550, 2540, '520629', '松桃苗族自治县', 3, '0856', '区', 100, 'song tao miao zu zi zhi xian', 'ux115 ux111 ux110 ux103 ux116 ux97 ux109 ux105 ux122 ux117 ux104 ux120 ux26494 ux26691 ux33495 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2551, 2492, '522300', '黔西南布依族苗族自治州', 2, '0859', '市', 100, 'qian xi nan bu yi zu miao zu zi zhi zhou', 'ux113 ux105 ux97 ux110 ux120 ux98 ux117 ux121 ux122 ux109 ux111 ux104 ux40660 ux35199 ux21335 ux24067 ux20381 ux26063 ux33495 ux33258 ux27835 ux24030', 0, 0),
(2552, 2551, '522301', '兴义市', 3, '0859', '区', 100, 'xing yi shi', 'ux120 ux105 ux110 ux103 ux121 ux115 ux104 ux20852 ux20041 ux24066', 0, 0),
(2553, 2551, '522322', '兴仁县', 3, '0859', '区', 100, 'xing ren xian', 'ux120 ux105 ux110 ux103 ux114 ux101 ux97 ux20852 ux20161 ux21439', 0, 0),
(2554, 2551, '522323', '普安县', 3, '0859', '区', 100, 'pu an xian', 'ux112 ux117 ux97 ux110 ux120 ux105 ux26222 ux23433 ux21439', 0, 0),
(2555, 2551, '522324', '晴隆县', 3, '0859', '区', 100, 'qing long xian', 'ux113 ux105 ux110 ux103 ux108 ux111 ux120 ux97 ux26228 ux38534 ux21439', 0, 0),
(2556, 2551, '522325', '贞丰县', 3, '0859', '区', 100, 'zhen feng xian', 'ux122 ux104 ux101 ux110 ux102 ux103 ux120 ux105 ux97 ux36126 ux20016 ux21439', 0, 0),
(2557, 2551, '522326', '望谟县', 3, '0859', '区', 100, 'wang mo xian', 'ux119 ux97 ux110 ux103 ux109 ux111 ux120 ux105 ux26395 ux35871 ux21439', 0, 0),
(2558, 2551, '522327', '册亨县', 3, '0859', '区', 100, 'ce heng xian', 'ux99 ux101 ux104 ux110 ux103 ux120 ux105 ux97 ux20876 ux20136 ux21439', 0, 0),
(2559, 2551, '522328', '安龙县', 3, '0859', '区', 100, 'an long xian', 'ux97 ux110 ux108 ux111 ux103 ux120 ux105 ux23433 ux40857 ux21439', 0, 0),
(2560, 2492, '522600', '黔东南苗族侗族自治州', 2, '0855', '市', 100, 'qian dong nan miao zu dong zu zi zhi zhou', 'ux113 ux105 ux97 ux110 ux100 ux111 ux103 ux109 ux122 ux117 ux104 ux40660 ux19996 ux21335 ux33495 ux26063 ux20375 ux33258 ux27835 ux24030', 0, 0),
(2561, 2560, '522601', '凯里市', 3, '0855', '区', 100, 'kai li shi', 'ux107 ux97 ux105 ux108 ux115 ux104 ux20975 ux37324 ux24066', 0, 0),
(2562, 2560, '522622', '黄平县', 3, '0855', '区', 100, 'huang ping xian', 'ux104 ux117 ux97 ux110 ux103 ux112 ux105 ux120 ux40644 ux24179 ux21439', 0, 0),
(2563, 2560, '522623', '施秉县', 3, '0855', '区', 100, 'shi bing xian', 'ux115 ux104 ux105 ux98 ux110 ux103 ux120 ux97 ux26045 ux31177 ux21439', 0, 0),
(2564, 2560, '522624', '三穗县', 3, '0855', '区', 100, 'san sui xian', 'ux115 ux97 ux110 ux117 ux105 ux120 ux19977 ux31319 ux21439', 0, 0),
(2565, 2560, '522625', '镇远县', 3, '0855', '区', 100, 'zhen yuan xian', 'ux122 ux104 ux101 ux110 ux121 ux117 ux97 ux120 ux105 ux38215 ux36828 ux21439', 0, 0),
(2566, 2560, '522626', '岑巩县', 3, '0855', '区', 100, 'cen gong xian', 'ux99 ux101 ux110 ux103 ux111 ux120 ux105 ux97 ux23697 ux24041 ux21439', 0, 0),
(2567, 2560, '522627', '天柱县', 3, '0855', '区', 100, 'tian zhu xian', 'ux116 ux105 ux97 ux110 ux122 ux104 ux117 ux120 ux22825 ux26609 ux21439', 0, 0),
(2568, 2560, '522628', '锦屏县', 3, '0855', '区', 100, 'jin ping xian', 'ux106 ux105 ux110 ux112 ux103 ux120 ux97 ux38182 ux23631 ux21439', 0, 0),
(2569, 2560, '522629', '剑河县', 3, '0855', '区', 100, 'jian he xian', 'ux106 ux105 ux97 ux110 ux104 ux101 ux120 ux21073 ux27827 ux21439', 0, 0),
(2570, 2560, '522630', '台江县', 3, '0855', '区', 100, 'tai jiang xian', 'ux116 ux97 ux105 ux106 ux110 ux103 ux120 ux21488 ux27743 ux21439', 0, 0),
(2571, 2560, '522631', '黎平县', 3, '0855', '区', 100, 'li ping xian', 'ux108 ux105 ux112 ux110 ux103 ux120 ux97 ux40654 ux24179 ux21439', 0, 0),
(2572, 2560, '522632', '榕江县', 3, '0855', '区', 100, 'rong jiang xian', 'ux114 ux111 ux110 ux103 ux106 ux105 ux97 ux120 ux27029 ux27743 ux21439', 0, 0),
(2573, 2560, '522633', '从江县', 3, '0855', '区', 100, 'cong jiang xian', 'ux99 ux111 ux110 ux103 ux106 ux105 ux97 ux120 ux20174 ux27743 ux21439', 0, 0),
(2574, 2560, '522634', '雷山县', 3, '0855', '区', 100, 'lei shan xian', 'ux108 ux101 ux105 ux115 ux104 ux97 ux110 ux120 ux38647 ux23665 ux21439', 0, 0),
(2575, 2560, '522635', '麻江县', 3, '0855', '区', 100, 'ma jiang xian', 'ux109 ux97 ux106 ux105 ux110 ux103 ux120 ux40635 ux27743 ux21439', 0, 0),
(2576, 2560, '522636', '丹寨县', 3, '0855', '区', 100, 'dan zhai xian', 'ux100 ux97 ux110 ux122 ux104 ux105 ux120 ux20025 ux23528 ux21439', 0, 0),
(2577, 2492, '522700', '黔南布依族苗族自治州', 2, '0854', '市', 100, 'qian nan bu yi zu miao zu zi zhi zhou', 'ux113 ux105 ux97 ux110 ux98 ux117 ux121 ux122 ux109 ux111 ux104 ux40660 ux21335 ux24067 ux20381 ux26063 ux33495 ux33258 ux27835 ux24030', 0, 0),
(2578, 2577, '522701', '都匀市', 3, '0854', '区', 100, 'du yun shi', 'ux100 ux117 ux121 ux110 ux115 ux104 ux105 ux37117 ux21248 ux24066', 0, 0),
(2579, 2577, '522702', '福泉市', 3, '0854', '区', 100, 'fu quan shi', 'ux102 ux117 ux113 ux97 ux110 ux115 ux104 ux105 ux31119 ux27849 ux24066', 0, 0),
(2580, 2577, '522722', '荔波县', 3, '0854', '区', 100, 'li bo xian', 'ux108 ux105 ux98 ux111 ux120 ux97 ux110 ux33620 ux27874 ux21439', 0, 0),
(2581, 2577, '522723', '贵定县', 3, '0854', '区', 100, 'gui ding xian', 'ux103 ux117 ux105 ux100 ux110 ux120 ux97 ux36149 ux23450 ux21439', 0, 0),
(2582, 2577, '522725', '瓮安县', 3, '0854', '区', 100, 'weng an xian', 'ux119 ux101 ux110 ux103 ux97 ux120 ux105 ux29934 ux23433 ux21439', 0, 0),
(2583, 2577, '522726', '独山县', 3, '0854', '区', 100, 'du shan xian', 'ux100 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux29420 ux23665 ux21439', 0, 0),
(2584, 2577, '522727', '平塘县', 3, '0854', '区', 100, 'ping tang xian', 'ux112 ux105 ux110 ux103 ux116 ux97 ux120 ux24179 ux22616 ux21439', 0, 0),
(2585, 2577, '522728', '罗甸县', 3, '0854', '区', 100, 'luo dian xian', 'ux108 ux117 ux111 ux100 ux105 ux97 ux110 ux120 ux32599 ux30008 ux21439', 0, 0),
(2586, 2577, '522729', '长顺县', 3, '0854', '区', 100, 'chang shun xian', 'ux99 ux104 ux97 ux110 ux103 ux115 ux117 ux120 ux105 ux38271 ux39034 ux21439', 0, 0),
(2587, 2577, '522730', '龙里县', 3, '0854', '区', 100, 'long li xian', 'ux108 ux111 ux110 ux103 ux105 ux120 ux97 ux40857 ux37324 ux21439', 0, 0),
(2588, 2577, '522731', '惠水县', 3, '0854', '区', 100, 'hui shui xian', 'ux104 ux117 ux105 ux115 ux120 ux97 ux110 ux24800 ux27700 ux21439', 0, 0),
(2589, 2577, '522732', '三都水族自治县', 3, '0854', '区', 100, 'san du shui zu zi zhi xian', 'ux115 ux97 ux110 ux100 ux117 ux104 ux105 ux122 ux120 ux19977 ux37117 ux27700 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2590, 0, '530000', '云南省', 1, '', '省', 100, 'yun nan sheng', 'ux121 ux117 ux110 ux97 ux115 ux104 ux101 ux103 ux20113 ux21335 ux30465', 0, 0),
(2591, 2590, '530100', '昆明市', 2, '0871', '市', 100, 'kun ming shi', 'ux107 ux117 ux110 ux109 ux105 ux103 ux115 ux104 ux26118 ux26126 ux24066', 0, 0),
(2592, 2591, '530102', '五华区', 3, '0871', '区', 100, 'wu hua qu', 'ux119 ux117 ux104 ux97 ux113 ux20116 ux21326 ux21306', 0, 0),
(2593, 2591, '530103', '盘龙区', 3, '0871', '区', 100, 'pan long qu', 'ux112 ux97 ux110 ux108 ux111 ux103 ux113 ux117 ux30424 ux40857 ux21306', 0, 0),
(2594, 2591, '530111', '官渡区', 3, '0871', '区', 100, 'guan du qu', 'ux103 ux117 ux97 ux110 ux100 ux113 ux23448 ux28193 ux21306', 0, 0),
(2595, 2591, '530112', '西山区', 3, '0871', '区', 100, 'xi shan qu', 'ux120 ux105 ux115 ux104 ux97 ux110 ux113 ux117 ux35199 ux23665 ux21306', 0, 0),
(2596, 2591, '530113', '东川区', 3, '0881', '区', 100, 'dong chuan qu', 'ux100 ux111 ux110 ux103 ux99 ux104 ux117 ux97 ux113 ux19996 ux24029 ux21306', 0, 0),
(2597, 2591, '530121', '呈贡区', 3, '0871', '区', 100, 'cheng gong qu', 'ux99 ux104 ux101 ux110 ux103 ux111 ux113 ux117 ux21576 ux36129 ux21306', 0, 0),
(2598, 2591, '530122', '晋宁县', 3, '0871', '区', 100, 'jin ning xian', 'ux106 ux105 ux110 ux103 ux120 ux97 ux26187 ux23425 ux21439', 0, 0),
(2599, 2591, '530124', '富民县', 3, '0871', '区', 100, 'fu min xian', 'ux102 ux117 ux109 ux105 ux110 ux120 ux97 ux23500 ux27665 ux21439', 0, 0),
(2600, 2591, '530125', '宜良县', 3, '0871', '区', 100, 'yi liang xian', 'ux121 ux105 ux108 ux97 ux110 ux103 ux120 ux23452 ux33391 ux21439', 0, 0),
(2601, 2591, '530126', '石林彝族自治县', 3, '0871', '区', 100, 'shi lin yi zu zi zhi xian', 'ux115 ux104 ux105 ux108 ux110 ux121 ux122 ux117 ux120 ux97 ux30707 ux26519 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2602, 2591, '530127', '嵩明县', 3, '0871', '区', 100, 'song ming xian', 'ux115 ux111 ux110 ux103 ux109 ux105 ux120 ux97 ux23913 ux26126 ux21439', 0, 0),
(2603, 2591, '530128', '禄劝彝族苗族自治县', 3, '0871', '区', 100, 'lu quan yi zu miao zu zi zhi xian', 'ux108 ux117 ux113 ux97 ux110 ux121 ux105 ux122 ux109 ux111 ux104 ux120 ux31108 ux21149 ux24413 ux26063 ux33495 ux33258 ux27835 ux21439', 0, 0),
(2604, 2591, '530129', '寻甸回族彝族自治县', 3, '0871', '区', 100, 'xun dian hui zu yi zu zi zhi xian', 'ux120 ux117 ux110 ux100 ux105 ux97 ux104 ux122 ux121 ux23547 ux30008 ux22238 ux26063 ux24413 ux33258 ux27835 ux21439', 0, 0),
(2605, 2591, '530181', '安宁市', 3, '0871', '区', 100, 'an ning shi', 'ux97 ux110 ux105 ux103 ux115 ux104 ux23433 ux23425 ux24066', 0, 0),
(2606, 2590, '530300', '曲靖市', 2, '0874', '市', 100, 'qu jing shi', 'ux113 ux117 ux106 ux105 ux110 ux103 ux115 ux104 ux26354 ux38742 ux24066', 0, 0),
(2607, 2606, '530302', '麒麟区', 3, '0874', '区', 100, 'qi lin qu', 'ux113 ux105 ux108 ux110 ux117 ux40594 ux40607 ux21306', 0, 0),
(2608, 2606, '530321', '马龙县', 3, '0874', '区', 100, 'ma long xian', 'ux109 ux97 ux108 ux111 ux110 ux103 ux120 ux105 ux39532 ux40857 ux21439', 0, 0),
(2609, 2606, '530322', '陆良县', 3, '0874', '区', 100, 'lu liang xian', 'ux108 ux117 ux105 ux97 ux110 ux103 ux120 ux38470 ux33391 ux21439', 0, 0),
(2610, 2606, '530323', '师宗县', 3, '0874', '区', 100, 'shi zong xian', 'ux115 ux104 ux105 ux122 ux111 ux110 ux103 ux120 ux97 ux24072 ux23447 ux21439', 0, 0),
(2611, 2606, '530324', '罗平县', 3, '0874', '区', 100, 'luo ping xian', 'ux108 ux117 ux111 ux112 ux105 ux110 ux103 ux120 ux97 ux32599 ux24179 ux21439', 0, 0),
(2612, 2606, '530325', '富源县', 3, '0874', '区', 100, 'fu yuan xian', 'ux102 ux117 ux121 ux97 ux110 ux120 ux105 ux23500 ux28304 ux21439', 0, 0),
(2613, 2606, '530326', '会泽县', 3, '0874', '区', 100, 'hui ze xian', 'ux104 ux117 ux105 ux122 ux101 ux120 ux97 ux110 ux20250 ux27901 ux21439', 0, 0),
(2614, 2606, '530328', '沾益县', 3, '0874', '区', 100, 'zhan yi xian', 'ux122 ux104 ux97 ux110 ux121 ux105 ux120 ux27838 ux30410 ux21439', 0, 0),
(2615, 2606, '530381', '宣威市', 3, '0874', '区', 100, 'xuan wei shi', 'ux120 ux117 ux97 ux110 ux119 ux101 ux105 ux115 ux104 ux23459 ux23041 ux24066', 0, 0),
(2616, 2590, '530400', '玉溪市', 2, '0877', '市', 100, 'yu xi shi', 'ux121 ux117 ux120 ux105 ux115 ux104 ux29577 ux28330 ux24066', 0, 0),
(2617, 2616, '530402', '红塔区', 3, '0877', '区', 100, 'hong ta qu', 'ux104 ux111 ux110 ux103 ux116 ux97 ux113 ux117 ux32418 ux22612 ux21306', 0, 0),
(2618, 2616, '530421', '江川县', 3, '0877', '区', 100, 'jiang chuan xian', 'ux106 ux105 ux97 ux110 ux103 ux99 ux104 ux117 ux120 ux27743 ux24029 ux21439', 0, 0),
(2619, 2616, '530422', '澄江县', 3, '0877', '区', 100, 'cheng jiang xian', 'ux99 ux104 ux101 ux110 ux103 ux106 ux105 ux97 ux120 ux28548 ux27743 ux21439', 0, 0),
(2620, 2616, '530423', '通海县', 3, '0877', '区', 100, 'tong hai xian', 'ux116 ux111 ux110 ux103 ux104 ux97 ux105 ux120 ux36890 ux28023 ux21439', 0, 0),
(2621, 2616, '530424', '华宁县', 3, '0877', '区', 100, 'hua ning xian', 'ux104 ux117 ux97 ux110 ux105 ux103 ux120 ux21326 ux23425 ux21439', 0, 0),
(2622, 2616, '530425', '易门县', 3, '0877', '区', 100, 'yi men xian', 'ux121 ux105 ux109 ux101 ux110 ux120 ux97 ux26131 ux38376 ux21439', 0, 0),
(2623, 2616, '530426', '峨山彝族自治县', 3, '0877', '区', 100, 'e shan yi zu zi zhi xian', 'ux101 ux115 ux104 ux97 ux110 ux121 ux105 ux122 ux117 ux120 ux23784 ux23665 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2624, 2616, '530427', '新平彝族傣族自治县', 3, '0877', '区', 100, 'xin ping yi zu dai zu zi zhi xian', 'ux120 ux105 ux110 ux112 ux103 ux121 ux122 ux117 ux100 ux97 ux104 ux26032 ux24179 ux24413 ux26063 ux20643 ux33258 ux27835 ux21439', 0, 0),
(2625, 2616, '530428', '元江哈尼族彝族傣族自治县', 3, '0877', '区', 100, 'yuan jiang ha ni zu yi zu dai zu zi zhi xian', 'ux121 ux117 ux97 ux110 ux106 ux105 ux103 ux104 ux122 ux100 ux120 ux20803 ux27743 ux21704 ux23612 ux26063 ux24413 ux20643 ux33258 ux27835 ux21439', 0, 0),
(2626, 2590, '530500', '保山市', 2, '0875', '市', 100, 'bao shan shi', 'ux98 ux97 ux111 ux115 ux104 ux110 ux105 ux20445 ux23665 ux24066', 0, 0),
(2627, 2626, '530502', '隆阳区', 3, '0875', '区', 100, 'long yang qu', 'ux108 ux111 ux110 ux103 ux121 ux97 ux113 ux117 ux38534 ux38451 ux21306', 0, 0),
(2628, 2626, '530521', '施甸县', 3, '0875', '区', 100, 'shi dian xian', 'ux115 ux104 ux105 ux100 ux97 ux110 ux120 ux26045 ux30008 ux21439', 0, 0),
(2629, 2626, '530522', '腾冲县', 3, '0875', '区', 100, 'teng chong xian', 'ux116 ux101 ux110 ux103 ux99 ux104 ux111 ux120 ux105 ux97 ux33150 ux20914 ux21439', 0, 0),
(2630, 2626, '530523', '龙陵县', 3, '0875', '区', 100, 'long ling xian', 'ux108 ux111 ux110 ux103 ux105 ux120 ux97 ux40857 ux38517 ux21439', 0, 0),
(2631, 2626, '530524', '昌宁县', 3, '0875', '区', 100, 'chang ning xian', 'ux99 ux104 ux97 ux110 ux103 ux105 ux120 ux26124 ux23425 ux21439', 0, 0),
(2632, 2590, '530600', '昭通市', 2, '0870', '市', 100, 'zhao tong shi', 'ux122 ux104 ux97 ux111 ux116 ux110 ux103 ux115 ux105 ux26157 ux36890 ux24066', 0, 0),
(2633, 2632, '530602', '昭阳区', 3, '0870', '区', 100, 'zhao yang qu', 'ux122 ux104 ux97 ux111 ux121 ux110 ux103 ux113 ux117 ux26157 ux38451 ux21306', 0, 0),
(2634, 2632, '530621', '鲁甸县', 3, '0870', '区', 100, 'lu dian xian', 'ux108 ux117 ux100 ux105 ux97 ux110 ux120 ux40065 ux30008 ux21439', 0, 0),
(2635, 2632, '530622', '巧家县', 3, '0870', '区', 100, 'qiao jia xian', 'ux113 ux105 ux97 ux111 ux106 ux120 ux110 ux24039 ux23478 ux21439', 0, 0),
(2636, 2632, '530623', '盐津县', 3, '0870', '区', 100, 'yan jin xian', 'ux121 ux97 ux110 ux106 ux105 ux120 ux30416 ux27941 ux21439', 0, 0),
(2637, 2632, '530624', '大关县', 3, '0870', '区', 100, 'da guan xian', 'ux100 ux97 ux103 ux117 ux110 ux120 ux105 ux22823 ux20851 ux21439', 0, 0),
(2638, 2632, '530625', '永善县', 3, '0870', '区', 100, 'yong shan xian', 'ux121 ux111 ux110 ux103 ux115 ux104 ux97 ux120 ux105 ux27704 ux21892 ux21439', 0, 0),
(2639, 2632, '530626', '绥江县', 3, '0870', '区', 100, 'sui jiang xian', 'ux115 ux117 ux105 ux106 ux97 ux110 ux103 ux120 ux32485 ux27743 ux21439', 0, 0),
(2640, 2632, '530627', '镇雄县', 3, '0870', '区', 100, 'zhen xiong xian', 'ux122 ux104 ux101 ux110 ux120 ux105 ux111 ux103 ux97 ux38215 ux38596 ux21439', 0, 0),
(2641, 2632, '530628', '彝良县', 3, '0870', '区', 100, 'yi liang xian', 'ux121 ux105 ux108 ux97 ux110 ux103 ux120 ux24413 ux33391 ux21439', 0, 0),
(2642, 2632, '530629', '威信县', 3, '0870', '区', 100, 'wei xin xian', 'ux119 ux101 ux105 ux120 ux110 ux97 ux23041 ux20449 ux21439', 0, 0),
(2643, 2632, '530630', '水富县', 3, '0870', '区', 100, 'shui fu xian', 'ux115 ux104 ux117 ux105 ux102 ux120 ux97 ux110 ux27700 ux23500 ux21439', 0, 0),
(2644, 2590, '530700', '丽江市', 2, '0888', '市', 100, 'li jiang shi', 'ux108 ux105 ux106 ux97 ux110 ux103 ux115 ux104 ux20029 ux27743 ux24066', 0, 0),
(2645, 2644, '530702', '古城区', 3, '0888', '区', 100, 'gu cheng qu', 'ux103 ux117 ux99 ux104 ux101 ux110 ux113 ux21476 ux22478 ux21306', 0, 0),
(2646, 2644, '530721', '玉龙纳西族自治县', 3, '0888', '区', 100, 'yu long na xi zu zi zhi xian', 'ux121 ux117 ux108 ux111 ux110 ux103 ux97 ux120 ux105 ux122 ux104 ux29577 ux40857 ux32435 ux35199 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2647, 2644, '530722', '永胜县', 3, '0888', '区', 100, 'yong sheng xian', 'ux121 ux111 ux110 ux103 ux115 ux104 ux101 ux120 ux105 ux97 ux27704 ux32988 ux21439', 0, 0),
(2648, 2644, '530723', '华坪县', 3, '0888', '区', 100, 'hua ping xian', 'ux104 ux117 ux97 ux112 ux105 ux110 ux103 ux120 ux21326 ux22378 ux21439', 0, 0),
(2649, 2644, '530724', '宁蒗彝族自治县', 3, '0888', '区', 100, 'ning lang yi zu zi zhi xian', 'ux110 ux105 ux103 ux108 ux97 ux121 ux122 ux117 ux104 ux120 ux23425 ux33943 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2650, 2590, '530800', '普洱市', 2, '0879', '市', 100, 'pu er shi', 'ux112 ux117 ux101 ux114 ux115 ux104 ux105 ux26222 ux27953 ux24066', 0, 0),
(2651, 2650, '530802', '思茅区', 3, '0879', '区', 100, 'si mao qu', 'ux115 ux105 ux109 ux97 ux111 ux113 ux117 ux24605 ux33541 ux21306', 0, 0),
(2652, 2650, '530821', '宁洱哈尼族彝族自治县', 3, '0879', '区', 100, 'ning er ha ni zu yi zu zi zhi xian', 'ux110 ux105 ux103 ux101 ux114 ux104 ux97 ux122 ux117 ux121 ux120 ux23425 ux27953 ux21704 ux23612 ux26063 ux24413 ux33258 ux27835 ux21439', 0, 0),
(2653, 2650, '530822', '墨江哈尼族自治县', 3, '0879', '区', 100, 'mo jiang ha ni zu zi zhi xian', 'ux109 ux111 ux106 ux105 ux97 ux110 ux103 ux104 ux122 ux117 ux120 ux22696 ux27743 ux21704 ux23612 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2654, 2650, '530823', '景东彝族自治县', 3, '0879', '区', 100, 'jing dong yi zu zi zhi xian', 'ux106 ux105 ux110 ux103 ux100 ux111 ux121 ux122 ux117 ux104 ux120 ux97 ux26223 ux19996 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2655, 2650, '530824', '景谷傣族彝族自治县', 3, '0879', '区', 100, 'jing gu dai zu yi zu zi zhi xian', 'ux106 ux105 ux110 ux103 ux117 ux100 ux97 ux122 ux121 ux104 ux120 ux26223 ux35895 ux20643 ux26063 ux24413 ux33258 ux27835 ux21439', 0, 0),
(2656, 2650, '530825', '镇沅彝族哈尼族拉祜族自治县', 3, '0879', '区', 100, 'zhen yuan yi zu ha ni zu la hu zu zi zhi xian', 'ux122 ux104 ux101 ux110 ux121 ux117 ux97 ux105 ux108 ux120 ux38215 ux27781 ux24413 ux26063 ux21704 ux23612 ux25289 ux31068 ux33258 ux27835 ux21439', 0, 0),
(2657, 2650, '530826', '江城哈尼族彝族自治县', 3, '0879', '区', 100, 'jiang cheng ha ni zu yi zu zi zhi xian', 'ux106 ux105 ux97 ux110 ux103 ux99 ux104 ux101 ux122 ux117 ux121 ux120 ux27743 ux22478 ux21704 ux23612 ux26063 ux24413 ux33258 ux27835 ux21439', 0, 0),
(2658, 2650, '530827', '孟连傣族拉祜族佤族自治县', 3, '0879', '区', 100, 'meng lian dai zu la hu zu wa zu zi zhi xian', 'ux109 ux101 ux110 ux103 ux108 ux105 ux97 ux100 ux122 ux117 ux104 ux119 ux120 ux23391 ux36830 ux20643 ux26063 ux25289 ux31068 ux20324 ux33258 ux27835 ux21439', 0, 0),
(2659, 2650, '530828', '澜沧拉祜族自治县', 3, '0879', '区', 100, 'lan cang la hu zu zi zhi xian', 'ux108 ux97 ux110 ux99 ux103 ux104 ux117 ux122 ux105 ux120 ux28572 ux27815 ux25289 ux31068 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2660, 2650, '530829', '西盟佤族自治县', 3, '0879', '区', 100, 'xi meng wa zu zi zhi xian', 'ux120 ux105 ux109 ux101 ux110 ux103 ux119 ux97 ux122 ux117 ux104 ux35199 ux30431 ux20324 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2661, 2590, '530900', '临沧市', 2, '0883', '市', 100, 'lin cang shi', 'ux108 ux105 ux110 ux99 ux97 ux103 ux115 ux104 ux20020 ux27815 ux24066', 0, 0),
(2662, 2661, '530902', '临翔区', 3, '0883', '区', 100, 'lin xiang qu', 'ux108 ux105 ux110 ux120 ux97 ux103 ux113 ux117 ux20020 ux32724 ux21306', 0, 0),
(2663, 2661, '530921', '凤庆县', 3, '0883', '区', 100, 'feng qing xian', 'ux102 ux101 ux110 ux103 ux113 ux105 ux120 ux97 ux20964 ux24198 ux21439', 0, 0),
(2664, 2661, '530922', '云县', 3, '0883', '区', 100, 'yun xian', 'ux121 ux117 ux110 ux120 ux105 ux97 ux20113 ux21439', 0, 0),
(2665, 2661, '530923', '永德县', 3, '0883', '区', 100, 'yong de xian', 'ux121 ux111 ux110 ux103 ux100 ux101 ux120 ux105 ux97 ux27704 ux24503 ux21439', 0, 0),
(2666, 2661, '530924', '镇康县', 3, '0883', '区', 100, 'zhen kang xian', 'ux122 ux104 ux101 ux110 ux107 ux97 ux103 ux120 ux105 ux38215 ux24247 ux21439', 0, 0),
(2667, 2661, '530925', '双江拉祜族佤族布朗族傣族自治县', 3, '0883', '区', 100, 'shuang jiang la hu zu wa zu bu lang zu dai zu zi zhi xian', 'ux115 ux104 ux117 ux97 ux110 ux103 ux106 ux105 ux108 ux122 ux119 ux98 ux100 ux120 ux21452 ux27743 ux25289 ux31068 ux26063 ux20324 ux24067 ux26391 ux20643 ux33258 ux27835 ux21439', 0, 0),
(2668, 2661, '530926', '耿马傣族佤族自治县', 3, '0883', '区', 100, 'geng ma dai zu wa zu zi zhi xian', 'ux103 ux101 ux110 ux109 ux97 ux100 ux105 ux122 ux117 ux119 ux104 ux120 ux32831 ux39532 ux20643 ux26063 ux20324 ux33258 ux27835 ux21439', 0, 0),
(2669, 2661, '530927', '沧源佤族自治县', 3, '0883', '区', 100, 'cang yuan wa zu zi zhi xian', 'ux99 ux97 ux110 ux103 ux121 ux117 ux119 ux122 ux105 ux104 ux120 ux27815 ux28304 ux20324 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2670, 2590, '532300', '楚雄彝族自治州', 2, '0878', '市', 100, 'chu xiong yi zu zi zhi zhou', 'ux99 ux104 ux117 ux120 ux105 ux111 ux110 ux103 ux121 ux122 ux26970 ux38596 ux24413 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2671, 2670, '532301', '楚雄市', 3, '0878', '区', 100, 'chu xiong shi', 'ux99 ux104 ux117 ux120 ux105 ux111 ux110 ux103 ux115 ux26970 ux38596 ux24066', 0, 0),
(2672, 2670, '532322', '双柏县', 3, '0878', '区', 100, 'shuang bai xian', 'ux115 ux104 ux117 ux97 ux110 ux103 ux98 ux105 ux120 ux21452 ux26575 ux21439', 0, 0),
(2673, 2670, '532323', '牟定县', 3, '0878', '区', 100, 'mou ding xian', 'ux109 ux111 ux117 ux100 ux105 ux110 ux103 ux120 ux97 ux29279 ux23450 ux21439', 0, 0),
(2674, 2670, '532324', '南华县', 3, '0878', '区', 100, 'nan hua xian', 'ux110 ux97 ux104 ux117 ux120 ux105 ux21335 ux21326 ux21439', 0, 0),
(2675, 2670, '532325', '姚安县', 3, '0878', '区', 100, 'yao an xian', 'ux121 ux97 ux111 ux110 ux120 ux105 ux23002 ux23433 ux21439', 0, 0),
(2676, 2670, '532326', '大姚县', 3, '0878', '区', 100, 'da yao xian', 'ux100 ux97 ux121 ux111 ux120 ux105 ux110 ux22823 ux23002 ux21439', 0, 0),
(2677, 2670, '532327', '永仁县', 3, '0878', '区', 100, 'yong ren xian', 'ux121 ux111 ux110 ux103 ux114 ux101 ux120 ux105 ux97 ux27704 ux20161 ux21439', 0, 0),
(2678, 2670, '532328', '元谋县', 3, '0878', '区', 100, 'yuan mou xian', 'ux121 ux117 ux97 ux110 ux109 ux111 ux120 ux105 ux20803 ux35851 ux21439', 0, 0),
(2679, 2670, '532329', '武定县', 3, '0878', '区', 100, 'wu ding xian', 'ux119 ux117 ux100 ux105 ux110 ux103 ux120 ux97 ux27494 ux23450 ux21439', 0, 0),
(2680, 2670, '532331', '禄丰县', 3, '0878', '区', 100, 'lu feng xian', 'ux108 ux117 ux102 ux101 ux110 ux103 ux120 ux105 ux97 ux31108 ux20016 ux21439', 0, 0),
(2681, 2590, '532500', '红河哈尼族彝族自治州', 2, '0873', '市', 100, 'hong he ha ni zu yi zu zi zhi zhou', 'ux104 ux111 ux110 ux103 ux101 ux97 ux105 ux122 ux117 ux121 ux32418 ux27827 ux21704 ux23612 ux26063 ux24413 ux33258 ux27835 ux24030', 0, 0),
(2682, 2681, '532501', '个旧市', 3, '0873', '区', 100, 'ge jiu shi', 'ux103 ux101 ux106 ux105 ux117 ux115 ux104 ux20010 ux26087 ux24066', 0, 0),
(2683, 2681, '532502', '开远市', 3, '0873', '区', 100, 'kai yuan shi', 'ux107 ux97 ux105 ux121 ux117 ux110 ux115 ux104 ux24320 ux36828 ux24066', 0, 0),
(2684, 2681, '532503', '蒙自市', 3, '0873', '区', 100, 'meng zi shi', 'ux109 ux101 ux110 ux103 ux122 ux105 ux115 ux104 ux33945 ux33258 ux24066', 0, 0),
(2685, 2681, '532523', '屏边苗族自治县', 3, '0873', '区', 100, 'ping bian miao zu zi zhi xian', 'ux112 ux105 ux110 ux103 ux98 ux97 ux109 ux111 ux122 ux117 ux104 ux120 ux23631 ux36793 ux33495 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2686, 2681, '532524', '建水县', 3, '0873', '区', 100, 'jian shui xian', 'ux106 ux105 ux97 ux110 ux115 ux104 ux117 ux120 ux24314 ux27700 ux21439', 0, 0),
(2687, 2681, '532525', '石屏县', 3, '0873', '区', 100, 'shi ping xian', 'ux115 ux104 ux105 ux112 ux110 ux103 ux120 ux97 ux30707 ux23631 ux21439', 0, 0),
(2688, 2681, '532526', '弥勒县', 3, '0873', '区', 100, 'mi le xian', 'ux109 ux105 ux108 ux101 ux120 ux97 ux110 ux24357 ux21202 ux21439', 0, 0),
(2689, 2681, '532527', '泸西县', 3, '0873', '区', 100, 'lu xi xian', 'ux108 ux117 ux120 ux105 ux97 ux110 ux27896 ux35199 ux21439', 0, 0),
(2690, 2681, '532528', '元阳县', 3, '0873', '区', 100, 'yuan yang xian', 'ux121 ux117 ux97 ux110 ux103 ux120 ux105 ux20803 ux38451 ux21439', 0, 0),
(2691, 2681, '532529', '红河县', 3, '0873', '区', 100, 'hong he xian', 'ux104 ux111 ux110 ux103 ux101 ux120 ux105 ux97 ux32418 ux27827 ux21439', 0, 0),
(2692, 2681, '532530', '金平苗族瑶族傣族自治县', 3, '0873', '区', 100, 'jin ping miao zu yao zu dai zu zi zhi xian', 'ux106 ux105 ux110 ux112 ux103 ux109 ux97 ux111 ux122 ux117 ux121 ux100 ux104 ux120 ux37329 ux24179 ux33495 ux26063 ux29814 ux20643 ux33258 ux27835 ux21439', 0, 0),
(2693, 2681, '532531', '绿春县', 3, '0873', '区', 100, 'lv chun xian', 'ux108 ux118 ux99 ux104 ux117 ux110 ux120 ux105 ux97 ux32511 ux26149 ux21439', 0, 0),
(2694, 2681, '532532', '河口瑶族自治县', 3, '0873', '区', 100, 'he kou yao zu zi zhi xian', 'ux104 ux101 ux107 ux111 ux117 ux121 ux97 ux122 ux105 ux120 ux110 ux27827 ux21475 ux29814 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2695, 2590, '532600', '文山壮族苗族自治州', 2, '0876', '市', 100, 'wen shan zhuang zu miao zu zi zhi zhou', 'ux119 ux101 ux110 ux115 ux104 ux97 ux122 ux117 ux103 ux109 ux105 ux111 ux25991 ux23665 ux22766 ux26063 ux33495 ux33258 ux27835 ux24030', 0, 0),
(2696, 2695, '532621', '文山市', 3, '0876', '区', 100, 'wen shan shi', 'ux119 ux101 ux110 ux115 ux104 ux97 ux105 ux25991 ux23665 ux24066', 0, 0),
(2697, 2695, '532622', '砚山县', 3, '0876', '区', 100, 'yan shan xian', 'ux121 ux97 ux110 ux115 ux104 ux120 ux105 ux30746 ux23665 ux21439', 0, 0),
(2698, 2695, '532623', '西畴县', 3, '0876', '区', 100, 'xi chou xian', 'ux120 ux105 ux99 ux104 ux111 ux117 ux97 ux110 ux35199 ux30068 ux21439', 0, 0),
(2699, 2695, '532624', '麻栗坡县', 3, '0876', '区', 100, 'ma li po xian', 'ux109 ux97 ux108 ux105 ux112 ux111 ux120 ux110 ux40635 ux26647 ux22369 ux21439', 0, 0),
(2700, 2695, '532625', '马关县', 3, '0876', '区', 100, 'ma guan xian', 'ux109 ux97 ux103 ux117 ux110 ux120 ux105 ux39532 ux20851 ux21439', 0, 0),
(2701, 2695, '532626', '丘北县', 3, '0876', '区', 100, 'qiu bei xian', 'ux113 ux105 ux117 ux98 ux101 ux120 ux97 ux110 ux19992 ux21271 ux21439', 0, 0),
(2702, 2695, '532627', '广南县', 3, '0876', '区', 100, 'guang nan xian', 'ux103 ux117 ux97 ux110 ux120 ux105 ux24191 ux21335 ux21439', 0, 0),
(2703, 2695, '532628', '富宁县', 3, '0876', '区', 100, 'fu ning xian', 'ux102 ux117 ux110 ux105 ux103 ux120 ux97 ux23500 ux23425 ux21439', 0, 0),
(2704, 2590, '532800', '西双版纳傣族自治州', 2, '0691', '市', 100, 'xi shuang ban na dai zu zi zhi zhou', 'ux120 ux105 ux115 ux104 ux117 ux97 ux110 ux103 ux98 ux100 ux122 ux111 ux35199 ux21452 ux29256 ux32435 ux20643 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2705, 2704, '532801', '景洪市', 3, '0691', '区', 100, 'jing hong shi', 'ux106 ux105 ux110 ux103 ux104 ux111 ux115 ux26223 ux27946 ux24066', 0, 0),
(2706, 2704, '532822', '勐海县', 3, '0691', '区', 100, 'meng hai xian', 'ux109 ux101 ux110 ux103 ux104 ux97 ux105 ux120 ux21200 ux28023 ux21439', 0, 0),
(2707, 2704, '532823', '勐腊县', 3, '0691', '区', 100, 'meng xi xian', 'ux109 ux101 ux110 ux103 ux120 ux105 ux97 ux21200 ux33098 ux21439', 0, 0),
(2708, 2590, '532900', '大理白族自治州', 2, '0872', '市', 100, 'da li bai zu zi zhi zhou', 'ux100 ux97 ux108 ux105 ux98 ux122 ux117 ux104 ux111 ux22823 ux29702 ux30333 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2709, 2708, '532901', '大理市', 3, '0872', '区', 100, 'da li shi', 'ux100 ux97 ux108 ux105 ux115 ux104 ux22823 ux29702 ux24066', 0, 0),
(2710, 2708, '532922', '漾濞彝族自治县', 3, '0872', '区', 100, 'yang bi yi zu zi zhi xian', 'ux121 ux97 ux110 ux103 ux98 ux105 ux122 ux117 ux104 ux120 ux28478 ux28638 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2711, 2708, '532923', '祥云县', 3, '0872', '区', 100, 'xiang yun xian', 'ux120 ux105 ux97 ux110 ux103 ux121 ux117 ux31077 ux20113 ux21439', 0, 0),
(2712, 2708, '532924', '宾川县', 3, '0872', '区', 100, 'bin chuan xian', 'ux98 ux105 ux110 ux99 ux104 ux117 ux97 ux120 ux23486 ux24029 ux21439', 0, 0),
(2713, 2708, '532925', '弥渡县', 3, '0872', '区', 100, 'mi du xian', 'ux109 ux105 ux100 ux117 ux120 ux97 ux110 ux24357 ux28193 ux21439', 0, 0),
(2714, 2708, '532926', '南涧彝族自治县', 3, '0872', '区', 100, 'nan jian yi zu zi zhi xian', 'ux110 ux97 ux106 ux105 ux121 ux122 ux117 ux104 ux120 ux21335 ux28071 ux24413 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2715, 2708, '532927', '巍山彝族回族自治县', 3, '0872', '区', 100, 'wei shan yi zu hui zu zi zhi xian', 'ux119 ux101 ux105 ux115 ux104 ux97 ux110 ux121 ux122 ux117 ux120 ux24013 ux23665 ux24413 ux26063 ux22238 ux33258 ux27835 ux21439', 0, 0),
(2716, 2708, '532928', '永平县', 3, '0872', '区', 100, 'yong ping xian', 'ux121 ux111 ux110 ux103 ux112 ux105 ux120 ux97 ux27704 ux24179 ux21439', 0, 0),
(2717, 2708, '532929', '云龙县', 3, '0872', '区', 100, 'yun long xian', 'ux121 ux117 ux110 ux108 ux111 ux103 ux120 ux105 ux97 ux20113 ux40857 ux21439', 0, 0),
(2718, 2708, '532930', '洱源县', 3, '0872', '区', 100, 'er yuan xian', 'ux101 ux114 ux121 ux117 ux97 ux110 ux120 ux105 ux27953 ux28304 ux21439', 0, 0),
(2719, 2708, '532931', '剑川县', 3, '0872', '区', 100, 'jian chuan xian', 'ux106 ux105 ux97 ux110 ux99 ux104 ux117 ux120 ux21073 ux24029 ux21439', 0, 0),
(2720, 2708, '532932', '鹤庆县', 3, '0872', '区', 100, 'he qing xian', 'ux104 ux101 ux113 ux105 ux110 ux103 ux120 ux97 ux40548 ux24198 ux21439', 0, 0),
(2721, 2590, '533100', '德宏傣族景颇族自治州', 2, '0692', '市', 100, 'de hong dai zu jing po zu zi zhi zhou', 'ux100 ux101 ux104 ux111 ux110 ux103 ux97 ux105 ux122 ux117 ux106 ux112 ux24503 ux23439 ux20643 ux26063 ux26223 ux39047 ux33258 ux27835 ux24030', 0, 0),
(2722, 2721, '533102', '瑞丽市', 3, '0692', '区', 100, 'rui li shi', 'ux114 ux117 ux105 ux108 ux115 ux104 ux29790 ux20029 ux24066', 0, 0),
(2723, 2721, '533103', '芒市', 3, '0692', '区', 100, 'mang shi', 'ux109 ux97 ux110 ux103 ux115 ux104 ux105 ux33426 ux24066', 0, 0),
(2724, 2721, '533122', '梁河县', 3, '0692', '区', 100, 'liang he xian', 'ux108 ux105 ux97 ux110 ux103 ux104 ux101 ux120 ux26753 ux27827 ux21439', 0, 0),
(2725, 2721, '533123', '盈江县', 3, '0692', '区', 100, 'ying jiang xian', 'ux121 ux105 ux110 ux103 ux106 ux97 ux120 ux30408 ux27743 ux21439', 0, 0),
(2726, 2721, '533124', '陇川县', 3, '0692', '区', 100, 'long chuan xian', 'ux108 ux111 ux110 ux103 ux99 ux104 ux117 ux97 ux120 ux105 ux38471 ux24029 ux21439', 0, 0),
(2727, 2590, '533300', '怒江傈僳族自治州', 2, '0886', '市', 100, 'nu jiang li su zu zi zhi zhou', 'ux110 ux117 ux106 ux105 ux97 ux103 ux108 ux115 ux122 ux104 ux111 ux24594 ux27743 ux20616 ux20723 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2728, 2727, '533321', '泸水县', 3, '0886', '区', 100, 'lu shui xian', 'ux108 ux117 ux115 ux104 ux105 ux120 ux97 ux110 ux27896 ux27700 ux21439', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(2729, 2727, '533323', '福贡县', 3, '0886', '区', 100, 'fu gong xian', 'ux102 ux117 ux103 ux111 ux110 ux120 ux105 ux97 ux31119 ux36129 ux21439', 0, 0),
(2730, 2727, '533324', '贡山独龙族怒族自治县', 3, '0886', '区', 100, 'gong shan du long zu nu zu zi zhi xian', 'ux103 ux111 ux110 ux115 ux104 ux97 ux100 ux117 ux108 ux122 ux105 ux120 ux36129 ux23665 ux29420 ux40857 ux26063 ux24594 ux33258 ux27835 ux21439', 0, 0),
(2731, 2727, '533325', '兰坪白族普米族自治县', 3, '0886', '区', 100, 'lan ping bai zu pu mi zu zi zhi xian', 'ux108 ux97 ux110 ux112 ux105 ux103 ux98 ux122 ux117 ux109 ux104 ux120 ux20848 ux22378 ux30333 ux26063 ux26222 ux31859 ux33258 ux27835 ux21439', 0, 0),
(2732, 2590, '533400', '迪庆藏族自治州', 2, '0887', '市', 100, 'di qing cang zu zi zhi zhou', 'ux100 ux105 ux113 ux110 ux103 ux99 ux97 ux122 ux117 ux104 ux111 ux36842 ux24198 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(2733, 2732, '533421', '香格里拉县', 3, '0887', '区', 100, 'xiang ge li la xian', 'ux120 ux105 ux97 ux110 ux103 ux101 ux108 ux39321 ux26684 ux37324 ux25289 ux21439', 0, 0),
(2734, 2732, '533422', '德钦县', 3, '0887', '区', 100, 'de qin xian', 'ux100 ux101 ux113 ux105 ux110 ux120 ux97 ux24503 ux38054 ux21439', 0, 0),
(2735, 2732, '533423', '维西傈僳族自治县', 3, '0887', '区', 100, 'wei xi li su zu zi zhi xian', 'ux119 ux101 ux105 ux120 ux108 ux115 ux117 ux122 ux104 ux97 ux110 ux32500 ux35199 ux20616 ux20723 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2736, 0, '540000', '西藏自治区', 1, '', '省', 100, 'xi cang zi zhi qu', 'ux120 ux105 ux99 ux97 ux110 ux103 ux122 ux104 ux113 ux117 ux35199 ux34255 ux33258 ux27835 ux21306', 0, 0),
(2737, 2736, '540100', '拉萨市', 2, '0891', '市', 100, 'la sa shi', 'ux108 ux97 ux115 ux104 ux105 ux25289 ux33832 ux24066', 0, 0),
(2738, 2737, '540102', '城关区', 3, '0891', '区', 100, 'cheng guan qu', 'ux99 ux104 ux101 ux110 ux103 ux117 ux97 ux113 ux22478 ux20851 ux21306', 0, 0),
(2739, 2737, '540121', '林周县', 3, '0891', '区', 100, 'lin zhou xian', 'ux108 ux105 ux110 ux122 ux104 ux111 ux117 ux120 ux97 ux26519 ux21608 ux21439', 0, 0),
(2740, 2737, '540122', '当雄县', 3, '0891', '区', 100, 'dang xiong xian', 'ux100 ux97 ux110 ux103 ux120 ux105 ux111 ux24403 ux38596 ux21439', 0, 0),
(2741, 2737, '540123', '尼木县', 3, '0891', '区', 100, 'ni mu xian', 'ux110 ux105 ux109 ux117 ux120 ux97 ux23612 ux26408 ux21439', 0, 0),
(2742, 2737, '540124', '曲水县', 3, '0891', '区', 100, 'qu shui xian', 'ux113 ux117 ux115 ux104 ux105 ux120 ux97 ux110 ux26354 ux27700 ux21439', 0, 0),
(2743, 2737, '540125', '堆龙德庆县', 3, '0891', '区', 100, 'dui long de qing xian', 'ux100 ux117 ux105 ux108 ux111 ux110 ux103 ux101 ux113 ux120 ux97 ux22534 ux40857 ux24503 ux24198 ux21439', 0, 0),
(2744, 2737, '540126', '达孜县', 3, '0891', '区', 100, 'da zi xian', 'ux100 ux97 ux122 ux105 ux120 ux110 ux36798 ux23388 ux21439', 0, 0),
(2745, 2737, '540127', '墨竹工卡县', 3, '0891', '区', 100, 'mo zhu gong qia xian', 'ux109 ux111 ux122 ux104 ux117 ux103 ux110 ux113 ux105 ux97 ux120 ux22696 ux31481 ux24037 ux21345 ux21439', 0, 0),
(2746, 2736, '542100', '昌都地区', 2, '0895', '市', 100, 'chang du di qu', 'ux99 ux104 ux97 ux110 ux103 ux100 ux117 ux105 ux113 ux26124 ux37117 ux22320 ux21306', 0, 0),
(2747, 2746, '542121', '昌都县', 3, '0895', '区', 100, 'chang du xian', 'ux99 ux104 ux97 ux110 ux103 ux100 ux117 ux120 ux105 ux26124 ux37117 ux21439', 0, 0),
(2748, 2746, '542122', '江达县', 3, '0895', '区', 100, 'jiang da xian', 'ux106 ux105 ux97 ux110 ux103 ux100 ux120 ux27743 ux36798 ux21439', 0, 0),
(2749, 2746, '542123', '贡觉县', 3, '0895', '区', 100, 'gong jue xian', 'ux103 ux111 ux110 ux106 ux117 ux101 ux120 ux105 ux97 ux36129 ux35273 ux21439', 0, 0),
(2750, 2746, '542124', '类乌齐县', 3, '0895', '区', 100, 'lei wu qi xian', 'ux108 ux101 ux105 ux119 ux117 ux113 ux120 ux97 ux110 ux31867 ux20044 ux40784 ux21439', 0, 0),
(2751, 2746, '542125', '丁青县', 3, '0895', '区', 100, 'ding qing xian', 'ux100 ux105 ux110 ux103 ux113 ux120 ux97 ux19969 ux38738 ux21439', 0, 0),
(2752, 2746, '542126', '察雅县', 3, '0895', '区', 100, 'cha ya xian', 'ux99 ux104 ux97 ux121 ux120 ux105 ux110 ux23519 ux38597 ux21439', 0, 0),
(2753, 2746, '542127', '八宿县', 3, '0895', '区', 100, 'ba su xian', 'ux98 ux97 ux115 ux117 ux120 ux105 ux110 ux20843 ux23487 ux21439', 0, 0),
(2754, 2746, '542128', '左贡县', 3, '0895', '区', 100, 'zuo gong xian', 'ux122 ux117 ux111 ux103 ux110 ux120 ux105 ux97 ux24038 ux36129 ux21439', 0, 0),
(2755, 2746, '542129', '芒康县', 3, '0895', '区', 100, 'mang kang xian', 'ux109 ux97 ux110 ux103 ux107 ux120 ux105 ux33426 ux24247 ux21439', 0, 0),
(2756, 2746, '542132', '洛隆县', 3, '0895', '区', 100, 'luo long xian', 'ux108 ux117 ux111 ux110 ux103 ux120 ux105 ux97 ux27931 ux38534 ux21439', 0, 0),
(2757, 2746, '542133', '边坝县', 3, '0895', '区', 100, 'bian ba xian', 'ux98 ux105 ux97 ux110 ux120 ux36793 ux22365 ux21439', 0, 0),
(2758, 2736, '542200', '山南地区', 2, '0893', '市', 100, 'shan nan di qu', 'ux115 ux104 ux97 ux110 ux100 ux105 ux113 ux117 ux23665 ux21335 ux22320 ux21306', 0, 0),
(2759, 2758, '542221', '乃东县', 3, '0893', '区', 100, 'nai dong xian', 'ux110 ux97 ux105 ux100 ux111 ux103 ux120 ux20035 ux19996 ux21439', 0, 0),
(2760, 2758, '542222', '扎囊县', 3, '0893', '区', 100, 'za nang xian', 'ux122 ux97 ux110 ux103 ux120 ux105 ux25166 ux22218 ux21439', 0, 0),
(2761, 2758, '542223', '贡嘎县', 3, '0893', '区', 100, 'gong ga xian', 'ux103 ux111 ux110 ux97 ux120 ux105 ux36129 ux22030 ux21439', 0, 0),
(2762, 2758, '542224', '桑日县', 3, '0893', '区', 100, 'sang ri xian', 'ux115 ux97 ux110 ux103 ux114 ux105 ux120 ux26705 ux26085 ux21439', 0, 0),
(2763, 2758, '542225', '琼结县', 3, '0893', '区', 100, 'qiong jie xian', 'ux113 ux105 ux111 ux110 ux103 ux106 ux101 ux120 ux97 ux29756 ux32467 ux21439', 0, 0),
(2764, 2758, '542226', '曲松县', 3, '0893', '区', 100, 'qu song xian', 'ux113 ux117 ux115 ux111 ux110 ux103 ux120 ux105 ux97 ux26354 ux26494 ux21439', 0, 0),
(2765, 2758, '542227', '措美县', 3, '0893', '区', 100, 'cuo mei xian', 'ux99 ux117 ux111 ux109 ux101 ux105 ux120 ux97 ux110 ux25514 ux32654 ux21439', 0, 0),
(2766, 2758, '542228', '洛扎县', 3, '0893', '区', 100, 'luo za xian', 'ux108 ux117 ux111 ux122 ux97 ux120 ux105 ux110 ux27931 ux25166 ux21439', 0, 0),
(2767, 2758, '542229', '加查县', 3, '0893', '区', 100, 'jia cha xian', 'ux106 ux105 ux97 ux99 ux104 ux120 ux110 ux21152 ux26597 ux21439', 0, 0),
(2768, 2758, '542231', '隆子县', 3, '0893', '区', 100, 'long zi xian', 'ux108 ux111 ux110 ux103 ux122 ux105 ux120 ux97 ux38534 ux23376 ux21439', 0, 0),
(2769, 2758, '542232', '错那县', 3, '0893', '区', 100, 'cuo na xian', 'ux99 ux117 ux111 ux110 ux97 ux120 ux105 ux38169 ux37027 ux21439', 0, 0),
(2770, 2758, '542233', '浪卡子县', 3, '0893', '区', 100, 'lang qia zi xian', 'ux108 ux97 ux110 ux103 ux113 ux105 ux122 ux120 ux28010 ux21345 ux23376 ux21439', 0, 0),
(2771, 2736, '542300', '日喀则地区', 2, '0892', '市', 100, 'ri ka ze di qu', 'ux114 ux105 ux107 ux97 ux122 ux101 ux100 ux113 ux117 ux26085 ux21888 ux21017 ux22320 ux21306', 0, 0),
(2772, 2771, '542301', '日喀则市', 3, '0892', '区', 100, 'ri ka ze shi', 'ux114 ux105 ux107 ux97 ux122 ux101 ux115 ux104 ux26085 ux21888 ux21017 ux24066', 0, 0),
(2773, 2771, '542322', '南木林县', 3, '0892', '区', 100, 'nan mu lin xian', 'ux110 ux97 ux109 ux117 ux108 ux105 ux120 ux21335 ux26408 ux26519 ux21439', 0, 0),
(2774, 2771, '542323', '江孜县', 3, '0892', '区', 100, 'jiang zi xian', 'ux106 ux105 ux97 ux110 ux103 ux122 ux120 ux27743 ux23388 ux21439', 0, 0),
(2775, 2771, '542324', '定日县', 3, '0892', '区', 100, 'ding ri xian', 'ux100 ux105 ux110 ux103 ux114 ux120 ux97 ux23450 ux26085 ux21439', 0, 0),
(2776, 2771, '542325', '萨迦县', 3, '0892', '区', 100, 'sa jia xian', 'ux115 ux97 ux106 ux105 ux120 ux110 ux33832 ux36838 ux21439', 0, 0),
(2777, 2771, '542326', '拉孜县', 3, '0892', '区', 100, 'la zi xian', 'ux108 ux97 ux122 ux105 ux120 ux110 ux25289 ux23388 ux21439', 0, 0),
(2778, 2771, '542327', '昂仁县', 3, '0892', '区', 100, 'ang ren xian', 'ux97 ux110 ux103 ux114 ux101 ux120 ux105 ux26114 ux20161 ux21439', 0, 0),
(2779, 2771, '542328', '谢通门县', 3, '0892', '区', 100, 'xie tong men xian', 'ux120 ux105 ux101 ux116 ux111 ux110 ux103 ux109 ux97 ux35874 ux36890 ux38376 ux21439', 0, 0),
(2780, 2771, '542329', '白朗县', 3, '0892', '区', 100, 'bai lang xian', 'ux98 ux97 ux105 ux108 ux110 ux103 ux120 ux30333 ux26391 ux21439', 0, 0),
(2781, 2771, '542330', '仁布县', 3, '0892', '区', 100, 'ren bu xian', 'ux114 ux101 ux110 ux98 ux117 ux120 ux105 ux97 ux20161 ux24067 ux21439', 0, 0),
(2782, 2771, '542331', '康马县', 3, '0892', '区', 100, 'kang ma xian', 'ux107 ux97 ux110 ux103 ux109 ux120 ux105 ux24247 ux39532 ux21439', 0, 0),
(2783, 2771, '542332', '定结县', 3, '0892', '区', 100, 'ding jie xian', 'ux100 ux105 ux110 ux103 ux106 ux101 ux120 ux97 ux23450 ux32467 ux21439', 0, 0),
(2784, 2771, '542333', '仲巴县', 3, '0892', '区', 100, 'zhong ba xian', 'ux122 ux104 ux111 ux110 ux103 ux98 ux97 ux120 ux105 ux20210 ux24052 ux21439', 0, 0),
(2785, 2771, '542334', '亚东县', 3, '0892', '区', 100, 'ya dong xian', 'ux121 ux97 ux100 ux111 ux110 ux103 ux120 ux105 ux20122 ux19996 ux21439', 0, 0),
(2786, 2771, '542335', '吉隆县', 3, '0892', '区', 100, 'ji long xian', 'ux106 ux105 ux108 ux111 ux110 ux103 ux120 ux97 ux21513 ux38534 ux21439', 0, 0),
(2787, 2771, '542336', '聂拉木县', 3, '0892', '区', 100, 'nie la mu xian', 'ux110 ux105 ux101 ux108 ux97 ux109 ux117 ux120 ux32834 ux25289 ux26408 ux21439', 0, 0),
(2788, 2771, '542337', '萨嘎县', 3, '0892', '区', 100, 'sa ga xian', 'ux115 ux97 ux103 ux120 ux105 ux110 ux33832 ux22030 ux21439', 0, 0),
(2789, 2771, '542338', '岗巴县', 3, '0892', '区', 100, 'gang ba xian', 'ux103 ux97 ux110 ux98 ux120 ux105 ux23703 ux24052 ux21439', 0, 0),
(2790, 2736, '542400', '那曲地区', 2, '0896', '市', 100, 'na qu di qu', 'ux110 ux97 ux113 ux117 ux100 ux105 ux37027 ux26354 ux22320 ux21306', 0, 0),
(2791, 2790, '542421', '那曲县', 3, '0896', '区', 100, 'na qu xian', 'ux110 ux97 ux113 ux117 ux120 ux105 ux37027 ux26354 ux21439', 0, 0),
(2792, 2790, '542422', '嘉黎县', 3, '0896', '区', 100, 'jia li xian', 'ux106 ux105 ux97 ux108 ux120 ux110 ux22025 ux40654 ux21439', 0, 0),
(2793, 2790, '542423', '比如县', 3, '0896', '区', 100, 'bi ru xian', 'ux98 ux105 ux114 ux117 ux120 ux97 ux110 ux27604 ux22914 ux21439', 0, 0),
(2794, 2790, '542424', '聂荣县', 3, '0896', '区', 100, 'nie rong xian', 'ux110 ux105 ux101 ux114 ux111 ux103 ux120 ux97 ux32834 ux33635 ux21439', 0, 0),
(2795, 2790, '542425', '安多县', 3, '0896', '区', 100, 'an duo xian', 'ux97 ux110 ux100 ux117 ux111 ux120 ux105 ux23433 ux22810 ux21439', 0, 0),
(2796, 2790, '542426', '申扎县', 3, '0896', '区', 100, 'shen za xian', 'ux115 ux104 ux101 ux110 ux122 ux97 ux120 ux105 ux30003 ux25166 ux21439', 0, 0),
(2797, 2790, '542427', '索县', 3, '0896', '区', 100, 'suo xian', 'ux115 ux117 ux111 ux120 ux105 ux97 ux110 ux32034 ux21439', 0, 0),
(2798, 2790, '542428', '班戈县', 3, '0896', '区', 100, 'ban ge xian', 'ux98 ux97 ux110 ux103 ux101 ux120 ux105 ux29677 ux25096 ux21439', 0, 0),
(2799, 2790, '542429', '巴青县', 3, '0896', '区', 100, 'ba qing xian', 'ux98 ux97 ux113 ux105 ux110 ux103 ux120 ux24052 ux38738 ux21439', 0, 0),
(2800, 2790, '542430', '尼玛县', 3, '0896', '区', 100, 'ni ma xian', 'ux110 ux105 ux109 ux97 ux120 ux23612 ux29595 ux21439', 0, 0),
(2801, 2736, '542500', '阿里地区', 2, '0897', '市', 100, 'a li di qu', 'ux97 ux108 ux105 ux100 ux113 ux117 ux38463 ux37324 ux22320 ux21306', 0, 0),
(2802, 2801, '542521', '普兰县', 3, '0897', '区', 100, 'pu lan xian', 'ux112 ux117 ux108 ux97 ux110 ux120 ux105 ux26222 ux20848 ux21439', 0, 0),
(2803, 2801, '542522', '札达县', 3, '0897', '区', 100, 'zha da xian', 'ux122 ux104 ux97 ux100 ux120 ux105 ux110 ux26413 ux36798 ux21439', 0, 0),
(2804, 2801, '542523', '噶尔县', 3, '0897', '区', 100, 'ga er xian', 'ux103 ux97 ux101 ux114 ux120 ux105 ux110 ux22134 ux23572 ux21439', 0, 0),
(2805, 2801, '542524', '日土县', 3, '0897', '区', 100, 'ri tu xian', 'ux114 ux105 ux116 ux117 ux120 ux97 ux110 ux26085 ux22303 ux21439', 0, 0),
(2806, 2801, '542525', '革吉县', 3, '0897', '区', 100, 'ge ji xian', 'ux103 ux101 ux106 ux105 ux120 ux97 ux110 ux38761 ux21513 ux21439', 0, 0),
(2807, 2801, '542526', '改则县', 3, '0897', '区', 100, 'gai ze xian', 'ux103 ux97 ux105 ux122 ux101 ux120 ux110 ux25913 ux21017 ux21439', 0, 0),
(2808, 2801, '542527', '措勤县', 3, '0897', '区', 100, 'cuo qin xian', 'ux99 ux117 ux111 ux113 ux105 ux110 ux120 ux97 ux25514 ux21220 ux21439', 0, 0),
(2809, 2736, '542600', '林芝地区', 2, '0894', '市', 100, 'lin zhi di qu', 'ux108 ux105 ux110 ux122 ux104 ux100 ux113 ux117 ux26519 ux33437 ux22320 ux21306', 0, 0),
(2810, 2809, '542621', '林芝县', 3, '0894', '区', 100, 'lin zhi xian', 'ux108 ux105 ux110 ux122 ux104 ux120 ux97 ux26519 ux33437 ux21439', 0, 0),
(2811, 2809, '542622', '工布江达县', 3, '0894', '区', 100, 'gong bu jiang da xian', 'ux103 ux111 ux110 ux98 ux117 ux106 ux105 ux97 ux100 ux120 ux24037 ux24067 ux27743 ux36798 ux21439', 0, 0),
(2812, 2809, '542623', '米林县', 3, '0894', '区', 100, 'mi lin xian', 'ux109 ux105 ux108 ux110 ux120 ux97 ux31859 ux26519 ux21439', 0, 0),
(2813, 2809, '542624', '墨脱县', 3, '0894', '区', 100, 'mo tuo xian', 'ux109 ux111 ux116 ux117 ux120 ux105 ux97 ux110 ux22696 ux33073 ux21439', 0, 0),
(2814, 2809, '542625', '波密县', 3, '0894', '区', 100, 'bo mi xian', 'ux98 ux111 ux109 ux105 ux120 ux97 ux110 ux27874 ux23494 ux21439', 0, 0),
(2815, 2809, '542626', '察隅县', 3, '0894', '区', 100, 'cha yu xian', 'ux99 ux104 ux97 ux121 ux117 ux120 ux105 ux110 ux23519 ux38533 ux21439', 0, 0),
(2816, 2809, '542627', '朗县', 3, '0894', '区', 100, 'lang xian', 'ux108 ux97 ux110 ux103 ux120 ux105 ux26391 ux21439', 0, 0),
(2817, 0, '610000', '陕西省', 1, '', '省', 100, 'shan xi sheng', 'ux115 ux104 ux97 ux110 ux120 ux105 ux101 ux103 ux38485 ux35199 ux30465', 0, 0),
(2818, 2817, '610100', '西安市', 2, '029', '市', 100, 'xi an shi', 'ux120 ux105 ux97 ux110 ux115 ux104 ux35199 ux23433 ux24066', 0, 0),
(2819, 2818, '610102', '新城区', 3, '029', '区', 100, 'xin cheng qu', 'ux120 ux105 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux26032 ux22478 ux21306', 0, 0),
(2820, 2818, '610103', '碑林区', 3, '029', '区', 100, 'bei lin qu', 'ux98 ux101 ux105 ux108 ux110 ux113 ux117 ux30865 ux26519 ux21306', 0, 0),
(2821, 2818, '610104', '莲湖区', 3, '029', '区', 100, 'lian hu qu', 'ux108 ux105 ux97 ux110 ux104 ux117 ux113 ux33714 ux28246 ux21306', 0, 0),
(2822, 2818, '610111', '灞桥区', 3, '029', '区', 100, 'ba qiao qu', 'ux98 ux97 ux113 ux105 ux111 ux117 ux28766 ux26725 ux21306', 0, 0),
(2823, 2818, '610112', '未央区', 3, '029', '区', 100, 'wei yang qu', 'ux119 ux101 ux105 ux121 ux97 ux110 ux103 ux113 ux117 ux26410 ux22830 ux21306', 0, 0),
(2824, 2818, '610113', '雁塔区', 3, '029', '区', 100, 'yan ta qu', 'ux121 ux97 ux110 ux116 ux113 ux117 ux38593 ux22612 ux21306', 0, 0),
(2825, 2818, '610114', '阎良区', 3, '029', '区', 100, 'yan liang qu', 'ux121 ux97 ux110 ux108 ux105 ux103 ux113 ux117 ux38414 ux33391 ux21306', 0, 0),
(2826, 2818, '610115', '临潼区', 3, '029', '区', 100, 'lin tong qu', 'ux108 ux105 ux110 ux116 ux111 ux103 ux113 ux117 ux20020 ux28540 ux21306', 0, 0),
(2827, 2818, '610116', '长安区', 3, '029', '区', 100, 'chang an qu', 'ux99 ux104 ux97 ux110 ux103 ux113 ux117 ux38271 ux23433 ux21306', 0, 0),
(2828, 2818, '610122', '蓝田县', 3, '029', '区', 100, 'lan tian xian', 'ux108 ux97 ux110 ux116 ux105 ux120 ux34013 ux30000 ux21439', 0, 0),
(2829, 2818, '610124', '周至县', 3, '029', '区', 100, 'zhou zhi xian', 'ux122 ux104 ux111 ux117 ux105 ux120 ux97 ux110 ux21608 ux33267 ux21439', 0, 0),
(2830, 2818, '610125', '户县', 3, '029', '区', 100, 'hu xian', 'ux104 ux117 ux120 ux105 ux97 ux110 ux25143 ux21439', 0, 0),
(2831, 2818, '610126', '高陵县', 3, '029', '区', 100, 'gao ling xian', 'ux103 ux97 ux111 ux108 ux105 ux110 ux120 ux39640 ux38517 ux21439', 0, 0),
(2832, 2817, '610200', '铜川市', 2, '0919', '市', 100, 'tong chuan shi', 'ux116 ux111 ux110 ux103 ux99 ux104 ux117 ux97 ux115 ux105 ux38108 ux24029 ux24066', 0, 0),
(2833, 2832, '610202', '王益区', 3, '0919', '区', 100, 'wang yi qu', 'ux119 ux97 ux110 ux103 ux121 ux105 ux113 ux117 ux29579 ux30410 ux21306', 0, 0),
(2834, 2832, '610203', '印台区', 3, '0919', '区', 100, 'yin tai qu', 'ux121 ux105 ux110 ux116 ux97 ux113 ux117 ux21360 ux21488 ux21306', 0, 0),
(2835, 2832, '610204', '耀州区', 3, '0919', '区', 100, 'yao zhou qu', 'ux121 ux97 ux111 ux122 ux104 ux117 ux113 ux32768 ux24030 ux21306', 0, 0),
(2836, 2832, '610222', '宜君县', 3, '0919', '区', 100, 'yi jun xian', 'ux121 ux105 ux106 ux117 ux110 ux120 ux97 ux23452 ux21531 ux21439', 0, 0),
(2837, 2817, '610300', '宝鸡市', 2, '0917', '市', 100, 'bao ji shi', 'ux98 ux97 ux111 ux106 ux105 ux115 ux104 ux23453 ux40481 ux24066', 0, 0),
(2838, 2837, '610302', '渭滨区', 3, '0917', '区', 100, 'wei bin qu', 'ux119 ux101 ux105 ux98 ux110 ux113 ux117 ux28205 ux28392 ux21306', 0, 0),
(2839, 2837, '610303', '金台区', 3, '0917', '区', 100, 'jin tai qu', 'ux106 ux105 ux110 ux116 ux97 ux113 ux117 ux37329 ux21488 ux21306', 0, 0),
(2840, 2837, '610304', '陈仓区', 3, '0917', '区', 100, 'chen cang qu', 'ux99 ux104 ux101 ux110 ux97 ux103 ux113 ux117 ux38472 ux20179 ux21306', 0, 0),
(2841, 2837, '610322', '凤翔县', 3, '0917', '区', 100, 'feng xiang xian', 'ux102 ux101 ux110 ux103 ux120 ux105 ux97 ux20964 ux32724 ux21439', 0, 0),
(2842, 2837, '610323', '岐山县', 3, '0917', '区', 100, 'qi shan xian', 'ux113 ux105 ux115 ux104 ux97 ux110 ux120 ux23696 ux23665 ux21439', 0, 0),
(2843, 2837, '610324', '扶风县', 3, '0917', '区', 100, 'fu feng xian', 'ux102 ux117 ux101 ux110 ux103 ux120 ux105 ux97 ux25206 ux39118 ux21439', 0, 0),
(2844, 2837, '610326', '眉县', 3, '0917', '区', 100, 'mei xian', 'ux109 ux101 ux105 ux120 ux97 ux110 ux30473 ux21439', 0, 0),
(2845, 2837, '610327', '陇县', 3, '0917', '区', 100, 'long xian', 'ux108 ux111 ux110 ux103 ux120 ux105 ux97 ux38471 ux21439', 0, 0),
(2846, 2837, '610328', '千阳县', 3, '0917', '区', 100, 'qian yang xian', 'ux113 ux105 ux97 ux110 ux121 ux103 ux120 ux21315 ux38451 ux21439', 0, 0),
(2847, 2837, '610329', '麟游县', 3, '0917', '区', 100, 'lin you xian', 'ux108 ux105 ux110 ux121 ux111 ux117 ux120 ux97 ux40607 ux28216 ux21439', 0, 0),
(2848, 2837, '610330', '凤县', 3, '0917', '区', 100, 'feng xian', 'ux102 ux101 ux110 ux103 ux120 ux105 ux97 ux20964 ux21439', 0, 0),
(2849, 2837, '610331', '太白县', 3, '0917', '区', 100, 'tai bai xian', 'ux116 ux97 ux105 ux98 ux120 ux110 ux22826 ux30333 ux21439', 0, 0),
(2850, 2817, '610400', '咸阳市', 2, '0910', '市', 100, 'xian yang shi', 'ux120 ux105 ux97 ux110 ux121 ux103 ux115 ux104 ux21688 ux38451 ux24066', 0, 0),
(2851, 2850, '610402', '秦都区', 3, '0910', '区', 100, 'qin du qu', 'ux113 ux105 ux110 ux100 ux117 ux31206 ux37117 ux21306', 0, 0),
(2852, 2850, '610403', '杨陵区', 3, '0910', '区', 100, 'yang ling qu', 'ux121 ux97 ux110 ux103 ux108 ux105 ux113 ux117 ux26472 ux38517 ux21306', 0, 0),
(2853, 2850, '610404', '渭城区', 3, '0910', '区', 100, 'wei cheng qu', 'ux119 ux101 ux105 ux99 ux104 ux110 ux103 ux113 ux117 ux28205 ux22478 ux21306', 0, 0),
(2854, 2850, '610422', '三原县', 3, '0910', '区', 100, 'san yuan xian', 'ux115 ux97 ux110 ux121 ux117 ux120 ux105 ux19977 ux21407 ux21439', 0, 0),
(2855, 2850, '610423', '泾阳县', 3, '0910', '区', 100, 'jing yang xian', 'ux106 ux105 ux110 ux103 ux121 ux97 ux120 ux27902 ux38451 ux21439', 0, 0),
(2856, 2850, '610424', '乾县', 3, '0910', '区', 100, 'qian xian', 'ux113 ux105 ux97 ux110 ux120 ux20094 ux21439', 0, 0),
(2857, 2850, '610425', '礼泉县', 3, '0910', '区', 100, 'li quan xian', 'ux108 ux105 ux113 ux117 ux97 ux110 ux120 ux31036 ux27849 ux21439', 0, 0),
(2858, 2850, '610426', '永寿县', 3, '0910', '区', 100, 'yong shou xian', 'ux121 ux111 ux110 ux103 ux115 ux104 ux117 ux120 ux105 ux97 ux27704 ux23551 ux21439', 0, 0),
(2859, 2850, '610427', '彬县', 3, '0910', '区', 100, 'bin xian', 'ux98 ux105 ux110 ux120 ux97 ux24428 ux21439', 0, 0),
(2860, 2850, '610428', '长武县', 3, '0910', '区', 100, 'chang wu xian', 'ux99 ux104 ux97 ux110 ux103 ux119 ux117 ux120 ux105 ux38271 ux27494 ux21439', 0, 0),
(2861, 2850, '610429', '旬邑县', 3, '0910', '区', 100, 'xun yi xian', 'ux120 ux117 ux110 ux121 ux105 ux97 ux26092 ux37009 ux21439', 0, 0),
(2862, 2850, '610430', '淳化县', 3, '0910', '区', 100, 'chun hua xian', 'ux99 ux104 ux117 ux110 ux97 ux120 ux105 ux28147 ux21270 ux21439', 0, 0),
(2863, 2850, '610431', '武功县', 3, '0910', '区', 100, 'wu gong xian', 'ux119 ux117 ux103 ux111 ux110 ux120 ux105 ux97 ux27494 ux21151 ux21439', 0, 0),
(2864, 2850, '610481', '兴平市', 3, '0910', '区', 100, 'xing ping shi', 'ux120 ux105 ux110 ux103 ux112 ux115 ux104 ux20852 ux24179 ux24066', 0, 0),
(2865, 2817, '610500', '渭南市', 2, '0913', '市', 100, 'wei nan shi', 'ux119 ux101 ux105 ux110 ux97 ux115 ux104 ux28205 ux21335 ux24066', 0, 0),
(2866, 2865, '610502', '临渭区', 3, '0913', '区', 100, 'lin wei qu', 'ux108 ux105 ux110 ux119 ux101 ux113 ux117 ux20020 ux28205 ux21306', 0, 0),
(2867, 2865, '610521', '华县', 3, '0913', '区', 100, 'hua xian', 'ux104 ux117 ux97 ux120 ux105 ux110 ux21326 ux21439', 0, 0),
(2868, 2865, '610522', '潼关县', 3, '0913', '区', 100, 'tong guan xian', 'ux116 ux111 ux110 ux103 ux117 ux97 ux120 ux105 ux28540 ux20851 ux21439', 0, 0),
(2869, 2865, '610523', '大荔县', 3, '0913', '区', 100, 'da li xian', 'ux100 ux97 ux108 ux105 ux120 ux110 ux22823 ux33620 ux21439', 0, 0),
(2870, 2865, '610524', '合阳县', 3, '0913', '区', 100, 'he yang xian', 'ux104 ux101 ux121 ux97 ux110 ux103 ux120 ux105 ux21512 ux38451 ux21439', 0, 0),
(2871, 2865, '610525', '澄城县', 3, '0913', '区', 100, 'cheng cheng xian', 'ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux28548 ux22478 ux21439', 0, 0),
(2872, 2865, '610526', '蒲城县', 3, '0913', '区', 100, 'pu cheng xian', 'ux112 ux117 ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux33970 ux22478 ux21439', 0, 0),
(2873, 2865, '610527', '白水县', 3, '0913', '区', 100, 'bai shui xian', 'ux98 ux97 ux105 ux115 ux104 ux117 ux120 ux110 ux30333 ux27700 ux21439', 0, 0),
(2874, 2865, '610528', '富平县', 3, '0913', '区', 100, 'fu ping xian', 'ux102 ux117 ux112 ux105 ux110 ux103 ux120 ux97 ux23500 ux24179 ux21439', 0, 0),
(2875, 2865, '610581', '韩城市', 3, '0913', '区', 100, 'han cheng shi', 'ux104 ux97 ux110 ux99 ux101 ux103 ux115 ux105 ux38889 ux22478 ux24066', 0, 0),
(2876, 2865, '610582', '华阴市', 3, '0913', '区', 100, 'hua yin shi', 'ux104 ux117 ux97 ux121 ux105 ux110 ux115 ux21326 ux38452 ux24066', 0, 0),
(2877, 2817, '610600', '延安市', 2, '0911', '市', 100, 'yan an shi', 'ux121 ux97 ux110 ux115 ux104 ux105 ux24310 ux23433 ux24066', 0, 0),
(2878, 2877, '610602', '宝塔区', 3, '0911', '区', 100, 'bao ta qu', 'ux98 ux97 ux111 ux116 ux113 ux117 ux23453 ux22612 ux21306', 0, 0),
(2879, 2877, '610621', '延长县', 3, '0911', '区', 100, 'yan chang xian', 'ux121 ux97 ux110 ux99 ux104 ux103 ux120 ux105 ux24310 ux38271 ux21439', 0, 0),
(2880, 2877, '610622', '延川县', 3, '0911', '区', 100, 'yan chuan xian', 'ux121 ux97 ux110 ux99 ux104 ux117 ux120 ux105 ux24310 ux24029 ux21439', 0, 0),
(2881, 2877, '610623', '子长县', 3, '0911', '区', 100, 'zi chang xian', 'ux122 ux105 ux99 ux104 ux97 ux110 ux103 ux120 ux23376 ux38271 ux21439', 0, 0),
(2882, 2877, '610624', '安塞县', 3, '0911', '区', 100, 'an sai xian', 'ux97 ux110 ux115 ux105 ux120 ux23433 ux22622 ux21439', 0, 0),
(2883, 2877, '610625', '志丹县', 3, '0911', '区', 100, 'zhi dan xian', 'ux122 ux104 ux105 ux100 ux97 ux110 ux120 ux24535 ux20025 ux21439', 0, 0),
(2884, 2877, '610626', '吴起县', 3, '0911', '区', 100, 'wu qi xian', 'ux119 ux117 ux113 ux105 ux120 ux97 ux110 ux21556 ux36215 ux21439', 0, 0),
(2885, 2877, '610627', '甘泉县', 3, '0911', '区', 100, 'gan quan xian', 'ux103 ux97 ux110 ux113 ux117 ux120 ux105 ux29976 ux27849 ux21439', 0, 0),
(2886, 2877, '610628', '富县', 3, '0911', '区', 100, 'fu xian', 'ux102 ux117 ux120 ux105 ux97 ux110 ux23500 ux21439', 0, 0),
(2887, 2877, '610629', '洛川县', 3, '0911', '区', 100, 'luo chuan xian', 'ux108 ux117 ux111 ux99 ux104 ux97 ux110 ux120 ux105 ux27931 ux24029 ux21439', 0, 0),
(2888, 2877, '610630', '宜川县', 3, '0911', '区', 100, 'yi chuan xian', 'ux121 ux105 ux99 ux104 ux117 ux97 ux110 ux120 ux23452 ux24029 ux21439', 0, 0),
(2889, 2877, '610631', '黄龙县', 3, '0911', '区', 100, 'huang long xian', 'ux104 ux117 ux97 ux110 ux103 ux108 ux111 ux120 ux105 ux40644 ux40857 ux21439', 0, 0),
(2890, 2877, '610632', '黄陵县', 3, '0911', '区', 100, 'huang ling xian', 'ux104 ux117 ux97 ux110 ux103 ux108 ux105 ux120 ux40644 ux38517 ux21439', 0, 0),
(2891, 2817, '610700', '汉中市', 2, '0916', '市', 100, 'han zhong shi', 'ux104 ux97 ux110 ux122 ux111 ux103 ux115 ux105 ux27721 ux20013 ux24066', 0, 0),
(2892, 2891, '610702', '汉台区', 3, '0916', '区', 100, 'han tai qu', 'ux104 ux97 ux110 ux116 ux105 ux113 ux117 ux27721 ux21488 ux21306', 0, 0),
(2893, 2891, '610721', '南郑县', 3, '0916', '区', 100, 'nan zheng xian', 'ux110 ux97 ux122 ux104 ux101 ux103 ux120 ux105 ux21335 ux37073 ux21439', 0, 0),
(2894, 2891, '610722', '城固县', 3, '0916', '区', 100, 'cheng gu xian', 'ux99 ux104 ux101 ux110 ux103 ux117 ux120 ux105 ux97 ux22478 ux22266 ux21439', 0, 0),
(2895, 2891, '610723', '洋县', 3, '0916', '区', 100, 'yang xian', 'ux121 ux97 ux110 ux103 ux120 ux105 ux27915 ux21439', 0, 0),
(2896, 2891, '610724', '西乡县', 3, '0916', '区', 100, 'xi xiang xian', 'ux120 ux105 ux97 ux110 ux103 ux35199 ux20065 ux21439', 0, 0),
(2897, 2891, '610725', '勉县', 3, '0916', '区', 100, 'mian xian', 'ux109 ux105 ux97 ux110 ux120 ux21193 ux21439', 0, 0),
(2898, 2891, '610726', '宁强县', 3, '0916', '区', 100, 'ning qiang xian', 'ux110 ux105 ux103 ux113 ux97 ux120 ux23425 ux24378 ux21439', 0, 0),
(2899, 2891, '610727', '略阳县', 3, '0916', '区', 100, 'l<e yang xian', 'ux108 ux60 ux101 ux121 ux97 ux110 ux103 ux120 ux105 ux30053 ux38451 ux21439', 0, 0),
(2900, 2891, '610728', '镇巴县', 3, '0916', '区', 100, 'zhen ba xian', 'ux122 ux104 ux101 ux110 ux98 ux97 ux120 ux105 ux38215 ux24052 ux21439', 0, 0),
(2901, 2891, '610729', '留坝县', 3, '0916', '区', 100, 'liu ba xian', 'ux108 ux105 ux117 ux98 ux97 ux120 ux110 ux30041 ux22365 ux21439', 0, 0),
(2902, 2891, '610730', '佛坪县', 3, '0916', '区', 100, 'fo ping xian', 'ux102 ux111 ux112 ux105 ux110 ux103 ux120 ux97 ux20315 ux22378 ux21439', 0, 0),
(2903, 2817, '610800', '榆林市', 2, '0912', '市', 100, 'yu lin shi', 'ux121 ux117 ux108 ux105 ux110 ux115 ux104 ux27014 ux26519 ux24066', 0, 0),
(2904, 2903, '610802', '榆阳区', 3, '0912', '区', 100, 'yu yang qu', 'ux121 ux117 ux97 ux110 ux103 ux113 ux27014 ux38451 ux21306', 0, 0),
(2905, 2903, '610821', '神木县', 3, '0912', '区', 100, 'shen mu xian', 'ux115 ux104 ux101 ux110 ux109 ux117 ux120 ux105 ux97 ux31070 ux26408 ux21439', 0, 0),
(2906, 2903, '610822', '府谷县', 3, '0912', '区', 100, 'fu gu xian', 'ux102 ux117 ux103 ux120 ux105 ux97 ux110 ux24220 ux35895 ux21439', 0, 0),
(2907, 2903, '610823', '横山县', 3, '0912', '区', 100, 'heng shan xian', 'ux104 ux101 ux110 ux103 ux115 ux97 ux120 ux105 ux27178 ux23665 ux21439', 0, 0),
(2908, 2903, '610824', '靖边县', 3, '0912', '区', 100, 'jing bian xian', 'ux106 ux105 ux110 ux103 ux98 ux97 ux120 ux38742 ux36793 ux21439', 0, 0),
(2909, 2903, '610825', '定边县', 3, '0912', '区', 100, 'ding bian xian', 'ux100 ux105 ux110 ux103 ux98 ux97 ux120 ux23450 ux36793 ux21439', 0, 0),
(2910, 2903, '610826', '绥德县', 3, '0912', '区', 100, 'sui de xian', 'ux115 ux117 ux105 ux100 ux101 ux120 ux97 ux110 ux32485 ux24503 ux21439', 0, 0),
(2911, 2903, '610827', '米脂县', 3, '0912', '区', 100, 'mi zhi xian', 'ux109 ux105 ux122 ux104 ux120 ux97 ux110 ux31859 ux33026 ux21439', 0, 0),
(2912, 2903, '610828', '佳县', 3, '0912', '区', 100, 'jia xian', 'ux106 ux105 ux97 ux120 ux110 ux20339 ux21439', 0, 0),
(2913, 2903, '610829', '吴堡县', 3, '0912', '区', 100, 'wu bao xian', 'ux119 ux117 ux98 ux97 ux111 ux120 ux105 ux110 ux21556 ux22561 ux21439', 0, 0),
(2914, 2903, '610830', '清涧县', 3, '0912', '区', 100, 'qing jian xian', 'ux113 ux105 ux110 ux103 ux106 ux97 ux120 ux28165 ux28071 ux21439', 0, 0),
(2915, 2903, '610831', '子洲县', 3, '0912', '区', 100, 'zi zhou xian', 'ux122 ux105 ux104 ux111 ux117 ux120 ux97 ux110 ux23376 ux27954 ux21439', 0, 0),
(2916, 2817, '610900', '安康市', 2, '0915', '市', 100, 'an kang shi', 'ux97 ux110 ux107 ux103 ux115 ux104 ux105 ux23433 ux24247 ux24066', 0, 0),
(2917, 2916, '610902', '汉滨区', 3, '0915', '区', 100, 'han bin qu', 'ux104 ux97 ux110 ux98 ux105 ux113 ux117 ux27721 ux28392 ux21306', 0, 0),
(2918, 2916, '610921', '汉阴县', 3, '0915', '区', 100, 'han yin xian', 'ux104 ux97 ux110 ux121 ux105 ux120 ux27721 ux38452 ux21439', 0, 0),
(2919, 2916, '610922', '石泉县', 3, '0915', '区', 100, 'shi quan xian', 'ux115 ux104 ux105 ux113 ux117 ux97 ux110 ux120 ux30707 ux27849 ux21439', 0, 0),
(2920, 2916, '610923', '宁陕县', 3, '0915', '区', 100, 'ning shan xian', 'ux110 ux105 ux103 ux115 ux104 ux97 ux120 ux23425 ux38485 ux21439', 0, 0),
(2921, 2916, '610924', '紫阳县', 3, '0915', '区', 100, 'zi yang xian', 'ux122 ux105 ux121 ux97 ux110 ux103 ux120 ux32043 ux38451 ux21439', 0, 0),
(2922, 2916, '610925', '岚皋县', 3, '0915', '区', 100, 'lan gao xian', 'ux108 ux97 ux110 ux103 ux111 ux120 ux105 ux23706 ux30347 ux21439', 0, 0),
(2923, 2916, '610926', '平利县', 3, '0915', '区', 100, 'ping li xian', 'ux112 ux105 ux110 ux103 ux108 ux120 ux97 ux24179 ux21033 ux21439', 0, 0),
(2924, 2916, '610927', '镇坪县', 3, '0915', '区', 100, 'zhen ping xian', 'ux122 ux104 ux101 ux110 ux112 ux105 ux103 ux120 ux97 ux38215 ux22378 ux21439', 0, 0),
(2925, 2916, '610928', '旬阳县', 3, '0915', '区', 100, 'xun yang xian', 'ux120 ux117 ux110 ux121 ux97 ux103 ux105 ux26092 ux38451 ux21439', 0, 0),
(2926, 2916, '610929', '白河县', 3, '0915', '区', 100, 'bai he xian', 'ux98 ux97 ux105 ux104 ux101 ux120 ux110 ux30333 ux27827 ux21439', 0, 0),
(2927, 2817, '611000', '商洛市', 2, '0914', '市', 100, 'shang luo shi', 'ux115 ux104 ux97 ux110 ux103 ux108 ux117 ux111 ux105 ux21830 ux27931 ux24066', 0, 0),
(2928, 2927, '611002', '商州区', 3, '0914', '区', 100, 'shang zhou qu', 'ux115 ux104 ux97 ux110 ux103 ux122 ux111 ux117 ux113 ux21830 ux24030 ux21306', 0, 0),
(2929, 2927, '611021', '洛南县', 3, '0914', '区', 100, 'luo nan xian', 'ux108 ux117 ux111 ux110 ux97 ux120 ux105 ux27931 ux21335 ux21439', 0, 0),
(2930, 2927, '611022', '丹凤县', 3, '0914', '区', 100, 'dan feng xian', 'ux100 ux97 ux110 ux102 ux101 ux103 ux120 ux105 ux20025 ux20964 ux21439', 0, 0),
(2931, 2927, '611023', '商南县', 3, '0914', '区', 100, 'shang nan xian', 'ux115 ux104 ux97 ux110 ux103 ux120 ux105 ux21830 ux21335 ux21439', 0, 0),
(2932, 2927, '611024', '山阳县', 3, '0914', '区', 100, 'shan yang xian', 'ux115 ux104 ux97 ux110 ux121 ux103 ux120 ux105 ux23665 ux38451 ux21439', 0, 0),
(2933, 2927, '611025', '镇安县', 3, '0914', '区', 100, 'zhen an xian', 'ux122 ux104 ux101 ux110 ux97 ux120 ux105 ux38215 ux23433 ux21439', 0, 0),
(2934, 2927, '611026', '柞水县', 3, '0914', '区', 100, 'zuo shui xian', 'ux122 ux117 ux111 ux115 ux104 ux105 ux120 ux97 ux110 ux26590 ux27700 ux21439', 0, 0),
(2935, 0, '620000', '甘肃省', 1, '', '省', 100, 'gan su sheng', 'ux103 ux97 ux110 ux115 ux117 ux104 ux101 ux29976 ux32899 ux30465', 0, 0),
(2936, 2935, '620100', '兰州市', 2, '0931', '市', 100, 'lan zhou shi', 'ux108 ux97 ux110 ux122 ux104 ux111 ux117 ux115 ux105 ux20848 ux24030 ux24066', 0, 0),
(2937, 2936, '620102', '城关区', 3, '0931', '区', 100, 'cheng guan qu', 'ux99 ux104 ux101 ux110 ux103 ux117 ux97 ux113 ux22478 ux20851 ux21306', 0, 0),
(2938, 2936, '620103', '七里河区', 3, '0931', '区', 100, 'qi li he qu', 'ux113 ux105 ux108 ux104 ux101 ux117 ux19971 ux37324 ux27827 ux21306', 0, 0),
(2939, 2936, '620104', '西固区', 3, '0931', '区', 100, 'xi gu qu', 'ux120 ux105 ux103 ux117 ux113 ux35199 ux22266 ux21306', 0, 0),
(2940, 2936, '620105', '安宁区', 3, '0931', '区', 100, 'an ning qu', 'ux97 ux110 ux105 ux103 ux113 ux117 ux23433 ux23425 ux21306', 0, 0),
(2941, 2936, '620111', '红古区', 3, '0931', '区', 100, 'hong gu qu', 'ux104 ux111 ux110 ux103 ux117 ux113 ux32418 ux21476 ux21306', 0, 0),
(2942, 2936, '620121', '永登县', 3, '0931', '区', 100, 'yong deng xian', 'ux121 ux111 ux110 ux103 ux100 ux101 ux120 ux105 ux97 ux27704 ux30331 ux21439', 0, 0),
(2943, 2936, '620122', '皋兰县', 3, '0931', '区', 100, 'gao lan xian', 'ux103 ux97 ux111 ux108 ux110 ux120 ux105 ux30347 ux20848 ux21439', 0, 0),
(2944, 2936, '620123', '榆中县', 3, '0931', '区', 100, 'yu zhong xian', 'ux121 ux117 ux122 ux104 ux111 ux110 ux103 ux120 ux105 ux97 ux27014 ux20013 ux21439', 0, 0),
(2945, 2935, '620200', '嘉峪关市', 2, '0937', '市', 100, 'jia yu guan shi', 'ux106 ux105 ux97 ux121 ux117 ux103 ux110 ux115 ux104 ux22025 ux23786 ux20851 ux24066', 0, 0),
(2946, 2945, '620201', '嘉峪关市', 3, '0937', '区', 100, 'jia yu guan shi', 'ux106 ux105 ux97 ux121 ux117 ux103 ux110 ux115 ux104 ux22025 ux23786 ux20851 ux24066', 0, 0),
(2947, 2935, '620300', '金昌市', 2, '0935', '市', 100, 'jin chang shi', 'ux106 ux105 ux110 ux99 ux104 ux97 ux103 ux115 ux37329 ux26124 ux24066', 0, 0),
(2948, 2947, '620302', '金川区', 3, '0935', '区', 100, 'jin chuan qu', 'ux106 ux105 ux110 ux99 ux104 ux117 ux97 ux113 ux37329 ux24029 ux21306', 0, 0),
(2949, 2947, '620321', '永昌县', 3, '0935', '区', 100, 'yong chang xian', 'ux121 ux111 ux110 ux103 ux99 ux104 ux97 ux120 ux105 ux27704 ux26124 ux21439', 0, 0),
(2950, 2935, '620400', '白银市', 2, '0943', '市', 100, 'bai yin shi', 'ux98 ux97 ux105 ux121 ux110 ux115 ux104 ux30333 ux38134 ux24066', 0, 0),
(2951, 2950, '620402', '白银区', 3, '0943', '区', 100, 'bai yin qu', 'ux98 ux97 ux105 ux121 ux110 ux113 ux117 ux30333 ux38134 ux21306', 0, 0),
(2952, 2950, '620403', '平川区', 3, '0943', '区', 100, 'ping chuan qu', 'ux112 ux105 ux110 ux103 ux99 ux104 ux117 ux97 ux113 ux24179 ux24029 ux21306', 0, 0),
(2953, 2950, '620421', '靖远县', 3, '0943', '区', 100, 'jing yuan xian', 'ux106 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux38742 ux36828 ux21439', 0, 0),
(2954, 2950, '620422', '会宁县', 3, '0943', '区', 100, 'hui ning xian', 'ux104 ux117 ux105 ux110 ux103 ux120 ux97 ux20250 ux23425 ux21439', 0, 0),
(2955, 2950, '620423', '景泰县', 3, '0943', '区', 100, 'jing tai xian', 'ux106 ux105 ux110 ux103 ux116 ux97 ux120 ux26223 ux27888 ux21439', 0, 0),
(2956, 2935, '620500', '天水市', 2, '0938', '市', 100, 'tian shui shi', 'ux116 ux105 ux97 ux110 ux115 ux104 ux117 ux22825 ux27700 ux24066', 0, 0),
(2957, 2956, '620502', '秦州区', 3, '0938', '区', 100, 'qin zhou qu', 'ux113 ux105 ux110 ux122 ux104 ux111 ux117 ux31206 ux24030 ux21306', 0, 0),
(2958, 2956, '620503', '麦积区', 3, '0938', '区', 100, 'mai ji qu', 'ux109 ux97 ux105 ux106 ux113 ux117 ux40614 ux31215 ux21306', 0, 0),
(2959, 2956, '620521', '清水县', 3, '0938', '区', 100, 'qing shui xian', 'ux113 ux105 ux110 ux103 ux115 ux104 ux117 ux120 ux97 ux28165 ux27700 ux21439', 0, 0),
(2960, 2956, '620522', '秦安县', 3, '0938', '区', 100, 'qin an xian', 'ux113 ux105 ux110 ux97 ux120 ux31206 ux23433 ux21439', 0, 0),
(2961, 2956, '620523', '甘谷县', 3, '0938', '区', 100, 'gan gu xian', 'ux103 ux97 ux110 ux117 ux120 ux105 ux29976 ux35895 ux21439', 0, 0),
(2962, 2956, '620524', '武山县', 3, '0938', '区', 100, 'wu shan xian', 'ux119 ux117 ux115 ux104 ux97 ux110 ux120 ux105 ux27494 ux23665 ux21439', 0, 0),
(2963, 2956, '620525', '张家川回族自治县', 3, '0938', '区', 100, 'zhang jia chuan hui zu zi zhi xian', 'ux122 ux104 ux97 ux110 ux103 ux106 ux105 ux99 ux117 ux120 ux24352 ux23478 ux24029 ux22238 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2964, 2935, '620600', '武威市', 2, '0935', '市', 100, 'wu wei shi', 'ux119 ux117 ux101 ux105 ux115 ux104 ux27494 ux23041 ux24066', 0, 0),
(2965, 2964, '620602', '凉州区', 3, '0935', '区', 100, 'liang zhou qu', 'ux108 ux105 ux97 ux110 ux103 ux122 ux104 ux111 ux117 ux113 ux20937 ux24030 ux21306', 0, 0),
(2966, 2964, '620621', '民勤县', 3, '0935', '区', 100, 'min qin xian', 'ux109 ux105 ux110 ux113 ux120 ux97 ux27665 ux21220 ux21439', 0, 0),
(2967, 2964, '620622', '古浪县', 3, '0935', '区', 100, 'gu lang xian', 'ux103 ux117 ux108 ux97 ux110 ux120 ux105 ux21476 ux28010 ux21439', 0, 0),
(2968, 2964, '620623', '天祝藏族自治县', 3, '0935', '区', 100, 'tian zhu cang zu zi zhi xian', 'ux116 ux105 ux97 ux110 ux122 ux104 ux117 ux99 ux103 ux120 ux22825 ux31069 ux34255 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2969, 2935, '620700', '张掖市', 2, '0936', '市', 100, 'zhang ye shi', 'ux122 ux104 ux97 ux110 ux103 ux121 ux101 ux115 ux105 ux24352 ux25494 ux24066', 0, 0),
(2970, 2969, '620702', '甘州区', 3, '0936', '区', 100, 'gan zhou qu', 'ux103 ux97 ux110 ux122 ux104 ux111 ux117 ux113 ux29976 ux24030 ux21306', 0, 0),
(2971, 2969, '620721', '肃南裕固族自治县', 3, '0936', '区', 100, 'su nan yu gu zu zi zhi xian', 'ux115 ux117 ux110 ux97 ux121 ux103 ux122 ux105 ux104 ux120 ux32899 ux21335 ux35029 ux22266 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2972, 2969, '620722', '民乐县', 3, '0936', '区', 100, 'min le xian', 'ux109 ux105 ux110 ux108 ux101 ux120 ux97 ux27665 ux20048 ux21439', 0, 0),
(2973, 2969, '620723', '临泽县', 3, '0936', '区', 100, 'lin ze xian', 'ux108 ux105 ux110 ux122 ux101 ux120 ux97 ux20020 ux27901 ux21439', 0, 0),
(2974, 2969, '620724', '高台县', 3, '0936', '区', 100, 'gao tai xian', 'ux103 ux97 ux111 ux116 ux105 ux120 ux110 ux39640 ux21488 ux21439', 0, 0),
(2975, 2969, '620725', '山丹县', 3, '0936', '区', 100, 'shan dan xian', 'ux115 ux104 ux97 ux110 ux100 ux120 ux105 ux23665 ux20025 ux21439', 0, 0),
(2976, 2935, '620800', '平凉市', 2, '0933', '市', 100, 'ping liang shi', 'ux112 ux105 ux110 ux103 ux108 ux97 ux115 ux104 ux24179 ux20937 ux24066', 0, 0),
(2977, 2976, '620802', '崆峒区', 3, '0933', '区', 100, 'kong tong qu', 'ux107 ux111 ux110 ux103 ux116 ux113 ux117 ux23814 ux23762 ux21306', 0, 0),
(2978, 2976, '620821', '泾川县', 3, '0933', '区', 100, 'jing chuan xian', 'ux106 ux105 ux110 ux103 ux99 ux104 ux117 ux97 ux120 ux27902 ux24029 ux21439', 0, 0),
(2979, 2976, '620822', '灵台县', 3, '0933', '区', 100, 'ling tai xian', 'ux108 ux105 ux110 ux103 ux116 ux97 ux120 ux28789 ux21488 ux21439', 0, 0),
(2980, 2976, '620823', '崇信县', 3, '0933', '区', 100, 'chong xin xian', 'ux99 ux104 ux111 ux110 ux103 ux120 ux105 ux97 ux23815 ux20449 ux21439', 0, 0),
(2981, 2976, '620824', '华亭县', 3, '0933', '区', 100, 'hua ting xian', 'ux104 ux117 ux97 ux116 ux105 ux110 ux103 ux120 ux21326 ux20141 ux21439', 0, 0),
(2982, 2976, '620825', '庄浪县', 3, '0933', '区', 100, 'zhuang lang xian', 'ux122 ux104 ux117 ux97 ux110 ux103 ux108 ux120 ux105 ux24196 ux28010 ux21439', 0, 0),
(2983, 2976, '620826', '静宁县', 3, '0933', '区', 100, 'jing ning xian', 'ux106 ux105 ux110 ux103 ux120 ux97 ux38745 ux23425 ux21439', 0, 0),
(2984, 2935, '620900', '酒泉市', 2, '0937', '市', 100, 'jiu quan shi', 'ux106 ux105 ux117 ux113 ux97 ux110 ux115 ux104 ux37202 ux27849 ux24066', 0, 0),
(2985, 2984, '620902', '肃州区', 3, '0937', '区', 100, 'su zhou qu', 'ux115 ux117 ux122 ux104 ux111 ux113 ux32899 ux24030 ux21306', 0, 0),
(2986, 2984, '620921', '金塔县', 3, '0937', '区', 100, 'jin ta xian', 'ux106 ux105 ux110 ux116 ux97 ux120 ux37329 ux22612 ux21439', 0, 0),
(2987, 2984, '620922', '瓜州县', 3, '0937', '区', 100, 'gua zhou xian', 'ux103 ux117 ux97 ux122 ux104 ux111 ux120 ux105 ux110 ux29916 ux24030 ux21439', 0, 0),
(2988, 2984, '620923', '肃北蒙古族自治县', 3, '0937', '区', 100, 'su bei meng gu zu zi zhi xian', 'ux115 ux117 ux98 ux101 ux105 ux109 ux110 ux103 ux122 ux104 ux120 ux97 ux32899 ux21271 ux33945 ux21476 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2989, 2984, '620924', '阿克塞哈萨克族自治县', 3, '0937', '区', 100, 'a ke sai ha sa ke zu zi zhi xian', 'ux97 ux107 ux101 ux115 ux105 ux104 ux122 ux117 ux120 ux110 ux38463 ux20811 ux22622 ux21704 ux33832 ux26063 ux33258 ux27835 ux21439', 0, 0),
(2990, 2984, '620981', '玉门市', 3, '0937', '区', 100, 'yu men shi', 'ux121 ux117 ux109 ux101 ux110 ux115 ux104 ux105 ux29577 ux38376 ux24066', 0, 0),
(2991, 2984, '620982', '敦煌市', 3, '0937', '区', 100, 'dun huang shi', 'ux100 ux117 ux110 ux104 ux97 ux103 ux115 ux105 ux25958 ux29004 ux24066', 0, 0),
(2992, 2935, '621000', '庆阳市', 2, '0934', '市', 100, 'qing yang shi', 'ux113 ux105 ux110 ux103 ux121 ux97 ux115 ux104 ux24198 ux38451 ux24066', 0, 0),
(2993, 2992, '621002', '西峰区', 3, '0934', '区', 100, 'xi feng qu', 'ux120 ux105 ux102 ux101 ux110 ux103 ux113 ux117 ux35199 ux23792 ux21306', 0, 0),
(2994, 2992, '621021', '庆城县', 3, '0934', '区', 100, 'qing cheng xian', 'ux113 ux105 ux110 ux103 ux99 ux104 ux101 ux120 ux97 ux24198 ux22478 ux21439', 0, 0),
(2995, 2992, '621022', '环县', 3, '0934', '区', 100, 'huan xian', 'ux104 ux117 ux97 ux110 ux120 ux105 ux29615 ux21439', 0, 0),
(2996, 2992, '621023', '华池县', 3, '0934', '区', 100, 'hua chi xian', 'ux104 ux117 ux97 ux99 ux105 ux120 ux110 ux21326 ux27744 ux21439', 0, 0),
(2997, 2992, '621024', '合水县', 3, '0934', '区', 100, 'he shui xian', 'ux104 ux101 ux115 ux117 ux105 ux120 ux97 ux110 ux21512 ux27700 ux21439', 0, 0),
(2998, 2992, '621025', '正宁县', 3, '0934', '区', 100, 'zheng ning xian', 'ux122 ux104 ux101 ux110 ux103 ux105 ux120 ux97 ux27491 ux23425 ux21439', 0, 0),
(2999, 2992, '621026', '宁县', 3, '0934', '区', 100, 'ning xian', 'ux110 ux105 ux103 ux120 ux97 ux23425 ux21439', 0, 0),
(3000, 2992, '621027', '镇原县', 3, '0934', '区', 100, 'zhen yuan xian', 'ux122 ux104 ux101 ux110 ux121 ux117 ux97 ux120 ux105 ux38215 ux21407 ux21439', 0, 0),
(3001, 2935, '621100', '定西市', 2, '0932', '市', 100, 'ding xi shi', 'ux100 ux105 ux110 ux103 ux120 ux115 ux104 ux23450 ux35199 ux24066', 0, 0),
(3002, 3001, '621102', '安定区', 3, '0932', '区', 100, 'an ding qu', 'ux97 ux110 ux100 ux105 ux103 ux113 ux117 ux23433 ux23450 ux21306', 0, 0),
(3003, 3001, '621121', '通渭县', 3, '0932', '区', 100, 'tong wei xian', 'ux116 ux111 ux110 ux103 ux119 ux101 ux105 ux120 ux97 ux36890 ux28205 ux21439', 0, 0),
(3004, 3001, '621122', '陇西县', 3, '0932', '区', 100, 'long xi xian', 'ux108 ux111 ux110 ux103 ux120 ux105 ux97 ux38471 ux35199 ux21439', 0, 0),
(3005, 3001, '621123', '渭源县', 3, '0932', '区', 100, 'wei yuan xian', 'ux119 ux101 ux105 ux121 ux117 ux97 ux110 ux120 ux28205 ux28304 ux21439', 0, 0),
(3006, 3001, '621124', '临洮县', 3, '0932', '区', 100, 'lin tao xian', 'ux108 ux105 ux110 ux116 ux97 ux111 ux120 ux20020 ux27950 ux21439', 0, 0),
(3007, 3001, '621125', '漳县', 3, '0932', '区', 100, 'zhang xian', 'ux122 ux104 ux97 ux110 ux103 ux120 ux105 ux28467 ux21439', 0, 0),
(3008, 3001, '621126', '岷县', 3, '0932', '区', 100, 'min xian', 'ux109 ux105 ux110 ux120 ux97 ux23735 ux21439', 0, 0),
(3009, 2935, '621200', '陇南市', 2, '0939', '市', 100, 'long nan shi', 'ux108 ux111 ux110 ux103 ux97 ux115 ux104 ux105 ux38471 ux21335 ux24066', 0, 0),
(3010, 3009, '621202', '武都区', 3, '0939', '区', 100, 'wu du qu', 'ux119 ux117 ux100 ux113 ux27494 ux37117 ux21306', 0, 0),
(3011, 3009, '621221', '成县', 3, '0939', '区', 100, 'cheng xian', 'ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux97 ux25104 ux21439', 0, 0),
(3012, 3009, '621222', '文县', 3, '0939', '区', 100, 'wen xian', 'ux119 ux101 ux110 ux120 ux105 ux97 ux25991 ux21439', 0, 0),
(3013, 3009, '621223', '宕昌县', 3, '0939', '区', 100, 'dang chang xian', 'ux100 ux97 ux110 ux103 ux99 ux104 ux120 ux105 ux23445 ux26124 ux21439', 0, 0),
(3014, 3009, '621224', '康县', 3, '0939', '区', 100, 'kang xian', 'ux107 ux97 ux110 ux103 ux120 ux105 ux24247 ux21439', 0, 0),
(3015, 3009, '621225', '西和县', 3, '0939', '区', 100, 'xi he xian', 'ux120 ux105 ux104 ux101 ux97 ux110 ux35199 ux21644 ux21439', 0, 0),
(3016, 3009, '621226', '礼县', 3, '0939', '区', 100, 'li xian', 'ux108 ux105 ux120 ux97 ux110 ux31036 ux21439', 0, 0),
(3017, 3009, '621227', '徽县', 3, '0939', '区', 100, 'hui xian', 'ux104 ux117 ux105 ux120 ux97 ux110 ux24509 ux21439', 0, 0),
(3018, 3009, '621228', '两当县', 3, '0939', '区', 100, 'liang dang xian', 'ux108 ux105 ux97 ux110 ux103 ux100 ux120 ux20004 ux24403 ux21439', 0, 0),
(3019, 2935, '622900', '临夏回族自治州', 2, '0930', '市', 100, 'lin xia hui zu zi zhi zhou', 'ux108 ux105 ux110 ux120 ux97 ux104 ux117 ux122 ux111 ux20020 ux22799 ux22238 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3020, 3019, '622901', '临夏市', 3, '0930', '区', 100, 'lin xia shi', 'ux108 ux105 ux110 ux120 ux97 ux115 ux104 ux20020 ux22799 ux24066', 0, 0),
(3021, 3019, '622921', '临夏县', 3, '0930', '区', 100, 'lin xia xian', 'ux108 ux105 ux110 ux120 ux97 ux20020 ux22799 ux21439', 0, 0),
(3022, 3019, '622922', '康乐县', 3, '0930', '区', 100, 'kang le xian', 'ux107 ux97 ux110 ux103 ux108 ux101 ux120 ux105 ux24247 ux20048 ux21439', 0, 0),
(3023, 3019, '622923', '永靖县', 3, '0930', '区', 100, 'yong jing xian', 'ux121 ux111 ux110 ux103 ux106 ux105 ux120 ux97 ux27704 ux38742 ux21439', 0, 0),
(3024, 3019, '622924', '广河县', 3, '0930', '区', 100, 'guang he xian', 'ux103 ux117 ux97 ux110 ux104 ux101 ux120 ux105 ux24191 ux27827 ux21439', 0, 0),
(3025, 3019, '622925', '和政县', 3, '0930', '区', 100, 'he zheng xian', 'ux104 ux101 ux122 ux110 ux103 ux120 ux105 ux97 ux21644 ux25919 ux21439', 0, 0),
(3026, 3019, '622926', '东乡族自治县', 3, '0930', '区', 100, 'dong xiang zu zi zhi xian', 'ux100 ux111 ux110 ux103 ux120 ux105 ux97 ux122 ux117 ux104 ux19996 ux20065 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3027, 3019, '622927', '积石山保安族东乡族撒拉族自治县', 3, '0930', '区', 100, 'ji shi shan bao an zu dong xiang zu sa la zu zi zhi xian', 'ux106 ux105 ux115 ux104 ux97 ux110 ux98 ux111 ux122 ux117 ux100 ux103 ux120 ux108 ux31215 ux30707 ux23665 ux20445 ux23433 ux26063 ux19996 ux20065 ux25746 ux25289 ux33258 ux27835 ux21439', 0, 0),
(3028, 2935, '623000', '甘南藏族自治州', 2, '0941', '市', 100, 'gan nan cang zu zi zhi zhou', 'ux103 ux97 ux110 ux99 ux122 ux117 ux105 ux104 ux111 ux29976 ux21335 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3029, 3028, '623001', '合作市', 3, '0941', '区', 100, 'he zuo shi', 'ux104 ux101 ux122 ux117 ux111 ux115 ux105 ux21512 ux20316 ux24066', 0, 0),
(3030, 3028, '623021', '临潭县', 3, '0941', '区', 100, 'lin tan xian', 'ux108 ux105 ux110 ux116 ux97 ux120 ux20020 ux28525 ux21439', 0, 0),
(3031, 3028, '623022', '卓尼县', 3, '0941', '区', 100, 'zhuo ni xian', 'ux122 ux104 ux117 ux111 ux110 ux105 ux120 ux97 ux21331 ux23612 ux21439', 0, 0),
(3032, 3028, '623023', '舟曲县', 3, '0941', '区', 100, 'zhou qu xian', 'ux122 ux104 ux111 ux117 ux113 ux120 ux105 ux97 ux110 ux33311 ux26354 ux21439', 0, 0),
(3033, 3028, '623024', '迭部县', 3, '0941', '区', 100, 'die bu xian', 'ux100 ux105 ux101 ux98 ux117 ux120 ux97 ux110 ux36845 ux37096 ux21439', 0, 0),
(3034, 3028, '623025', '玛曲县', 3, '0941', '区', 100, 'ma qu xian', 'ux109 ux97 ux113 ux117 ux120 ux105 ux110 ux29595 ux26354 ux21439', 0, 0),
(3035, 3028, '623026', '碌曲县', 3, '0941', '区', 100, 'lu qu xian', 'ux108 ux117 ux113 ux120 ux105 ux97 ux110 ux30860 ux26354 ux21439', 0, 0),
(3036, 3028, '623027', '夏河县', 3, '0941', '区', 100, 'xia he xian', 'ux120 ux105 ux97 ux104 ux101 ux110 ux22799 ux27827 ux21439', 0, 0),
(3037, 0, '630000', '青海省', 1, '', '省', 100, 'qing hai sheng', 'ux113 ux105 ux110 ux103 ux104 ux97 ux115 ux101 ux38738 ux28023 ux30465', 0, 0),
(3038, 3037, '630100', '西宁市', 2, '0971', '市', 100, 'xi ning shi', 'ux120 ux105 ux110 ux103 ux115 ux104 ux35199 ux23425 ux24066', 0, 0),
(3039, 3038, '630102', '城东区', 3, '0971', '区', 100, 'cheng dong qu', 'ux99 ux104 ux101 ux110 ux103 ux100 ux111 ux113 ux117 ux22478 ux19996 ux21306', 0, 0),
(3040, 3038, '630103', '城中区', 3, '0971', '区', 100, 'cheng zhong qu', 'ux99 ux104 ux101 ux110 ux103 ux122 ux111 ux113 ux117 ux22478 ux20013 ux21306', 0, 0),
(3041, 3038, '630104', '城西区', 3, '0971', '区', 100, 'cheng xi qu', 'ux99 ux104 ux101 ux110 ux103 ux120 ux105 ux113 ux117 ux22478 ux35199 ux21306', 0, 0),
(3042, 3038, '630105', '城北区', 3, '0971', '区', 100, 'cheng bei qu', 'ux99 ux104 ux101 ux110 ux103 ux98 ux105 ux113 ux117 ux22478 ux21271 ux21306', 0, 0),
(3043, 3038, '630121', '大通回族土族自治县', 3, '0971', '区', 100, 'da tong hui zu tu zu zi zhi xian', 'ux100 ux97 ux116 ux111 ux110 ux103 ux104 ux117 ux105 ux122 ux120 ux22823 ux36890 ux22238 ux26063 ux22303 ux33258 ux27835 ux21439', 0, 0),
(3044, 3038, '630122', '湟中县', 3, '0971', '区', 100, 'huang zhong xian', 'ux104 ux117 ux97 ux110 ux103 ux122 ux111 ux120 ux105 ux28255 ux20013 ux21439', 0, 0),
(3045, 3038, '630123', '湟源县', 3, '0971', '区', 100, 'huang yuan xian', 'ux104 ux117 ux97 ux110 ux103 ux121 ux120 ux105 ux28255 ux28304 ux21439', 0, 0),
(3046, 3037, '632100', '海东地区', 2, '0972', '市', 100, 'hai dong di qu', 'ux104 ux97 ux105 ux100 ux111 ux110 ux103 ux113 ux117 ux28023 ux19996 ux22320 ux21306', 0, 0),
(3047, 3046, '632121', '平安县', 3, '0972', '区', 100, 'ping an xian', 'ux112 ux105 ux110 ux103 ux97 ux120 ux24179 ux23433 ux21439', 0, 0),
(3048, 3046, '632122', '民和回族土族自治县', 3, '0972', '区', 100, 'min he hui zu tu zu zi zhi xian', 'ux109 ux105 ux110 ux104 ux101 ux117 ux122 ux116 ux120 ux97 ux27665 ux21644 ux22238 ux26063 ux22303 ux33258 ux27835 ux21439', 0, 0),
(3049, 3046, '632123', '乐都县', 3, '0972', '区', 100, 'le du xian', 'ux108 ux101 ux100 ux117 ux120 ux105 ux97 ux110 ux20048 ux37117 ux21439', 0, 0),
(3050, 3046, '632126', '互助土族自治县', 3, '0972', '区', 100, 'hu zhu tu zu zi zhi xian', 'ux104 ux117 ux122 ux116 ux105 ux120 ux97 ux110 ux20114 ux21161 ux22303 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3051, 3046, '632127', '化隆回族自治县', 3, '0972', '区', 100, 'hua long hui zu zi zhi xian', 'ux104 ux117 ux97 ux108 ux111 ux110 ux103 ux105 ux122 ux120 ux21270 ux38534 ux22238 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3052, 3046, '632128', '循化撒拉族自治县', 3, '0972', '区', 100, 'xun hua sa la zu zi zhi xian', 'ux120 ux117 ux110 ux104 ux97 ux115 ux108 ux122 ux105 ux24490 ux21270 ux25746 ux25289 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3053, 3037, '632200', '海北藏族自治州', 2, '0970', '市', 100, 'hai bei cang zu zi zhi zhou', 'ux104 ux97 ux105 ux98 ux101 ux99 ux110 ux103 ux122 ux117 ux111 ux28023 ux21271 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3054, 3053, '632221', '门源回族自治县', 3, '0970', '区', 100, 'men yuan hui zu zi zhi xian', 'ux109 ux101 ux110 ux121 ux117 ux97 ux104 ux105 ux122 ux120 ux38376 ux28304 ux22238 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3055, 3053, '632222', '祁连县', 3, '0970', '区', 100, 'qi lian xian', 'ux113 ux105 ux108 ux97 ux110 ux120 ux31041 ux36830 ux21439', 0, 0),
(3056, 3053, '632223', '海晏县', 3, '0970', '区', 100, 'hai yan xian', 'ux104 ux97 ux105 ux121 ux110 ux120 ux28023 ux26191 ux21439', 0, 0),
(3057, 3053, '632224', '刚察县', 3, '0970', '区', 100, 'gang cha xian', 'ux103 ux97 ux110 ux99 ux104 ux120 ux105 ux21018 ux23519 ux21439', 0, 0),
(3058, 3037, '632300', '黄南藏族自治州', 2, '0973', '市', 100, 'huang nan cang zu zi zhi zhou', 'ux104 ux117 ux97 ux110 ux103 ux99 ux122 ux105 ux111 ux40644 ux21335 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3059, 3058, '632321', '同仁县', 3, '0973', '区', 100, 'tong ren xian', 'ux116 ux111 ux110 ux103 ux114 ux101 ux120 ux105 ux97 ux21516 ux20161 ux21439', 0, 0),
(3060, 3058, '632322', '尖扎县', 3, '0973', '区', 100, 'jian za xian', 'ux106 ux105 ux97 ux110 ux122 ux120 ux23574 ux25166 ux21439', 0, 0),
(3061, 3058, '632323', '泽库县', 3, '0973', '区', 100, 'ze ku xian', 'ux122 ux101 ux107 ux117 ux120 ux105 ux97 ux110 ux27901 ux24211 ux21439', 0, 0),
(3062, 3058, '632324', '河南蒙古族自治县', 3, '0973', '区', 100, 'he nan meng gu zu zi zhi xian', 'ux104 ux101 ux110 ux97 ux109 ux103 ux117 ux122 ux105 ux120 ux27827 ux21335 ux33945 ux21476 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3063, 3037, '632500', '海南藏族自治州', 2, '0974', '市', 100, 'hai nan cang zu zi zhi zhou', 'ux104 ux97 ux105 ux110 ux99 ux103 ux122 ux117 ux111 ux28023 ux21335 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3064, 3063, '632521', '共和县', 3, '0974', '区', 100, 'gong he xian', 'ux103 ux111 ux110 ux104 ux101 ux120 ux105 ux97 ux20849 ux21644 ux21439', 0, 0),
(3065, 3063, '632522', '同德县', 3, '0974', '区', 100, 'tong de xian', 'ux116 ux111 ux110 ux103 ux100 ux101 ux120 ux105 ux97 ux21516 ux24503 ux21439', 0, 0);
INSERT INTO `%DB_PREFIX%region` (`id`, `pid`, `no`, `name`, `level`, `code`, `type`, `sort`, `py`, `matchs`, `is_default`, `is_service`) VALUES
(3066, 3063, '632523', '贵德县', 3, '0974', '区', 100, 'gui de xian', 'ux103 ux117 ux105 ux100 ux101 ux120 ux97 ux110 ux36149 ux24503 ux21439', 0, 0),
(3067, 3063, '632524', '兴海县', 3, '0974', '区', 100, 'xing hai xian', 'ux120 ux105 ux110 ux103 ux104 ux97 ux20852 ux28023 ux21439', 0, 0),
(3068, 3063, '632525', '贵南县', 3, '0974', '区', 100, 'gui nan xian', 'ux103 ux117 ux105 ux110 ux97 ux120 ux36149 ux21335 ux21439', 0, 0),
(3069, 3037, '632600', '果洛藏族自治州', 2, '0975', '市', 100, 'guo luo cang zu zi zhi zhou', 'ux103 ux117 ux111 ux108 ux99 ux97 ux110 ux122 ux105 ux104 ux26524 ux27931 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3070, 3069, '632621', '玛沁县', 3, '0975', '区', 100, 'ma qin xian', 'ux109 ux97 ux113 ux105 ux110 ux120 ux29595 ux27777 ux21439', 0, 0),
(3071, 3069, '632622', '班玛县', 3, '0975', '区', 100, 'ban ma xian', 'ux98 ux97 ux110 ux109 ux120 ux105 ux29677 ux29595 ux21439', 0, 0),
(3072, 3069, '632623', '甘德县', 3, '0975', '区', 100, 'gan de xian', 'ux103 ux97 ux110 ux100 ux101 ux120 ux105 ux29976 ux24503 ux21439', 0, 0),
(3073, 3069, '632624', '达日县', 3, '0975', '区', 100, 'da ri xian', 'ux100 ux97 ux114 ux105 ux120 ux110 ux36798 ux26085 ux21439', 0, 0),
(3074, 3069, '632625', '久治县', 3, '0975', '区', 100, 'jiu zhi xian', 'ux106 ux105 ux117 ux122 ux104 ux120 ux97 ux110 ux20037 ux27835 ux21439', 0, 0),
(3075, 3069, '632626', '玛多县', 3, '0975', '区', 100, 'ma duo xian', 'ux109 ux97 ux100 ux117 ux111 ux120 ux105 ux110 ux29595 ux22810 ux21439', 0, 0),
(3076, 3037, '632700', '玉树藏族自治州', 2, '0976', '市', 100, 'yu shu cang zu zi zhi zhou', 'ux121 ux117 ux115 ux104 ux99 ux97 ux110 ux103 ux122 ux105 ux111 ux29577 ux26641 ux34255 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3077, 3076, '632721', '玉树县', 3, '0976', '区', 100, 'yu shu xian', 'ux121 ux117 ux115 ux104 ux120 ux105 ux97 ux110 ux29577 ux26641 ux21439', 0, 0),
(3078, 3076, '632722', '杂多县', 3, '0976', '区', 100, 'za duo xian', 'ux122 ux97 ux100 ux117 ux111 ux120 ux105 ux110 ux26434 ux22810 ux21439', 0, 0),
(3079, 3076, '632723', '称多县', 3, '0976', '区', 100, 'cheng duo xian', 'ux99 ux104 ux101 ux110 ux103 ux100 ux117 ux111 ux120 ux105 ux97 ux31216 ux22810 ux21439', 0, 0),
(3080, 3076, '632724', '治多县', 3, '0976', '区', 100, 'zhi duo xian', 'ux122 ux104 ux105 ux100 ux117 ux111 ux120 ux97 ux110 ux27835 ux22810 ux21439', 0, 0),
(3081, 3076, '632725', '囊谦县', 3, '0976', '区', 100, 'nang qian xian', 'ux110 ux97 ux103 ux113 ux105 ux120 ux22218 ux35878 ux21439', 0, 0),
(3082, 3076, '632726', '曲麻莱县', 3, '0976', '区', 100, 'qu ma lai xian', 'ux113 ux117 ux109 ux97 ux108 ux105 ux120 ux110 ux26354 ux40635 ux33713 ux21439', 0, 0),
(3083, 3037, '632800', '海西蒙古族藏族自治州', 2, '0977', '市', 100, 'hai xi meng gu zu cang zu zi zhi zhou', 'ux104 ux97 ux105 ux120 ux109 ux101 ux110 ux103 ux117 ux122 ux99 ux111 ux28023 ux35199 ux33945 ux21476 ux26063 ux34255 ux33258 ux27835 ux24030', 0, 0),
(3084, 3083, '632801', '格尔木市', 3, '0977', '区', 100, 'ge er mu shi', 'ux103 ux101 ux114 ux109 ux117 ux115 ux104 ux105 ux26684 ux23572 ux26408 ux24066', 0, 0),
(3085, 3083, '632802', '德令哈市', 3, '0977', '区', 100, 'de ling ha shi', 'ux100 ux101 ux108 ux105 ux110 ux103 ux104 ux97 ux115 ux24503 ux20196 ux21704 ux24066', 0, 0),
(3086, 3083, '632821', '乌兰县', 3, '0977', '区', 100, 'wu lan xian', 'ux119 ux117 ux108 ux97 ux110 ux120 ux105 ux20044 ux20848 ux21439', 0, 0),
(3087, 3083, '632822', '都兰县', 3, '0977', '区', 100, 'du lan xian', 'ux100 ux117 ux108 ux97 ux110 ux120 ux105 ux37117 ux20848 ux21439', 0, 0),
(3088, 3083, '632823', '天峻县', 3, '0977', '区', 100, 'tian jun xian', 'ux116 ux105 ux97 ux110 ux106 ux117 ux120 ux22825 ux23803 ux21439', 0, 0),
(3089, 0, '640000', '宁夏回族自治区', 1, '', '省', 100, 'ning xia hui zu zi zhi qu', 'ux110 ux105 ux103 ux120 ux97 ux104 ux117 ux122 ux113 ux23425 ux22799 ux22238 ux26063 ux33258 ux27835 ux21306', 0, 0),
(3090, 3089, '640100', '银川市', 2, '0951', '市', 100, 'yin chuan shi', 'ux121 ux105 ux110 ux99 ux104 ux117 ux97 ux115 ux38134 ux24029 ux24066', 0, 0),
(3091, 3090, '640104', '兴庆区', 3, '0951', '区', 100, 'xing qing qu', 'ux120 ux105 ux110 ux103 ux113 ux117 ux20852 ux24198 ux21306', 0, 0),
(3092, 3090, '640105', '西夏区', 3, '0951', '区', 100, 'xi xia qu', 'ux120 ux105 ux97 ux113 ux117 ux35199 ux22799 ux21306', 0, 0),
(3093, 3090, '640106', '金凤区', 3, '0951', '区', 100, 'jin feng qu', 'ux106 ux105 ux110 ux102 ux101 ux103 ux113 ux117 ux37329 ux20964 ux21306', 0, 0),
(3094, 3090, '640121', '永宁县', 3, '0951', '区', 100, 'yong ning xian', 'ux121 ux111 ux110 ux103 ux105 ux120 ux97 ux27704 ux23425 ux21439', 0, 0),
(3095, 3090, '640122', '贺兰县', 3, '0951', '区', 100, 'he lan xian', 'ux104 ux101 ux108 ux97 ux110 ux120 ux105 ux36154 ux20848 ux21439', 0, 0),
(3096, 3090, '640181', '灵武市', 3, '0951', '区', 100, 'ling wu shi', 'ux108 ux105 ux110 ux103 ux119 ux117 ux115 ux104 ux28789 ux27494 ux24066', 0, 0),
(3097, 3089, '640200', '石嘴山市', 2, '0952', '市', 100, 'shi zui shan shi', 'ux115 ux104 ux105 ux122 ux117 ux97 ux110 ux30707 ux22068 ux23665 ux24066', 0, 0),
(3098, 3097, '640202', '大武口区', 3, '0952', '区', 100, 'da wu kou qu', 'ux100 ux97 ux119 ux117 ux107 ux111 ux113 ux22823 ux27494 ux21475 ux21306', 0, 0),
(3099, 3097, '640205', '惠农区', 3, '0952', '区', 100, 'hui nong qu', 'ux104 ux117 ux105 ux110 ux111 ux103 ux113 ux24800 ux20892 ux21306', 0, 0),
(3100, 3097, '640221', '平罗县', 3, '0952', '区', 100, 'ping luo xian', 'ux112 ux105 ux110 ux103 ux108 ux117 ux111 ux120 ux97 ux24179 ux32599 ux21439', 0, 0),
(3101, 3089, '640300', '吴忠市', 2, '0953', '市', 100, 'wu zhong shi', 'ux119 ux117 ux122 ux104 ux111 ux110 ux103 ux115 ux105 ux21556 ux24544 ux24066', 0, 0),
(3102, 3101, '640302', '利通区', 3, '0953', '区', 100, 'li tong qu', 'ux108 ux105 ux116 ux111 ux110 ux103 ux113 ux117 ux21033 ux36890 ux21306', 0, 0),
(3103, 3101, '640303', '红寺堡区', 3, '0953', '区', 100, 'hong si bao qu', 'ux104 ux111 ux110 ux103 ux115 ux105 ux98 ux97 ux113 ux117 ux32418 ux23546 ux22561 ux21306', 0, 0),
(3104, 3101, '640323', '盐池县', 3, '0953', '区', 100, 'yan chi xian', 'ux121 ux97 ux110 ux99 ux104 ux105 ux120 ux30416 ux27744 ux21439', 0, 0),
(3105, 3101, '640324', '同心县', 3, '0953', '区', 100, 'tong xin xian', 'ux116 ux111 ux110 ux103 ux120 ux105 ux97 ux21516 ux24515 ux21439', 0, 0),
(3106, 3101, '640381', '青铜峡市', 3, '0953', '区', 100, 'qing tong xia shi', 'ux113 ux105 ux110 ux103 ux116 ux111 ux120 ux97 ux115 ux104 ux38738 ux38108 ux23777 ux24066', 0, 0),
(3107, 3089, '640400', '固原市', 2, '0954', '市', 100, 'gu yuan shi', 'ux103 ux117 ux121 ux97 ux110 ux115 ux104 ux105 ux22266 ux21407 ux24066', 0, 0),
(3108, 3107, '640402', '原州区', 3, '0954', '区', 100, 'yuan zhou qu', 'ux121 ux117 ux97 ux110 ux122 ux104 ux111 ux113 ux21407 ux24030 ux21306', 0, 0),
(3109, 3107, '640422', '西吉县', 3, '0954', '区', 100, 'xi ji xian', 'ux120 ux105 ux106 ux97 ux110 ux35199 ux21513 ux21439', 0, 0),
(3110, 3107, '640423', '隆德县', 3, '0954', '区', 100, 'long de xian', 'ux108 ux111 ux110 ux103 ux100 ux101 ux120 ux105 ux97 ux38534 ux24503 ux21439', 0, 0),
(3111, 3107, '640424', '泾源县', 3, '0954', '区', 100, 'jing yuan xian', 'ux106 ux105 ux110 ux103 ux121 ux117 ux97 ux120 ux27902 ux28304 ux21439', 0, 0),
(3112, 3107, '640425', '彭阳县', 3, '0954', '区', 100, 'peng yang xian', 'ux112 ux101 ux110 ux103 ux121 ux97 ux120 ux105 ux24429 ux38451 ux21439', 0, 0),
(3113, 3089, '640500', '中卫市', 2, '0977', '市', 100, 'zhong wei shi', 'ux122 ux104 ux111 ux110 ux103 ux119 ux101 ux105 ux115 ux20013 ux21355 ux24066', 0, 0),
(3114, 3113, '640502', '沙坡头区', 3, '0977', '区', 100, 'sha po tou qu', 'ux115 ux104 ux97 ux112 ux111 ux116 ux117 ux113 ux27801 ux22369 ux22836 ux21306', 0, 0),
(3115, 3113, '640521', '中宁县', 3, '0977', '区', 100, 'zhong ning xian', 'ux122 ux104 ux111 ux110 ux103 ux105 ux120 ux97 ux20013 ux23425 ux21439', 0, 0),
(3116, 3113, '640522', '海原县', 3, '0977', '区', 100, 'hai yuan xian', 'ux104 ux97 ux105 ux121 ux117 ux110 ux120 ux28023 ux21407 ux21439', 0, 0),
(3117, 0, '650000', '新疆维吾尔自治区', 1, '', '省', 100, 'xin jiang wei wu er zi zhi qu', 'ux120 ux105 ux110 ux106 ux97 ux103 ux119 ux101 ux117 ux114 ux122 ux104 ux113 ux26032 ux30086 ux32500 ux21566 ux23572 ux33258 ux27835 ux21306', 0, 0),
(3118, 3117, '650100', '乌鲁木齐市', 2, '0991', '市', 100, 'wu lu mu qi shi', 'ux119 ux117 ux108 ux109 ux113 ux105 ux115 ux104 ux20044 ux40065 ux26408 ux40784 ux24066', 0, 0),
(3119, 3118, '650102', '天山区', 3, '0991', '区', 100, 'tian shan qu', 'ux116 ux105 ux97 ux110 ux115 ux104 ux113 ux117 ux22825 ux23665 ux21306', 0, 0),
(3120, 3118, '650103', '沙依巴克区', 3, '0991', '区', 100, 'sha yi ba ke qu', 'ux115 ux104 ux97 ux121 ux105 ux98 ux107 ux101 ux113 ux117 ux27801 ux20381 ux24052 ux20811 ux21306', 0, 0),
(3121, 3118, '650104', '新市区', 3, '0991', '区', 100, 'xin shi qu', 'ux120 ux105 ux110 ux115 ux104 ux113 ux117 ux26032 ux24066 ux21306', 0, 0),
(3122, 3118, '650105', '水磨沟区', 3, '0991', '区', 100, 'shui mo gou qu', 'ux115 ux104 ux117 ux105 ux109 ux111 ux103 ux113 ux27700 ux30952 ux27807 ux21306', 0, 0),
(3123, 3118, '650106', '头屯河区', 3, '0991', '区', 100, 'tou tun he qu', 'ux116 ux111 ux117 ux110 ux104 ux101 ux113 ux22836 ux23663 ux27827 ux21306', 0, 0),
(3124, 3118, '650107', '达坂城区', 3, '0991', '区', 100, 'da ban cheng qu', 'ux100 ux97 ux98 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux36798 ux22338 ux22478 ux21306', 0, 0),
(3125, 3118, '650109', '米东区', 3, '0991', '区', 100, 'mi dong qu', 'ux109 ux105 ux100 ux111 ux110 ux103 ux113 ux117 ux31859 ux19996 ux21306', 0, 0),
(3126, 3118, '650121', '乌鲁木齐县', 3, '0991', '区', 100, 'wu lu mu qi xian', 'ux119 ux117 ux108 ux109 ux113 ux105 ux120 ux97 ux110 ux20044 ux40065 ux26408 ux40784 ux21439', 0, 0),
(3127, 3117, '650200', '克拉玛依市', 2, '0990', '市', 100, 'ke la ma yi shi', 'ux107 ux101 ux108 ux97 ux109 ux121 ux105 ux115 ux104 ux20811 ux25289 ux29595 ux20381 ux24066', 0, 0),
(3128, 3127, '650202', '独山子区', 3, '0992', '区', 100, 'du shan zi qu', 'ux100 ux117 ux115 ux104 ux97 ux110 ux122 ux105 ux113 ux29420 ux23665 ux23376 ux21306', 0, 0),
(3129, 3127, '650203', '克拉玛依区', 3, '0990', '区', 100, 'ke la ma yi qu', 'ux107 ux101 ux108 ux97 ux109 ux121 ux105 ux113 ux117 ux20811 ux25289 ux29595 ux20381 ux21306', 0, 0),
(3130, 3127, '650204', '白碱滩区', 3, '0990', '区', 100, 'bai jian tan qu', 'ux98 ux97 ux105 ux106 ux110 ux116 ux113 ux117 ux30333 ux30897 ux28393 ux21306', 0, 0),
(3131, 3127, '650205', '乌尔禾区', 3, '0990', '区', 100, 'wu er he qu', 'ux119 ux117 ux101 ux114 ux104 ux113 ux20044 ux23572 ux31166 ux21306', 0, 0),
(3132, 3117, '652100', '吐鲁番地区', 2, '0995', '市', 100, 'tu lu fan di qu', 'ux116 ux117 ux108 ux102 ux97 ux110 ux100 ux105 ux113 ux21520 ux40065 ux30058 ux22320 ux21306', 0, 0),
(3133, 3132, '652101', '吐鲁番市', 3, '0995', '区', 100, 'tu lu fan shi', 'ux116 ux117 ux108 ux102 ux97 ux110 ux115 ux104 ux105 ux21520 ux40065 ux30058 ux24066', 0, 0),
(3134, 3132, '652122', '鄯善县', 3, '0995', '区', 100, 'shan shan xian', 'ux115 ux104 ux97 ux110 ux120 ux105 ux37167 ux21892 ux21439', 0, 0),
(3135, 3132, '652123', '托克逊县', 3, '0995', '区', 100, 'tuo ke xun xian', 'ux116 ux117 ux111 ux107 ux101 ux120 ux110 ux105 ux97 ux25176 ux20811 ux36874 ux21439', 0, 0),
(3136, 3117, '652200', '哈密地区', 2, '0902', '市', 100, 'ha mi di qu', 'ux104 ux97 ux109 ux105 ux100 ux113 ux117 ux21704 ux23494 ux22320 ux21306', 0, 0),
(3137, 3136, '652201', '哈密市', 3, '0902', '区', 100, 'ha mi shi', 'ux104 ux97 ux109 ux105 ux115 ux21704 ux23494 ux24066', 0, 0),
(3138, 3136, '652222', '巴里坤哈萨克自治县', 3, '0902', '区', 100, 'ba li kun ha sa ke zi zhi xian', 'ux98 ux97 ux108 ux105 ux107 ux117 ux110 ux104 ux115 ux101 ux122 ux120 ux24052 ux37324 ux22372 ux21704 ux33832 ux20811 ux33258 ux27835 ux21439', 0, 0),
(3139, 3136, '652223', '伊吾县', 3, '0902', '区', 100, 'yi wu xian', 'ux121 ux105 ux119 ux117 ux120 ux97 ux110 ux20234 ux21566 ux21439', 0, 0),
(3140, 3117, '652300', '昌吉回族自治州', 2, '0994', '市', 100, 'chang ji hui zu zi zhi zhou', 'ux99 ux104 ux97 ux110 ux103 ux106 ux105 ux117 ux122 ux111 ux26124 ux21513 ux22238 ux26063 ux33258 ux27835 ux24030', 0, 0),
(3141, 3140, '652301', '昌吉市', 3, '0994', '区', 100, 'chang ji shi', 'ux99 ux104 ux97 ux110 ux103 ux106 ux105 ux115 ux26124 ux21513 ux24066', 0, 0),
(3142, 3140, '652302', '阜康市', 3, '0994', '区', 100, 'fu kang shi', 'ux102 ux117 ux107 ux97 ux110 ux103 ux115 ux104 ux105 ux38428 ux24247 ux24066', 0, 0),
(3143, 3140, '652323', '呼图壁县', 3, '0994', '区', 100, 'hu tu bi xian', 'ux104 ux117 ux116 ux98 ux105 ux120 ux97 ux110 ux21628 ux22270 ux22721 ux21439', 0, 0),
(3144, 3140, '652324', '玛纳斯县', 3, '0994', '区', 100, 'ma na si xian', 'ux109 ux97 ux110 ux115 ux105 ux120 ux29595 ux32435 ux26031 ux21439', 0, 0),
(3145, 3140, '652325', '奇台县', 3, '0994', '区', 100, 'qi tai xian', 'ux113 ux105 ux116 ux97 ux120 ux110 ux22855 ux21488 ux21439', 0, 0),
(3146, 3140, '652327', '吉木萨尔县', 3, '0994', '区', 100, 'ji mu sa er xian', 'ux106 ux105 ux109 ux117 ux115 ux97 ux101 ux114 ux120 ux110 ux21513 ux26408 ux33832 ux23572 ux21439', 0, 0),
(3147, 3140, '652328', '木垒哈萨克自治县', 3, '0994', '区', 100, 'mu lei ha sa ke zi zhi xian', 'ux109 ux117 ux108 ux101 ux105 ux104 ux97 ux115 ux107 ux122 ux120 ux110 ux26408 ux22418 ux21704 ux33832 ux20811 ux33258 ux27835 ux21439', 0, 0),
(3148, 3117, '652700', '博尔塔拉蒙古自治州', 2, '0909', '市', 100, 'bo er ta la meng gu zi zhi zhou', 'ux98 ux111 ux101 ux114 ux116 ux97 ux108 ux109 ux110 ux103 ux117 ux122 ux105 ux104 ux21338 ux23572 ux22612 ux25289 ux33945 ux21476 ux33258 ux27835 ux24030', 0, 0),
(3149, 3148, '652701', '博乐市', 3, '0909', '区', 100, 'bo le shi', 'ux98 ux111 ux108 ux101 ux115 ux104 ux105 ux21338 ux20048 ux24066', 0, 0),
(3150, 3148, '652722', '精河县', 3, '0909', '区', 100, 'jing he xian', 'ux106 ux105 ux110 ux103 ux104 ux101 ux120 ux97 ux31934 ux27827 ux21439', 0, 0),
(3151, 3148, '652723', '温泉县', 3, '0909', '区', 100, 'wen quan xian', 'ux119 ux101 ux110 ux113 ux117 ux97 ux120 ux105 ux28201 ux27849 ux21439', 0, 0),
(3152, 3117, '652800', '巴音郭楞蒙古自治州', 2, '0996', '市', 100, 'ba yin guo leng meng gu zi zhi zhou', 'ux98 ux97 ux121 ux105 ux110 ux103 ux117 ux111 ux108 ux101 ux109 ux122 ux104 ux24052 ux38899 ux37101 ux26974 ux33945 ux21476 ux33258 ux27835 ux24030', 0, 0),
(3153, 3152, '652801', '库尔勒市', 3, '0996', '区', 100, 'ku er le shi', 'ux107 ux117 ux101 ux114 ux108 ux115 ux104 ux105 ux24211 ux23572 ux21202 ux24066', 0, 0),
(3154, 3152, '652822', '轮台县', 3, '0996', '区', 100, 'lun tai xian', 'ux108 ux117 ux110 ux116 ux97 ux105 ux120 ux36718 ux21488 ux21439', 0, 0),
(3155, 3152, '652823', '尉犁县', 3, '0996', '区', 100, 'wei li xian', 'ux119 ux101 ux105 ux108 ux120 ux97 ux110 ux23561 ux29313 ux21439', 0, 0),
(3156, 3152, '652824', '若羌县', 3, '0996', '区', 100, 'ruo qiang xian', 'ux114 ux117 ux111 ux113 ux105 ux97 ux110 ux103 ux120 ux33509 ux32652 ux21439', 0, 0),
(3157, 3152, '652825', '且末县', 3, '0996', '区', 100, 'qie mo xian', 'ux113 ux105 ux101 ux109 ux111 ux120 ux97 ux110 ux19988 ux26411 ux21439', 0, 0),
(3158, 3152, '652826', '焉耆回族自治县', 3, '0996', '区', 100, 'yan qi hui zu zi zhi xian', 'ux121 ux97 ux110 ux113 ux105 ux104 ux117 ux122 ux120 ux28937 ux32774 ux22238 ux26063 ux33258 ux27835 ux21439', 0, 0),
(3159, 3152, '652827', '和静县', 3, '0996', '区', 100, 'he jing xian', 'ux104 ux101 ux106 ux105 ux110 ux103 ux120 ux97 ux21644 ux38745 ux21439', 0, 0),
(3160, 3152, '652828', '和硕县', 3, '0996', '区', 100, 'he shuo xian', 'ux104 ux101 ux115 ux117 ux111 ux120 ux105 ux97 ux110 ux21644 ux30805 ux21439', 0, 0),
(3161, 3152, '652829', '博湖县', 3, '0996', '区', 100, 'bo hu xian', 'ux98 ux111 ux104 ux117 ux120 ux105 ux97 ux110 ux21338 ux28246 ux21439', 0, 0),
(3162, 3117, '652900', '阿克苏地区', 2, '0997', '市', 100, 'a ke su di qu', 'ux97 ux107 ux101 ux115 ux117 ux100 ux105 ux113 ux38463 ux20811 ux33487 ux22320 ux21306', 0, 0),
(3163, 3162, '652901', '阿克苏市', 3, '0997', '区', 100, 'a ke su shi', 'ux97 ux107 ux101 ux115 ux117 ux104 ux105 ux38463 ux20811 ux33487 ux24066', 0, 0),
(3164, 3162, '652922', '温宿县', 3, '0997', '区', 100, 'wen su xian', 'ux119 ux101 ux110 ux115 ux117 ux120 ux105 ux97 ux28201 ux23487 ux21439', 0, 0),
(3165, 3162, '652923', '库车县', 3, '0997', '区', 100, 'ku che xian', 'ux107 ux117 ux99 ux104 ux101 ux120 ux105 ux97 ux110 ux24211 ux36710 ux21439', 0, 0),
(3166, 3162, '652924', '沙雅县', 3, '0997', '区', 100, 'sha ya xian', 'ux115 ux104 ux97 ux121 ux120 ux105 ux110 ux27801 ux38597 ux21439', 0, 0),
(3167, 3162, '652925', '新和县', 3, '0997', '区', 100, 'xin he xian', 'ux120 ux105 ux110 ux104 ux101 ux97 ux26032 ux21644 ux21439', 0, 0),
(3168, 3162, '652926', '拜城县', 3, '0997', '区', 100, 'bai cheng xian', 'ux98 ux97 ux105 ux99 ux104 ux101 ux110 ux103 ux120 ux25308 ux22478 ux21439', 0, 0),
(3169, 3162, '652927', '乌什县', 3, '0997', '区', 100, 'wu shi xian', 'ux119 ux117 ux115 ux104 ux105 ux120 ux97 ux110 ux20044 ux20160 ux21439', 0, 0),
(3170, 3162, '652928', '阿瓦提县', 3, '0997', '区', 100, 'a wa ti xian', 'ux97 ux119 ux116 ux105 ux120 ux110 ux38463 ux29926 ux25552 ux21439', 0, 0),
(3171, 3162, '652929', '柯坪县', 3, '0997', '区', 100, 'ke ping xian', 'ux107 ux101 ux112 ux105 ux110 ux103 ux120 ux97 ux26607 ux22378 ux21439', 0, 0),
(3172, 3117, '653000', '克孜勒苏柯尔克孜自治州', 2, '0908', '市', 100, 'ke zi le su ke er ke zi zi zhi zhou', 'ux107 ux101 ux122 ux105 ux108 ux115 ux117 ux114 ux104 ux111 ux20811 ux23388 ux21202 ux33487 ux26607 ux23572 ux33258 ux27835 ux24030', 0, 0),
(3173, 3172, '653001', '阿图什市', 3, '0908', '区', 100, 'a tu shi shi', 'ux97 ux116 ux117 ux115 ux104 ux105 ux38463 ux22270 ux20160 ux24066', 0, 0),
(3174, 3172, '653022', '阿克陶县', 3, '0908', '区', 100, 'a ke tao xian', 'ux97 ux107 ux101 ux116 ux111 ux120 ux105 ux110 ux38463 ux20811 ux38518 ux21439', 0, 0),
(3175, 3172, '653023', '阿合奇县', 3, '0997', '区', 100, 'a he qi xian', 'ux97 ux104 ux101 ux113 ux105 ux120 ux110 ux38463 ux21512 ux22855 ux21439', 0, 0),
(3176, 3172, '653024', '乌恰县', 3, '0908', '区', 100, 'wu qia xian', 'ux119 ux117 ux113 ux105 ux97 ux120 ux110 ux20044 ux24688 ux21439', 0, 0),
(3177, 3117, '653100', '喀什地区', 2, '0998', '市', 100, 'ka shi di qu', 'ux107 ux97 ux115 ux104 ux105 ux100 ux113 ux117 ux21888 ux20160 ux22320 ux21306', 0, 0),
(3178, 3177, '653101', '喀什市', 3, '0998', '区', 100, 'ka shi shi', 'ux107 ux97 ux115 ux104 ux105 ux21888 ux20160 ux24066', 0, 0),
(3179, 3177, '653121', '疏附县', 3, '0998', '区', 100, 'shu fu xian', 'ux115 ux104 ux117 ux102 ux120 ux105 ux97 ux110 ux30095 ux38468 ux21439', 0, 0),
(3180, 3177, '653122', '疏勒县', 3, '0998', '区', 100, 'shu le xian', 'ux115 ux104 ux117 ux108 ux101 ux120 ux105 ux97 ux110 ux30095 ux21202 ux21439', 0, 0),
(3181, 3177, '653123', '英吉沙县', 3, '0998', '区', 100, 'ying ji sha xian', 'ux121 ux105 ux110 ux103 ux106 ux115 ux104 ux97 ux120 ux33521 ux21513 ux27801 ux21439', 0, 0),
(3182, 3177, '653124', '泽普县', 3, '0998', '区', 100, 'ze pu xian', 'ux122 ux101 ux112 ux117 ux120 ux105 ux97 ux110 ux27901 ux26222 ux21439', 0, 0),
(3183, 3177, '653125', '莎车县', 3, '0998', '区', 100, 'suo che xian', 'ux115 ux117 ux111 ux99 ux104 ux101 ux120 ux105 ux97 ux110 ux33678 ux36710 ux21439', 0, 0),
(3184, 3177, '653126', '叶城县', 3, '0998', '区', 100, 'ye cheng xian', 'ux121 ux101 ux99 ux104 ux110 ux103 ux120 ux105 ux97 ux21494 ux22478 ux21439', 0, 0),
(3185, 3177, '653127', '麦盖提县', 3, '0998', '区', 100, 'mai gai ti xian', 'ux109 ux97 ux105 ux103 ux116 ux120 ux110 ux40614 ux30422 ux25552 ux21439', 0, 0),
(3186, 3177, '653128', '岳普湖县', 3, '0998', '区', 100, 'yue pu hu xian', 'ux121 ux117 ux101 ux112 ux104 ux120 ux105 ux97 ux110 ux23731 ux26222 ux28246 ux21439', 0, 0),
(3187, 3177, '653129', '伽师县', 3, '0998', '区', 100, 'qie shi xian', 'ux113 ux105 ux101 ux115 ux104 ux120 ux97 ux110 ux20285 ux24072 ux21439', 0, 0),
(3188, 3177, '653130', '巴楚县', 3, '0998', '区', 100, 'ba chu xian', 'ux98 ux97 ux99 ux104 ux117 ux120 ux105 ux110 ux24052 ux26970 ux21439', 0, 0),
(3189, 3177, '653131', '塔什库尔干塔吉克自治县', 3, '0998', '区', 100, 'ta shi ku er gan ta ji ke zi zhi xian', 'ux116 ux97 ux115 ux104 ux105 ux107 ux117 ux101 ux114 ux103 ux110 ux106 ux122 ux120 ux22612 ux20160 ux24211 ux23572 ux24178 ux21513 ux20811 ux33258 ux27835 ux21439', 0, 0),
(3190, 3117, '653200', '和田地区', 2, '0903', '市', 100, 'he tian di qu', 'ux104 ux101 ux116 ux105 ux97 ux110 ux100 ux113 ux117 ux21644 ux30000 ux22320 ux21306', 0, 0),
(3191, 3190, '653201', '和田市', 3, '0903', '区', 100, 'he tian shi', 'ux104 ux101 ux116 ux105 ux97 ux110 ux115 ux21644 ux30000 ux24066', 0, 0),
(3192, 3190, '653221', '和田县', 3, '0903', '区', 100, 'he tian xian', 'ux104 ux101 ux116 ux105 ux97 ux110 ux120 ux21644 ux30000 ux21439', 0, 0),
(3193, 3190, '653222', '墨玉县', 3, '0903', '区', 100, 'mo yu xian', 'ux109 ux111 ux121 ux117 ux120 ux105 ux97 ux110 ux22696 ux29577 ux21439', 0, 0),
(3194, 3190, '653223', '皮山县', 3, '0903', '区', 100, 'pi shan xian', 'ux112 ux105 ux115 ux104 ux97 ux110 ux120 ux30382 ux23665 ux21439', 0, 0),
(3195, 3190, '653224', '洛浦县', 3, '0903', '区', 100, 'luo pu xian', 'ux108 ux117 ux111 ux112 ux120 ux105 ux97 ux110 ux27931 ux28006 ux21439', 0, 0),
(3196, 3190, '653225', '策勒县', 3, '0903', '区', 100, 'ce le xian', 'ux99 ux101 ux108 ux120 ux105 ux97 ux110 ux31574 ux21202 ux21439', 0, 0),
(3197, 3190, '653226', '于田县', 3, '0903', '区', 100, 'yu tian xian', 'ux121 ux117 ux116 ux105 ux97 ux110 ux120 ux20110 ux30000 ux21439', 0, 0),
(3198, 3190, '653227', '民丰县', 3, '0903', '区', 100, 'min feng xian', 'ux109 ux105 ux110 ux102 ux101 ux103 ux120 ux97 ux27665 ux20016 ux21439', 0, 0),
(3199, 3117, '654000', '伊犁哈萨克自治州', 2, '0999', '市', 100, 'yi li ha sa ke zi zhi zhou', 'ux121 ux105 ux108 ux104 ux97 ux115 ux107 ux101 ux122 ux111 ux117 ux20234 ux29313 ux21704 ux33832 ux20811 ux33258 ux27835 ux24030', 0, 0),
(3200, 3199, '654002', '伊宁市', 3, '0999', '区', 100, 'yi ning shi', 'ux121 ux105 ux110 ux103 ux115 ux104 ux20234 ux23425 ux24066', 0, 0),
(3201, 3199, '654003', '奎屯市', 3, '0992', '区', 100, 'kui tun shi', 'ux107 ux117 ux105 ux116 ux110 ux115 ux104 ux22862 ux23663 ux24066', 0, 0),
(3202, 3199, '654021', '伊宁县', 3, '0999', '区', 100, 'yi ning xian', 'ux121 ux105 ux110 ux103 ux120 ux97 ux20234 ux23425 ux21439', 0, 0),
(3203, 3199, '654022', '察布查尔锡伯自治县', 3, '0999', '区', 100, 'cha bu cha er xi bo zi zhi xian', 'ux99 ux104 ux97 ux98 ux117 ux101 ux114 ux120 ux105 ux111 ux122 ux110 ux23519 ux24067 ux26597 ux23572 ux38177 ux20271 ux33258 ux27835 ux21439', 0, 0),
(3204, 3199, '654023', '霍城县', 3, '0999', '区', 100, 'huo cheng xian', 'ux104 ux117 ux111 ux99 ux101 ux110 ux103 ux120 ux105 ux97 ux38669 ux22478 ux21439', 0, 0),
(3205, 3199, '654024', '巩留县', 3, '0999', '区', 100, 'gong liu xian', 'ux103 ux111 ux110 ux108 ux105 ux117 ux120 ux97 ux24041 ux30041 ux21439', 0, 0),
(3206, 3199, '654025', '新源县', 3, '0999', '区', 100, 'xin yuan xian', 'ux120 ux105 ux110 ux121 ux117 ux97 ux26032 ux28304 ux21439', 0, 0),
(3207, 3199, '654026', '昭苏县', 3, '0999', '区', 100, 'zhao su xian', 'ux122 ux104 ux97 ux111 ux115 ux117 ux120 ux105 ux110 ux26157 ux33487 ux21439', 0, 0),
(3208, 3199, '654027', '特克斯县', 3, '0999', '区', 100, 'te ke si xian', 'ux116 ux101 ux107 ux115 ux105 ux120 ux97 ux110 ux29305 ux20811 ux26031 ux21439', 0, 0),
(3209, 3199, '654028', '尼勒克县', 3, '0999', '区', 100, 'ni le ke xian', 'ux110 ux105 ux108 ux101 ux107 ux120 ux97 ux23612 ux21202 ux20811 ux21439', 0, 0),
(3210, 3117, '654200', '塔城地区', 2, '0901', '市', 100, 'ta cheng di qu', 'ux116 ux97 ux99 ux104 ux101 ux110 ux103 ux100 ux105 ux113 ux117 ux22612 ux22478 ux22320 ux21306', 0, 0),
(3211, 3210, '654201', '塔城市', 3, '0901', '区', 100, 'ta cheng shi', 'ux116 ux97 ux99 ux104 ux101 ux110 ux103 ux115 ux105 ux22612 ux22478 ux24066', 0, 0),
(3212, 3210, '654202', '乌苏市', 3, '0992', '区', 100, 'wu su shi', 'ux119 ux117 ux115 ux104 ux105 ux20044 ux33487 ux24066', 0, 0),
(3213, 3210, '654221', '额敏县', 3, '0901', '区', 100, 'e min xian', 'ux101 ux109 ux105 ux110 ux120 ux97 ux39069 ux25935 ux21439', 0, 0),
(3214, 3210, '654223', '沙湾县', 3, '0993', '区', 100, 'sha wan xian', 'ux115 ux104 ux97 ux119 ux110 ux120 ux105 ux27801 ux28286 ux21439', 0, 0),
(3215, 3210, '654224', '托里县', 3, '0901', '区', 100, 'tuo li xian', 'ux116 ux117 ux111 ux108 ux105 ux120 ux97 ux110 ux25176 ux37324 ux21439', 0, 0),
(3216, 3210, '654225', '裕民县', 3, '0901', '区', 100, 'yu min xian', 'ux121 ux117 ux109 ux105 ux110 ux120 ux97 ux35029 ux27665 ux21439', 0, 0),
(3217, 3210, '654226', '和布克赛尔蒙古自治县', 3, '0990', '区', 100, 'he bu ke sai er meng gu zi zhi xian', 'ux104 ux101 ux98 ux117 ux107 ux115 ux97 ux105 ux114 ux109 ux110 ux103 ux122 ux120 ux21644 ux24067 ux20811 ux36187 ux23572 ux33945 ux21476 ux33258 ux27835 ux21439', 0, 0),
(3218, 3117, '654300', '阿勒泰地区', 2, '0906', '市', 100, 'a le tai di qu', 'ux97 ux108 ux101 ux116 ux105 ux100 ux113 ux117 ux38463 ux21202 ux27888 ux22320 ux21306', 0, 0),
(3219, 3218, '654301', '阿勒泰市', 3, '0906', '区', 100, 'a le tai shi', 'ux97 ux108 ux101 ux116 ux105 ux115 ux104 ux38463 ux21202 ux27888 ux24066', 0, 0),
(3220, 3218, '654321', '布尔津县', 3, '0906', '区', 100, 'bu er jin xian', 'ux98 ux117 ux101 ux114 ux106 ux105 ux110 ux120 ux97 ux24067 ux23572 ux27941 ux21439', 0, 0),
(3221, 3218, '654322', '富蕴县', 3, '0906', '区', 100, 'fu yun xian', 'ux102 ux117 ux121 ux110 ux120 ux105 ux97 ux23500 ux34164 ux21439', 0, 0),
(3222, 3218, '654323', '福海县', 3, '0906', '区', 100, 'fu hai xian', 'ux102 ux117 ux104 ux97 ux105 ux120 ux110 ux31119 ux28023 ux21439', 0, 0),
(3223, 3218, '654324', '哈巴河县', 3, '0906', '区', 100, 'ha ba he xian', 'ux104 ux97 ux98 ux101 ux120 ux105 ux110 ux21704 ux24052 ux27827 ux21439', 0, 0),
(3224, 3218, '654325', '青河县', 3, '0906', '区', 100, 'qing he xian', 'ux113 ux105 ux110 ux103 ux104 ux101 ux120 ux97 ux38738 ux27827 ux21439', 0, 0),
(3225, 3218, '654326', '吉木乃县', 3, '0906', '区', 100, 'ji mu nai xian', 'ux106 ux105 ux109 ux117 ux110 ux97 ux120 ux21513 ux26408 ux20035 ux21439', 0, 0),
(3226, 3117, '659000', '自治区直辖', 2, '', '市', 100, 'zi zhi qu zhi xia', 'ux122 ux105 ux104 ux113 ux117 ux120 ux97 ux33258 ux27835 ux21306 ux30452 ux36758', 0, 0),
(3227, 3226, '659001', '石河子市', 3, '0993', '区', 100, 'shi he zi shi', 'ux115 ux104 ux105 ux101 ux122 ux30707 ux27827 ux23376 ux24066', 0, 0),
(3228, 3226, '659002', '阿拉尔市', 3, '0997', '区', 100, 'a la er shi', 'ux97 ux108 ux101 ux114 ux115 ux104 ux105 ux38463 ux25289 ux23572 ux24066', 0, 0),
(3229, 3226, '659003', '图木舒克市', 3, '0998', '区', 100, 'tu mu shu ke shi', 'ux116 ux117 ux109 ux115 ux104 ux107 ux101 ux105 ux22270 ux26408 ux33298 ux20811 ux24066', 0, 0),
(3230, 3226, '659004', '五家渠市', 3, '0994', '区', 100, 'wu jia qu shi', 'ux119 ux117 ux106 ux105 ux97 ux113 ux115 ux104 ux20116 ux23478 ux28192 ux24066', 0, 0),
(3231, 0, '710000', '台湾省', 1, '', '省', 100, 'tai wan sheng', 'ux116 ux97 ux105 ux119 ux110 ux115 ux104 ux101 ux103 ux21488 ux28286 ux30465', 0, 0),
(3232, 3231, '710100', '台北市', 2, '00886', '市', 100, 'tai bei shi', 'ux116 ux97 ux105 ux98 ux101 ux115 ux104 ux21488 ux21271 ux24066', 0, 0),
(3233, 3232, '710101', '中正区', 3, '00886', '区', 100, 'zhong zheng qu', 'ux122 ux104 ux111 ux110 ux103 ux101 ux113 ux117 ux20013 ux27491 ux21306', 0, 0),
(3234, 3232, '710102', '大同区', 3, '00886', '区', 100, 'da tong qu', 'ux100 ux97 ux116 ux111 ux110 ux103 ux113 ux117 ux22823 ux21516 ux21306', 0, 0),
(3235, 3232, '710103', '中山区', 3, '00886', '区', 100, 'zhong shan qu', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux20013 ux23665 ux21306', 0, 0),
(3236, 3232, '710104', '松山区', 3, '00886', '区', 100, 'song shan qu', 'ux115 ux111 ux110 ux103 ux104 ux97 ux113 ux117 ux26494 ux23665 ux21306', 0, 0),
(3237, 3232, '710105', '大安区', 3, '00886', '区', 100, 'da an qu', 'ux100 ux97 ux110 ux113 ux117 ux22823 ux23433 ux21306', 0, 0),
(3238, 3232, '710106', '万华区', 3, '00886', '区', 100, 'wan hua qu', 'ux119 ux97 ux110 ux104 ux117 ux113 ux19975 ux21326 ux21306', 0, 0),
(3239, 3232, '710107', '信义区', 3, '00886', '区', 100, 'xin yi qu', 'ux120 ux105 ux110 ux121 ux113 ux117 ux20449 ux20041 ux21306', 0, 0),
(3240, 3232, '710108', '士林区', 3, '00886', '区', 100, 'shi lin qu', 'ux115 ux104 ux105 ux108 ux110 ux113 ux117 ux22763 ux26519 ux21306', 0, 0),
(3241, 3232, '710109', '北投区', 3, '00886', '区', 100, 'bei tou qu', 'ux98 ux101 ux105 ux116 ux111 ux117 ux113 ux21271 ux25237 ux21306', 0, 0),
(3242, 3232, '710110', '内湖区', 3, '00886', '区', 100, 'nei hu qu', 'ux110 ux101 ux105 ux104 ux117 ux113 ux20869 ux28246 ux21306', 0, 0),
(3243, 3232, '710111', '南港区', 3, '00886', '区', 100, 'nan gang qu', 'ux110 ux97 ux103 ux113 ux117 ux21335 ux28207 ux21306', 0, 0),
(3244, 3232, '710112', '文山区', 3, '00886', '区', 100, 'wen shan qu', 'ux119 ux101 ux110 ux115 ux104 ux97 ux113 ux117 ux25991 ux23665 ux21306', 0, 0),
(3245, 3231, '710200', '高雄市', 2, '00886', '市', 100, 'gao xiong shi', 'ux103 ux97 ux111 ux120 ux105 ux110 ux115 ux104 ux39640 ux38596 ux24066', 0, 0),
(3246, 3245, '710201', '新兴区', 3, '00886', '区', 100, 'xin xing qu', 'ux120 ux105 ux110 ux103 ux113 ux117 ux26032 ux20852 ux21306', 0, 0),
(3247, 3245, '710202', '前金区', 3, '00886', '区', 100, 'qian jin qu', 'ux113 ux105 ux97 ux110 ux106 ux117 ux21069 ux37329 ux21306', 0, 0),
(3248, 3245, '710203', '芩雅区', 3, '00886', '区', 100, 'qin ya qu', 'ux113 ux105 ux110 ux121 ux97 ux117 ux33449 ux38597 ux21306', 0, 0),
(3249, 3245, '710204', '盐埕区', 3, '00886', '区', 100, 'yan cheng qu', 'ux121 ux97 ux110 ux99 ux104 ux101 ux103 ux113 ux117 ux30416 ux22485 ux21306', 0, 0),
(3250, 3245, '710205', '鼓山区', 3, '00886', '区', 100, 'gu shan qu', 'ux103 ux117 ux115 ux104 ux97 ux110 ux113 ux40723 ux23665 ux21306', 0, 0),
(3251, 3245, '710206', '旗津区', 3, '00886', '区', 100, 'qi jin qu', 'ux113 ux105 ux106 ux110 ux117 ux26071 ux27941 ux21306', 0, 0),
(3252, 3245, '710207', '前镇区', 3, '00886', '区', 100, 'qian zhen qu', 'ux113 ux105 ux97 ux110 ux122 ux104 ux101 ux117 ux21069 ux38215 ux21306', 0, 0),
(3253, 3245, '710208', '三民区', 3, '00886', '区', 100, 'san min qu', 'ux115 ux97 ux110 ux109 ux105 ux113 ux117 ux19977 ux27665 ux21306', 0, 0),
(3254, 3245, '710209', '左营区', 3, '00886', '区', 100, 'zuo ying qu', 'ux122 ux117 ux111 ux121 ux105 ux110 ux103 ux113 ux24038 ux33829 ux21306', 0, 0),
(3255, 3245, '710210', '楠梓区', 3, '00886', '区', 100, 'nan zi qu', 'ux110 ux97 ux122 ux105 ux113 ux117 ux26976 ux26771 ux21306', 0, 0),
(3256, 3245, '710211', '小港区', 3, '00886', '区', 100, 'xiao gang qu', 'ux120 ux105 ux97 ux111 ux103 ux110 ux113 ux117 ux23567 ux28207 ux21306', 0, 0),
(3257, 3231, '710300', '基隆市', 2, '00886', '市', 100, 'ji long shi', 'ux106 ux105 ux108 ux111 ux110 ux103 ux115 ux104 ux22522 ux38534 ux24066', 0, 0),
(3258, 3257, '710301', '仁爱区', 3, '00886', '区', 100, 'ren ai qu', 'ux114 ux101 ux110 ux97 ux105 ux113 ux117 ux20161 ux29233 ux21306', 0, 0),
(3259, 3257, '710302', '信义区', 3, '00886', '区', 100, 'xin yi qu', 'ux120 ux105 ux110 ux121 ux113 ux117 ux20449 ux20041 ux21306', 0, 0),
(3260, 3257, '710303', '中正区', 3, '00886', '区', 100, 'zhong zheng qu', 'ux122 ux104 ux111 ux110 ux103 ux101 ux113 ux117 ux20013 ux27491 ux21306', 0, 0),
(3261, 3257, '710304', '中山区', 3, '00886', '区', 100, 'zhong shan qu', 'ux122 ux104 ux111 ux110 ux103 ux115 ux97 ux113 ux117 ux20013 ux23665 ux21306', 0, 0),
(3262, 3257, '710305', '安乐区', 3, '00886', '区', 100, 'an le qu', 'ux97 ux110 ux108 ux101 ux113 ux117 ux23433 ux20048 ux21306', 0, 0),
(3263, 3257, '710306', '暖暖区', 3, '00886', '区', 100, 'nuan nuan qu', 'ux110 ux117 ux97 ux113 ux26262 ux21306', 0, 0),
(3264, 3257, '710307', '七堵区', 3, '00886', '区', 100, 'qi du qu', 'ux113 ux105 ux100 ux117 ux19971 ux22581 ux21306', 0, 0),
(3265, 3231, '710400', '台中市', 2, '00886', '市', 100, 'tai zhong shi', 'ux116 ux97 ux105 ux122 ux104 ux111 ux110 ux103 ux115 ux21488 ux20013 ux24066', 0, 0),
(3266, 3265, '710401', '中区', 3, '00886', '区', 100, 'zhong qu', 'ux122 ux104 ux111 ux110 ux103 ux113 ux117 ux20013 ux21306', 0, 0),
(3267, 3265, '710402', '东区', 3, '00886', '区', 100, 'dong qu', 'ux100 ux111 ux110 ux103 ux113 ux117 ux19996 ux21306', 0, 0),
(3268, 3265, '710403', '南区', 3, '00886', '区', 100, 'nan qu', 'ux110 ux97 ux113 ux117 ux21335 ux21306', 0, 0),
(3269, 3265, '710404', '西区', 3, '00886', '区', 100, 'xi qu', 'ux120 ux105 ux113 ux117 ux35199 ux21306', 0, 0),
(3270, 3265, '710405', '北区', 3, '00886', '区', 100, 'bei qu', 'ux98 ux101 ux105 ux113 ux117 ux21271 ux21306', 0, 0),
(3271, 3265, '710406', '北屯区', 3, '00886', '区', 100, 'bei tun qu', 'ux98 ux101 ux105 ux116 ux117 ux110 ux113 ux21271 ux23663 ux21306', 0, 0),
(3272, 3265, '710407', '西屯区', 3, '00886', '区', 100, 'xi tun qu', 'ux120 ux105 ux116 ux117 ux110 ux113 ux35199 ux23663 ux21306', 0, 0),
(3273, 3265, '710408', '南屯区', 3, '00886', '区', 100, 'nan tun qu', 'ux110 ux97 ux116 ux117 ux113 ux21335 ux23663 ux21306', 0, 0),
(3274, 3231, '710500', '台南市', 2, '00886', '市', 100, 'tai nan shi', 'ux116 ux97 ux105 ux110 ux115 ux104 ux21488 ux21335 ux24066', 0, 0),
(3275, 3274, '710501', '中西区', 3, '00886', '区', 100, 'zhong xi qu', 'ux122 ux104 ux111 ux110 ux103 ux120 ux105 ux113 ux117 ux20013 ux35199 ux21306', 0, 0),
(3276, 3274, '710502', '东区', 3, '00886', '区', 100, 'dong qu', 'ux100 ux111 ux110 ux103 ux113 ux117 ux19996 ux21306', 0, 0),
(3277, 3274, '710503', '南区', 3, '00886', '区', 100, 'nan qu', 'ux110 ux97 ux113 ux117 ux21335 ux21306', 0, 0),
(3278, 3274, '710504', '北区', 3, '00886', '区', 100, 'bei qu', 'ux98 ux101 ux105 ux113 ux117 ux21271 ux21306', 0, 0),
(3279, 3274, '710505', '安平区', 3, '00886', '区', 100, 'an ping qu', 'ux97 ux110 ux112 ux105 ux103 ux113 ux117 ux23433 ux24179 ux21306', 0, 0),
(3280, 3274, '710506', '安南区', 3, '00886', '区', 100, 'an nan qu', 'ux97 ux110 ux113 ux117 ux23433 ux21335 ux21306', 0, 0),
(3281, 3231, '710600', '新竹市', 2, '00886', '市', 100, 'xin zhu shi', 'ux120 ux105 ux110 ux122 ux104 ux117 ux115 ux26032 ux31481 ux24066', 0, 0),
(3282, 3281, '710601', '东区', 3, '00886', '区', 100, 'dong qu', 'ux100 ux111 ux110 ux103 ux113 ux117 ux19996 ux21306', 0, 0),
(3283, 3281, '710602', '北区', 3, '00886', '区', 100, 'bei qu', 'ux98 ux101 ux105 ux113 ux117 ux21271 ux21306', 0, 0),
(3284, 3281, '710603', '香山区', 3, '00886', '区', 100, 'xiang shan qu', 'ux120 ux105 ux97 ux110 ux103 ux115 ux104 ux113 ux117 ux39321 ux23665 ux21306', 0, 0),
(3285, 3231, '710700', '嘉义市', 2, '00886', '市', 100, 'jia yi shi', 'ux106 ux105 ux97 ux121 ux115 ux104 ux22025 ux20041 ux24066', 0, 0),
(3286, 3285, '710701', '东区', 3, '00886', '区', 100, 'dong qu', 'ux100 ux111 ux110 ux103 ux113 ux117 ux19996 ux21306', 0, 0),
(3287, 3285, '710702', '西区', 3, '00886', '区', 100, 'xi qu', 'ux120 ux105 ux113 ux117 ux35199 ux21306', 0, 0),
(3288, 3231, '719000', '省直辖', 2, '00886', '市', 100, 'sheng zhi xia', 'ux115 ux104 ux101 ux110 ux103 ux122 ux105 ux120 ux97 ux30465 ux30452 ux36758', 0, 0),
(3289, 3288, '719001', '台北县', 3, '00886', '区', 100, 'tai bei xian', 'ux116 ux97 ux105 ux98 ux101 ux120 ux110 ux21488 ux21271 ux21439', 0, 0),
(3290, 3288, '719002', '宜兰县', 3, '00886', '区', 100, 'yi lan xian', 'ux121 ux105 ux108 ux97 ux110 ux120 ux23452 ux20848 ux21439', 0, 0),
(3291, 3288, '719003', '新竹县', 3, '00886', '区', 100, 'xin zhu xian', 'ux120 ux105 ux110 ux122 ux104 ux117 ux97 ux26032 ux31481 ux21439', 0, 0),
(3292, 3288, '719004', '桃园县', 3, '00886', '区', 100, 'tao yuan xian', 'ux116 ux97 ux111 ux121 ux117 ux110 ux120 ux105 ux26691 ux22253 ux21439', 0, 0),
(3293, 3288, '719005', '苗栗县', 3, '00886', '区', 100, 'miao li xian', 'ux109 ux105 ux97 ux111 ux108 ux120 ux110 ux33495 ux26647 ux21439', 0, 0),
(3294, 3288, '719006', '台中县', 3, '00886', '区', 100, 'tai zhong xian', 'ux116 ux97 ux105 ux122 ux104 ux111 ux110 ux103 ux120 ux21488 ux20013 ux21439', 0, 0),
(3295, 3288, '719007', '彰化县', 3, '00886', '区', 100, 'zhang hua xian', 'ux122 ux104 ux97 ux110 ux103 ux117 ux120 ux105 ux24432 ux21270 ux21439', 0, 0),
(3296, 3288, '719008', '南投县', 3, '00886', '区', 100, 'nan tou xian', 'ux110 ux97 ux116 ux111 ux117 ux120 ux105 ux21335 ux25237 ux21439', 0, 0),
(3297, 3288, '719009', '嘉义县', 3, '00886', '区', 100, 'jia yi xian', 'ux106 ux105 ux97 ux121 ux120 ux110 ux22025 ux20041 ux21439', 0, 0),
(3298, 3288, '719010', '云林县', 3, '00886', '区', 100, 'yun lin xian', 'ux121 ux117 ux110 ux108 ux105 ux120 ux97 ux20113 ux26519 ux21439', 0, 0),
(3299, 3288, '719011', '台南县', 3, '00886', '区', 100, 'tai nan xian', 'ux116 ux97 ux105 ux110 ux120 ux21488 ux21335 ux21439', 0, 0),
(3300, 3288, '719012', '高雄县', 3, '00886', '区', 100, 'gao xiong xian', 'ux103 ux97 ux111 ux120 ux105 ux110 ux39640 ux38596 ux21439', 0, 0),
(3301, 3288, '719013', '屏东县', 3, '00886', '区', 100, 'ping dong xian', 'ux112 ux105 ux110 ux103 ux100 ux111 ux120 ux97 ux23631 ux19996 ux21439', 0, 0),
(3302, 3288, '719014', '台东县', 3, '00886', '区', 100, 'tai dong xian', 'ux116 ux97 ux105 ux100 ux111 ux110 ux103 ux120 ux21488 ux19996 ux21439', 0, 0),
(3303, 3288, '719015', '花莲县', 3, '00886', '区', 100, 'hua lian xian', 'ux104 ux117 ux97 ux108 ux105 ux110 ux120 ux33457 ux33714 ux21439', 0, 0),
(3304, 3288, '719016', '澎湖县', 3, '00886', '区', 100, 'peng hu xian', 'ux112 ux101 ux110 ux103 ux104 ux117 ux120 ux105 ux97 ux28558 ux28246 ux21439', 0, 0),
(3305, 0, '810000', '香港特别行政区', 1, '', '省', 100, 'xiang gang te bie xing zheng qu', 'ux120 ux105 ux97 ux110 ux103 ux116 ux101 ux98 ux122 ux104 ux113 ux117 ux39321 ux28207 ux29305 ux21035 ux34892 ux25919 ux21306', 0, 0),
(3306, 3305, '810100', '香港岛', 2, '00852', '市', 100, 'xiang gang dao', 'ux120 ux105 ux97 ux110 ux103 ux100 ux111 ux39321 ux28207 ux23707', 0, 0),
(3307, 3306, '810101', '中西区', 3, '00852', '区', 100, 'zhong xi qu', 'ux122 ux104 ux111 ux110 ux103 ux120 ux105 ux113 ux117 ux20013 ux35199 ux21306', 0, 0),
(3308, 3306, '810102', '湾仔区', 3, '00852', '区', 100, 'wan zi qu', 'ux119 ux97 ux110 ux122 ux105 ux113 ux117 ux28286 ux20180 ux21306', 0, 0),
(3309, 3306, '810103', '东区', 3, '00852', '区', 100, 'dong qu', 'ux100 ux111 ux110 ux103 ux113 ux117 ux19996 ux21306', 0, 0),
(3310, 3306, '810104', '南区', 3, '00852', '区', 100, 'nan qu', 'ux110 ux97 ux113 ux117 ux21335 ux21306', 0, 0),
(3311, 3305, '810200', '九龙', 2, '00852', '市', 100, 'jiu long', 'ux106 ux105 ux117 ux108 ux111 ux110 ux103 ux20061 ux40857', 0, 0),
(3312, 3311, '810201', '油尖旺区', 3, '00852', '区', 100, 'you jian wang qu', 'ux121 ux111 ux117 ux106 ux105 ux97 ux110 ux119 ux103 ux113 ux27833 ux23574 ux26106 ux21306', 0, 0),
(3313, 3311, '810202', '深水埗区', 3, '00852', '区', 100, 'shen shui bu qu', 'ux115 ux104 ux101 ux110 ux117 ux105 ux98 ux113 ux28145 ux27700 ux22487 ux21306', 0, 0),
(3314, 3311, '810203', '九龙城区', 3, '00852', '区', 100, 'jiu long cheng qu', 'ux106 ux105 ux117 ux108 ux111 ux110 ux103 ux99 ux104 ux101 ux113 ux20061 ux40857 ux22478 ux21306', 0, 0),
(3315, 3311, '810204', '黄大仙区', 3, '00852', '区', 100, 'huang da xian qu', 'ux104 ux117 ux97 ux110 ux103 ux100 ux120 ux105 ux113 ux40644 ux22823 ux20185 ux21306', 0, 0),
(3316, 3311, '810205', '观塘区', 3, '00852', '区', 100, 'guan tang qu', 'ux103 ux117 ux97 ux110 ux116 ux113 ux35266 ux22616 ux21306', 0, 0),
(3317, 3305, '810300', '新界', 2, '00852', '市', 100, 'xin jie', 'ux120 ux105 ux110 ux106 ux101 ux26032 ux30028', 0, 0),
(3318, 3317, '810301', '北区', 3, '00852', '区', 100, 'bei qu', 'ux98 ux101 ux105 ux113 ux117 ux21271 ux21306', 0, 0),
(3319, 3317, '810302', '大埔区', 3, '00852', '区', 100, 'da pu qu', 'ux100 ux97 ux112 ux117 ux113 ux22823 ux22484 ux21306', 0, 0),
(3320, 3317, '810303', '沙田区', 3, '00852', '区', 100, 'sha tian qu', 'ux115 ux104 ux97 ux116 ux105 ux110 ux113 ux117 ux27801 ux30000 ux21306', 0, 0),
(3321, 3317, '810304', '西贡区', 3, '00852', '区', 100, 'xi gong qu', 'ux120 ux105 ux103 ux111 ux110 ux113 ux117 ux35199 ux36129 ux21306', 0, 0),
(3322, 3317, '810305', '荃湾区', 3, '00852', '区', 100, 'quan wan qu', 'ux113 ux117 ux97 ux110 ux119 ux33603 ux28286 ux21306', 0, 0),
(3323, 3317, '810306', '屯门区', 3, '00852', '区', 100, 'tun men qu', 'ux116 ux117 ux110 ux109 ux101 ux113 ux23663 ux38376 ux21306', 0, 0),
(3324, 3317, '810307', '元朗区', 3, '00852', '区', 100, 'yuan lang qu', 'ux121 ux117 ux97 ux110 ux108 ux103 ux113 ux20803 ux26391 ux21306', 0, 0),
(3325, 3317, '810308', '葵青区', 3, '00852', '区', 100, 'kui qing qu', 'ux107 ux117 ux105 ux113 ux110 ux103 ux33909 ux38738 ux21306', 0, 0),
(3326, 3317, '810309', '离岛区', 3, '00852', '区', 100, 'li dao qu', 'ux108 ux105 ux100 ux97 ux111 ux113 ux117 ux31163 ux23707 ux21306', 0, 0),
(3327, 0, '820000', '澳门特别行政区', 1, '', '省', 100, 'ao men te bie xing zheng qu', 'ux97 ux111 ux109 ux101 ux110 ux116 ux98 ux105 ux120 ux103 ux122 ux104 ux113 ux117 ux28595 ux38376 ux29305 ux21035 ux34892 ux25919 ux21306', 0, 0),
(3328, 3327, '820100', '澳门半岛', 2, '00853', '市', 100, 'ao men ban dao', 'ux97 ux111 ux109 ux101 ux110 ux98 ux100 ux28595 ux38376 ux21322 ux23707', 0, 0),
(3329, 3328, '820101', '花地玛堂区', 3, '00853', '区', 100, 'hua di ma tang qu', 'ux104 ux117 ux97 ux100 ux105 ux109 ux116 ux110 ux103 ux113 ux33457 ux22320 ux29595 ux22530 ux21306', 0, 0),
(3330, 3328, '820102', '圣安多尼堂区', 3, '00853', '区', 100, 'sheng an duo ni tang qu', 'ux115 ux104 ux101 ux110 ux103 ux97 ux100 ux117 ux111 ux105 ux116 ux113 ux22307 ux23433 ux22810 ux23612 ux22530 ux21306', 0, 0),
(3331, 3328, '820103', '大堂区', 3, '00853', '区', 100, 'da tang qu', 'ux100 ux97 ux116 ux110 ux103 ux113 ux117 ux22823 ux22530 ux21306', 0, 0),
(3332, 3328, '820104', '望德堂区', 3, '00853', '区', 100, 'wang de tang qu', 'ux119 ux97 ux110 ux103 ux100 ux101 ux116 ux113 ux117 ux26395 ux24503 ux22530 ux21306', 0, 0),
(3333, 3328, '820105', '风顺堂区', 3, '00853', '区', 100, 'feng shun tang qu', 'ux102 ux101 ux110 ux103 ux115 ux104 ux117 ux116 ux97 ux113 ux39118 ux39034 ux22530 ux21306', 0, 0),
(3334, 3327, '820200', '澳门离岛', 2, '00853', '市', 100, 'ao men li dao', 'ux97 ux111 ux109 ux101 ux110 ux108 ux105 ux100 ux28595 ux38376 ux31163 ux23707', 0, 0),
(3335, 3334, '820201', '嘉模堂区', 3, '00853', '区', 100, 'jia mo tang qu', 'ux106 ux105 ux97 ux109 ux111 ux116 ux110 ux103 ux113 ux117 ux22025 ux27169 ux22530 ux21306', 0, 0),
(3336, 3334, '820202', '圣方济各堂区', 3, '00853', '区', 100, 'sheng fang ji ge tang qu', 'ux115 ux104 ux101 ux110 ux103 ux102 ux97 ux106 ux105 ux116 ux113 ux117 ux22307 ux26041 ux27982 ux21508 ux22530 ux21306', 0, 0),
(3337, 3327, '820300', '无堂区划分区域', 2, '00853', '市', 100, 'wu tang qu hua fen qu yu', 'ux119 ux117 ux116 ux97 ux110 ux103 ux113 ux104 ux102 ux101 ux121 ux26080 ux22530 ux21306 ux21010 ux20998 ux22495', 0, 0),
(3338, 3337, '820301', '路氹城', 3, '00853', '区', 100, 'lu dang cheng', 'ux108 ux117 ux100 ux97 ux110 ux103 ux99 ux104 ux101 ux36335 ux27705 ux22478', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%repair`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%repair` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) DEFAULT NULL COMMENT '商家编号',
  `district_id` int(11) DEFAULT NULL COMMENT '小区编号',
  `build_id` int(11) DEFAULT NULL COMMENT '楼栋号',
  `room_id` int(11) DEFAULT NULL COMMENT '房间号',
  `puser_id` int(11) DEFAULT NULL COMMENT '业主信息编号',
  `user_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `type` varchar(20) DEFAULT NULL COMMENT '类型',
  `content` text COMMENT '内容',
  `images` text COMMENT '图片',
  `status` tinyint(1) DEFAULT '0' COMMENT '0待处理1处理中2已完成',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `dispose_time` int(11) DEFAULT NULL COMMENT '处理时间',
  `finish_time` int(11) DEFAULT NULL COMMENT '完成时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报修表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%repair_type`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%repair_type` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报修类型';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%room_fee`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%room_fee` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业公司编号',
  `district_id` int(11) DEFAULT '0' COMMENT '小区编号',
  `build_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼栋编号',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间编号',
  `payitem_id` int(11) DEFAULT '0' COMMENT '收费项目编号',
  `puser_id` int(11) DEFAULT '0' COMMENT '物业的业主编号',
  `fee` double(10,2) DEFAULT NULL COMMENT '总费用',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='房间应缴物业费';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller` (
  `id` int(11) NOT NULL COMMENT '编号',
  `user_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `name_match` text,
  `type` tinyint(1) DEFAULT NULL COMMENT '1自营2机构3物业公司',
  `logo` varchar(500) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL COMMENT '商家背景图',
  `mobile` varchar(20) DEFAULT '',
  `service_tel` varchar(20) DEFAULT NULL COMMENT '客服电话',
  `contacts` varchar(60) DEFAULT NULL COMMENT '负责人',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `address_detail` varchar(100) DEFAULT NULL,
  `province_id` mediumint(8) DEFAULT NULL COMMENT '所在省',
  `city_id` mediumint(8) DEFAULT NULL COMMENT '所在市',
  `area_id` mediumint(8) DEFAULT NULL COMMENT '所在县',
  `sort` smallint(6) DEFAULT '100',
  `business_desc` varchar(500) DEFAULT '' COMMENT '营业说明',
  `status` int(1) DEFAULT '1' COMMENT '状态',
  `create_time` int(11) DEFAULT NULL,
  `create_day` int(11) DEFAULT NULL,
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除0否1是',
  `brief` varchar(500) DEFAULT NULL COMMENT '简介',
  `is_authshow` tinyint(1) DEFAULT '0' COMMENT '审核删除0否1是',
  `map_point` point DEFAULT NULL COMMENT '地图坐标',
  `map_point_str` varchar(60) DEFAULT NULL COMMENT '地图坐标字符串',
  `map_pos` polygon DEFAULT NULL,
  `map_pos_str` text,
  `is_check` tinyint(1) DEFAULT '0' COMMENT '审核状态0待审核1通过-1拒绝',
  `check_val` varchar(500) DEFAULT NULL COMMENT '审核原因',
  `is_authenticate` tinyint(1) DEFAULT '0' COMMENT '是否认证0未认证1已认证',
  `is_cash_on_delivery` tinyint(1) DEFAULT '0' COMMENT '货到付款 ',
  `service_fee` double(10,2) DEFAULT '0.00' COMMENT '起送费',
  `delivery_fee` double(10,2) DEFAULT '0.00' COMMENT '配送费',
  `delivery_time` varchar(100) DEFAULT NULL COMMENT '配送时段',
  `deduct` double(5,2) DEFAULT '0.00' COMMENT '佣金',
  `goods_keywords` text COMMENT '商品关键字 格式（aaa|abc|xyz|）',
  `is_avoid_fee` tinyint(4) DEFAULT '0' COMMENT '是否设置满减',
  `avoid_fee` double DEFAULT NULL COMMENT '满X免运费',
  `send_way` varchar(255) DEFAULT '1' COMMENT '配送方式:1商家配送,2到店消费,3到店自提',
  `reserve_days` tinyint(4) DEFAULT '1' COMMENT '可预约天数:最大30天（不包含当天），默认1天',
  `send_loop` int(11) DEFAULT '30' COMMENT '配送周期：分钟，默认30分钟',
  `first_level` int(11) DEFAULT NULL COMMENT '一级代理',
  `second_level` int(11) DEFAULT NULL COMMENT '二级代理',
  `third_level` int(11) DEFAULT NULL COMMENT '三级代理',
  `business_scope` text COMMENT '经营范围',
  `service_mode` tinyint(1) DEFAULT '1' COMMENT '1上门,2到店',
  `service_way` varchar(255) DEFAULT '1' COMMENT '服务方式:1上门服务,2到店消费',
  `store_type` tinyint(4) DEFAULT '0' COMMENT '是否是全国店：1是（全国店） 0：否（周边店）',
  `refund_address` varchar(255) DEFAULT NULL COMMENT '退款地址',
  `seller_cancel` int(11) DEFAULT '0' COMMENT '卖家取消订单次数',
  `user_cancel` int(11) DEFAULT '0' COMMENT '客户取消订单次数',
  `passage_id` varchar(50) DEFAULT NULL COMMENT '分销通道ID，distribution-三级分销返佣;channel-渠道返佣;agent-区域代理返佣;等等',
  `scheme_id` tinyint(4) DEFAULT '1' COMMENT '分销方案编号:1=默认',
  `limit_money` int(11) DEFAULT '0' COMMENT '分销金额上限，不传或为0表示不设上限',
  `send_type` tinyint(4) DEFAULT NULL COMMENT '配送方式：null=无上门服务 1=配送托管 2=平台众包',
  `send_fee` double(10,2) unsigned DEFAULT '0.00' COMMENT '配送服务费',
  `send_staff_fee` double(10,2) unsigned DEFAULT '0.00' COMMENT '服务人员得的配送服务费',
  `send_system_fee` double(10,2) unsigned DEFAULT '0.00' COMMENT '系统得的服务配送费',
  `is_cancel_call` tinyint(1) unsigned DEFAULT '0' COMMENT '是否取消过呼叫配送 0=未使用 1=使用过了'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='服务站';

--
-- 转存表中的数据 `%DB_PREFIX%seller`
--

INSERT INTO `%DB_PREFIX%seller` (`id`, `user_id`, `name`, `name_match`, `type`, `logo`, `image`, `mobile`, `service_tel`, `contacts`, `address`, `address_detail`, `province_id`, `city_id`, `area_id`, `sort`, `business_desc`, `status`, `create_time`, `create_day`, `is_del`, `brief`, `is_authshow`, `map_point`, `map_point_str`, `map_pos`, `map_pos_str`, `is_check`, `check_val`, `is_authenticate`, `is_cash_on_delivery`, `service_fee`, `delivery_fee`, `delivery_time`, `deduct`, `goods_keywords`, `is_avoid_fee`, `avoid_fee`, `send_way`, `reserve_days`, `send_loop`, `first_level`, `second_level`, `third_level`, `business_scope`, `service_mode`, `service_way`, `store_type`, `refund_address`, `seller_cancel`, `user_cancel`, `passage_id`, `scheme_id`, `limit_money`, `send_type`, `send_fee`, `send_staff_fee`, `send_system_fee`, `is_cancel_call`) VALUES
(1, 1, '自营商家', 'ux33258 ux33829 ux21830 ux23478 ux49 ux56 ux57 ux56 ux57 ux56 ux57 ux56 ux57 ux56 ux57', 2, 'http://image.jikesoft.com/seller/0000/0000/001/2016-12-07/ce577d8b0beae40fac84695d5ef38a37.jpg', 'http://image.jikesoft.com/seller/0000/0000/004/2016-12-07/fa69828fe1803660ae2990b0e4eec5f8.jpg', '18989898989', '', '', '天安门', NULL, 0, 0, 0, 100, '', 1, 1481074723, 1481011200, 0, '', 0, '\0\0\0\0\0\0\0?RD�U�C@zpw�n]@', '39.90886,116.39739', '\0\0\0\0\0\0\0\0\0\0\0\0\0l�����C@$�j�$]@l�����C@E����]@��E���C@�0��]@��E���C@�1��]@l�����C@$�j�$]@', '39.913285319545,116.39286837991|39.913285319545,116.40319651536|39.904434475025,116.40191173385|39.904434475025,116.3915835984', 1, NULL, 0, 0, 0.00, 0.00, NULL, 0.00, NULL, 0, NULL, '1', 1, 30, NULL, NULL, NULL, 'YTozNTU6e2k6MDtzOjE6IjEiO2k6MTtzOjI6IjE4IjtpOjI7czoyOiIzNiI7aTozO3M6MjoiNjAiO2k6NDtzOjI6Ijc1IjtpOjU7czoyOiI4MyI7aTo2O3M6MzoiMTAzIjtpOjc7czozOiIxMjMiO2k6ODtzOjM6IjE0OSI7aTo5O3M6MzoiMTY3IjtpOjEwO3M6MzoiMTc5IjtpOjExO3M6MzoiMTk2IjtpOjEyO3M6MzoiMjA3IjtpOjEzO3M6MzoiMjIwIjtpOjE0O3M6MzoiMjMxIjtpOjE1O3M6MzoiMjQzIjtpOjE2O3M6MzoiMjQ5IjtpOjE3O3M6MzoiMjYzIjtpOjE4O3M6MzoiMjcwIjtpOjE5O3M6MzoiMjc3IjtpOjIwO3M6MzoiMjg5IjtpOjIxO3M6MzoiMzAzIjtpOjIyO3M6MzoiMzE4IjtpOjIzO3M6MzoiMzM2IjtpOjI0O3M6MzoiMzUxIjtpOjI1O3M6MzoiMzYxIjtpOjI2O3M6MzoiMzcxIjtpOjI3O3M6MzoiMzc1IjtpOjI4O3M6MzoiMzg4IjtpOjI5O3M6MzoiMzk3IjtpOjMwO3M6MzoiNDA2IjtpOjMxO3M6MzoiNDIwIjtpOjMyO3M6MzoiNDI4IjtpOjMzO3M6MzoiNDQwIjtpOjM0O3M6MzoiNDQ3IjtpOjM1O3M6MzoiNDYwIjtpOjM2O3M6MzoiNDY1IjtpOjM3O3M6MzoiNDc5IjtpOjM4O3M6MzoiNDkwIjtpOjM5O3M6MzoiNDk4IjtpOjQwO3M6MzoiNTA2IjtpOjQxO3M6MzoiNTEzIjtpOjQyO3M6MzoiNTIwIjtpOjQzO3M6MzoiNTI4IjtpOjQ0O3M6MzoiNTM1IjtpOjQ1O3M6MzoiNTQzIjtpOjQ2O3M6MzoiNTUxIjtpOjQ3O3M6MzoiNTU2IjtpOjQ4O3M6MzoiNTY0IjtpOjQ5O3M6MzoiNTcyIjtpOjUwO3M6MzoiNTgwIjtpOjUxO3M6MzoiNTkxIjtpOjUyO3M6MzoiNjAxIjtpOjUzO3M6MzoiNjA4IjtpOjU0O3M6MzoiNjEzIjtpOjU1O3M6MzoiNjIxIjtpOjU2O3M6MzoiNjI4IjtpOjU3O3M6MzoiNjM0IjtpOjU4O3M6MzoiNjQwIjtpOjU5O3M6MzoiNjUwIjtpOjYwO3M6MzoiNjY5IjtpOjYxO3M6MzoiNjg2IjtpOjYyO3M6MzoiNjk2IjtpOjYzO3M6MzoiNzA1IjtpOjY0O3M6MzoiNzE0IjtpOjY1O3M6MzoiNzI0IjtpOjY2O3M6MzoiNzQyIjtpOjY3O3M6MzoiNzUzIjtpOjY4O3M6MzoiNzU4IjtpOjY5O3M6MzoiNzY5IjtpOjcwO3M6MzoiNzc2IjtpOjcxO3M6MzoiNzg3IjtpOjcyO3M6MzoiNzk1IjtpOjczO3M6MzoiODE0IjtpOjc0O3M6MzoiODI4IjtpOjc1O3M6MzoiODM3IjtpOjc2O3M6MzoiODQ4IjtpOjc3O3M6MzoiODU2IjtpOjc4O3M6MzoiODY2IjtpOjc5O3M6MzoiODc1IjtpOjgwO3M6MzoiODgzIjtpOjgxO3M6MzoiODkyIjtpOjgyO3M6MzoiOTAyIjtpOjgzO3M6MzoiOTA5IjtpOjg0O3M6MzoiOTE2IjtpOjg1O3M6MzoiOTIzIjtpOjg2O3M6MzoiOTMwIjtpOjg3O3M6MzoiOTQ0IjtpOjg4O3M6MzoiOTU2IjtpOjg5O3M6MzoiOTY4IjtpOjkwO3M6MzoiOTc2IjtpOjkxO3M6MzoiOTgyIjtpOjkyO3M6MzoiOTg5IjtpOjkzO3M6MzoiOTk5IjtpOjk0O3M6NDoiMTAwNiI7aTo5NTtzOjQ6IjEwMTEiO2k6OTY7czo0OiIxMDIxIjtpOjk3O3M6NDoiMTAzMiI7aTo5ODtzOjQ6IjEwNDIiO2k6OTk7czo0OiIxMDUxIjtpOjEwMDtzOjQ6IjEwNTkiO2k6MTAxO3M6NDoiMTA2NiI7aToxMDI7czo0OiIxMDczIjtpOjEwMztzOjQ6IjEwNzgiO2k6MTA0O3M6NDoiMTA4MyI7aToxMDU7czo0OiIxMDk1IjtpOjEwNjtzOjQ6IjExMDMiO2k6MTA3O3M6NDoiMTExMiI7aToxMDg7czo0OiIxMTIxIjtpOjEwOTtzOjQ6IjExMjciO2k6MTEwO3M6NDoiMTEzNSI7aToxMTE7czo0OiIxMTQwIjtpOjExMjtzOjQ6IjExNDUiO2k6MTEzO3M6NDoiMTE1NCI7aToxMTQ7czo0OiIxMTY4IjtpOjExNTtzOjQ6IjExNzUiO2k6MTE2O3M6NDoiMTE4MSI7aToxMTc7czo0OiIxMTk0IjtpOjExODtzOjQ6IjEyMDciO2k6MTE5O3M6NDoiMTIxOSI7aToxMjA7czo0OiIxMjMwIjtpOjEyMTtzOjQ6IjEyMzgiO2k6MTIyO3M6NDoiMTI0OSI7aToxMjM7czo0OiIxMjU5IjtpOjEyNDtzOjQ6IjEyNjQiO2k6MTI1O3M6NDoiMTI3MCI7aToxMjY7czo0OiIxMjg0IjtpOjEyNztzOjQ6IjEyODciO2k6MTI4O3M6NDoiMTI5MSI7aToxMjk7czo0OiIxMzEwIjtpOjEzMDtzOjQ6IjEzMjQiO2k6MTMxO3M6NDoiMTMzNSI7aToxMzI7czo0OiIxMzQ3IjtpOjEzMztzOjQ6IjEzNjEiO2k6MTM0O3M6NDoiMTM3MiI7aToxMzU7czo0OiIxMzg1IjtpOjEzNjtzOjQ6IjEzOTQiO2k6MTM3O3M6NDoiMTQwMSI7aToxMzg7czo0OiIxNDA3IjtpOjEzOTtzOjQ6IjE0MjAiO2k6MTQwO3M6NDoiMTQzMyI7aToxNDE7czo0OiIxNDQ2IjtpOjE0MjtzOjQ6IjE0NTMiO2k6MTQzO3M6NDoiMTQ1OCI7aToxNDQ7czo0OiIxNDYzIjtpOjE0NTtzOjQ6IjE0NjYiO2k6MTQ2O3M6NDoiMTQ3OSI7aToxNDc7czo0OiIxNDkxIjtpOjE0ODtzOjQ6IjE1MDAiO2k6MTQ5O3M6NDoiMTUwOCI7aToxNTA7czo0OiIxNTE5IjtpOjE1MTtzOjQ6IjE1MzIiO2k6MTUyO3M6NDoiMTU0MyI7aToxNTM7czo0OiIxNTU5IjtpOjE1NDtzOjQ6IjE1NzAiO2k6MTU1O3M6NDoiMTU4MCI7aToxNTY7czo0OiIxNTg2IjtpOjE1NztzOjQ6IjE1OTkiO2k6MTU4O3M6NDoiMTYxMCI7aToxNTk7czo0OiIxNjE3IjtpOjE2MDtzOjQ6IjE2MjQiO2k6MTYxO3M6NDoiMTYzMCI7aToxNjI7czo0OiIxNjM3IjtpOjE2MztzOjQ6IjE2NTEiO2k6MTY0O3M6NDoiMTY2MSI7aToxNjU7czo0OiIxNjcyIjtpOjE2NjtzOjQ6IjE2ODMiO2k6MTY3O3M6NDoiMTY5NCI7aToxNjg7czo0OiIxNjk3IjtpOjE2OTtzOjQ6IjE3MTEiO2k6MTcwO3M6NDoiMTcxOCI7aToxNzE7czo0OiIxNzI3IjtpOjE3MjtzOjQ6IjE3NDEiO2k6MTczO3M6NDoiMTc1MSI7aToxNzQ7czo0OiIxNzU1IjtpOjE3NTtzOjQ6IjE3NjEiO2k6MTc2O3M6NDoiMTc2OSI7aToxNzc7czo0OiIxNzc4IjtpOjE3ODtzOjQ6IjE3ODkiO2k6MTc5O3M6NDoiMTc5NiI7aToxODA7czo0OiIxODAwIjtpOjE4MTtzOjQ6IjE4MDkiO2k6MTgyO3M6NDoiMTgxNSI7aToxODM7czo0OiIxODI1IjtpOjE4NDtzOjQ6IjE4MzUiO2k6MTg1O3M6NDoiMTg0MSI7aToxODY7czo0OiIxODU0IjtpOjE4NztzOjQ6IjE4NjciO2k6MTg4O3M6NDoiMTg3NyI7aToxODk7czo0OiIxODg3IjtpOjE5MDtzOjQ6IjE4OTIiO2k6MTkxO3M6NDoiMTg5OSI7aToxOTI7czo0OiIxOTExIjtpOjE5MztzOjQ6IjE5MjMiO2k6MTk0O3M6NDoiMTkzNiI7aToxOTU7czo0OiIxOTQyIjtpOjE5NjtzOjQ6IjE5NTIiO2k6MTk3O3M6NDoiMTk2NSI7aToxOTg7czo0OiIxOTc2IjtpOjE5OTtzOjQ6IjE5ODMiO2k6MjAwO3M6NDoiMTk4NyI7aToyMDE7czo0OiIxOTk1IjtpOjIwMjtzOjQ6IjIwMDEiO2k6MjAzO3M6NDoiMjAwOSI7aToyMDQ7czo0OiIyMDE5IjtpOjIwNTtzOjQ6IjIwMjYiO2k6MjA2O3M6NDoiMjAzNSI7aToyMDc7czo0OiIyMDQxIjtpOjIwODtzOjQ6IjIwNTAiO2k6MjA5O3M6NDoiMjA1NSI7aToyMTA7czo0OiIyMDYyIjtpOjIxMTtzOjQ6IjIwNjciO2k6MjEyO3M6NDoiMjA3NiI7aToyMTM7czo0OiIyMDc4IjtpOjIxNDtzOjQ6IjIwODAiO2k6MjE1O3M6NDoiMjA4NCI7aToyMTY7czo0OiIyMDkwIjtpOjIxNztzOjQ6IjIwOTciO2k6MjE4O3M6NDoiMjExMCI7aToyMTk7czo0OiIyMTIxIjtpOjIyMDtzOjQ6IjIxMzkiO2k6MjIxO3M6NDoiMjE0NyI7aToyMjI7czo0OiIyMTUyIjtpOjIyMztzOjQ6IjIxNTciO2k6MjI0O3M6NDoiMjE2MiI7aToyMjU7czo0OiIyMTY4IjtpOjIyNjtzOjQ6IjIxNzUiO2k6MjI3O3M6NDoiMjE4OCI7aToyMjg7czo0OiIyMTk0IjtpOjIyOTtzOjQ6IjIyMDYiO2k6MjMwO3M6NDoiMjIxMyI7aToyMzE7czo0OiIyMjIyIjtpOjIzMjtzOjQ6IjIyMjciO2k6MjMzO3M6NDoiMjIyOSI7aToyMzQ7czo0OiIyMjMzIjtpOjIzNTtzOjQ6IjIyNTAiO2k6MjM2O3M6NDoiMjI5MCI7aToyMzc7czo0OiIyMzEwIjtpOjIzODtzOjQ6IjIzMTciO2k6MjM5O3M6NDoiMjMyMyI7aToyNDA7czo0OiIyMzMxIjtpOjI0MTtzOjQ6IjIzMzgiO2k6MjQyO3M6NDoiMjM0OCI7aToyNDM7czo0OiIyMzU2IjtpOjI0NDtzOjQ6IjIzNjIiO2k6MjQ1O3M6NDoiMjM2OCI7aToyNDY7czo0OiIyMzgwIjtpOjI0NztzOjQ6IjIzOTAiO2k6MjQ4O3M6NDoiMjM5NyI7aToyNDk7czo0OiIyNDA4IjtpOjI1MDtzOjQ6IjI0MTQiO2k6MjUxO3M6NDoiMjQyMiI7aToyNTI7czo0OiIyNDMxIjtpOjI1MztzOjQ6IjI0MzYiO2k6MjU0O3M6NDoiMjQ0MSI7aToyNTU7czo0OiIyNDU1IjtpOjI1NjtzOjQ6IjI0NzQiO2k6MjU3O3M6NDoiMjQ5MyI7aToyNTg7czo0OiIyNTA0IjtpOjI1OTtzOjQ6IjI1MDkiO2k6MjYwO3M6NDoiMjUyNCI7aToyNjE7czo0OiIyNTMxIjtpOjI2MjtzOjQ6IjI1NDAiO2k6MjYzO3M6NDoiMjU1MSI7aToyNjQ7czo0OiIyNTYwIjtpOjI2NTtzOjQ6IjI1NzciO2k6MjY2O3M6NDoiMjU5MSI7aToyNjc7czo0OiIyNjA2IjtpOjI2ODtzOjQ6IjI2MTYiO2k6MjY5O3M6NDoiMjYyNiI7aToyNzA7czo0OiIyNjMyIjtpOjI3MTtzOjQ6IjI2NDQiO2k6MjcyO3M6NDoiMjY1MCI7aToyNzM7czo0OiIyNjYxIjtpOjI3NDtzOjQ6IjI2NzAiO2k6Mjc1O3M6NDoiMjY4MSI7aToyNzY7czo0OiIyNjk1IjtpOjI3NztzOjQ6IjI3MDQiO2k6Mjc4O3M6NDoiMjcwOCI7aToyNzk7czo0OiIyNzIxIjtpOjI4MDtzOjQ6IjI3MjciO2k6MjgxO3M6NDoiMjczMiI7aToyODI7czo0OiIyNzM3IjtpOjI4MztzOjQ6IjI3NDYiO2k6Mjg0O3M6NDoiMjc1OCI7aToyODU7czo0OiIyNzcxIjtpOjI4NjtzOjQ6IjI3OTAiO2k6Mjg3O3M6NDoiMjgwMSI7aToyODg7czo0OiIyODA5IjtpOjI4OTtzOjQ6IjI4MTgiO2k6MjkwO3M6NDoiMjgzMiI7aToyOTE7czo0OiIyODM3IjtpOjI5MjtzOjQ6IjI4NTAiO2k6MjkzO3M6NDoiMjg2NSI7aToyOTQ7czo0OiIyODc3IjtpOjI5NTtzOjQ6IjI4OTEiO2k6Mjk2O3M6NDoiMjkwMyI7aToyOTc7czo0OiIyOTE2IjtpOjI5ODtzOjQ6IjI5MjciO2k6Mjk5O3M6NDoiMjkzNiI7aTozMDA7czo0OiIyOTQ1IjtpOjMwMTtzOjQ6IjI5NDciO2k6MzAyO3M6NDoiMjk1MCI7aTozMDM7czo0OiIyOTU2IjtpOjMwNDtzOjQ6IjI5NjQiO2k6MzA1O3M6NDoiMjk2OSI7aTozMDY7czo0OiIyOTc2IjtpOjMwNztzOjQ6IjI5ODQiO2k6MzA4O3M6NDoiMjk5MiI7aTozMDk7czo0OiIzMDAxIjtpOjMxMDtzOjQ6IjMwMDkiO2k6MzExO3M6NDoiMzAxOSI7aTozMTI7czo0OiIzMDI4IjtpOjMxMztzOjQ6IjMwMzgiO2k6MzE0O3M6NDoiMzA0NiI7aTozMTU7czo0OiIzMDUzIjtpOjMxNjtzOjQ6IjMwNTgiO2k6MzE3O3M6NDoiMzA2MyI7aTozMTg7czo0OiIzMDY5IjtpOjMxOTtzOjQ6IjMwNzYiO2k6MzIwO3M6NDoiMzA4MyI7aTozMjE7czo0OiIzMDkwIjtpOjMyMjtzOjQ6IjMwOTciO2k6MzIzO3M6NDoiMzEwMSI7aTozMjQ7czo0OiIzMTA3IjtpOjMyNTtzOjQ6IjMxMTMiO2k6MzI2O3M6NDoiMzExOCI7aTozMjc7czo0OiIzMTI3IjtpOjMyODtzOjQ6IjMxMzIiO2k6MzI5O3M6NDoiMzEzNiI7aTozMzA7czo0OiIzMTQwIjtpOjMzMTtzOjQ6IjMxNDgiO2k6MzMyO3M6NDoiMzE1MiI7aTozMzM7czo0OiIzMTYyIjtpOjMzNDtzOjQ6IjMxNzIiO2k6MzM1O3M6NDoiMzE3NyI7aTozMzY7czo0OiIzMTkwIjtpOjMzNztzOjQ6IjMxOTkiO2k6MzM4O3M6NDoiMzIxMCI7aTozMzk7czo0OiIzMjE4IjtpOjM0MDtzOjQ6IjMyMjYiO2k6MzQxO3M6NDoiMzIzMiI7aTozNDI7czo0OiIzMjQ1IjtpOjM0MztzOjQ6IjMyNTciO2k6MzQ0O3M6NDoiMzI2NSI7aTozNDU7czo0OiIzMjc0IjtpOjM0NjtzOjQ6IjMyODEiO2k6MzQ3O3M6NDoiMzI4NSI7aTozNDg7czo0OiIzMjg4IjtpOjM0OTtzOjQ6IjMzMDYiO2k6MzUwO3M6NDoiMzMxMSI7aTozNTE7czo0OiIzMzE3IjtpOjM1MjtzOjQ6IjMzMjgiO2k6MzUzO3M6NDoiMzMzNCI7aTozNTQ7czo0OiIzMzM3Ijt9', 1, '1', 0, '', 0, 0, NULL, 1, 0, NULL, 0.00, 0.00, 0.00, 0);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_authenticate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_authenticate` (
  `seller_id` int(11) NOT NULL COMMENT '卖家编号',
  `idcard_sn` char(20) DEFAULT NULL COMMENT '身份证号码',
  `idcard_positive_img` varchar(255) DEFAULT NULL COMMENT '身份证正面',
  `idcard_negative_img` varchar(255) DEFAULT NULL COMMENT '身份证反面',
  `business_licence_img` varchar(255) DEFAULT NULL COMMENT '营业执照',
  `status` tinyint(1) DEFAULT '0' COMMENT '身份认证状态，0:待认证 1:未通过 2:已认证',
  `update_time` int(11) DEFAULT '0' COMMENT '身份认证更新时间',
  `certificate_img` varchar(255) DEFAULT NULL COMMENT '资质证书'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_auth_icon`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_auth_icon` (
  `id` int(11) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `icon` varchar(500) DEFAULT NULL COMMENT '图标',
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家分类';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_bank`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_bank` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL COMMENT '卖家编号',
  `bank` varchar(30) DEFAULT NULL COMMENT '银行名称',
  `bank_no` varchar(30) DEFAULT NULL COMMENT '银行卡号',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `mobile` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卖家银行卡';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_cate`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_cate` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '顶级编号',
  `name` varchar(300) DEFAULT NULL,
  `logo` varchar(500) DEFAULT NULL COMMENT '图标',
  `sort` smallint(5) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1',
  `type` tinyint(1) DEFAULT '1' COMMENT '类型1商品2服务'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家分类';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_cate_related`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_cate_related` (
  `seller_id` int(11) NOT NULL DEFAULT '0',
  `cate_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家分类关联';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_delivery_time`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_delivery_time` (
  `stime` char(5) NOT NULL COMMENT '开始时间如00:00',
  `etime` char(5) NOT NULL COMMENT '结束时间如：23:00',
  `seller_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家配送时间';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_extend`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_extend` (
  `seller_id` int(11) NOT NULL COMMENT '卖家编号',
  `total_money` double(10,2) DEFAULT '0.00' COMMENT '总金额',
  `money` double(10,2) DEFAULT '0.00' COMMENT '可提现金额',
  `use_money` double(10,2) DEFAULT '0.00' COMMENT '已提现金额',
  `wait_confirm_money` double(10,2) DEFAULT '0.00',
  `order_count` int(11) DEFAULT '0' COMMENT '销量',
  `collect_count` int(11) DEFAULT '0' COMMENT '被收藏次数',
  `goods_count` int(11) DEFAULT '0' COMMENT '单个商品数量',
  `goods_total_price` double(10,2) DEFAULT '0.00' COMMENT '单个商品总价',
  `goods_avg_price` double(10,2) DEFAULT '0.00' COMMENT '单个商品均价',
  `credit_rank_id` int(11) DEFAULT '1' COMMENT '信誉等级',
  `credit_score` int(11) DEFAULT '0' COMMENT '信誉得分',
  `comment_total_count` int(11) DEFAULT '0' COMMENT '评价总次数',
  `comment_specialty_total_score` int(11) DEFAULT '0' COMMENT '评价-专业总分',
  `comment_specialty_avg_score` double(2,1) DEFAULT '0.0' COMMENT '评价-专业平均分',
  `comment_communicate_total_score` int(11) DEFAULT '0' COMMENT '评价-沟通总分',
  `comment_communicate_avg_score` double(2,1) DEFAULT '0.0' COMMENT '评价-沟通平均分',
  `comment_punctuality_total_score` int(11) DEFAULT '0' COMMENT '评价-守时总分',
  `comment_punctuality_avg_score` double(2,1) DEFAULT '0.0' COMMENT '评价-守时平均分',
  `comment_good_count` int(11) DEFAULT '0' COMMENT '评价-好评数',
  `money_cycle_day` int(11) DEFAULT NULL COMMENT '提现周期',
  `comment_neutral_count` int(11) DEFAULT '0' COMMENT '评价-中评数',
  `comment_bad_count` int(11) DEFAULT '0' COMMENT '评价-差评数',
  `share_num` int(11) DEFAULT '0' COMMENT '分享数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卖家扩展信息';

--
-- 转存表中的数据 `%DB_PREFIX%seller_extend`
--

INSERT INTO `%DB_PREFIX%seller_extend` (`seller_id`, `total_money`, `money`, `use_money`, `wait_confirm_money`, `order_count`, `collect_count`, `goods_count`, `goods_total_price`, `goods_avg_price`, `credit_rank_id`, `credit_score`, `comment_total_count`, `comment_specialty_total_score`, `comment_specialty_avg_score`, `comment_communicate_total_score`, `comment_communicate_avg_score`, `comment_punctuality_total_score`, `comment_punctuality_avg_score`, `comment_good_count`, `money_cycle_day`, `comment_neutral_count`, `comment_bad_count`, `share_num`) VALUES
(1, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 0.00, 0.00, 1, 0, 0, 0, 0.0, 0, 0.0, 0, 0.0, 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_icon_related`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_icon_related` (
  `seller_id` int(11) NOT NULL DEFAULT '0',
  `icon_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家图标关联表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_map`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_map` (
  `seller_id` int(11) NOT NULL,
  `map_point` point NOT NULL,
  `map_pos` polygon NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_money_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_money_log` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `admin_id` int(11) DEFAULT NULL COMMENT '0',
  `type` char(20) DEFAULT '' COMMENT '关联类型',
  `related_id` int(11) DEFAULT '0' COMMENT '关联编号',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `balance` double(10,2) DEFAULT '0.00' COMMENT '余额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(2) DEFAULT '0' COMMENT '0 待处理 1已确认 2已拒绝'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卖家资金流水';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_pay_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_pay_log` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `admin_id` int(11) DEFAULT NULL COMMENT '0',
  `activity_id` int(11) DEFAULT NULL,
  `payment_type` char(20) DEFAULT '' COMMENT '支付方式',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `pay_account` varchar(80) DEFAULT '',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `pay_day` int(11) DEFAULT '0' COMMENT '支付时间(天)',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '付款流水号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家支付日志';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_search`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_search` (
  `id` int(11) unsigned NOT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `name` varchar(60) CHARACTER SET utf8 DEFAULT NULL COMMENT '商家名称',
  `keywords` text CHARACTER SET utf8 COMMENT '搜索关键字',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_service_time`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_service_time` (
  `service_time_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `goods_id` int(11) DEFAULT '0',
  `week` smallint(1) NOT NULL COMMENT '0:星期日 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六',
  `begin_time` char(5) DEFAULT NULL COMMENT '开始时间 如:00:00',
  `end_time` char(5) DEFAULT NULL COMMENT '结束时间 如:00:30',
  `end_stime` char(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家服务时间查询用表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_service_time_set`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_service_time_set` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `goods_id` int(11) DEFAULT '0',
  `week` varchar(500) NOT NULL COMMENT '0:星期日 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六',
  `hours` varchar(500) DEFAULT NULL COMMENT 'json格式时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家服务时间设置';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_staff`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_staff` (
  `id` int(11) NOT NULL COMMENT '编号',
  `seller_id` int(11) DEFAULT NULL COMMENT '服务站编号',
  `user_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `name` varchar(60) DEFAULT NULL COMMENT '姓名',
  `type` tinyint(1) DEFAULT '3' COMMENT '员工类型1配送2服务0商家3同是配送服务',
  `card_number` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `name_match` text,
  `mobile` varchar(20) DEFAULT '',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `province_id` mediumint(8) DEFAULT NULL COMMENT '所在省',
  `city_id` mediumint(8) DEFAULT NULL COMMENT '所在市',
  `area_id` mediumint(8) DEFAULT NULL COMMENT '所在县',
  `brief` varchar(500) DEFAULT NULL COMMENT '简介',
  `sort` smallint(6) DEFAULT '100',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `create_time` int(11) DEFAULT NULL,
  `create_day` int(11) DEFAULT NULL,
  `sex` smallint(1) DEFAULT '1' COMMENT '性别:1为男,2为女',
  `birthday` int(11) DEFAULT NULL COMMENT '出生日期',
  `order_status` int(1) DEFAULT '1' COMMENT '接单状态 0：拒绝接单 1：正常接单',
  `begin_time` varchar(5) DEFAULT NULL COMMENT '接单开始时间',
  `end_time` varchar(5) DEFAULT NULL COMMENT '接单结束时间',
  `authenticate_img` varchar(255) DEFAULT NULL COMMENT '认证图片',
  `authentication` varchar(100) DEFAULT NULL COMMENT '认证标题',
  `map_point` point DEFAULT NULL COMMENT '地图坐标',
  `map_point_str` varchar(60) DEFAULT NULL COMMENT '地图坐标字符串',
  `map_pos` polygon DEFAULT NULL,
  `map_pos_str` text,
  `is_work` tinyint(1) DEFAULT '0' COMMENT '是否上班 0=下班 1=上班',
  `company` varchar(255) DEFAULT NULL COMMENT '所属公司',
  `is_system` tinyint(1) unsigned DEFAULT '0' COMMENT '是否是系统配送人员 1=是 0=不是'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构员工';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_staff_bank`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_staff_bank` (
  `id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL COMMENT '服务人员编号',
  `bank` varchar(30) DEFAULT NULL COMMENT '银行名称',
  `bank_no` varchar(30) DEFAULT NULL COMMENT '银行卡号',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `mobile` char(12) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='卖家银行卡';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_staff_extend`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_staff_extend` (
  `staff_id` int(11) NOT NULL COMMENT '员工编号',
  `seller_id` int(11) NOT NULL COMMENT '机构编号',
  `total_money` double(10,2) DEFAULT '0.00' COMMENT '总金额',
  `withdraw_money` double(10,2) DEFAULT '0.00' COMMENT '可提现金额',
  `frozen_money` double(10,2) DEFAULT '0.00' COMMENT '冻结金额',
  `order_count` int(11) DEFAULT '0' COMMENT '订单数量',
  `collect_count` int(11) DEFAULT '0' COMMENT '被收藏次数',
  `comment_total_count` int(11) DEFAULT '0' COMMENT '评价总次数',
  `comment_specialty_total_score` int(11) DEFAULT '0' COMMENT '评价-专业总分',
  `comment_specialty_avg_score` double(2,1) DEFAULT '0.0' COMMENT '评价-专业平均分',
  `comment_communicate_total_score` int(11) DEFAULT '0' COMMENT '评价-沟通总分',
  `comment_communicate_avg_score` double(2,1) DEFAULT '0.0' COMMENT '评价-沟通平均分',
  `comment_punctuality_total_score` int(11) DEFAULT '0' COMMENT '评价-守时总分',
  `comment_punctuality_avg_score` double(2,1) DEFAULT '0.0' COMMENT '评价-守时平均分',
  `comment_good_count` int(11) DEFAULT '0' COMMENT '评价-好评数',
  `comment_neutral_count` int(11) DEFAULT '0' COMMENT '评价-中评数',
  `comment_bad_count` int(11) DEFAULT '0' COMMENT '评价-差评数',
  `stop_receive_content` text COMMENT '暂停接单理由',
  `stop_receive_begin_time` int(11) DEFAULT NULL COMMENT '暂停接单开始时间',
  `stop_receive_end_time` int(11) DEFAULT NULL COMMENT '暂停接单结束时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工扩展信息';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_staff_money_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_staff_money_log` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '',
  `staff_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `admin_id` int(11) DEFAULT NULL COMMENT '0',
  `type` char(20) DEFAULT '' COMMENT '关联类型',
  `related_id` int(11) DEFAULT '0' COMMENT '关联编号',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `balance` double(10,2) DEFAULT '0.00' COMMENT '余额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(2) DEFAULT '0' COMMENT '0 待处理 1已确认 2已拒绝'
) ENGINE=InnoDB AUTO_INCREMENT=2356 DEFAULT CHARSET=utf8 COMMENT='服务人员资金流水';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_staff_withdraw_money`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_staff_withdraw_money` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `staff_id` int(11) DEFAULT '0' COMMENT '服务人员编号',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `bank` varchar(30) DEFAULT '' COMMENT '银行',
  `bank_no` varchar(30) DEFAULT '' COMMENT '银行卡号',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `dispose_time` int(11) DEFAULT '0' COMMENT '处理时间',
  `dispose_remark` varchar(500) DEFAULT '' COMMENT '操作备注',
  `dispose_admin` int(10) DEFAULT '0' COMMENT '操作管理员',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(2) DEFAULT '0' COMMENT '0 待核审 1确认核审 2拒绝提现',
  `name` varchar(32) DEFAULT NULL COMMENT '持有人'
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='卖家提现申请';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_staff_work`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_staff_work` (
  `id` int(10) unsigned NOT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL COMMENT '服务人员ID',
  `is_work` tinyint(1) unsigned DEFAULT NULL COMMENT '变成的状态 0=下班 1=上班',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%seller_withdraw_money`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%seller_withdraw_money` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `bank` varchar(30) DEFAULT '' COMMENT '银行',
  `bank_no` varchar(30) DEFAULT '' COMMENT '银行卡号',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `dispose_time` int(11) DEFAULT '0' COMMENT '处理时间',
  `dispose_remark` varchar(500) DEFAULT '' COMMENT '操作备注',
  `dispose_admin` int(10) DEFAULT '0' COMMENT '操作管理员',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(2) DEFAULT '0' COMMENT '0 待核审 1确认核审 2拒绝提现',
  `name` varchar(32) DEFAULT NULL COMMENT '持有人',
  `user_id` int(11) DEFAULT '0' COMMENT '会员Id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卖家提现申请';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%sharechapman_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%sharechapman_log` (
  `id` int(11) unsigned NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `remark` varchar(80) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0申请 1成功 -1申请失败',
  `create_time` int(10) unsigned DEFAULT '0',
  `dispose_admin` int(11) unsigned DEFAULT '0',
  `dispose_time` int(11) unsigned DEFAULT '0',
  `dispose_remark` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%share_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%share_log` (
  `id` int(11) unsigned NOT NULL,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `user_id` int(11) NOT NULL COMMENT '会员Id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `create_day` int(11) NOT NULL COMMENT '创建天',
  `share_type` varchar(50) DEFAULT 'goods' COMMENT '分享数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%shopping_cart`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%shopping_cart` (
  `id` int(11) NOT NULL,
  `user_id` varchar(20) NOT NULL DEFAULT '1' COMMENT '用户ID',
  `seller_id` int(11) NOT NULL COMMENT '商家编号',
  `goods_id` int(10) NOT NULL COMMENT '商品ID',
  `norms_id` int(11) DEFAULT '0' COMMENT '商品规格',
  `num` int(11) NOT NULL COMMENT '数量',
  `price` double(11,2) DEFAULT NULL,
  `sort` smallint(6) DEFAULT '100',
  `type` smallint(1) DEFAULT '1' COMMENT '类型 1商品，2服务',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `service_time` int(11) DEFAULT NULL COMMENT '服务类商品选择的服务时间',
  `share_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '分享人的编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%staff_leave`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%staff_leave` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL COMMENT '服务机构编号',
  `staff_id` int(11) NOT NULL COMMENT '员工编号',
  `begin_time` int(11) NOT NULL COMMENT '请假开始时间',
  `end_time` int(11) NOT NULL COMMENT '请假结束时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '请假理由',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 是否同意, 1 :同意 0:待处理 -1: 拒绝',
  `is_agree` tinyint(2) NOT NULL DEFAULT '0' COMMENT ' 是否同意, 1 :同意 0:待处理 -1: 拒绝',
  `dispose_time` int(11) NOT NULL DEFAULT '0' COMMENT '处理时间',
  `dispose_result` text COMMENT '处理结果',
  `dispose_admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '处理人员'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%staff_service_time`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%staff_service_time` (
  `service_time_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT '0',
  `week` smallint(1) NOT NULL COMMENT '0:星期日 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六',
  `begin_time` char(5) DEFAULT NULL COMMENT '开始时间 如:00:00',
  `end_time` char(5) DEFAULT NULL COMMENT '结束时间 如:00:30',
  `end_stime` char(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工服务时间查询用表';

--
-- 转存表中的数据 `%DB_PREFIX%staff_service_time`
--

INSERT INTO `%DB_PREFIX%staff_service_time` (`service_time_id`, `seller_id`, `staff_id`, `week`, `begin_time`, `end_time`, `end_stime`) VALUES
(1, 1, 0, 0, '00:00', '00:00', '23:59:59'),
(1, 1, 0, 1, '00:00', '00:00', '23:59:59'),
(1, 1, 0, 2, '00:00', '00:00', '23:59:59'),
(1, 1, 0, 3, '00:00', '00:00', '23:59:59'),
(1, 1, 0, 4, '00:00', '00:00', '23:59:59'),
(1, 1, 0, 5, '00:00', '00:00', '23:59:59'),
(1, 1, 0, 6, '00:00', '00:00', '23:59:59');

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%staff_service_time_set`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%staff_service_time_set` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT '0',
  `week` varchar(500) NOT NULL COMMENT '0:星期日 1:星期一 2:星期二 3:星期三 4:星期四 5:星期五 6:星期六',
  `hours` varchar(500) DEFAULT NULL COMMENT 'json格式时间'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='员工服务时间设置';

--
-- 转存表中的数据 `%DB_PREFIX%staff_service_time_set`
--

INSERT INTO `%DB_PREFIX%staff_service_time_set` (`id`, `seller_id`, `staff_id`, `week`, `hours`) VALUES
(1, 1, 0, '["0","1","2","3","4","5","6"]', '["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]');

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%system_config`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%system_config` (
  `code` varchar(30) NOT NULL COMMENT '键名',
  `name` varchar(30) DEFAULT NULL COMMENT '显示名称',
  `val` text COMMENT '键值',
  `group_code` varchar(128) DEFAULT NULL COMMENT '分组码',
  `show_type` varchar(20) DEFAULT NULL COMMENT '显示类型',
  `default_vals` text COMMENT '默认值',
  `default_names` text COMMENT '默认值名称',
  `is_show` tinyint(1) DEFAULT '1' COMMENT '是否显示',
  `sort` smallint(3) DEFAULT '100' COMMENT '排序',
  `tooltip` text COMMENT '操作提示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局配置';

--
-- 转存表中的数据 `%DB_PREFIX%system_config`
--

INSERT INTO `%DB_PREFIX%system_config` (`code`, `name`, `val`, `group_code`, `show_type`, `default_vals`, `default_names`, `is_show`, `sort`, `tooltip`) VALUES
('aboutus', '关于我们(APP)', '<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<span style="color:#666666;"></span> \r\n</p>\r\n<span></span>', ',admin,', 'editor', NULL, NULL, 1, 101, NULL),
('access_token', '微信AccessToken', 'awYMnsXkocjlMn9p-1QNIPbw1zMyIwBb4rrDTA0LCQwLl9hjP7O8rzGE7I2IkPlIjDiDD4egojeVTPDPn5lmQuTyAHLuhnMSK0NprRh-nc-BmbYhZfPGRKDTIBRVZ4AlYZHdCDAIJR', ',weixin,', 'inputtext', NULL, NULL, 0, 100, NULL),
('access_token_expired', '微信AccessToken过期时间', '1482797988', ',weixin,', 'inputtext', NULL, NULL, 0, 100, NULL),
('admin_logo', '管理后台LOGO', 'http://image.jikesoft.com/images/2016/12/27/201612271426245802538.jpg', ',admin,', 'image', NULL, NULL, 1, 9, NULL),
('admin_name', '管理后台标题', '社区o2o', ',admin,', 'inputtext', NULL, NULL, 1, 5, NULL),
('admin_tpl', '管理后台模板', '', ',admin,', 'select', NULL, NULL, 1, 8, NULL),
('app_logo', '分享app图片', '', ',admin,wap,', 'image', NULL, NULL, 1, 10, NULL),
('app_opendoor', '是否开启门禁', '0', ',admin,buyer,', 'radio', '1', NULL, 1, 99, '是否开启门禁'),
('auto_time', '自动评价时间', '60', 'order_config', 'inputtext', NULL, NULL, 1, 100, NULL),
('buyer_android_app_down_url', 'APP下载链接(安卓)', '', ',buyer,', 'inputtext', NULL, NULL, 1, 8, NULL),
('buyer_android_app_version', 'APP版本名称(安卓)', '1.0', ',buyer,', 'inputtext', NULL, NULL, 1, 7, NULL),
('buyer_android_app_version_code', 'APP版本号(安卓)', '1', ',buyer,', 'inputtext', NULL, NULL, 1, 7, NULL),
('buyer_android_upgrade_info', 'APP升级说明(安卓)', '安卓APP升级了哦!', ',buyer,', 'editor', NULL, NULL, 1, 13, NULL),
('buyer_app_down_url', 'APP下载链接(ios)', '', ',buyer,', 'inputtext', NULL, NULL, 1, 10, NULL),
('buyer_app_version', 'APP版本名称(ios)', '1.0', ',buyer,', 'inputtext', NULL, NULL, 1, 9, NULL),
('buyer_app_version_code', 'APP版本号(IOS)', '1.0', ',buyer,', 'inputtext', NULL, NULL, 1, 9, NULL),
('buyer_force_upgrade', '是否强制更新', '0', ',buyer,', 'radio', NULL, NULL, 1, 11, NULL),
('buyer_index_show', '首页推荐列表', '0', ',buyer,', 'radio', '0,1', NULL, 1, 100, ''),
('buyer_push_appkey', '推送APPKEY', '', ',buyer,', 'inputtext', NULL, NULL, 1, 5, NULL),
('buyer_push_master_secret', '推送秘钥', '', ',buyer,', 'inputtext', NULL, NULL, 1, 6, NULL),
('buyer_service_tel', '客服电话', '', ',buyer,wap,', 'inputtext', NULL, NULL, 1, 3, NULL),
('buyer_share_content', '分享内容', '我在使用%1$sApp，可以在上面预约商品送货上门和预约上门服务，邀请你来试试。下载地址%2$s', ',wap,buyer,', 'textarea', NULL, NULL, 1, 12, NULL),
('buyer_upgrade_info', 'APP升级说明(ios)', '苹果APP升级了哦!', ',buyer,', 'editor', NULL, NULL, 1, 14, NULL),
('cash_integral', '积分抵现比例', '50', ',integral_config,', 'text', '0', NULL, 1, 6, '%'),
('cost_integral', '消费送积分比例', '100', ',integral_config,', 'text', '0', NULL, 1, 5, '%'),
('coupon_exchange_explain', '优惠券使用说明', '<p>\r\n	<br />\r\n</p>', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('coupon_return_alert_time', '优惠券到期提醒', '1', ',admin,wap,buyer,seller,', 'inputtext', '1', NULL, 1, 30, '天'),
('disclaimer', '免责声明(APP)', '<p>\r\n	<br />\r\n</p>\r\n<span style="line-height: 30px; font-family: 微软雅黑,;" microsoft="" yahei?,="" tahoma,="" srial,="" helvetica,="" sans-serif;font-size:13px;background-color:#ffffff;?=""><span></span></span>', ',admin,', 'editor', NULL, NULL, 1, 101, NULL),
('download_address', '下载地址', '', ',buyer,', 'inputtext', '1', NULL, 1, 31, '连接'),
('fx_exchange_percent', '佣金兑换比例', '100', ',fanwefx,', 'inputtext', '1', NULL, 1, 100, ''),
('fx_user_check', '是否核审分销账户', '100', ',fanwefx,', 'inputtext', '1', NULL, 1, 100, ''),
('integral_off', '积分开关', '0', ',integral_config,', 'radio', '0,1', '关闭,开启', 1, 100, NULL),
('integral_open_type', '积分抵现设置', '2', ',integral_config,', 'radio', '0,1,2', '周边店,全国店,周边店和全国店', 1, 100, NULL),
('integral_remark', '积分规则', '<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>', ',integral_config,buyer,', 'editor', '', NULL, 1, 15, NULL),
('is_refund_balance', '退款到余额', '1', ',order_config,', 'radio', '0,1', '否,是', 1, 30, NULL),
('jsapi_ticket', '微信JsApiTicket', 'sM4AOVdWfPE4DxkXGEs8VOkDQ778csmKoAmg1ge4He2aqmqIXuJrEJURlZlKdwFb8P7oveY3gfILmZpr-wJnyQ', ',weixin,', 'inputtext', NULL, NULL, 0, 100, NULL),
('jsapi_ticket_expired', '微信JsApiTicket过期时间', '1482797988', ',weixin,', 'inputtext', NULL, NULL, 0, 100, NULL),
('key_words', '关键字过滤', '你妹,呵呵,法轮功,萨达姆，习近平，操你妈，滚犊子，奥多姆，卡戴珊', ',word,', 'textarea', '', '', 1, 100, ''),
('limit_cash_integral', '积分抵现上限比例', '50', ',integral_config,', 'text', '0', NULL, 1, 7, '%'),
('limit_posts_integral', '发帖送积分每日上限', '50', ',integral_config,', 'text', '0', NULL, 1, 4, '只允许为正整数'),
('limit_reply_integral', '回复送积分每日上限', '100', ',integral_config,', 'text', '0', NULL, 1, 3, '只允许为正整数'),
('live_key', '生活缴费key', '', ',admin,wap,', 'inputtext', NULL, NULL, 1, 99, NULL),
('money_cycle_day', '提现周期', '1', ',admin,wap,', 'inputtext', NULL, NULL, 1, 30, '天'),
('order_track_key', '快递key', '', ',admin,wap,seller,staff,', 'inputtext', NULL, NULL, 1, 99, NULL),
('posts_check', '发帖审核', '1', ',live,', 'radio', '1', '', 1, 100, ''),
('posts_integral', '发帖送积分', '50', ',integral_config,', 'text', '0', NULL, 1, 4, '只允许为正整数'),
('public_address_number', '公众号地址', '', ',buyer,', 'inputtext', '1', NULL, 1, 31, '连接'),
('qq_map_key', 'QQ地图密匙', '2N2BZ-KKZA4-ZG4UB-XAOJU-HX2ZE-HYB4O', ',all,', 'inputtext', NULL, NULL, 1, 14, NULL),
('reg_integral', '注册送积分', '50', ',integral_config,', 'text', '0', NULL, 1, 2, '只允许为正整数'),
('reply_integral', '回复送积分', '50', ',integral_config,', 'text', '0', NULL, 1, 3, '只允许为正整数'),
('seller_about_us', '关于我们', '关于我们', ',seller,', 'textarea', NULL, NULL, 1, 100, NULL),
('seller_android_app_down_url', 'APP下载链接(安卓)', 'http://gdown.baidu.com/data/wisegame/733dbbbb81e6ebfc/jieriduanxinzhufu_2.apk', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_android_app_version', 'APP版本号(安卓)', '1.0', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_android_upgrade_info', 'APP升级说明(安卓)', '安卓APP升级了哦', ',seller,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_app_down_url', 'APP下载链接(ios)', 'http://gdown.baidu.com/data/wisegame/733dbbbb81e6ebfc/jieriduanxinzhufu_2.apk', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_app_version', 'APP版本号(ios)', '1.0', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_force_upgrade', '是否强制更新', '0', ',seller,', 'radio', NULL, NULL, 1, 100, NULL),
('seller_push_appkey', '推送APPKEY', 'fcba66635dfa2fcb78198dea', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_push_master_secret', '推送秘钥', '4c001821fddf8982d95c97b9', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_reg1', '安全保障', '', ',admin,seller_reg,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_reg2', '服务保障', '', ',admin,seller_reg,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_reg3', '权益保障', '<p class="MsoNormal">\r\n	<br />\r\n</p>', ',admin,seller_reg,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_reg4', '优惠措施', '<p class="MsoNormal">\r\n	<br />\r\n</p>', ',admin,seller_reg,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_reg5', '加盟须知', '<p class="MsoNormal">\r\n	<br />\r\n</p>', ',admin,seller_reg,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_service_tel', '客服电话', '023-67898579', ',seller,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_site_title', '网站名称', '易赞上门服务卖家系统', ',seller_web,', 'inputtext', NULL, NULL, 1, 100, NULL),
('seller_upgrade_info', 'APP升级说明(ios)', '苹果APP升级了哦', ',seller,', 'editor', NULL, NULL, 1, 100, NULL),
('seller_withdraw_day', '商家到账时间', '0', ',order_config,', 'text', '0', NULL, 1, 20, '天'),
('sign_integral', '签到送积分', '10', ',integral_config,', 'text', '0', NULL, 1, 1, '只允许为正整数'),
('site_desc', '网站描述', '社区o2o', ',admin,wap,', 'textarea', NULL, NULL, 1, 4, NULL),
('site_keyword', '网站关键字', '农村、电商、代购、代销、生活服务，社区、上门服务', ',admin,wap,', 'textarea', NULL, NULL, 1, 3, NULL),
('site_name', '网站名称', '方维社区o2o', ',admin,wap,buyer,seller,', 'inputtext', NULL, NULL, 1, 1, NULL),
('site_title', '网站标题', '社区o2o', ',admin,wap,', 'inputtext', NULL, NULL, 1, 2, NULL),
('sms_password', '短信密码', '', ',sms,', 'inputtext', NULL, NULL, 1, 100, NULL),
('sms_url', '短信发送地址', 'http://sms.fanwe.com/post', ',sms,', 'inputtext', NULL, NULL, 1, 100, NULL),
('sms_user_name', '短信账号', '', ',sms,', 'inputtext', NULL, NULL, 1, 100, NULL),
('sms_valid_time', '验证码过期时间', '60', ',all,admin,', NULL, NULL, NULL, 1, 10, '秒'),
('staff_about_us', '关于员工', '', ',staff,', 'editor', NULL, NULL, 1, 11, NULL),
('staff_android_app_down_url', 'APP下载链接(安卓)', '', ',staff,', 'inputtext', NULL, NULL, 1, 5, NULL),
('staff_android_app_version', 'APP版本名称(安卓)', '1.0', ',staff,', 'inputtext', NULL, NULL, 1, 4, NULL),
('staff_android_app_version_code', 'APP版本号(安卓)', '1', ',staff,', 'inputtext', NULL, NULL, 1, 4, NULL),
('staff_android_upgrade_info', 'APP升级说明(安卓)', '安卓APP升级了哦!', ',staff,', 'editor', NULL, NULL, 1, 9, NULL),
('staff_app_down_url', 'APP下载链接(ios)', '', ',staff,', 'inputtext', NULL, NULL, 1, 7, NULL),
('staff_app_version', 'APP版本名称(ios)', '1.0', ',staff,', 'inputtext', NULL, NULL, 1, 6, NULL),
('staff_app_version_code', 'APP版本号(ios)', '1.0', ',staff,', 'inputtext', NULL, NULL, 1, 6, NULL),
('staff_bank_info', '服务端提现说明', '<span><br />\r\n</span><strong><span style="background-color:#E56600;"></span></strong>', ',staff,', 'editor', NULL, NULL, 1, 12, NULL),
('staff_deduct_type', '员工抽成方式', '2', ',admin_order,', 'select', '1,2', '按次,按百分比', 1, 101, NULL),
('staff_deduct_value', '员工抽成值', '1', ',admin_order,', 'inputtext', NULL, NULL, 1, 102, NULL),
('staff_disclaimer', '免责声明(员工)', '', ',staff,', 'editor', NULL, NULL, 1, 15, NULL),
('staff_force_upgrade', '是否强制更新', '0', ',staff,', 'radio', NULL, NULL, 1, 8, NULL),
('staff_order_notice', '订单须知(员工)', '', ',staff,', 'editor', NULL, NULL, 1, 13, NULL),
('staff_push_appkey', '推送APPKEY', '', ',staff,', 'inputtext', NULL, NULL, 1, 2, NULL),
('staff_push_master_secret', '推送秘钥', '', ',staff,', 'inputtext', NULL, NULL, 1, 3, NULL),
('staff_service', '服务范围(员工)', '', ',staff,', 'editor', NULL, NULL, 1, 14, NULL),
('staff_service_tel', '客服电话', '', ',staff,', 'inputtext', NULL, NULL, 1, 1, NULL),
('staff_settled_image', '商家入驻图片', '', ',admin,wap,', 'image', NULL, NULL, 1, 9, NULL),
('staff_upgrade_info', 'APP升级说明(ios)', '苹果APP升级了哦!', ',staff,', 'editor', NULL, NULL, 1, 10, NULL),
('system_admin', '系统管理员', 'admin', ',admin,', 'inputtext', NULL, NULL, 1, 5, NULL),
('system_buyer_order_confirm', '确认订单完成时间', '1', ',admin_order,order_config,', 'intputtext', NULL, NULL, 1, 101, '天'),
('system_buyer_order_confirm_all', '确认订单完成时间', '1', ',admin_order,order_config,', 'intputtext', NULL, NULL, 1, 201, '天'),
('system_order_fee', '服务抽成', '2', ',admin_order,', 'intputtext', NULL, NULL, 0, 10, '%'),
('system_order_pass', '订单过期时间', '3600', ',admin_order,order_config,', 'intputtext', NULL, NULL, 1, 100, '分钟'),
('system_order_pass_all', '订单过期时间', '86400', ',admin_order,order_config,', 'intputtext', NULL, NULL, 1, 200, '天'),
('system_order_self_motion', '自动评价时间', '2', ',order_config_bak,order_config,', 'intputtext', NULL, NULL, 1, 25, '天'),
('system_seller_order_confirm', '确认接单时间', '60', ',admin_order,', 'intputtext', NULL, NULL, 1, 100, '分钟'),
('system_send_fee', '配送服务费(平台配送)', '0', ',sendcenter,', 'intputtext', NULL, NULL, 1, 10, '元/单'),
('system_send_staff_fee', '配送抽佣(平台配送)', '0.00', ',sendcenter,', 'intputtext', NULL, NULL, 1, 20, '元/单'),
('system_staff_change_hour', '人员切换时间(平台配送)', '1', ',sendcenter,', 'intputtext', NULL, NULL, 1, 40, '小时'),
('vcode_type', '验证码类型', '0', ',vcode,', 'radio', '0', NULL, 1, 100, ''),
('wap_about_us', '关于我们(wap端)', '<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<span style="color:#666666;"></span> \r\n</p>\r\n<span></span>', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_disclaimer', '免责声明(wap端)', '<br />', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_help', '使用帮助', '', ',staff,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_integral', '积分前端文字', '', ',admin,', 'inputtext', NULL, NULL, 1, 99, ''),
('wap_lookopen_district', '查看开通小区', '<br />', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_order_notice', '下单须知(微信端)', '<span> \r\n<p>\r\n	<span style="color:#999999;line-height:1.5;"><span></span></span> \r\n</p>\r\n<h4 style="font-family:Simsun;font-size:medium;">\r\n	<br />\r\n</h4>\r\n</span>', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_promotion', '优惠券前端文字', '', ',admin,', 'inputtext', NULL, NULL, 1, 99, ''),
('wap_refund_agreement', '退款协议(wap端)', '<br />', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_service', '服务范围(wap端)', '<br />', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_service_tel', '平台客服电话', '', ',admin,wap,buyer,', 'inputtext', NULL, NULL, 1, 2, NULL),
('wap_service_time', '平台服务时间', '', ',admin,wap,buyer,', 'inputtext', NULL, NULL, 1, 4, '例:9:00-18:00'),
('wap_terrace_referral', '平台介绍', '<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<span style="color:#666666;"></span> \r\n</p>', ',admin,wap,', 'editor', NULL, NULL, 1, 100, NULL),
('wap_tpl', 'WAP端模板', 'community', ',admin,wap,', 'select', NULL, NULL, 1, 9, NULL),
('watermark_clarity', '水印透明度', '', ',admin_image,wap,seller,staff,', 'intputtext', NULL, NULL, 1, 100, NULL),
('watermark_logo', '水印图片', '', ',admin_image,wap,seller,staff,', 'image', NULL, NULL, 1, 100, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%system_goods`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%system_goods` (
  `id` int(11) NOT NULL,
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '1:商品，2：服务',
  `name` varchar(60) DEFAULT NULL COMMENT '服务/商品名称',
  `unit` tinyint(1) DEFAULT '0' COMMENT '时长单位，0:分钟，1:小时',
  `duration` int(11) DEFAULT '0' COMMENT '预约时长',
  `images` text COMMENT '菜品图片',
  `price` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '现价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `total_stock` int(11) DEFAULT '0' COMMENT '总库存',
  `brief` text COMMENT '描述',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '上架状态 0：下架 1：上架',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `dispose_time` int(11) DEFAULT NULL COMMENT '处理时间',
  `dispose_result` varchar(500) DEFAULT NULL COMMENT '处理结果',
  `dispose_status` int(2) DEFAULT NULL COMMENT '处理状态 0：待审核 1：审核通过 -1：审核未通过',
  `sort` smallint(6) DEFAULT '100',
  `deduct_type` tinyint(1) DEFAULT '1' COMMENT '提成方式1固定2百分比',
  `deduct_val` char(5) DEFAULT '0' COMMENT '提成值',
  `system_tag_list_pid` int(11) DEFAULT NULL COMMENT '商品标签分类（一级）',
  `system_tag_list_id` int(11) DEFAULT NULL COMMENT '商品标签分类（二级）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通用服务库';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%system_goods_norms`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%system_goods_norms` (
  `id` int(11) NOT NULL COMMENT '编号',
  `system_goods_id` int(11) NOT NULL COMMENT '商品编号',
  `name` varchar(50) NOT NULL COMMENT '规格名称',
  `price` double(11,2) DEFAULT NULL COMMENT '价格',
  `stock` int(11) DEFAULT NULL COMMENT '库存'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统 规格库';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%system_tag`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%system_tag` (
  `id` int(11) NOT NULL COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '标签分类名称',
  `sort` int(11) DEFAULT '100' COMMENT '排序',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：0：关闭 1：开启',
  `create_time` varchar(12) DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台商品标签分类';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%system_tag_list`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%system_tag_list` (
  `id` int(11) NOT NULL COMMENT '编号',
  `pid` int(11) DEFAULT '0' COMMENT '父编号',
  `system_tag_id` int(11) NOT NULL COMMENT '平台商品标签分类编号',
  `name` varchar(20) DEFAULT '' COMMENT '名称',
  `img` varchar(255) DEFAULT NULL COMMENT '图片',
  `sort` smallint(3) DEFAULT '100' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `create_time` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台标签列表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user` (
  `id` int(11) unsigned NOT NULL COMMENT '编号',
  `group_id` smallint(6) DEFAULT '1',
  `mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `name_match` text,
  `birthday` int(11) DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) DEFAULT '0' COMMENT '性别',
  `crypt` char(6) DEFAULT '',
  `pwd` char(32) DEFAULT NULL COMMENT '密码',
  `pay_pwd` char(32) DEFAULT NULL COMMENT '支付密码',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `is_sms_verify` tinyint(1) DEFAULT '0' COMMENT '是否短信认证',
  `province_id` mediumint(8) DEFAULT NULL COMMENT '所在省',
  `city_id` mediumint(8) DEFAULT NULL COMMENT '所在市',
  `area_id` mediumint(8) DEFAULT NULL COMMENT '所在县',
  `total_money` double(10,2) DEFAULT '0.00' COMMENT '总金额',
  `balance` double(10,2) DEFAULT '0.00' COMMENT '当前余额',
  `lock_amount` double DEFAULT '0' COMMENT '冻结金额',
  `reg_time` int(11) DEFAULT NULL COMMENT '注册时间',
  `reg_ip` varchar(20) DEFAULT NULL COMMENT '注册IP',
  `reg_province_id` mediumint(8) DEFAULT NULL COMMENT '注册所在省',
  `reg_city_id` mediumint(8) DEFAULT NULL COMMENT '注册所在市',
  `login_time` int(11) DEFAULT NULL COMMENT '最后登陆时间',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '最后登陆IP',
  `login_province_id` mediumint(8) DEFAULT NULL COMMENT '最后登陆所在省',
  `login_city_id` mediumint(8) DEFAULT NULL COMMENT '最后登陆所在市',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `total_integral` int(11) NOT NULL DEFAULT '0' COMMENT '累计积分',
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT '现有积分',
  `invitation_type` varchar(10) DEFAULT NULL COMMENT '推荐注册的类型： seller,user,staff',
  `invitation_id` int(11) DEFAULT NULL COMMENT '推荐注册的编号',
  `openid` varchar(255) DEFAULT NULL COMMENT '微信用户openid',
  `unionid` varchar(255) DEFAULT NULL COMMENT '微信用户unionid',
  `money_cycle_day` int(11) DEFAULT '0' COMMENT '提现周期',
  `fanwe_id` int(11) unsigned DEFAULT '0' COMMENT '会员id',
  `mine_pwd` char(32) DEFAULT NULL,
  `fanwe_recommend_user` int(11) unsigned DEFAULT '0' COMMENT '分销系统推荐ID'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员';

--
-- 转存表中的数据 `%DB_PREFIX%user`
--

INSERT INTO `%DB_PREFIX%user` (`id`, `group_id`, `mobile`, `name`, `name_match`, `birthday`, `sex`, `crypt`, `pwd`, `pay_pwd`, `avatar`, `is_sms_verify`, `province_id`, `city_id`, `area_id`, `total_money`, `balance`, `lock_amount`, `reg_time`, `reg_ip`, `reg_province_id`, `reg_city_id`, `login_time`, `login_ip`, `login_province_id`, `login_city_id`, `status`, `total_integral`, `integral`, `invitation_type`, `invitation_id`, `openid`, `unionid`, `money_cycle_day`, `fanwe_id`, `mine_pwd`, `fanwe_recommend_user`) VALUES
(1, 1, '18989898989', '自营商家', '+ux33258 +ux33829 +ux21830 +ux23478', NULL, 0, 'TaIvmf', '168a00fa9e8494e7a478f35aa4055472', NULL, NULL, 1, 1, 2, 0, 0.00, 0.00, 0, 1481074723, '127.0.0.1', NULL, NULL, 1481152066, '127.0.0.1', 0, 0, 1, 0, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 0);

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_address`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_address` (
  `id` int(11) NOT NULL COMMENT '编号',
  `user_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `name` varchar(60) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `doorplate` varchar(50) DEFAULT NULL COMMENT '门牌号',
  `map_point` point DEFAULT NULL COMMENT '地图坐标',
  `map_point_str` varchar(60) DEFAULT NULL COMMENT '地图坐标字符串',
  `province_id` int(11) DEFAULT NULL COMMENT '所在省',
  `city_id` int(11) DEFAULT NULL COMMENT '所在市',
  `area_id` int(11) DEFAULT NULL COMMENT '所在县',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认',
  `detail_address` varchar(255) DEFAULT NULL COMMENT '详细地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员地址表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_address_logs`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_address_logs` (
  `id` int(11) unsigned NOT NULL COMMENT 'id',
  `address` varchar(255) CHARACTER SET utf8 DEFAULT '',
  `map_point_str` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_bank`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_bank` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '会员编号',
  `bank` varchar(30) DEFAULT NULL COMMENT '银行名称',
  `bank_no` varchar(30) DEFAULT NULL COMMENT '银行卡号',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `mobile` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='卖家银行卡';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_collect`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_collect` (
  `id` int(11) NOT NULL COMMENT '编号',
  `user_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '商家编号',
  `goods_id` int(11) DEFAULT '0' COMMENT '商品编号',
  `create_time` int(11) DEFAULT NULL COMMENT '收藏时间',
  `type` tinyint(1) DEFAULT '1' COMMENT '类型1商品2店铺'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员收藏餐厅';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_integral`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_integral` (
  `id` int(11) unsigned NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员编号',
  `type` smallint(1) DEFAULT '1' COMMENT '类型 1:获取 2:消费',
  `related_type` smallint(1) DEFAULT NULL COMMENT '关联类型:1:签到 2:注册 3:消费 4:抵现 5:回复 6:发帖',
  `related_id` int(11) DEFAULT '0' COMMENT '关联编号',
  `integral` int(11) DEFAULT '0' COMMENT '积分',
  `remark` text COMMENT '备注',
  `status` smallint(1) DEFAULT '1' COMMENT '状态',
  `create_time` int(11) DEFAULT '0',
  `create_day` int(11) DEFAULT '0',
  `money` double(10,2) DEFAULT '0.00' COMMENT '消费金额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_mobile`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_mobile` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '会员编号',
  `mobile` varchar(11) NOT NULL COMMENT '联系电话',
  `is_default` tinyint(4) DEFAULT '0' COMMENT '是否为默认联系电话：0=否 1=是'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员联系电话';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_pay_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_pay_log` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `order_id` int(11) DEFAULT '0' COMMENT '订单编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `activity_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT '0',
  `pay_type` tinyint(1) DEFAULT '1' COMMENT '1表示消费 2表示充值 3表示退款 4平台充值 5平台扣款',
  `payment_type` char(20) DEFAULT '' COMMENT '支付方式',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `balance` double(10,2) DEFAULT '0.00' COMMENT '会员余额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `pay_account` varchar(80) DEFAULT '',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `pay_day` int(11) DEFAULT '0' COMMENT '支付时间(天)',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '付款流水号',
  `withdraw_id` int(11) NOT NULL DEFAULT '0' COMMENT '退款id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员支付日志';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_praise`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_praise` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '帖子编号',
  `posts_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员帖子';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_refund_log`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_refund_log` (
  `id` int(11) NOT NULL COMMENT '编号',
  `sn` char(22) DEFAULT '' COMMENT 'SN',
  `user_id` int(11) DEFAULT '0' COMMENT '会员编号',
  `refund_id` int(11) DEFAULT '0' COMMENT '退款编号',
  `seller_id` int(11) DEFAULT '0' COMMENT '卖家编号',
  `payment_type` char(20) DEFAULT '' COMMENT '支付方式',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '原付款流水号',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `content` varchar(500) DEFAULT '' COMMENT '说明',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_day` int(11) DEFAULT '0' COMMENT '创建时间(天)',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员退款日志';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%user_verify_code`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%user_verify_code` (
  `id` int(11) NOT NULL,
  `mobile` char(11) DEFAULT NULL COMMENT '手机号码',
  `type` varchar(20) DEFAULT NULL COMMENT '类型',
  `user_id` int(11) DEFAULT NULL COMMENT '会员编号',
  `code` varchar(6) DEFAULT NULL COMMENT '验证码',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员验证码表';

-- --------------------------------------------------------

--
-- 表的结构 `%DB_PREFIX%wap_nav`
--

CREATE TABLE IF NOT EXISTS `%DB_PREFIX%wap_nav` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT '导航名称',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `create_time` int(50) DEFAULT '0' COMMENT '创建时间',
  `image` varchar(300) DEFAULT NULL COMMENT '导航图标',
  `url` varchar(100) DEFAULT NULL COMMENT '连接地址',
  `color_image` varchar(300) DEFAULT NULL COMMENT '背景颜色图标',
  `sort` int(11) DEFAULT '0' COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `%DB_PREFIX%activity`
--
ALTER TABLE `%DB_PREFIX%activity`
  ADD PRIMARY KEY (`id`),
  ADD FULLTEXT KEY `name_match` (`name_match`);

--
-- Indexes for table `%DB_PREFIX%activity_goods`
--
ALTER TABLE `%DB_PREFIX%activity_goods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%activity_logs`
--
ALTER TABLE `%DB_PREFIX%activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%activity_promotion`
--
ALTER TABLE `%DB_PREFIX%activity_promotion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%activity_seller`
--
ALTER TABLE `%DB_PREFIX%activity_seller`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%admin_log`
--
ALTER TABLE `%DB_PREFIX%admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `log_day` (`log_day`);

--
-- Indexes for table `%DB_PREFIX%admin_role`
--
ALTER TABLE `%DB_PREFIX%admin_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%admin_role_access`
--
ALTER TABLE `%DB_PREFIX%admin_role_access`
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `%DB_PREFIX%admin_user`
--
ALTER TABLE `%DB_PREFIX%admin_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `%DB_PREFIX%admin_user_city`
--
ALTER TABLE `%DB_PREFIX%admin_user_city`
  ADD UNIQUE KEY `auc1` (`admin_user_id`,`city_id`);

--
-- Indexes for table `%DB_PREFIX%adv`
--
ALTER TABLE `%DB_PREFIX%adv`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`position_id`,`city_id`);

--
-- Indexes for table `%DB_PREFIX%adv_position`
--
ALTER TABLE `%DB_PREFIX%adv_position`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `%DB_PREFIX%article`
--
ALTER TABLE `%DB_PREFIX%article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cate` (`cate_id`);

--
-- Indexes for table `%DB_PREFIX%article_cate`
--
ALTER TABLE `%DB_PREFIX%article_cate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `%DB_PREFIX%city_location`
--
ALTER TABLE `%DB_PREFIX%city_location`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%city_open`
--
ALTER TABLE `%DB_PREFIX%city_open`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%district`
--
ALTER TABLE `%DB_PREFIX%district`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%door_access`
--
ALTER TABLE `%DB_PREFIX%door_access`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unpid` (`pid`);

--
-- Indexes for table `%DB_PREFIX%door_open_log`
--
ALTER TABLE `%DB_PREFIX%door_open_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%feedback`
--
ALTER TABLE `%DB_PREFIX%feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_user` (`user_id`,`type`);

--
-- Indexes for table `%DB_PREFIX%forum_complain`
--
ALTER TABLE `%DB_PREFIX%forum_complain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_user` (`user_id`,`post_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%forum_message`
--
ALTER TABLE `%DB_PREFIX%forum_message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%forum_plate`
--
ALTER TABLE `%DB_PREFIX%forum_plate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%forum_posts`
--
ALTER TABLE `%DB_PREFIX%forum_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%freight_tmp`
--
ALTER TABLE `%DB_PREFIX%freight_tmp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%goods`
--
ALTER TABLE `%DB_PREFIX%goods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller` (`seller_id`,`type`,`status`),
  ADD KEY `sellerId` (`seller_id`),
  ADD FULLTEXT KEY `name` (`name`);

--
-- Indexes for table `%DB_PREFIX%goods_cate`
--
ALTER TABLE `%DB_PREFIX%goods_cate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `%DB_PREFIX%goods_extend`
--
ALTER TABLE `%DB_PREFIX%goods_extend`
  ADD PRIMARY KEY (`goods_id`),
  ADD KEY `seller` (`seller_id`);

--
-- Indexes for table `%DB_PREFIX%goods_norms`
--
ALTER TABLE `%DB_PREFIX%goods_norms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un` (`name`,`goods_id`,`seller_id`) USING BTREE,
  ADD KEY `sellerId` (`seller_id`),
  ADD KEY `goodsId` (`goods_id`);

--
-- Indexes for table `%DB_PREFIX%goods_staff`
--
ALTER TABLE `%DB_PREFIX%goods_staff`
  ADD UNIQUE KEY `gs1` (`goods_id`,`staff_id`),
  ADD KEY `gs2` (`staff_id`),
  ADD KEY `gs3` (`seller_id`);

--
-- Indexes for table `%DB_PREFIX%hot_words`
--
ALTER TABLE `%DB_PREFIX%hot_words`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%index_nav`
--
ALTER TABLE `%DB_PREFIX%index_nav`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%invitation`
--
ALTER TABLE `%DB_PREFIX%invitation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%invitation_back_log`
--
ALTER TABLE `%DB_PREFIX%invitation_back_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `invitation_id` (`invitation_id`) USING BTREE,
  ADD KEY `orst` (`order_id`,`status`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%live_log`
--
ALTER TABLE `%DB_PREFIX%live_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%logistics_refund`
--
ALTER TABLE `%DB_PREFIX%logistics_refund`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%menu`
--
ALTER TABLE `%DB_PREFIX%menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%message_send`
--
ALTER TABLE `%DB_PREFIX%message_send`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%msg_model`
--
ALTER TABLE `%DB_PREFIX%msg_model`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%order`
--
ALTER TABLE `%DB_PREFIX%order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `mobile` (`mobile`),
  ADD KEY `seller_appoint` (`seller_id`) USING BTREE,
  ADD KEY `user` (`user_id`,`status`,`is_rate`) USING BTREE,
  ADD FULLTEXT KEY `name_match` (`name_match`);

--
-- Indexes for table `%DB_PREFIX%order_goods`
--
ALTER TABLE `%DB_PREFIX%order_goods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order` (`order_id`,`goods_id`);

--
-- Indexes for table `%DB_PREFIX%order_promotion`
--
ALTER TABLE `%DB_PREFIX%order_promotion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `seller` (`seller_id`),
  ADD KEY `user` (`user_id`),
  ADD KEY `promotion` (`promotion_id`),
  ADD KEY `promotion_sn` (`promotion_sn_id`);

--
-- Indexes for table `%DB_PREFIX%order_rate`
--
ALTER TABLE `%DB_PREFIX%order_rate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `seller` (`seller_id`),
  ADD KEY `user` (`user_id`);

--
-- Indexes for table `%DB_PREFIX%order_track`
--
ALTER TABLE `%DB_PREFIX%order_track`
  ADD PRIMARY KEY (`id`,`state`);

--
-- Indexes for table `%DB_PREFIX%payment`
--
ALTER TABLE `%DB_PREFIX%payment`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `%DB_PREFIX%pay_item`
--
ALTER TABLE `%DB_PREFIX%pay_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%promotion`
--
ALTER TABLE `%DB_PREFIX%promotion`
  ADD PRIMARY KEY (`id`),
  ADD FULLTEXT KEY `name_match` (`name_match`);

--
-- Indexes for table `%DB_PREFIX%promotion_sn`
--
ALTER TABLE `%DB_PREFIX%promotion_sn`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%property_bind_deivce`
--
ALTER TABLE `%DB_PREFIX%property_bind_deivce`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`user_id`,`id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%property_building`
--
ALTER TABLE `%DB_PREFIX%property_building`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a2` (`id`,`seller_id`,`district_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%property_fee`
--
ALTER TABLE `%DB_PREFIX%property_fee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`id`,`seller_id`,`build_id`,`room_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%property_order`
--
ALTER TABLE `%DB_PREFIX%property_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `user` (`user_id`) USING BTREE,
  ADD KEY `seller` (`seller_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%property_order_item`
--
ALTER TABLE `%DB_PREFIX%property_order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order` (`order_id`,`propertyfee_id`);

--
-- Indexes for table `%DB_PREFIX%property_room`
--
ALTER TABLE `%DB_PREFIX%property_room`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`id`,`seller_id`,`district_id`,`build_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%property_user`
--
ALTER TABLE `%DB_PREFIX%property_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`seller_id`,`build_id`,`room_id`,`user_id`,`id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%proxy`
--
ALTER TABLE `%DB_PREFIX%proxy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%puser_door`
--
ALTER TABLE `%DB_PREFIX%puser_door`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%push_message`
--
ALTER TABLE `%DB_PREFIX%push_message`
  ADD PRIMARY KEY (`id`,`type`);

--
-- Indexes for table `%DB_PREFIX%read_message`
--
ALTER TABLE `%DB_PREFIX%read_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_read_message_user` (`message_id`,`user_id`) USING BTREE,
  ADD KEY `ix_read_message_seller` (`message_id`,`seller_id`) USING BTREE,
  ADD KEY `ix_read_message_staff` (`message_id`,`staff_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%refund`
--
ALTER TABLE `%DB_PREFIX%refund`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%region`
--
ALTER TABLE `%DB_PREFIX%region`
  ADD PRIMARY KEY (`id`),
  ADD KEY `r1` (`pid`,`sort`) USING BTREE,
  ADD FULLTEXT KEY `r2` (`matchs`);

--
-- Indexes for table `%DB_PREFIX%repair`
--
ALTER TABLE `%DB_PREFIX%repair`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%repair_type`
--
ALTER TABLE `%DB_PREFIX%repair_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%room_fee`
--
ALTER TABLE `%DB_PREFIX%room_fee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`id`,`seller_id`,`build_id`,`room_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%seller`
--
ALTER TABLE `%DB_PREFIX%seller`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user_id`),
  ADD KEY `mobile` (`mobile`) USING BTREE,
  ADD KEY `city_id` (`city_id`),
  ADD FULLTEXT KEY `name_match` (`name_match`);

--
-- Indexes for table `%DB_PREFIX%seller_authenticate`
--
ALTER TABLE `%DB_PREFIX%seller_authenticate`
  ADD PRIMARY KEY (`seller_id`);

--
-- Indexes for table `%DB_PREFIX%seller_auth_icon`
--
ALTER TABLE `%DB_PREFIX%seller_auth_icon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%seller_bank`
--
ALTER TABLE `%DB_PREFIX%seller_bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%seller_cate`
--
ALTER TABLE `%DB_PREFIX%seller_cate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `a1` (`id`,`pid`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%seller_cate_related`
--
ALTER TABLE `%DB_PREFIX%seller_cate_related`
  ADD PRIMARY KEY (`seller_id`,`cate_id`);

--
-- Indexes for table `%DB_PREFIX%seller_delivery_time`
--
ALTER TABLE `%DB_PREFIX%seller_delivery_time`
  ADD KEY `a1` (`seller_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%seller_extend`
--
ALTER TABLE `%DB_PREFIX%seller_extend`
  ADD PRIMARY KEY (`seller_id`),
  ADD KEY `goods_avg_price` (`goods_avg_price`),
  ADD KEY `credit_score` (`credit_score`);

--
-- Indexes for table `%DB_PREFIX%seller_icon_related`
--
ALTER TABLE `%DB_PREFIX%seller_icon_related`
  ADD PRIMARY KEY (`seller_id`,`icon_id`);

--
-- Indexes for table `%DB_PREFIX%seller_map`
--
ALTER TABLE `%DB_PREFIX%seller_map`
  ADD PRIMARY KEY (`seller_id`),
  ADD SPATIAL KEY `map_point` (`map_point`),
  ADD SPATIAL KEY `map_pos` (`map_pos`);

--
-- Indexes for table `%DB_PREFIX%seller_money_log`
--
ALTER TABLE `%DB_PREFIX%seller_money_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`) USING BTREE,
  ADD KEY `seller` (`seller_id`),
  ADD KEY `related_type` (`related_id`,`type`),
  ADD KEY `create_day` (`create_day`);

--
-- Indexes for table `%DB_PREFIX%seller_pay_log`
--
ALTER TABLE `%DB_PREFIX%seller_pay_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `seller_pay` (`seller_id`,`pay_day`),
  ADD KEY `seller_create` (`seller_id`,`create_day`,`status`);

--
-- Indexes for table `%DB_PREFIX%seller_search`
--
ALTER TABLE `%DB_PREFIX%seller_search`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%seller_service_time_set`
--
ALTER TABLE `%DB_PREFIX%seller_service_time_set`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%seller_staff`
--
ALTER TABLE `%DB_PREFIX%seller_staff`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user_id`),
  ADD KEY `mobile` (`mobile`) USING BTREE,
  ADD FULLTEXT KEY `name_match` (`name_match`);

--
-- Indexes for table `%DB_PREFIX%seller_staff_bank`
--
ALTER TABLE `%DB_PREFIX%seller_staff_bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%seller_staff_extend`
--
ALTER TABLE `%DB_PREFIX%seller_staff_extend`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `%DB_PREFIX%seller_staff_money_log`
--
ALTER TABLE `%DB_PREFIX%seller_staff_money_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`) USING BTREE,
  ADD KEY `seller` (`staff_id`),
  ADD KEY `related_type` (`related_id`,`type`),
  ADD KEY `create_day` (`create_day`);

--
-- Indexes for table `%DB_PREFIX%seller_staff_withdraw_money`
--
ALTER TABLE `%DB_PREFIX%seller_staff_withdraw_money`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `seller` (`staff_id`),
  ADD KEY `create_day` (`create_day`);

--
-- Indexes for table `%DB_PREFIX%seller_staff_work`
--
ALTER TABLE `%DB_PREFIX%seller_staff_work`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `%DB_PREFIX%seller_withdraw_money`
--
ALTER TABLE `%DB_PREFIX%seller_withdraw_money`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `seller` (`seller_id`),
  ADD KEY `create_day` (`create_day`);

--
-- Indexes for table `%DB_PREFIX%sharechapman_log`
--
ALTER TABLE `%DB_PREFIX%sharechapman_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%share_log`
--
ALTER TABLE `%DB_PREFIX%share_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `%DB_PREFIX%shopping_cart`
--
ALTER TABLE `%DB_PREFIX%shopping_cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%staff_leave`
--
ALTER TABLE `%DB_PREFIX%staff_leave`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%staff_service_time_set`
--
ALTER TABLE `%DB_PREFIX%staff_service_time_set`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%system_config`
--
ALTER TABLE `%DB_PREFIX%system_config`
  ADD PRIMARY KEY (`code`),
  ADD KEY `group_code` (`group_code`);

--
-- Indexes for table `%DB_PREFIX%system_goods`
--
ALTER TABLE `%DB_PREFIX%system_goods`
  ADD PRIMARY KEY (`id`),
  ADD FULLTEXT KEY `name` (`name`);

--
-- Indexes for table `%DB_PREFIX%system_goods_norms`
--
ALTER TABLE `%DB_PREFIX%system_goods_norms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un` (`name`,`system_goods_id`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%system_tag`
--
ALTER TABLE `%DB_PREFIX%system_tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%system_tag_list`
--
ALTER TABLE `%DB_PREFIX%system_tag_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `%DB_PREFIX%user`
--
ALTER TABLE `%DB_PREFIX%user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mobile` (`mobile`),
  ADD KEY `name` (`name`) USING BTREE,
  ADD FULLTEXT KEY `name_match` (`name_match`);

--
-- Indexes for table `%DB_PREFIX%user_address`
--
ALTER TABLE `%DB_PREFIX%user_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user_id`);

--
-- Indexes for table `%DB_PREFIX%user_address_logs`
--
ALTER TABLE `%DB_PREFIX%user_address_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%user_bank`
--
ALTER TABLE `%DB_PREFIX%user_bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%user_collect`
--
ALTER TABLE `%DB_PREFIX%user_collect`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_time` (`user_id`,`create_time`),
  ADD KEY `restaurant_user` (`goods_id`,`user_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `%DB_PREFIX%user_integral`
--
ALTER TABLE `%DB_PREFIX%user_integral`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%user_mobile`
--
ALTER TABLE `%DB_PREFIX%user_mobile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%user_pay_log`
--
ALTER TABLE `%DB_PREFIX%user_pay_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `user` (`user_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `seller_pay` (`seller_id`,`pay_day`),
  ADD KEY `seller_create` (`seller_id`,`create_day`,`status`);

--
-- Indexes for table `%DB_PREFIX%user_praise`
--
ALTER TABLE `%DB_PREFIX%user_praise`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `%DB_PREFIX%user_refund_log`
--
ALTER TABLE `%DB_PREFIX%user_refund_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `user` (`user_id`),
  ADD KEY `refund_id` (`refund_id`),
  ADD KEY `seller_create` (`seller_id`,`create_day`,`status`);

--
-- Indexes for table `%DB_PREFIX%user_verify_code`
--
ALTER TABLE `%DB_PREFIX%user_verify_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `mobile_type` (`mobile`,`type`) USING BTREE;

--
-- Indexes for table `%DB_PREFIX%wap_nav`
--
ALTER TABLE `%DB_PREFIX%wap_nav`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `%DB_PREFIX%activity`
--
ALTER TABLE `%DB_PREFIX%activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%activity_goods`
--
ALTER TABLE `%DB_PREFIX%activity_goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%activity_logs`
--
ALTER TABLE `%DB_PREFIX%activity_logs`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%activity_promotion`
--
ALTER TABLE `%DB_PREFIX%activity_promotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%activity_seller`
--
ALTER TABLE `%DB_PREFIX%activity_seller`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%admin_log`
--
ALTER TABLE `%DB_PREFIX%admin_log`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%admin_role`
--
ALTER TABLE `%DB_PREFIX%admin_role`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%admin_user`
--
ALTER TABLE `%DB_PREFIX%admin_user`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%adv`
--
ALTER TABLE `%DB_PREFIX%adv`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%adv_position`
--
ALTER TABLE `%DB_PREFIX%adv_position`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%article`
--
ALTER TABLE `%DB_PREFIX%article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%article_cate`
--
ALTER TABLE `%DB_PREFIX%article_cate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%district`
--
ALTER TABLE `%DB_PREFIX%district`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%door_access`
--
ALTER TABLE `%DB_PREFIX%door_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%door_open_log`
--
ALTER TABLE `%DB_PREFIX%door_open_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%feedback`
--
ALTER TABLE `%DB_PREFIX%feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%forum_complain`
--
ALTER TABLE `%DB_PREFIX%forum_complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%forum_message`
--
ALTER TABLE `%DB_PREFIX%forum_message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%forum_plate`
--
ALTER TABLE `%DB_PREFIX%forum_plate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%forum_posts`
--
ALTER TABLE `%DB_PREFIX%forum_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%freight_tmp`
--
ALTER TABLE `%DB_PREFIX%freight_tmp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%goods`
--
ALTER TABLE `%DB_PREFIX%goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%goods_cate`
--
ALTER TABLE `%DB_PREFIX%goods_cate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%goods_norms`
--
ALTER TABLE `%DB_PREFIX%goods_norms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%hot_words`
--
ALTER TABLE `%DB_PREFIX%hot_words`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%index_nav`
--
ALTER TABLE `%DB_PREFIX%index_nav`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%invitation`
--
ALTER TABLE `%DB_PREFIX%invitation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%invitation_back_log`
--
ALTER TABLE `%DB_PREFIX%invitation_back_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%live_log`
--
ALTER TABLE `%DB_PREFIX%live_log`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '只增id';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%logistics_refund`
--
ALTER TABLE `%DB_PREFIX%logistics_refund`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%menu`
--
ALTER TABLE `%DB_PREFIX%menu`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%message_send`
--
ALTER TABLE `%DB_PREFIX%message_send`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%msg_model`
--
ALTER TABLE `%DB_PREFIX%msg_model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%order`
--
ALTER TABLE `%DB_PREFIX%order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%order_goods`
--
ALTER TABLE `%DB_PREFIX%order_goods`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单商品ID';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%order_promotion`
--
ALTER TABLE `%DB_PREFIX%order_promotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%order_rate`
--
ALTER TABLE `%DB_PREFIX%order_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%order_track`
--
ALTER TABLE `%DB_PREFIX%order_track`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%pay_item`
--
ALTER TABLE `%DB_PREFIX%pay_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%promotion`
--
ALTER TABLE `%DB_PREFIX%promotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%promotion_sn`
--
ALTER TABLE `%DB_PREFIX%promotion_sn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_bind_deivce`
--
ALTER TABLE `%DB_PREFIX%property_bind_deivce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_building`
--
ALTER TABLE `%DB_PREFIX%property_building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_fee`
--
ALTER TABLE `%DB_PREFIX%property_fee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_order`
--
ALTER TABLE `%DB_PREFIX%property_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_order_item`
--
ALTER TABLE `%DB_PREFIX%property_order_item`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单商品ID';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_room`
--
ALTER TABLE `%DB_PREFIX%property_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%property_user`
--
ALTER TABLE `%DB_PREFIX%property_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%proxy`
--
ALTER TABLE `%DB_PREFIX%proxy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%puser_door`
--
ALTER TABLE `%DB_PREFIX%puser_door`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%push_message`
--
ALTER TABLE `%DB_PREFIX%push_message`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%read_message`
--
ALTER TABLE `%DB_PREFIX%read_message`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%refund`
--
ALTER TABLE `%DB_PREFIX%refund`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%region`
--
ALTER TABLE `%DB_PREFIX%region`
  MODIFY `id` mediumint(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3339;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%repair`
--
ALTER TABLE `%DB_PREFIX%repair`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%repair_type`
--
ALTER TABLE `%DB_PREFIX%repair_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%room_fee`
--
ALTER TABLE `%DB_PREFIX%room_fee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller`
--
ALTER TABLE `%DB_PREFIX%seller`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_auth_icon`
--
ALTER TABLE `%DB_PREFIX%seller_auth_icon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_bank`
--
ALTER TABLE `%DB_PREFIX%seller_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_cate`
--
ALTER TABLE `%DB_PREFIX%seller_cate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_money_log`
--
ALTER TABLE `%DB_PREFIX%seller_money_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_pay_log`
--
ALTER TABLE `%DB_PREFIX%seller_pay_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_search`
--
ALTER TABLE `%DB_PREFIX%seller_search`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_service_time_set`
--
ALTER TABLE `%DB_PREFIX%seller_service_time_set`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_staff`
--
ALTER TABLE `%DB_PREFIX%seller_staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_staff_bank`
--
ALTER TABLE `%DB_PREFIX%seller_staff_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=139;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_staff_money_log`
--
ALTER TABLE `%DB_PREFIX%seller_staff_money_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=2356;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_staff_withdraw_money`
--
ALTER TABLE `%DB_PREFIX%seller_staff_withdraw_money`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=83;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_staff_work`
--
ALTER TABLE `%DB_PREFIX%seller_staff_work`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%seller_withdraw_money`
--
ALTER TABLE `%DB_PREFIX%seller_withdraw_money`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%sharechapman_log`
--
ALTER TABLE `%DB_PREFIX%sharechapman_log`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%share_log`
--
ALTER TABLE `%DB_PREFIX%share_log`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%shopping_cart`
--
ALTER TABLE `%DB_PREFIX%shopping_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%staff_leave`
--
ALTER TABLE `%DB_PREFIX%staff_leave`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%staff_service_time_set`
--
ALTER TABLE `%DB_PREFIX%staff_service_time_set`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%system_goods`
--
ALTER TABLE `%DB_PREFIX%system_goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%system_goods_norms`
--
ALTER TABLE `%DB_PREFIX%system_goods_norms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%system_tag`
--
ALTER TABLE `%DB_PREFIX%system_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%system_tag_list`
--
ALTER TABLE `%DB_PREFIX%system_tag_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user`
--
ALTER TABLE `%DB_PREFIX%user`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_address`
--
ALTER TABLE `%DB_PREFIX%user_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_address_logs`
--
ALTER TABLE `%DB_PREFIX%user_address_logs`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_bank`
--
ALTER TABLE `%DB_PREFIX%user_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_collect`
--
ALTER TABLE `%DB_PREFIX%user_collect`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_integral`
--
ALTER TABLE `%DB_PREFIX%user_integral`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_mobile`
--
ALTER TABLE `%DB_PREFIX%user_mobile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_pay_log`
--
ALTER TABLE `%DB_PREFIX%user_pay_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_praise`
--
ALTER TABLE `%DB_PREFIX%user_praise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_refund_log`
--
ALTER TABLE `%DB_PREFIX%user_refund_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号';
--
-- AUTO_INCREMENT for table `%DB_PREFIX%user_verify_code`
--
ALTER TABLE `%DB_PREFIX%user_verify_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `%DB_PREFIX%wap_nav`
--
ALTER TABLE `%DB_PREFIX%wap_nav`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

