<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- table css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 나현 로그인모달 & 드롭다운-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Project Community List</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {

		$('#resultTransfer').css('display', "none");

		$('#writeBtn').click(function() {
			location = "ProjectCommunity/write.do";
		});

	});

	function searchCheck() {
	
	if (searchform[1].value == "") {
			alert("검색어를 입력해주세요");
			return false;
		}
		return true;
	}
</script>
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">

</head>
<jsp:include page="../common/header.jsp" />
<body>
	<h1>Project Community List</h1>

	<div align="center">
		<c:if test="${startPage != 1}">
			<a href='ProjectCommunity.do?page=${startPage-1}'>[ 이전 ]</a>
		</c:if>
		<div style="width: 80%; margin: 20px auto">
			<!-- 검색 기능 -->
			<form action="ProjectCommunity.do" name="searchform" onsubmit="return searchCheck()">
				<select name="opt" class="selectDefault">
					<option value="0">제목</option>
					<option value="1">내용</option>
					<option value="2">제목+내용</option>
					<option value="3">글쓴이</option>
				</select> 
				<input type="text" size="20" name="condition" />&nbsp; 
				<input type="submit" value="검색" />
			</form>
		
			<button id="writeBtn" class="w3-button w3-white w3-border">작성하기</button>
			<!-- 프로젝트 공유 리스트 -->
			<table class="w3-table w3-bordered">
				<tr>
					<th width="7%">글번호</th>
					<th width="7%">분류</th>
					<th width="30%">제목</th>
					<th width="10%">작성자</th>
					<th width="15%">작성시간</th>
					<th width="10%">조회수</th>
				</tr>
				<c:choose>
					<c:when test="${empty requestScope.list}">
						<tr>
							<td colspan="7">등록된 글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${requestScope.list}" var="list" varStatus="state">
							<tr>
								<td>${listCount - (spage)*10 - state.count + 11}</td>
								<td>${list.classification}</td>
								<td><a href="ProjectCommunity/detail.do?project_no=${list.project_no}" 
									 	class="title" >${list.title}</a></td>
								<td>${list.writer_name}(${list.writer})</td>
								<td>${list.write_time}</td>
								<td>${list.hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<!-- paging -->
		<div align="center" class="paging">
			<c:if test="${startPage != 1}">
				<a href='ProjectCommunity.do?page=${startPage-1}' class="page_btn">이전</a>
			</c:if>
			
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<c:if test="${pageNum == spage}" >
			              <span class="page_btn">${pageNum}</span>
			          </c:if>
				<c:if test="${pageNum != spage}">
					<a href='ProjectCommunity.do?page=${pageNum}' class="page_btn">${pageNum}</a>
				</c:if>
			</c:forEach>
			
			<c:if test="${endPage != maxPage }">
				<a href='ProjectCommunity.do?page=${endPage+1}' class="page_btn">다음</a>
			</c:if>
		</div>
		
		<!-- 검색결과 시 없을 때 -->
		<div align="center">
			<c:if test="${condition != null}">
				<input type="button" class="w3-button w3-white w3-border" value="되돌아가기" onclick="location='ProjectCommunity.do'">
			</c:if>
		</div>
	</div>
</body>
</html>