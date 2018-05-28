<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Education System</title>

<link rel="StyleSheet" href="/EducationSystem/css/bootstrap.min.css">
<!-- 로그인모달 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$('document').ready(function() {
		console.log('${sessionScope.account}');
		if ( "${sessionScope.account}" == 'inst'){
			$('.disable').click(function() {
				alert('외부강사는 이용하실 수 없습니다.');
				return false;
			});
		}
	});
</script>
<style>
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    padding: 12px 16px;
    z-index: 1;
}

.dropdown:hover .dropdown-content {
    display: block;
}
.headAtag:hover{
	color: green;
	text-decoration: none;
}
.manage:hover{
	color: #FF5E00;
	text-decoration: none;
	font-weight: bold;
}
.manage{ 
	color : black;
	background-color: yellow;
}
</style>
</head>
<body style="width: 70%; margin: 10px auto;">
	<div style="text-align: right;">
		<c:choose>
		  <c:when test="${ sessionScope.no == null }">
				<button type="button" class="w3-button w3-white w3-border" data-toggle="modal" data-target="#login" tabindex="0"
					style="width: 117px; height: 40px;">로그인</button>
		  </c:when>
		  <c:otherwise>
		  <div class="dropdown">
			  	<c:if test="${sessionScope.account eq 'inst'}">
			  		<span style="color:pink;">외부강사</span>
			  	</c:if>
			    <button class="w3-button w3-white w3-border" type="button" data-toggle="dropdown">
			    	${sessionScope.name}님  <span class="caret"></span>
			    </button>
			    <div class="dropdown-content">
			      <p><a class="headAtag" href="/EducationSystem/user/password.do?emp_no=${sessionScope.no}">비밀번호 변경</a></p>
			      <p><a class="headAtag" href="/EducationSystem/user/logout.do">로그아웃</a></p>
			    </div>
		  </div>
		  <c:if test="${sessionScope.account eq 'hr'}">
			<a href="/EducationSystem/manage/empList.do" class="manage">관리자 페이지</a>
		  </c:if>

		  </c:otherwise>
		</c:choose>
	</div>
	<div class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/EducationSystem/main.do">HOME</a>
		</div>
		<div class="navbar-collapse collapse navbar-responsive-collapse">
			<ul class="nav navbar-nav">
				<li><a href="/EducationSystem/notice.do">공지사항</a></li>
				<li><a href="/EducationSystem/EducationList.do" class="disable">교육목록/신청</a></li>
				<li><a href="/EducationSystem/PetitionList.do" class="disable">청원</a></li>
				<li><a href="/EducationSystem/eduhistory.do" class="disable">수강목록</a></li>
				<li><a href="/EducationSystem/instructor/main.do">강사</a></li>
				<li><a href="/EducationSystem/ProjectCommunity.do"  class="disable">프로젝트공유</a></li>
			</ul>
		</div>
	</div>
	<!-- 모달 팝업 -->
	<div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" 
		 aria-hidden="true">
		<div class="modal-dialog"  style="width: 400px; margin-top: 180px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">로그인</h4>
				</div>

				<div class="modal-body">
					<!-- 로그인부트스트랩  -->
					<div class="card card-container" align="center">
						<img src="http://www.bitacademy.com/Images/Content/Employ/img_LOGO_BizTechPartners.png" height="40px"/>
						
						<img id="profile-img" class="profile-img-card"
							src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png" />
						<p id="profile-name" class="profile-name-card"></p>

						<!------- form ------->
						<form id="loginForm" name="loginForm" class="form-signin"
							method="post" action="/EducationSystem/user/login.do">
							
							<input type="text" name="no" id="no" class="form-control" placeholder="ID" required autofocus value=""> 
							
							<input type="password" name="passwd" id="passwd" class="form-control" 
									placeholder="Password" required >
							<br>
							<button class="btn btn-lg btn-primary btn-block btn-signin"
								type="submit">Sign in</button>
						</form>
						<!-- /form -->
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>