<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"
	scope="application" />
<title>메인 페이지 - Education System</title>
<jsp:include page="common/header.jsp" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 로그인모달 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 드롭다운(비밀번호 변경) -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.boxA:after {
	content: "";
	display: block;
	clear: both
}

.box1 {
	float: left;
	width: 50%
}

.box2 {
	float: left;
	width: 50%
}

.box3 {
	float: left;
	width: 50%
}

.box4 {
	float: left;
	width: 50%
}
</style>
<script>
	
</script>
<body>


	<div class="boxA">
		<div class="box1">
			<h5>
				<a href="${path}/notice.do">공지사항</a>
			</h5>
			<hr>
			<table>
				<tr>
					<th align="center" style="width: 10%;">번호</th>
					<th align="center" style="width: 40%;">제목</th>
					<th align="center" style="width: 20%;">작성자</th>
					<th align="center" style="width: 20%;">등록일</th>
					<th align="center" style="width: 20%;">긴급	</th>
				</tr>
			</table>
		</div>

		<div class="box2">
			<h5>
				<a href="${path}/eduhistory.do">수강내역</a>
			</h5>
			<hr>
			<table>
				<tr>
					<th align="center" style="width: 10%;">번호</th>
					<th align="center" style="width: 40%;">교육명</th>
					<th align="center" style="width: 20%;">강사명</th>
					<th align="center" style="width: 20%;">교육일</th>
					<th align="center" style="width: 20%;">이수여부</th>
				</tr>
			</table>
		</div>
		<br>

		<div class="boxB">
			<div class="box3">
				<h5>
					<a href="${path}/instructor/main.do">강사</a>
				</h5>
				<hr>
				<table>
					<tr>
						<th align="center" style="width: 10%;">소속</th>
						<th align="center" style="width: 40%;">강의명</th>
						<th align="center" style="width: 20%;">교육명</th>
						<th align="center" style="width: 20%;">교육기간</th>
					</tr>
				</table>
			</div>

			<div class="box4">
				<h5>
					<a href="${path}/EducationList.do">교육목록</a>
				</h5>
				<hr>
				<table>
					<tr>
						<th align="center" style="width: 10%;">번호</th>
						<th align="center" style="width: 40%;">제목</th>
						<th align="center" style="width: 20%;">작성자</th>
						<th align="center" style="width: 20%;">등록일</th>
					</tr>
				</table>
			</div>
		</div>
</body>