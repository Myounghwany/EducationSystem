<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</style>
<script>
$(document).ready(function(){
	
	$('#edu_state').val('Y').prop("selected", true);
});

function checkValue(){
	if(!document.replyInfo.instructor_eval.value==''){
		alert('평가를 입력하세요');
		document.replyInfo.instructor_eval.focus();
	}else{
		document.replyInfo.method = "post";
		document.replyInfo.submit(); 
		self.close();
		/* window.opener.document.location.reload(); 
        opener.evalForm = null;
        self.close(); */
	} 
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
	        	<table>
	        		<tr>
	        			<td>사번</td>
	        			<td>부서</td>
	        			<td>이름</td>
	        			<td>이수구분</td>
	        			<td>평가</td>
	        		</tr>
	        		<c:forEach items = "${edu_history }" var = "item">
	        		<input type="hidden" value="${item.no }" name = "no"/>
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
	        				<td>
	        					<!-- hidden으로 item.edu_state넣어주기 -->
	        					<select name="edu_state" id="edu_state">
	        						<option value="I" >교육진행중</option>
	        						<option value="Y" >Y</option>
	        						<option value="N" >N</option>
	        					</select>
	        				</td>
	        				<td>
	        					<input type="text" name="instructor_eval" value="${item.instructor_eval }">
	        				</td>
	        			</tr>
	        		</c:forEach>
	        		
	        	</table>
	          	<input type="button" value="저장" onclick="checkValue()">
            	<input type="button" value="창닫기" onclick="window.close()">
	        </form>
	    </div>
	</div>    
</body>