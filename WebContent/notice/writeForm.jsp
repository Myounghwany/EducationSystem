<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>

</head>
<body>
	<h2>게시글 작성</h2>
	<hr>
	
	<form method="post" action="writePro.do">
	<table>
			<tr>
    			<th align="right" colspan="2" >
    			<a href="boardList.jsp">글 목록</a>
    			</th>
  			</tr>
  			
  			<tr>
  				<th>작성자</th>
  				<td align="left">
  					<input class="input" type="text" name="name" maxlength="10" style="width:200px">
  				</td>
  			</tr>
  			
  			<tr>
  				<th>이메일</th>
  				<td align="left">
  					<input class="input" type="text" name="email" maxlength="30" style="width:200px">
  				</td>
  			</tr>
  			
  			<tr>
  				<th>글제목</th>
  				<td align="left">
  					<input class="input" type="text" name="title" maxlength="50"  style="width :250px">
  				</td>
  			</tr>
  			
  			<tr>
  				<th>글내용</th>
  				<td align="left">
  					<textarea class="input" name="content" rows="10" cols="75"	style="width:300px"></textarea>
  				</td>
  			</tr>
  			
  			<tr>
  				<th>비밀번호</th>
  				<td align="left"><input class="input" type="password" name="password" maxlength="12" style="width:200px"> </td>
  			</tr>
  			
  			<tr>
  				<th colspan="2">
  					<input type="submit" value="작성" class="inputbutton">				
  					<input type="reset" value="취소" class="inputbutton">				
  					<input type="button" value="목록" class="inputbutton" onclick="location='main.do'">				
  				</th>
  			</tr>
  		
	</table>
	</form>
</body>
</html>