<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../common/header.jsp" />
<title>edulist_detail Page</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

<script type="text/javascript">
function action(val){
	location.href='${path}/edulist/detail.do?edu_no='+val;
}
</script>
<style type="text/css">
	select {
		width: 70%;
		height: 50px;
	}
	b{
		color: orange;
	}
	#wrapper{
		margin-top: 5%;
	}
	option:hover {
		background-color: #FAF4C0;
	}
</style>
</head>
<body>
	<h2>수강목록 해당 교육명 상세페이지</h2>
	<div align="center" id="wrapper">
		<c:if test="${!empty edu_list}" >
			<select id="sel" name="sel" multiple="multiple" onchange="action(this.value)">
				<c:forEach items="${edu_list}" var="edulist" varStatus="state">
					<option value="${edulist.edu_no}">${edulist.edu_name}  ${edulist.edu_schedule}</option>
				</c:forEach>
			</select>
		</c:if>
		<br>
		<br>
		<!-- 강의 계획서 테이블 -->
		<table width="70%">
			<tr>
				<th colspan="4" style="font-size: 1.5em;">강의 계획서</th>
			</tr>
			<tr>
				<td width="10%">교육명</td>
				<td width="30%"><b>${edu_detail.edu_name}</b></td>
				<td width="10%">교육대상</td>
				<td width="30%">${edu_detail.edu_target}</td>
			</tr>
			<tr>
				<td>교육분야</td>
				<td>${edu_detail.edu_field}</td>
				<td>교육일정</td>
				<td>${edu_detail.edu_schedule}</td>
			</tr>
			<tr>
				<td>담당자</td>
				<td>${edu_detail.manager}</td>
				<td>교육일시</td>
				<td>${edu_detail.edu_date}</td>
			</tr>
			<tr>
				<td>강사</td>
				<td>${edu_detail.instructor_no}</td>
				<td>교육장소</td>
				<td>${edu_detail.edu_location}</td>
			</tr>
			<tr>
				<td>소요예산</td>
				<td><pre>${edu_detail.budget}</pre></td>
			</tr>
			<tr>
				<td>비고</td>
				<td colspan="3"><pre>${edu_detail.note}</pre></td>
			</tr>
		</table>
		<!-- 강의자료 테이블 -->
		<table width="70%">
			<tr>
				<th colspan="4" style="font-size: 1.5em;">강의 자료</th>
			</tr>
			<tr>
				<td width="10%">자료명</td>
				<td width="30%"><b></b></td>
				<td width="10%">다운링크</td>
				<td width="30%">ㅁㅁㅁ</td>
			</tr>
			
		</table>
		<button style="margin-top: 2%;"
			onclick="location.href='${path}/edulist.do'">목록</button>
	</div>
</body>
</html>