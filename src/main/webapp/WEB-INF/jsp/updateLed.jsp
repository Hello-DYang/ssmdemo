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
                    <small>修改Led信息</small>
                </h1>
            </div>
        </div>
    </div>

    <form class="layui-form" action="" name="userForm" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${paper.id}"/>
        <div class="layui-form-item">
            <label  class="layui-form-label">Led名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" required  lay-verify="required" value="${paper.name}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">高度</label>
            <div class="layui-input-block">
                <input type="text" name="width" required  lay-verify="required" value="${paper.width}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">宽度</label>
            <div class="layui-input-block">
                <input type="text" name="hight" required  lay-verify="required" value="${paper.hight}" autocomplete="off" class="layui-input">
            </div>
        </div>
            <div class="layui-form-item">
                <label  class="layui-form-label">所属组织机构</label>
                <div class="layui-input-block">
                    <input type="text" name="affiliatedOrganization" required  lay-verify="required" value="${paper.affiliatedOrganization}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">设备编号</label>
                <div class="layui-input-block">
                    <input type="text" name="deviceId" required  lay-verify="required" value="${paper.deviceId}" autocomplete="off" class="layui-input">
                </div>
            </div>
        <div class="layui-form-item">
            <label class="layui-form-label">型号名称</label>
            <div class="layui-input-block">
                <input type="text" name="modelname" required  lay-verify="required" value="${paper.modelName}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" name="remark" required  lay-verify="required" value="${paper.remark}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
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
            form.action = "<%=basePath %>led/updateLed";
            form.method = "post";
            form.submit();
        }

    </script>
