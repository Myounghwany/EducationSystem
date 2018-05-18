<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="application"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- table css -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<title>Project Community Detail</title>
<style>
.hover{ color:#FF3333;}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){

	var project_no=${result.project_no};
	var emp_no = '<c:out value="${sessionScope.no}"/>';
	var likeCheck = ${likeCheck};
	
	console.log('likeCheck : '+likeCheck);
	console.log('emp_no : '+emp_no);
	
	if(likeCheck == 1){
		$("#fa-heart").attr("title","추천취소");
		$("#fa-heart").addClass('hover');
		
		$("#fa-heart").mouseenter(function(){
			$(this).removeClass('hover');		 
		}).mouseleave(function(){
					 $(this).addClass('hover');	
				 }
		 );
		
	}else{
		
		$("#fa-heart").attr("title","추천합니다");
		$("#fa-heart").mouseenter(function(){
			 $(this).addClass('hover');		 
		 			
		}).mouseleave(function(){
					 $(this).removeClass('hover');	
				 }
		 );
	}
	

	$("#fa-heart").click(function(){
		$.ajax({
			contentType : 'application/text; charset=utf-8',
			url : '${path}/ProjectCommunity/like.do',
			type : 'get',
			data : {
				'project_no' : project_no
			},
			dataType:"text",  
			success : function(data){
					console.log('data : '+data);
					location.href="${path}/ProjectCommunity/detail.do?project_no="+project_no;
			},
			error : function(request,status,error){
				alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});
	});

	
	
	/* 댓글 목록 */
		 $.ajax({
			contentType : 'application/text; charset=utf-8',
			url : '${path}/ProjectCommunity/CommentList.do',
			type : 'get',
			data : {
				'project_no':project_no
			},
			success : function(data){
					console.log('data : '+data);
					console.log('=================================');
					var a =''; 
					$.each(data, function(key, value){ 
						console.log('key : '+key+' value : '+value+'\n'+' data : '+data+'\n'+value.reply_no+' value.dep :'+value.dep);
						
						if(value.dep == 0){
							a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
			                a += '<div class="commentInfo'+value.reply_no+'">'+'<strong>'+value.writer_name+'('+value.writer+')</strong>&nbsp; '+value.write_time ;
			                a += '<div class="commentContent'+value.reply_no+'"><span id="replyContent'+value.reply_no+'"> '+value.content+'</span>' ;
			                a += '<div align="right"><button style="font-size: 12px;" class="btn btn-default commentWriteRBtn" value='+value.reply_no+' >답글</button>';
			                if(value.writer == emp_no){
				                a += '<button style="font-size: 12px;" class="btn btn-default commentUpdateRBtn" value='+value.reply_no+' >수정</button>';
				                a += '<button style="font-size: 12px;" class="btn btn-default commentDeleteRBtn" value='+value.reply_no+' >삭제</button>';
			                }
			                a += '</div></div></div></div><div id="commentWriteR'+value.reply_no+'"></div>'; 
						}else{
							a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;"><div class="commentInfo'+value.reply_no+'">';
			                for(var i=0; i<value.dep;i++) a+= '&nbsp;&nbsp;&nbsp;&nbsp;';
						  	a += '<img src="${path}/img/reply_icon.gif">&nbsp;<strong>'+value.writer_name+'('+value.writer+')</strong>&nbsp;'+value.write_time+'<br>';
						  	a += '<div class="commentContent'+value.reply_no+'">';
						  	for(var i=0; i<value.dep;i++) a+= '&nbsp;&nbsp;&nbsp;&nbsp;';
						  	a += '<span id="replyContent'+value.reply_no+'"> '+value.content+'</span>' ;
			                a += '<div align="right"><button style="font-size: 12px;" class="btn btn-default commentWriteRBtn" value='+value.reply_no+' >답글</button>';
			                if(value.writer == emp_no){
			               		 a += '<button style="font-size: 12px;" class="btn btn-default commentUpdateRBtn" value='+value.reply_no+' >수정</button>';
			               	 	 a += '<button style="font-size: 12px;" class="btn btn-default commentDeleteRBtn" value='+value.reply_no+' >삭제</button>';
			                }
			                a += '</div></div></div></div><div id="commentWriteR'+value.reply_no+'"></div>'; 
						}
						
		            }); 
		            
			         $(".commentList").html(a);
					
			         
			         function commentWriteRBtn(reply_no){
			        	 alert('commnetWriteRBtn');
			        	 alert(reply_no);
			         }
			         
			         
			},
			error : function(request,status,error){
				alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});	 

	/* 댓글 쓰기 */
	 $('#commentInsertBtn').click(function(){

		 $.ajax({
			contentType : 'application/text; charset=utf-8',
			url : '${path}/ProjectCommunity/CommentWrite.do',
			type : 'get',
			data : $('#commentInsertForm').serialize(),
			dataType:"text",  
			success : function(data){
					console.log('data : '+data);
			},
			error : function(request,status,error){
				alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
			}
		});	 
	});	 
	
	
	
	/* 댓글답글 - 답글 버튼 누르면 창 띄우기 */
	$(document).on("click", ".commentWriteRBtn", function(){
		var reply_no=$(this).val();	
		
		 console.log('project_no : '+project_no);
		 console.log('reply_no : '+reply_no);
		 
		 $("#commentWriteR"+reply_no).html(
		  '<form name="commentInsertFormR" id="commentInsertFormR" class="commentInsertFormR">'+
	         '<div class="input-group">'+
	            '<input type="hidden" name="project_no" value="'+project_no+'" />'+
	            '<input type="hidden" name="reply_no" value="'+reply_no+'" />'+
	            '<input type="text" class="form-control" class="content" id="content" name="content" placeholder="내용을 입력하세요.">'+
	            '<span class="input-group-btn">'+
	                 '<button class="btn btn-default commentReplyBtnR" value='+reply_no+' >등록</button>'+
	            '</span></div></form>'
			);
		 
	});
		
	/* 댓글답글 - 댓글 내용 핸들러에 값 넘기기 */
	$(document).on("click", ".commentReplyBtnR", function(){
		
		var reply_no=$(this).val();	
		var content=$('.commentInsertFormR [name="content"]').val();

		 console.log('project_no : '+project_no);
		 console.log('reply_no : '+reply_no);
		 console.log('content : '+content);
		
		$.ajax({
				contentType : 'application/text; charset=utf-8',
				url : '${path}/ProjectCommunity/CommentWrite.do',
				type : 'get',
				data : {
					'project_no':project_no,
					'reply_no':reply_no,
					'content' : content
				},
				dataType:"text",  
				success : function(data){
						console.log('data : '+data);
				},
				error : function(request,status,error){
					alert("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
					console.log("code : "+"\n"+request.status+"\n"+"message: "+"\n"+request.responseText+"\n"+" error : "+"\n"+error);
				}
			}); 
		
	});

	//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
	$(document).on("click", ".commentUpdateRBtn", function(){
		var reply_no=$(this).val();	
		var content = $('#replyContent'+reply_no).text();
		
		var a ='';
		a += '<form>'
	    a += '<div class="input-group">';
	    a += '<input type="text" class="form-control" name="content_'+reply_no+'" value="'+content+'"/>';
	    a += '<span class="input-group-btn"><button class="btn btn-default commentUpdateProc" type="button" value='+reply_no+'>수정</button> </span>';
	    a += '<span class="input-group-btn"><button class="btn btn-default" type="reset" onclick="location.href="${path}/ProjectCommunity/detail.do?project_no='+project_no+'">취소</button> </span>';
	    a += '</div>';
		a += '</form>'
	    $('.commentContent'+reply_no).html(a);
		
	    console.log('project_no : '+project_no);
		console.log('reply_no : '+reply_no);
		console.log('content : '+content);
		
	});
	
	//댓글 수정 
	$(document).on("click", ".commentUpdateProc", function(){
		var reply_no=$(this).val();	
		var content = $('[name=content_'+reply_no+']').val();
	    
	    console.log('project_no : '+project_no);
		console.log('reply_no : '+reply_no);
		console.log('content : '+content);
		
		$.ajax({
	        url : '${path}/ProjectCommunity/CommentUpdate.do',
	        type : 'get',
	        data : {'content' : content, 'reply_no' : reply_no},
	        success : function(data){
	        	alert('댓글이 수정되었습니다.');
	        	location.href="${path}/ProjectCommunity/detail.do?project_no="+project_no;
	        }
	    });
		
	});

	//댓글 삭제 
	$(document).on("click", ".commentDeleteRBtn", function(){
		var reply_no=$(this).val();	
	    
	    console.log('project_no : '+project_no);
		console.log('reply_no : '+reply_no);
		
		if(confirm('정말 삭제 하시겠습니까?')){

			$.ajax({
		        url : '${path}/ProjectCommunity/CommentDelete.do',
		        type : 'get',
		        data : {
		        	'reply_no' : reply_no,
		        	'project_no' : project_no
		        	},
		        success : function(data){
		        	alert('댓글이 삭제되었습니다.');
		        	location.href="${path}/ProjectCommunity/detail.do?project_no="+project_no;
		        }
		    });
					
		}
		
		
	});
	


	 
	 
	});
</script>
<link rel= "stylesheet" type="text/css" href="${path}/css/nahyun.css">

</head>
<jsp:include page="../common/header.jsp" />
<body>
<h1>Project Community Detail</h1>
<div style="width: 70%; margin: 20px auto">

	
	<span style="color: #FF5E00;"> <b>분류 : 	${result.classification}</b></span> <br>
	<table class="w3-table w3-bordered">
		<tr>
			<th colspan="4" style="background-color: #EAEAEA;"> Project Coummunity 상세보기 </th>
		</tr>
		<tr>
			<td width="7%">번호</td>
			<td width="7%">${result.project_no}</td>
			<td width="7%">조회수</td>
			<td width="7%">${result.hit}</td>
		</tr>
		<tr>
			<td width="15%">작성자</td>
			<td width="15%">${result.writer_name}(${result.writer})</td>
			<td width="15%">작성일</td>
			<td width="15%">${result.write_time}</td>
		</tr>
		<tr>
			<td>글제목</td>
			<td colspan="3">${result.title}</td>
		</tr>
		<tr height="100">
			<td colspan="4" height="400">
			<div style="word-break:break-all;">${result.content}</div>
			</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="3"><a
				href="${path}/ProjectCommunity/fileDownload.do?project_no=${result.project_no}">${result.file_ori_name}</a></td>
		</tr>
		<tr>
				<td colspan="4"><strong> 추천 <i id="fa-heart" class="fas fa-heart" title="추천합니다"></i>  ${projectLikeCount} 개 </strong>
			<c:if test="${result.writer eq sessionScope.no}">
					
					<div align="right">
						<input class="w3-button w3-white w3-border" type="button" value="글수정" onclick="location='${path}/ProjectCommunity/modify.do?project_no=${result.project_no}'">
						<input class="w3-button w3-white w3-border" type="button" value="글삭제" 
						onclick="if(confirm('정말 삭제 하시겠습니까?')){location='${path}/ProjectCommunity/delete.do?project_no=${result.project_no}'}">
					</div>
			</c:if>
				</td>
		</tr>
		
		
		
	</table>
	
	<div align="center" class="goList">
		<input class="w3-button w3-white w3-border" type="button" value="목록보기" onclick="location='${path}/ProjectCommunity.do'">
	</div><br>
	
  <!--  댓글  -->
     <label for="content">comment</label>
  	<c:if test="${commentListCount ne 0}">
		<strong style="padding-left: 10px">댓글 : ${commentListCount} 개</strong><br>
  	</c:if>
     
     <form name="commentInsertForm" id="commentInsertForm">
         <div class="input-group">
            <input type="hidden" name="project_no" value="${result.project_no}"/>
            <input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요.">
            <span class="input-group-btn">
                 <button class="btn btn-default" type="submit" id="commentInsertBtn">등록</button>
            </span>
           </div>
     </form>
 
     <div class="commentList"></div>


	</div>
</body>
</html>