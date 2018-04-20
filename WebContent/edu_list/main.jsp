<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<title>수강목록 페이지</title>
<jsp:include page="../common/header.jsp" />
<style>
table {
	color:black;
	width: 70%;
}
th{
	background-color: #EAEAEA;
	text-align: center;
	height: 50px;
}
</style>

<body>
<h3>수강목록 페이지</h3>
<table>
	<tr>
		<th>교육명</th>
		<th>강사명</th>
		<th>교육일</th>
		<th>이수여부</th>
		<th>강의평가</th>
	</tr>
	<tr>
	</tr>
</table>
</body>