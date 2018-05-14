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
<script type="text/javascript">
	
	var textCountLimit = 1000;
	$(document).ready(function(){
		$('textarea[name=text]').keyup(function(){
			//텍스트영역의 길이를 체크
			var textLength = $(this).val().length;
			
			//입력된 텍스트 길이를 #textCount에 업데이트해줌
			$('#textCount').text(textLength);
			
			//제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼 자르고 텍스트영역에 넣음
			if(textLength>textCountLimit){
				$(this).val($(this).val().substr(0, textCountLimit));
			}
		});
	});
</script>
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">
</head>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Project Community 글쓰기</h1>
<div style="width: 70%; margin: 20px auto">
	
	<form name=insertForm class="form-horizontal" method="post" action="ProjectWrite.do" enctype="multipart/form-data" onSubmit="return checkValtext()">
		<table class="w3-table w3-bordered">
			<tr>
				<th colspan="2" style="background-color: #EAEAEA;">작성하기</th>
			</tr>
			<tr>
				<td>글 분류</td>
				<td>
					<select name="selectType" >
					   	<option value="">글 분류</option>
						<option value="coding">코딩</option>
						<option value="system">시스템</option>
						<option value="db">데이터베이스</option>
						<option value="design">설계</option>
				    </select>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title" style="width: 700px; height: 30px;"	value="">
				</td>
			</tr>
			<tr>
				<td>게시글</td>
				<td>	
					<textarea class="form-control" rows="10" name="text" style="width: 700px; height: 50%;"></textarea>
					<span style="float: right;"> 
						(<span id="textCount" class="textCount">0</span>/1000)
					</span>
				</td>
			</tr>	
			<tr>
				<td>파일첨부</td>
				<td>
					<input type="file" name="upfile" size="20">
			 	</td>
			</tr>
			<tr>
				<td colspan="2">
				<div align="right">
					<input type="reset" class="w3-button w3-white w3-border" value="다시작성"></input>
					<button type="submit" class="w3-button w3-white w3-border">작성 완료</button>
				</div>
				</td>
			</tr>
		</table>
		<div align="center" class="goList">
			<input type="button" class="w3-button w3-white w3-border" value="목록보기" onclick="location='ProjectList.do'">
		</div>
	</form>
</div>
</body>
</html>