<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@
	page import = "admin.model.service.MemberAdminService,admin.model.dao.MemberAdminDao"
%>
<%@ 
	page import = "adminNotice.model.dao.NoticeDao, adminNotice.model.service.NoticeService, adminNotice.model.vo.Notice,java.util.ArrayList"
%>
<%@
	page import = "memberComplainBoard.model.vo.ComplainBoard,adminComplainBoard.model.dao.ComplainBoardDao,adminComplainBoard.model.service.ComplainBoardService"
 %>
 
<%@
	page import = "memberReviewBoard.model.vo.ReviewBoard,adminReviewBoard.model.dao.ReviewBoardDao,adminReviewBoard.model.service.ReviewBoardService"
 %>
 
<%@
	page import = "memberSharedBoard.model.vo.SharedBoard,adminShareBoard.model.dao.ShareBoardDao,adminShareBoard.model.service.ShareBoardService"
 %>

<%		
	ArrayList<Notice> noticeList = new NoticeService().viewNoticeList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 페이지</title>
<!-- CSS Global -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

    <!-- CSS Plugins -->
    <link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
<!-- jQuery 쓸라고 추가한거 -->
<script type="text/javascript" src = "../../../js/jquery-3.2.1.min.js"></script>


<script type="text/javascript">
	function noticeWrite(){
		location.href="../notice/noticewrite.jsp";
	}
</script>

</head>


<body>
<%@ include file = "../../../header.jsp" %>
<div class="container" align="center">
	<!-- noticeWrite() 메서드 구동, 글작성 페이지로 이동 noticewrite.jsp-->
		<button class="btn btn-default btn-lg btn-block" id="nwrite" onclick="noticeWrite();" >공지등록</button>		
	<!-- </a> -->
</div>

<div class="container" align="center"><!-- 공지사항 띄워 줄 공간 -->
		<div align="left" style="margin-left: 10%; margin-right: 10%">
		<h2>공지사항</h2>
		
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
						<th style="background-color: tomato">비고</th>
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
					<td>
						<%if(member.getId().equals(notice.getId())){ %>
				 		<a href="/review/noticedel?postno=<%=notice.getPostingNo()%>">
							<button class="btn" style="color: red">공지사항 삭제</button>
						</a>		 			
						<%} %>
					</td>
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

<br><br><br><br><br>
<div class="container" align="center">
		<table border="1" class="table table-striped table-bordered">
			<tr height="50">
				<th><label style="font-size: 20pt"><a href="#">&nbsp;리뷰게시글관리&nbsp;</a></label></th> <!-- 관리자 리뷰게시판 불러오는 서블릿 a태그로 연결-->
				<th><label style="font-size: 20pt"><a href="/review/adminsblist">&nbsp;공유게시글관리&nbsp;</a></label></th> <!-- 관리자 정보공유 게시판 불러오는 서블릿 a태그로 연결 -->
			</tr>
			<tr height="80">
				<td><label style="font-size: 50pt">아직 X</label></td> <!-- 관리자 ReviewService, Dao에 글 갯수 가져오는 메서드 -->
				<td><label style="font-size: 50pt"><%= new ShareBoardService().getShareBoardListCount()%>(개)</label></td> <!-- 관리자 SharedService, Dao 에 글 갯 수 가져오는 메서드 -->
			</tr>
			<tr align="center" height="50">
				<th><label style="font-size: 20pt"><a href = "/review/cblist">&nbsp;신고게시글관리&nbsp;</a></label></th>
				<th width="80"><label style="font-size: 20pt">&nbsp;<a href="/review/mlist">회원관리&nbsp;</a></label></th>
			</tr>
			<tr>
				<td width="80"><label style="font-size: 50pt"><%= new ComplainBoardService().getComplainBoardListCount() %>(개)</label></td>
				<td width="80"><label style="font-size: 50pt"><%= new MemberAdminService().getMemberCount() %>(명)</label></td>
			</tr>
		</table>
	</div> 
</body>
</html>