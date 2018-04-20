<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project Community 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){

	
	$('#resultTransfer').css('display',"none");
	
	$('#writeBtn').click(function(){
		location="ProjectWrite.do";
	});	
		
	});
	
function checkValtext() {
	var f = window.document.insertForm;
	
	 if(f.selectType.value == ""){
		alert("항목을 입력하세요");
		f.selectType.focus();
		return false;
	}

	if (f.title.value == "") {
		alert("제목을 입력해주세요");
		f.title.focus();
		return false;
	}
	if (f.text.value == "") {
		alert("게시글을 입력해주세요");
		f.text.focus();
		return false;
	}
	
		return true;
	
		
}
</script>
</head>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Project Community 글쓰기</h1>


<form name=insertForm class="form-horizontal" method="post" action="writeForm.do" enctype="multipart/form-data" onSubmit="return checkValtext()">
	<select name="selectType" >
	   	<option value="">글 분류</option>
		<option value="erp">ERP</option>
		<option value="web">WEB</option>
		<option value="bpo">BPO</option>
    </select><br>
	
	<br><span style="font-family: 'Jeju Gothic', serif; font-size: 20px; color: black;">제목</span><br>
	<input type="text" name="title" style="width: 700px; height: 30px;"	value="">
	
	<br><br><span style="font-family: 'Jeju Gothic', serif; font-size: 20px; color: black;">게시글</span><br>
	<textarea class="form-control" rows="10" name="text" style="width: 700px; height: 800px;"></textarea>
	
	<br>
	<div class="form-group">
		<br><span style="font-family: 'Jeju Gothic', serif; font-size: 4; color: black;">파일첨부 : </span> 
		 <input type="file" name="upfile" size="20" style="font-family: 'Jeju Gothic', serif;">
	</div>

	<input type="hidden" name="replyboard_no" style="width: 700px; height: 30px;"value="0">
	<br>
	<br>
	<button style="font-family: 'Jeju Gothic', serif;" type="submit">작성 완료</button>
</form>


</body>
</html>