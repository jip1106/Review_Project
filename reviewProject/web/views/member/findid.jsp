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

<title>find ID</title>

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
    
    <style type="text/css">
	@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.woff')}
	@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.otf.eot')}
	
	body, table, div, p, a, h1, h2, h3, button, .header, li a.navbar-brand, .btn{
	font-family:'CoreGTM5';
	}
	
	.btn:hover{
		background: #C2D6E9;
	}
	
	.btn{
		background: #4D81B0;
	}
	

</style>
    
   <script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script> 

    
    <script type="text/javascript">
    	$(document).ready(function(){
    		
	    	$("#findId").click(function(){
	    			
	    			var userEmail = $("#email").val().trim();
	    			var queryString = {email: userEmail};
	    			var userId = "";
	    			var check = "fail";
	    			$.ajax({ 
	    				type: "post",
	    				url: "/review/memberFindId",
	    				data: queryString,
	    				success: function(data){
	    					userId = data;
	    					if(data.trim() != check.trim()){
	    						$("#findEmail").html("회원님의 아이디는 " +userId+" 입니다.").css("color", "green");
	    						
	    					}else{
	    						$("#findEmail").html("입력하신 이메일과 일치하는 아이디가 없습니다.").css("color", "red");
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
					<h1 class="text-center">아이디 찾기</h1>
				</div>
			</div>
		</div>
		<!-- / .row -->
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 col-sm-offset-3 col-md-offset-3 col-lg-offset-4">
				<div class="body-plain__form">
					<!-- Sign In form -->
					<form role="form" method="post" action="">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
						</div>
						<br>
						<button type="button" id="findId" class="btn btn-block btn-lg" style="color: white;">아이디찾기</button>
						<button type="reset" class="btn btn-block btn-lg" style="color: white;">취소</button>
					</form>
					<br>
					<span id ="findEmail"></span>
				<!-- Footer -->
					<div class="body-plain__footer">
					Copyright 2017 <a href="/review/index.jsp" style="color: red;">Review</a>.
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