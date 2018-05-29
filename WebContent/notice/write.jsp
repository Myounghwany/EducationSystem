<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>

<title>Notice Write</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function checkValtext() {
	var f = window.document.insertForm;
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
<h1>Notice Write</h1>
<div style="width: 70%; margin: 20px auto">
	
	<form name=insertForm class="form-horizontal" method="post" action="${path}/notice/write.do" enctype="multipart/form-data" onSubmit="return checkValtext()">
		<table class="w3-table w3-bordered">

			<tr>
				<td>Title</td>
				<td>
					<input type="text" name="title" style="width: 700px; height: 30px;"	value="">
				</td>
			</tr>
			<tr>
				<td>Content</td>
				<td>	
					<textarea class="form-control" rows="10" name="text" style="width: 700px; height: 100%;"></textarea>

				</td>
			</tr>	
			<tr>
				<td>Upload</td>
				<td>
					<input type="file" name="upfile" size="20">
			 	</td>
			</tr>
			<tr>
				<td colspan="2">
				<div align="center">
					<input type="reset" class="w3-button w3-white w3-border" value="다시작성"></input>
					<button type="submit" class="w3-button w3-white w3-border">작성 완료</button>
					<input type="button" class="w3-button w3-white w3-border" value="목록보기" onclick="location='${path}/notice.do'">
				</div>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>