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
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">

</head>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Project Community Detail</h1>
<div style="width: 70%; margin: 20px auto">

	<span style="color: #FF5E00;"> <b>분류 : 	${result.classification}</b>
	</span> <br>
	<table class="w3-table w3-bordered">
		<tr>
			<th colspan="4" style="background-color: #EAEAEA;"> Project Coummunity 상세보기 </th>
		</tr>
		<tr>
			<td width="7%">번호</td>
			<td width="7%">${result.project_no}</td>
			<td width="7%">조회수</td>
			<td width="7%">${result.hit}</td>
		</tr>
		<tr>
			<td width="15%">작성자</td>
			<td width="15%">${result.writer}</td>
			<td width="15%">작성일</td>
			<td width="15%">${result.write_time}</td>
		</tr>
		<tr>
			<td>글제목</td>
			<td colspan="3">${result.title}</td>
		</tr>
		<tr height="100">
			<td>내용</td>
			<td colspan="3"><pre>${result.content}</pre></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="3"><a
				href="ProjectFileDownload.do?project_no=${result.project_no}">${result.file_ori_name}</a></td>
		</tr>
		<tr>
			<td colspan="4">
			<div align="right">
				<input class="w3-button w3-white w3-border" type="button" value="글수정"
						onclick="location='ProjectModify.do?project_no=${result.project_no}'">
				<input class="w3-button w3-white w3-border" type="button" value="글삭제"
						onclick="location='ProjectDelete.do?project_no=${result.project_no}'">
			</div>
			</td>
		</tr>
	</table>
	<div align="center" class="goList">
		<input class="w3-button w3-white w3-border" type="button" value="목록보기"
				onclick="location='ProjectList.do'">
	</div>
</div>
</body>
</html>