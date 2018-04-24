<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<jsp:include page="../common/header.jsp" />
<title>교육목록/신청</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script>

$(document).ready(function() {
                 
    
});


function listBtn(no){
	alert(no);	
	document.getElementById('id01').style.display='block';
	
}


</script>
<style>
	table {
		color: black;
		width: 80%;
		margin-top : 2%;
		text-align: center;
		border-color: #BDBDBD;
	}
	th {
		background-color: #EAEAEA;
		text-align: center;
		height: 50px;
	}
	td {
		height: 30px;
		background-color: #FDFFFF;
	}
	a:hover {
		color : #FF5E00;
		text-decoration: none;
		font-weight: bold;
	}
	</style>
<body>
<h2>교육목록/신청</h2>
	<br>
	<table align="center" border="1" id="title">
		<tr>
			<th>교육코드</th>
			<th>소속번호</th>
			<th>교육분야</th>
			<th>교육대상</th>
			<th>담당자</th>
			<th>교육일정</th>
			<th>강사명</th>
			<th>교육인원</th>
			<th>마감일</th>
			<th>교육신청</th>
		</tr>
		<c:choose>
			<c:when test="${empty list}">
				<tr>
					<td>수강내역이 존재하지 않습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list}" var="edulist" varStatus="state">
					<tr>
						<td id="ed_no" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_no}</td>
						<td id="be_no" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.belong_no}</td>
						<td id="ed_field" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_field}</td>
						<td id="ed_target" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_target}</td>
						<td id="ma" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.manager}</td>
						<td id="ed_schedule" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_schedule}</td>
						<td id="in_name" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.instructor_name}</td>
						<td id="ap_limit" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.applicants_limit}</td>
						<td id="closing" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.closing_date}</td>
						<td><input type="button" value="교육신청" onclick="listBtn(${edulist.edu_no})"></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	
	
<!-- modal -->  
  <div id="id01" class="w3-modal">
    <div class="w3-modal-content" style="width: 400px; height: 400px;">
      <header class="w3-container w3-teal"> 
        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
        <h1>교육신청</h1>
      </header>
      <div class="w3-container">
        <p>선택한 교육과정</p>
        <div id="modalId"></div>
        
        
        <table border="1">
        	<tr>
        		<td>소속명</td><td><span id="belong_name"> </span></td> 
        	</tr>
        	<tr>
        		<td>교육분야</td><td><span id="edu_field" ></span></td> 
        	</tr>
        	<tr>
        		<td>교육명</td><td><span id="edu_name" ></span></td> 
        	</tr>
        	<tr>
        		<td>교육일정</td><td><span id="edu_schedule" ></span></td> 
        	</tr>
        	<tr>
        		<td>강사명</td><td><span id="instructor_name" ></span></td> 
        	</tr>
        </table><br/>
        <span>신청하시겠습니까?</span><br>

        <button id="applicationBtn">신청</button>
        <br>
      </div>
    </div>
  </div>
  
  
	
	
</body>
</body>