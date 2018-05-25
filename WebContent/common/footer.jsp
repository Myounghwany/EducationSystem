<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>common/footer</title>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css);
.footer {
   position: inherit;
   bottom: 0;
   height: 10%;
   margin: 50px auto;
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

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    padding: 12px 16px;
    z-index: 1;
}

.dropdown:hover .dropdown-content {
    display: block;
}
.footTag{
	color:black;
}
.footTag:hover{
	color: #5D5D5D;
	text-decoration: none;
	background-color: #FFFFF6;
}
</style>
</head>
<body>
	<div class="footer">
		<hr class="hr">
		<div class="content">
			<img src="http://biztechpartners.co.kr/common/images/footerlogo.jpg">
			<span class="footerSpan">유창연 | 장명환 | 박나현 | 윤소현 | 최재은 | 이주현</span>
			
			<div class="dropdown">
				<button type="button" class="w3-button w3-white w3-border"
						style="width: 120px; height: 40px; margin-left: 30%;" data-toggle="dropdown">
				Family Site ▼</button>
				<div class="dropdown-content">
			      <p><a class="footTag" href="http://biztechpartners.co.kr/" target="_blank">비즈테크파트너스</a></p>
			    </div>
		    </div>
		
		</div>
	</div>
</body>
</html>