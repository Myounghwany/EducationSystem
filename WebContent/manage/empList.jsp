<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>관리자 페이지 - Education System</title>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$('document').ready(function() {
		//alert($(location).attr('host')); //localhost:8080
		//alert($(location).attr('hostname')); //localhost
		//alert($(location).attr('path')); //undefined
		alert($(location).attr('href')); //http://localhost:8080/EducationSystem/manageEmpList.do
		//alert($(location).attr('port')); //8080
		//alert($(location).attr('protocol')); //http:
		
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
		$('.emp').click(function() {
			var emp_no = $(this).find('.empNum').html();
			location.href='empDetail.do?emp_no='+emp_no;
		});
	});
	
	function checkSubmit() {
		if(srchWord.value == '') {
			alert('검색어를 입력해주세요.');
			return false;
		}
		var dept = $('#srchDept').val();
		var pos = $('#srchPos').val();
		var cat = $('#srchCat').val();
		var word = $('#srchWord').val();
		location.href='empList.do?';
		return true;		
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
								<tr class="emp">
									<td class="empNum">${empList.emp_no}</td>
									<td>${empList.name}</td>
									<td>${empList.dept_name}</td>
									<td>${empList.position_name}</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="4" style="text-align: center">
									<c:if test="${pageStart > 5}">
										<a href="empList.do?pageNum=${pageStart-1}">[이전]</a>
										&nbsp;|
									</c:if>
									<c:forEach begin="${pageStart}" end="${pageEnd}" var="page">
										&nbsp;<a href="empList.do?pageNum=${page}">${page}</a>
										<c:if test="${page != pageEnd}">
											&nbsp;|
										</c:if>
									</c:forEach>
									<c:if test="${next == 1}">
										&nbsp;|&nbsp;
										<a href="empList.do?pageNum=${pageEnd+1}">[다음]</a>
									</c:if>
									<br />
									<form action="empList.do" method="post" onsubmit="checkSubmit()">
									<select name="srchDept" id="srchDept">
										<option value="nothing">---부서---</option>
										<c:forEach items="${deptList}" var="deptList">
											<option value="${deptList.dept_no}">${deptList.dept_name}</option>
										</c:forEach>
									</select>
									<select name="srchPos" id="srchPos">
										<option value="nothing">---직책---</option>
										<c:forEach items="${posList}" var="posList">
											<option value="${posList.position_no}">${posList.position_name}</option>
										</c:forEach>
									</select>
									<select name="srchCat" id="srchCat">
										<option value="number">사원번호</option>
										<option value="name">이름</option>
									</select>
									<input type="text" id="srchWord" style="width: 110px;"/>
									<input id="srch" type="submit" value="검색"/>
									</form>
								</td>
							</tr>
						</tbody>
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