<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
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
    
    <script type="text/javascript">
    	
    	function checkpw(){
    		if(document.getElementById('sign-up__password').value != document.getElementById('sign-up__password_repeat').value){
    			alert("비밀번호를 확인해주세요!");
    			document.signupForm.repeatPassword.focus();
    			return false;
    		}
    		return true;
    	}
    
    </script>
  </head>

  <body class="body_plain"> 

    <!-- PAGE CONTENT
    ============================== -->
    <div class="container">
      <div class="row">
        <div class="col-xs-12">
          <div class="body-plain__title">
            <h1 class="text-center">Sign Up</h1>
          </div>
        </div>  
      </div> <!-- / .row -->
      <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 col-sm-offset-3 col-md-offset-3 col-lg-offset-4">
          <div class="body-plain__form">

            <!-- Sign Up form  -->
            <form role="form" action="/review/signup" method="post" name="signupForm" onsubmit="return checkpw()">
  			  <div class="form-group">
                  <label for="sign-up__name" class="sr-only">ID</label>
              	  <input type="text" class="form-control" id="sign-up__id" name="id" placeholder="아이디" required>
              	  <span id="idCheckView"></span>
              </div>
              <div class="form-group">
              	<label for="sign-up__password" class="sr-only">Password</label>
                <input type="password" class="form-control" id="sign-up__password" name="password" placeholder="패스워드" required>
              </div>
              <div class="form-group">
              	 <label for="sign-up__password_repeat" class="sr-only">Repeat Password</label>
                 <input type="password" class="form-control" id="sign-up__password_repeat" name="repeatPassword" placeholder="패스워드확인" required>
              </div>
              <div class="form-group">
              	<label for="sign-up__name" class="sr-only">name</label>
                <input type="text" class="form-control" id="sign-up__name" name="name" placeholder="이름" required>
              </div>
              <div class="form-group">
               	  <label for="sign-up__tel" class="sr-only">email</label>
              	  <input type="email" class="form-control" id="sign-up__email"  name="email"  placeholder="이메일" required>
              </div>
             <input type="submit" class="btn btn-primary btn-block btn-lg" value="가입완료"><br>
             <input type="reset" class="btn btn-primary btn-block btn-lg"  value="취소">
            </form>

            <!-- Sign In link -->
            <hr />
            <p align="center">회원이면 <a href="login.jsp">로그인 하러가기</a></p>
          </div> <!-- / .body-plain__form -->

          <!-- Footer -->
          <div class="body-plain__footer">
            Copyright 2017 <a href="http://simpleqode.com/">Simpleqode.com</a>. All Rights Reserved.
          </div>
        </div>
      </div> <!-- / .row -->
    </div> <!-- / .container -->


    <!-- Javascript
    ============================== -->

    <!-- JS Global -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.min.js"></script>

    <!-- JS Plugins -->
    <script src="${pageContext.request.contextPath}/resources/js/scrolltopcontrol.js"></script>
    <script src="${pageContext.request.contextPath}/js/wow.min.js"></script>

    <!-- JS Custom -->
    <script src="js/custom.js"></script>


  </body>
</html>