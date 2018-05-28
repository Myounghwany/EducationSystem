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
				<td rowspan="5">
					<table>
						<c:forEach items="${eduList}" var="eduList">
							<tr>
								<th colspan="5">${eduList.edu_name}을 수강하지 않은 사원</th>
							</tr>
							<tr>
									<th>사번</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>수강상태</th>
							</tr>
							<c:choose>
								<c:when test="${fn:length(empList) > 0}">
									<c:forEach items="${empList}" var="empList">
										<c:if test="${'Y' ne empList.edu_state and empList.edu_code eq eduList.edu_code}">
											<tr class="emp">
												<td class="empNum">${empList.emp_no}</td>
												<td>${empList.name}</td>
												<td>${empList.dept_name}</td>
												<td>${empList.position_name}</td>
												<td>
													<c:if test="${'N' eq empList.edu_state}">
														미수료
													</c:if>
													<c:if test="${'I' eq empList.edu_state}">
														현재 수강중
													</c:if>
													<c:if test="${null eq empList.edu_state}">
														수강하지 않음
													</c:if>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="text-align: center;"><b>해당하는 사원이 없습니다.</b></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
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
			<tr>
				<th menu_value="must_finish">필수과정<br />이수조회</th>
			</tr>
		</table>
	</div>
</body>