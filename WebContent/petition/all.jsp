<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 모든 청원 </title>
</head>
<jsp:include page="pheader.jsp" />
<body>
<div class="Petition_list" style="margin-top: 50px;">
	 <h4> 모든 청원 </h4>
	 
	 <table border="1" style="width: 90%;" align="center" >
	 	<thead>
	 		<tr>
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
					<td colspan="6" align="center">현재 작성된 청원이 없습니다.</td>
				</tr>
		   </c:when>
		   <c:otherwise>
				<c:forEach items="${requestScope.list}" var="list" varStatus="state">
					 <tr>
		              <td>${list.petition_no}</td>
					  <td>${list.classification}</td>
					  <td><a href="PetitionDetail.do?petition_no=${list.petition_no}">${list.title}</a></td>
					  <td>${list.writer}</td>
					  <td>${list.write_time} ~ </td> 		<!-- 청원기간 -->
					  <td>${list.agree}</td>		 
				 	 </tr>
				</c:forEach>
		    </c:otherwise>
		  </c:choose>
	 	</tbody>
	 </table>
	 
	 <div align="center">
	 
		<form action="AllList.do" name="searchform" onsubmit="return searchcheck()" style="margin-top: 20px;">  		<!-- 검색 -->
			<select name="src">
				<option value="0">제목</option>
				<option value="1">내용</option>
				<option value="2">제목/내용</option>
				<option value="3">글쓴이</option>
			</select> 
			<input type="text" size="17" name="search" /> <input type="submit" value="검색" />
		</form>
	  	</div>
		<!-- paging -->
		<div align="center" class="paging"  >
			<c:if test="${startPage != 1}">
				<a href='AllList.do?page=${startPage-1}' class="page_btn">이전</a>
			</c:if>
			
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<c:if test="${pageNum == spage}" >
			              <span class="page_btn">${pageNum}</span>
			          </c:if>
				<c:if test="${pageNum != spage}">
					<a href='AllList.do?page=${pageNum}' class="page_btn">${pageNum}</a>
				</c:if>
			</c:forEach>
			
			<c:if test="${endPage != maxPage }">
				<a href='AllList.do?page=${endPage+1}' class="page_btn">다음</a>
			</c:if>
		</div>
		
		<!-- 검색결과 시 없을 때 -->
		<div align="center">
			<c:if test="${search != null}">
				<input type="button" class="w3-button w3-white w3-border" value="되돌아가기" onclick="location='AllList.do'">
			</c:if>
		</div>
		
	 
	 
	</div>
</body>
</html>