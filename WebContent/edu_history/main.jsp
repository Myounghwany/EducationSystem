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
<!-- 강의평가 제출내역 modal bootstrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<script type="text/javascript">
	function show_eval(edu_no){
		var edu_no = edu_no;
		
		$.ajax({
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			url : 'eduhistory/show_eval.do',
			type : 'get',
			data : {
				edu_no : edu_no
			},
			headers : {
				Accept : "application/json"
			},
			dataType:"json",
			success : function(data){
				$('#edu_no').html(data.edu_no);
				$('#edu_name').html(data.edu_name);
				$('#edu_schedule').html(data.edu_schedule);
				$('#edu_state').html(data.edu_state);
				$('#emp_eval').html(data.emp_eval);
			},
			error : function(request, status, error){
				alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});
	}
	
</script>
<body>
<h2>수강목록 페이지</h2>
<div style="width: 80%; margin: 20px auto">
	
	세션계졍 : ${sessionScope.no}, ${sessionScope.name}님 <br>
	<c:if test="${sessionScope.account eq 'emp'}">
		강의평가는 수강종료일 이후 <b>15일</b> 이내에 하셔야 합니다. <br><br>
	</c:if>
	<div class="container">
		<table class="w3-table w3-bordered" >
			<tr>
				<th width="5%">번호</th>
				<th width="40%">교육명</th>
				<th width="10%">강사명</th>
				<th width="25%">교육일</th>
				<c:if test="${sessionScope.account eq 'emp'}">
					<th width="8%">이수여부</th>
					<th>강의평가</th>
				</c:if>
				<c:if test="${sessionScope.account eq 'inst'}">
					<th width="8%">교육여부</th>
				</c:if>
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
							<c:if test="${sessionScope.account eq 'inst'}">
								<td>
								<c:choose>
									<c:when test="${date <= HistoryList.end_date}" >
										<span style="color:blue;">현재 교육중 </span>
									</c:when>
									<c:otherwise>
										<span style="color:black;">교육 완료 </span>
									</c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${sessionScope.account eq 'emp'}">
								<td>${HistoryList.edu_state}</td>
								<td>
									<!-- 현재 수강중 표시 조건
										 1.오늘 날짜 < 강의 종료일일 때  -->
									<c:if test="${date <= HistoryList.end_date}">
										<span style="color:blue;">현재 수강중 </span>
									</c:if>
									
									<!-- 강의평가 버튼 생성 조건 
										 1. 직원이 강의평가 하지 않았을 때
										 2. 종료일 < 현재시각(date)
										 3. 강의 종료일 < 현재시각(date) < 강의종료일 +7 일 때 (= Flag가 1이 올 때)  -->
									
									<c:if test="${ empty HistoryList.emp_eval and HistoryList.end_date < date and HistoryList.buttonFlag eq 1}">
										<button class="button button2"
												onclick="window.open('eduhistory/emp_eval.do?edu_no=${HistoryList.edu_no}', '강의평가',
												'width=600,height=340,location=no,status=no,scrollbars=yes,resizeable=no,left=600,top=200');">
											강의평가
										</button>
									</c:if>
									
									<!-- 기간내에 평가했다면 완료했다면 --> 
									<c:if test="${!empty HistoryList.emp_eval}">
										평가완료
										<!-- 직원의 강의평가 제출내역 보기 -->
										<button type="button"  data-toggle="modal" data-target="#myModal" onclick="show_eval(${HistoryList.edu_no});">보기</button>
		
										<!-- Modal -->
									  	<div class="modal fade" id="myModal" role="dialog">
										    <div class="modal-dialog">
										    
										      <!-- 내용 -->
										      <div class="modal-content">
										        <div class="modal-header">
										          <button type="button" class="close" data-dismiss="modal">&times;</button>
										          <h4 class="modal-title">강의평가  제출내역</h4>
										        </div>
										        <div class="modal-body">
										        <table class="w3-table w3-bordered" >
											        <tr>
											        	<td>
											         	교육번호 : <span id="edu_no"> </span>
											        	</td>
											        </tr>
											        <tr>
											        	<td>
											          	교육명 : <span id="edu_name"> </span>
											        	</td>
											        </tr>
											        <tr>
											        	<td>
											          	교육일정 : <span id="edu_schedule"> </span>
											        	</td>
											        </tr>
											        <tr>
											        	<td>
											          	이수여부 : <span id="edu_state"> </span>
											        	</td>
											        </tr>
											        <tr>
											        	<td>
											          	강의평가 제출내역 : <span id="emp_eval"> </span>
											        	</td>
											        </tr>
										        </table>
										        </div>
										        <div class="modal-footer">
										          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										        </div>
										      </div>
										      
										    </div>
									 	 </div>
										
									</c:if>
									
									<!-- 기간내에 평가하지 못했다면(flag 0) -->
									<c:if test="${empty HistoryList.emp_eval and HistoryList.buttonFlag eq 0}">
										미제출
									</c:if>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</div>
	
</body>

<!-- holder.js -->