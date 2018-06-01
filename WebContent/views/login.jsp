<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>欢迎来到致未来</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>lib/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>lib/bootstrap/css/bootstrap-responsive.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>stylesheets/theme.css">
<link rel="stylesheet"
	href="<%=basePath%>lib/font-awesome/css/font-awesome.css">

<script src="<%=basePath%>lib/jquery-1.8.1.min.js"
	type="text/javascript"></script>
	<script type="text/javascript">
	function refresh() {
		var myData = new Date(); 
		$("#checkCode").attr("src","<%=basePath%>img?time="+myData.getTime());
	}
	
	function legalCheck() {
		var username = $("#username").val();
		var password = $("#password").val();
		var inputRandomCode = $("#inputRandomCode").val();
		if (username == '') {
			alert("请填写用户名");
			return false;
		} else if (password == '') {
			alert("请填写密码");
			return false;
		} else if (inputRandomCode == '') {
			alert("请填写验证码");
			return false;
		} else{
			return true;
		}
	}
	</script>
<style type="text/css">
.brand {
	font-family: georgia, serif;
}

.brand .first {
	color: #ccc;
	font-style: italic;
}

.brand .second {
	color: #fff;
	font-weight: bold;
}
</style>
</head>
<body>
	<jsp:include page="alert.jsp"></jsp:include>
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<ul class="nav pull-right">

				</ul>
				<a class="brand" href="index.html"><span class="first">致</span>
					<span class="second">未来</span></a>
			</div>
		</div>
	</div>


	<div class="container-fluid">

		<div class="row-fluid">
			<div class="dialog span4">
				<div class="block">
					<form class="form-inline" action="<%=basePath%>index/login" method="post"
					onsubmit="return legalCheck()">
					<div class="block-heading">登&nbsp;&nbsp;录</div>
						<div class="block-body">
							<span></span>
							<div class="span12" style="margin-top: 9px;">
								<label class="form-label" style="width: 55px;height: 30px; line-height: 30px; font-size: 16px;">用户名</label> <input
									type="text" id="username" name="username" class="span8 form-control" value="${username}">
							</div>
							<div class="span12" style="margin-top: 9px;">
								<label class="form-label" style="width: 55px;height: 30px; line-height: 30px; font-size: 16px;">密&nbsp;&nbsp;码</label> <input
									type="password" id="password" name="password" class="span8 form-control" value="${password}">
							</div>
							<div class="span12" style="margin-top: 9px;">
								<label class="form-label" style="width: 55px;height: 30px; line-height: 30px; font-size: 16px;">验证码</label> <input
									name="inputRandomCode" id="inputRandomCode" class="span4 form-control" /> <img
									src="<%=basePath%>img" alt="" id="checkCode" onclick="refresh()" title="看不清？点击换一张"/>
							</div>
							<div class="span12" style="margin-top: 9px;">
								<button type="submit" class="btn btn-primary">登录</button>&nbsp;&nbsp;<button type="reset" class="btn">重置</button>
							</div>
							<div class="clearfix"></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=basePath%>lib/bootstrap/js/bootstrap.js"></script>
</body>
</html>