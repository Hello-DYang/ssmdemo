<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>新增Led屏</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
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
                    <small>添加led屏幕</small>
                </h1>
            </div>
        </div>
    </div>

    <form class="layui-form" action="" name="userForm">
        Led名称：<input type="text" name="name"><br><br><br>
        高度：<input type="text" name="width"><br><br><br>
        宽度：<input type="text" name="hight"><br><br><br>
        所属组织机构：<input type="text" name="affiliatedOrganization"><br><br><br>
        设备编号：<input type="text" name="deviceId"><br><br><br>
        型号名称：<input type="text" name="modelName"><br><br><br>
        备注：<input type="text" name="remark"><br><br><br>
        <input type="button" value="添加" onclick="addPaper()">
    </form>
</div>
</body>

    <script type="text/javascript">
        function addPaper() {
            var form = document.forms[0];
            form.action = "<%=basePath %>led/addLed";
            form.method = "post";
            form.submit();
        }
    </script>