<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application" />
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<jsp:include page="../common/header.jsp" />
<title>Notice List</title>
<style>
table {
	width: 80%;
}

a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
	color: #FF5E00;
}

.button {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 3px 12px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s; /* Safari */
	transition-duration: 0.4s;
	cursor: pointer;
}

.button2 {
	background-color: white;
	color: black;
	border: 2px solid #008CBA;
}

.button2:hover {
	background-color: #008CBA;
	color: white;
}

select {
	width: 70%;
	height: 50px;
}

b {
	color: orange;
	font-size: 1.3em;
}

#wrapper {
	margin-top: 5%;
}

option:hover {
	background-color: #FAF4C0;
}

th {
	background-color: #EAEAEA;
}

td, th {
	vertical-align: middle;
}

table tr td pre {
	background-color: white;
	border: none;
}

.selectDefault {
	width: 10%;
	height: 25px;
}

#writeBtn {
	float: right;
}

.title:link {
	text-decoration: none;
	color: black;
}

.title:visited {
	color: black;
	text-decoration: none;
}

table tr td .title:hover {
	text-decoration: none;
	color: #FF5E00;
}

.paging {
	font-size: 1.5em;
}

.page_btn:link {
	color: #FF5E00;
	text-decoration: none;
	margin: 0 5px;
	border: 1px;
}

.page_btn:visited {
	color: brown;
	text-decoration: none;
}

.page_btn:hover {
	text-decoration: none;
	color: aqua;
	background-color: white;
}

</style>
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
				<c:if test="${sessionScope.account eq 'hr'}">
				<button id="writeBtn" class="w3-button w3-white w3-border">작성하기</button>
				</c:if>
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