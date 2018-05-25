<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<link href="${path}/petition/petition.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원 답변 </title> 
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	
	$('textarea[name=comment]').keyup(function(){ 
		
		var commentlength = $(this).val().length; 
		
		if(commentlength>1000){
			$(this).val($(this).val().substr(0, 1000));
			alert('답변은 1000자까지 작성 가능합니다.');
		}
	});

});

function writecheck() {
	
	var w = window.document.writeForm;
	
	if (w.comment.value == "") {
		alert("답변을 작성해주세요.");
		w.comment.focus();
		return false;
	} 
		return true; 
}
</script>
 
</head>
<jsp:include page="pheader.jsp" />

<body>

	<h1> 청원 답변 </h1>
 
<form name="writeForm"  action="ReplyWritePro.do" method="post" enctype="multipart/form-data" onsubmit="return writecheck()"> 
<input type="hidden" value="${result.petition_no}" id="petition_no" name="petition_no">
	<table style="width: 70%" >
		<tr>
		  <td> 청원제목 </td>
		  <td> ${result.title} : <span>답변</span></td>
		</tr>
		<tr>
		  <td> 청원인 </td>
		  <td> ${result.writer} </td>
		</tr>
		<tr> 
		  <td> 분류 </td>
		  <td>${result.classification}</td>
		</tr>
		<tr>
		  <td> 참여인원 </td>
		  <td>${result.agree}</td>
		</tr>
		<tr>
		  <td> 청원기간 </td> 
		  <td> ${result.write_time} ~ ${result.closing_date} </td>
		</tr>			
		<tr>
		<td> 청원개요 </td>
		<td style="padding: 20px 0;">${content}</td>
		</tr>
		<tr>
		<td><input type="radio" name="category" value="Y">채택</td>
		<td><input type="radio" name="category" value="N">거절</td>
		</tr>
		<tr>
		  <td colspan="2"><textarea class="input" name="comment" rows="15" placeholder=" ※ 작성된 답변은 수정 및 삭제가 불가능 합니다 ※"></textarea></td>
		</tr>
		<tr>
		  <td> 파일첨부: </td>
		  <td> <a href="PetitionFileDownload.do?petition_no=${result.petition_no}">${result.file_ori_name}</a></td>
		</tr> 
		<tr>
		  <td colspan="2">
		    <input class="inputbutton" type="submit" value="작성">
			<input class="inputbutton" type="button" value="목록" onclick="location='ManageList.do'">
		  </td>
		</tr>			
	</table>
 
 </form> 
</body>
</html>