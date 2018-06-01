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
<link rel="stylesheet"
	href="<%=basePath%>kindeditor/themes/default/default.css" />
<script charset="utf-8" src="<%=basePath%>kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	//KindEditor脚本
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('#content', {});
	});

	function legalCheck() {
		var title = $("#title").val();
		var openTime = $("#open_time").val();
		var descript = $("#descript").val();
		var outView = $("#is_out_view").val();
		if (title == '') {
			alert("请填写标题");
			return false;
		} else if (descript == '') {
			alert("请填写摘要");
			return false;
		}else if (outView == -1) {
			alert("请选择是否开放");
			return false;
		} else if (outView==0&&openTime == '') {
			alert("请设置开放时间");
			return false;
		}  else {
			return true;
		}
	}
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
					<div class="span12">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">标&nbsp;&nbsp;&nbsp;&nbsp;题</label>
						<input type="text" class="span8" id="title" name="title"
							value="${article.title}" style="height: 30px;">
					</div>
					<div class="span12">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">摘&nbsp;&nbsp;&nbsp;&nbsp;要</label>
						<div style="float: left; margin-left: 0px;" class="span8">
							<textarea id="descript" name="descript"
								style="width: 100%; padding: 4px 0px;" rows="5">${article.descript}</textarea>
						</div>
					</div>

					<div class="span12">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">内&nbsp;&nbsp;&nbsp;&nbsp;容</label>
						<div style="float: left; margin-left: 0px" class="span8">
							<textarea id="content" name="content" style="width: 100%;"
								rows="14">${article.content}</textarea>
						</div>
					</div>
					<br>
					<div class="span12"  style="margin-top: 12px;">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">图片上传</label>
						<input type="file" style="float: left;" id="picture" name="picture" multiple="multiple">
					</div>
					<br>
					<div class="span12"  style="margin-top: 12px;">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">是否开放</label>
						<select name="is_out_view" id="is_out_view" style="float: left;">
							<option value="-1"
								${-1==article.is_out_view?"selected='selected'":"" }>请选择</option>
							<option value="0"
								${0==article.is_out_view?"selected='selected'":"" }>是</option>
							<option value="1"
								${1==article.is_out_view?"selected='selected'":"" }>否</option>
						</select>
					</div>
					<br>
					<div class="span12">
						<label
							style="float: left; width: 85px; height: 30px; line-height: 30px; font-size: 18px; font-weight: bold;">开放时间</label>
						<input type="text" style="float: left;" id="open_time"
							name="open_time" value="${article.open_time}"
							onfocus="WdatePicker({skin:'whyGreen',readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',
minDate:'%y-%M-%d %H:%m:%s'})">
					</div>
					<br>
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