<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- table css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Project Community Modify</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {

		var tmp = $('[name="selected"]').val();

		$("select option[value=" + tmp + "]").attr("selected", true);

		$('#resultTransfer').css('display', "none");

		$('#writeBtn').click(function() {
			location = "ProjectWrite.do";
		});

	});

	function checkValtext() {
		var f = window.document.insertForm;

		if (f.selectType.value == "") {
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
<style type="text/css">
button {
	float: right;
}
</style>
</head>
<jsp:include page="../common/header.jsp" />
<body>
<div style="width: 70%; margin: 20px auto">

	<form name=insertForm method="post"
		action="ProjectModify.do" enctype="multipart/form-data"
		onSubmit="return checkValtext()">
		<table class="w3-table w3-bordered">
			<tr>
				<th colspan="2" style="background-color: #EAEAEA;">수정하기</th>
			</tr>
			<tr>
				<td>글 분류</td>
				<td>
					<select name="selectType">
						<option value="">글 분류</option>
						<option value="coding">코딩</option>
						<option value="system">시스템</option>
						<option value="db">데이터베이스</option>
						<option value="design">설계</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>제목 </td>
				<td> ${result.title} </td>
			</tr>
			<tr>
				<td>게시글</td>
				<td>
					<textarea class="form-control" rows="10" name="text" id="text"
							  style="width: 100%; height: 50%;">
					</textarea>
				</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<a href="ProjectFileDownload.do?project_no=${result.project_no}">${result.file_ori_name}</a>
				</td>
			</tr>
			<tr>
				<td>파일수정</td>
				<td><input type="file" name="upfile" size="20"></td>
			</tr>
		<tr>
			<td>
		<input type="hidden" value="${result.classification}" name="selected">
		<input type="hidden" value="${result.project_no}" name="project_no">
		<button type="submit" class="w3-button w3-white w3-border">작성 완료</button>
		</td>
		</tr>
		</table>
	</form>
</div>
</body>
</html>