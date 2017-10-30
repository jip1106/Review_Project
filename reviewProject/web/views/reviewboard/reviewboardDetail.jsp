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
	
	
	
	<!-- 댓글공간 -->
<div class="col-sm-8 col-md-9">
		<div class="comment comment_new">
			<div class="comment__author_img">	
				<%=member.getName()%>[<%=member.getId() %>]
			</div>
			<div class="comment__content">
				<form>
					<div class="form-group">
	
					<label for="comment-new__textarea" class="sr-only">Enter your comment</label>
						<textarea class="form-control" rows="2" id="commentContent" placeholder="Enter your comment"></textarea>
					</div>
					
						<button type="button" id="sendComment" class="btn btn-primary" onclick="return insertComment();" >Send Comment</button> 

				</form>
			</div>
		</div>
	
		<!-- Comments header -->
		<div class="comment__header">
			<span>List of Comments</span>
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
			var boardPostNum = "<%=review.getPosting_no()%>";
			
			$.ajax({
				url: "/review/reviewcomment.do",
				data: {postNum:boardPostNum},
				dataType : "json",
				success: function(data){
					var jsonStr = JSON.stringify(data);
					var json = JSON.parse(jsonStr);
					var memberId = "<%=member.getId()%>";
					
					var values = "";
					
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
											decodeURIComponent(json.list[i].content).replace(/\+/gi, " ")
											+"<hr>"
					
						}
					}
					
					$('#viewComment').html(values);
					
				}
			})
		}			
		
		function insertComment(){
			if($("#commentContent").val() ==""){
				alert("댓글 내용을 입력해주세요!");
				focus("#commentContent");
				return false;
			}else{
				var postNum = "<%=review.getPosting_no()%>";
				var id = "<%=member.getId()%>";
				var content = $("#commentContent").val();
				$.ajax({	
					url:"/review/insertReviewCommentAjax",
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
				var postNum = "<%=review.getPosting_no()%>";
				var id = "<%=member.getId()%>";
				var commentNum = commentNo+"";
				$.ajax({
					url:"/review/deleteReviewCommentAjax",
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
			var postNum = "<%=review.getPosting_no()%>";
			var id = "<%=member.getId()%>"
			var commentNum = commentNo+"";
			
			var content = $("#reply").val().replace(/\+/gi," ");
					
			if(content===""){
				alert("댓글 내용을 입력해주세요");
				return false;
			}else{
				$.ajax({
					url:"/review/updateReviewCommentAjax",
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
	</div>
	
</body>
</html>