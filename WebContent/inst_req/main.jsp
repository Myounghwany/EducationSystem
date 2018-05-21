<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">

<title>강사 - Education System</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- 나현 로그인모달 & 드롭다운-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
#name{
	font-weight:bold;
	font-size: 20px;
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
	<div style="padding-bottom: 80px;">
	<c:choose>
		<c:when test='${instructor_no=="null"}'>
			<div id="info">${result }</div>

			<table class="w3-table w3-bordered">
				<tr>
					<th>
						<input type="button" id="eduRegBtn" onclick="isntRegBtn('${account_no}');" value="강사신청" class="w3-button w3-green w3-border">
					</th>
				</tr>
			</table>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test='${approval_state == 3}'>
					<a href="#" data-target="#layerpop" data-toggle="modal"><i class="fas fa-info-circle"></i></a><span id="name">&nbsp;${name }</span> 강사님 ( ${instructor_no} ) 환영합니다!
						<div class="modal fade" id="layerpop" >
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <!-- header -->
						      <div class="modal-header">
						        <!-- 닫기(x) 버튼 -->
						        <button type="button" class="close" data-dismiss="modal">×</button>
						        <!-- header title -->
						        <h4 class="modal-title">강사 정보</h4>
						      </div>
						      <!-- body -->
						      <div class="modal-body">
						            <c:forEach items="${instInfo }" var = "item">
						            	강사명 : ${item.name }<br/>
						            	<c:if test='${account_no!=null}'>
							            	사원번호 : ${item.emp_no}<br/>
						            		소속 : ${item.belong_name }<br/>
						            		부서 : ${item.dept_name }<br/>
						            		직급 : ${item.position_name }<br/>
						            	</c:if>
						            	주민번호 : ${item.identity_no }<br/>
						            	주소지 : ${item.address } <br/>
						            	휴대폰 : ${item.phone }<br/>
						            	이메일 : ${item.email }
						            </c:forEach>
						      </div>
						      <!-- Footer -->
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						      </div>
						    </div>
						  </div>
						</div>
						<c:choose>
							<c:when test='${account_no!=null}'>
							<table class="w3-table w3-bordered">
								<tr>
									<th>
										<input type="button" id="eduRegBtn" onclick="eduRegBtn('${instructor_no}');" value="교육신청" class="w3-button w3-green w3-border">
									</th>
								</tr>
							</table>
							
							<table class="w3-table w3-bordered">
								<tr>
									<th colspan="7" style="background-color: #CCCCCC;">신청현황</th>
								</tr>
								<tr>
									<td style="background-color: #EAEAEA;">소속</td>
									<td style="background-color: #EAEAEA;">교육분야</td>
									<td style="background-color: #EAEAEA;">교육코드</td>
									<td style="background-color: #EAEAEA;">교육명</td>
									<td style="background-color: #EAEAEA;">교육기간</td>
									<td style="background-color: #EAEAEA;">수강제한 수</td>
									<td style="background-color: #EAEAEA;">신청현황</td>
								</tr>
								<c:choose>
								<c:when test="${empty result1}">
									<tr>
										<td colspan="7" style="text-align: center;">신청하신 교육내역이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items = "${result1 }" var = "item">
										<tr>
											<td>${item.belong_name }</td>
											<td>${item.edu_field }</td>
											<td>${item.edu_code_name }</td>
											<td><a href="${path}/instructor/eduReqDetail.do?edu_no=${item.edu_no }">${item.edu_name }</a></td>
											<td>${item.edu_schedule }</td>
											<td>${item.applicants_limit } 명</td>
											<td>
												<c:if test="${item.approval_state == 1}">신청완료</c:if>
												<c:if test="${item.approval_state == 2}">심사중</c:if>
												<c:if test="${item.approval_state == 4}">승인거부</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
								</c:choose>
							</table>
					
							</c:when>	
							<c:otherwise>
							(외부강사)
							</c:otherwise>
						</c:choose>
					
					<br/>
					<hr/>
					<br/>
					<table class="w3-table w3-bordered">
						<tr>
							<th colspan="7" style="background-color: #CCCCCC;">강의목록</th>
						</tr>
						<tr>
							<td style="background-color: #EAEAEA;">소속</td>
							<td style="background-color: #EAEAEA;">교육분야</td>
							<td style="background-color: #EAEAEA;">교육코드</td>
							<td style="background-color: #EAEAEA;">교육명</td>
							<td style="background-color: #EAEAEA;">교육기간</td>
							<td style="background-color: #EAEAEA;">수강자 수</td>
							<td style="background-color: #EAEAEA;">평가</td>
						</tr>
						<c:forEach items = "${result2 }" var = "item">
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="now_date" /> 
						<fmt:parseDate value="${item.end_date }" pattern="yyyy-MM-dd HH:mm:ss" var="end_date" /> 
						<fmt:formatDate value="${end_date }" pattern="yyyy-MM-dd HH:mm:ss" var="end" /> 
						<fmt:parseDate value="${item.deadLine }" pattern="yyyy-MM-dd HH:mm:ss" var="deadLine" /> 
						<fmt:formatDate value="${deadLine }" pattern="yyyy-MM-dd HH:mm:ss" var="dead" /> 
						<fmt:parseDate value="${item.start_date}" pattern="yyyy-MM-dd HH:mm:ss" var="start_date" /> 
						<fmt:formatDate value="${start_date }" pattern="yyyy-MM-dd HH:mm:ss" var="start" /> 
							<tr>
								<td>${item.belong_name }</td>
								<td>${item.edu_field }</td>
								<td>${item.edu_code_name }</td>
								<td><a href="${path}/instructor/eduDetail.do?edu_no=${item.edu_no }&instructor_no=${instructor_no}">${item.edu_name }</a></td>
								<td>${item.edu_schedule }</td>
								<td><span class="studentNum">${item.student } </span>/ ${item.applicants_limit }</td>
								<td>
									<c:if test="${now_date < dead && now_date > end}">
										<input type="button" onclick="isntEvalBtn('${item.edu_no }', '${item.deadLine }');" value="평가하기" class="w3-button w3-blue w3-border">
									</c:if>
									<c:if test="${dead < now_date}">
										<input type="button" onclick="isntEvalBtn('${item.edu_no }', '${item.deadLine }');" value="평가완료" class="w3-button w3-white w3-border">
									</c:if>
									<c:if test="${start > now_date }">
										강의대기중
									</c:if>
									<c:if test="${start < now_date && end > now_date}">
										강의진행중
									</c:if>
									
								</td>
							</tr>
						
						</c:forEach>
					</table>
					
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
	
				</c:when>
				<c:when test='${approval_state == 1}'>
					강사신청 상태 : 신청완료 <br/>
					강사신청일 : ${approval_date }
				</c:when>
				<c:when test='${approval_state == 2}'>
					강사신청 상태 : 심사진행중 <br/>
					강사신청일 : ${approval_date }
				</c:when>
				<c:otherwise>
					강사신청 상태 : 승인거부 <br/>
					강사신청일 : ${approval_date }
				</c:otherwise> 
			</c:choose>
		</c:otherwise>
	</c:choose>
	
	
	</div>
	
</body>