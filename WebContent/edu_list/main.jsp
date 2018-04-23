<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<jsp:include page="../common/header.jsp" />
<head>

<title>수강목록 페이지</title>
<style>
	table {
		color: black;
		width: 80%;
		margin-top : 2%;
		text-align: center;
		border-color: #BDBDBD;
	}
	th {
		background-color: #EAEAEA;
		text-align: center;
		height: 50px;
	}
	td {
		height: 30px;
		background-color: #FDFFFF;
	}
	a:hover {
		color : #FF5E00;
		text-decoration: none;
		font-weight: bold;
	}
	</style>
</head>

<body>
	<h2>수강목록 페이지</h2>
	<br>
	<table align="center" border="1">
		<tr>
			<th>교육명</th>
			<th>강사명</th>
			<th>교육일</th>
			<th>이수여부</th>
			<th>강의평가</th>
		</tr>
		<c:choose>
			<c:when test="${empty edu_list}">
				<tr>
					<td>수강내역이 존재하지 않습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${edu_list}" var="edulist" varStatus="state">
					<tr>
						<td><a href="edulist/detail.do?edu_no=${edulist.edu_no}">${edulist.edu_name}</a></td>
						<td>${edulist.instructor_no}</td>
						<td>${edulist.edu_schedule}</td>
						<td>${edulist.edu_state}</td>
						<td>
						<c:if test="${empty edulist.emp_eval}">
								<a data-toggle="modal" href="#myModal">강의평가
									<input type="hidden" name="edu_no" value="${edulist.edu_no}">
								</a>
						</c:if> 
						<c:if test="${!empty edulist.emp_eval}">
								<!-- 직원이 강사에 대한 평가를 완료했다면 -->평가완료
						</c:if>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<!-- 모달 팝업 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<span class="modal-title" id="myModalLabel">강의평가하기</span>
				</div>
				
				<form id="loginForm" name="loginForm" class="form-signin" method="post" action="${path}/user/login">
					<div class="modal-body">
					
					교육명 : ${edu_no} <br>
					강사명 : 	<br>
					교육일 : 	<br>
					강의평가 : <input type="text" name="text" width="500px" height="500px">
					
				
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Save changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://googledrive.com/host/0B-QKv6rUoIcGREtrRTljTlQ3OTg"></script>
<!-- ie10-viewport-bug-workaround.js -->
<script src="http://googledrive.com/host/0B-QKv6rUoIcGeHd6VV9JczlHUjg"></script>
<!-- holder.js -->