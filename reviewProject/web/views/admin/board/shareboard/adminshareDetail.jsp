<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard, memberSharedComment.model.vo.SharedComment, java.util.ArrayList, java.sql.Date"%>
<% 
	SharedBoard sb = (SharedBoard)request.getAttribute("sb"); 
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int limit = (Integer)request.getAttribute("limit");
	int endPage = (Integer)request.getAttribute("endPage");
	ArrayList<SharedComment> commentList = (ArrayList<SharedComment>)request.getAttribute("commentList");
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
</head>
<body>
<%@ include file = "../../../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge"><%= sb.getPostingNum()%>번 공지글 상세보기</span></a> <a
				href="#"><span class="badge">조회수 : <%=sb.getHits() %></span></a> <a
				href="#"><span class="badge">날짜 : <%=sb.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%= sb.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><%=sb.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=sb.getContent() %></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<a href="/review/adminsbfdelete?no=<%= sb.getPostingNum() %>&currentPage=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>" class="btn btn-default">삭제</a>
						<a href="/review/adminsblist?page=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>" class="btn btn-default">목 록</a>
					</div>
				</div>
			</div>
		</div>
	</div>

		<div class="col-sm-5">
			<div class="badge">댓글을 입력해주세요</div>
		</div>

		<div class="col-sm-8 col-md-9">
			<div class="comment comment_new">
				<div class="comment__author_img">
					<%=member.getName()%><font color="#4D81B0">[<%=member.getId()%>]</font>
				</div>
				<div class="comment__content">
					<form>
						<div class="form-group" style="float: left; width: 80%">
							<label for="comment-new__textarea" class="sr-only">Enter
								your comment</label>
							<textarea class="form-control" rows="2" id="commentContent"
								placeholder="Enter your comment"></textarea>
						</div>
						<div style="float: left; width: 20%">
						<button type="button" id="sendComment" class="btn"
							onclick="return insertComment();" style="color: white;">Send Comment</button>
						</div>
					</form>
				</div>
			</div>
			<!-- Comments header -->
			<div class="comment__header">
				<span><font color="red">List of Comments</font></span>
			</div>
			<!-- 댓글 보여주는 자리-->
			<div id="viewComment"></div>

		</div>

</div>

<!-- 자바스크립트 -->
<script type="text/javascript">
    $(function(){
    	selectComment();
    	
    	$("#commentContent").keydown(function(key){
    		if(key.keyCode==13){
    			insertComment();
    		}
    	})
    });
    
    function selectComment(){
    	var sharePostNum = "<%=sb.getPostingNum()%>";
    	
    	$.ajax({
    		url:"/review/adminSharecomment.do",
    		data: {postNum: sharePostNum},
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
    										"아이디 :"+decodeURIComponent(json.list[i].id)+ 
    									"</div>"+
    									"시간: "+ decodeURIComponent(json.list[i].date).replace(/\+/gi," ") +
    									"<br>댓글내용 :"+
    									"<input type='hidden' id='editComment" +json.list[i].commentNo+ "' value='"+decodeURIComponent(json.list[i].content)+"' ><p>"+decodeURIComponent(json.list[i].content).replace(/\+/gi, " ")+"</p>" +
    										"<div class='btn-group pull-right' role='group' aria-label='comment__actions'>"+
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
											"<br>댓글내용 :" +
											"<h2>"+decodeURIComponent(json.list[i].content).replace(/\+/gi, " ")+"</h2>"
											+"<hr>"
					
    					}
    				}
    				
    				$("#viewComment").html(values);
    		}
    	})
    }
    
    function insertComment(){	//댓글 삽입
    	if($("#commentContent").val()==""){
    		alert("댓글 내용을 입력해 주세요!");
    		focus("#commentContent");
    		return false;
    	}else{
    		var postNum = "<%=sb.getPostingNum()%>";
    		var id = "<%=member.getId()%>";
    		var content = $("#commentContent").val();
    		$.ajax({
    			url:"/review/insertSharedComment.do",
    			data:{postNum:postNum, id:id, content:content},
    			type:"get",
    			async:false
    		});    		
    		$("#commentContent").val("");
    		selectComment();
    		return true;
    	}
    }
    
    function removeCommentFun(commentNo){	//댓글 삭제
		//넘겨야 될 값 : 게시글 번호, 댓글 번호, 아이디
		if(confirm("정말 댓글을 삭제하시겠습니까?")==false){
			return false;
		}else{
			var postNum = "<%=sb.getPostingNum()%>";
			var id = "<%=member.getId()%>";
			var commentNum = commentNo+"";
			$.ajax({
				url:"/review/deleteSharedComment.do",
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
		var postNum = "<%=sb.getPostingNum()%>";
		var id = "<%=member.getId()%>"
		var commentNum = commentNo+"";
		
		var content = $("#reply").val().replace(/\+/gi," ");
				
		if(content===""){
			alert("댓글 내용을 입력해주세요");
			return false;
		}else{
			$.ajax({
				url:"/review/updateSharedComment.do",
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