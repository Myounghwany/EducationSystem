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
				$('#pagePrev').attr('href', 'exInstList.do?pageNum='+$('#pagePrev').attr('page-value'));
			}
			
			var length = 0;
			for(var i=pageStart; i<=pageEnd; i++) {
				var id = '#pageNumber' + i;
				$(id).attr('href', 'exInstList.do?pageNum='+$(id).attr('page-value')); 
			}
			
			if(next == 1) {
				$('#pageNext').attr('href', 'exInstList.do?pageNum='+$('#pageNext').attr('page-value'));
			}
		} else {
			var srchType = $('#srchType').val();
			var srchCat = $('#srchCat').val();
			var srchWord = $('#srchWord').val();
			
			if(pageStart > 5) {
				$('#pagePrev').attr('href', 'exInstList.do?srchType=' + srchType +
						'&srchCat' + srchCat +  '&srchWord=' + srchWord +
						'&pageNum=' + $('#pagePrev').attr('page-value'));
			}
			
			var length = 0;
			for(var i=pageStart; i<=pageEnd; i++) {
				var id = '#pageNumber' + i;
				$(id).attr('href', 'exInstList.do?srchType=' + srchType +
						'&srchCat' + srchCat +  '&srchWord=' + srchWord +
						'&pageNum='+$(id).attr('page-value'));
			}
			
			if(next == 1) {
				$('#pageNext').attr('href', 'exInstList.do?srchType=' + srchType +
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
			}
		});
		$('.exInst').click(function() {
			var exInstructor_no = $(this).find('.exInstNum').html();
			location.href='exInstDetail.do?exInst_no='+exInstructor_no;
		});
		
		$('#inputExInst').click(function() {
			location.href='exInstRegist.do';
		});
	});
	
	function checkSubmit() {
		if(srchWord.value == '') {
			alert('검색어를 입력하셔야 합니다.');
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
				<td rowspan="4">
					<table>
						<thead>
							<tr>
								<th style="width: 5%;">강사번호</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(exInstList) > 0}">
									<c:forEach items="${exInstList}" var="exInstList">
										<tr class="exInst">
											<td class="exInstNum">${exInstList.instructor_no}</td>
											<td>${exInstList.name}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="text-align: center;"><b>해당하는 외부강사가 없습니다.</b></td>
									</tr>
								</c:otherwise>
							</c:choose>
							<tr>
								<td colspan="4" style="text-align: center;">
									<c:if test="${fn:length(exInstList) > 0}">
										<c:if test="${pageStart > 5}">
											<a id="pagePrev" page-value="${pageStart-1}" href="exInstList.do?pageNum=${pageStart-1}">[이전]</a>
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
											<a id="pageNext" page-value="${pageEnd+1}" href="exInstList.do?pageNum=${pageEnd+1}">[다음]</a>
										</c:if>
									</c:if>
									<br />
									<form action="exInstList.do" method="get" onsubmit="return checkSubmit();">
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
									<button id="inputExInst">외부강사 등록</button>
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
		</table>
	</div>
</body>