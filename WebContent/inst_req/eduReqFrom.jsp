<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp" />

<title>강사 - Education System</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<%-- <script src="${path}/inst_req/js/jquery-3.3.1.min.js"></script> --%>
<style>
.table1{
	width: 100%;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
}
.eduReqBtn{
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
}
</style>
<script type="text/javascript">
	$(function() {
	    $( "#fromDate" ).datepicker({
	    	dateFormat: "yy-mm-dd",
	    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	    $( "#toDate" ).datepicker({
	    	dateFormat: "yy-mm-dd",
	    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	    $( "#endDate" ).datepicker({
	    	dateFormat: "yy-mm-dd",
	    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	});
	function selectBelong(belong_no){
		alert(belong_no);
		if(belong_no == '0'){
			/* $('#department').empty(); */
		}
		$.ajax({
			url : '/EducationSystem/instructor/belong.do',
			type : 'get',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				belong_no : belong_no
			},
			headers: { 
			    Accept : "application/json"
			},
			success : function(res){
				for(i in res){
					$('#department').append('<option value = "'+res[i].dept_no+'">'+res[i].dept_name+'</option>')
					console.log(res[i].dept_no + ' - ' + res[i].dept_name);
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	/* function selectDept(dept_no){
		alert(belong_no);
		$.ajax({
			url : '/EducationSystem/instructor/belong.do',
			type : 'get',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				belong_no : belong_no
			},
			headers: { 
			    Accept : "application/json"
			},
			success : function(res){
				for(i in res){
					$('#department').append('<option value = "'+res[i].dept_no+'">'+res[i].dept_name+'</option>')
					console.log(res[i].dept_no + ' - ' + res[i].dept_name);
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	} */
</script>
<body>
	<h3>교육신청 페이지</h3>
	강사번호 : ${instructor_no }
	<form>
		<table class="table1" border = "1">
			<tr>
				<td width="130px">교육코드</td>
				<td>
					<select name = "edu_code">
						<option value = "">교육코드</option>
						<c:forEach items = "${edu_code }" var = "item">
							<option value = "${item.edu_code }">${item.edu_name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>소속번호</td>
				<td>
					<select name = "belong_no">
						<option value = "">소속</option>
						<c:forEach items = "${belong_no }" var = "item">
							<option value = "${item.belong_no }">${item.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>교육분야</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>교육명</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>교육방법</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>교육일정</td>
				<td>	
					<input type="text" id="fromDate">
					<input type="text" id="toDate">
				</td>
			</tr>
			<tr>
				<td>교육일시</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>소요시간</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>신청마감일</td>
				<td><input type="text" id="endDate"></td>
			</tr>
			<tr>
				<td>교육장소</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>강사</td>
				<td>
					<select name = "instructor_no">
						<option value = "">강사선택</option>
						<c:forEach items = "${instructor }" var = "item">
							<option value = "${item.instructor_no }">${item.name } - ${item.instructor_no }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>담당자</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>교육대상</td>
				<td>
					<select name = "target_belong" onChange="javascript:selectBelong(this.value)">
						<option value = "0">전체</option>
						<c:forEach items = "${belong_no }" var = "item">
							<option value = "${item.belong_no }">${item.name }</option>
						</c:forEach>
					</select>
					<select name = "target_department" id="department" onChange="javascript:selectDept(this.value)">
						<option value = "0">전체</option>
					</select>
					<select name = "target_position">
						<option value = "0">전체</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>소요예산</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>비고</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>신청자 제한 수</td>
				<td><input type="text"/>명</td>
			</tr>
			<tr>
				<td>파일첨부</td>
				<td><input type="file"/></td>
			</tr>
		</table>
		<br/>	
		<div class="eduReqBtn">
			<input type="submit" value="교육신청"/>
			<input type="reset" value="교육신청취소"/>
		</div>
	</form>
</body>