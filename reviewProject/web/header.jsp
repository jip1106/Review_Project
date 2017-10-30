<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.model.vo.Member"%>
<%
	Member member = (Member)session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta charset=utf-8>
<!--<link rel="icon" href="img/favicon.ico">-->

<!-- CSS Global -->
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet">

<!-- CSS Plugins -->
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/animate.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700'
	rel='stylesheet' type='text/css'>

<style type="text/css">
@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.woff')}
@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.otf.eot')}
	
	body, table, div, p, a, h1, h2, h3, button, .header, li a.navbar-brand, .btn{
	font-family:'CoreGTM5';
	}
	
.header {
	background-size: 50%;
	height: 200px;
	width: 100%;
	padding-bottom: 60;
	magin: 0;
	background-image: url("/review/resources/img/backgroundsomi.jpg");
}

ul.navi li {
	margin-top: 1%;
	margin-right: 1%;
	list-style-type: none;
	display: block;
	width: 20em;
	height: 3em;
	float: left;
	text-align: center;
	font-family: "Lucida Grande", sans-serif;
	border-right: 1px #C2D6E9 solid;
	-webkit-box-shadow: 1px 1px 1px #C2D6E9;
	-moz-box-shadow: 1px 1px 1px #C2D6E9;
	box-shadow: 1px 1px 1px #C2D6E9;
	/* background-color: #c9c9c9; */
	background: -webkit-gradient(linear, left top, left bottom, from(white),
		to(white));
	/* background: -moz-linear-gradient(top, white, #a1a1a1, #848484); */
}

ul.navi li a {
	display: block;
	padding: .8em .5em .5em .5em;
	text-decoration: none;
	color: #497FAE;
	/* text-shadow: 1px 1px 0px white; */
}

ul.navi li:hover {
	background-color: #4D81B0;
	background: -webkit-gradient(linear, left top, left bottom, from(#C2D6E9),
		to(#C2D6E9) /* , color-stop(0.6, #474747) */);
	/* background: -moz-linear-gradient(top, #333333, #474747, #4c4c4c); */
}

ul.navi li:hover>a {
	color: white; /* 글자색*/
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
</head>
<body>

	<div class="header">
		<h1 align="center">
		<%if(member.getUserType()==1){ %>
  			<a href=/review/views/main/main.jsp style="text-decoration: none; color: white; font-size: 110%">Review</a></h1> 	<!-- 회원 -->
  		<%}else{ %>
	  		<a href=/review/views/admin/main/adminMain.jsp style="text-decoration: none; color: white; font-size: 110%;">Review</a></h1> <!-- 관리자 -->
  		<%} %>
		<div>

			<div class="container">
				<ul class="topbar-nav topbar-nav_right">
		<%if(member != null && member.getUserType()==1){%><!-- 회원 -->
			<li><a class="navbar-brand" style="color: black;"><%=member.getName()%><font color="red">회원</font>님 환영합니다.</a></li>
			<li><a class="navbar-brand" style="color: red;" href="/review/logout">Logout</a></li>
		<%}else if(member !=null && member.getUserType()==0){ %><!-- 관리자 -->
			<li><a class="navbar-brand" style="color: black;"><%=member.getName()%> <font color="red">관리자</font>님 환영합니다.</a></li>
			<li><a class="navbar-brand" style="color: red;" href="/review/logout">Logout</a></li>
		<%}else{%>	<!-- 비회원 -->
			<li><a class="navbar-brand" style="color: black;" href="views/member/login.jsp">Login</a></li> 
			<li><a class="navbar-brand" style="color: black;" href="views/member/signup.jsp">SignUp</a></li>
		<%}%> 
	</ul>
</div>	
			<div align="center">
			<%if(member.getUserType() == 1){ %> <!-- 회원 -->
			<ul class="navi">
				<li><a href="/review/reviewList">리뷰게시판</a></li>

	   			<li><a href="/review/slist">정보공유게시판</a></li>
	  			<li><a href="/review/clist">신고게시판</a></li> 
	   			<li><a href="/review/views/mypage/member/memberupdateview.jsp">마이페이지</a></li>
			</ul>
			
			 <%}else{ %> <!-- 관리자 -->
			  <ul class="navi">
			   	<li><a href="/review/adminReviewList">리뷰게시판</a></li>
			   	<li><a href="/review/adminsblist">정보공유게시판</a></li>
			   	<li><a href="/review/cblist?page=1">신고게시판</a></li> 
			  	<li><a href="/review/mlist">회원관리</a></li> <!-- 관리자 MemberManagementServlet 호출 -->
			  </ul>
  			<%} %>
  			</div>
			<!-- STATIC TOPBAR 
    ============================== -->

		</div>
	</div>
	<br><br>
</body>
</html>