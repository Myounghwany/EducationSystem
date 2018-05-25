<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원 </title>

<link rel="StyleSheet" href="${path}/css/bootstrap.min.css">

</head>
<jsp:include page="../common/header.jsp" />
<body> 
		<div style="margin-bottom: 15%"> 
			<ul class="nav navbar-nav">
				<li><a href="${path}/PetitionList.do">청원</a></li>
				<li><a href="${path}/AllList.do">모든 청원</a></li> 
			    <li><a href="${path}/OngoingList.do">진행중</a></li> 
				<li><a href="${path}/EvaluateList.do">심사중</a></li> 
				<li><a href="${path}/AnswerList.do">심사완료</a></li>
				<li><a href="${path}/ExpireList.do">기간만료</a></li>
				<li><a href="${path}/ManageList.do">청원관리</a></li>
			</ul>
		</div> 
</body>
</html>