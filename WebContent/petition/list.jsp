<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<link href="${path}/petition/petition.css" rel="stylesheet" type="text/css">
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title> 청원  </title> 
</head>
<jsp:include page="pheader.jsp" />
<body>

	<div class="petition_text">
		청원 기간은 3개월입니다. <br>
		한번 작성된 청원은 수정및 삭제가 불가능하며  <br>
		관련되지 않은 글은 삭제될 수 있습니다. <br>
		<a href="PetitionWrite.do"> 청원하기 </a>
	</div>
	

	 <h4> 심사중인 청원 </h4>
	 
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
		   <c:when test="${empty requestScope.elist}">
				<tr>
					<td colspan="7">현재 답변 대기중인 청원이 없습니다.</td>
				</tr>
		   </c:when>
		   <c:otherwise>
				<c:forEach items="${requestScope.elist}" var="list" varStatus="state" begin="0" end="2" >
					 <tr>
					  <td> 
					  <c:choose>
					  	<c:when test="${list.approval_state == 1}" >
					  		<span> 심사중 </span>
					  	</c:when>
					  	<c:when test="${list.approval_state == 2}" >
					  		<span> 심사중/만료 </span>
					  	</c:when>
					  </c:choose>
					  </td>
		              <td>${list.petition_no}</td>
					  <td>${list.classification}</td>
					  <td><a href="PetitionDetail.do?petition_no=${list.petition_no}&list=PetitionList ">${list.title}</a></td>
					  <td>${list.writer}</td>
					  <td>${list.write_time} ~ ${list.closing_date} </td>
					  <td>${list.agree}</td> 			 
				 	 </tr>
				</c:forEach>
		    </c:otherwise>
		  </c:choose>
	 	</tbody>
	 </table>
	 
	 <p class="moreBtn"> <a href='EvaluateList.do'>[ 더보기 ]</a> </p>

	

	 <h4> 진행중인 청원 </h4>
	 
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
		   <c:when test="${empty requestScope.olist}">
				<tr>
					<td colspan="7">현재 진행중인 청원이 없습니다.</td>
				</tr>
		   </c:when>
		   <c:otherwise>
				<c:forEach items="${requestScope.olist}" var="list" varStatus="state" begin="0" end="5" >
					 <tr>
					  <td> <span>진행중</span> </td>
		              <td>${list.petition_no}</td>
					  <td>${list.classification}</td>
					  <td><a href="PetitionDetail.do?petition_no=${list.petition_no}&list=PetitionList ">${list.title}</a></td>
					  <td>${list.writer}</td>
					  <td>${list.write_time} ~ ${list.closing_date}</td>
					  <td>${list.agree}</td>				 
				 	 </tr>
				</c:forEach>
		    </c:otherwise>
		  </c:choose>
	 	</tbody>
	 </table>
	 
	 <p class="moreBtn"> <a href='OngoingList.do'>[ 더보기 ]</a> </p>
 
</body>
</html>