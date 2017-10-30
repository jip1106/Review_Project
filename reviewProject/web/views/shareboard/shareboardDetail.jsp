<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard,java.util.*,memberSharedComment.model.vo.SharedComment,java.sql.Date"%>
<%
	SharedBoard share = (SharedBoard)request.getAttribute("sharedBoard");
	int currentPage = (Integer)request.getAttribute("currentPage");
	int index = (Integer)request.getAttribute("index");

	int location = 0;

	if(index==1){
		location=1;
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
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

<style type="text/css">

	div a#listBtn:hover{
		background: #C2D6E9;
	}
	
	div a#listBtn{
		background: #4D81B0;
	}
	</style>
	
</head>
<body>
<%@include file="../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<span class="badge">No.<%= share.getPostingNum() %></span>
			<span class="badge">조회수 : <%= share.getHits() %></span>	
			<span class="badge">날짜 : <%= share.getPostingDate() %></span>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
		<label style="color:red;">작성자 : </label>
			<a href="/review/ssearch?searchMenu=findByWriter&keyword=<%=share.getId()%>&page=1"
			style="color:black;"><%= share.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><%= share.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%= share.getContent() %></td>
						</tr>
					</table>
				</div>
				
				<div>
					<div align="center">
				<% if(member.getId().equals(share.getId())) {%>
						<a style="color: white;" 
						href="/review/supview?no=<%= share.getPostingNum() %>&page=<%=currentPage %>" 
						class="btn btn-default" id="listBtn">수정</a>
						
						<a style="color: white;" class="btn btn-default" onclick="board_delete()" id="listBtn">삭제</a>
						
						<a style="color: white;" 
						href="/review/slist?page=<%= currentPage %>" 
						class="btn btn-default" id="listBtn">목 록</a>
				<% }else{ %>
						<a href="/review/slist?page=<%= currentPage %>" class="btn btn-default" id="listBtn">목 록</a>
				<%} %>
					</div>
				</div>
		</div>
	</div>
</div>
</div>
<br>

<!-- 게시글 삭제여부 재확인 -->
<script>
function board_delete(){
	if(confirm("해당 게시글을 삭제하시겠습니까?")){
		location.href="/review/sdelete?no=<%= share.getPostingNum() %>&location=<%=location %>&index=<%= index %>&page=<%=currentPage%>";
	}else{
		return false;
	}
}
</script>

<!-- 댓글공간 -->

	<div class="badge">댓글을 입력해주세요</div>
	<br><br>
			<div class="comment__author_img">	
				<%=member.getName()%><font color="#4D81B0">[<%=member.getId() %>]</font>
			</div>
			<div class="comment__content">
				<form>
					<div class="form-group" style="float: left; width: 80%">
	
					<label for="comment-new__textarea" class="sr-only">Enter your comment</label>
						<textarea class="form-control" rows="1" id="commentContent" placeholder="Enter your comment" style="width: 98%"></textarea>
					</div>
					<div style="float: left; width: 20%">
						<button type="button" id="sendComment" class="btn" onclick="return insertComment();" style="color: white;">Send Comment</button> 
					</div>
				</form>
			</div>
			<br>
			
		<!-- Comments header -->
		<div class="comment__header">
			<span><font color="red">List of Comments</font></span>
		</div>
		
		<!-- 댓글 보여주는 자리-->
		<div id="viewComment">
		</div>
		
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
		var boardPostNum = "<%=share.getPostingNum() %>";
		
		$.ajax({
			url: "/review/shareComment.do",
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
    									"<font color='#4D81B0'>시간: </font>"+ decodeURIComponent(json.list[i].date).replace(/\+/gi," ") +
    									"<br><div style='float:left; width:'80%'><font color='#4D81B0'>댓글내용 : &nbsp;</font></div>"+
    									"<div style='float:left; width:'20%'><input type='hidden' id='editComment" +json.list[i].commentNo+ "' value='"+decodeURIComponent(json.list[i].content)+"' ><p>"+decodeURIComponent(json.list[i].content).replace(/\+/gi, " ")+"</p>" +
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
											"<br>댓글내용 :" +
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
			var postNum = "<%=share.getPostingNum()%>";
			var id = "<%=member.getId()%>";
			var content = $("#commentContent").val();
			$.ajax({	
				url:"/review/scInsert.do",
				data:{postNum:postNum, id:id, content:content}, //key,value
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
			var postNum = "<%=share.getPostingNum()%>";
			var id = "<%=member.getId()%>";
			var commentNum = commentNo+"";
			$.ajax({
				url:"/review/smdelete.do",
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
		var postNum = "<%=share.getPostingNum()%>";
		var id = "<%=member.getId()%>"
		var commentNum = commentNo+"";
		
		var content = $("#reply").val().replace(/\+/gi," ");
				
		if(content===""){
			alert("댓글 내용을 입력해주세요");
			return false;
		}else{
			$.ajax({
				url:"/review/smupdate.do",
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
</body>
</html>
		