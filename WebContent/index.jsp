<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<title>메인 페이지 - Education System</title>
<jsp:include page="common/header.jsp" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 로그인모달 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	window.onload = function() {
		var result = '${result}';
		console.log(result);
		if(result == "fail") {
			alert("아이디나 비밀번호가 일치하지 않습니다.");
		}
	}
</script>
<body>

index 페이지 입니다.
</body>