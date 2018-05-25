<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 삭제</title>
</head>
<body>
<h2> 글 삭제 </h2>


<c:if test="${result == 1}">
   <c:redirect url="notice.do" />
</c:if>


<c:if test="${result == 0}">
   입력하신 비밀번호가 다릅니다 <br>
   다시 입력하세요 <br>
   <meta http-equiv="refresh" content="2; url=deleteForm.do" />
</c:if>
</body>
</html>