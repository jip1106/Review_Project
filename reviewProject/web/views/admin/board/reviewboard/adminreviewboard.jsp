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
	
	String searchLocation = null;
	String searchCategory = null;
	String storeName = null;
	String id = null;
	
	if(request.getParameter("searchLocation")!=null){
		searchLocation = (String)request.getAttribute("searchLocation");
	}
	if(request.getParameter("searchCategory")!=null){
		searchLocation = (String)request.getAttribute("searchCategory");
	}
	if(request.getParameter("storeName")!=null){
		storeName = (String)request.getAttribute("storeName");
	}
	if(request.getParameter("id")!=null){
		id = (String)request.getAttribute("id");
	}
	
	
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
    
 <style type="text/css">
 	.stylish-input-group .input-group-addon {
	background: white !important;
}

.stylish-input-group .form-control {
	border-right: 0;
	box-shadow: 0 0 0;
	border-color: #ccc;
}

.stylish-input-group button {
	border: 0;
	background: transparent;
}

.btn {
	background: #ff6347;
	background-image: -webkit-linear-gradient(top, #ff6347, #ff6347);
	background-image: -moz-linear-gradient(top, #ff6347, #ff6347);
	background-image: -ms-linear-gradient(top, #ff6347, #ff6347);
	background-image: -o-linear-gradient(top, #ff6347, #ff6347);
	background-image: linear-gradient(to bottom, #ff6347, #ff6347);
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
	background: #f75234;
	background-image: -webkit-linear-gradient(top, #f75234, #f75234);
	background-image: -moz-linear-gradient(top, #f75234, #f75234);
	background-image: -ms-linear-gradient(top, #f75234, #f75234);
	background-image: -o-linear-gradient(top, #f75234, #f75234);
	background-image: linear-gradient(to bottom, #f75234, #f75234);
	text-decoration: none;
}
 
 </style>
 
 <script type="text/javascript">
	function inputPleaseMessage(){
		if($("#searchStoreName").val()==""){
			alert("식당 이름을 입력하세요");
			
			return false;
		}
		if( $("#findLocationType").val()=="" && $("#findCategoryType").val()==""){
			alert("검색할 지역이나 카테고리 중 하나를 선택 해 주세요");
			
			return false;
		
		}
	}
	
	function idInputCheck(){
		if($("#searchId").val() == ""){
			alert("검색할 아이디 중 일부를 입력해 주세요");
			
			return false;
		}
	}
</script>
 
</head>
<body>
<%@ include file="../../../../header.jsp"%>
<br>
<div class="container">
	<div class="row">
			<form class="form-inline topbar__search" role="form" action="/review/adminSearch" onsubmit="return inputPleaseMessage();">
				<div class="col-lg-1">    
					<input type = "hidden" name="page" value=<%=currentPage %>>
					<select class="selectpicker" id="findLocationType" name="searchLocation">
						<option value="">지역별</option>
						<option value="서울특별시">서울특별시</option>
						<option value="인천광역시">인천광역시</option>
						<option value="광주광역시">광주광역시</option>
						<option value="대전광역시">대전광역시</option>
						<option value="울산광역시">울산광역시</option>
						<option value="경기도">경기도</option>
						<option value="제주도">제주도</option>
					</select> 
				</div>
			
				<div class="col-lg-1" align = "left">   				
					<select class="selectpicker" id="findCategoryType" name="searchCategory">
						<option value="">카테고리별</option>
						<option value="식당">식당</option>
						<option value="카페">카페</option>
						<option value="교통">교통</option>
						<option value="숙박">숙박</option>
					</select> 
				</div>
			
				<div class="col-lg-16" align ="right"> 			
					<div align="left" style="margin-left: 20%; margin-right: 0%">
						<div class="input-group stylish-input-group">
							<input type="text" class="form-control" placeholder="가게 이름 검색" name="storeName" id="searchStoreName">
							<span class="input-group-addon">
								<button type="submit">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</form>
			
			<form method="post" action="/review/adminReviewIdSearch" onsubmit="return idInputCheck();">
				<div align = "left" class="col-md-4" style="margin-right:30%"> 			
						<div align="left">
							<div class="input-group stylish-input-group">
								<input type="text" class="form-control" placeholder="회원 id로 검색" name="id" id="searchId">
								<input type="hidden" name="page" value="<%=currentPage%>">
								<span class="input-group-addon">
									<button type="submit">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
				</div>
			</form>
	</div>
</div>

<div align="left" style="margin-left: 10%; margin-right:10%">
	<h2>리뷰 게시판</h2> 
	<%if(searchLocation ==null && searchCategory ==null && storeName ==null && id==null){ %>
		<h3>전체 게시글 수 : <%=listCount %></h3>
	<%}else{ %>
		<h3>검색된 게시글 수 : <%=listCount %> </h3>
	<%} %>
	
	
</div>
<hr>



<!-- PAGE CONTENT
    ============================== -->
<div class="container" align="left" style="margin-left:8%; margin-right:10%">
	<!-- Portfolio -->
	<div class="portfolio__items">
	<%for(ReviewBoard r : list){ %>
		<div class="cols">
			<div class="col-xs-12 col-sm-4 filter__item filter_modernism">
					<div class="portfolio__item">
						<!-- Image -->
						<div class="portfolio__img">
							<a href="portfolio-item.html"> 
							<img src="${pageContext.request.contextPath}/uploadfile/<%=r.getRenameImageName() %>" alt="Portfolio Image">
							</a>
						</div>
						<!-- Captions -->
						<div class="portfolio__caption">
							<h3 class="portfolio__title">
								<a href="/review/adminReviewDetail?postNo=<%=r.getPosting_no()%>&page=<%=currentPage%>">글제목  : <%=r.getTitle() %></a>
								<a href="/review/adminForceDelete?postNo=<%=r.getPosting_no()%>&page=<%=currentPage%>&limit=9"><button class = "btn btn-primary">삭제</button></a>
							</h3>  
							
								<div class="portfolio__intro">
								<%if(r.getEvaluation() == 1){%>
									평점: <img src="/review/resources/img/one.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 2){%>
									평점: <img src="/review/resources/img/2점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 3){%>
									평점: <img src="/review/resources/img/3점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 4){%>
									평점: <img src="/review/resources/img/4점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 5){%>
									평점: <img src="/review/resources/img/5점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 6){%>
									평점: <img src="/review/resources/img/6점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 7){%>
									평점: <img src="/review/resources/img/7점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 8){%>
									평점: <img src="/review/resources/img/8점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() == 9){%>
									평점: <img src="/review/resources/img/9점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}else if(r.getEvaluation() ==10){%>
									평점: <img src="/review/resources/img/10점.PNG" width="100px" height="25px"> <%=r.getEvaluation()%>점<br>
								<%}%>	
								가게명: <%=r.getStoreName()%> <br>	
								지역 : <%=r.getLocation() %>	<br>
								카테고리 : <%=r.getCategory() %> <br>
								작성자:<%=r.getId() %>
								</div>
						</div>
					</div>
				</div>
			</div> 
			<%} %>
		<!-- / .row -->
	</div>
	<!-- / .portfolio__items -->
</div>
<!-- / .container -->

	<!-- paging -->
      <div class="ui__section" id="ui_pagination" align="center">
         <nav>
            <ul class="pagination">
               <!-- 이전페이지 처리 -->
               <%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
                  <li><span aria-hidden="true">«««</span></li>
               <%}else{ %>   <!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
                  <li><a href="/review/adminReviewList?page=<%= currentPage-1 %>" aria-label="Previous"><span
                        aria-hidden="true">«««</span></a></li>   
               <%} %>
               
               <!-- 페이지 보여주기 -->
               <%for(int p = startPage; p<=endPage; p++){ 
                  if(p==currentPage){%>
                     <li class="active"><a><%=p %></a></li>               
                  <%}else{ %> 
                     <li><a href = "/review/adminReviewList?page=<%=p %>"><%=p %></a></li>
                  <%} %>
               <%} %>
               
               <!-- 다음페이지 처리 -->
               <%if(currentPage>=maxPage){ %>
                  <li><span aria-hidden="true">»»»</span></li>               
               <%}else{ %>
                  <li><a href="/review/adminReviewList?page=<%=currentPage+1%>" aria-label="Next">
                     <span aria-hidden="true">»»»</span></a></li>
               <%} %>
            </ul>
         </nav>
      </div>
</body>
</html>