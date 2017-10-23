<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <style type="text/css">
  	.header{
  		background-image: url("resources/img/새싹비빔밥.jpg");
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

<body>
<div class="header">
<h1 align="center">Review</h1>

<div class="container">
	<ul class="topbar-nav topbar-nav_right">
		<li><a class="navbar-brand" style="color: black;" href="views/member/login.jsp">Login</a></li>
		<li><a class="navbar-brand" style="color: black;" href="views/member/signup.jsp">SignUp</a></li>
	</ul>
</div>
</div>
<!-- PORTFOLIO
    ============================== -->
<div class="section section_portfolio section_alt">
	<div class="container">
		<div class="row">
			<div class="col-xs-12" align="center">
			 <form action="" method="post">	<!-- 비회원일 경우 여기서 서블릿 넘기면 됨..? -->
			 	<input type="text" name="search" size="80" placeholder="ex)신촌 산토리아">
			 	<button type="submit" class="btn btn-primary">검색</button>
			 </form>
			</div>
		</div>
	</div>
</div>

<!-- AUTHORS
    ============================== -->
    <div class="section section_authors">
      <div class="container">
        <div class="row">
          <div class="col-xs-12">
            <h1 class="section__title">
              Developers
            </h1>
            <p class="section__intro">
              Introduce Developers Member
            </p>
        </div>
        </div> <!-- / .row -->
        <div class="row">
          <!-- Author #1 -->
          <div class="col-xs-12 col-sm-4">
            <div class="authors__item">
              <div class="authors__img wow flipInY" data-wow-offset>
                <img src="${pageContext.request.contextPath}/resources/img/photo_1.jpg" class="img-responsive" alt="...">
              </div>
              <div class="authors__content">
                <div class="authors__title">John Doe, Designer</div>
                <div class="authors__intro">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu lacus enim. Aliquam eu elit justo. 
                </div>
                <ul class="authors__contact">
                  <li class="facebook">
                    <a href=""><i class="fa fa-facebook"></i></a>
                  </li>
                  <li class="twitter">
                    <a href=""><i class="fa fa-twitter"></i></a>
                  </li>
                  <li class="linkedin">
                    <a href=""><i class="fa fa-linkedin"></i></a>
                  </li>
                  <li class="envelope">
                    <a href=""><i class="fa fa-envelope-o"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <!-- Author #2 -->
          <div class="col-xs-12 col-sm-4">
            <div class="authors__item">
              <div class="authors__img wow flipInY" data-wow-delay=".2s">
                <img src="${pageContext.request.contextPath}/resources/img/photo_2.jpg" class="img-responsive" alt="...">
              </div>
              <div class="authors__content">
                <div class="authors__title">Judy Roe, Designer</div>
                <div class="authors__intro">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu lacus enim. Aliquam eu elit justo. 
                </div>
                <ul class="authors__contact">
                  <li class="facebook">
                    <a href=""><i class="fa fa-facebook"></i></a>
                  </li>
                  <li class="twitter">
                    <a href=""><i class="fa fa-twitter"></i></a>
                  </li>
                  <li class="linkedin">
                    <a href=""><i class="fa fa-linkedin"></i></a>
                  </li>
                  <li class="envelope">
                    <a href=""><i class="fa fa-envelope-o"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <!-- Author #3 -->
          <div class="col-xs-12 col-sm-4">
            <div class="authors__item">
              <div class="authors__img wow flipInY" data-wow-delay=".4s">
                <img src="${pageContext.request.contextPath}/resources/img/photo_3.jpg" class="img-responsive" alt="...">
              </div>
              <div class="authors__content">
                <div class="authors__title">Richard Doe, Developer</div>
                <div class="authors__intro">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu lacus enim. Aliquam eu elit justo. 
                </div>
                <ul class="authors__contact">
                  <li class="facebook">
                    <a href=""><i class="fa fa-facebook"></i></a>
                  </li>
                  <li class="twitter">
                    <a href=""><i class="fa fa-twitter"></i></a>
                  </li>
                  <li class="linkedin">
                    <a href=""><i class="fa fa-linkedin"></i></a>
                  </li>
                  <li class="envelope">
                    <a href=""><i class="fa fa-envelope-o"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div> <!-- / .row -->
        <!-- Author #3 -->
        <div class="row" align="center">
          <div class="col-xs-12 col-sm-4">
            <div class="authors__item">
              <div class="authors__img wow flipInY" data-wow-delay=".4s">
                <img src="${pageContext.request.contextPath}/resources/img/photo_3.jpg" class="img-responsive" alt="...">
              </div>
              <div class="authors__content">
                <div class="authors__title">Richard Doe, Developer</div>
                <div class="authors__intro">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu lacus enim. Aliquam eu elit justo. 
                </div>
                <ul class="authors__contact">
                  <li class="facebook">
                    <a href=""><i class="fa fa-facebook"></i></a>
                  </li>
                  <li class="twitter">
                    <a href=""><i class="fa fa-twitter"></i></a>
                  </li>
                  <li class="linkedin">
                    <a href=""><i class="fa fa-linkedin"></i></a>
                  </li>
                  <li class="envelope">
                    <a href=""><i class="fa fa-envelope-o"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <!-- Author #3 -->
          <div class="col-xs-12 col-sm-4">
            <div class="authors__item">
              <div class="authors__img wow flipInY" data-wow-delay=".4s">
                <img src="" class="img-responsive" alt="...">
              </div>
              <div class="authors__content">
                <div class="authors__title">SangHyeon Ha, Developer</div>
                <div class="authors__intro">
                  LOL. 
                </div>
                <ul class="authors__contact">
                  <li class="facebook">
                    <a href=""><i class="fa fa-facebook"></i></a>
                  </li>
                  <li class="twitter">
                    <a href=""><i class="fa fa-twitter"></i></a>
                  </li>
                  <li class="linkedin">
                    <a href=""><i class="fa fa-linkedin"></i></a>
                  </li>
                  <li class="envelope">
                    <a href=""><i class="fa fa-envelope-o"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- /.container -->
    </div> <!-- / .section -->

</body>
</html>
