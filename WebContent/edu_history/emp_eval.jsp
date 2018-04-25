<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>직원의 강의평가 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function test() {
		var emp_eval = document.getElementById("emp_eval").value;
		var form = document.form;
		if (emp_eval == '') {
			alert('평가란을 입력해주세요.');
		} else {
			form.method = "post";
			form.action = "${path}/eduhistory/write_emp_eval.do?edu_no=" + ${edu_detail.edu_no};
			form.submit();
		}
	}
</script>
<script type="text/javascript">
	
	var textCountLimit = 1000;
	$(document).ready(function(){
		$('textarea[name=emp_eval]').keyup(function(){
			//텍스트영역의 길이를 체크
			var textLength = $(this).val().length;
			
			//입력된 텍스트 길이를 #textCount에 업데이트해줌
			$('#textCount').text(textLength);
			
			//제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼 자르고 텍스트영역에 넣음
			if(textLength>textCountLimit){
				$(this).val($(this).val().substr(0, textCountLimit));
			}
		});
	});
</script>
</head>
<body>
	<div align="center">
		<h4>강의평가하기</h4>
		<form id="form" name="form">
			<table>
				<tr>
					<td>교육명</td>
					<td>${edu_detail.edu_name}</td>
				</tr>
				<tr>
					<td width="80px">교육분야</td>
					<td>${edu_detail.edu_field}</td>
				</tr>
				<tr>
					<td>강사명</td>
					<td>${edu_detail.instructor_name}</td>
				</tr>
				<tr>
					<td>교육일</td>
					<td>${edu_detail.edu_schedule}</td>
				</tr>
				<tr>
					<td>강의평가</td>
					<td>
						<textarea rows="6" cols="30" id="emp_eval" name="emp_eval"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<span style="color: red; font-size: 8px;">*제출하면 다시 수정 불가능합니다.</span>
					<span style="float: right; font-size: 8px;">
						(<span id="textCount" class="textCount">0</span>/1000)
					</span>
					</td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<input type="button" onclick="test();" value="제출">
						<button onclick="window.close();">취소</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>