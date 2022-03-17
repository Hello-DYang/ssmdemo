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
        .form_1{
            width:400px;
            height:200px;
            border:3px solid #f8f8f8;
            visibility: hidden;
            position: absolute;
            z-index: 999;
            opacity: 1;
            overflow: hidden;
            background-color: white;
            text-align: center;
            margin-top: 10%;
            margin-left: 35%;
            border-radius: 10px;
        }
        .open{
            visibility: visible;
            opacity: 1;
        }
        .input_1{
            margin-top: 15px;
            width:100%;
            height:40px;

        }
        .input_1 .login_logo{
            text-align: left;
            font-size: 20px;
            font-weight: 300;
            padding-left: 30px;
            float: left;
        }
        .input_1 .close{
            width:20px;
            height:20px;
            color:#5d5d5d;
            text-align: center;
            line-height: 20px;
            border:1px solid  #5d5d5d;
            border-radius: 50%;
            float: right;
            padding-top: 0px;
            margin-right: 10px;
            font-size: 12px;
        }
        .input_1 .close:hover{
            cursor:pointer;
        }
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
    <c:set var="username" value="${requestScope.username}"></c:set>
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
                    <small>人员列表 —— 显示所有人员</small>
                </h1>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="btn-group" role="group" aria-label="...">
            <div style="display: inline"><button style="background-color: #92B8B1" type="button" class="btn btn-default"><a href="${path}/paper/toAddPaper">新增</a></button></div>
            <form class="layui-form" action="" name="userForm">
                <input  type="hidden" name="id" value="${paper.id}"/>
                <div style="display: inline" class="layui-form-item">
                    <label style="width: 110px;padding-left: 3px" class="layui-form-label">人员名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="username" name="username" placeholder="请输入人员姓名" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="submitQuery()">查询</button>
            </form>
<%--            弹框输入--%>
                <button style="margin-top: 5px" class="layui-btn" lay-submit lay-filter="formDemo" id="btn_1">批量修改性别</button>
                <div class="form_1">
                    <form >
                        <div class="input_1"><div class="login_logo">批量修改性别</div><div class="close">X</div></div>
                        <hr>
                        <div class="input_1"><input class="layui-input" type="text" id="sex" name="sex" placeholder="&nbsp;性别"></div>
                        <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="submitUpdate()">提&nbsp;交</button>
                    </form>
        </div>
            <input style="margin-top: 4px"  type="file" id="file" name="myfile" />
            <input style="margin-top: 4px" class="layui-btn" type="button" onclick="UpladFile()" value="上传" />
            <input style="margin-top: 4px" class="layui-btn" type="button" onclick="cancleUploadFile()" value="取消" />

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
                        <span> <a href="/user/pagingQueryUserList?page=${page}&sorted=1"><i class="layui-icon layui-icon-up" style="font-size: 14px; color: #1E9FFF;cursor:pointer"></i></a></span>
                        人员编号
                        <span> <a href="/user/pagingQueryUserList?page=${page}&sorted=2"><i class="layui-icon layui-icon-down" style="font-size: 14px; color: #1E9FFF;cursor:pointer"></i></a></span>
                    </th>
                    <th>人员名字</th>
                    <th>人员头像</th>
                    <th>人员年龄</th>
                    <th>人员性别</th>
                    <th>人员地址</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${currentPageUsers}">
                    <tr>
                        <td><input name="choose" type="checkbox" value="${user.id}">${user.id}</td>
                        <td>${user.username}</td>
                        <th><img src="<%=basePath%>${user.photo}"></th>
                        <td>${user.age}</td>
                        <td>${user.sex}</td>
                        <td>${user.address}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="...">
                                <button type="button" style="background-color: #92B8B1" class="btn btn-default"><a href="${path}/paper/toUpdatePaper?id=${user.id}">编辑</a></button>
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
<%--                显示所有页数--%>
<%--                <ul class="pagination">--%>
<%--                    <li><a href="<c:url value="${path}/user/pagingQueryUserList?page=1"/>">首页</a></li>--%>
<%--                    <li><a href="<c:url value="${path}/user/pagingQueryUserList?page=${page-1>1?page-1:1}"/>">&laquo;</a></li>--%>
<%--                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">--%>
<%--                        <c:set var="active" value="${loop.index==page?'active':''}"/>--%>
<%--                        <li class="${active}"><a--%>
<%--                                href="<c:url value="${path}/user/pagingQueryUserList?page=${loop.index}"/>">${loop.index}</a>--%>
<%--                        </li>--%>
<%--                    </c:forEach>--%>
<%--                    <li>--%>
<%--                        <a href="<c:url value="${path}/user/pagingQueryUserList?page=${page+1<totalPages?page+1:totalPages}"/>">&raquo;</a>--%>
<%--                    </li>--%>
<%--                    <li><a href="<c:url value="${path}/user/pagingQueryUserList?page=${totalPages}"/>">尾页</a></li>--%>
<%--                </ul>--%>
<%--    显示部分页数--%>
                <ul class="pagination">
                    <li class="page-item ${page==1?'disabled':''}"><a class="page-link"
                                                                      href="<c:url value="${path}/user/pagingQueryUserList?page=${page-1>1?page-1:1}&sorted=${sorted}&username=${username}"/>">上一页</a>
                    </li>
                    <c:if test="${page!=1}">
                        <li class="page-item">
                            <a class="page-link" href="<c:url value="${path}/user/pagingQueryUserList?page=1&sorted=${sorted}&username=${username}"/>">1</a>
                        </li>
                    </c:if>
                    <c:if test="${page>3}">
                        <li class="page-item disabled">
                            <a class="page-link">...</a>
                        </li>
                    </c:if>
                    <li class="page-item active">
                        <a class="page-link" href="<c:url value="${path}/user/pagingQueryUserList?page=${page}&sorted=${sorted}&username=${username}"/>">${page}</a>
                    </li>
                    <c:if test="${totalPages-page>2}">
                        <li class="page-item disabled">
                            <a class="page-link">...</a>
                        </li>
                    </c:if>
                    <c:if test="${page!=totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="<c:url value="${path}/user/pagingQueryUserList?page=${totalPages}&sorted=${sorted}&username=${username}"/>">${totalPages}</a>
                        </li>
                    </c:if>

                    <li class="page-item ${page==totalPages?'disabled':''}">
                        <a class="page-link" href="<c:url value="${path}/user/pagingQueryUserList?page=${page+1<totalPages?page+1:totalPages}&sorted=${sorted}&username=${username}"/>">下一页</a>
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
        function confirmDel(param)
        {
            if(window.confirm("确定删除?")){
            document.location="<%=appPath%>/user/deleteByPrimaryKey/"+param
        }
        }
        function submitQuery() {
            var username=$("#username").val();
            form.action = "<%=basePath %>user/pagingQueryUserList?username=${username}";
            form.method = "post";
            form.submit();
        }
        function submitUpdate() {
            var sex=$("#sex").val();
            var temp = "";
            var ids = "";
            var id = document.getElementsByName("choose");
            for ( var i = 0; i < id.length; i++) {
                if (id[i].checked) {
                    temp = id[i].value;
                    ids = ids + "," + temp;
                }
            }
            debugger
            $.ajax({
                type:"POST",
                url:"<%=basePath %>user/updateAllUser",
                dataType:"json",
                data:{"ids":ids,"sex":sex},
                success:function(data){
                    alert("批量更新成功")
                },
                error:function(){
                    console.log("error")
                }
            })
        }

        // 批量删除
        window.onload=function(){
            var btn_1=document.getElementById("btn_1");
            var close=document.getElementsByClassName("close");
            var form_1=document.getElementsByClassName("form_1");
            btn_1.addEventListener('click',function(){
                form_1[0].className="form_1 open";
            })
            close[0].addEventListener('click',function(){
                form_1[0].className="form_1";
            })
        }

        //图片上传
        var xhr;
        //上传文件方法
        function UpladFile() {
            debugger
            var fileObj = document.getElementById("file").files[0]; // js 获取文件对象
            var url="<%=basePath %>upload/uploadFile";

            var form = new FormData(); // FormData 对象
            form.append("uploadFile", fileObj); // 文件对象

            xhr = new XMLHttpRequest();  // XMLHttpRequest 对象
            xhr.open("post", url, true); //post方式，url为服务器请求地址，true 该参数规定请求是否异步处理。
            xhr.onload = uploadComplete; //请求完成
            xhr.onerror =  uploadFailed; //请求失败

            xhr.upload.onloadstart = function(){//上传开始执行方法
                ot = new Date().getTime();   //设置上传开始时间
                oloaded = 0;//设置上传开始时，以上传的文件大小为0
            };
            xhr.send(form); //开始上传，发送form数据
            location.reload(true);
        }

        //上传成功响应
        function uploadComplete(evt) {
            //服务断接收完文件返回的结果

            var data = JSON.parse(evt.target.responseText);
            if(true) {
                alert("上传成功！");
            }else{
                alert("上传失败！");
            }

        }
        //上传失败
        function uploadFailed(evt) {
            alert("上传失败！");
        }
        //取消上传
        function cancleUploadFile(){
            xhr.abort();
        }



    </script>
</body>
