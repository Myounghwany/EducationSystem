<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.table1{
	width: 100%;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
}
.table2{
	width: 100%;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
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
	function isntEvalBtn(edu_no){
		window.name = "parentForm";
		window.open = ("/EducationSystem/instructor/inst_eval.do?edu_no=" + edu_no, "evalForm", "width=570, height=350, resizable = no, scrollbars = no");
	}
</script>
<jsp:include page="../common/header.jsp" />
<body>
	<h3>강사 페이지</h3>
	<c:choose>
		<c:when test='${instructor_no=="null"}'>
			<div id="info">${result }</div>
			<button id="isntRegBtn" onclick="isntRegBtn('${account_no}');">강사신청</button>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test='${inproval_state == 3}'>
				
					강사번호 : ${instructor_no}
						<c:choose>
							<c:when test='${account_no!=null}'>
								<button id="eduRegBtn" onclick="eduRegBtn('${instructor_no}');">교육신청</button>
							</c:when>	
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					<br/>
					<br/>
					<h4>신청현황</h4>
					<table class="table1" border = "1">
						<tr>
							<td>교육분야</td>
							<td>교육명</td>
							<td>시간표</td>
							<td>수강제한 수</td>
							<td>신청현황</td>
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
					<h4>강의목록</h4>
					<table class="table2" border = "1">
						<tr>
							<td>교육분야</td>
							<td>교육명</td>
							<td>시간표</td>
							<td>수강자 수</td>
							<td>평가</td>
						</tr>
						<c:forEach items = "${result2 }" var = "item">
							<tr>
								<td>${item.edu_field }</td>
								<td><a href="${path}/instructor/eduDetail.do?edu_no=${item.edu_no }">${item.edu_name }</a></td>
								<td>${item.edu_schedule }</td>
								<td>${item.applicants_limit } 명</td>
								<td><button onclick="isntEvalBtn('${item.edu_no }');">평가하기</button></td>
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
	
	
	${target }
	
	
</body>