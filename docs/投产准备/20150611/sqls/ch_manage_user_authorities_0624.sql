＃给admin追加退货信息权限
INSERT INTO cupid.ch_manage_authorities(authority,remark) VALUES('ROLE_ORDERCANCEMANAGE','退货信息');

insert into cupid.ch_manage_user_authorities(username,authority) values ('admin','ROLE_ORDERCANCEMANAGE');
