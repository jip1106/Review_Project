<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>MyPageLeftMenu</title>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--<link rel="icon" href="img/favicon.ico">-->

    <title>Sign up</title>
 	<!-- CSS Global -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

    <!-- CSS Plugins -->
    <link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
    
    <style type="text/css">
@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.woff')}
@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.otf.eot')}
	
	body, table, div, p, a, h1, h2, h3, button, .header, li a.navbar-brand, .btn{
	font-family:'CoreGTM5';
	}
	</style>
	
</head>
<body>
<div class="col-sm-4 col-md-3 col-lg-2">
	<ul class="list-unstyled profile-social center-block">
		<br><br>
		<li><a href="memberupdateview.jsp" class="btn btn-primary" style="width: 160px; background: red; text-align: center">회원정보 </a></li> 
		<li><a href="memberleave.jsp" class="btn btn-primary" style="width: 160px; background: red; text-align: center">회원탈퇴</a></li>
		
		<!-- 내가 작성한 공유글 -->
		<li><a href="mysharewrite.jsp" class="btn btn-primary" style="width: 160px; background: red; text-align: center">내가 작성한 공유글</a></li>
		
		<!-- 내가 작성한 신고글-->
		<li><a href="mycomplainwrite.jsp" class="btn btn-primary" style="width: 160px; background: red; text-align: center">내가 작성한 신고글</a>
		
		<%-- <li><a href="/review/mycomplainList?id=<%=member.getId() %>" class="btn btn-primary" style="width: 160px;">내가 작성한 신고글</a></li> --%>
		
		
	</ul>
</div>
</body>
</html>