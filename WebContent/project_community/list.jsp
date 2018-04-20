<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 Community</title>
<jsp:include page="../common/header.jsp" />
</head>
<body>

<h1>프로젝트 Community List</h1>

        <table border="1" width="60%" align="center">
          <thead>
            <tr>
              <th>글번호</th>
              <th>분류</th>
              <th>제목</th>
              <th>내용</th>
              <th>작성자</th>
              <th>작성시간</th>
              <th>조회수</th>
            </tr>
          </thead>
          <tbody>
			<c:choose>
				<c:when test="${empty requestScope.accountList}">
				<tr>
					<td colspan="7" align="center">등록된 글이 없습니다.</td>
				</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${requestScope.accountList}" var="list" varStatus="state">
						<tr>
							<td>${list.account_number}</td>
							<td>${list.account_number}</td>
							<td>${list.account_number}</td>
							<td>${list.account_name}</td>
							<td>${list.remain_money}</td>
							<td>${list.remain_money}</td>
							<td>${list.remain_money}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
          </tbody>
        </table>


</body>
</html>