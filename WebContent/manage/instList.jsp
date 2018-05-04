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
		$('.inst').click(function() {
			var instructor_no = $(this).find('.instNum').html();
			location.href='instDetail.do?inst_no='+instructor_no;
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
				<th menu_value="emp">직원</th>
				<td rowspan="4">
					<table>
						<thead>
							<tr>
								<th>강사번호</th>
								<th>분류</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${instList}" var="instList">
								<tr class="inst">
									<td class="instNum">${instList.instructor_no}</td>
									<td>
										<c:choose>
											<c:when test="${null == instList.emp_no}">
												외부 강사
											</c:when>
											<c:otherwise>
												내부 강사
											</c:otherwise>
										</c:choose>
									</td>
									<td>${instList.name}</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="4" style="text-align: center">
									<c:if test="${pageStart > 5}">
										<a href="instList.do?pageNum=${pageStart-1}">[이전]</a>
										&nbsp;|
									</c:if>
									<c:forEach begin="${pageStart}" end="${pageEnd}" var="page">
										&nbsp;<a href="instList.do?pageNum=${page}">${page}</a>
										<c:if test="${page != pageEnd}">
											&nbsp;|
										</c:if>
									</c:forEach>
									<c:if test="${next == 1}">
										&nbsp;|
										<a href="instList.do?pageNum=${pageEnd+1}">[다음]</a>
									</c:if>
									<br />
									<select name="srchType">
										<option value="internal">내부강사</option>
										<option value="external">외부강사</option>
									</select>
									<select name="srchCat" id="srchCat">
										<option value="number">강사번호</option>
										<option value="name">이름</option>
									</select>
									<input type="text" id="srchWord" style="width: 110px;"/>
									<button id="srch">검색</button>
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