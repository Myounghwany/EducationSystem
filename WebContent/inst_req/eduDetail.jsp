<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.table1{
	width: 100%;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
}
.table2{
	width: 100%;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
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
					
		<h4>강의계획서</h4>
		<button id="eduModify" onclick="eduModify('${edu_no}')">강의계획서 수정</button>
		<br/>
		<table class="table1" border = "1">
			<tr>
				<td>교육분야</td>
				<td>교육명</td>
				<td>담당자</td>
				<td>강사번호</td>
				<td>교육대상</td>
				<td>교육일정</td>
				<td>교육일시</td>
				<td>교육장소</td>
				<td>소요예산</td>
				<td>비고</td>
				<td>강의자료</td>
			</tr>
			<c:forEach items = "${edu_list }" var = "item">
				<tr>
					<td>${item.edu_field }</td>
					<td>${item.edu_name }</td>
					<td>${item.manager }</td>
					<td>${item.instructor_no }</td>
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
					<td>${item.edu_schedule }</td>
					<td>${item.edu_date }</td>
					<td>${item.edu_location }</td>
					<td>${item.budget }</td>
					<td>${item.note }</td>
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
		<h4>수강자</h4>
		<table class="table2" border = "1">
			<tr>
				<td>사원번호</td>
				<td>부서</td>
				<td>이름</td>
				<td>이수여부</td>
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