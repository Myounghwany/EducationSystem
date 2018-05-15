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
#ModDelBtn{
	float: right;
}
#msg{
	font-size: 12px;
	color: red;
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
	function eduReqModify(edu_no){
		if(confirm("교육신청 수정페이지로 이동하시겠습니까?")==true){
			location.href="/EducationSystem/instructor/eduReqModify.do?edu_no=" + edu_no;
		}else{
			return;
		}
	}
	function eduReqDelete(edu_no){
		if(confirm("교육신청을 취소하시겠습니까?")==true){
			location.href="/EducationSystem/instructor/eduReqDelete.do?edu_no=" + edu_no;
		}else{
			return;
		}
	}
</script>
<jsp:include page="../common/header.jsp" />
<body>
	<h3>강사 페이지</h3>
	<div style="padding-bottom: 80px; width: 100%;">
		
		<c:forEach items = "${edu_list }" var = "item">
		<table class="w3-table w3-bordered">
			<tr>
				<th>신청현황 : 
					<c:if test="${item.approval_state == 1}">
					신청완료
					</c:if>
					<c:if test="${item.approval_state == 2}">
					심사진행중
					</c:if>
					<c:if test="${item.approval_state == 4}">
					승인거부
					</c:if>
					<br/>
					<span id="msg">※ 심사중일 경우 수정이 불가합니다</span>
					<div id="ModDelBtn">
						<c:if test="${item.approval_state == 1}">
						<input type="button" onclick="eduReqModify('${edu_no}')" value="교육신청 수정" class="w3-button w3-green w3-border"/>
						</c:if>
						<input type="button" onclick="eduReqDelete('${edu_no}')" value="교육신청 취소" class="w3-button w3-green w3-border"/>
					</div>
				</th>
			</tr>
		</table>
		<table class="w3-table w3-bordered" style="width: 100%;">
			<tr>
				<th colspan="2" style="background-color: #CCCCCC;">강의계획서</th>
			</tr>
			<tr>
				<th>소속</th>
				<td>${item.belong_name }</td>
			</tr>
			<tr>
				<th style="width: 10%;">교육분야</th>
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
				<th>교육대상</th>
				<td>
					<c:forEach items = "${edu_target }" var = "item1">
						<%-- <c:forEach items = "${dept_name }" var = "item2"> --%>
						<%-- <c:forEach items = "${dept_name }" var = "item2">
							<c:forEach items = "${position_name }" var = "item3"> --%>
						${item1 } <br/>
						<%-- ${item2 } 
						직급 : 
						${item3 } --%>
							<%-- </c:forEach>
						</c:forEach> --%>
						<%-- </c:forEach> --%>
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
					<fmt:parseDate value="${item.closing_date }" pattern="yyyy-MM-dd HH:mm:ss" var="closing_date" /> 
					<fmt:formatDate value="${closing_date }" pattern="yyyy.MM.dd" var="date" /> 
					${date }
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
				<td><pre style="white-space: pre-wrap;">${item.budget }</pre></td>
			</tr>
			<tr>
				<th>비고</th>
				<td><pre style="white-space: pre-wrap;">${item.note }</pre></td>
			</tr>
			<tr>
				<th>강의자료</th>
				<c:forEach items = "${edu_detail }" var = "item">
				<td><a href="${path}/instructor/fileDown.do?edu_no=${item.edu_no}">${item.file_ori_name}</a>
				</td>
				</c:forEach>
			</tr>
				
		</table>
		</c:forEach>
		
	
	</div>
</body>