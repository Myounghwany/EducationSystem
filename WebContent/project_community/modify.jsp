<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project Community Modify</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	
	var tmp = $('[name="selected"]').val();
	
	$("select option[value="+tmp+"]").attr("selected", true);

	
	
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


<form name=insertForm class="form-horizontal" method="post" action="ProjectModify.do" enctype="multipart/form-data" onSubmit="return checkValtext()">
	<select name="selectType">
	   	<option value="">글 분류</option>
		<option value="coding">코딩</option>
		<option value="system">시스템</option>
		<option value="db">데이터베이스</option>
		<option value="design">설계</option>
    </select><br>
	
	<br><span style="font-family: 'Jeju Gothic', serif; font-size: 20px; color: black;">${result.title} </span><br>
	
	<br><br><span style="font-family: 'Jeju Gothic', serif; font-size: 20px; color: black;">게시글</span><br>
	<textarea class="form-control" rows="10" name="text" style="width: 700px; height: 800px;"></textarea>
	
	<br>
	<span>첨부파일</span>
	<a href="ProjectFileDownload.do?project_no=${result.project_no}">${result.file_name}</a>

	<div class="form-group">
		<br><span style="font-family: 'Jeju Gothic', serif; font-size: 10; color: black;">파일수정 : </span> 
		 <input type="file" name="upfile" size="20" style="font-family: 'Jeju Gothic', serif;">
	</div>
	

	<input type="hidden" value="${result.classification}" name="selected">
	<input type="hidden" value="${result.project_no}" name="project_no">
	<br>
	<br>
	<button style="font-family: 'Jeju Gothic', serif;" type="submit">작성 완료</button>
</form>





</body>
</html>