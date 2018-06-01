<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
	<input type="hidden" id="pageNumber" name="pageNumber"
		value="${pagination.pageNumber}">
	<input type="hidden" id="totalPage" name="totalPage"
		value="${pagination.totalPage}">
	<c:forEach items="${pagination.list}" var="data" varStatus="i">
		<div class="block">
			<div class="block-heading">
				<%=session.getAttribute("alias")%>
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
						pattern="yyyy-MM-dd HH:mm" />
					&nbsp;&nbsp;&nbsp;&nbsp;是否开放:
					<c:if test="${data.is_out_view==0}">是</c:if>
					<c:if test="${data.is_out_view==1}">否</c:if>
					&nbsp;&nbsp;&nbsp;&nbsp;开放时间:
					<fmt:formatDate value="${data.open_time}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>
			</div>
		</div>
	</c:forEach>
</body>
</html>