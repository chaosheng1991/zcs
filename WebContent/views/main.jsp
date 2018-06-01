<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
            + request.getServerName() + ":" + request.getServerPort()  
            + path + "/";  
       %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>全部动态</title>
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
	$(function() {
		$('#myModal').on('shown.bs.modal', function() {
			$('body').css("overflow", "hidden");
		});
	});

	$(function() {
		$('#myModal').on('hide.bs.modal', function() {
			$('body').css("overflow", "auto");
		});
	});
	$(window).scroll(function() {
		var scrollTop = $(this).scrollTop();
		var scrollHeight = $(document).height();
		var windowHeight = $(this).height();
		if (scrollTop + windowHeight >= scrollHeight) {
			var pageNumber=Number($("#pageNumber").val());
			var totalPage=Number($("#totalPage").val());
			if(pageNumber<totalPage){
				//加载更多
				pageNumber=pageNumber+1;
				$.ajax({
					url : "<%=basePath%>content/more",
					type : "POST",
					async : false,
					data : "pageNow=" + pageNumber,
					success : function(data) {
						$("#pageNumber").remove();
						$("#totalPage").remove();
						$("#msg").before(data);
					}
				});
			}else{
				//没有更多
				$("#msg").html("没有更多数据了!");
			}
		}
	});
	
	function init(){
		var scrollHeight = $(document).height();
		var windowHeight = $(this).height();
		if(scrollHeight==windowHeight){
			$("#msg").html("没有更多数据了!");
		}
	}
	
	function show_modal(id) {
		$.ajax({
			url : "<%=basePath%>content/view",
			type : "POST",
			async : false,
			data : "articleId=" + id,
			success : function(data) {
				if(data.article==''){
					alert("存在错误信息，请重新操作！");
				}else{
					$("#myModalLabel").html(data.article.title);
					$("#modal-content").html(data.article.content);
					$("#openTime").html(data.article.open_time.substring(0,16));
					$("#submitTime").html(data.article.submit_time.substring(0,16));
				}
			}
		});
        $("#myModal").modal("show");
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
<body onload="init()">
	<jsp:include page="alert.jsp"></jsp:include>
	<input type="hidden" id="pageNumber" name="pageNumber"
		value="${pagination.pageNumber}">
	<input type="hidden" id="totalPage" name="totalPage"
		value="${pagination.totalPage}">
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" style="width: 70%; margin-left: 15%">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body" id="modal-content"></div>

				<div class="modal-footer">
					<p style="margin-left: 20px;">
						开放时间：<span id="openTime"></span>&nbsp;&nbsp;&nbsp;&nbsp;提交时间：<span
							id="submitTime"></span>
					</p>
				</div>
			</div>
		</div>
	</div>

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
						<li><a href="<%=basePath%>content/index"
							style="background: #e8e8e8">全部动态</a></li>
						<li><a href="<%=basePath%>content/my">与我有关</a></li>
						<li><a href="<%=basePath%>content/addNew">发布新动态</a></li>
						<li><a href="<%=basePath%>myinfo">个人设置</a></li>
					</ul>
				</div>
			</div>
			<div class="span9">
				<script type="text/javascript"
					src="<%=basePath%>lib/jqplot/jquery.jqplot.min.js"></script>
				<script type="text/javascript" charset="utf-8"
					src="<%=basePath%>javascripts/graphDemo.js"></script>
				<h2 class="page-title">全部动态</h2>

				<div class="row-fluid">
					<c:set value="0" var="index" />
					<c:forEach items="${pagination.list}" var="data" varStatus="i">
						<c:set value="1" var="index"></c:set>
						<div class="block">
							<div class="block-heading">
								${data.alias}
							</div>
							<div class="block-body collapse in">
								<div align="center">
									<h3>${data.title}</h3>
								</div>
								<div
									style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical;"
									title="${data.descript}">${data.descript}</div>
								<br>
								<p class="pull-right">
									<a style="cursor: default; margin-right: 20px;"
										href="javascript:void(0)"
										onclick="show_modal('${data.article_id}')">[内容]</a>
								</p>
								<br>
								<p>
									提交时间:
									<fmt:formatDate value="${data.submit_time}"
										pattern="yyyy-MM-dd HH:mm" />&nbsp;&nbsp;&nbsp;&nbsp;开放时间:
									<fmt:formatDate value="${data.open_time}"
										pattern="yyyy-MM-dd HH:mm" />
									
								</p>
							</div>
						</div>
					</c:forEach>
					<div id="msg" align="center"
						style="font-size: 20px; margin-bottom: 20px; background: #ddd; padding-top: 10px; padding-bottom: 10px;">
						<img alt="" src="<%=basePath%>images/loading.gif">&nbsp;&nbsp;加载更多
					</div>
				</div>

			</div>
		</div>
	</div>
	<script src="<%=basePath%>lib/bootstrap/js/bootstrap.js"></script>
</body>
</html>