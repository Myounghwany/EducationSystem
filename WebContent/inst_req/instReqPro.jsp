<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>°­»ç - Education System</title>

<body>
	<c:if test="${result == 0}">
	</c:if>
	<c:if test="${result != 0}">
		<c:redirect url="main.do"/>
	</c:if>	
</body>
