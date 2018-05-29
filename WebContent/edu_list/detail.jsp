<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../common/header.jsp" />
<title>edulist_detail Page</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    
	
	if($('#edu_target').text() !=""){
		
	
	var edu_target = ${eduTarget};  
	var str = JSON.stringify(edu_target);
	var newArr = JSON.parse(str);
	var target ="";
	
	for(var i=0; newArr.length > i ;i++){
		target += newArr[i].belong_name+' , '+newArr[i].dept_name+' , '+newArr[i].position_name;
	}
	
	
	$('#edu_target').html(target);
	}
	

	$('#applicationBtn').click(function(){
		var edu_no = $('#edu_no').val();
		
		$.ajax({
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			url : '${path}/EducationList/application.do',
			type : 'get',
			data : {
				edu_no : edu_no
			},
			dataType:"text",  
			success : function(data){
				if(data != 0){
					alert("신청이 정상적으로 되었습니다.");
				}else{
					alert("신청 불가");
				}
				
			},
			error : function(request,status,error){
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});
				location.href="${path}/EducationList/detail.do?edu_no="+edu_no;

	});

	$('#deleteBtn').click(function(){
		var edu_no = $('#edu_no').val();
		
		if(confirm("정말 취소 하시겠습니까?")){

			$.ajax({
				contentType : 'application/x-www-form-urlencoded; charset=utf-8',
				url : '${path}/EducationList/applicationDelete.do',
				type : 'get',
				data : {
					edu_no : edu_no
				},
				dataType:"text",  
				success : function(data){
					alert('취소되었습니다.');
				},
				error : function(request,status,error){
					console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				}
			});
			
			location.href="${path}/EducationList/detail.do?edu_no="+edu_no;
		}
	
	
	});
	
	
});
	
</script>
<style type="text/css">
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
</head>
<body>
	<h2>교육목록 해당 교육명 상세페이지</h2>
	<div align="center" id="wrapper">
		
		<c:set var="check" value="0"/>
		<c:forEach items="${apCheck}" var="apCheck" varStatus="state">
			
			<c:choose>
			<c:when test="${apCheck eq detail.edu_no}">
				<c:set var="check" value="${check +1}" />
			</c:when>
			<c:otherwise>
			
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
		
		<c:if test="${check eq 0 and applicants < detail.applicants_limit }">
			<button id="applicationBtn">교육신청</button>
		</c:if>
		<c:if test="${check ne 0 }">
			<span>신청완료<button id="deleteBtn">신청취소</button></span>
		</c:if>
		<c:if test="${applicants >= detail.applicants_limit }">
			<span style="color:red;"><br>인원 마감</span>
		</c:if>
		
		
		<table width="70%" border="1">
			<tr>
				<td width="10%">소속</td>
				<td width="30%"><b>${detail.belong_name}</b></td>
				<td width="10%">교육분야</td>
				<td width="30%">${detail.edu_field}</td>
			</tr>
			<tr>
				<td>교육명</td>
				<td>${detail.edu_name}</td>
				<td>필수교육대상</td>
				<td id="edu_target">${detail.edu_target}</td>
			</tr>
			<tr>
				<td>교육방법</td>
				<td>${detail.edu_way}</td>
				<td>담당자</td>
				<td>${detail.edu_way}</td>
			</tr>
			<tr>
				<td>교육일정</td>
				<td>${detail.edu_schedule}</td>
				<td>교육일시</td>
				<td>${detail.edu_date}</td>
			</tr>
			<tr>
				<td>교육장소</td>
				<td>${detail.edu_location}</td>
				<td>강사</td>
				<td>${detail.instructor_name}</td>
			</tr>
			<tr>
				<td>소요예산</td>
				<td>${detail.budget}</td>
				<td>신청자 수</td>
				<td>${applicants}/${detail.applicants_limit}</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td><a href="${path}/eduhistory/eduHistoryFile.do?edu_no=${detail.edu_no}">${detail.file_ori_name}</a></td>
				<td>신청마감일</td>
				<td>${detail.closing_date}</td>
			</tr>
			<tr>
				<td>비고</td>
				<td>${detail.note}</td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<input type="hidden" value="${detail.edu_no}" id="edu_no">
		
		<br>
		<div align="center" class="goList">
			<input class="w3-button w3-white w3-border" type="button" value="목록보기" onclick="location='${path}/EducationList.do'">
		</div>
		
	</div>
</body>
</html>