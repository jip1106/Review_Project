<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
<head>
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
<%@ include file="../../../../header.jsp"%>
<br><br>

<div class="row">
		<div class="col-sm-2" align="center">    
			<form class="form-inline topbar__search" role="form" action="">
				<select class="selectpicker" id="findLocationType">
					<option value="">지역별</option>
					<option value="">서울 특별시</option>
					<option value="">인천 광역시</option>
					<option value="">광주 광역시</option>
					<option value="">대전 광역시</option>
					<option value="">울산 광역시</option>
					<option value="">경기도</option>
					<option value="">제주도</option>
					
				</select> 
			</form>
		</div>
		
		<div class="col-sm-2" align = "left">    
			<form class="form-inline topbar__search" role="form" action="">
				<select class="selectpicker" id="findCategoryType">
					<option value="">카테고리별</option>
					<option value="">식당</option>
					<option value="">카페</option>
					<option value="">교통</option>
					<option value="">숙박</option>
				</select> 
			</form>
		</div>
		
		<div class="col-sm-4" align ="left">    
			<form class="form-inline topbar__search" role="form" action="">
				<label class="sr-only" for="nav-search">Search</label>
				<input type="text" class="form-control" id="searchKeyWord" name="">
				<button type="submit" id="searchSubmit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
</div>

<br>
<h2 class="header">리뷰 게시판</h2> 
<caption>리뷰를 남겨주세요</caption>
<div class="ui__section" id="ui_buttons" align="right">
		<a href="reviewboardWriteForm.jsp" class="btn btn-sm btn-primary">글작성</a>
</div>

<!-- PAGE CONTENT
    ============================== -->
<div class="container">
	<!-- Portfolio -->
	<div class="portfolio__items">
		<div class="row">
			<div class="col-xs-12 col-sm-4 filter__item filter_modernism">
					<div class="portfolio__item">
						<!-- Image -->
						<div class="portfolio__img">
							<a href="portfolio-item.html"> 
							<img src="${pageContext.request.contextPath}/resources/img/beer.jpg" alt="Portfolio Image">
							</a>
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">
								<a href="reviewboardDetail.jsp">글제목</a></h3> 
								<div class="portfolio__intro">
								평점<br>
								작성자
								</div>
						</div>
					</div>
				</div>
			</div>
		<!-- / .row -->
	</div>
	<!-- / .portfolio__items -->
</div>
<!-- / .container -->

	<!-- paging -->
	<div class="ui__section" id="ui_pagination" align="center">
		<nav>
			<ul class="pagination">  
				<li><a href="#">&laquo;</a>
				<li><a href="#">1</a>
				<li><a href="#">2</a>
				<li><a href="#">3</a>
				<li><a href="#">4</a>
				<li><a href="#">5</a>
				<li><a href="#">&raquo;</a>
			
			</ul>
		</nav>
	</div>
</body>
</html>