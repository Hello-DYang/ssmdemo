<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>修改人员信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
    <!-- 引入 Layui -->
    <link rel="stylesheet" type="text/css" href="../../layui/css/layui.css">
    <style>
        .layui-form-label{
            padding-left: 12px;
            padding-right: 12px
        }
        .layui-input{
            width: 30%;
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
                    <small>修改人员信息</small>
                </h1>
            </div>
        </div>
    </div>

    <form class="layui-form" action="" name="userForm" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${paper.id}"/>
        <div class="layui-form-item">
            <label  class="layui-form-label">人员名称</label>
            <div class="layui-input-block">
                <input type="text" name="username" required  lay-verify="required" value="${paper.username}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">上传头像</label>
            <input type="file" name="file"><br>
        </div>
            <div class="layui-form-item">
                <label  class="layui-form-label">人员年龄</label>
                <div class="layui-input-block">
                    <input type="text" name="age" required  lay-verify="required" value="${paper.age}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">人员地址</label>
                <div class="layui-input-block">
                    <input type="text" name="address" required  lay-verify="required" value="${paper.address}" autocomplete="off" class="layui-input">
                </div>
            </div>
        <div class="layui-form-item">
            <label class="layui-form-label">人员性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男" checked="${paper.sex=="男"?"'checked'":''}"/>
                <input type="radio" name="sex" value="女" title="女" checked="${paper.sex=="女"?"'checked'":''}"/>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="updatePaper()">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </div>
    </form>
</div>
    <script src="../../js/jquery.js"></script>
    <script src="../../layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        // 。依赖加载模块：form （请注意：如果不加载form模块，select、checkbox、radio等将无法显示，并且无法使用 form 相关功能）
        layui.use('form', function(){
            var form = layui.form;
        });
        function updatePaper() {
            var form = document.forms[0];
            form.action = "<%=basePath %>user/updateByPrimaryKeySelective";
            form.method = "post";
            form.submit();
        }

    </script>
