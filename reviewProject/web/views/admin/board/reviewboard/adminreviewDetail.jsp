<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="memberReviewBoard.model.vo.ReviewBoard ,java.util.ArrayList, java.sql.Date"%>
<% 
	ReviewBoard review = (ReviewBoard)request.getAttribute("board"); 
 	int currentPage = (Integer)request.getAttribute("currentPage"); 
%> 
<!DOCTYPE html>
<html lang="en"> 
<head>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=5a5f74b55c137eef83dc34e43b7a72b7&libraries=services"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
	$('#like').onclick(function(){
		
	});
</script>

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
<%@include file="../../../../header.jsp" %> 

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge">No. <%=review.getPosting_no() %></span></a>
			<a href="#"><span class="badge">조회수 : <%=review.getHits() %></span></a>
			<a href="#"><span class="badge">날짜 : <%=review.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%=review.getId() %></a> &nbsp;
			<a href="#">좋아요 : <%=review.getLikes() %></a> &nbsp;
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><h2><%=review.getTitle() %></h2></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=review.getContent() %></td> 
						</tr>
					</table>
					<br><br>
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
			
							
						<!-- 지도 api-->
				<br><br>
					
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
						level : 3
					// 지도의 확대 레벨
					};
			
					var map = new daum.maps.Map(mapContainer, mapOption);
					var geocoder = new daum.maps.services.Geocoder();
					var fullAddr = <%=review.getAddress()%>; //이곳에 장소 넣어줌 
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
				</div>
				
					
				
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<a href="/review/adminForceDelete?page=<%=currentPage %>&limit=9&postNo=<%=review.getPosting_no()%>" class="btn btn-default">삭제</a>
						<a href="/review/reviewLikeUp" class="btn btn-default">좋아요</a>
					</div>
				</div>				
			</div>
						
		</div>
	</div>
</div>

<br><br>


	<!-- 댓글공간 -->
</body>
</html>