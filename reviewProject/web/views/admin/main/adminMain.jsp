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
	

<!-- 아코디언 메뉴 스타일부분임 -->
<style>
	.accordionMenu{
		font : 12px/20px;
		color:#424242;
		background:white;
		padding:10px;
		width:200px;
		margin:0;
	}
	.accordionMenu h1 {
		margin:0;
		font-size:20px;
		text-shadow:2px 2px 2px #aeaeae;
	}
	.accordionMenu h2{
		margin:5px 0;
		paddion:0;
	}

	.accordionMenu h2 a{
		font-size:15px;
		display:block;
		font-weight:normal;
		color:#424242;
		text-shadow:2px 2px 2px #aeaeae;
		text-decoration:none;
		margion:0;
		padding:10px;
		background:white;
	}

	.accordionMenu h2 a{
		font-size:15px;
		display:block;
		font-weight:normal;
		color:white;
		text-shadow:2px 2px 2px #aeaeae;
		text-decoration:none;
		margion:0;
		padding:10px;
		background:-moz-linear-gradient(top,#cecece,#8f8f8f);
		background:-webkit-gradient(linear,left top, left bottom, from(#F2F2F2), to(#F2F2F2));
		filter: progid:DXImageTransform.Microsoft.gradient
		(startColorstr=#ffcecece, endColorstr=#ff8f8f8f);
		-ms-filter: "progid:DXImageTransform.Microsoft.gradient
		(startColorstr=#ffcecece, endColorstr=#f8f8f8f)";
		-webkit-border-radius:5px;
		-moz-border-radius:5px;
		border-radius:5px;
	}

	.accordionMenu :target h2 a,
	.accordionMenu h2 a:focus,
	.accordionMenu h2 a:hover,
	.accordionMenu h2 :active {
		background:#2288dd;
		background:-moz-linear-gradient(top,#6bb2ff,#2288dd);
		background:-webkit-gradient(linear,left top, left bottom, from(#4D81B0), to(#4D81B0));
		-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff6bb2ff, endColorstr=#ff2288dd)";
		color:#fff;
	}

	.accordionMenu p {
		padding:0 10px;
		margin:0;
		height:0;
		overflow:hidden;
		-moz-transition:height 0.5s ease-in;
		-webkit-transition:height 0.5s ease-in;
		-o-transition:hegith 0.5s ease-in;
		tansition:height 0.5s ease-in;
	}

	.accordionMenu :target p{
		overflow: auto;
		height:50px; /* 펼쳐진 아코디언 높이  */
	}
	</style>

</head>


<body>
<%@ include file = "../../../header.jsp" %>


<!-- <div class="container" align="center"> -->
	<!-- noticeWrite() 메서드 구동, 글작성 페이지로 이동 noticewrite.jsp-->
				
	<!-- </a> -->
<!-- </div> -->

<div class="" align="" ><!-- 공지사항 띄워 줄 공간 -->
		<div align="left" style="margin-left: 1%; margin-right: 5%">
		
		<!-- 아코디언 메뉴 만들꺼임 -->
<div class="accordionMenu" style="float: left; width: 20%">

		<div id="review" class="menuSection">
			<h2 align="center"><a href="#review"><label style="font-size: 15pt; text-align: center;">&nbsp;리뷰게시글관리&nbsp;</label></a></h2>
			<p>
			<label style="font-size: 15pt; text-align: center;">게시글 수 : <a href="/review/adminReviewList" style="color: red"><%= new ReviewBoardService().getReviewListCount() %>(개)</a></label>
			</p>
		</div>
		<div id="share" class="menuSection">
			<h2 align="center"><a href="#share"><label style="font-size: 15pt; text-align: center">&nbsp;공유게시글관리&nbsp;</label></a></h2>
			<p>
			<label style="font-size: 15pt; text-align: center">게시글 수 : <a href="/review/adminsblist" style="color: red"><%= new ShareBoardService().getShareBoardListCount()%>(개)</a></label>
			</p>
		</div>
		<div id="complain" class="menuSection">
			<h2 align="center"><a href="#complain"><label style="font-size: 15pt; text-align: center">&nbsp;신고게시글관리&nbsp;</label></a></h2>
			<p>
			<label style="font-size: 15pt; text-align: center">게시글 수 : <a href = "/review/cblist" style="color: red"><%= new ComplainBoardService().getComplainBoardListCount() %>(개)</a></label>
			</p>
		</div>
		<div id="member" class="menuSection">
			<h2 align="center"><a href="#member"><label style="font-size: 15pt; text-align: center">&nbsp;회원관리&nbsp;</label></a></h2>
			<p>
			<label style="font-size: 15pt; text-align: center">회원 수 : <a href="/review/mlist" style="color: red"><%= new MemberAdminService().getMemberCount() %>(명)</a></label>
			</p>
		</div>
	</div>
	
	<!--  아코디언 메뉴 끝-->
		
		<div style="float: left; width: 80%">
		<h2>공지사항</h2>
		
			<table class="table table-striped table-bordered">
					<tr>
						<td colspan="6" align="right">
							<button class="btn" id="nwrite" onclick="noticeWrite();" style="background-color: #4D81B0; color: white" >공지등록</button>
						</td>
					</tr>
					<tr>
						<th style="background-color: #4D81B0; color: white; text-align: center">번호</th>
						<th style="background-color: #4D81B0; color: white; text-align: center" >제목</th>
						<th style="background-color: #4D81B0; color: white; text-align: center" >작성자</th>
						<th style="background-color: #4D81B0; color: white; text-align: center" >작성일</th>
						<th style="background-color: #4D81B0; color: white; text-align: center" >조회수</th>
						<th style="background-color: #4D81B0; color: white; text-align: center" >비고</th>
					</tr>
				<%
				if(noticeList !=null){
					for(Notice notice: noticeList) {
				%>
				<tr>
					<td style="text-align: center"><%=notice.getPostingNo()%></td>
					<td style=" text-align: center;">
						<a style="color: red" href="/review/noticeDetail?postno=<%= notice.getPostingNo() %>">
							<%= notice.getTitle() %>
						</a>
					</td>
					<td style=" text-align: center"><%=notice.getId()%></td>
					<td style=" text-align: center"><%=notice.getPostingDate()%></td>
					<td style=" text-align: center"><%=notice.getHits()%></td>
					<td style=" text-align: center">
						<%if(member.getId().equals(notice.getId())){ %>
				 		<a href="/review/noticedel?postno=<%=notice.getPostingNo()%>">
							<button class="btn" style="background-color: #4D81B0; color: white">공지사항 삭제</button>
						</a>		 			
						<%} %>
					</td>
				</tr>
				<%
					}
				}
				%>
			</table>
			<!-- 공지사항 끝 --><br><br>
			<hr>
			<div style="float: left; width: 100%">
				<h2>경고수 <font color="red">3회</font> 이상인 회원</h2>
				<table class='table table-striped table-bordered'>
					
						<tr>
							<th style="background-color: #4D81B0; color: white; text-align: center">회원Id</th>
							<th style='background-color: #4D81B0; color: white; text-align: center'>이름</th>
							<th style='background-color: #4D81B0; color: white; text-align: center' >이메일</th>
							<th style='background-color: #4D81B0; color: white; text-align: center' >경고횟수</th>
							<th style='background-color: #4D81B0; color: white; text-align: center' >삭제</th>
							
						</tr>
					
					<tbody id = "maxWarningCount">	<!-- 회원정보 찍어주는 자리 -->
					
					</tbody>
									
				</table>
			</div>
			
			
			
			</div>
			
			
			<!-- 삭제될 회원 시작 ajax 이용-->
			
			
			
			
			
			<br>
		<table border="1" class="table table-striped table-bordered">
			<!-- 여기에 top3 보여주는거 넣을꺼야!!!!!!  -->
			<!-- 신고 게시판 최신글 3개 뽑아오기 -->
			
		</table>
		</div>
	</div>
		
		<script type="text/javascript">
	
			$(function(){
				selectWarningCountOverThreeMember();		
			})
	
			function selectWarningCountOverThreeMember(){
				$.ajax({
					url: "/review/viewWarningCountOverThree.do",
					type: "get",
					dataType: "json",
					success: function(data){
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						var values = "";
						
						for(var i in json.list){
						
							values+="<tr>"+ 
										"<td style='text-align:center'>" + decodeURIComponent(json.list[i].id) + "</td>"+
										"<td style='text-align:center'>" + decodeURIComponent(json.list[i].name) + "</td>"+
										"<input type='hidden' id='fdeleteEmail' value='"+decodeURIComponent(json.list[i].email)+"'>"+
										"<td style='text-align:center'>" + decodeURIComponent(json.list[i].email) + "</td>"+
										"<td style='text-align:center'><font color='red'>" + json.list[i].warningCount  +"</font></td>"+
										"<td style='text-align:center'>"+
											"<input type='hidden' id='fdelete' value='"+decodeURIComponent(json.list[i].id)+"'>"+
												"<a class='btn' onclick='forceDelete()' style='background-color: #4D81B0; color: white'>" + 
													"삭제</a></td></tr>";
										
							
						}
						
						$("#maxWarningCount").html(values);
					}
				});
			}
	
	
		 function forceDelete(){
			var id = $("#fdelete").val();
			var email =$("#fdeleteEmail").val(); 
			if(confirm("정말 회원을 탈퇴 시키시겠습니까?")==false){
				return false;
			}else{
				
				$.ajax({
					url:"/review/mainForceDelete.do",
					data : {"id":id,"email":email},
					type:"get",
					async:false
				})
								
				selectWarningCountOverThreeMember();
				
				alert("탈퇴 되었습니다.");
				return true;
			}
		}
 
	
	function noticeWrite(){
		location.href="../notice/noticewrite.jsp";
	}
	
	
	
</script>
	
<%@ include file = "../../../footer.jsp" %>
</body>
</html>