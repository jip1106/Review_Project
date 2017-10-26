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
</head>
<body>
<%@ include file = "../../../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
		<!-- <session> -->
			<span class="badge"><%= board.getPostingNo() %>번 글 상세보기</span>
			<span class="badge">조회수 : <%= board.getHits() %></span>
			<span class="badge">날짜 : <%= board.getPostingDate() %></span>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%= board.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><%= board.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%= board.getContent() %></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<!-- 게시판 제목 눌러서 상세보기 했을 때 관리자가 삭제할 수 있게 해주는 서블릿 cbdfDelete -->
						<a href="cbdfDelete?postno=<%= board.getPostingNo()%>&currentPage=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>" class="btn btn-default">삭제 하기</a> <!-- 상세보기에서 삭제하는 서블릿 연결 -->
						
						<a href="cblist?page=1" class="btn btn-default">목 록 보기</a>	<!-- 목록 돌아가는거 연결 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function(){
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
										"아이디 :"+decodeURIComponent(json.list[i].id)+ 
									"</div>"+
										"시간: "+ decodeURIComponent(json.list[i].date).replace(/\+/gi," ") +
										"<br>댓글내용" + decodeURIComponent(json.list[i].content) +
										"<p>"+decodeURIComponent(json.list[i].content)+"</p>" +
									
										"<div class='btn-group pull-right' role='group' aria-label='comment__actions'>"+
											"<a id='removeComment'class='btn btn-default btn-xs'><i class='fa fa-times'></i>Remove</a>"+ 
											"<a id='editComment'class='btn btn-default btn-xs'><i class='fa fa-edit'></i>Edit</a>"+ 
										"</div>"+									
								"</div>" +
							"</div>" + "<hr>";
						}else{
														
							values +=
								"<div class='comment'>"+
									"<div class='comment__content' id='commentresetView'>"+
										"<div class='comment__author_name'>"+									
											"아이디 : "+decodeURIComponent(json.list[i].id)+ 
										"</div>"+
											"시간: "+ decodeURIComponent(json.list[i].date).replace(/\+/gi, " ") +
											"<br>댓글내용" +
											"<p>"+decodeURIComponent(json.list[i].content)+"</p>"
											+"<hr>"
					
						}
					}
				
				$('#viewComment').html(values);
			},error: function(data){
				alert("에러");
			}
		})
	});
</script>

<div class="col-sm-5">
		<div class="badge">댓글을 입력해주세요</div>
</div> 
	<div class="col-sm-8 col-md-9">
		<div class="comment comment_new">
			<div class="comment__author_img"><%=member.getName()%></div>
				<div class="comment__content">
					<form>
						<div class="form-group">
							<label for="comment-new__textarea" class="sr-only">Enteryour comment</label>
								<textarea class="form-control" rows="2" id="comment" placeholder="Enter your comment"></textarea>
						</div>
						<button type="button" id="sendComment" class="btn btn-primary" >Send Comment</button> 
					</form>
				</div>
		</div>
	
				<!-- / .comment__new -->
				
				<!-- Comments header -->
				<div class="comment__header">
					<span>List of Comments</span>
				</div>

				<!-- 댓글 보여주는 자리-->
				 <div id="viewComment">
						
				</div>
			</div> 
			
</body>
</html>