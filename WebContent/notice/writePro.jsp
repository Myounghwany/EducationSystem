<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<h2> 글작성 </h2>



<c:if test="${result == 0}">
	접근에 실패했습니다 <br>
	로그인 후 다시 시도하세요 <br>
	<meta http-equiv="refresh" content="2; url=notice.do">
</c:if>
<c:if test="${result == 1}">
	<c:redirect url="notice.do"/>
</c:if>