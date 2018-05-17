<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<jsp:include page="../common/header.jsp" />
<html>
<head>
<title>비밀번호 변경</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 로그인모달 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- table css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style type="text/css">
td { height: 50px; font-weight: bold; padding-right: 30px;}
table { width: 45%; }
</style>
</head>
<body>
<div align="center" style="margin: 10% auto;">
	<h3>비밀번호 변경 페이지</h3>
	<form name="form" method="post"
		action="${path}/user/password.do?emp_no=${sessionScope.no}"
		onsubmit="return valid()">
		<table>
			<tr>
				<td width="25%" style="text-align: right;">
					기존 비밀번호
				</td>
				<td width="35%">
					<input type="password" id="currentPasswd" name="currentPasswd" width="500px"
						   oninput="currentPassword()">
				</td>
				<td width="40%"><span id="chkMsg"></span></td>
			</tr>
			<tr>
				<td style="text-align: right;">
					새로운 비밀번호
				</td>
				<td>
					<input type="password" name="changePasswd" id="changePasswd"
							width="500px">
				</td>
				<td></td>
			</tr>
			<tr>
				<td style="text-align: right;">비밀번호 확인</td>
				<td><input type="password" name="checkPasswd" id="checkPasswd"
						   onkeyup="checkPwd()" width="300px"></td>
				<td style="text-align: left;"><span id="message" class="input-group">동일한 암호를 입력하세요.</span></td>
			</tr>
			<tr>
				<td colspan="3">
				<div align="center">
					<input type="submit" value="확인" class="w3-button w3-white w3-border">
					<input type="reset" value="취소" class="w3-button w3-white w3-border">
				</div>
				</td>
			</tr>
		</table>
	</form>
	<br>
	
	<button class="w3-button w3-white w3-border" onclick="location.href='${path}/main.do'">홈으로 가기</button>
</div>
<script type="text/javascript">
/* 빈칸 있는지 확인 */
function valid() {
	var f = window.document.form;
	var x = document.getElementById("chkMsg").innerHTML;
	alert("기존비밀번호 일치여부 : " + x);
	
	if (f.currentPasswd.value == "") {
		alert("기존 비밀번호를 입력해주세요");
		f.currentPasswd.focus();
		return false;
	}
	if (f.changePasswd.value == "") {
		alert("새로운 비밀번호를 입력해주세요");
		f.changePasswd.focus();
		return false;
	}
	if (f.checkPasswd.value == "") {
		alert("checkPasswd를 입력해주세요");
		f.checkPasswd.focus();
		return false;
	}
	if (f.changePasswd.value != f.checkPasswd.value){
		alert("다시 한 번 비밀번호를 확인해주세요");
		f.checkPasswd.focus();
		return false;
	}
	if ( x == "불일치" ){
		alert("기존 비밀번호를 확인해주세요");
		f.currentPasswd.focus();
		return false;
	}
	return true;
}

/* 기존 비밀번호 일치여부 확인 */
function currentPassword() {
	var currentPasswd = $('#currentPasswd').val();
	
	$.ajax({
		url : '${path}/user/checkPassword.do',
		type : 'post',
		data : {
			passwd : currentPasswd,
		},
		headers : {
			Accept : "application/json"
		},
		dataType:"json",
		success : function(data) {
			if ($.trim(data) == 1) {
				$('#chkMsg').html("일치 확인").css('color', 'blue');
			} else {
				$('#chkMsg').html("불일치").css('color', 'red');
			}
		},
		error : function(request, status, error) {
			alert('code:' + request.status + '\n' + 'error:' + error);
		}
	});
}

/* 비밀번호 재확인 */
function checkPwd() {
	var f = window.document.form;
	var pw1 = f.changePasswd.value;
	var pw2 = f.checkPasswd.value;
	
	if (pw1 != pw2) {
		document.getElementById('message').style.color = "red";
		document.getElementById('message').innerHTML = "동일한 암호를 입력하세요.";
	} else {
		document.getElementById('message').style.color = "blue";
		document.getElementById('message').innerHTML = "암호가 확인 되었습니다.";
	}
}
</script>
</body>
</html>