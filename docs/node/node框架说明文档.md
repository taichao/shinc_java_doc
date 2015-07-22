NODE 框架使用文档
# 目录结构说明
- cmd
	启动脚本
```
sh service.sh [start|restart|stop|restartS|restartJ|min|normal|clear|mincss]
```

- jserver 静态资源服务目录
1. jserver.js 为实际启动入口
2. config/service.json 静态资源服务配置信息
			

```
{
			"max_time": 3000,
			"root": "/Users/taichao/Code/berners/web",
			"onPort": 3001,
			"jspath": "script-min/"
}
```
>root:根据个人情况配置
>onPort:启动端口

- server 动态接口服务目录
server/config/site.json

```
{
	"SVERSION": 109.0305,
	"JCSTATIC_BASE": "",
	"CSS_JS_BASE_URL": "http://localhost:3001",
	"SERVER_BASE": "/",
	"SCRIPT_BASE": "script-ss/",
	"JS_Defer": true,
	"GOODS_URL": "",
	"PICTURE_URL": "",
	"AVATOR_PIC": "",
	"IMG_URL": "",
	"CSSEXT": ".css",
	"pageTitle": "",
	"keywords": "",
	"meta_description": "",
	"national_day_active": true,
	"is_offline": true
}
```

>CSS_JS_BASE_URL:根据实际情况配置

virtual_host.json

```
{
  "localhost" : "news.com"
}
```

- web 静态资源存放目录

# 开发流程说明
- 请求示例
`curl -d postparam1=testpost http://localhost:3000/user/list/param=1?getpatam=2`
向访问服务器http://localhost:3000/user/list/param=1?getpatam=2，方法POST,POST参数为：postparam1=testpost

## node端处理流程
### 1. 定位访问域
>取hostname=localhost, 读取virtual_host.json 
>`{
  "localhost" : "news.com"
}`
>得到访问为news.com.计算的到实际访问域controller/news.com
### 2. 定位模块
>取pathname=/user/list/param=1
>模块文件名/方法名/[参数] 
>模块：user
>方法：list
>参数：param=1
### 3. 找到实际controller方法
>controller/news.com/user.js的list方法
>`'list' : function(params){
		console.log('params' + params);
		// console.log('reqdata=' + JSON.parse(this.__reqdata));
		for(var i in this.__reqdata) {
			console.log(this.__reqdata[i])
		}
		console.log(this.req.__get);
		console.log(this.req.__post)
		console.log(this.req.method)
		console.log(this.__get);
		var php = {
			'getAdminUser':'/infomgmt/adminUser/getAdminUserById'
		}
		var mSelf = this;
		this.setDefaultData(php);
		this.bridgeMuch(php);
		this.listenOver(function(data){
			console.log(data)
			if(!data.getAdminUser) {
			} else {
				data.url = helper.getUrlMethod(this.modObj.req.url);
				data.menu = helper.getMenuList();
				mSelf.render('user/list.html' , data);
			}
		});
	}`
	params:param=1
	this.__reqdata:包含post和get的所有参数
	this.req.__get:get方法参数
	this.req.__post：post请求参数
	
### 4. 向java端发接口
>- 构造请求参数
		`var php = {
			'getAdminUser':'/infomgmt/adminUser/getAdminUserById'}`
		
>- 构造请求api
>`this.bridgeMuch(php);`
>发送请求并接收响应处理
>`this.listenOver(function(data){
			console.log(data)
			if(!data.getAdminUser) {
			} else {
				data.url = helper.getUrlMethod(this.modObj.req.url);
				data.menu = helper.getMenuList();
				mSelf.render('user/list.html' , data);
			}
		});`
		data的结果为：
		`{ SVERSION: 109.031,
  JCSTATIC_BASE: '',
  CSS_JS_BASE_URL: 'http://localhost:3001',
  SERVER_BASE: '/',
  SCRIPT_BASE: 'script-ss/',
  JS_Defer: true,
  GOODS_URL: '',
  PICTURE_URL: '',
  AVATOR_PIC: '',
  IMG_URL: '',
  CSSEXT: '.css',
  pageTitle: '',
  keywords: '',
  meta_description: '',
  national_day_active: true,
  is_offline: true,
  getAdminUser:
   { code: 'SUCCESS',
     message: '交易成功',
     detail: null,
     result:
      { id: 78,
        realname: '张三',
        nickname: '小王',
        password: '666666',
        sex: '1',
        address: '北京朝阳望京',
        tel: '12345678911',
        email: 'steve_hi@163.com',
        createTime: 1437389368000,
        updateTime: 1437389796000,
        enabled: '1',
        remark: null,
        company: [Object],
        adminUserPosition: [Object],
        position: null,
        menuMap: null,
        authorityList: [Object],
        authCateList: [Object],
        manageCateList: [Object] } } }`
        注意他的getAdminUser属性，
        java服务端接受日志为：
        ` HttpServletRequest:
         HTTP Method = POST
         Request URI = /infomgmt/adminUser/getAdminUserById
          Parameters = {id=[78]}`
          注意Parameters属性
####响应页面
<script src="<%= this.CSS_JS_BASE_URL %>/flatlib/js/jquery-1.8.3.min.js"></script>
