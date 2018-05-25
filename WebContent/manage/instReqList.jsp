<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			}
		});
		$('.emp_no').click(function() {
			var emp_no = $(this).html();
			location.href='empDetail.do?emp_no='+emp_no;
		});
		$('.approval_change').click(function() {
			var approval_state = $(this).val();
			var emp_no = $(this).parent().parent().find('.emp_no').html();
			$('#emp_no').val(emp_no);
			$('#approval_state').val(approval_state);
			$('#sendReq').submit();
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
						<c:choose>
							<c:when test="${fn:length(waitList) > 0}">
								<tr>
									<th colspan="6">심사 대기중인 직원</th>
								</tr>
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>신청날짜</th>
									<th>비고</th>
								</tr>
								<c:forEach items="${waitList}" var="waitList">
									<tr>
										<td class="emp_no">${waitList.emp_no}</td>
										<td>${waitList.name}</td>
										<td>${waitList.dept_name}</td>
										<td>${waitList.position_name}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${waitList.approval_date}"/></td>
										<td><button class="approval_change" value="2">심사 시작</button></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th>심사 대기중인 직원</th>
								</tr>								
								<tr>
									<td>심사 대기중인 직원이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<table>
						<c:choose>
							<c:when test="${fn:length(examingList) > 0}">
								<tr>
									<th colspan="6">심사 중인 직원</th>
								</tr>
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>신청날짜</th>
									<th>비고</th>
								</tr>
								<c:forEach items="${examingList}" var="examingList">
									<tr>
										<td class="emp_no">${examingList.emp_no}</td>
										<td>${examingList.name}</td>
										<td>${examingList.dept_name}</td>
										<td>${examingList.position_name}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${examingList.approval_date}"/></td>
										<td>
											<button class="approval_change" value="3">승인</button>
											<button class="approval_change" value="4">거절</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th>심사 중인 직원</th>
								</tr>								
								<tr>
									<td>심사 중인 직원이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>						
					</table>
					<table>
						<c:choose>
							<c:when test="${fn:length(refusedList) > 0}">
								<tr>
									<th colspan="6">거절 당한 직원</th>
								</tr>
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>신청날짜</th>
									<th>비고</th>
								</tr>
								<c:forEach items="${refusedList}" var="refusedList">
									<tr>
										<td class="emp_no">${refusedList.emp_no}</td>
										<td>${refusedList.name}</td>
										<td>${refusedList.dept_name}</td>
										<td>${refusedList.position_name}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${refusedList.approval_date}"/></td>
										<td>
											<button class="approval_delete" value="${refusedList.emp_no}">삭제</button>
											<button class="approval_change" value="2">보류</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th>거절 당한 직원</th>
								</tr>								
								<tr>
									<td>거절 당한 직원이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>						
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
	<form action="reqInstList.do" method="POST" id="sendReq">
		<input type="hidden" name="emp_no" id="emp_no"/>
		<input type="hidden" name="approval_state" id="approval_state"/>
	</form>
</body>