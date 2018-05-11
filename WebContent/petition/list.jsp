<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 로그인모달 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title> 청원 리스트 </title> 
<style>
.petition_text {
	border: 3px solid #D9E5FF; 
	background-color: #EBF7FF;
	margin: 70px auto;
	padding: 20px;
	width: 70%;
}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function searchcheck(){
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

	<div class="petition_text" align="center">
		청원 기간은 30일입니다. <br>
		한번 작성된 청원은 수정및 삭제가 불가능하며  <br>
		관련되지 않은 글은 삭제될 수 있습니다. <br>
		<a href="PetitionWrite.do"> 청원하기 </a>
	</div>
	
	<div class="Petition_list">
	 <h4> 심사중인 청원 </h4>
	 
	 <table border="1" style="width: 90%;" align="center">
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
<%-- 	 	 <c:if test="${requestScope.list.approval_state == 1}"> --%>
	 	  <c:choose>
		   <c:when test="${empty requestScope.list}">
				<tr>
					<td colspan="6" align="center">현재 답변 대기중인 청원이 없습니다.</td>
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
					  <td></td> 							<!-- 참여인원${count}-->
				 	 </tr>
				</c:forEach>
		    </c:otherwise>
		  </c:choose>
<%-- 		 </c:if> --%>
	 	</tbody>
	 </table>
	 
	</div>
	
	<div class="Petition_list" style="margin-top: 50px;">
	 <h4> 청원 목록 </h4>
	 
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
					  <td></td> 							<!-- 참여인원-->
				 	 </tr>
				</c:forEach>
		    </c:otherwise>
		  </c:choose>
	 	</tbody>
	 </table>
	 
	 <div align="center">
	 
		<form action="PetitionList.do" name="searchform" onsubmit="return searchcheck()" style="margin-top: 20px;">  		<!-- 검색 -->
			<select name="src">
				<option value="0">제목</option>
				<option value="1">내용</option>
				<option value="2">제목/내용</option>
				<option value="3">글쓴이</option>
			</select> 
			<input type="text" size="17" name="search" /> <input type="submit" value="검색" />
		</form>
	  
			<c:if test="${startPage != 1}">														<!-- 페이징 -->
				<a href='PetitionList.do?page=${startPage-1}'>[ 이전 ]</a>
			</c:if>
	
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<c:if test="${pageNum == spage}">
		                ${pageNum}&nbsp;
		        </c:if>
				<c:if test="${pageNum != spage}">
					<a href='PetitionList.do?page=${pageNum}'>${pageNum}&nbsp;</a>
				</c:if>
			</c:forEach>
	
			<c:if test="${endPage != maxPage }">
				<a href='PetitionList.do?page=${endPage+1}'>[ 다음 ]</a>
			</c:if>
	
			<c:if test="${search != null}">
				<p align="center">
					<b><a href="PetitionList.do">되돌아가기</a></b>
				</p>
			</c:if>
		</div>
	 
	</div>
</body>
</html>