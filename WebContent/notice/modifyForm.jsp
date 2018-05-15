<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../common/header.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정</title>

</head>
<body>

<h2> 공 지 수 정 </h2>
<hr>


	<body onload="modifyfocus()">
		<form name="modifyform" method="post" action="modifyPro.do?no=${noticeDto.notice_no }"
			onsubmit="return modifycheck()">
			
			<input type="hidden" name="num" value="${noticeDto.notice_no  }">
			<input type="hidden" name="pageNum" value="">
			
			<table>
				<tr>
					<th colspan="2">
						수정할 정보를 입력하세요.
					</th>
				</tr>
				<tr>
					<th> 작성자 </th>
					<td align="left"> ${NoticeDataBean.writer  } </td>
				</tr>
				<tr>
					<th> 이메일 </th>
					<td align="left">
							<input class="input" type="text" name="email" style="width:200px"
								maxlength="30" value="${noticeDto.email }" readonly="readonly">
							
					</td>
				</tr>
				<tr>
					<th> 제목
					<td align="left">
						<input class="input" type="text" name="title" maxlength="50"
							style="width:200px" value="${noticeDto.title }">								
					</td>
				</tr>
				<tr>
					<th> 글내용 </th>
					<td>
						<textarea class="input" name="content" rows="10" cols="75"	style="width:300px">${noticeDto.content }</textarea>
					</td>
				</tr>
				<tr>
					<th> 비밀번호 </th>
					<td align="left">
						<input class="input" type="password" name="password" style="width:200px" 
							maxlength="12" value="${noticeDto.password }">
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input class="inputbutton" type="submit" value="수정">
						<input class="inputbutton" type="reset" value="취소">
						<input class="inputbutton" type="button" value="수정취소"
							onclick="location='notice.do?'">					
					</th>
				</tr>
			</table>				
		</form>
	</body>
</html>