
#新增用户 admin 密码：admin
insert into cupid.ch_manage_user(username,password,type) values ('admin','$2a$04$miYtXC9SCrDevLTsmpjxguEELuui/RJOIg8yptXG1WfvpGw8zawnO',0);

＃新增基础权限表
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_PRODUCTMANAGE','商品管理');
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_PRICEMANAGE','价格管理');
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_COMMONUSERMANAGE','普通用户管理');
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_MANAGEUSERMANAGE','后台管理');
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_ORDERMANAGE','订单管理');
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_STATISTICS','统计查询');

#新增供应商商信息表 2015-06－15 fzr
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_SUPPLIER','供应商信息');

＃给admin追加权限
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_PRODUCTMANAGE');
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_PRICEMANAGE');
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_COMMONUSERMANAGE');
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_MANAGEUSERMANAGE');
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_ORDERMANAGE');
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_STATISTICS');

#新增供应商商信息表 2015-06－15 fzr
insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_SUPPLIER');
