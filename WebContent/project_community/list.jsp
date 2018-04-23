<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project Community List</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){

	
	$('#resultTransfer').css('display',"none");
	
	$('#writeBtn').click(function(){
		location="ProjectWrite.do";
	});	
		
	});
</script>
</head>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Project Community List</h1>

<table border="1" align="center">
	<tr>
		<td width="7%">글번호</td>
		<td width="7%">분류</td>
		<td width="30%">제목</td>
		<td width="15%">작성자</td>
		<td width="10%">작성시간</td>
		<td width="10%">조회수</td>
	</tr>
	<c:choose>
		<c:when test="${empty requestScope.list}">
		<tr>
			<td colspan="7" align="center">등록된 글이 없습니다.</td>
		</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${requestScope.list}" var="list" varStatus="state">
				<tr>
					<td>${list.project_no}</td>
					<td>${list.classification}</td>
					<td><a href="ProjectDetail.do?project_no=${list.project_no}">${list.title}</a></td>
					<td>${list.writer}</td>
					<td>${list.write_time}</td>
					<td>${list.hit}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<br>
<button id="writeBtn">작성하기</button>


</body>
</html>