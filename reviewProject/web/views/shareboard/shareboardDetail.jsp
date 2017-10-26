<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard,java.util.*,memberSharedComment.model.vo.SharedComment,java.sql.Date"%>
<%
	SharedBoard share = (SharedBoard)request.getAttribute("sharedBoard");
	ArrayList<SharedComment> commentList = (ArrayList<SharedComment>)request.getAttribute("commentList");
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


</head>
<body>
<%@include file="../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge">No.<%= share.getPostingNum() %></span></a> 
			<a href="#"><span class="badge">조회수 : <%= share.getHits() %></span></a> 	
			<a href="#"><span class="badge">날짜 : <%= share.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%= share.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well">글제목 : <%= share.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%= share.getContent() %></td>
						</tr>
					</table>
				</div>
				
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
				<% if(member.getId().equals(share.getId())) {%>
						<a href="/review/supview?no=<%= share.getPostingNum() %>" class="btn btn-default">수정</a>
						<a href="/review/sdelete?no=<%= share.getPostingNum() %>&location=<%=location %>&index=<%= index %>" class="btn btn-default">삭제</a>
						<a href="/review/slist" class="btn btn-default">목 록</a>
				<% }else{ %>
						<a href="/review/slist" class="btn btn-default">목 록</a>
				<%} %>
					</div>
				</div>
		</div>
	</div>
</div>
</div>
<br>

<!-- 댓글공간 -->
<script type="text/javascript">
$(document).ready(function(){
	var boardNo = "<%=share.getPostingNum()%>";
	var userId = "<%=member.getId()%>";
	var content = "";
	var commentNo = "";
	
	//댓글 등록
	$("#sendComment").click(function() {
		var comment = $("#sendContent").val(); 
		var queryString = {no:boardNo, id:userId, content:comment};
		
		$.ajax({
			type : "get",
			url : "/review/sminsert.do",
			data : queryString,
			dataType: "json",
			success : function(data) { 
				var json = "";
				var j = JSON.parse(JSON.stringify(data));
				
				for (var i in j.list) {
					json += "<div class='comment'>";
					json += "<div class='comment__content' id='commentresetView'>";
					json += "<div class='comment__author_name'>"
					json += "아이디: "+decodeURIComponent(j.list[i].userId);
					json += "</div>";
					json += "시간: "+j.list[i].timePosted;
					json += "<br> 댓글내용";
					json += "<p>";
					json += j.list[i].content;
					json += "</p>";
					var id = decodeURIComponent(j.list[i].userId);
					var nowid="";
					nowid = "<%=member.getId()%>";  

					if (id == nowid) {
						json += "<div class='btn-group pull-right' role='group' aria-label='comment__actions'>";
						json += "<a id='removeComment' class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
						json += "<a id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
						json += "</div>"
					}
					json += "<input type='hidden' id='commentNo' value="
					json += j.list[i].commentNo
					json +=">"
					json += "</div></div>";
				}
				 $("#commentView").html(json);
				 
				// textarea 리셋
					var deleteArea = "";
					deleteArea += "<textarea class='form-control' rows='2' id='sendContent' placeholder='Enter your comment'></textarea>";
					$("#deleteArea").html(deleteArea);  
			}
			}); 
		}); 
	}); 
	
//삭제하기
$(document).on("click","#removeComment",function() {
					if (confirm("댓글을 삭제하시겠습니까?")) {
						var boardNo = "<%=share.getPostingNum()%>";
						commentNo = $(this).parent().next().val();
						var queryString = {sNo: boardNo, cNo: commentNo};
						$.ajax({
									type : "get",
									url : "/review/smdelete.do",
									data : queryString,
									dataType: "json",
									success : function(data) {
										var json = "";
										var j =  JSON.parse(JSON.stringify(data));
										for (var i in j.list) {
											json += "<div class='comment'>";
											json += "<div class='comment__content' id='commentresetView'>";
											json += "<div class='comment__author_name'>"
											json += "아이디: "+decodeURIComponent(j.list[i].userId);
											json += "</div>";
											json += "시간: "+j.list[i].timePosted;
											json += "<br> 댓글내용";
											json += "<p>";
											json += decodeURIComponent(j.list[i].content);
											json += "</p>";
											var id = decodeURIComponent(j.list[i].userId);
											var nowid="";
											nowid = "<%=member.getId()%>";

											if (id == nowid) {
												json += "<div class='btn-group pull-right' role='group' aria-label='comment__actions'>";
												json += " <a id='removeComment' class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
												json += " <a id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
												json += "</div>"
											}
											json += "<input type='hidden' id='commentNo' value="
											json += j.list[i].commentNo
											json +=">"
											json += "</div></div>";
										}
										$("#commentView").html(json);
									}
								}); //ajax
					} else {
						location.href = "/review/shareboardDetail?no=<%=share.getPostingNum()%>&page=<%=currentPage%>";
					}
				}); //commentView 삭제하기 버튼
				
				//수정하기
$(document).on("click","#editComment",function() {
					content = $(this).parent().prev().html().trim();
					commentNo = $(this).parent().next().val();
					$("#commentresetView").empty();
					$("#commentresetView").html("<textarea class='form-control'"+"rows='2' id='comment'>"
					+ content+ "</textarea>"+ "<a id='updateComment' class='btn btn-default btn-xs'>"
				+ "<i class='fa fa-edit'></i> 수정하기</a>");

				});//editComment (댓글 수정)

				//댓글 수정 처리
$(document).on("click","#updateComment",function(){
				if(confirm("댓글을 수정하시겠습니까?")){
					var boardNo = "<%=share.getPostingNum()%>";
					content = $(this).prev().val();
					var queryString = {sNo: boardNo, cNo: commentNo, scontent: content};
					$.ajax({
								type : "get",
								url : "/review/smupdate.do",
								data : queryString,
								dataType: "json",
								success : function(data) {
									var json = "";
									var j =  JSON.parse(JSON.stringify(data));
									for (var i in j.list) {
										json += "<div class='comment'>";
										json += "<div class='comment__content' id='commentresetView'>";
										json += "<div class='comment__author_name'>"
										json += "아이디: "+decodeURIComponent(j.list[i].userId);
										json += "</div>";
										json += "시간: "+j.list[i].timePosted;
										json += "<br> 댓글내용";
										json += "<p>";
										json += j.list[i].content;
										json += "</p>";
										var id = decodeURIComponent(j.list[i].userId);
										var nowid="";
										nowid = "<%=member.getId()%>";

										if (id == nowid) {
											json += "<div class='btn-group pull-right' role='group' aria-label='comment__actions'>";
											json += " <a id='removeComment' class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
											json += " <a id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
											json += "</div>"
										}
										json += "<input type='hidden' id='commentNo' value="
										json += j.list[i].commentNo
										json +=">"
										json += "</div></div>";
									}
									$("#commentView").html(json);
								}
						}); //ajax
					 }else{
						 location.href = "/review/shareboardDetail?no=<%=share.getPostingNum() %>&page=<%=currentPage%>";
					 }//confirm
				}); //commentView 수정하기 버튼
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
								<div id="deleteArea">
								<textarea class="form-control" rows="2" id="sendContent" placeholder="Enter your comment"></textarea>
							</div>
							<button type="button" id="sendComment" class="btn btn-primary" >Send Comment</button> 
						</form>
					</div>
					<!-- / .comment__content -->
				</div>
				<!-- / .comment__new -->
				
				<!-- Comments header -->
				<div class="comment__header">
					<span>List of Comments</span>
				</div>
				
<!-- All comments -->
				<div id="commentView">
					
					<%for(int i = 0; i<commentList.size(); i++){%>
						<div class="comment">
							<div class="comment__content" id="commentresetView">
								<div class="comment__author_name">
									아이디: <%=commentList.get(i).getId()%> 
								</div>
									시간: <%= commentList.get(i).getCommentStringDate()%><br>
									댓글내용
									<p><%=commentList.get(i).getCommentContent()%></p> 
									
								<%if(member.getId().equals(commentList.get(i).getId())){%> 
									<div class="btn-group pull-right" role="group" aria-label="comment__actions">
										<a id="removeComment" class="btn btn-default btn-xs"><i class="fa fa-times"></i>Remove</a> 
										<a id="editComment" class="btn btn-default btn-xs"><i class="fa fa-edit"></i>Edit</a> 
									</div>
									<input type="hidden" id="commentNo" value="<%=commentList.get(i).getCommentNo()%>">
								<%}%>
							</div>
							<!-- / .comment__content -->
						</div>
						<!-- / .comment -->
					<%}%>
				</div>
			</div>
</body>
</html>
		