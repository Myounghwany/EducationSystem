<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>Insert title here</title>

<script>
	function test() {
 		var form = document.getElementById("form");
		var approval_state = document.getElementById("approval_state").value;

		if (approval_state == 1){
			approval_state = "승인대기";
		} else if(approval_state == 2){
			approval_state = "승인심사";
		} else if(approval_state == 3){
			approval_state = "승인완료";
		} else if(approval_state == 4){
			approval_state = "승인거절";
		}
 		
 		if (confirm("심사현황을 " + approval_state + "로 변경하시겠습니까?") == false){
 			return false;
 		} else{
			form.method = "post";
			form.action = "/EducationSystem/manage/updateEduState.do?edu_no=" + ${eduDetail.edu_no};
			form.submit();
 		}
	}
</script>
</head>
<body>
<div align="center">
<h3>심사현황 변경</h3>
	<form id="form" name="form">
		<table class="w3-table w3-bordered" width="80%">
			<tr>
				<td>교육번호</td>
				<td>${eduDetail.edu_no}</td>
			</tr>
			<tr>
				<td>교육명</td>
				<td><b> ${eduDetail.edu_name} </b></td>
			</tr>
			<tr>
				<td>담당자</td>
				<td>${eduDetail.manager}</td>
			</tr>
			<tr>
				<td>교육일정</td>
				<td>${eduDetail.edu_schedule}</td>
			</tr>
			<tr>
				<td>승인여부</td>
				<td><!-- 심사현황 // 1 - 승인대기, 2 - 승인심사 3 - 승인완료 4-거절-->
					<select id="approval_state" name = "approval_state">
							<option value = "${eduDetail.approval_state}">
								<c:if test="${eduDetail.approval_state eq 1}">
									<span>승인대기</span>
								</c:if>
								<c:if test="${eduDetail.approval_state eq 2}">
									<span>승인심사</span>
								</c:if>
								<c:if test="${eduDetail.approval_state eq 4}">
									<span>승인거절</span>
								</c:if>
							</option>
							<option value = "1">승인대기</option>
							<option value = "2">승인심사</option>
							<option value = "3">승인완료</option>
							<option value = "4">승인거절</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;">
					<input type="button" class="w3-button w3-white w3-border" onclick="test();" value="변경">
							<button class="w3-button w3-white w3-border" onclick="window.close();">취소</button>
				</td>
			</tr>
		</table>
	</form>

</div>
</body>
</html>