<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>직원의 강의평가 페이지</title>
</head>
<body>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript">
var f = document.getElementById("myForm");
f.target = "main";
f.action = "${path}/eduhistory/write_emp_eval.do?edu_no="+${edu_detail.edu_no};
f.submit();
self.close();

</script>
<div align="center">
	<h4>강의평가하기</h4>
	<form name="myForm"  method="post" target="main"
		action="${path}/eduhistory/write_emp_eval.do?edu_no=${edu_detail.edu_no}">
		<table>
			<tr>
				<td width="80px">교육번호</td>
				<td>${edu_detail.edu_no}</td>
			</tr>
			<tr>
				<td>교육명</td>
				<td>${edu_detail.edu_name}</td>
			</tr>
			<tr>
				<td>강사명</td>
				<td> ${edu_detail.instructor_no}</td>
			</tr>
			<tr>
				<td>교육일</td>
				<td>${edu_detail.edu_schedule}</td>
			</tr>
			<tr>
				<td>강의평가</td>
				<td><input type="text" name="emp_eval"> </td>
			</tr>
			<tr align="center" >
				<td colspan="2">
					<input type="submit" value="제출">
					<button onclick="window.close();">취소</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>