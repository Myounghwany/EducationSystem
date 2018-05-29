<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<jsp:include page="../common/header.jsp" />
<title>교육목록/신청</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 로그인모달 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 드롭다운(비밀번호 변경) -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>

$(document).ready(function() {
                 
	var index = "";
	var edu_target =  ${targetList}; 
	var listCount = ${listCount};
	var applicantsList = ${applicantsList};
	var edu_list = $(".ed_no");
	
	
	if($('#optV').val() !=""){
		var  opt = $('#optV').val();
		var condition =$('#conditionV').val();
		
		console.log('opt :'+opt+' condition :'+condition);
		
		$(".selectDefault option:eq("+opt+")").attr("selected", "selected");
		$("#condition").val(condition);
		
	}
	
	 $(function(){
		    $(${applicantsList}).each(function(key, value){

		    	$(function(){
				    $('.ed_no').each(function(){
				    	var ed = $(this).text();
				    	
				    	console.log($('#tr'+ed).find('.apptd')) ;
				    	console.log('==============================================');
				    	console.log('ed_no :'+ed+$('#tr'+ed).find('.apptd').text()) ;
				    	console.log('==============================================');
				    	
				        if($(this).text() == value && $('#tr'+ed).find('.apptd').text() != ""){
				        	console.log($('#tr'+ed).find('.apptd').append('<span style="color:red;">인원 마감</span>')) ;
				        }

				        if($(this).text() == value && $('#tr'+ed).find('.apptd').text() == ""){
				        	console.log($('#tr'+ed).find('.apptd').html('<span style="color:red;">인원 마감</span>')) ;
				        }
				        
				    });
				});
		    	
		    });
		});

	console.log('edu_target : '+edu_target);	
	console.log('edu_target.length : '+edu_target.length);	
	 
	for(var i=0; edu_target.length>i ; i++){
		index = $("."+(i)).text();
		
		var str ="";
		console.log(' [i] : '+i);
		console.log('edu_target[i] : '+edu_target[i]);
		
		if(edu_target[i] != -1){
			
		for(var j=0; edu_target[i].length > j ; j++){
			str += edu_target[i][j].belong_name+' , '+edu_target[i][j].dept_name+' , '+edu_target[i][j].position_name;
			
			$("."+(i)).text(str);
		
			}
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
		dataType:"json", 
		success : function(data){
			
			$('#edu_no').html(edu_no);
			$('#belong_name').html(data.belong_name);
			$('#edu_field').html(data.edu_field);
			$('#edu_name').html(data.edu_name);
			$('#edu_schedule').html(data.edu_schedule);
			$('#instructor_name').html(data.instructor_name);
			$('#app_limit').html(data.applicants+'/'+data.applicants_limit);
			
		},
		error : function(request,status,error){
			alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
		}
	});
	
	
}

function deleteBtn(no){
	var edu_no = no; 
	
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
				alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});
		
		location.href="${path}/EducationList.do";
	}
	
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
	
	<div align="center">
	<div>
		<form action="EducationList.do" name="searchform" onsubmit="return searchCheck()">
			<select name="opt" class="selectDefault">
				<option value="0">교육명</option>
				<option value="1">교육번호</option>
				<option value="2">교육분야</option>
				<option value="3">강사명</option>
			</select> 
			<input type="text" size="20" name="condition" id="condition" />&nbsp; <input	type="submit" value="검색" />
		</form>
	</div>
	
	
	<br>
	<span>*클릭하면 상세보기 페이지로 넘어갑니다.</span>
	<table align="center" border="1" id="title">
		<tr>
			<th>교육번호</th>
			<th>교육명</th>
			<th>소속명</th>
			<th>교육분야</th>
			<th>필수교육대상</th>
			<th>담당자</th>
			<th>교육일정</th>
			<th width="7%">강사명</th>
			<th>교육인원</th>
			<th>마감일</th>
			<th>교육신청</th>
		</tr>
		<c:choose>
			<c:when test="${empty list}">
				<tr>
					<td colspan="11">해당하는 교육이 존재하지 않습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list}" var="edulist" varStatus="state">
					<tr id="tr${edulist.edu_no}">
						<td id="ed_no" class="ed_no" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_no}</td>
						<td id="ed_name" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_name}</td>
						<td id="be_no" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.belong_name}</td>
						<td id="ed_field" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_field}</td>
						<td id="ed_target" class='${state.index}' onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'"></td>
						<td id="ma" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.manager}</td>
						<td id="ed_schedule" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.edu_schedule}</td>
						<td id="in_name" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.instructor_name}</td>
						<td id="ap_limit" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.applicants_limit}</td>
						<td id="closing" onclick="location.href='EducationList/detail.do?edu_no=${edulist.edu_no}'">${edulist.closing_date}</td>
							
							<c:set var="doneLoop" value="false"/>
							<c:forEach items="${history}" var="history" varStatus="state1">
								<c:if test="${not doneLoop}">
									<c:if test="${history.edu_no eq edulist.edu_no}">
										<td class="apptd" id="apptd">신청완료<input type="button" value="신청취소" onclick="deleteBtn(${edulist.edu_no})"><br></td>
										<c:set var="doneLoop" value="true"/> 
									</c:if>
									<c:if test="${history.edu_no ne edulist.edu_no  and state1.count eq historySize }">
										<td class="apptd" id="apptd"><input type="button" value="교육신청" onclick="listBtn(${edulist.edu_no})"></td>
									</c:if>
								</c:if>
							</c:forEach>

							<c:if test="${empty history }">
								<td class="apptd" id="apptd"><input type="button" value="교육신청" onclick="listBtn(${edulist.edu_no})"></td>
							</c:if>
 
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	
	
<!-- modal -->  
  <div id="id01" class="w3-modal">
    <div class="w3-modal-content" style="width: 400px; height: 400px;">
      <header class="w3-container w3" style="background-color: #EAEAEA;"> 
        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-display-topright">&times;</span>
        <h1 style="color : black;">교육신청</h1>
      </header>
      <div class="w3-container">
        <p>선택한 교육과정</p>
        <div id="modalId"></div>
        
        
        <table border="1">
        	<tr>
        		<td width="35%">교육코드</td><td><span id="edu_no"> </span></td> 
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
        	<tr>
        		<td>신청자 수</td><td><span id="app_limit" ></span></td> 
        	</tr>
        </table><br/>
        <span>신청하시겠습니까?</span><br>

        <button id="applicationBtn">신청</button>
        <br>
      </div>
    </div>
  </div>
  


		
		<!-- paging -->
		<div align="center" class="paging">
			
			<!-- 검색 X 페이징 -->
			<c:if test="${condition == null}">
		
				<c:if test="${startPage != 1}">
					<a href='EducationList.do?page=${startPage-1}' class="page_btn">이전</a>
				</c:if>
				
				<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
					<c:if test="${pageNum == spage}" >
				              <span class="page_btn">${pageNum}</span>
				          </c:if>
					<c:if test="${pageNum != spage}">
						<a href='EducationList.do?page=${pageNum}' class="page_btn">${pageNum}</a>
					</c:if>
				</c:forEach>
				
				<c:if test="${endPage != maxPage }">
					<a href='EducationList.do?page=${endPage+1}' class="page_btn">다음</a>
				</c:if>
			
			</c:if>

			<!-- 검색 O 페이징 -->
			<c:if test="${condition != null}">
		
				<c:if test="${startPage != 1}">
					<a href='EducationList.do?page=${startPage-1}&opt=${opt}&condition=${condition}' class="page_btn">이전</a>
				</c:if>
				
				<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
					<c:if test="${pageNum == spage}" >
				              <span class="page_btn">${pageNum}</span>
				          </c:if>
					<c:if test="${pageNum != spage}">
						<a href='EducationList.do?page=${pageNum}&opt=${opt}&condition=${condition}' class="page_btn">${pageNum}</a>
					</c:if>
				</c:forEach>
				
				<c:if test="${endPage != maxPage }">
					<a href='EducationList.do?page=${endPage+1}&opt=${opt}&condition=${condition}' class="page_btn">다음</a>
				</c:if>
			
			</c:if>
		
			<input type="hidden" value="${opt}" id="optV" name="optV">
			<input type="hidden" value="${condition}" id="conditionV">
		
			<c:if test="${condition != null}">
				<p align="center">
					<b><a href="EducationList.do">되돌아가기</a></b>
				</p>
			</c:if>
		</div>
		
		
		
	</div>
	
</body>
</body>