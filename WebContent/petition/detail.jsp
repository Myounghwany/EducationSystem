<%@page import="org.springframework.web.context.request.RequestScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 청원 디테일 </title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
  
function clickcheck() {
	if(!confirm("참여하시겠습니까?")){
		return;
	} else {
		location="PetitionAgree.do?petition_no=${result.petition_no}";
	}
}
</script>
</head>
<jsp:include page="../common/header.jsp"/>
<body> 
<% String agree = (String) request.getAttribute("agree");
	if (agree == "true") {
		 %>
		 <script>
		 	alert('참여는 한번만 가능합니다.');
		 </script>
		 <%
	} else if (agree == "false") {
		%>
		<script>
			alert('참여하였습니다.');
		</script>
		<%
	}
%>
<table style="width: 70%" border="1">
		<tr> 
		  <td colspan="2"> 진행상태[진행중] </td>
		</tr>
		<tr> 
		  <td colspan="2"> ${count}</td>
		</tr> 
		<tr>
		  <td> 참여인원: 00 명 </td>
		  <td><input class="inputbutton" type="button" value="청원참여" onclick="return clickcheck()"></td>
		</tr>
		<tr>
		  <th> 분류 </th>
		  <td> ${result.classification} </td>
		</tr>		
		<tr>
		  <th> 청원시작 </th> 
		  <td> ${result.write_time} </td>
		</tr>			
		<tr>
		  <th> 청원마감 </th> 
		  <td> </td>  <!-- closingdate -->
		</tr>
		<tr>
		  <th> 청원인 </th>
		  <td> ${result.writer} </td>
		</tr>
		<tr>
		  <th colspan="2"> 청원개요 </th> 
		</tr>
		<tr>
		  <td colspan="2"> ${result.content} </td>
		</tr>
		<tr>
		  <th> 첨부파일 </th>
		  <td> <a href="PetitionFileDownload.do?petition_no=${result.petition_no}">${result.file_ori_name}</a></td>
		</tr>
		<tr>
		  <th colspan="2"> <input class="inputbutton" type="button" value="목록" onclick="location='PetitionList.do'"> </th>
		</tr>
	</table>

</body>
</html>