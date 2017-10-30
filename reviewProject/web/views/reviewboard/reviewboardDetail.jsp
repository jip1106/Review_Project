<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="memberReviewBoard.model.vo.ReviewBoard ,memberReviewComment.model.vo.ReviewComment, java.util.ArrayList, java.sql.Date"%>
<% 
	ReviewBoard review = (ReviewBoard)request.getAttribute("review");
	int currentPage = (Integer)request.getAttribute("currentPage");
	ArrayList<ReviewComment> commentList = (ArrayList<ReviewComment>)request.getAttribute("commentList");
%> 
<!DOCTYPE html>
<html lang="en"> 
<head>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=5a5f74b55c137eef83dc34e43b7a72b7&libraries=services"></script>
<script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script> 

<title>reviewboardDetail</title>
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
			<span class="badge">No. <%=review.getPosting_no()%></span>
			<span class="badge">조회수 : <%=review.getHits()%></span>
			<span class="badge">날짜 : <%=review.getPostingDate()%></span>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			작성자 : <%=review.getId()%> &nbsp;
			좋아요 : <%=review.getLikes()%> &nbsp;
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><%=review.getTitle()%></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=review.getContent()%></td> 
						</tr>
					</table>
					<br><br><br><br><hr>
					<table align="left">
						<tr>
							<td>		
							<%if(review.getRenameImageName()!= null){ %> 
								<div class="col-sm-8">
										<div class="badge">이미지</div>
								</div> 
								<div class="item">
									 <img src="/review/uploadfile/<%=review.getRenameImageName()%>" width="250px" height="250px" alt="...">
								</div>
							
							<%}%>					
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td>
									<div class="col-sm-8">
										<div class="badge">위치정보</div>
									</div> 
								<div id="map" style="width: 250px; height: 250px; align:right"></div>
							</td>
						</tr>						
					</table>
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<%if(member.getId().equals(review.getId())){%>
						<a href="/review/ReviewUpdateView?no=<%=review.getPosting_no()%>&page=<%=currentPage%>" class="btn btn-default">수정</a>
						<a href="/review/reviewDelete?no=<%=review.getPosting_no()%>" class="btn btn-default">삭제</a>
						<a href="/review/reviewLikeUp?no=<%=review.getPosting_no()%>&writer=<%=member.getId()%>&page=<%=currentPage%>" class="btn btn-default">좋아요</a>
						<%}else{%>
						<a href="/review/passNoTitle?reviewNo=<%=review.getPosting_no()%>&reviewTitle=<%=review.getTitle() %>" class="btn btn-default">신고</a>
						<a href="/review/reviewLikeUp?no=<%=review.getPosting_no()%>&writer=<%=member.getId()%>&page=<%=currentPage%>" class="btn btn-default">좋아요</a>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new daum.maps.Map(mapContainer, mapOption);
		var geocoder = new daum.maps.services.Geocoder();
		var fullAddr = '<%=review.getAddress()%>'; //이곳에 장소 넣어줌
		// 주소로 좌표를 검색합니다
		geocoder.addr2coord(fullAddr, function(status, result) {

			// 정상적으로 검색이 완료됐으면 
			if (status === daum.maps.services.Status.OK) {
				var coords = new daum.maps.LatLng(result.addr[0].lat,
						result.addr[0].lng);
				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new daum.maps.Marker({
					map : map,
					position : coords
				});
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});
	</script>
	<br><br><br><br>
	<!-- 댓글공간 -->
<script type="text/javascript">
    	$(document).ready(function(){
    		var boardNo = "<%=review.getPosting_no()%>";
    		var userId = "<%=member.getId()%>";
    		var content = "";
			var commentNo = "";
			$("#sendComment").click(function() {
								var comment = $("#sendContent").val(); 
								var queryString = {no: boardNo, id: userId, content: comment};
								$.ajax({
											type : "get",
											url : "/review/insertReviewCommentAjax",
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
														json += " <a  id='removeComment' class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
														json += " <a  id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
														json += "</div>"
													}
													json += "<input type='hidden' id='commentNo'  value="
													json += j.list[i].commentNo
													json +=">"
													json += "</div></div>";
												}
												 $("#commentView").html(json);
												
											}
											//callback			
										}); //ajax
								
							}); // sendCommentclick 이벤트
							
			$("#commentView").on("click","#editComment",function() {
								content = $(this).parent().prev().html().trim();
								commentNo = $(this).parent().next().val();
								$("#commentresetView").empty();
								$("#commentresetView").html("<textarea class='form-control'"+"rows='2' id='comment'>"
								+ content+ "</textarea>"+ "<a id='updateComment' class='btn btn-default btn-xs'>"
							+ "<i class='fa fa-edit'></i> 수정하기</a>");

							});//editComment (댓글 수정)

			$("#commentView").on("click","#updateComment",function(){
							if(confirm("댓글을 수정하시겠습니까?")){
								content = $(this).prev().val();
								var queryString = {rNo: boardNo, cNo: commentNo, rcontent: content};
								$.ajax({
											type : "get",
											url : "/review/updateReviewCommentAjax",
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
														json += " <a  id='removeComment'class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
														json += " <a  id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
														json += "</div>"
													}
													json += "<input type='hidden' id='commentNo'  value="
													json += j.list[i].commentNo
													json +=">"
													json += "</div></div>";
												}
												$("#commentView").html(json);
												
											}
									}); //ajax
								 }else{
									 location.href = "/review/ReviewDetail?no=<%=review.getPosting_no()%>&page=<%=currentPage%>";
								 }//confirm
							}); //commentView 수정하기 버튼
			//삭제하기
			$("#commentView").on("click","#removeComment",function() {
								if (confirm("댓글을 삭제하시겠습니까?")) {
									commentNo = $(this).parent().next().val();
									var queryString = {rNo: boardNo, cNo: commentNo};
									$.ajax({
												type : "get",
												url : "/review/deleteReviewCommentAjax",
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
															json += " <a id='removeComment'class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
															json += " <a  id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
															json += "</div>"
														}
														json += "<input type='hidden' id='commentNo'  value="
														json += j.list[i].commentNo
														json +=">"
														json += "</div></div>";
													}
													$("#commentView").html(json);
												}
											}); //ajax
								} else {
									location.href = "/review/ReviewDetail?no=<%=review.getPosting_no()%>&page=<%=currentPage%>";
								}
							}); //commentView 삭제하기 버튼
    		
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
									시간: <%=commentList.get(i).getCommentDate()%><br>
									댓글내용
									<p><%=commentList.get(i).getCommentContent()%></p> 
								<%if(member.getId().equals(commentList.get(i).getId())){%> 
									<div class="btn-group pull-right" role="group" aria-label="comment__actions">
										<a  id="removeComment"class="btn btn-default btn-xs"><i class="fa fa-times"></i>Remove</a> 
										<a id="editComment"class="btn btn-default btn-xs"><i class="fa fa-edit"></i>Edit</a> 
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