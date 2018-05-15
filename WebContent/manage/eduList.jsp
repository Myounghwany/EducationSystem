<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>관리자 페이지 - Education System</title>
<jsp:include page="../common/header.jsp" />
<!-- 추가 Page styles -->
<link type='text/css' href='../css/demo.css' rel='stylesheet' media='screen' />
<!-- 추가 Contact Form CSS files -->
<link type='text/css' href='../css/basic.css' rel='stylesheet' media='screen' />
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

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
			case 'eduAudit':
				location.href='eduAudit.do';
				break;
			case 'regist':
				location.href='regist.do';
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
					$('#edu_name').html(data.edu_name);
					$('#edu_schedule').html(data.edu_schedule);
					$('#budget').html(data.budget);
					$('#closing_date').html(data.closing_date);
					$('#edu_code').html(data.edu_code);
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
	
	function checkSubmit() {
		if(srchWord.value == '') {
			alert('검색어를 입력해주세요.');
			return false;
		}
		var dept = $('#srchDept').val();
		var pos = $('#srchPos').val();
		var cat = $('#srchCat').val();
		var word = $('#srchWord').val();
		location.href='empList.do?';
		return true;		
	}
	
	function PageMove(page){
		location.href="eduList.do?page="+page;
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
		height: 25%;
	}
	a {
		color: black;
		text-decoration: none;
	}
	
	#container #basic-modal #menu .edu:hover{ 
		background-color: #EAEAEA; 				/* 리스트 tr 행 마우스 오버 */
	}
	#menu .no { width : 8%;}
	#menu .belong { width : 8%;}
	#menu .name { width : 30%;}
	#menu .code { width : 10%;}
	#menu .manager { width : 10%;}

</style>
<body>
<h2>교육과정 관리</h2>
<div id='container'>
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
				<th menu_value="eduList">교육목록</th>
				<td rowspan="4">
					<table frame="void">
						<thead>
							<tr>
								<th class="no">교육번호</th>
								<th class="belong">소속</th>
								<th class="name">교육명</th>
								<th class="code">교육분야</th>
								<th>교육일시</th>
								<th class="manager">담당자</th>
								<th>강사명</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${eduList}" var="eduList">
								<tr class="edu" name='basic'>
									<td class="eduNum">${eduList.edu_no}</td> <!-- 교육명 -->
									<td>${eduList.belong_name}</td> <!-- 소속 -->
									<td>${eduList.edu_name}</td> <!-- 교육명  -->
									<td>${eduList.edu_code_name}</td> <!-- 교육코드 -->
									<td>${eduList.edu_schedule}</td> <!-- 교육일시 -->
									<td>${eduList.manager}</td> <!-- 담당자 -->
									<td>${eduList.instructor_name}</td> <!-- 강사명 -->
								</tr>
							</c:forEach>
								
						<!-- modal content -->
						<div id="basic-modal-content">
							<p><code>교육번호 : <span id="edu_no"> </span> | 
									  교육명 : <span id="edu_name"> </span>
								</code>
								<button id="updateEduList" style="float:right;">수정 </button>
							</p>
							<h5>소속번호 : <span id="belong_no"> </span></h5>
							<h5>교육코드 : <span id="edu_code"> </span></h5>
							<h5>교육코드명 : <span id="edu_code_name"> </span></h5>
							<h5>교육일정 : <span id="edu_schedule"> </span></h5>
							<h5>신청마감일 : <span id="closing_date"> </span></h5>
							<h5>교육일정 : <span id="edu_schedule"> </span></h5>
							<h5>교육일시 : <span id="edu_date"> </span></h5>
							<h5>교육뷴야 : <span id="edu_feild"> </span></h5>
							<h5>교육장소 : <span id="edu_location"> </span></h5>
							<h5>교육대상 : <span id="edu_target"> </span></h5>
							<h5>교육방법 : <span id="edu_way"> </span></h5>
							<h5>강사이름 : <span id="instructor_name"> </span></h5>
							<h5>강사번호 : <span id="instructor_no"> </span></h5>
							<h5>담당자 : <span id="manager"> </span></h5>
							<h5>소요예산 : <span id="budget"> </span></h5>
							<p>비고: <span id="note"> </span></p>
						
						</div>
						<!-- preload the images -->
						<div style='display:none'>
							<img src='../img/x.png' alt='' />
						</div>	
							
						<tr>
							<td colspan="7" style="text-align: center">
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
								
								
								<!-- 검색 -->
								<form action="eduList.do" method="post" onsubmit="checkSubmit()">
								<select name="srchDept" id="srchDept">
									<option value="nothing">---소속---</option>
									<c:forEach items="${deptList}" var="deptList">
										<option value="${deptList.dept_no}">${deptList.dept_name}</option>
									</c:forEach>
								</select>
								<select name="srchPos" id="srchPos">
									<option value="nothing">---교육분야--</option>
									<c:forEach items="${posList}" var="posList">
										<option value="${posList.position_no}">${posList.position_name}</option>
									</c:forEach>
								</select>
								<select name="srchCat" id="srchCat">
									<option value="number">담당자</option>
									<option value="name">강사명</option>
								</select>
								<input type="text" id="srchWord" style="width: 110px;"/>
								<input id="srch" type="submit" value="검색"/>
								</form>
							</td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr>
				<th menu_value="eduAudit">교육심사</th>
			</tr>
			<tr>
				<th menu_value="regist">강의 등록</th>
			</tr>
		</table>
	</div>
</div>
<!-- 추가 Load jQuery, SimpleModal and Basic JS files -->
<script type='text/javascript' src='../js/jquery.js'></script>
<script type='text/javascript' src='../js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='../js/basic.js'></script>
</body>