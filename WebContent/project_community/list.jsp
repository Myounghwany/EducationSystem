<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Project Community List</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){

	
	$('#resultTransfer').css('display',"none");
	
	$('#writeBtn').click(function(){
		location="ProjectWrite.do";
	});	
		
	});
	
function searchCheck(){
	if(searchform[1].value ==""){
		alert("검색어를 입력해주세요");
		return false;
	}
	
	return true;
}	
</script>
</head>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Project Community List</h1>

<form action="ProjectList.do" name="searchform" onsubmit="return searchCheck()">
	<select name="opt">
		<option value="0">제목</option>
		<option value="1">내용</option>
		<option value="2">제목+내용</option>
		<option value="3">글쓴이</option>
	</select> 
	<input type="text" size="20" name="condition" />&nbsp; <input	type="submit" value="검색" />
</form>



<table border="1" align="center">
	<tr>
		<td width="7%">글번호</td>
		<td width="7%">분류</td>
		<td width="30%">제목</td>
		<td width="15%">작성자</td>
		<td width="10%">작성시간</td>
		<td width="10%">조회수</td>
	</tr>
	<c:choose>
		<c:when test="${empty requestScope.list}">
		<tr>
			<td colspan="7" align="center">등록된 글이 없습니다.</td>
		</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${requestScope.list}" var="list" varStatus="state">
				<tr>
					<td>${list.project_no}</td>
					<td>${list.classification}</td>
					<td><a href="ProjectDetail.do?project_no=${list.project_no}">${list.title}</a></td>
					<td>${list.writer}</td>
					<td>${list.write_time}</td>
					<td>${list.hit}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<br>
<button id="writeBtn">작성하기</button>

<div align="center">
	<c:if test="${startPage != 1}">
		<a href='ProjectList.do?page=${startPage-1}'>[ 이전 ]</a>
	</c:if>

	<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
		<c:if test="${pageNum == spage}">
                ${pageNum}&nbsp;
            </c:if>
		<c:if test="${pageNum != spage}">
			<a href='ProjectList.do?page=${pageNum}'>${pageNum}&nbsp;</a>
		</c:if>
	</c:forEach>

	<c:if test="${endPage != maxPage }">
		<a href='ProjectList.do?page=${endPage+1 }'>[다음]</a>
	</c:if>

<c:if test="${condition != null}">
	<p align="center">
		<b><a href="ProjectList.do">되돌아가기</a></b>
	</p>
</c:if>

</div>

</body>
</html>