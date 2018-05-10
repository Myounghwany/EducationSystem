<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<title>관리자 페이지 - Education System</title>
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
		$('.emp').click(function() {
			var emp_no = $(this).find('.empNum').html();
			location.href='empDetail.do?emp_no='+emp_no;
		});
	});
	
	function checkSubmit() {
		if(srchDept.value == 'nothing' && srchPos.value == 'nothing' && srchWord.value == '') {
			alert('검색조건을 갖춰주세요.\n부서, 직책을 선택하거나 검색어 입력중 하나라도 해야 합니다.');
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
							<c:choose>
								<c:when test="${fn:length(empList) > 0}">
									<c:forEach items="${empList}" var="empList">
										<tr class="emp">
											<td class="empNum">${empList.emp_no}</td>
											<td>${empList.name}</td>
											<td>${empList.dept_name}</td>
											<td>${empList.position_name}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="text-align: center;"><b>해당하는 사원이 없습니다.</b></td>
									</tr>
								</c:otherwise>
							</c:choose>
							<tr>
								<td colspan="4" style="text-align: center;">
									<c:if test="${fn:length(empList) > 0}">
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
									</c:if>
									<br />
									<form action="empList.do" method="get" onsubmit="return checkSubmit();">
										<select name="srchDept" id="srchDept">
											<c:if test="${'nothing' == srchDept}">
												<option value="nothing" selected="selected">---부서---</option>
											</c:if>
											<c:if test="${'nothing' != srchDept}">
												<option value="nothing">---부서---</option>
											</c:if>
											<c:forEach items="${deptList}" var="deptList">
												<c:choose>
													<c:when test="${'nothing' != srchDept and deptList.dept_no == srchDept}">
														<option value="${deptList.dept_no}" selected="selected">${deptList.dept_name}</option>
													</c:when>
													<c:otherwise>
														<option value="${deptList.dept_no}">${deptList.dept_name}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
										<select name="srchPos" id="srchPos">
											<c:if test="${'nothing' == srchPos}">
												<option value="nothing" selected="selected">---직책---</option>
											</c:if>
											<c:if test="${'nothing' != srchPos}">
												<option value="nothing">---직책---</option>
											</c:if>
											<c:forEach items="${posList}" var="posList">
												<c:choose>
													<c:when test="${'nothing' != srchPos and posList.position_no == srchPos}">
														<option value="${posList.position_no}" selected="selected">${posList.position_name}</option>
													</c:when>
													<c:otherwise>
														<option value="${posList.position_no}">${posList.position_name}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
										<select name="srchCat" id="srchCat">
											<c:choose>
												<c:when test="${'number' == srchCat}">
													<option value="number" selected="selected">사원번호</option>
													<option value="name">이름</option>
												</c:when>
												<c:when test="${'name' == srchCat}">
													<option value="number">사원번호</option>
													<option value="name" selected="selected">이름</option>
												</c:when>
												<c:otherwise>
													<option value="number">사원번호</option>
													<option value="name">이름</option>
												</c:otherwise>
											</c:choose>
										</select>
										<input type="text" name="srchWord" id="srchWord" value="${srchWord}" style="width: 110px;"/>
										<input type="submit" id="srch" value="검색"/>
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