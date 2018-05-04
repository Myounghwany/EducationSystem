<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<jsp:include page="../common/header.jsp" />
<head>
<title>수강목록 페이지</title>
<!-- table css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">
</head>
<script type="text/javascript">
	
</script>
<body>
	<h2>수강목록 페이지</h2>
	<div style="width: 80%; margin: 20px auto">
	세션계졍 : ${sessionScope.account} <br>
	강의평가는 수강종료일 이후 <b>15일</b> 이내에 하셔야 합니다. <br><br>
	<table class="w3-table w3-bordered" >
		<tr>
			<th>번호</th>
			<th>교육명</th>
			<th>강사명</th>
			<th width="25%">교육일</th>
			<th width="10%">이수여부</th>
			<th>강의평가</th>
		</tr>
		<c:choose>
			<c:when test="${empty eduhistory_list}">
				<tr>
					<td colspan="5">수강내역이 존재하지 않습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${eduhistory_list}" var="HistoryList" varStatus="state">
					<tr>
						<td>${state.count}</td>
						<td><a href="eduhistory/detail.do?edu_no=${HistoryList.edu_no}">${HistoryList.edu_name}</a></td>
						<td>${HistoryList.instructor_name}</td>
						<td>${HistoryList.edu_schedule}</td>
						<td>${HistoryList.edu_state}</td>
						<td>
						<!-- 강의평가 버튼 생성 조건 
							 1. 직원이 강의평가 하지 않았을 때
							 2. 현재 수강중이 아닐 때
							 3. 강의 종료일 < 강의종료일 +10 까지  -->
						
						<c:if test="${ empty HistoryList.emp_eval and HistoryList.edu_state != 'I' and HistoryList.buttonFlag eq 1}">
							<button class="button button2"
									onclick="window.open('eduhistory/emp_eval.do?edu_no=${HistoryList.edu_no}', '강의평가',
									'width=600,height=340,location=no,status=no,scrollbars=yes,resizeable=no,left=600,top=200');">
								강의평가
							</button>
						</c:if> 
						<c:if test="${!empty HistoryList.emp_eval}">
								<!-- 직원이 강사에 대한 평가를 완료했다면 -->평가완료
						</c:if>
						<!-- 현재 수강중 표시 조건
							 1.수강목록 테이블(history)의 이수여부가 I일 때
							 2.오늘 날짜 < 강의 종료일일 때  -->
						<c:if test="${HistoryList.edu_state eq 'I'}" >
								<span style="color:blue;">현재 수강중 </span>
						</c:if>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	</div>
</body>

<!-- holder.js -->