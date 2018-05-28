<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<title>관리자 페이지 - Education System</title>
<jsp:include page="../common/header.jsp" />
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$('document').ready(function() {
		
		var pageStart = ${pageStart};
		var pageEnd = ${pageEnd};
		var next = ${next};
		
		if($('#srchType').val() == 'nothing' && $('#srchWord').val() == '') {
			if(pageStart > 5) {
				$('#pagePrev').attr('href', 'instList.do?pageNum='+$('#pagePrev').attr('page-value'));
			}
			
			var length = 0;
			for(var i=pageStart; i<=pageEnd; i++) {
				var id = '#pageNumber' + i;
				$(id).attr('href', 'instList.do?pageNum='+$(id).attr('page-value')); 
			}
			
			if(next == 1) {
				$('#pageNext').attr('href', 'instList.do?pageNum='+$('#pageNext').attr('page-value'));
			}
		} else {
			var srchType = $('#srchType').val();
			var srchCat = $('#srchCat').val();
			var srchWord = $('#srchWord').val();
			
			if(pageStart > 5) {
				$('#pagePrev').attr('href', 'instList.do?srchType=' + srchType +
						'&srchCat' + srchCat +  '&srchWord=' + srchWord +
						'&pageNum=' + $('#pagePrev').attr('page-value'));
			}
			
			var length = 0;
			for(var i=pageStart; i<=pageEnd; i++) {
				var id = '#pageNumber' + i;
				$(id).attr('href', 'instList.do?srchType=' + srchType +
						'&srchCat' + srchCat +  '&srchWord=' + srchWord +
						'&pageNum='+$(id).attr('page-value'));
			}
			
			if(next == 1) {
				$('#pageNext').attr('href', 'instList.do?srchType=' + srchType +
						'&srchCat' + srchCat +  '&srchWord=' + srchWord +
						'&pageNum=' + $('#pagePrev').attr('page-value'));		
			}
		}
		
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
		$('.inst').click(function() {
			var instructor_no = $(this).find('.instNum').html();
			location.href='instDetail.do?inst_no='+instructor_no;
		});
	});
	
	function checkSubmit() {
		if(srchType.value == 'nothing' && srchWord.value == '') {
			alert('검색조건을 갖춰주세요.\n부서, 구분을 선택하거나 검색어 입력중 하나라도 해야 합니다.');
			return false;
		} else {
			return true;			
		}
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
						<thead>
							<tr>
								<th>강사번호</th>
								<th>분류</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(instList) > 0}">
									<c:forEach items="${instList}" var="instList">
										<tr class="inst">
											<td class="instNum">${instList.instructor_no}</td>
											<td>
												<c:choose>
													<c:when test="${null == instList.emp_no}">
														외부 강사
													</c:when>
													<c:otherwise>
														내부 강사
													</c:otherwise>
												</c:choose>
											</td>
											<td>${instList.name}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="text-align: center;"><b>해당하는 강사가 없습니다.</b></td>
									</tr>
								</c:otherwise>
							</c:choose>
							<tr>
								<td colspan="4" style="text-align: center;">
									<c:if test="${fn:length(instList) > 0}">
										<c:if test="${pageStart > 5}">
											<a id="pagePrev" page-value="${pageStart-1}" href="instList.do?pageNum=${pageStart-1}">[이전]</a>
											&nbsp;|
										</c:if>
										<c:forEach begin="${pageStart}" end="${pageEnd}" var="page">
											&nbsp;<a id="pageNumber${page}" page-value="${page}">${page}</a>
											<c:if test="${page != pageEnd}">
												&nbsp;|
											</c:if>
										</c:forEach>
										<c:if test="${next == 1}">
											&nbsp;|&nbsp;
											<a id="pageNext" page-value="${pageEnd+1}" href="instList.do?pageNum=${pageEnd+1}">[다음]</a>
										</c:if>
									</c:if>
									<br />
									<form action="instList.do" method="get" onsubmit="return checkSubmit();">
										<select name="srchType" id="srchType">
											<c:if test="${'nothing' == srchType}">
												<option value="nothing" selected="selected">---구분---</option>
											</c:if>
											<c:if test="${'nothing' != srchType}">
												<option value="nothing">---구분---</option>
											</c:if>
											<c:choose>
												<c:when test="${'internal' == srchType}">
													<option value="internal" selected="selected">내부강사</option>
													<option value="external">외부강사</option>
												</c:when>
												<c:when test="${'external' == srchType}">
													<option value="internal">내부강사</option>
													<option value="external" selected="selected">외부강사</option>
												</c:when>
												<c:otherwise>
													<option value="internal">내부강사</option>
													<option value="external">외부강사</option>													
												</c:otherwise>
											</c:choose>
										</select>
										<select name="srchCat" id="srchCat">
											<c:choose>
												<c:when test="${'number' == srchCat}">
													<option value="number" selected="selected">강사번호</option>
													<option value="name">이름</option>
												</c:when>
												<c:when test="${'name' == srchCat}">
													<option value="number">강사번호</option>
													<option value="name" selected="selected">이름</option>
												</c:when>
												<c:otherwise>
													<option value="number">강사번호</option>
													<option value="name">이름</option>
												</c:otherwise>
											</c:choose>
										</select>
										<input type="text" name="srchWord" id="srchWord" value="${srchWord}" style="width: 110px;"/>
										<input type="submit" id="srch" value="검색"/>
									</form>
								</td>
							</tr>
						</tbody>
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