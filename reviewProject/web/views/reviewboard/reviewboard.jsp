<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="memberReviewBoard.model.vo.ReviewBoard ,java.util.ArrayList, java.sql.Date"%>
<% 
	ArrayList<ReviewBoard> list = (ArrayList<ReviewBoard>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
%>
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

<!-- <script type="text/javascript" src="/review/js/jquery-3.2.1.min.js">   
 $(document).ready(function() {
	$('#searchSubmit').click(function() {
		var searchKeyWord = $('#searchKeyWord').val(); //검색어 값 받아오기
		if (searchKeyWord == "") {
			alert("검색어를 입력하세요!");
		} else {
			var command = $('#findType').val(); 
			console.log(searchKeyWord);
			location.href = "/review/reviewList?command=" + command + "&searchKeyWord=" + searchKeyWord;
		}
	});  
}); 
</script> -->

<!-- <script type="text/javascript">
	function search(){
		var searchKeyWord = document.getElementById('searchKeyWord').value;
		if(searchKeyWord == ""){
			alert("검색어를 입력하세요");
		}else{
			var command = document.getElementById('findType').value;
			location.href = "/review/reviewList?command="+command+"&searchKeyWord="+searchKeyWord;
		}
	}
</script> -->

<style type="text/css">
.col-sm-8 {
	left: 50px;
}

.btn {
	background: #4D81B0;
	background-image: -webkit-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -moz-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -ms-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -o-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: linear-gradient(to #4D81B0, #4D81B0, #4D81B0);
	-webkit-border-radius: 4;
	-moz-border-radius: 4;
	border-radius: 4px;
	font-family: Arial;
	color: #ffffff;
	font-size: 20px;
	padding: 10px 20px 10px 20px;
	text-decoration: none;
}

.btn:hover {
	background: #C2D6E9;
	background-image: -webkit-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -moz-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -ms-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -o-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: linear-gradient(to bottom, #C2D6E9, #C2D6E9);
	text-decoration: none;
}

</style>


</head>
<body>
<%@ include file="../../header.jsp"%>
<br>
<div align="left" style="margin-left: 10%; margin-right: 10%">
		<div align="left">    
			<form class="" role="form" action="/review/reviewList">
				<select name="findLocationType" class="btn" style="color: white">
					<option value="">지역별</option>
					<option value="서울특별시">서울특별시</option>
					<option value="부산광역시">부산광역시</option>
					<option value="대구광역시">대구광역시</option>
					<option value="인천광역시">인천광역시</option>
					<option value="광주광역시">광주광역시</option>
					<option value="대전광역시">대전광역시</option>
					<option value="울산광역시">울산광역시</option>
					<option value="경기도">경기도</option>
					<option value="제주도">제주도</option>
				</select>
				&nbsp;&nbsp;&nbsp;
				<select class="btn" name="findCategoryType" style="color: white">
					<option value="">카테고리별</option> 
					<option value="식당">식당</option>
					<option value="카페">카페</option>
					<option value="교통">교통</option>
					<option value="숙박">숙박</option>
				</select>
				&nbsp;&nbsp;&nbsp;
				<!-- <label class="sr-only" for="nav-search">Search</label> -->
				<input type="text" class="btn2" name="searchKeyWord" placeholder="가게명" style="height: 25px; width: 200px;">
				<button type="submit" id="searchSubmit" class="btn" style="color: white">
					<i class="fa fa-search"></i>
				</button> 
			</form>
		</div>
</div>

<div align="left" style="margin-left: 10%; margin-right: 10%">  
<h2>리뷰 게시판</h2> 
<caption>리뷰를 남겨주세요</caption>
<div class="" id="ui_buttons" align="right">
		<a href="/review/views/reviewboard/reviewboardWriteForm.jsp" class="btn" style="background-color: red; color: white">글작성</a>
</div>
<br>
<!-- PAGE CONTENT
    ============================== -->

	<!-- Portfolio -->
	<div class="portfolio__items">
	  	<div class="table-responsive">
	  		<%for(int i = 0; i<list.size(); i++){%> 
				<div class="col-xs-12 col-sm-4 filter__item filter_modernism">
					<div class="portfolio__item">
						<!-- Image -->
						<div class="portfolio__img">
							<a href="portfolio-item.html"> 
							<img src="${pageContext.request.contextPath}/uploadfile/<%=list.get(i).getRenameImageName()%>" alt="Portfolio Image">
							</a>
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">
								<a href="/review/ReviewDetail?no=<%=list.get(i).getPosting_no()%>&page=<%=currentPage%>"><font color="red"><%=list.get(i).getTitle()%></font></a></h3> 
								<div class="portfolio__intro">

								<%if(list.get(i).getEvaluation() == 1){%>
									평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 2){%>
									평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 3){%>
									평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 4){%>
									평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 5){%>
									평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 6){%>
									평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 7){%>
									평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 8){%>
									평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}else if(list.get(i).getEvaluation() == 9){%>
									평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br> 
								<%}else if(list.get(i).getEvaluation() ==10){%>
									평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=list.get(i).getEvaluation()%>점<br>
								<%}%>
								가게명: <%=list.get(i).getStoreName()%><br>
								지역: <%=list.get(i).getLocation()%><br>
								카테고리: <%=list.get(i).getCategory()%> <br>
								작성자: <%= list.get(i).getId() %>
								<div align="right">
								&nbsp;&nbsp;<img src="resources/img/good.png">&nbsp;<font
									size="2pt" color="#4D81B0"><%=list.get(i).getLikes() %></font>
							</div>
								</div>
						</div>
					</div>
				</div>
			  <%}%>
			</div>
		<!-- / .row -->
	</div>
	<!-- / .portfolio__items -->
	<br><br>

<!-- / .container -->
<!-- paging -->
      <div id="ui_pagination" align="center">
         <nav>
            <ul class="pagination">
               <!-- 이전페이지 처리 -->
               <%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
                  <li><span aria-hidden="true">«««</span></li>
               <%}else{ %>   <!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
                  <li><a href="/review/reviewList?page=<%= currentPage-1 %>" aria-label="Previous"><span
                        aria-hidden="true">«««</span></a></li>   
               <%} %>
               
               <!-- 페이지 보여주기 -->
               <%for(int p = startPage; p<=endPage; p++){ 
                  if(p==currentPage){%>
                     <li class="active"><a><%=p %></a></li>               
                  <%}else{ %> 
                     <li><a href = "/review/reviewList?page=<%=p %>"><%=p %></a></li>
                  <%} %>
               <%} %>
               
               <!-- 다음페이지 처리 -->
               <%if(currentPage>=maxPage){ %>
                  <li><span aria-hidden="true">»»»</span></li>               
               <%}else{ %>
                  <li><a href="/review/reviewList?page=<%= currentPage+1 %>" aria-label="Next">
                     <span aria-hidden="true">»»»</span></a></li>
               <%} %>
            </ul>
         </nav>
      </div>
      </div>
      <%@ include file="../../footer.jsp"%>
</body>
</html>