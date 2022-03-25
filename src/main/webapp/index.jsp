<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("path", request.getContextPath());
%>
<!-- 引入 Bootstrap -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
<!-- 引入 Layui -->
<link rel="stylesheet" type="text/css" href="/layui/css/layui.css">
<!DOCTYPE HTML>
<html>
<head>
    <title>首页</title>
    <style type="text/css">
        a {
            text-decoration: none;
            color: black;
            font-size: 18px;
        }

        h3 {
            width: 180px;
            height: 38px;
            margin: 100px auto;
            text-align: center;
            line-height: 38px;
            background: deepskyblue;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container">
<div class="row clearfix">
    <div class="col-md-12 column">
        <div class="page-header">
            <h1>
                基于SSM框架的管理系统：简单实现增、删、改、查。
            </h1>
        </div>
    </div>
</div>

<div class="row clearfix">
    <div class="col-md-12 column">
        <div class="page-header">
            <h1>
                <small>主页-首页</small>
            </h1>
        </div>
    </div>
</div>
<div  class="btn-group" role="group" aria-label="...">
    <button style="background-color: aquamarine" type="button" class="btn btn-default"><a href="/user/pagingQueryUserList">点击进入-用户管理</a></button>
    <button style="background-color: aquamarine" type="button" class="btn btn-default"><a href="/led/pagingQueryLedList">点击进入-Led屏管理</a></button>
    <button style="background-color: aquamarine" type="button" class="btn btn-default"><a href="/paper/toVerify">滑动验证-腾讯云</a></button>
    <button style="background-color: aquamarine" type="button" class="btn btn-default"><a href="/paper/toCaptcha">滑动验证-tianai</a></button>
</div>
</div>
</body>
</html>