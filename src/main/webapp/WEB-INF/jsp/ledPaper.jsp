<% pageContext.setAttribute("path", request.getContextPath());%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String appPath = request.getContextPath(); %>
<html>
<head>
    <title>Paper列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
    <!-- 引入 Layui -->
    <link rel="stylesheet" type="text/css" href="../../layui/css/layui.css">
    <style>
        hr{
            background-color: #F8F8F8;
        }
    </style>
    <!DOCTYPE HTML>
</head>
<body>
<div class="container">
    <c:set var="totalUsers" value="${requestScope.totalUsers}"/>
    <c:set var="usersPerPage" value="${requestScope.usersPerPage}"/>
    <c:set var="totalPages" value="${requestScope.totalPages}"/>
    <c:set var="beginIndex" value="${requestScope.beginIndex}"/>
    <c:set var="endIndex" value="${requestScope.endIndex}"/>
    <c:set var="page" value="${requestScope.page}"/>
    <c:set var="name" value="${requestScope.name}"></c:set>
    <c:set var="sorted" value="${requestScope.sorted}"></c:set>
    <c:set var="currentPageUsers" value="${requestScope.users.subList(beginIndex,endIndex)}"/>
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
                    <c:out value="${path}"></c:out>
                    <c:out value="${basePath}"></c:out>
                    <small>Led屏列表 —— 显示所有Led</small>
                </h1>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="btn-group" role="group" aria-label="...">
            <div style="display: inline"><button style="background-color: #92B8B1" type="button" class="btn btn-default"><a href="${path}/paper/toAddLedPaper">新增</a></button></div>
            <form class="layui-form" action="" name="userForm">
                <input  type="hidden" name="id" value="${paper.id}"/>
                <div style="display: inline" class="layui-form-item">
                    <label style="width: 110px;padding-left: 3px" class="layui-form-label">Led名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="username" name="name" placeholder="请输入Led名称" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="submitQuery()">查询</button>
            </form>
<%--            弹框输入--%>
                <button style="margin-top: 5px" class="layui-btn" onclick="deleteAllChoose()" lay-submit lay-filter="formDemo" id="btn_1">批量删除屏幕</button>
            <button style="margin-top: 5px" class="layui-btn" lay-submit lay-filter="formDemo" onclick="exportExcelByXhr()">导出</button>

    </div>
    <div class="row clearfix">
            <table class="layui-table" lay-size="lg">
                <colgroup>
                    <col width="150">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th style="font-size: 13px">
                        <span> <a href="/led/pagingQueryLedList?page=${page}&sorted=1"><i class="layui-icon layui-icon-up" style="font-size: 14px; color: #1E9FFF;cursor:pointer"></i></a></span>
                        Led编号
                        <span> <a href="/led/pagingQueryLedList?page=${page}&sorted=2"><i class="layui-icon layui-icon-down" style="font-size: 14px; color: #1E9FFF;cursor:pointer"></i></a></span>
                    </th>
                    <th>Led名称</th>
                    <th>高度</th>
                    <th>宽度</th>
                    <th>所属组织机构</th>
                    <th>设备编号</th>
                    <th>型号名称</th>
                    <th>备注</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${currentPageUsers}">
                    <tr>
                        <td><input name="choose" type="checkbox" value="${user.id}">${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.width}</td>
                        <td>${user.hight}</td>
                        <td>${user.affiliatedOrganization}</td>
                        <td>${user.deviceId}</td>
                        <td>${user.modelName}</td>
                        <td>${user.remark}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="...">
                                <button type="button" style="background-color: #92B8B1" class="btn btn-default"><a href="${path}/paper/toUpdateLed?id=${user.id}">编辑</a></button>
                                <button type="button" style="background-color: #92B8B1" class="btn btn-default"><a href="javascript:void(0)" onclick="confirmDel(${user.id})">删除</a></button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

<%--        分页--%>
        <div class="text-center" style="text-align: center">
            <nav>
                <ul class="pagination">
                    <li class="page-item ${page==1?'disabled':''}"><a class="page-link"
                                                                      href="<c:url value="${path}/led/pagingQueryLedList?page=${page-1>1?page-1:1}&sorted=${sorted}&name=${name}"/>">上一页</a>
                    </li>
                    <c:if test="${page!=1}">
                        <li class="page-item">
                            <a class="page-link" href="<c:url value="${path}/led/pagingQueryLedList?page=1&sorted=${sorted}&name=${name}"/>">1</a>
                        </li>
                    </c:if>
                    <c:if test="${page>3}">
                        <li class="page-item disabled">
                            <a class="page-link">...</a>
                        </li>
                    </c:if>
                    <li class="page-item active">
                        <a class="page-link" href="<c:url value="${path}/led/pagingQueryLedList?page=${page}&sorted=${sorted}&name=${name}"/>">${page}</a>
                    </li>
                    <c:if test="${totalPages-page>2}">
                        <li class="page-item disabled">
                            <a class="page-link">...</a>
                        </li>
                    </c:if>
                    <c:if test="${page!=totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="<c:url value="${path}/led/pagingQueryLedList?page=${totalPages}&sorted=${sorted}&name=${name}"/>">${totalPages}</a>
                        </li>
                    </c:if>

                    <li class="page-item ${page==totalPages?'disabled':''}">
                        <a class="page-link" href="<c:url value="${path}/led/pagingQueryLedList?page=${page+1<totalPages?page+1:totalPages}&sorted=${sorted}&name=${name}"/>">下一页</a>
                    </li>
                </ul>

            </nav>
        </div>

    </div>
</div>
<script src="../../js/jquery.js"></script>
<script src="../../layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var xmlhttp;
        if (window.XMLHttpRequest)
        {
            //  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
            xmlhttp=new XMLHttpRequest();
        }
        else
        {
            // IE6, IE5 浏览器执行代码
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }

        function confirmDel(param)
        {
            if(window.confirm("确定删除?")){
            document.location="<%=appPath%>/led/deleteLedById/"+param
        }
        }
        // 查询
        function submitQuery() {
            const name = $("#username").val();
            xmlhttp.open("GET","<%=basePath %>led/pagingQueryLedList?name="+name,true);
            xmlhttp.send();
        }
        // 批量删除
        function deleteAllChoose() {
            if(window.confirm("确定删除?")) {
                var temp = "";
                var ids = "";
                var id = document.getElementsByName("choose");
                for (var i = 0; i < id.length; i++) {
                    if (id[i].checked) {
                        temp = id[i].value;
                        ids = ids + "," + temp;
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "<%=basePath %>led/deleteAllChooseLed",
                    dataType: "json",
                    data: {"ids": ids},
                    success: function (data) {
                        alert("批量更新成功")
                    },
                    error: function () {
                        console.log("error")
                    }
                })
                this.submitQuery();
            }
        }

        function exportExcelByXhr() {
            var oReq = new XMLHttpRequest();
            oReq.open("GET", "<%=basePath %>led/download", true);
            oReq.responseType = "blob";
            oReq.onload = function (oEvent) {
                var content = oReq.response;
                var elink = document.createElement('a');
                elink.download = "led列表.xlsx";
                elink.style.display = 'none';
                var blob = new Blob([content]);
                elink.href = URL.createObjectURL(blob);
                document.body.appendChild(elink);
                elink.click();
                document.body.removeChild(elink);
            };
            oReq.send();
        }
    </script>
</body>
