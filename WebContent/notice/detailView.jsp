<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:include page="../common/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<title>글 상세보기</title>


</head>

<body>
	<h2>글 상세보기</h2>
	<hr>
	<div style="text-align: center">
		
		<table>
			<tr>
				<th>번호</th>
				<td style="text-align: center">${noticeDto.no }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td style="text-align: center">${noticeDto.hit }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td style="text-align: center">${noticeDto.name }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td style="text-align: center">${noticeDto.write_time }</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td colspan="3">${noticeDto.title }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><pre>${noticeDto.content }</pre></td>
			</tr>
			<tr>
				<th colspan="4"><input class="inputbutton" type="button"
					value="글수정" onclick="location='modifyForm.do?notice_no=${noticeDto.notice_no}'">
					<input class="inputbutton" type="button" value="글삭제"
					onclick="location='deleteForm.do?notice_no=${noticeDto.notice_no}'"> <input
					class="inputbutton" type="button" value="답글쓰기"
					onclick="location='writeForm.do'"> <input
					class="inputbutton" type="button" value="목록보기"
					onclick="location='notice.do'"></th>
			</tr>
		</table>
	</div>

</body>
</html>
