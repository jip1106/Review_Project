<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard, java.util.ArrayList"%>
<%
	ArrayList<ComplainBoard> list = (ArrayList<ComplainBoard>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int limit = ((Integer)request.getAttribute("limit")).intValue();	//관리자가 게시글 삭제했을때 전 페이지로 넘기기 위해서 넘겼음
	String searchMenu = null;
	String searchValue = null;
	
	if((String)request.getAttribute("searchMenu")!=null){
		searchMenu = (String)request.getAttribute("searchMenu");
	}
	if((String)request.getAttribute("searchValue")!=null){
		searchValue=(String)request.getAttribute("searchValue");
	}
	

	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta charset="utf-8">
<!--<link rel="icon" href="img/favicon.ico">-->

<!-- CSS Global -->
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet">

<!-- CSS Plugins -->
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/animate.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700'
	rel='stylesheet' type='text/css'>

<style type="text/css">
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


</head>

<body>
	<%@ include file="../../../../header.jsp"%>


	<br>
	<br>
	<br>
	<div align="left" style="margin-left: 10%; margin-right: 10%">
		<div align="left">
			<form class="form-group" role="form" method="post" action="/review/cbsearch">
				<select class="btn" id="findType"
					style="height: 30px; color: #ffffff;" name="searchMenu">
					<option value="findByTitle">제목</option>	
					<option value="findByWriter">작성자</option>
				</select>	<!-- select 속성에서 name 값을 getParamater으로 받아오면 속성값(value) 넘어옴 -->
								
				<input style="height: 25px; width: 200px;" name ="searchValue" type="search"
					id="searchKeyWord" placeholder="제목 혹은 작성자로 검색 " class="btn2">
								
				<button type="submit" id="searchSubmit" value="검색" class="btn"
					style="color: #ffffff">검색</button>	<!-- (ComplainBoardSearchServlet)-->
				&nbsp;&nbsp;&nbsp;&nbsp;				
			</form>
			<!-- btn-primary class : style.css에 있음 -->
		</div>
	</div>

	<div align="left" style="margin-left: 10%; margin-right: 10%">
		<h2>신고게시판</h2>
		<%if(searchMenu==null){ %>
			<h3>전체 게시글 수 : <%=listCount %></h3>
		<%}else{ %>
			<h3>검색된 게시글 수 : <%=listCount %></h3>
		<%} %>
		<div class="table-responsive">
			<table class="table table-striped table-bordered">
				<caption>신고게시판에 올라온 게시글 입니다.</caption>
				<thead>
					<tr>
						<th style="background-color: tomato">글번호</th>
						<th style="background-color: tomato">제목</th>
						<th style="background-color: tomato">작성자</th>
						<th style="background-color: tomato">작성일</th>
						<th style="background-color: tomato">조회수</th>
						<th style="background-color: tomato">비고</th>
					</tr>
				</thead>
				<%
					for (ComplainBoard cboard: list) {
				%>
				<tr>
					<td><%=cboard.getPostingNo()%></td>
					<td><!-- 게시판 상세보기 해주는 cbdetail -->
						<a href="/review/cbdetail?postno=<%= cboard.getPostingNo() %>&currentPage=<%= currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>">
							<%= cboard.getTitle() %>
						</a>
					</td>
					<td><%=cboard.getId()%></td>
					<td><%=cboard.getPostingDate()%></td>
					<td><%=cboard.getHits()%></td>
					<td><!-- 신고게시판 메인에서 관리자가 삭제할 수 있게 해주는 서블릿 cbfdelete-->
						<a href="cbfdelete?postno=<%= cboard.getPostingNo()%>&currentPage=<%= currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>">
							<button class="btn" style="color: white">게시글 삭제</button>
						</a>
					</td>
				</tr>
				<%
					}
				%>
			</table>
		
		</div>
		<!-- / .table-responsive -->

		<!-- paging -->
	<%if(searchMenu == null){ %>
		<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					<!-- 이전페이지 처리 -->
					<%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
						<li><span aria-hidden="true">«««</span></li>
					<%}else{ %>	<!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
						<li><a href="/review/cblist?page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">«««</span></a></li>	
					<%} %>
					
					<!-- 페이지 보여주기 -->
					<%for(int p = startPage; p<=endPage; p++){ 
						if(p==currentPage){%>
							<li class="active"><a><%=p %></a></li>					
						<%}else{ %>
							<li><a href = "cblist?page=<%=p %>"><%=p %></a></li>
						<%} %>
					<%} %>
					
					<!-- 다음페이지 처리 -->
					<%if(currentPage>=maxPage){ %>
						<li><span aria-hidden="true">»»»</span></li>					
					<%}else{ %>
						<li><a href="/review/cblist?page=<%= currentPage+1 %>" aria-label="Next">
							<span aria-hidden="true">»»»</span></a></li>
					<%} %>
				</ul>
			</nav>
		</div>
		<%}else{ %>
		<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					<!-- 이전페이지 처리 -->
					<%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
						<li><span aria-hidden="true">«««</span></li>
					<%}else{ %>	<!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
						<li><a href="/review/cblist?page=<%= currentPage-1 %>&searchValue=<%=searchValue %>&searchMenu=<%=searchMenu %>" aria-label="Previous"><span
								aria-hidden="true">«««</span></a></li>	
					<%} %>
					
					<!-- 페이지 보여주기 -->
					<%for(int p = startPage; p<=endPage; p++){ 
						if(p==currentPage){%>
							<li class="active"><a><%=p %></a></li>					
						<%}else{ %>
							<li><a href = "cblist?page=<%=p %>&searchValue=<%=searchValue%>&searchMenu=<%=searchMenu%>"><%=p %></a></li>
						<%} %>
					<%} %>
					
					<!-- 다음페이지 처리 -->
					<%if(currentPage>=maxPage){ %>
						<li><span aria-hidden="true">»»»</span></li>					
					<%}else{ %>
						<li><a href="/review/cblist?page=<%= currentPage+1 %>&searchValue=<%=searchValue %>&searchMenu=<%=searchMenu %>" aria-label="Next">
							<span aria-hidden="true">»»»</span></a></li>
					<%} %>
				</ul>
			</nav>
		</div>
		
		<%} %>
		<!-- / .ui__section -->
	</div>
</body>
</html>