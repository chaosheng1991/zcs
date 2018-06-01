<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>发布新动态</title>
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

</script>
<style type="text/css">
#line-chart {
	height: 300px;
	width: 800px;
	margin: 0px auto;
	margin-top: 1em;
}

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
					<li><a href="<%=basePath%>myinfo" style="float: left"> <i
							class="icon-user"></i><%=session.getAttribute("name")%>
					</a></li>
					<li><a href="<%=basePath%>logout" style="float: left"
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
						<li><a href="<%=basePath%>content/addNew"
							style="background: #e8e8e8">发布新动态</a></li>
						<li><a href="<%=basePath%>myinfo">个人设置</a></li>
					</ul>
				</div>
			</div>
			<div class="span9">
				<script type="text/javascript"
					src="<%=basePath%>lib/jqplot/jquery.jqplot.min.js"></script>
				<script type="text/javascript" charset="utf-8"
					src="<%=basePath%>javascripts/graphDemo.js"></script>
				<form action="<%=basePath%>content/add" method="post"
					onsubmit="return legalCheck()" enctype="multipart/form-data">
					<h2 class="page-title">发布新动态</h2>
					
					<div class="span12"  style="margin-top: 12px;">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">图片上传</label>
						<input type="file" style="float: left;" id="picture" name="picture" multiple="multiple">
					</div>
					
					<div class="span12" style="margin-bottom: 10px;">
						<button type="submit" class="btn btn-primary">保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="<%=basePath%>lib/bootstrap/js/bootstrap.js"></script>

</body>
</html>