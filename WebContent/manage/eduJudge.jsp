<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​
<title>관리자 페이지/교육심사</title>
<jsp:include page="../common/header.jsp" />
<!-- 추가 Page styles -->
<link type='text/css' href='../css/demo.css' rel='stylesheet' media='screen' />
<!-- 추가 Contact Form CSS files -->
<link type='text/css' href='../css/basic.css' rel='stylesheet' media='screen' />
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- 로그인모달 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
	$('document').ready(function() {
		//alert($(location).attr('href')); //http://localhost:8080/EducationSystem/manageEmpList.do
		
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
			case 'eduList':
				location.href='eduList.do';
				break;
			case 'eduJudge':
				location.href='eduJudge.do';
				break;
			case 'regist':
				location.href='regist.do';
				break;
			case 'petition':
				location.href='/EducationSystem/ManageList.do';
				break;
			}
		});
		$('.edu').click(function() {
			var edu_no = $(this).find('.eduNum').html();
			
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
					$('#edu_no').html(data.edu_no);
					$('#belong_no').html(data.belong_no);
					$('#belong_name').html(data.belong_name);
					$('#edu_name').html(data.edu_name);
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
	
	function PageMove(page){
		location.href="eduJudge.do?page="+page;
	}
	function realtimeClock() {
	  document.rtcForm.rtcInput.value = getTimeStamp();
	  setTimeout("realtimeClock()", 1000);
	}


	function getTimeStamp() { // 24시간제
	  var d = new Date();

	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}


	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
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
		height: 40;
	}
	#title tr th {
		margin: 3px;
		width: 50%;
	}
	#menu tr th {
		margin: 3px;
		width: 20%;
		height: 15%;
	}
	a {
		color: black;
		text-decoration: none;
	}
	
	#container #basic-modal #menu .edu:hover{ 
		background-color: #EAEAEA; 				/* 리스트 tr 행 마우스 오버 */
	}
	#container #basic-modal #menu .edu .status:hover{ 
		background-color: white; 				/* 리스트 tr 행 마우스 오버 */
	}
	#menu_value:hover{
		background-color: #EBF7FF;	
	}
	#title_value:hover{
		color : #3162C7;
	}
	#menu .no { width : 5%; }
	#menu .belong { width : 5%;}
	#menu .name { width : 30%;}
	#menu .code { width : 5%;}
	#menu .closing_date { width : 10%;}
	#menu .manager { width : 8%;}
	#menu .instructor_name { width : 8%;}
	code{
			font-family: 'Nanum Gothic', serif;
			font-weight: bold;
			font-size: 1.4em;
		}
	.title{
	display: block;
	text-align: center;
	color: #2fa4e7;
	}
</style>
<body onload="realtimeClock()">
<span class="title">[ 교육과정 관리 ]</span>
<div id='container'>
	<div>
		<table id="title">
			<tr>
				<th title_value="emp" id="title_value">강사 및 직원관리</th>
				<th title_value="edu" id="title_value">교육과정 관리</th>
			</tr>
		</table>
	</div>
	<div id="basic-modal">
		<table id="menu">
			<tr>
				<th menu_value="eduList" id="menu_value">교육목록</th>
				<td rowspan="4">
					<table frame="void">
						<thead>
							<tr>
								<td colspan="5" style="text-align:left; color: #033c73;">
									* 강의승인여부는 신청마감일 14일 전까지 완료해주세요
								</td>
								<td colspan="4" style="text-align: right;">
									* 총 심사현황 개수 : ${totalCount}
									<form name="rtcForm">
										<input type="text" name="rtcInput" size="17" readonly="readonly"
											style="border:none;" />
									</form>
								</td>		
							</tr>		
							<tr>
								<th class="no">교육번호</th>
								<th class="belong">소속</th>
								<th class="name">교육명</th>
								<th class="code">교육분야</th>
								<th class="schedule">교육일시</th>
								<th class="closing_date" style="padding: 0px 0px">
									<span style="color:red;">승인마감</span>
									<hr style="border:none; border:1px dashed; color:#EAEAEA; margin: 0px 0px; ">
									신청마감
								</th>
								<th class="manager">담당자</th>
								<th class="instructor_name">강사명</th>
								<th class="judgeStatus">심사현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${eduJudgeList}" var="eduList">
								<tr class="edu" name='basic'>
									<td class="eduNum">${eduList.edu_no}</td> <!-- 교육번호 -->
									<td>${eduList.belong_name}</td> <!-- 소속 -->
									<td>${eduList.edu_name}</td> <!-- 교육명  -->
									<td>${eduList.edu_code_name}</td> <!-- 교육코드 -->
									<td>${eduList.edu_schedule}</td> <!-- 교육일시 -->
									<td> <!-- 수강자 신청마감일 /승인마감일  -->
										<fmt:formatDate var="closing_date" value="${eduList.closing_date}" pattern="yyyy-MM-dd" /> 
										<span id="judge_script">
											<script>
											var date = new Date('${closing_date}');
											date.setDate (date.getDate() - 14);
											document.write("<span style='color:red;'>"+ date.toISOString().substr(0,10) + "</span>");
											</script>
										</span>
										<hr style="border:none; border:1px dashed; color:#EAEAEA; margin: 0px 0px; ">
										<span id="closing_date">${closing_date}</span>
									
									​</td> 
									<td>${eduList.manager}</td> <!-- 담당자 -->
									<td>${eduList.instructor_name}(${eduList.instructor_no})</td> <!-- 강사명 -->
									<!-- 심사현황 // 1 - 승인대기, 2 - 승인심사 3 - 승인완료 4-거절-->
									<td onclick="event.cancelBubble = true;"><!-- tr:hover효과에서 배제 -->
										<c:if test="${eduList.approval_state eq 1 and eduList.buttonFlag eq 1}">
											<button onclick="window.open('eduState.do?edu_no=${eduList.edu_no}', '심사현황 변경',
											'width=600,height=340,location=no,status=no,scrollbars=yes,resizeable=no,left=600,top=200')">
												<span>승인대기</span>
											</button>
										</c:if>
										<c:if test="${eduList.approval_state eq 2 and eduList.buttonFlag eq 1}">
											<button onclick="window.open('eduState.do?edu_no=${eduList.edu_no}', '심사현황 변경',
										'width=600,height=340,location=no,status=no,scrollbars=yes,resizeable=no,left=600,top=200')">
												<span style="color:blue">승인심사</span>
											</button>
										</c:if>
										<c:if test="${eduList.approval_state eq 4 and eduList.buttonFlag eq 1}">
											<button onclick="window.open('eduState.do?edu_no=${eduList.edu_no}', '심사현황 변경',
										'width=600,height=340,location=no,status=no,scrollbars=yes,resizeable=no,left=600,top=200')">
												<span style="color:red">승인거절</span>
											</button>
										</c:if>
										<c:if test="${eduList.buttonFlag eq 0 }">
											<span>기간마감</span>
										</c:if>
									</td> 
								</tr>
							</c:forEach>
								
						<!-- modal content -->
						<div id="basic-modal-content">
							<p><code>교육번호 : <span id="edu_no"> </span> | 
									  교육명 : <span id="edu_name"> </span>
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
							<div style="width:100%;">
								<p>소요예산 : </p>
								<pre><span id="budget"></span></pre>
								<p>비고: </p>
								<pre><span id="note"> </span></pre>
							</div>
						</div>
						<!-- preload the images -->
						<div style='display:none'>
							<img src='../img/x.png' alt='' />
						</div>	

						<tr>
							<td colspan="9" style="text-align: center">
								<!-- 페이징 -->
								<div style="margin:20px auto " align="center" >					
										<ul class="pagination" >
												<li class="page-item"><a class="page-link" href="javascript:PageMove(${paging.firstPageNo})">처음</a></li>
												<li class="page-item"><a class="page-link" href="javascript:PageMove(${paging.prevPageNo})">이전</a></li>
												<c:forEach var="i" begin="${paging.startPageNo}"
													end="${paging.endPageNo}" step="1">
													<c:choose>
														<c:when test="${i eq paging.pageNo}">
															<li class="page-item"><a class="page-link"
																href="javascript:PageMove(${i})">${i}</a></li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link"
																href="javascript:PageMove(${i})">${i}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<li class="page-item"><a class="page-link"
													href="javascript:PageMove(${paging.nextPageNo})">다음</a></li>
												<li class="page-item"><a class="page-link"
													href="javascript:PageMove(${paging.finalPageNo})">마지막</a></li>
											</ul>
								</div>
								
							</td>
						</tr>
					</tbody>
				</table>

				</td>
			</tr>
			<tr>
				<th menu_value="eduJudge" id="menu_value">교육심사</th>
			</tr>
			<tr>
				<th menu_value="regist" id="menu_value">강의 등록</th>
			</tr>
			<tr>
				<th menu_value="petition" id="menu_value">청원관리</th>
			</tr>
		</table>
	</div>
</div>
<!-- 추가 Load jQuery, SimpleModal and Basic JS files -->
<script type='text/javascript' src='../js/jquery.js'></script>
<script type='text/javascript' src='../js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='../js/basic.js'></script>
</body>