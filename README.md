# LW
Life And Work


1.因为有计步器、视频录制、相机、陀螺仪、蓝牙扫描等功能，所以需要真机运行、否则大部分功能无法演示

2.ServiceApp 是服务器,打开后会自动获取本机ip做为服务器ip  默认启用8080接口 点击"开始监控"服务器开始运行,服务器地址 https://github.com/joy-make/socketServer.git

3.LW 是客户端 没有设置密码，直接点击头像即可登陆进去后，左上角头像点击可以设置服务器ip（serviceapp在serviceapp页面启动时显示栏中获取），端口无需设置，默认服务器、客户端均设置了8080端口

4.JoyTool 也是自己封装的pod库，主要有presenter(业务逻辑处理)、interactor(数据处理、管理)和一些公共的view供页面快速开发使用,JoyTableAutoLayoutView是一个公共的listview,封装了table的大部分功能(autolayout实现了页面包括cell在内的自动布局,不在需要实现table的代理、包括cell高度计算、文本类的编辑键盘处理、文本类的字数限制、cell自动计算缓存、可编辑类文本的缓存)，list类的页面毋需自己写ui，只要配置自己的interactor数据源去驱动页面即可、对于事件点击、文本编辑、滑动删除功能均已block回调可自由处理

5.使用方法:命令终端进入项目目录执行 pod update 安装pod依赖库


![image.png](https://github.com/joymakee/LW/blob/master/demo.jpg?raw=true)

![image.png](https://github.com/joymakee/LW/blob/master/lw.png?raw=true)
