<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>강사 - Education System</title>
<style>
#isntRegBtn{
	float: right;
}
#info{
	text-align: center;
}
#eduRegBtn{
	float: right;
}
#eduModify{
	float: right;
}
</style>
<script type="text/javascript">
	function isntRegBtn(account_no){
		if(confirm("사원번호 : " + account_no + "\n"+"강사를 신청하시겠습니까?")==true){
			location.href="/EducationSystem/instructor/inst_req.do?account_no=" + account_no;
			alert('강사신청이 완료되었습니다.');
		}else{
			return;
		}
	}
	function eduRegBtn(instructor_no){
		location.href="/EducationSystem/instructor/edu_req.do?instructor_no=" + instructor_no;
	}
	function fileDown(file_path){
		alert('sfsfs');
		alert(file_path);
	}
	function eduModify(edu_no){
		if(confirm("강의계획서 수정페이지로 이동하시겠습니까?")==true){
			location.href="/EducationSystem/instructor/eduModify.do?edu_no=" + edu_no;
		}else{
			return;
		}
	}
</script>
<jsp:include page="../common/header.jsp" />
<body>
	<h3>강사 페이지</h3>
					
		<table class="w3-table w3-bordered">
			<tr>
				<th>
					<input type="button" id="eduModify" onclick="eduModify('${edu_no}')" value="강의계획서 수정" class="w3-button w3-green w3-border"/>
				</th>
			</tr>
		</table>
		<table class="w3-table w3-bordered">
			<tr>
				<th colspan="2" style="background-color: #CCCCCC;">강의계획서</th>
			</tr>
			<c:forEach items = "${edu_list }" var = "item">
			<tr>
				<th width="140px" >교육분야</th>
				<td>${item.edu_field }</td>
			</tr>
			<tr>
				<th>교육명</th>
				<td>${item.edu_name }</td>
			</tr>
			<tr>
				<th>담당자</th>
				<td>${item.manager }</td>
			</tr>
			<tr>
				<th>강사번호</th>
				<td>${item.instructor_no }</td>
			</tr>
			<tr>
				<th>교육대상</th>
				<td>
					<c:forEach items = "${belong_name }" var = "item1">
						<c:forEach items = "${dept_name }" var = "item2">
							<c:forEach items = "${position_name }" var = "item3">
						${item1 } - 
						${item2 } 
						직급 : 
						${item3 }
							</c:forEach>
						</c:forEach>
					</c:forEach>
				</td>	
			</tr>
			<tr>
				<th>교육일정</th>
				<td>${item.edu_schedule }</td>
			</tr>
			<tr>
				<th>교육일시</th>
				<td>${item.edu_date }</td>
			</tr>
			<tr>
				<th>교육장소</th>
				<td>${item.edu_location }</td>
			</tr>
			<tr>
				<th>소요예산</th>
				<td>${item.budget }</td>
			</tr>
			<tr>
				<th>비고</th>
				<td>${item.note }</td>
			</tr>
			<tr>
				<th>강의자료</th>
				<c:forEach items = "${edu_detail }" var = "item">
				<td><a href="${path}/instructor/fileDown.do?edu_no=${item.edu_no}">${item.file_ori_name}</a>
				</td>
				</c:forEach>
			</tr>
				
			</c:forEach>
		</table>
		<br/>
		<hr/>
		<br/>
		<table class="w3-table w3-bordered">
			<tr>
				<th colspan="5" style="background-color: #CCCCCC;">수강자</th>
			</tr>
			<tr>
				<td style="background-color: #EAEAEA;">사원번호</td>
				<td style="background-color: #EAEAEA;">부서</td>
				<td style="background-color: #EAEAEA;">이름</td>
				<td style="background-color: #EAEAEA;">이수여부</td>
			</tr>
			<c:forEach items = "${edu_history }" var = "item">
				<tr>
					<td>${item.emp_no }</td>
					<td>${item.dept_name }</td>
					<td>${item.name }</td>
					<td>${item.edu_state }</td>
				</tr>
			</c:forEach>
		</table>
	
	
</body>