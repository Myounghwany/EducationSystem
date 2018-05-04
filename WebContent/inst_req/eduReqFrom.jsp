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
.table2{
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
.plusBtn{
	color: black;
}
</style>
<script type="text/javascript">
	$(function() {
	    $( "#startDate" ).datepicker({
	    	dateFormat: "yy.mm.dd",
	    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	    $( "#endDate" ).datepicker({
	    	dateFormat: "yy.mm.dd",
	    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	    $( "#closingDate" ).datepicker({
	    	dateFormat: "yy.mm.dd",
	    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	    });
	});
	
	function selectBelong(belong_no){
		if(belong_no == '0'){
			$('#department').empty();
			$('#department').append('<option value = "0">전체</option>');
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
					$('#department').append('<option value = "'+res[i].dept_no+'">'+res[i].dept_name+'</option>');
					console.log(res[i].dept_no + ' - ' + res[i].dept_name);
				}
			},
			error : function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	function addTarget(){
		var form = document.eduForm;
		var belong = form.target_belong;
		var department = form.target_department;
		var position = form.target_position;
		var belong_name = belong.options[belong.selectedIndex].text;
		var department_name = department.options[department.selectedIndex].text;
		var position_name = position.options[position.selectedIndex].text;
		var belong_no = belong.options[belong.selectedIndex].value;
		var department_no = department.options[department.selectedIndex].value;
		var position_no  = position.options[position.selectedIndex].value;
		form.elements['select1'].options.add(new Option(belong.options[belong.selectedIndex].text + '-' + department.options[department.selectedIndex].text + '-' + position.options[position.selectedIndex].text, belong_no + '!' + belong_name + '@' + department_no + '#' + department_name + '$' + position_no + '%' + position_name));
		alert(belong.options[belong.selectedIndex].value + '-' + department.options[department.selectedIndex].value + '-' + position.options[position.selectedIndex].value);
		$('#select1 option').prop('selected', true);
		/* $('.table1').append('<input type = "hidden" value = "">'); */
	}
	function removeTarget(){
		var form = document.eduForm;
		var o = form.elements['select1'];
		var idx = o.selectedIndex;
		if(idx == -1 ) return;
		o.options.remove(idx);
		o.selectedIndex = idx - 1;
		if(idx - 1 < 0) o.selectedIndex = 0;
	}
</script>
<body>
	<h3>교육신청 페이지</h3>
	강사번호 : ${instructor_no }
	<br/>
	<form name= "eduForm" method="post" action = "eduReq.do" enctype="multipart/form-data">
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
				<td><input type="text" name="edu_field"/></td>
			</tr>
			<tr>
				<td>교육명</td>
				<td><input type="text" name="edu_name"/></td>
			</tr>
			<tr>
				<td>교육방법</td>
				<td><input type="text" name="edu_way"/></td>
			</tr>
			<tr>
				<td>교육일정</td>
				<td>	
					<input type="text" id="startDate" name="startDate">
					<input type="text" id="endDate" name="endDate">
				</td>
			</tr>
			<tr>
				<td>교육일시</td>
				<td><input type="text" name="edu_date"/></td>
			</tr>
			<tr>
				<td>소요시간</td>
				<td><input type="text" name="input_time"/></td>
			</tr>
			<tr>
				<td>신청마감일</td>
				<td><input type="text" name="closing_date" id="closingDate"></td>
			</tr>
			<tr>
				<td>교육장소</td>
				<td><input type="text" name="edu_location"/></td>
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
				<td><input type="text" name = "manager"/></td>
			</tr>
			<tr>
				<td>교육대상</td>
				<td>소속 : 
					<select name = "target_belong" onChange="javascript:selectBelong(this.value)">
						<option value = "0">전체</option>
						<c:forEach items = "${belong_no }" var = "item">
							<option value = "${item.belong_no }">${item.name }</option>
						</c:forEach>
					</select>
					부서 :
					<select name = "target_department" id="department">
						<option value = "0">전체</option>
					</select>
					직급 : 
					<select name = "target_position">
						<option value = "0">전체</option>
						<c:forEach items = "${position }" var = "item">
							<option value = "${item.position_no }">${item.position_name }</option>
						</c:forEach>
					</select>
					
					<input type = "button" value="추가" onclick="addTarget()">
					<br/>
					<table class="table2" border="0" cellpadding="5" cellspacing="1" style="font-size:9pt;" bgcolor="#999999">
			            <tr>
			                <td align="center" bgcolor="white">
			                	<select id="select1" name="select1" size="10" style="width:200px;"  multiple="multiple"></select>
			                </td>
			                
			            </tr>
			            <tr>
			                <td align="center" colspan="4" bgcolor="white">   
			                	<input type="button" value="삭제" onclick="removeTarget()"> 
			                </td>
			            </tr>
		        	</table>
				</td>
					
			</tr>
			<tr>
				<td>소요예산</td>
				<td><textarea class="form-control" rows="4" name="budget" maxlength="1000"
					style="width: 700px; height: 500px;"></textarea></td>
			</tr>
			<tr>
				<td>비고</td>
				<td><textarea class="form-control" rows="4" name="note" maxlength="1000"
					style="width: 700px; height: 500px;"></textarea></td>
			</tr>
			<tr>
				<td>신청자 제한 수</td>
				<td><input type="text" name="applicants_limit"/>명</td>
			</tr>
			<tr>
				<td>파일첨부</td>
				<td><input type="file" name="file_name"/></td>
			</tr>
		</table>
		<br/>	
		<div class="eduReqBtn">
			<input type="submit" value="교육신청"/>
			<input type="reset" value="입력취소"/>
		</div>
	</form>
</body>