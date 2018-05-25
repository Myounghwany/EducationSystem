<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<link href="${path}/petition/petition.css" rel="stylesheet" type="text/css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원 </title>
<script>
  
function clickcheck() {
	if(!confirm("참여하시겠습니까?")){
		return;
	} else {
		location="PetitionAgree.do?petition_no=${result.petition_no}&list=${list}";
	}
}

function deletecheck() {
	if(!confirm("정말 삭제 하시겠습니까?")){
		return;
	} else {
		location="PetitionDelete.do?petition_no=${result.petition_no}";
	}
}
</script>
</head>

<jsp:include page="pheader.jsp" />

<body> 

 

<table>
		<tr> 
		  <th colspan="2"> 진행상태: 
					  <c:choose>
					  	<c:when test="${result.approval_state == 0}" >
					  		<span> 진행중 </span>
					  	</c:when>
					  	<c:when test="${result.approval_state == 1}" >
					  		<span> 심사중 </span>
					  	</c:when>
					  	<c:when test="${result.approval_state == 2}" >
					  		<span> 심사중/만료 </span>
					  	</c:when>
					  	<c:when test="${result.approval_state == 3}" >
					  		<span> 채택 </span>
					  	</c:when>
					  	<c:when test="${result.approval_state == 4}" >
					  		<span> 거부 </span>
					  	</c:when>
					  	<c:when test="${result.approval_state == 5}" >
					  		<span> 기간만료 </span>
					  	</c:when>
					  </c:choose>
		  </th>
		</tr>  
		<tr>
		  <td colspan="2"> 청원제목 </td> 
		</tr>
		<tr>
		  <th colspan="2"> ${result.title} </th>
		</tr>
		<tr>
		  <td> 참여인원: ${result.agree} 명 </td>
		  <td><input class="inputbutton" type="button" value="청원참여" onclick="return clickcheck()"></td>
		</tr>
		<tr>
		  <td> 분류 </td>
		  <td> ${result.classification} </td>
		</tr>		
		<tr>
		  <td> 청원시작 </td> 
		  <td> ${result.write_time} </td>
		</tr>			
		<tr>
		  <td> 청원마감 </td> 
		  <td> ${result.closing_date} </td>
		</tr>
		<tr>
		  <th> 청원인 </th>
		  <th> ${result.writer} </th>
		</tr>
		<tr>
		  <td colspan="2"> 청원개요 </td> 
		</tr>
		<tr height="250px">
		  <th colspan="2"> ${content} </th>
		</tr>
		<c:if test="${result.approval_state == 3 || result.approval_state == 4}"> 
		<tr>
		  <td colspan="2"> 답변 </td> 
		</tr>
		<tr>
		  <th colspan="2"> ${result.comment} </th>
		</tr>
		</c:if>
		<tr>
		  <td> 첨부파일 </td>
		  <td> <a href="PetitionFileDownload.do?petition_no=${result.petition_no}">${result.file_ori_name}</a></td>
		</tr>
		<tr>
		  <td colspan="2"> 
		  <c:if test=""> 
		  <input class="inputbutton" type="button" value="삭제" onclick="return deletecheck()"> 
		  </c:if>
		  <input class="inputbutton" type="button" value="목록" onclick="location='${list}.do'">
		  </td>
		</tr>
	</table>

</body>
</html>