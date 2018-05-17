<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>common/fixedFooter</title>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css);
.footer {
    position: fixed;
    bottom: 0;
    width: 70%;
    height: 10%;
    margin:0 auto;
    background-color: white;
    color: white;
}
.hr{
	height: 1px;
	background-color: #dee8ff;
}
.content{
	margin-left: 30%;
}
.footerSpan {
	margin-left : 20px;
	color : #b5b5b5;
	font-family: 'Jeju Myeongjo', serif;
}
</style>
</head>
<body>
	<div class="footer">
		<hr class="hr">
		<div class="content">
			<img src="http://biztechpartners.co.kr/common/images/footerlogo.jpg" />
			<span class="footerSpan">유창연 | 장명환 | 박나현 | 윤소현 | 최재은 | 이주현</span>
		</div>
	</div>
</body>
</html>