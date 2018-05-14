<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	
})

</script>
<title>comment</title>
</head>
<jsp:include page="../common/header.jsp" />
<body>

		<table class="w3-table w3-bordered">
				<tr>
					<th width="7%">작성자 :</th><td></td>
					<th width="30%"></th>
					<th width="7%">작성시간</th>
				</tr>
				<c:choose>
					<c:when test="${empty requestScope.list}">
						<tr>
							<td colspan="7">등록된 댓글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${requestScope.list}" var="list" varStatus="state">
							<tr>
								<th width="7%">작성자 :</th><td>${list.project_no}</td>
								<th width="50%">내용</th><td>${list.classification}</td>
								<th width="7%">작성시간</th><td>${list.write_time}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>

</body>
</html>