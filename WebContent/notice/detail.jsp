<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<title>Notice Detail</title>
<style>
table {
	width: 80%;
}

a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
	color: #FF5E00;
}

.button {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 3px 12px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s; /* Safari */
	transition-duration: 0.4s;
	cursor: pointer;
}

.button2 {
	background-color: white;
	color: black;
	border: 2px solid #008CBA;
}

.button2:hover {
	background-color: #008CBA;
	color: white;
}

select {
	width: 70%;
	height: 50px;
}

b {
	color: orange;
	font-size: 1.3em;
}

#wrapper {
	margin-top: 5%;
}

option:hover {
	background-color: #FAF4C0;
}

th {
	background-color: #EAEAEA;
}

td, th {
	vertical-align: middle;
}

table tr td pre {
	background-color: white;
	border: none;
}

.selectDefault {
	width: 10%;
	height: 25px;
}

#writeBtn {
	float: right;
}

.title:link {
	text-decoration: none;
	color: black;
}

.title:visited {
	color: black;
	text-decoration: none;
}

table tr td .title:hover {
	text-decoration: none;
	color: #FF5E00;
}

.paging {
	font-size: 1.5em;
}

.page_btn:link {
	color: #FF5E00;
	text-decoration: none;
	margin: 0 5px;
	border: 1px;
}

.page_btn:visited {
	color: brown;
	text-decoration: none;
}

.page_btn:hover {
	text-decoration: none;
	color: aqua;
	background-color: white;
}

.goList {
	margin-top: 3%;
}
</style>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Notice Detail</h1>
<div style="width: 70%; margin: 20px auto">
	
	<c:out value="${sessionScope.name}"/>
	<table class="w3-table w3-bordered">

		<tr>
			<td width="7%">번호</td>
			<td width="7%">${result.notice_no}</td>
			<td width="7%">조회수</td>
			<td width="7%">${result.hit}</td>
		</tr>
		<tr>
			<td width="15%">작성자</td>
			<td width="15%">${result.writer_name}(${result.writer})</td>
			<td width="15%">작성일</td>
			<td width="15%">${result.write_time}</td>
		</tr>
		<tr>
			<td>글제목</td>
			<td colspan="3">${result.title}</td>
		</tr>
		<tr height="100">
			<td colspan="4" height="400"><pre>${result.content}</pre>
			</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="3"><a
				href="${path}/ProjectCommunity/fileDownload.do?project_no=${result.notice_no}">${result.file_ori_name}</a></td>
		</tr>
		<tr>
					<td colspan="4">
					
					<div align="center">
						<input class="w3-button w3-white w3-border" type="button" value="글수정" onclick="location='${path}/ProjectCommunity/modify.do?notice_no=${result.notice_no}'">
						<input class="w3-button w3-white w3-border" type="button" value="글삭제" 
						onclick="if(confirm('정말 삭제 하시겠습니까?')){location='${path}/ProjectCommunity/delete.do?notice_no=${result.notice_no}'}"/>
						<input class="w3-button w3-white w3-border" type="button" value="목록보기" onclick="location='${path}/notice.do'">
					</div>
				</td>
			
		</tr>	
	</table>
	</div>
	

</body>
</html>