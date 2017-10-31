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
    
     <style>
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
    		
    		$("#signupForm").submit(function(){
    			var password = $(":input[name=password]").val();
    			var repeatpassword = $(":input[name=repeatPassword]").val();
    			
    			if(password != repeatpassword){
    				alert("비밀번호를 확인해주세요");
    				$(":input[name=repeatPassword]").focus();
    				return false;
    			}
    			return true;
    		});
    		
    		
    		$(":input[name=id]").keyup(function(){
    			
    			var userId = $(this).val().trim();
    			var queryString = {id: userId};
    			var fail = "fail";
    			
    			$.ajax({ 
    				type: "post",
    				url: "/review/memberIdCheck",
    				data: queryString,
    				success: function(data){
    					if(data.trim() == fail.trim()){ 
    						$("#idCheckView").html(" "+userId+"는 사용하실 수 없는 아이디 입니다!").css("color", "red");
    						
    					}else{
    						$("#idCheckView").html(" "+userId+"는 사용할 수 있는 아이디 입니다!").css("color", "green");
    						
    					}
    				}
    			});
    		   
    		});	
    	
    	});
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
            <form role="form" action="/review/signup" method="post" id="signupForm" name="signupForm" onsubmit="return checkpw()">
  			  <div class="form-group">
                  <label for="sign-up__name" class="sr-only">ID</label>
              	  <input type="text" class="form-control" id="sign-up__id" name="id" placeholder="아이디" style="size: 30" required>
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
             <input type="submit" class="btn btn-block btn-lg" 
              value="가입완료" style="color: white;"><br>
             <input type="reset" class="btn btn-block btn-lg"  
               value="취소" style="color: white;">
            </form>

            <!-- Sign In link -->
             
            <hr />
          
            <p align="center">회원이면 <a href="login.jsp" style="color: red;">로그인 하러가기</a></p>
            <br>
             <p align="center"><a href="/review/index.jsp" style="color: red;">메인으로 이동</a></p>
          </div> <!-- / .body-plain__form -->

          <!-- Footer -->
          <div class="body-plain__footer">
			Copyright 2017 <a href="/review/index.jsp" style="color: red;">Review</a>.
			All Rights Reserved.
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