<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<title>Insert title here</title>
<jsp:include page="../common/header.jsp" />
<!-- 추가 Page styles -->
<link type='text/css' href='../css/demo.css' rel='stylesheet' media='screen' />
<!-- 추가 Contact Form CSS files -->
<link type='text/css' href='../css/basic.css' rel='stylesheet' media='screen' />
<!-- 강의평가 제출내역 modal bootstrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
	});
	
	function isntEvalBtn(edu_no, deadLine){
		window.name = "parentForm";
		window.open("${path}/instructor/inst_eval.do?edu_no=" + edu_no + "&deadLine=" + deadLine, "evalForm", "width=570, height=350, resizable = no, scrollbars = no, top=250, left=570");
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
	#info{
	text-align: center;
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
						<tr>
							<th>사번</th>
							<td>${inst.instructor_no}</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${inst.name}</td>
						</tr>
						<tr>
							<th>구분</th>
							<td>
								<c:choose>
									<c:when test="${null ne inst.emp_no}">
										내부강사(${inst.emp_no})
									</c:when>
									<c:otherwise>
										외부강사
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<c:choose>
									<c:when test='${inst.emp_no!=null}'>							
									<table>
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
								</c:choose>
							
								<br/>
								<hr/>
								<br/>
								<table>
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
											<td><a href="${path}/instructor/eduDetail.do?edu_no=${item.edu_no }&instructor_no=${inst.instructor_no}">${item.edu_name }</a></td>
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
							</td>
						</tr>
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