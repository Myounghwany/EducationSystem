<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<title>manage/eduModify</title>
<style>
.eduReqBtn {
	text-align: right;
	margin-left: auto;
	margin-right: auto;
}
.necessary {
	color: red;
}
</style>
<script type="text/javascript">
	var textCountLimit = 1000;
	$(document).ready(function() {
		$('textarea[name=budget]').keyup(function() {
			//텍스트영역의 길이를 체크
			var textLength = $(this).val().length;

			//입력된 텍스트 길이를 #textCount에 업데이트해줌
			$('#textCount1').text(textLength);

			//제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼 자르고 텍스트영역에 넣음
			if (textLength > textCountLimit) {
				$(this).val($(this).val().substr(0, textCountLimit));
			}
		});
		$('textarea[name=note]').keyup(function() {
			//텍스트영역의 길이를 체크
			var textLength = $(this).val().length;

			//입력된 텍스트 길이를 #textCount에 업데이트해줌
			$('#textCount2').text(textLength);

			//제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼 자르고 텍스트영역에 넣음
			if (textLength > textCountLimit) {
				$(this).val($(this).val().substr(0, textCountLimit));
			}
		});
		$('#checkTarget').change(function(){
			if($('#checkTarget').is(':checked')){
				$('#target :input').attr("disabled", "true");
				 var form = document.eduForm;
				 var o = form.elements['select1'];
			     if(o.length == 0) return;
				 var loop = o.length;
			     for (var i=0 ; i < loop ; i++){
			         o.options.remove(0);
			     }
			}else{
				$('#target :input').removeAttr('disabled');
			}
		});
		$('#target :input').attr("disabled", "true");
	});
	$(function() {
		 $( "#startDate" ).datepicker({
		    	dateFormat: "yy.mm.dd",
		    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        minDate: 0,
		        onClose: function( selectedDate ) {
	                $("#endDate").datepicker( "option", "minDate", selectedDate );
	            }
		    });
		    $( "#endDate" ).datepicker({
		    	dateFormat: "yy.mm.dd",
		    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        onClose: function( selectedDate ) {
	                $("#startDate").datepicker( "option", "maxDate", selectedDate );
		        },
	            onClose: function( selectedDate ) {
	                $("#closingDate").datepicker( "option", "maxDate", selectedDate );
	            }
		    });
		    $( "#closingDate" ).datepicker({
		    	dateFormat: "yy.mm.dd",
		    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
		        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
		        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		        minDate: 0 
		    });
	});

	function selectBelong(belong_no) {
		if (belong_no == '0') {
			$('#department').empty();
			$('#department').append('<option value = "0">전체</option>');
		}
		$.ajax({
			url : '/EducationSystem/manage/belong.do',
			type : 'get',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				belong_no : belong_no
			},
			headers : {
				Accept : "application/json"
			},
			success : function(res) {
				$('#department').empty();
				$('#department').append('<option value = "0">전체</option>');
				for (i in res) {
					$('#department').append(
							'<option value = "'+res[i].dept_no+'">'
									+ res[i].dept_name + '</option>');
					console.log(res[i].dept_no + ' - ' + res[i].dept_name);
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
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
		/* alert(belong.options[belong.selectedIndex].value + '-' + department.options[department.selectedIndex].value + '-' + position.options[position.selectedIndex].value); */
		$('#select1 option').prop('selected', true);
	}
	function removeTarget() {
		var form = document.eduForm;
		var o = form.elements['select1'];
		var idx = o.selectedIndex;
		if (idx == -1)
			return;
		o.options.remove(idx);
		o.selectedIndex = idx - 1;
		if (idx - 1 < 0)
			o.selectedIndex = 0;
	}
	function inputCheck(){
		if(!document.eduForm.edu_code.value || document.eduForm.edu_code.value == ""){
			alert('교육코드를 선택하세요');
			document.eduForm.edu_code.focus();
			return false;
		}else if(!document.eduForm.belong_no.value || document.eduForm.belong_no.value == ""){
			alert('소속을 선택하세요');
			document.eduForm.belong_no.focus();
			return false;
		}else if(!document.eduForm.edu_field.value){
			alert('교육분야를 입력하세요');
			document.eduForm.belong_no.focus();
			return false;
		}else if(!document.eduForm.edu_name.value){
			alert('교육명을 입력하세요');
			document.eduForm.edu_name.focus();
			return false;
		}else if(!document.eduForm.edu_way.value){
			alert('교육방법을 입력하세요');
			document.eduForm.edu_way.focus();
			return false;
		}else if(!document.eduForm.startDate.value){
			alert('교육일정을 입력하세요');
			document.eduForm.startDate.focus();
			return false;
		}else if(!document.eduForm.endDate.value){
			alert('교육일정을 입력하세요');
			document.eduForm.endDate.focus();
			return false;
		}else if(!document.eduForm.edu_date.value){
			alert('교육일시를 입력하세요');
			document.eduForm.edu_date.focus();
			return false;
		}else if(!document.eduForm.input_time.value){
			alert('소요시간을 입력하세요');
			document.eduForm.input_time.focus();
			return false;
		}else if(!document.eduForm.closing_date.value){
			alert('신청마감일을 입력하세요');
			document.eduForm.input_time.focus();
			return false;
		}else if(!document.eduForm.edu_location.value){
			alert('교육장소를 입력하세요');
			document.eduForm.edu_location.focus();
			return false;
		}else if(!document.eduForm.manager.value){
			alert('담당자를 입력하세요');
			document.eduForm.manager.focus();
			return false;
		}else if(!document.eduForm.checkTarget.checked){
			if(!document.eduForm.select1.value){
				alert('교육대상을 선택하세요');
				document.eduForm.select1.focus();
				return false;
			}
		}else if(!document.eduForm.applicants_limit.value){
			alert('신청자제한수를 입력하세요');
			document.eduForm.applicants_limit.focus();
			return false;
		}
	}
	function InputOnlyNumber(obj) {
		if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
			return true;
		} else {
			alert('숫자만 입력가능합니다');
			event.returnValue = false;
		}
	}
</script>
<body>
	<h3>강의계획서 수정 페이지</h3>
	<div style="width: 90%; margin: 20px auto">
		<br />
		<form name="eduForm" method="post" action="/EducationSystem/manage/eduModify.do"
			enctype="multipart/form-data" onsubmit="return inputCheck()">
			<input type="hidden" name="edu_no" value="${edu_no}">
			<input type="hidden" name="instructor_no" value="${instructor_no}">
			<table class="w3-table w3-bordered">
				<tr>
					<th colspan="2" style="background-color: #EAEAEA;">강의계획서 수정</th>
				</tr>
				<c:forEach items="${edu_list}" var="item">
					<c:forEach items="${edu_detail}" var="item2">
						<tr>
							<td width="150px"><span class="necessary">*</span>교육코드</td>
							<td>${item.edu_code_name}</td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>소속번호</td>
							<td>${item.name}</td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>교육분야</td>
							<td>${item.edu_field}</td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>교육명</td>
							<td>${item.edu_name}</td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>교육방법</td>
							<td><input type="text" name="edu_way"
								value="${item.edu_way}" /></td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>교육일정</td>
							<td><input type="text" id="startDate" name="startDate"
								value="${item2.start_date}" /> <input type="text" id="endDate"
								name="endDate" value="${item2.end_date}" /></td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>교육일시</td>
							<td><input type="text" name="edu_date"
								value="${item.edu_date}" /></td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>소요시간</td>
							<td><input type="number" name="input_time"
								onkeyPress="InputOnlyNumber(this);" value="${item2.input_time}">&nbsp;소요시간은
								시 단위로 입력이 가능합니다</td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>신청마감일</td>
							<td><input type="text" name="closing_date" id="closingDate"
								value="${item.closing_date}" /></td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>교육장소</td>
							<td><input type="text" name="edu_location"
								value="${item.edu_location}" /></td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>담당자</td>
							<td>${item.manager}</td>
						</tr>
					</c:forEach>
				</c:forEach>
				<tr>
					<td><span class="necessary">*</span>필수교육대상</td>
					<td><input type="checkbox" checked id="checkTarget" name="checkTarget" value="noTarget"> &nbsp;없음<br/>
					<div id="target">
					소속 :<select name="target_belong" onChange="javascript:selectBelong(this.value)" id="belong">
								<option value="0">전체</option>
								<c:forEach items="${belong_no }" var="item">
									<option value="${item.belong_no }">${item.name }</option>
								</c:forEach>
						</select>
					 부서 :<select name="target_department" id="department">
							<option value="0">전체</option>
						 </select>
					직급 : <select name="target_position"  id="position">
							<option value="0">전체</option>
							<c:forEach items="${position }" var="item">
								<option value="${item.position_no }">${item.position_name}</option>
							</c:forEach>
						</select>
						
						<input type="button" value="추가" onclick="addTarget()"> <br />
						<table border="0" cellpadding="5" cellspacing="1"
							style="font-size: 9pt;" bgcolor="#999999">
							<tr>
								<td align="center" bgcolor="white"><select id="select1"
									name="select1" size="10" style="width: 200px;"
									multiple="multiple"></select></td>

							</tr>
							<tr>
								<td align="center" colspan="4" bgcolor="white"><input
									type="button" value="삭제" onclick="removeTarget()"></td>
							</tr>
						</table>
						</div>
					</td>

				</tr>
				<c:forEach items="${edu_list }" var="item">
					<c:forEach items="${edu_detail }" var="item2">
						<tr>
							<td><span class="necessary">&nbsp;</span>소요예산</td>
							<td><textarea class="form-control" rows="4" name="budget"
									maxlength="1000" style="width: 700px; height: 300px;">${item.budget }</textarea>
								<span style="float: right;"> (<span id="textCount1"
									class="textCount1">0</span>/1000)
							</span></td>
						</tr>
						<tr>
							<td><span class="necessary">&nbsp;</span>비고</td>
							<td><textarea class="form-control" rows="4" name="note"
									maxlength="1000" style="width: 700px; height: 300px;">${item.note }</textarea>
								<span style="float: right;"> (<span id="textCount2"
									class="textCount2">0</span>/1000)
							</span></td>
						</tr>
						<tr>
							<td><span class="necessary">*</span>신청자 제한 수</td>
							<td><input type="number" name="applicants_limit"
								value="${item.applicants_limit }" />명</td>
						</tr>
						<tr>
							<td><span class="necessary">&nbsp;</span>기존파일</td>
							<td>${item2.file_ori_name }</td>
						</tr>
						<tr>
							<td><span class="necessary">&nbsp;</span>파일첨부</td>
							<td><input type="file" name="file_name" /></td>
						</tr>
					</c:forEach>
				</c:forEach>
			</table>
			<br />
			<div class="eduReqBtn">
				<input type="submit" value="수정하기"
					class="w3-button w3-white w3-border" />
			</div>
			<br /> <br />
			<div align="center" class="goList">
				<input type="button" class="w3-button w3-white w3-border" value="이전"
					onclick="location='/EducationSystem/manage/eduList.do'">
			</div>
		</form>
	</div>
</body>