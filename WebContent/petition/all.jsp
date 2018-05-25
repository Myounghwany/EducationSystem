<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<link href="${path}/petition/petition.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 모든 청원 </title>
<script>
function searchClick(){
	if(searchform[1].value ==""){
		alert("검색어를 입력해주세요");
		return false;
	} 
	return true;
}
</script>
</head>
<jsp:include page="pheader.jsp" />
<body>

	 <h4> 모든 청원 </h4>
	 
	 <table>
	 	<thead>
	 		<tr>
	 			<th> 상태 </th>
	 			<th> 번호 </th>
	 			<th> 분류 </th>
	 			<th> 제목 </th>
	 			<th> 청원인 </th>
	 			<th> 청원기간 </th>
	 			<th> 참여인원 </th>
	 		</tr>
	 	</thead>
	 	<tbody>
	 	  <c:choose>
		   <c:when test="${empty requestScope.list}">
				<tr>
					<td colspan="7">현재 작성된 청원이 없습니다.</td>
				</tr>
		   </c:when>
		   <c:otherwise>
				<c:forEach items="${requestScope.list}" var="list" varStatus="state">
					 <tr>
					 <td> 
					  <c:choose>
					  	<c:when test="${list.approval_state == 0 }" >
					  		<span> 진행중 </span>
					  	</c:when>
					  	<c:when test="${list.approval_state == 1 }" >
					  		<span> 심사중 </span>
					  	</c:when>
					  	<c:when test="${list.approval_state == 2 }" >
					  		<span> 심사중/만료 </span>
					  	</c:when>
					  	<c:when test="${list.approval_state == 3 }" >
					  		<span> 채택 </span>
					  	</c:when>
					  	<c:when test="${list.approval_state == 4 }" >
					  		<span> 거부 </span>
					  	</c:when>
					  	<c:when test="${list.approval_state == 5 }" >
					  		<span> 기간만료 </span>
					  	</c:when>
					  </c:choose>
					  </td>
		              <td>${list.petition_no}</td>
					  <td>${list.classification}</td>
					  <td><a href="PetitionDetail.do?petition_no=${list.petition_no}&list=AllList">${list.title}</a></td>
					  <td>${list.writer}</td>
					  <td> ${list.write_time} ~  ${list.closing_date} </td>
					  <td>${list.agree}</td>		 
				 	 </tr>
				</c:forEach>
		    </c:otherwise>
		  </c:choose>
	 	</tbody>
	 </table>
	 
	<div class="srcform">
	 
		<form action="AllList.do" name="searchform" onsubmit="return searchClick()">  		<!-- 검색 -->
		<select name="src">
				<option value="0" <c:if test="${src eq '0'}">selected</c:if>>제목</option>
				<option value="1" <c:if test="${src eq '1'}">selected</c:if>>내용</option>
				<option value="2" <c:if test="${src eq '2'}">selected</c:if>>제목/내용</option>
				<option value="3" <c:if test="${src eq '3'}">selected</c:if>>글쓴이</option>
			</select> 
			<input type="text" size="17" name="search" value="${search}"/> <input type="submit" value="검색" />
		</form>
									 														<!-- 페이징 -->
			<c:if test="${startPage != 1}">
				<a href='AllList.do?page=${startPage-1}&src=${src}&search=${search}'> 이전 </a>
			</c:if>
			
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<c:if test="${pageNum == spage}" >
			              <span> ${pageNum} </span>
			          </c:if>
				<c:if test="${pageNum != spage}">
					<a href='AllList.do?page=${pageNum}&src=${src}&search=${search}'> ${pageNum} </a>
				</c:if>
			</c:forEach>
			
			<c:if test="${endPage != maxPage }">
				<a href='AllList.do?page=${endPage+1}&src=${src}&search=${search}'> 다음 </a>
			</c:if>
 																						   <!-- 검색결과 x -->
			<c:if test="${search != null}">
				<input type="button" value="되돌아가기" onclick="location='AllList.do'">
			</c:if>
	 </div>

</body>
</html>