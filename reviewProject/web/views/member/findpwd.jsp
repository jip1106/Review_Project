<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!--<link rel="icon" href="img/favicon.ico">-->

<title>findpwd</title>

<!-- CSS Global -->
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

<!-- CSS Plugins -->
<link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

<!-- Google Fonts -->
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
   <script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script> 

    
    <script type="text/javascript">
    	$(document).ready(function(){
    		
	    	$("#findPassword").click(function(){
	    			
	    			var userId = $("#id").val().trim();
	    			var userName = $("#name").val().trim();
	    			var userEmail = $("#email").val().trim();
	    			var queryString = {id: userId, name: userName, email: userEmail};
	    			var check = "fail";
	    			
	    			$.ajax({ 
	    				type: "post",
	    				url: "/review/memberFindPwd",
	    				data: queryString,
	    				success: function(data){
	    					if(data.trim() == check.trim()){
	    						$("#findPwd").html("입력하신 정보와 일치하는 비밀번호가 없습니다.").css("color", "red");
	    					}else{
	    						$("#findPwd").html("임시비밀번호 "+data+" 로 로그인하세요!").css("color", "green");
	    					}
	    				}
	    			});
	    		   
	    		});	
    	
    	});
</script>

</head>

<body class="body_plain">

	<!-- PRELOADER (uncomment to enable)
    ============================== -->
	<!-- <div class="preloader">
      <img src="img/preloader.gif" alt="Loading..." class="preloader__img">
    </div> -->

	<!-- PAGE CONTENT
    ============================== -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="body-plain__title">
					<h1 class="text-center">비밀번호 찾기</h1>
				</div>
			</div>
		</div>
		<!-- / .row -->
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 col-sm-offset-3 col-md-offset-3 col-lg-offset-4">
				<div class="body-plain__form">
					<!-- Sign In form -->
					<form role="form" method="post">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요">
						</div>
						<br>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
						</div>
						<br>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
						</div>
						<br>
						<button type="button" id="findPassword" class="btn btn-primary btn-block btn-lg">비밀번호 찾기</button>
						<button type="reset" class="btn btn-primary btn-block btn-lg">취소</button>
						<br>
						 <p align="center"><a href="login.jsp">로그인 하러가기</a></p>
					</form>
					<br>
					<span id=findPwd></span>
			<!-- Footer -->
					<div class="body-plain__footer">
						Copyright 2016 <a href="http://simpleqode.com/">Simpleqode.com</a>.
						All Rights Reserved.
					</div>
				</div>
			</div>
			<!-- / .row -->
		</div>
		<!-- / .container -->
	</div>
</body>
</html>