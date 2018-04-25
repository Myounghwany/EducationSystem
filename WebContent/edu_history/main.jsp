<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<jsp:include page="../common/header.jsp" />
<head>

<title>수강목록 페이지</title>
<style>
	table {
		color: black;
		width: 80%;
		margin-top : 2%;
		text-align: center;
		border-color: #BDBDBD;
	}
	th {
		background-color: #EAEAEA;
		text-align: center;
		height: 50px;
	}
	td {
		height: 30px;
		background-color: #FDFFFF;
	}
	a:hover {
		color : #FF5E00;
		text-decoration: none;
		font-weight: bold;
	}
	</style>
</head>

<body>
	<h2>수강목록 페이지</h2>
	세션계졍 : ${sessionScope.account} <br>
	java코드 오늘 날짜 : ${date} <br>
	<table align="center" border="1">
		<tr>
			<th>교육명</th>
			<th>강사명</th>
			<th>교육일</th>
			<th>이수여부</th>
			<th>강의평가</th>
		</tr>
		<c:choose>
			<c:when test="${empty edu_list}">
				<tr>
					<td colspan="5">수강내역이 존재하지 않습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${edu_list}" var="edulist" varStatus="state">
					<tr>
						<td><a href="eduhistory/detail.do?edu_no=${edulist.edu_no}">${edulist.edu_name}</a></td>
						<td>${edulist.instructor_name}</td>
						<td>${edulist.edu_schedule}</td>
						<td>${edulist.edu_state}</td>
						<td>
						<!-- 강의평가 버튼 생성 조건 
							 1. 직원이 강의평가 하지 않았을 때
							 2. 현재 수강중이 아닐 때
							 3. 강의 종료일 < 오늘 날짜일 때  -->
						<c:if test="${ empty edulist.emp_eval and edulist.edu_state != 'I' and edulist.end_date lt date }">
							<button onclick="window.open('eduhistory/emp_eval.do?edu_no=${edulist.edu_no}', '강의평가',
									'width=600,height=320,location=no,status=no,scrollbars=yes,resizeable=no,left=600,top=200');">
								강의평가
							</button>
						</c:if> 
						<c:if test="${!empty edulist.emp_eval}">
								<!-- 직원이 강사에 대한 평가를 완료했다면 -->평가완료
						</c:if>
						<!-- 현재 수강중 표시 조건
							 1.수강목록 테이블(history)의 이수여부가 I일 때
							 2.오늘 날짜 < 강의 종료일일 때  -->
						<c:if test="${edulist.edu_state eq 'I' and date lt edulist.end_date }" >
								<span style="color:blue;">현재 수강중 </span>
						</c:if>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</body>

<!-- holder.js -->