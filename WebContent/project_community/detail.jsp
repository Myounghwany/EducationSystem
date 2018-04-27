<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- table css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Project Community Detail</title>
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

<h1>Project Community Detail</h1>

	<div style="width: 80%; margin: 20px auto">
		<span style="color: #FF5E00;"> <b>분류 : 	${result.classification}</b>
		</span> <br>
		<table class="w3-table w3-bordered">
			<tr>
				<th width="7%">번호</th>
				<td width="7%">${result.project_no}</td>
				<th width="7%">조회수</th>
				<td width="7%">${result.hit}</td>
			</tr>
			<tr>
				<th width="15%">작성자</th>
				<td width="15%">${result.writer}</td>
				<th width="15%">작성일</th>
				<td width="15%">${result.write_time}</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td colspan="3">${result.title}</td>
			</tr>
			<tr height="100">
				<th>내용</th>
				<td colspan="3">${result.content}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3"><a
					href="ProjectFileDownload.do?project_no=${result.project_no}">${result.file_ori_name}</a></td>
			</tr>
			<tr>
				<th colspan="4">
					<input class="inputbutton" type="button" value="글수정"
							onclick="location='ProjectModify.do?project_no=${result.project_no}'">
					<input class="inputbutton" type="button" value="글삭제"
							onclick="location='ProjectDelete.do?project_no=${result.project_no}'">
					<input class="inputbutton" type="button" value="목록보기"
							onclick="location='ProjectList.do'">
				</th>
			</tr>

		</table>
	</div>
</body>
</html>