<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원 작성 </title>
<style> 
.petition_text {
	border: 3px solid #D9E5FF; 
	background-color: #EBF7FF;
	margin: 30 auto;
	padding: 20px;
	width: 70%;
}
table {	
	border: 3px solid #D9E5FF; 
	margin: auto;
}   
.input {
	background-color: #FFFFFF;
	border: 1px solid #D9E5FF;
	width: 90%;
}
.inputbutton {
	background-color: #FFFFFF; 
	border: 3px solid #D9E5FF;
	font-size:12px;
	font-weight: bold; 
	width: 80px;  
	height: 25px;   
 	text-align: center;  
}

th {
	background-color: #EBF7FF; 
	font-size : 11px;
	border : 1px solid #E5FFFF;	 
	padding : 3px;
	height: 35px; 
}
td {
	background-color: #EBF7FF;  
	font-size : 11px;
	border : 1px solid #E5FFFF;	 
	padding : 3px;
	height: 35px; 
}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function writecheck() {
	var w = window.document.writeForm;
	
	 if(w.classification.value == ""){
		alert("분류를 선택해주세요.");
		w.classification.focus();
		return false;
	} 
	if (w.title.value == "") {
		alert("제목을 입력해주세요.");
		w.title.focus();
		return false;
	}
	if (w.content.value == "") {
		alert("게시글을 입력해주세요.");
		w.content.focus();
		return false;
	} 
		return true; 
}
</script>
</head>
<jsp:include page="../common/header.jsp" />

<body>

	<div class="petition_text" align="center" >
		청원 기간은 30일입니다. <br>
		한번 작성된 청원은 수정및 삭제가 불가능하며  <br>
		관련되지 않은 글은 삭제될 수 있습니다. <br> 
	</div>
	
<form name="writeForm" action="PetitionWrite.do" method="post" enctype="multipart/form-data" onsubmit="return writecheck()"> 
	<table style="width: 70%">
		<tr>
		  <th> 청원제목 </th>
		  <td><input class="input" type="text" name="title" maxlength="20"></td>
		</tr>
		<tr>
		  <th> 분류 </th>
		  <td>
		  	<select class="input" name="classification">
		  		<option value=""> 분류 </option>
		  		<option value="coding">코딩</option>
		  		<option value="system">시스템</option>
		  		<option value="database">데이터베이스</option>
		  		<option value="design">설계</option>
		  		<option value="other">기타</option>
		  	</select>
		  </td>
		</tr>
		<tr>
		  <th> 청원개요 </th>
		  <td><textarea class="input" name="content" rows="20"></textarea></td>
		</tr>
		<tr>
		  <td> 파일첨부: </td>
		  <td> <input type="file" name="newfile"> </td>
		</tr> 
		<tr>
		  <th colspan="2">
		    <input class="inputbutton" type="submit" value="작성">
			<input class="inputbutton" type="button" value="목록" onclick="location='PetitionList.do'">
		  </th>
		</tr>			
	</table>
 
 </form>
</body>
</html>