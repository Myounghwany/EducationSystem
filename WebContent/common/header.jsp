<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EducationSystem</title>

<link rel="StyleSheet" href="${path}/css/bootstrap.min.css">

</head>
<body style="width: 70%; margin: 0 auto;">
	<div style="text-align: right">
		<c:if test="${loginUser == null}">
			<a href="#">로그인</a>
		</c:if>
		<c:if test="${loginUser != null}">
			<a href="#">로그아웃</a>
		</c:if>
	</div>
	<div class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${path}">HOME</a>
		</div>
		<div class="navbar-collapse collapse navbar-responsive-collapse">
			<ul class="nav navbar-nav">
				<li><a href="${path}/#">공지사항</a></li>
				<li><a href="${path}/#">교육목록/신청</a></li>
				<li><a href="${path}/#">청원</a></li>
				<li><a href="${path}/#">수강목록</a></li>
				<li><a href="${path}/instructor/main.do">강사</a></li>
				<li><a href="${path}/#">프로젝트공유</a></li>
			</ul>
		</div>
	</div>