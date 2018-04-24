<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>관리자 페이지 - Education System</title>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$('document').ready(function() {
		$('#title tr th').click(function() {
			var title_value = $(this).attr('title_value');
			if(title_value == 'emp') {
				location.href='manageEmpList.do';
			} else if(title_value == 'edu') {
				location.href='manageEduList.do';
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
				<th>직원</th>
				<td rowspan="4">
					<table>
						<thead>
							<tr>
								<th>사번</th>
								<th>이름</th>
								<th>부서</th>
								<th>직급</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${empList}" var="empList">
								<tr>
									<td>${empList.emp_no}</td>
									<td>${empList.name}</td>
									<td>${empList.dept_name}</td>
									<td>${empList.position_name}</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="4" style="text-align: center">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<th>강사</th>
			</tr>
			<tr>
				<th>외부강사</th>
			</tr>
			<tr>
				<th>강사요청<br />심사관리</th>
			</tr>
		</table>
	</div>
</body>