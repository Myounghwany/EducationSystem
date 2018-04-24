<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../common/header.jsp" />
<title>edulist_detail Page</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">

</script>
<style type="text/css">
	table {
		color: black;
		width: 80%;
		margin-top : 2%;
		text-align: center;
		border-color: #BDBDBD;
	}
	th {
		background-color: #EAEAEA;
		text-align: center;
		height: 50px;
	}
	td {
		height: 30px;
		background-color: #FDFFFF;
	}
	a:hover {
		color : #FF5E00;
		text-decoration: none;
		font-weight: bold;
	}
</style>
</head>
<body>
	<h2>교육목록 해당 교육명 상세페이지</h2>
	<div align="center" id="wrapper">
		<button>교육신청</button>
		
		<table width="70%" border="1">
			<tr>
				<td width="10%">소속</td>
				<td width="30%"><b>${detail.belong_name}</b></td>
				<td width="10%">교육분야</td>
				<td width="30%">${detail.edu_field}</td>
			</tr>
			<tr>
				<td>교육명</td>
				<td>${detail.edu_name}</td>
				<td>교육대상</td>
				<td>${detail.edu_target}</td>
			</tr>
			<tr>
				<td>교육방법</td>
				<td>${detail.edu_way}</td>
				<td>담당자</td>
				<td>${edu_detail.edu_way}</td>
			</tr>
			<tr>
				<td>교육일정</td>
				<td>${detail.edu_schedule}</td>
				<td>교육일시</td>
				<td>${detail.edu_date}</td>
			</tr>
			<tr>
				<td>교육장소</td>
				<td>${edu_detail.edu_location}</td>
				<td>강사</td>
				<td>${edu_detail.instructor_name}</td>
			</tr>
			<tr>
				<td>소요예산</td>
				<td>${edu_detail.budget}</td>
				<td>신청자 수</td>
				<td>${edu_detail.applicants_limit}</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td></td>
				<td>신청마감일</td>
				<td>${edu_detail.closing_date}</td>
			</tr>
			<tr>
				<td>비고</td>
				<td>${edu_detail.note}</td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
</body>
</html>