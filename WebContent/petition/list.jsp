<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원  </title> 
<style>
.petition_text {
	border: 3px solid #D9E5FF; 
	background-color: #EBF7FF;
	margin: 70px auto;
	padding: 20px;
	width: 70%;
}
</style>
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
	 	  <c:choose>
		   <c:when test="${empty requestScope.elist}">
				<tr>
					<td colspan="6" align="center">현재 답변 대기중인 청원이 없습니다.</td>
				</tr>
		   </c:when>
		   <c:otherwise>
				<c:forEach items="${requestScope.elist}" var="list" varStatus="state" begin="0" end="2" >
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
	 
	<div align="right" style="width:93%"> <a href='EvaluateList.do'>[ 더보기 ]</a> </div>
	
	</div>
	
	<div class="Petition_list" style="margin-top: 50px;">
	 <h4> 진행중인 청원 </h4>
	 
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
					<td colspan="6" align="center">현재 진행중인 청원이 없습니다.</td>
				</tr>
		   </c:when>
		   <c:otherwise>
				<c:forEach items="${requestScope.list}" var="list" varStatus="state" begin="0" end="5" >
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
	 
	 <div align="right" style="width:93%"> <a href='OngoingList.do'>[ 더보기 ]</a> </div>
	 
	 </div> 
	 
</body>
</html>