<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<link href="${path}/petition/petition.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원 작성 </title> 
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	
	$('textarea[name=content]').keyup(function(){ 
		
		var contentength = $(this).val().length; 
		
		if(contentength>1000){
			$(this).val($(this).val().substr(0, 1000));
			alert('1000자까지 작성 가능합니다.');
		}
	});
	$('input[name=title]').keyup(function(){ 
		
		var titletength = $(this).val().length; 
		
		if(titletength>20){
			$(this).val($(this).val().substr(0, 20));
			alert('20자까지 작성 가능합니다.');
		}
	});
});

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
		alert("내용을 입력해주세요.");
		w.content.focus();
		return false;
	} 
		return true; 
}
</script>
 
</head>
<jsp:include page="pheader.jsp" />

<body>

	<div class="petition_text" align="center" >
		청원 기간은 30일입니다. <br>
		한번 작성된 청원은 수정및 삭제가 불가능하며  <br>
		관련되지 않은 글은 삭제될 수 있습니다. <br> 
	</div>
 
<form name="writeForm"  action="PetitionWrite.do" method="post" enctype="multipart/form-data" onsubmit="return writecheck()"> 
	<table style="width: 70%" >
		<tr>
		  <td> 청원제목 </td>
		  <td><input class="input" type="text" name="title"></td>
		</tr>
		<tr>
		  <td> 분류 </td>
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
		  <td> 청원개요 </td>
		  <td><textarea class="input" name="content" rows="15" wrap="hard"></textarea></td>
		</tr>
		<tr>
		  <td> 파일첨부: </td>
		  <td> <input type="file" name="newfile"> </td>
		</tr> 
		<tr>
		  <td colspan="2">
		    <input class="inputbutton" type="submit" value="작성">
			<input class="inputbutton" type="button" value="목록" onclick="location='PetitionList.do'">
		  </td>
		</tr>			
	</table>
 
 </form> 
</body>
</html>