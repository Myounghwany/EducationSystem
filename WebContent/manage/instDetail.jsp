<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		
		$('.eduList .edu').click(function() {
			var edu_no = $(this).parent().find('.eduNum').html();
			
			$.ajax({
				contentType : 'application/x-www-form-urlencoded; charset=utf-8',
				url : '/EducationSystem/manage/edu_detail.do',
				type : 'get',
				data : {
					edu_no : edu_no
				},
				headers : {
					Accept : "application/json"
				},
				dataType:"json",
				success : function(data){
					$('#edu_no_detail').html(data.edu_no);
					$('#belong_no').html(data.belong_no);
					$('#belong_name').html(data.belong_name);
					$('#edu_name_detail').html(data.edu_name);
					$('#edu_schedule').html(data.edu_schedule);
					$('#budget').html(data.budget);
					$('#closing_date').html(data.closing_date);
					$('#edu_code').html(data.edu_code);
					$('#edu_code_name').html(data.edu_code_name);
					$('#edu_date').html(data.edu_date);
					$('#edu_feild').html(data.edu_feild);
					$('#edu_location').html(data.edu_location);
					$('#edu_target').html(data.edu_target);
					$('#edu_way').html(data.edu_way);
					$('#instructor_name').html(data.instructor_name);
					$('#instructor_no').html(data.instructor_no);
					$('#manager').html(data.manager);
					$('#note').html(data.note);
				},
				error : function(request, status, error){
					alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
					console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				}
			});
		});
		
	});
	

	function show_eval(edu_no){
		var edu_no = edu_no;
		
		$.ajax({
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			url : '/EducationSystem/eduhistory/show_eval.do',
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
	<div id="basic-modal">
		<table id="menu">
			<tr>
				<th menu_value="emp">직원</th>
				<td rowspan="5">
					<table>
						<tr>
							<th>사번</th>
							<td>${emp.emp_no}</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${emp.name}</td>
						</tr>
						<tr>
							<th>구분</th>
							<td>${emp.dept_name}</td>
						</tr>
						<tr>
							<td colspan="2">
								<table>
									<tr>
										<th>교육명</th>
										<th>강사명</th>
										<th>교육일</th>
										<th>이수여부</th>
										<th>강의평가</th>
									</tr>
									<c:choose>
										<c:when test="${empty eduHistory}">
											<tr>
												<td colspan="5">수강내역이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${eduHistory}" var="eduHistory" varStatus="state">
												<tr class="eduList">
													<td class="eduNum" style="display: none;">${eduHistory.edu_no}</td>
													<td class="edu">${eduHistory.edu_name}</td>
													<td><a href="instDetail.do?inst_no=${eduHistory.instructor_no}">${eduHistory.instructor_name}</a></td>
													<td>${eduHistory.edu_schedule}</td>
													<c:if test="${sessionScope.account eq 'inst'}">
														<td>
														<c:choose>
															<c:when test="${date <= eduHistory.end_date}" >
																<span style="color:blue;">현재 교육중 </span>
															</c:when>
															<c:otherwise>
																<span style="color:black;">교육 완료 </span>
															</c:otherwise>
														</c:choose>
														</td>
													</c:if>
													<c:if test="${sessionScope.account eq 'emp'}">
														<td>${eduHistory.edu_state}</td>
														<td>
															<!-- 현재 수강중 표시 조건
																 1.오늘 날짜 < 강의 종료일일 때  -->
															<c:if test="${date <= eduHistory.end_date}">
																<span style="color:blue;">현재 수강중 </span>
															</c:if>
															
															<!-- 강의평가 버튼 생성 조건 
																 1. 직원이 강의평가 하지 않았을 때
																 2. 종료일 < 현재시각(date)
																 3. 강의 종료일 < 현재시각(date) < 강의종료일 +7 일 때 (= Flag가 1이 올 때)  -->
															
															<c:if test="${ empty eduHistory.emp_eval and eduHistory.end_date < date and eduHistory.buttonFlag eq 1}">
																<span>평가 미제출</span>
															</c:if>
															
															<!-- 기간내에 평가했다면 완료했다면 --> 
															<c:if test="${!empty eduHistory.emp_eval}">
																평가완료
																<!-- 직원의 강의평가 제출내역 보기 -->
																<button type="button"  data-toggle="modal" data-target="#myModal" onclick="show_eval(${eduHistory.edu_no});">보기</button>
								
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
															<c:if test="${empty eduHistory.emp_eval and eduHistory.buttonFlag eq 0}">
																기간내 미제출
															</c:if>
														</td>
													</c:if>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
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
		

		<!-- modal content -->
		<div id="basic-modal-content">
			<p><code>교육번호 : <span id="edu_no_detail"> </span> | 
					  교육명 : <span id="edu_name_detail"> </span>
				</code>
			</p>
			<div style="height: auto;">
				<div style="width: 50%; float:left;">
					<p>소속번호 : <span id="belong_no"> </span></p>
					<p>소속명 : <span id="belong_name"> </span></p>
					<p>교육코드 : <span id="edu_code"> </span></p>							
					<p>교육코드명 : <span id="edu_code_name"> </span></p>
					<p>교육일정 : <span id="edu_schedule"> </span></p>
					<p>신청마감일 : <span id="closing_date"> </span></p>
					<p>교육일시 : <span id="edu_date"> </span></p>
					<p>교육상세분야 : <span id="edu_feild"> </span></p>
					</div>
				<div>
					<p>교육장소 : <span id="edu_location"> </span></p>
					<p>교육대상 : <span id="edu_target"> </span></p>
					<p>교육방법 : <span id="edu_way"> </span></p>
					<p>강사이름 : <span id="instructor_name"> </span></p>
					<p>강사번호 : <span id="instructor_no"> </span></p>
					<p>담당자 : <span id="manager"> </span></p>
				</div>
			</div>
			<div style="width: 100%;">
				<span>소요예산 :</span>
				<pre><span id="budget"> </span></pre>
				<p>비고: </p>
				<pre><span id="note"> </span></pre>
			</div>
		</div>
		<!-- preload the images -->
		<div style='display:none'>
			<img src='../img/x.png' alt='' />
		</div>
	</div>
	
	<!-- 추가 Load jQuery, SimpleModal and Basic JS files -->
	<script type='text/javascript' src='../js/jquery.js'></script>
	<script type='text/javascript' src='../js/jquery.simplemodal.js'></script>
	<script type='text/javascript' src='../js/basic.js'></script>
</body>