<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>강사 - Education System</title>
<style>
#isntRegBtn{
	float: right;
}
#info{
	text-align: center;
}
#eduRegBtn{
	float: right;
}
#pageForm{
	text-align: center;
}
.studentNum{
	color : red;
}
</style>
<script type="text/javascript">
	function isntRegBtn(account_no){
		if(confirm("사원번호 : " + account_no + "\n"+"강사를 신청하시겠습니까?")==true){
			location.href="/EducationSystem/instructor/inst_req.do?account_no=" + account_no;
			alert('강사신청이 완료되었습니다.');
		}else{
			return;
		}
	}
	function eduRegBtn(instructor_no){
		location.href="/EducationSystem/instructor/edu_req.do?instructor_no=" + instructor_no;
	}
	function isntEvalBtn(edu_no, deadLine){
		window.name = "parentForm";
		window.open("${path}/instructor/inst_eval.do?edu_no=" + edu_no + "&deadLine=" + deadLine, "evalForm", "width=570, height=350, resizable = no, scrollbars = no, top=250, left=570");
	}
</script>
<jsp:include page="../common/header.jsp" />
<body>
	<h3>강사 페이지</h3>
	<c:choose>
		<c:when test='${instructor_no=="null"}'>
			<div id="info">${result }</div>
			<table class="w3-table w3-bordered">
				<tr>
					<th>
						<input type="button" id="eduRegBtn" onclick="isntRegBtn('${account_no}');" value="교육신청" class="w3-button w3-green w3-border">
					</th>
				</tr>
			</table>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test='${inproval_state == 3}'>
				
					강사번호 : ${instructor_no}
						<c:choose>
							<c:when test='${account_no!=null}'>
							<table class="w3-table w3-bordered">
								<tr>
									<th>
										<input type="button" id="eduRegBtn" onclick="eduRegBtn('${instructor_no}');" value="교육신청" class="w3-button w3-green w3-border">
									</th>
								</tr>
							</table>
							</c:when>	
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					
					<table class="w3-table w3-bordered">
						<tr>
							<th colspan="5" style="background-color: #CCCCCC;">신청현황</th>
						</tr>
						<tr>
							<td style="background-color: #EAEAEA;">교육분야</td>
							<td style="background-color: #EAEAEA;">교육명</td>
							<td style="background-color: #EAEAEA;">시간표</td>
							<td style="background-color: #EAEAEA;">수강제한 수</td>
							<td style="background-color: #EAEAEA;">신청현황</td>
						</tr>
						<c:forEach items = "${result1 }" var = "item">
							<tr>
								<td>${item.edu_field }</td>
								<td>${item.edu_name }</td>
								<td>${item.edu_schedule }</td>
								<td>${item.applicants_limit } 명</td>
								<td>
									<c:choose>
										<c:when test="${item.approval_state == 1}">심사중</c:when>
										<c:otherwise>승인거부</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
					<br/>
					<hr/>
					<br/>
					<table class="w3-table w3-bordered">
						<tr>
							<th colspan="5" style="background-color: #CCCCCC;">강의목록</th>
						</tr>
						<tr>
							<td style="background-color: #EAEAEA;">교육분야</td>
							<td style="background-color: #EAEAEA;">교육명</td>
							<td style="background-color: #EAEAEA;">시간표</td>
							<td style="background-color: #EAEAEA;">수강자 수</td>
							<td style="background-color: #EAEAEA;">평가</td>
						</tr>
						<c:forEach items = "${result2 }" var = "item">
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="now_date" /> 
						<fmt:parseDate value="${item.end_date }" pattern="yyyy-MM-dd HH:mm:ss" var="end_date" /> 
						<fmt:formatDate value="${end_date }" pattern="yyyy-MM-dd HH:mm:ss" var="end" /> 
						<fmt:parseDate value="${item.deadLine }" pattern="yyyy-MM-dd HH:mm:ss" var="deadLine" /> 
						<fmt:formatDate value="${deadLine }" pattern="yyyy-MM-dd HH:mm:ss" var="dead" /> 
							<tr>
								<td>${item.edu_field }</td>
								<td><a href="${path}/instructor/eduDetail.do?edu_no=${item.edu_no }">${item.edu_name }</a></td>
								<td>${item.edu_schedule }</td>
								<td><span class="studentNum">${item.student } </span>/ ${item.applicants_limit }</td>
								<td>
									<c:if test="${now_date < dead && now_date > end}">
										<input type="button" onclick="isntEvalBtn('${item.edu_no }', '${item.deadLine }');" value="평가하기" class="w3-button w3-blue w3-border">
									</c:if>
									<c:if test="${dead < now_date}">
										<input type="button" onclick="isntEvalBtn('${item.edu_no }', '${item.deadLine }');" value="평가완료" class="w3-button w3-white w3-border">
									</c:if>
									<c:if test="${end > now_date}">
										강의진행중
									</c:if>
									
								</td>
							</tr>
						
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
					강사신청 심사중입니다.
				</c:otherwise> 
			</c:choose>
		</c:otherwise>
	</c:choose>
	
	<br>
	<div id="pageForm">
		<c:if test="${startPage != 1 }">
			<a href ="${path}/instructor/main.do?page=${page -1}">[ 이전 ]</a> 
		</c:if>
		<c:forEach var="pageNum" begin="${startPage }" end="${endPage }">
			<c:if test="${pageNum == page }">
				${pageNum }&nbsp;
			</c:if>
			<c:if test="${pageNum != page }">
				<a href="${path}/instructor/main.do?page=${pageNum}">${pageNum}&nbsp;</a>
			</c:if>
			
		</c:forEach>
		
		<c:if test="${endPage != maxPage }">
			<a href='${path}/instructor/main.do?page=${endPage+1 }'>[다음]</a>
	    </c:if>
	</div>
	
	
</body>