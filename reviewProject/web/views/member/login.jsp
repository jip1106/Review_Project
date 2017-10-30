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

<title>Login</title>

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
		background: #4D81B0;
	}
	
	.btn{
		background: #4D81B0;
	}
	

</style>
    
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="../../js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
	function checkInput(){
		if($("#inputid").val() ==""){
			alert("아이디를 입력하세요.");
			focus("#inputid");
			return false;
		}else if($("#inputpassword").val()==""){
			alert("패스워드를 입력하세요.");
			focus("#inputpassword");
			return false;
		}
	}
</script>

</head>

<body class="body_plain">
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="body-plain__title">
					<h1 class="text-center">Login</h1>
				</div>
			</div>
		</div>
		<!-- / .row -->
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 col-sm-offset-3 col-md-offset-3 col-lg-offset-4">
				<div class="body-plain__form">
					<!-- Sign In form -->
					<!-- action = /review/login 이였음 -->
				 <form role="form" action="/review/login" method="post">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input type="text" name = "id" class="form-control" id="inputid"  placeholder="아이디를 입력하세요">
							<!-- name="id" 였음 -->
						</div>
						
						<br>
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="password" name = "password" class="form-control" id="inputpassword" placeholder="패스워드 입력하세요">
							<!-- name="password" 였음 -->
						</div>
					<!-- 	<div id="idpwdCheck" style="color: red;"></div> -->
						<br>
					
						<button type="submit" class="btn btn-primary btn-lg btn-block" 
									onclick="return checkInput();">Login</button>
						<!-- <button type="submit" class="btn btn-primary btn-block btn-lg">Login</button> -->
						<button type="reset" class="btn btn-primary btn-block btn-lg" 
									id="cancel" style=" background: #4D81B0;">취소</button>
				</form> 

				
					<!-- Sign Up link -->
					<hr />
					<p align="center">
						<a href="findid.jsp" style="color: red;">아이디찾기</a> &nbsp;&nbsp;
						<a href="findpwd.jsp" style="color: red;">비밀번호찾기</a>
					</p>

					<br>
					 <p align="center">회원이 아니면 <a href="signup.jsp" style="color: red;">회원 가입 하러가기</a></p>
					<!--
					<div class="body-plain__footer">
						Copyright 2017 <a href="http://simpleqode.com/">Simpleqode.com</a>.
						All Rights Reserved.
					</div> -->
				</div>
			</div>
			<!-- / .row -->
		</div>
		<!-- / .container -->
		<!-- Footer -->
		<div class="body-plain__footer">
			Copyright 2017 <a href="http://simpleqode.com/" style="color: red;">Simpleqode.com</a>.
			All Rights Reserved.
		</div>
	</div>
</body>
</html>