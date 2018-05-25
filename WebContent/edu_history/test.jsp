<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	aa = '';
	$(function() {
		setTimeout("window.self.focus();", 1000);

		$('#dd').focus(function() {
			aa = $(this).val();
		}).change(function() {
			$('#dd').trigger("blur");
			$('#test').append("before value : " + aa + "<br>");
		});
	});
</script>
<body>
	<select id='dd'>
		<option value=1>1</option>
		<option value=2>2</option>
		<option value=3>3</option>
	</select>

	<div id='test'></div>
</body>