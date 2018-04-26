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
                 
	var index = "";
	var edu_target =  ${targetList}; 
	
 	for(var i=0; ed_target.length>i ; i++){
		index = $("."+(i)).text();
		
		var str ="";
		
		for(var j=0; edu_target[i].length > j ; j++){
			str += edu_target[i][j].belong_name+' , '+edu_target[i][j].dept_name+' , '+edu_target[i][j].position_name;
			console.log(str);
			
			$("."+(i)).text(str);
		
		}
	} 
	
	
	
	$('#applicationBtn').click(function(){
		var edu_no = $('#edu_no').html();
		
		$.ajax({
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			url : 'EducationList/application.do',
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

				location.href="${path}/EducationList.do";
				
			},
			error : function(request,status,error){
				alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});
		
		

	});
	
});


function listBtn(no){
	document.getElementById('id01').style.display='block';
	var edu_no = no; 
	
	$.ajax({
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		url : 'detailM.do',
		type : 'get',
		data : {
			edu_no : edu_no
		},
		headers: { 
            Accept : "application/json"
        },
		dataType:"json",  //다른서버에서도 데이터를 주고받을수 있게 dataType을 설정해 줘야함..
		success : function(data){
			
			$('#edu_no').html(edu_no);
			$('#belong_name').html(data.belong_name);
			$('#edu_field').html(data.edu_field);
			$('#edu_name').html(data.edu_name);
			$('#edu_schedule').html(data.edu_schedule);
			$('#instructor_name').html(data.instructor_name);
			
		},
		error : function(request,status,error){
			alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
		}
	});
	
	
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
	
	
	<span>*클릭하면 상세보기 페이지로 넘어갑니다.</span>
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
						<td id="ed_target" class='${state.index}' onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_target}</td>
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
        		<td>교육코드</td><td><span id="edu_no"> </span></td> 
        	</tr>
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