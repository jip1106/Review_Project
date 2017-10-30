<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ 
	page import = "adminNotice.model.dao.NoticeDao, adminNotice.model.service.NoticeService, adminNotice.model.vo.Notice,java.util.ArrayList"
%>
<%@ 
	page import = "memberReviewBoard.model.dao.ReviewBoardDao,memberReviewBoard.model.service.ReviewBoardService,memberReviewBoard.model.vo.ReviewBoard"
%>
<%	
	ArrayList<Notice> noticeList = new NoticeService().viewNoticeList();
	ArrayList<ReviewBoard> restaurantList = new ReviewBoardService().selectTop3Restaurant();
	ArrayList<ReviewBoard> cafeList = new ReviewBoardService().selectTop3Cafe();
	ArrayList<ReviewBoard> hotelList = new ReviewBoardService().selectTop3Hotel();
	ArrayList<ReviewBoard> transList = new ReviewBoardService().selectTop3Trans();
				
%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <style type="text/css">
@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.woff')}
@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.otf.eot')}
	
	body, table, div, p, a, h1, h2, h3, button, .header, li a.navbar-brand {
	font-family:'CoreGTM5';
	}
	
.header {
	padding-bottom: 60;
	magin: 0;
	background-image: url("/review/resources/img/새싹비빔밥.jpg");
}

ul.navi li {
	list-style-type: none;
	display: block;
	width: 20em;
	height: 3em;
	float: left;
	text-align: center;
	font-family: "Lucida Grande", sans-serif;
	border-right: 1px white solid;
	-webkit-box-shadow: 1px 1px 1px white;
	-moz-box-shadow: 1px 1px 1px white;
	box-shadow: 1px 1px 1px white;
	/* background-color: #c9c9c9; */
	background: -webkit-gradient(linear, left top, left bottom, from(tomato),
		to(tomato));
	/* background: -moz-linear-gradient(top, white, #a1a1a1, #848484); */
}

ul.navi li a {
	display: block;
	padding: .8em .5em .5em .5em;
	text-decoration: none;
	color: white;
	/* text-shadow: 1px 1px 0px white; */
}

ul.navi li:hover {
	background-color: white;
	background: -webkit-gradient(linear, left top, left bottom, from(white),
		to(white) /* , color-stop(0.6, #474747) */);
	/* background: -moz-linear-gradient(top, #333333, #474747, #4c4c4c); */
}

ul.navi li:hover>a {
	color: tomato; /* 글자색*/
	/* text-shadow: 0px 1px 0px #fff */; /* 텍스트그림자*/
}

/* 첫번째항목의스타일*/
ul.navi li {
	-webkit-border-top-left-radius: .5em; /* 왼쪽상단코너를부드럽게*/
	-moz-border-radius-topleft: .5em;
	border-top-left-radius: .5em;
	-webkit-border-bottom-left-radius: .5em; /* 왼쪽하단코너를부드럽게*/
	-moz-border-radius-bottomleft: .5em;
	border-bottom-left-radius: .5em;
	-webkit-border-top-right-radius: .5em; /*오른쪽상단코너를부드럽게*/
	-moz-border-radius-topright: .5em;
	border-top-right-radius: .5em;
	-webkit-border-bottom-right-radius: .5em; /* 오른쪽하단코너를부드럽게*/
	-moz-border-radius-bottomright: .5em;
	border-bottom-right-radius: .5em;
}


</style>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset=utf-8>
    <!--<link rel="icon" href="img/favicon.ico">-->

    <title>Main</title>
 	<!-- CSS Global -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

    <!-- CSS Plugins -->
    <link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
  </head>
<script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("a[target!='_blank']").click(function(){
	       if(confirm("로그인을 해주세요!")==false){
	    	   return false;
	       }
	        
	    });
	});
	
	function goLogin(){
		location.replace("views/member/login.jsp");
	}
	function goSignUp(){
		location.replace("views/member/signup.jsp");
	}
	
</script>
<body>
	<div class="header">
		<h1 align="center">
			<a href=/review/views/member/login.jsp style="text-decoration: none">Review</a>
		</h1> 	<!-- 회원 -->
  		<div>

			<div class="container">
				<ul class="topbar-nav topbar-nav_right">
					<li><a class="navbar-brand" style="color: black;" target="_blank" href="javascript:void(0);" onclick="goLogin(); return false;">Login</a></li> 
					<li><a class="navbar-brand" style="color: black;" target="_blank" href="javascript:void(0);" onclick="goSignUp(); return false;">SignUp</a></li>
				</ul>
			</div>
		
			<ul class="navi" style="text-align:center; margin-left:auto; margin-right:auto;">
				<li style="display:inline-block;"><a href="/review/views/member/login.jsp">리뷰게시판</a></li>
	   			<li style="display:inline-block;"><a href="/review/views/member/login.jsp">정보공유게시판</a></li>
	  			<li style="display:inline-block;"><a href="/review/views/member/login.jsp">신고게시판</a></li> 
	   			<li style="display:inline-block;"><a href="/review/views/member/login.jsp">마이페이지</a></li>
			</ul>

		</div>
	</div>

	<br><br>

	<div class="item active" id="noticeId"><!-- 공지사항 띄워 줄 공간 -->
		<div align="left" style="margin-left: 12%; margin-right: 21%">
		<h3>공지사항</h3>
		
		<div class="table-responsive">
		<!-- <form role="form" action="/review/nlist" method="post"> -->
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th style="background-color: tomato">번호</th>
						<th style="background-color: tomato">제목</th>
						<th style="background-color: tomato">작성자</th>
						<th style="background-color: tomato">작성일</th>
						<th style="background-color: tomato">조회수</th>
						
					</tr>
				</thead>
				<%
				if(noticeList !=null){
					for(Notice notice: noticeList) {
				%>
				<tr>
					<td><%=notice.getPostingNo()%></td>
					<td>
						<a href="/review/views/member/login.jsp">
							<%= notice.getTitle() %>
						</a>
					</td>
					<td><%=notice.getId()%></td>
					<td><%=notice.getPostingDate()%></td>
					<td><%=notice.getHits()%></td>
				
				</tr>
				<%
					}
				}
				%>
			</table>
			<!-- </form> -->
			</div>
		</div>
	</div>
	
<div class="container">	
	<div class="item active"> <!-- 식당 탑3 자리 -->
	<%if(restaurantList!=null){ %>
		<h2 style="margin-left: 12%; margin-right: 21%">식당 Top3</h2>
		<div class="row" style="margin-left: 10%; margin-right: 10%">
				
					<%for(ReviewBoard review : restaurantList){ %>
						<div class="col-lg-4 ">
							<div class="portfolio__item">
								<!-- Image -->
		
								<div class="portfolio__img">
									<img
										src="${pageContext.request.contextPath}/uploadfile/<%=review.getRenameImageName() %>"
										alt="Portfolio Image">
								</div>
								<!-- Captions -->
								<div class="portfolio__caption">
									<h3 class="portfolio__title">
										<a href="views/member/login.jsp">글제목 : <%=review.getTitle()%> </a>
										[좋아요] : <%=review.getLikes() %>	
									</h3>
									
								</div>
								<div class="portfolio__intro">
									<%if(review.getEvaluation() == 1){%>
										평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 2){%>
										평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 3){%>
										평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 4){%>
										평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 5){%>
										평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 6){%>
										평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 7){%>
										평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 8){%>
										평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 9){%>
										평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br> 
									<%}else if(review.getEvaluation() ==10){%>
										평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}%>
								</div>
								<div class="portfolio__intro">
										가게명 : <%=review.getStoreName() %>
								</div>
								<div class="portfolio__intro">
										지역 : <%=review.getLocation() %>
								</div>
								<div class="portfolio__intro">
										카테고리 : <%=review.getCategory() %>
								</div>
								
							</div>
						</div>
					<%} %>
				<%} %>
		</div>
</div>

<hr>

<div class="item active"> <!-- 카페 탑3 자리 -->
<%if(cafeList!=null){ %>
		<h2 style="margin-left: 12%; margin-right: 21%">카페 Top3</h2>
		<div class="row" style="margin-left: 10%; margin-right: 10%">				
					<%for(ReviewBoard review : cafeList){ %>
						<div class="col-lg-4 ">
							<div class="portfolio__item">
								<!-- Image -->
		
								<div class="portfolio__img">
									<img
										src="${pageContext.request.contextPath}/uploadfile/<%=review.getRenameImageName() %>"
										alt="Portfolio Image">
								</div>
								<!-- Captions -->
								<div class="portfolio__caption">
									<h3 class="portfolio__title">
										<a href="views/member/login.jsp">글제목 : <%=review.getTitle()%> </a>
										[좋아요] : <%=review.getLikes() %>	
									</h3>
									
								</div>
								<div class="portfolio__intro">
									<%if(review.getEvaluation() == 1){%>
										평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 2){%>
										평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 3){%>
										평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 4){%>
										평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 5){%>
										평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 6){%>
										평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 7){%>
										평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 8){%>
										평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 9){%>
										평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br> 
									<%}else if(review.getEvaluation() ==10){%>
										평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}%>
								</div>
								<div class="portfolio__intro">
										가게명 : <%=review.getStoreName() %>
								</div>
								<div class="portfolio__intro">
										지역 : <%=review.getLocation() %>
								</div>
								<div class="portfolio__intro">
										카테고리 : <%=review.getCategory() %>
								</div>
								
							</div>
						</div>
					<%} %>
				<%} %>
		</div>
</div>
<hr>
<div class="item active"> <!-- 교통 탑3 자리 -->
	<%if(transList!=null){ %>
		<h2 style="margin-left: 12%; margin-right: 21%">교통 Top3</h2>
		<div class="row" style="margin-left: 10%; margin-right: 10%">
				<%for(ReviewBoard review : transList){ %>
						<div class="col-lg-4 ">
							<div class="portfolio__item">
								<!-- Image -->
		
								<div class="portfolio__img">
									<img
										src="${pageContext.request.contextPath}/uploadfile/<%=review.getRenameImageName() %>"
										alt="Portfolio Image">
								</div>
								<!-- Captions -->
								<div class="portfolio__caption">
									<h3 class="portfolio__title">
										<a href="views/member/login.jsp">글제목 : <%=review.getTitle()%> </a>
										[좋아요] : <%=review.getLikes() %>	
									</h3>
									
								</div>
								<div class="portfolio__intro">
									<%if(review.getEvaluation() == 1){%>
										평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 2){%>
										평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 3){%>
										평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 4){%>
										평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 5){%>
										평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 6){%>
										평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 7){%>
										평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 8){%>
										평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 9){%>
										평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br> 
									<%}else if(review.getEvaluation() ==10){%>
										평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}%>
								</div>
								<div class="portfolio__intro">
										가게명 : <%=review.getStoreName() %>
								</div>
								<div class="portfolio__intro">
										지역 : <%=review.getLocation() %>
								</div>
								<div class="portfolio__intro">
										카테고리 : <%=review.getCategory() %>
								</div>
								
							</div>
						</div>
					<%} %>
				<%} %>
		</div>
</div>
<hr>
<div class="item active"> <!-- 숙박 탑3 자리 -->
	<%if(hotelList!=null){ %>
		<h2 style="margin-left: 12%; margin-right: 21%">숙박 Top3</h2>
		<div class="row" style="margin-left: 10%; margin-right: 10%">
					<%for(ReviewBoard review : hotelList){ %>
						<div class="col-lg-4 ">
							<div class="portfolio__item">
								<!-- Image -->
		
								<div class="portfolio__img">
									<img
										src="${pageContext.request.contextPath}/uploadfile/<%=review.getRenameImageName() %>"
										alt="Portfolio Image">
								</div>
								<!-- Captions -->
								<div class="portfolio__caption">
									<h3 class="portfolio__title">
										<a href="views/member/login.jsp">글제목 : <%=review.getTitle()%> </a>
										[좋아요] : <%=review.getLikes() %>	
									</h3>
									
								</div>
								<div class="portfolio__intro">
									<%if(review.getEvaluation() == 1){%>
										평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 2){%>
										평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 3){%>
										평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 4){%>
										평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 5){%>
										평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 6){%>
										평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 7){%>
										평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 8){%>
										평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}else if(review.getEvaluation() == 9){%>
										평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br> 
									<%}else if(review.getEvaluation() ==10){%>
										평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
									<%}%>
								</div>
								<div class="portfolio__intro">
										가게명 : <%=review.getStoreName() %>
								</div>
								<div class="portfolio__intro">
										지역 : <%=review.getLocation() %>
								</div>
								<div class="portfolio__intro">
										카테고리 : <%=review.getCategory() %>
								</div>
								
							</div>
						</div>
					<%} %>
				<%} %>
		</div>
	</div>
</div>
	

</body>
</html>
