<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<html>
<head>
<title>Notice Modify</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	$(document).ready(function() {

		var tmp = $('[name="selected"]').val();

		console.log('tmp : '+tmp);
		
		$("select option[value=" + tmp + "]").attr("selected", true);

		$('#resultTransfer').css('display', "none");

	});
	
	function checkValtext() {
		var f = window.document.insertForm;
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
<h1>Notice Modify</h1>
<div style="width: 70%; margin: 20px auto">
	<form name=insertForm method="post"
		action="${path}/notice/modify.do" enctype="multipart/form-data"
		onSubmit="return checkValtext()">
		<table class="w3-table w3-bordered">

			<tr>
				<td>Title </td>
				<td> ${result.title} </td>
			</tr>
			<tr>
				<td>Content</td>
				<td>
					<textarea class="form-control" rows="10" name="text" id="text" style="width: 700px; height: 100%;" ></textarea>
				</td>
			</tr>
			<tr>
				<td>Upload</td>
				<td>
					<a href="${path}/notice/fileDownload.do?notice_no=${result.notice_no}">${result.file_ori_name}</a>
				</td>
			</tr>
			<tr>
				<td>File</td>
				<td><input type="file" name="upfile" size="20"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<div align="center">
					<input type="hidden" name="title" value="${result.title}">
					<input type="hidden" value="${result.notice_no}" name="notice_no">
					<input type="reset" class="w3-button w3-white w3-border" value="다시작성"></input>
					<button type="submit" class="w3-button w3-white w3-border">작성 완료</button>
								<input type="button" value="목록보기" class="w3-button w3-white w3-border" 
				onclick="location='${path}/notice/detail.do?notice_no=${result.notice_no}'">
				</div>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>