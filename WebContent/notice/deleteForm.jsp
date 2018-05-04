<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제</title>

</head>
<body>
<h2> 공 지 삭 제 </h2>

<form method="post" action="deletePro.do">
	<table>
		<tr>
			<th> 비밀번호 </th>
			<td> <input class="input" type="password" name="password" maxlength="20" ></td>
		</tr>
		
		<tr>
			<th colspan="2">
		<input type="hidden" name="no" value="${param.notice_no}" >
				<input class="inputbutton" type="submit" value="삭제">
				<input class="inputbutton" type="button" value="삭제취소" onclick="location='main.do'">
			</th>		
		</tr>	
	</table>		
</form>    
	
	
</body>
</html>