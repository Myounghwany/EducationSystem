<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<title> 수강자 평가 </title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    
<style type="text/css">
#wrap {
    width: 550px;
    margin: 0 auto 0 auto;
    text-align :center;
}

#commentReplyForm{
    text-align :center;
}
.table1{
	width: 100%;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
}
</style>
<script>
/* 다 지우기 */
$(document).ready(function(){
	var length = $("input[name=no]").length;
	var list = new Array(); 
	<c:forEach items = "${edu_history }" var = "item">
		list.push("${item.edu_state}");
	</c:forEach>
	for(var i = 0; i<length; i++){
		var edu_state = list[i];
		/* alert(document.getElementById("edu_state('"+i+"')").selectedIndex); */
		/* $("#edu_state('"+i+"') option:first").remove();
		$("#edu_state(1)").val('Y').prop("selected", true); */
		/* $('input[value*="'+edu_state+'"]').prop("selected", true); */
		/* $('#edu_state(1)').val('Y').prop("selected", true); */
		/* $('select[name=edu_state(1)]').val('Y').prop("selected", true); */
	}
	var num = 1;
	/* $("#edu_state(1)").val('Y').prop("selected", true); */
	/* $('select[name=edu_state]').each(function(){
		if(this.value == 'Y'){
			$('#edu_state').val(edu_state).prop("selected", true);
		}
	}); */
	/* $("select[name=edu_state]").each(function(index){
		alert(index + ' , ' + this.text());
		for(var i = 0; i<length; i++){
			var edu_state = list[i];
			alert(edu_state);
		} 
	}); */
});

function checkValue(){
		alert('평가기간은 ' +'${deadLine }' + ' 까지입니다.');
		document.replyInfo.method = "post";
		document.replyInfo.submit(); 
		self.close();
}
</script>
<body>
	<div id="wrap">
	    <br>
	    <b><font size="5" color="gray">수강자 평가</font></b>
	    <hr size="1" width="550">
	    <br>
	 
	    <div id="commentReplyForm">
	        <form name="replyInfo" target="parentForm">  
	        <input type="hidden" value="${edu_no }" name="edu_no"/>
	        	<table class="table1">
	        		<tr>
	        			<td>사번</td>
	        			<td>부서</td>
	        			<td>이름</td>
	        			<td>이수구분</td>
	        			<td>평가</td>
	        		</tr>
	        		<c:forEach items = "${edu_history }" var = "item" varStatus="status">
	        		<input type="hidden" value="${item.no }" name = "no" id="no"/>
	        			<tr>
	        				<td>
	        					${item.emp_no }
	        				</td>
	        				<td>
	        					${item.dept_name }
	        				</td>
	        				<td>
	        					${item.name }
	        				</td>
	        				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="now_date" /> 
	        				<fmt:parseDate value="${deadLine }" pattern="yyyy-MM-dd HH:mm:ss" var="close_date" /> 
							<fmt:formatDate value="${close_date }" pattern="yyyy-MM-dd HH:mm:ss" var="dead" /> 
								<c:choose>
									<c:when test="${dead < now_date}">
										<td>
				        					${item.edu_state}
				        				</td>
				        				<td>
				        					${item.instructor_eval }
				        				</td>
									</c:when>
									<c:otherwise>
										<td>
				        					<input type="hidden" value="${item.edu_state }" id = "state"/>
				        					<select name="edu_state" id="edu_state">
				        						<option value="I" <c:if test="${item.edu_state == 'I'}">selected</c:if>>이수선택</option> 
				        						<option value="Y" <c:if test="${item.edu_state == 'Y'}">selected</c:if>>Y</option>
				        						<option value="N" <c:if test="${item.edu_state == 'N'}">selected</c:if>>N</option>
				        					</select>
				        				</td>
				        				<td>
				        					<input type="text" name="instructor_eval" value="${item.instructor_eval }">
				        				</td>
									</c:otherwise>
								</c:choose>
								
							
	        			</tr>
	        		</c:forEach>
	        	</table>
	        	<br/>
	        	<br/>
	        	<br/>
	        		<c:if test="${dead > now_date}">
			          	<input type="button" value="저장" onclick="checkValue()">
			        </c:if>
		            	<input type="button" value="창닫기" onclick="window.close()">
	        		
	        </form>
	    </div>
	</div>    
</body>