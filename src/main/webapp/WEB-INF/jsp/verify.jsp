<%--
  Created by IntelliJ IDEA.
  User: yunping
  Date: 2022/3/17
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Web 前端接入示例</title>
    <!-- 验证码程序依赖(必须)。请勿修改以下程序依赖，如使用本地缓存，或通过其他手段规避加载，会影响程序的正常使用。 -->
<%--    <script src="https://ssl.captcha.qq.com/TCaptcha.js"></script>--%>
    <!-- 如果script是在head中引入 onerror的函数需等domready再绑定元素事件 在body中加载无需等待 -->
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap-5.1.3/font/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap-5.1.3/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-theme.min.css">
    <script src="../../js/jquery.js"></script>
    <script src="https://ssl.captcha.qq.com/TCaptcha.js" onerror="TCaptchaLoadError()"></script>
    <style>
        html {
            min-width: 1080px;
            height: 100%;
        }
        body{
            height: 100%;
        }
        body {
            background-image: url("../../access/IsometricVector.jpg");
            background-repeat: no-repeat;
            background-size: cover;
        }

        div.card {
            backdrop-filter: blur(10px);
            background: none;
            padding: 20px;
            box-shadow: 0 0 25px grey;
        }
    </style>
</head>

<body class="d-flex justify-content-center align-items-center">
<div class="col-3">
    <div class="card align-items-center justify-content-center">
        <div class="row col-10 align-items-center justify-content-center">
            <h4 class="text-center mb-4">Web 前端接入示例</h4>
            <form class="needs-validation col-10" novalidate>
                <div class="mb-4 row justify-content-center">
                    <label class="col-form-label col-4 text-center" for="username">用户名</label>
                    <div class="col-8">
                        <input id="username" name="username" type="text" class="form-control form-control-sm"
                               required placeholder="请输入用户名"/>
                        <div class="invalid-feedback">
                            请输入用户名
                        </div>
                    </div>
                </div>
                <div class="mb-4 row justify-content-center">
                    <label class="col-form-label col-4 text-center" for="password">密码</label>
                    <div class="col-8">
                        <input id="password" name="password" type="password" class="form-control form-control-sm"
                               required placeholder="请输入密码"/>
                        <div class="invalid-feedback">
                            请输入密码
                        </div>
                    </div>
                </div>
                <div class="mb-4 row  text-center align-items-center justify-content-center">
                    <!--点击此元素会自动激活验证码, 此例使用的button元素, 也可以使用div、span等-->
                    <!--id :            (不可变) 元素的 ID, 值必须是 'TencentCaptcha'-->
                    <!--data-appid :    (必须) 验证码CaptchaAppId, 从腾讯云的验证码控制台中获取, 验证码控制台页面内【图形验证】>【验证列表】进行查看 。如果未新建验证，请根据业务需求选择适合的验证渠道、验证场景进行新建-->
                    <!--data-cbfn :     (必须) 回调函数名, 函数名要与 data-cbfn 相同-->
                    <!--data-biz-state :(可选) 业务自定义透传参数, 会在回调函数内获取到 （res.bizState）-->
                    <button id="TencentCaptcha" data-appid="****" data-cbfn="callbackName" data-biz-state="data-biz-state" class="btn btn-outline-primary" type="button" id="login">
                        <i class="bi bi-box-arrow-in-right"></i>
                        登陆
                    </button>
                </div>
            </form>
        </div>
        <div class="col-10">
            <img class="img-fluid"  src="<%=basePath%>/access/stick-kids.png">
        </div>
    </div>
</div>
</body>

<script>
    // 在脚本加载或初始化错误时 需手动绑定button元素的事件确保流程正常
    // 函数定义需在script加载前
    function TCaptchaLoadError(){
        var CaptchaAppId=''
        document.getElementById('TencentCaptcha').addEventListener('click', function () {
            var CaptchaAppId = ''
            /* 生成票据或自行做其它处理 */
            var ticket = 'terror_1001_' + CaptchaAppId + '_' + Math.floor(new Date().getTime()/1000)
            window.callback({
                ret: 0,
                randstr: '@'+Math.random().toString(36).substr(2),
                ticket: ticket,
                errorCode: 1001,
                errorMessage: 'jsload_error'
            })
        }, false)
    }

    // 回调函数需要放在全局对象window下
    window.callbackName = function (res) {
        // 返回结果
        // ret         Int       验证结果，0：验证成功。2：用户主动关闭验证码。
        // ticket      String    验证成功的票据，当且仅当 ret = 0 时 ticket 有值。
        // CaptchaAppId       String    验证码应用ID。
        // bizState    Any       自定义透传参数。
        // randstr     String    本次验证的随机串，请求后台接口时需带上。
        console.log('callback:', res);
        // res（用户主动关闭验证码）= {ret: 2, ticket: null}
        // res（验证成功） = {ret: 0, ticket: "String", randstr: "String"}
        // res（客户端出现异常错误 仍返回可用票据） = {ret: 0, ticket: "String", randstr: "String",  errorCode: Number, errorMessage: "String"}
        if (res.ret === 0) {
            var username=$("#username").val();
            var password=$("#password").val();
            debugger
            // 复制结果至剪切板
            <%--let str = `【randstr】->【${res.randstr}】      【ticket】->【${res.ticket}】`;--%>
            <%--let ipt = document.createElement('input');--%>
            <%--ipt.value = str;--%>
            <%--document.body.appendChild(ipt);--%>
            <%--ipt.select();--%>
            <%--document.execCommand("Copy");--%>
            <%--document.body.removeChild(ipt);--%>
            <%--alert('1. 返回结果（randstr、ticket）已复制到剪切板，ctrl+v 查看。\n2. 打开浏览器控制台，查看完整返回结果。');--%>
            $.ajax({
                type:"POST",
                url:"/verify/getVerify",
                dataType:"json",
                data:"ticket="+res.ticket+"&randstr="+res.randstr+"&username="+username+"&password="+password,
                success:function(data){
                    if (data.code==200){
                        alert(data.message)
                    }else {
                        alert(data.message)
                    }
                },
                error:function(){
                    console.log("error")
                }
            })
        }
    }

    window.callback = function(res){
        /* res（验证成功） = {ret: 0, ticket: "String", randstr: "String"}
         res（客户端出现异常错误 仍返回可用票据） = {ret: 0, ticket: "String", randstr: "String",
                                               errorCode: Number, errorMessage: "String"}
         res（用户主动关闭验证码）= {ret: 2}
         */
        if (res.ticket){
            // 上传票据 可根据errorCode和errorMessage做特殊处理或统计
        }
    }

    try {
        var captcha1 = new TencentCaptcha('CaptchaAppId', callback);
        captcha1.show(); // 显示验证码
    } catch (error) {
        loadErrorCallback();
    }

</script>

</html>
