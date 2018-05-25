<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"
	scope="application" />
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
#h2 {
	text-align: center;
}
</style>
<title>Notice Page</title>
<body>
	<div>
		<h2>공 지 사 항</h2>
		<hr>

		<table width="100%">


			<tr>
				<th align="center" style="width: 10%;">번호</th>
				<th align="center">제목</th>
				<th align="center" style="width: 15%;">작성자</th>
				<th align="center" style="width: 15%;">등록일</th>
				<th align="center" style="width: 10%;">조회수</th>

			</tr>


			<c:choose>
				<c:when test="${empty requestScope.list }">
					<tr>
						<td align="center" colspan="6">공지사항에 저장된 글이 없습니다. 글쓰기를 눌러 주세요
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${requestScope.list}" var="result">
						<tr>
							<td align="center">${result.notice_no }</td>
							<td align="center"><a href="detailView.do?no=${result.notice_no}">
									${result.title }</a></td>
							<td align="center">${result.writer }</td>
							<td align="center">${result.write_time }</td>
							<td align="center">${result.hit }</td>

						</tr>
					</c:forEach>
				</c:otherwise>
	
			</c:choose>
			<tr>
				<th align="center" colspan="6"><a href="writeForm.do">글쓰기</a></th>
			</tr>
			<tr>
				<td colspan="6" align="center">
					<form action="search.do">
						<select name="searchName" size="1">
							<option value="all">전체</option>
							<option value="writer">작성자</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select> <input type="text" name="searchValue"> <input
							type="submit" value="검색">
					</form>
				</td>
			</tr>


		</table>
	</div>
</body>