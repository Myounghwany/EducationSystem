<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<title>관리자 페이지 - Education System</title>
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$('document').ready(function() {		
		$('#title tr th').click(function() {
			var title_value = $(this).attr('title_value');
			switch(title_value) {
			case 'emp':
				location.href='empList.do';
				break;
			case 'edu':
				location.href='eduList.do';
				break;
			}
		});
		$('#menu tr th').click(function() {
			var menu_value = $(this).attr('menu_value');
			switch(menu_value) {
			case 'emp':
				location.href='empList.do';
				break;
			case 'inst':
				location.href='instList.do';
				break;
			case 'ex_inst':
				location.href='exInstList.do';
				break;
			case 'req_inst':
				location.href='reqInstList.do';
				break;			
			case 'must_finish':
				location.href='mustEmpList.do';
				break;
			}
		});
		$('.emp').click(function() {
			var emp_no = $(this).find('.empNum').html();
			location.href='empDetail.do?emp_no='+emp_no;
		});
		
		$('#back').click(function() {
			location.href='exInstList.do';
		});
	});
	
	function checkSubmit() {
		if(name.value == '') {
			alert('이름을 입력해주세요.');
			return false;
		} else if(identity_no1.value == '' || identity_no2.value == '') {
			alert('주민등록번호를 입력해주세요.');
			return false;
		} else if(address.value == '') {
			alert('주소를 입력해주세요.');
			return false;
		} else if(phone1.value == '' || phone2.value == '' || phone3.value == '') {
			alert('전화번호를 입력해주세요.');
			return false;
		} else if(email.value == '') {
			alert('이메일을 입력해주세요.');
			return false;
		} else {
			return true;			
		}
	}
</script>
<style>
	table {
		width: 100%;
	}
	table tr th {
		border: 1px solid black;
		padding : 20px;
		text-align: center;
	}
	table tr td {
		border: 1px solid black;
		text-align: center;
	}
	#title tr th {
		margin: 3px;
		width: 50%;
	}
	#menu tr th {
		margin: 3px;
		width: 20%;
		height: 25%;
	}
	a {
		color: black;
		text-decoration: none;
	}
	#inputForm tr td {
		text-align: left;
	}
	#inputForm input {
		margin: 3px;
	}
</style>
<body>
	<div>
		<table id="title">
			<tr>
				<th title_value="emp">강사 및 직원관리</th>
				<th title_value="edu">교육과정 관리</th>
			</tr>
		</table>
	</div>
	<div>
		<table id="menu">
			<tr>
				<th menu_value="emp">직원</th>
				<td rowspan="5">
					<form action="exInstRegist.do" method="post" onsubmit="return checkSubmit();">
						<table id="inputForm">
							<tr>
								<th>이름</th>
								<td><input type="text" id="name" name="name"/></td>
							</tr>
							<tr>
								<th>주민등록번호</th>
								<td><input type="text" id="identy_no1" name="identy_no1" style="width: 100px;"/>-<input type="text" id="identy_no2" name="identy_no2" style="width: 15px;"/>XXXXXX</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" id="address" name="address" style="width: 90%;"/></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="text" id="phone1" name="phone1" style="width: 45px;"/>-<input type="text" id="phone2" name="phone2" style="width: 60px;"/>-<input type="text" id="phone3" name="phone3" style="width: 60px;"/></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" id="email" name="email"/></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;">
									<input type="submit" value="등록하기"/>
									<input type="reset" value="다시작성"/>
									<input type="button" id="back" value="목록으로"/>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<tr>
				<th menu_value="inst">강사</th>
			</tr>
			<tr>
				<th menu_value="ex_inst">외부강사</th>
			</tr>
			<tr>
				<th menu_value="req_inst">강사요청<br />심사관리</th>
			</tr>
			<tr>
				<th menu_value="must_finish">필수과정<br />이수조회</th>
			</tr>
		</table>
	</div>
</body>