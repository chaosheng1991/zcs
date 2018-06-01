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
<title>个人信息</title>
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
	function legalCheck() {
		var name = $("#name").val();
		var alias = $("#alias").val();
		if (name == '') {
			alert("请填写姓名");
			return false;
		} else if (alias == '') {
			alert("请填写昵称");
			return false;
		} else {
			return true;
		}
	}

	function legalCheckPwd() {
		var oldPassword = $("#oldPassword").val();
		var newPassword = $("#newPassword").val();
		var newAgainPassword = $("#newAgainPassword").val();
		if (oldPassword == '') {
			alert("请填写原密码");
			return false;
		} else if (newPassword == '') {
			alert("请填写新密码");
			return false;
		} else if (newAgainPassword == '') {
			alert("请填写确认密码");
			return false;
		} else if (newAgainPassword !=newPassword) {
			alert("新密码和确认密码不一致");
			return false;
		}else {
			return true;
		}
	}
	
	function menuChoose(){
		var flag = $("#flag").val();
		if(flag==''||flag=="info"){
			$("#myinfoMenu").click();
		}else{
			$("#passwordMenu").click();
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
<body onload="menuChoose()">
	<jsp:include page="alert.jsp"></jsp:include>
	<input type="hidden" name="flag" id="flag" value="${flag}">
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<ul class="nav pull-right">
					<li><a href="<%=basePath%>myinfo" style="float:left">
							<i class="icon-user"></i><%=session.getAttribute("name")%>
					</a></li>
					<li><a href="<%=basePath%>logout" style="float:left"
								onclick="return confirm('确定要安全退出吗？')">退出</a></li>

				</ul>
				<a class="brand" href="<%=basePath%>content"><span class="first">致</span>
					<span class="second">未来</span></a>
			</div>
		</div>
	</div>


	<div class="container-fluid">

		<div class="row-fluid">
			<div class="span3">
				<div class="sidebar-nav">
					<div class="nav-header" data-toggle="collapse"
						data-target="#dashboard-menu">
						<i class="icon-dashboard"></i>导航栏
					</div>
					<ul id="dashboard-menu" class="nav nav-list collapse in">
						<li><a href="<%=basePath%>content/index">全部动态</a></li>
						<li><a href="<%=basePath%>content/my">与我有关</a></li>
						<li><a href="<%=basePath%>content/addNew">发布新动态</a></li>
						<li><a href="<%=basePath%>myinfo" style="background: #e8e8e8">个人设置</a></li>
					</ul>
				</div>
			</div>
			<div class="span9">
				<h2 class="page-title">个人设置</h2>
				<div class="well">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#home" data-toggle="tab" id="myinfoMenu">个人信息</a></li>
						<li><a href="#profile" data-toggle="tab" id="passwordMenu">修改密码</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane active in" id="home">
							<form id="tab" action="<%=basePath%>index/editInfo" method="post"
								onsubmit="return legalCheck()">
								<label>用户名</label> <input type="text" value="${user.username }"
									id="username" name="username" class="input-xlarge"
									readonly="readonly"> <label>姓名</label> <input
									type="text" value="${user.name }" id="name" name="name"
									class="input-xlarge"> <label>昵称</label> <input
									type="text" value="${user.alias }" id="alias" name="alias"
									class="input-xlarge"> <label>性别</label> <select
									name="sex" id="sex" class="input-xlarge">
									<option value="0" ${0==user.sex?"selected='selected'":"" }>男</option>
									<option value="1" ${1==user.sex?"selected='selected'":"" }>女</option>
								</select> <label>备注</label>
								<textarea id="note" name="note" rows="3" class="input-xlarge">${user.note }</textarea>
								<div>
									<button class="btn btn-primary">确定修改</button>
								</div>
							</form>
						</div>
						<div class="tab-pane fade" id="profile">
							<form id="tab2" action="<%=basePath%>index/editPassword"
								method="post" onsubmit="return legalCheckPwd()">
								<label>原密码</label> <input type="password" id="oldPassword"
									name="oldPassword" class="input-xlarge"> <label>新密码</label>
								<input type="password" id="newPassword" name="newPassword"
									class="input-xlarge"> <label>确认密码</label> <input
									type="password" id="newAgainPassword" name="newAgainPassword"
									class="input-xlarge">
								<div>
									<button class="btn btn-primary">提交</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=basePath%>lib/bootstrap/js/bootstrap.js"></script>
</body>
</html>