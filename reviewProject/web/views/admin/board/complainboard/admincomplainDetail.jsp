<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard,memberComplainComment.model.vo.ComplainComment"%>
<%
	ComplainBoard board = (ComplainBoard)request.getAttribute("board");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int limit = (Integer)request.getAttribute("limit");
	int endPage = (Integer)request.getAttribute("endPage");
	
	
%>   
<!DOCTYPE html>
<html lang="en"> 
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset=utf-8>
    <!--<link rel="icon" href="img/favicon.ico">-->
	
	<!-- CSS Global -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

    <!-- CSS Plugins -->
    <link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
    
    <script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script> 
    
    
    <style type="text/css">
.btn {
	background: #4D81B0;
	background-image: -webkit-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -moz-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -ms-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -o-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: linear-gradient(to #4D81B0, #4D81B0, #4D81B0);
	-webkit-border-radius: 4;
	-moz-border-radius: 4;
	border-radius: 4px;
	font-family: Arial;
	color: #ffffff;
	font-size: 20px;
	padding: 10px 20px 10px 20px;
	text-decoration: none;
}

.btn:hover {
	background: #C2D6E9;
	background-image: -webkit-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -moz-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -ms-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -o-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: linear-gradient(to bottom, #C2D6E9, #C2D6E9);
	text-decoration: none;
}


</style>
    
</head>
<body>
<%@ include file = "../../../../header.jsp" %>
<div class="container">
<div align="left" style="margin-left: 10%; margin-right: 10%">
		<div style="float: left;">
		<!-- <session> -->
			<span class="badge">No. <%= board.getPostingNo() %></span>
			<span class="badge">조회수 : <%= board.getHits() %></span>
			<span class="badge">날짜 : <%= board.getPostingDate() %></span>
		</div>
		<div style="float: right;">
			<font color="red">작성자 : </font><font color="black"><%= board.getId() %></font>
		</div>
	<br><br>
				<div class="well well"><%= board.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%= board.getContent() %></td>
						</tr>
					</table>
						<br><br><br><br><hr>
				</div>
				<div align="center">
						<!-- 게시판 제목 눌러서 상세보기 했을 때 관리자가 삭제할 수 있게 해주는 서블릿 cbdfDelete -->
						<a href="cbdfDelete?postno=<%= board.getPostingNo()%>&currentPage=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>" class="btn btn-primary" style="width: 100px; background: red; color: white">삭제 하기</a> <!-- 상세보기에서 삭제하는 서블릿 연결 -->
						<a href="cblist?page=<%=currentPage %>" class="btn btn-primary" style="width: 100px; background: red; color: white">목 록 보 기</a>	<!-- 목록 돌아가는거 연결 -->
				</div>
	<br>
	<div class="comment comment_new">
			<div class="comment__author_img">	
				<%=member.getName()%><font color="#4D81B0">[<%=member.getId() %>]</font>
			</div>
			<div class="comment__content">
				<form>
					<div style="float: left; width: 80%">
	
					<label for="comment-new__textarea" class="sr-only">Enter your comment</label>
						<textarea class="form-control" rows="1" id="commentContent" placeholder="Enter your comment" style="width: 98%"></textarea>
					</div>
					<div style="float: right; width: 15%">
						<button type="button" id="sendComment" class="btn" onclick="return insertComment();" style="color: white;">Send Comment</button> 
					</div>
				</form>
			</div>
			</div>
	<br><br>
		<!-- Comments header -->
		<div class="comment__header">
			<span><font color="red">List of Comments</font></span>
		</div>
		<!-- 댓글 보여주는 자리-->
		<div id="viewComment">
		</div>
	</div>
<script type="text/javascript">

	$(function(){
		selectComment();
		
		$("#commentContent").keydown(function(key){
			if(key.keyCode==13){
				insertComment();
				$("#commentContent").val("");
				
			}
		})
		
	
		
		
	});
	
	function selectComment(){
		var boardPostNum = "<%=board.getPostingNo() %>";
		
		$.ajax({
			url: "/review/adminComplaincomment.do",
			data: {postNum:boardPostNum},
			type: "get",
			dataType : "json",
			success: function(data){
				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);
				var memberId = "<%=member.getId()%>";
							
				var values="";
					for(var i in json.list){   
						if(memberId === decodeURIComponent(json.list[i].id)){
    						values +=
    							"<div class='comment'>"+
    								"<div class='comment__content' id='commentresetView'>"+
    									"<div class='comment__author_name'>"+									
    										"<font color='#4D81B0'>아이디 : </font>"+decodeURIComponent(json.list[i].id)+ 
    									"</div>"+
    									"<font color='#4D81B0'><b>시간 : </b></font>"+ decodeURIComponent(json.list[i].date).replace(/\+/gi," ") +
    									"<br><div style='float:left; width: 10%'><font color='#4D81B0'>댓글내용 ▶</font></div>"+
    									"<div style='float:left; width: 90%'><input type='hidden' id='editComment" +json.list[i].commentNo+ "' value='"+decodeURIComponent(json.list[i].content)+"' ><p>"+decodeURIComponent(json.list[i].content).replace(/\+/gi, " ")+"</p>" +
    										"</div><div class='btn-group pull-right' role='group' aria-label='comment__actions'>"+
    											"<a id='removeComment'class='btn btn-default btn-xs' onclick='return removeCommentFun("+json.list[i].commentNo+");'><i class='fa fa-times'></i>Remove</a>"+ 
    											"<a id='editButton' class='btn btn-default btn-xs' onclick='viewEditCommentFun("+json.list[i].commentNo+");'><i class='fa fa-edit'></i>Edit</a>"+ 
    										"</div>"+	
    								"</div>" +
    								"<div id='updateWriteForm"+json.list[i].commentNo+"'>" + "</div>" +
    							"</div>" + "<hr>";
						}else{														
							values +=
								"<div class='comment'>"+
									"<div class='comment__content' id='commentresetView'>"+
										"<div class='comment__author_name'>"+									
											"아이디 : "+decodeURIComponent(json.list[i].id)+ 
										"</div>"+
											"시간: "+ decodeURIComponent(json.list[i].date).replace(/\+/gi, " ") +
											"<br><div style='float:left; width: 10%'>댓글내용 ▶</div>" +
											decodeURIComponent(json.list[i].content).replace(/\+/gi, " ")
											+"<hr>"
					
						}
					}
				
				$('#viewComment').html(values);
			},error: function(data){
				alert("에러");
			}
		})
	}	
	
	function insertComment(){
		if($("#commentContent").val() ==""){
			alert("댓글 내용을 입력해주세요!");
			focus("#commentContent");
			return false;
		}else{
			var postNum = "<%=board.getPostingNo()%>";
			var id = "<%=member.getId()%>";
			var content = $("#commentContent").val();
			$.ajax({	
				url:"/review/insertComplainComment.do",
				data:{postNum:postNum, id:id, content:content}, //key,value
				type:"get",
				async:false
			
			});
		
			
			selectComment();
						
			return true;
			
		}
	}
	
	function removeCommentFun(commentNo){	//댓글 삭제
		//넘겨야 될 값 : 게시글 번호, 댓글 번호, 아이디
		if(confirm("정말 댓글을 삭제하시겠습니까?")==false){
			return false;
		}else{
			var postNum = "<%=board.getPostingNo()%>";
			var id = "<%=member.getId()%>";
			var commentNum = commentNo+"";
			$.ajax({
				url:"/review/deleteComplainComment.do",
				data:{postNum:postNum, id:id, commentNum:commentNum},
				type:"get",
				async:false
			})
			
			selectComment();
			alert("삭제 되었습니다.");
			return true;
		}
	}
	
	function viewEditCommentFun(commentNo){	
			
		var commentNum = commentNo+"";		
		var divId = '#updateWriteForm'+commentNum;
		var editCommentId = '#editComment'+commentNum;
		
		var previousContent = $(editCommentId).val().replace(/\+/gi, " ");
		
		
		var values="<div><textarea class='form-control'"+"rows='2' id='reply'>"
		+ previousContent+ "</textarea>"+ "<a id='updateComment' class='btn btn-default btn-xs' onclick='return editCommentFun(" +commentNum+ ")'>"
		+ "<i class='fa fa-edit'></i> 수정하기</a></div>"
		
		$(divId).html(values);
	}
	
	function editCommentFun(commentNo){ //댓글 수정
		var postNum = "<%=board.getPostingNo()%>";
		var id = "<%=member.getId()%>"
		var commentNum = commentNo+"";
		
		var content = $("#reply").val().replace(/\+/gi," ");
				
		if(content===""){
			alert("댓글 내용을 입력해주세요");
			return false;
		}else{
			$.ajax({
				url:"/review/updateComplainComment.do",
				data:{postNum:postNum , commentNum:commentNum , id:id, content:content},
				type:"get",
				async:false
			})
					
			selectComment();
			alert("수정완료");
			return true;
		}
	}

		
</script>
<%@ include file = "../../../../footer.jsp" %>

</body>
</html>