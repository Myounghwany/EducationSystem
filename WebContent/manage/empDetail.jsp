<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<title>Insert title here</title>
<jsp:include page="../common/header.jsp" />
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
			}
		});
	});
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
				<td rowspan="4">
					<table>
						<tr>
							<th>사번</th>
							<td>${emp.emp_no}</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${emp.name}</td>
						</tr>
						<tr>
							<th>부서</th>
							<td>${emp.dept}</td>
						</tr>
						<tr>
							<th>직책</th>
							<td>${emp.position}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${emp.address}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${emp.phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${emp.email}</td>
						</tr>
					</table>
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
		</table>
	</div>
</body>