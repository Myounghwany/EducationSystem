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
	location.href='${path}/eduhistory/detail.do?edu_no='+val;
}
</script>
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">

</head>
<body>
	<h2>수강목록 해당 교육명 상세페이지</h2>
	<div align="center" id="wrapper">
		<c:if test="${!empty eduhistory_list}" >
			<select id="sel" name="sel"  onchange="action(this.value)" multiple="multiple">
				<c:forEach items="${eduhistory_list}" var="HistoryList" varStatus="state">
					<option value="${HistoryList.edu_no}" style="text-align: center;">
						${HistoryList.edu_name}  ${HistoryList.edu_schedule}
					</option>
				</c:forEach>
			</select>
		</c:if>
		<br>
		<br>
		<!-- 강의 계획서 테이블 -->
		<table width="70%" >
			<tr>
				<th colspan="4" style="font-size: 1.5em;">강의 계획서</th>
			</tr>
			<tr>
				<td width="10%">교육명</td>
				<td width="30%"><b>${eduhistory_detail.edu_name}</b></td>
				<td width="10%">교육대상</td>
				<td width="30%">${edu_target}</td>
			</tr>
			<tr>
				<td>교육분야</td>
				<td>${eduhistory_detail.edu_field}</td>
				<td>교육일정</td>
				<td>${eduhistory_detail.edu_schedule}</td>
			</tr>
			<tr>
				<td>담당자</td>
				<td>${eduhistory_detail.manager}</td>
				<td>교육일시</td>
				<td>${eduhistory_detail.edu_date}</td>
			</tr>
			<tr>
				<td>강사번호</td>
				<td>${eduhistory_detail.instructor_no}</td>
				<td>교육장소</td>
				<td>${eduhistory_detail.edu_location}</td>
			</tr>
			<tr>
				<td>강사이름</td>
				<td>${eduhistory_detail.instructor_name}</td>
				<td>소요예산</td>
				<td><pre>${eduhistory_detail.budget}</pre></td>
			</tr>
			<tr>
				<td>비고</td>
				<td colspan="3"><pre>${eduhistory_detail.note}</pre></td>
			</tr>
		</table>
		<br>
		<!-- 강의자료 테이블 -->
		<table width="70%">
			<tr>
				<th colspan="4" style="font-size: 1.5em;">강의 자료</th>
			</tr>
			<tr>
				<td width="5%">첨부파일</td>
				<td width="30%"><a href="${path}/eduhistory/eduHistoryFile.do?edu_no=${eduhistory_detail.edu_no}">${eduhistory_detail.file_ori_name}</a></td>
			</tr>
			
		</table>
		<button style="margin-top: 2%;"
			onclick="location.href='${path}/eduhistory.do'">목록</button>
	</div>
</body>
</html>