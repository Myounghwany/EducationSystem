<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<jsp:include page="../common/header.jsp" />
<title>Notice List</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	$(document).ready(function() {

		$('#resultTransfer').css('display', "none");

		$('#writeBtn').click(function() {
			location = "notice/write.do";
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
</head>

<body>
	<h1>Notice List</h1>

	<div align="center">
		
			

			<table class="w3-table w3-bordered">
				<tr>
					<th width="7%">번호</th>
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
								<td><a href="notice/detail.do?notice_no=${list.notice_no}" 
									 	class="title" >${list.title}</a></td>
								<td>${list.writer_name}(${list.writer})</td>
								<td>${list.write_time}</td>
								<td>${list.hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<tr>
				<button id="writeBtn" class="w3-button w3-white w3-border">작성하기</button>
				</tr>
			</table>
		</div>
		
		<!-- paging -->
		<div align="center" class="paging">
					<form action="notice.do" name="searchform" onsubmit="return searchCheck()">
				<select name="opt" class="selectDefault">
					<option value="0">제목</option>
					<option value="1">내용</option>
					<option value="2">제목+내용</option>
					<option value="3">글쓴이</option>
				</select> 
				<input type="text" size="10" name="condition" />&nbsp; 
				<input type="submit" value="검색" />
			</form>
			<c:if test="${startPage != 1}">
				<a href='notice.do?page=${startPage-1}' class="page_btn">이전</a>
			</c:if>
			
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<c:if test="${pageNum == spage}" >
			              <span class="page_btn">${pageNum}</span>
			          </c:if>
				<c:if test="${pageNum != spage}">
					<a href='notice.do?page=${pageNum}' class="page_btn">${pageNum}</a>
				</c:if>
			</c:forEach>
			
			<c:if test="${endPage != maxPage }">
				<a href='notice.do?page=${endPage+1}' class="page_btn">다음</a>
			</c:if>
		</div>


	
</body>
</html>