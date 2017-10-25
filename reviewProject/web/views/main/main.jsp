<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ 
	page import = "adminNotice.model.dao.NoticeDao, adminNotice.model.service.NoticeService, adminNotice.model.vo.Notice,java.util.ArrayList"
%>
<%
	
	ArrayList<Notice> noticeList = new NoticeService().viewNoticeList();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--<link rel="icon" href="img/favicon.ico">-->

    <title>Member Main</title>
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
<%@ include file="../../header.jsp" %> 
<br><br>
<div class="item active"><!-- 공지사항 띄워 줄 공간 -->
		<div align="left" style="margin-left: 5%; margin-right: 21%">
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
						<a href="/review/noticeDetail?postno=<%= notice.getPostingNo() %>">
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

<div class="item active"> 
		<h2 style="margin-left: 5%; margin-right: 21%">식당 Top3</h2>
		<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_1.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
		<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진2</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
		<div class="row" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_3.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진3</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
		
</div>
<br><br>
<hr>

<!-- 카테고리별  div 생성 -->
<div class="item active">
		<h2 style="margin-left: 5%; margin-right: 10%">카페 Top3</h2>
		<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
			<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
			<div class="row" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
</div>
<br><br>
<hr>

<div class="item active">
		<h2 style="margin-left: 5%; margin-right: 10%">숙박 Top3</h2>
		<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
			<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
			<div class="row" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
</div>
<br><br>
<hr>

<div class="item active">
		<h2 style="margin-left: 5%; margin-right: 10%">교통 Top3</h2>
		<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
			<div class="col" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
			<div class="row" style="margin-left: 5%; margin-right: 10%">
				<div class="col-xs-6 col-sm-6 col-md-3">
					<div class="portfolio__item">
						<!-- Image -->

						<div class="portfolio__img">
							<img
								src="${pageContext.request.contextPath}/resources/img/product_2.jpg"
								alt="Portfolio Image">
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">사진1</h3>
						</div>
						<div class="portfolio__intro">
								평점 
						</div>
					</div>
				</div>
		</div>
</div>
<br><br>
<hr>
</body>
</html>
