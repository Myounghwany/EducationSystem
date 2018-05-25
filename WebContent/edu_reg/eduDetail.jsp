<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<title>강사 - Education System</title>
<style>
#info{
	text-align: center;
}
#eduModify{
	float: right;
}
select {
    width: 500px;
    height: 40px;
    padding-left: 10px;
    font-size: 30px;
    color: #006fff;
    border: 1px solid #006fff;
    border-radius: 3px;
}
option {
    width: 200px;
    height: 30px;
    padding-left: 15px;
    font-size: 15px;
    border: 1px solid #006fff;
    border-radius: 3px;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#edu_no").change(function(){
		location.href="/EducationSystem/instructor/eduDetail.do?edu_no=" + $(this).val()+"&instructor_no=${instructor_no}";
	});
});
	function fileDown(file_path){
		alert('sfsfs');
		alert(file_path);
	}
	function eduModify(edu_no, instructor_no){
		if(confirm("강의계획서 수정페이지로 이동하시겠습니까?")==true){
			location.href="/EducationSystem/instructor/eduModify.do?edu_no=" + edu_no + "&instructor_no="+instructor_no;
		}else{
			return;
		}
	}
</script>
<jsp:include page="../common/header.jsp" />
<body>
	<h3>강사 페이지</h3>
	<div style="padding-bottom: 80px;">
		강의계획서 > &nbsp;<select name="edu_no" id="edu_no">
		<c:forEach items = "${edu_name }" var = "item">
			<option value="${item.edu_no }" <c:if test="${edu_no == item.edu_no}">selected</c:if>>${item.edu_name }</option> 
		</c:forEach>
		</select>
		<table class="w3-table w3-bordered">
			<tr>
				<th>
					<input type="button" id="eduModify" onclick="eduModify('${edu_no}', '${instructor_no }')" value="강의계획서 수정" class="w3-button w3-green w3-border"/>
				</th>
			</tr>
		</table>
		<table class="w3-table w3-bordered">
			<tr>
				<th colspan="2" style="background-color: #CCCCCC;">강의계획서</th>
			</tr>
			<c:forEach items = "${edu_list }" var = "item">
			<tr>
				<th>소속</th>
				<td>${item.belong_name }</td>
			</tr>
			<tr>
				<th width="140px" >교육분야</th>
				<td>${item.edu_field }</td>
			</tr>
			<tr>
				<th>교육코드</th>
				<td>${item.edu_code_name }</td>
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
				<th>필수교육대상</th>
				<td>
					<c:forEach items = "${edu_target }" var = "item1">
						${item1 } <br/>
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
				<th>신청마감일</th>
				<td>
					${item.closing_date }
					<%-- <fmt:parseDate value="${item.closing_date }" pattern="yyyy-MM-dd HH:mm:ss" var="closing_date" /> 
					<fmt:formatDate value="${closing_date }" pattern="yyyy.MM.dd" var="date" /> 
					${date } --%>
				</td>
			</tr>
			<tr>
				<th>교육방법</th>
				<td>${item.edu_way }</td>
			</tr>
			<tr>
				<th>교육장소</th>
				<td>${item.edu_location }</td>
			</tr>
			<tr>
				<th>소요예산</th>
				<td><pre>${item.budget }</pre></td>
			</tr>
			<tr>
				<th>비고</th>
				<td><pre>${item.note }</pre></td>
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
				<th colspan="6" style="background-color: #CCCCCC;">수강자</th>
			</tr>
			<tr>
				<td style="background-color: #EAEAEA;">사원번호</td>
				<td style="background-color: #EAEAEA;">부서</td>
				<td style="background-color: #EAEAEA;">직급</td>
				<td style="background-color: #EAEAEA;">이름</td>
				<td style="background-color: #EAEAEA;">이수여부</td>
			</tr>
			
			<c:choose>
				<c:when test="${empty edu_history}">
					<tr>
						<td colspan="5" style="text-align: center;">수강자가 존재하지 않습니다</td>
					</tr>
				</c:when>
				<c:otherwise>
				<c:forEach items = "${edu_history }" var = "item">
					<tr>
						<td>${item.emp_no }</td>
						<td>${item.dept_name }</td>
						<td>${item.position_name }</td>
						<td>${item.name }</td>
						<td>
							<c:choose>
								<c:when test="${item.edu_state == 'I'}">강의진행중</c:when>			
								<c:otherwise>${item.edu_state }</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	
	</div>
</body>