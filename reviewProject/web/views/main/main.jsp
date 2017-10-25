<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ 
	page import = "adminNotice.model.dao.NoticeDao, adminNotice.model.service.NoticeService, adminNotice.model.vo.Notice,java.util.ArrayList"
%>
<%@ 
	page import = "memberReviewBoard.model.dao.ReviewBoardDao,memberReviewBoard.model.service.ReviewBoardService,memberReviewBoard.model.vo.ReviewBoard"
 %>
<%	
	ArrayList<Notice> noticeList = new NoticeService().viewNoticeList();
	ArrayList<ReviewBoard> restaurantList = new ReviewBoardService().selectTop3Restaurant();
	ArrayList<ReviewBoard> cafeList = new ReviewBoardService().selectTop3Cafe();
	ArrayList<ReviewBoard> hotelList = new ReviewBoardService().selectTop3Hotel();
	ArrayList<ReviewBoard> transList = new ReviewBoardService().selectTop3Trans();
	
	
			
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
				<%if(restaurantList!=null){ %>
					<%for(ReviewBoard review : restaurantList){ %>
						<div class="col-xs-6 col-sm-6 col-md-3">
							<div class="portfolio__item">
								<!-- Image -->
		
								<div class="portfolio__img">
									<img
										src="${pageContext.request.contextPath}/uploadfile/<%=review.getRenameImageName() %>"
										alt="Portfolio Image">
								</div>
								<!-- Captions -->
								<div class="portfolio__caption">
									<h3 class="portfolio__title">
										<a href="/review/ReviewDetail?no=<%=review.getPosting_no()%>&page=1">글제목 : <%=review.getTitle()%></a>
									</h3>
								</div>
								<div class="portfolio__intro">
										<%if(review.getEvaluation() == 1){%>
									평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 2){%>
									평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 3){%>
									평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 4){%>
									평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 5){%>
									평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 6){%>
									평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 7){%>
									평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 8){%>
									평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}else if(review.getEvaluation() == 9){%>
									평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br> 
								<%}else if(review.getEvaluation() ==10){%>
									평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=review.getEvaluation()%>점<br>
								<%}%>
								</div>
								<div class="portfolio__intro">
										가게명 :
								</div>
								<div class="portfolio__intro">
										지역 :
								</div>
								<div class="portfolio__intro">
										카테고리 :
								</div>
								
							</div>
						</div>
					<%} %>
				<%} %>
		</div>
				
</div>
<br><br>
<hr>



</body>
</html>
