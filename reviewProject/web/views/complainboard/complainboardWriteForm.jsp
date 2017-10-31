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


	<script>
		function pleaseInputMessage(){
			if($("#title").val()=="" || $("#content").val()==""){
				alert("글 제목과 내용을 입력해 주세요!");
				return false;
			}
		}
	</script>
<script type="text/javascript">	
	 function pleaseInputMessage(){
	
	
	}
</script>
</head>
<body>
<%@ include file = "../../header.jsp" %>

<div class="container">
	<div class="row">
		<div align="left" style="margin-left: 15%; margin-right: 15%">
			<h3 style="color: black;"><b>Complainboard Write</b></h3><br>
			<p class="text-muted">불건전한 게시글을 신고해 주세요</p>
			<form role="form" action="/review/cinsert" method="post">
			<input type="hidden" name="id" value="<%= member.getId() %>">
				
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" id="title" placeholder="title"> 
					<span class="help-block"></span>
				</div>

				

				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control"  id="content" placeholder="content"></textarea>
					 <span class="help-block"></span>  
				</div>
<<<<<<< HEAD
				
					<button type="submit" class="btn btn-primary" onclick = "return pleaseInputMessage()" style="background:#4D81B0">글작성</button>
					<button type="reset" class="btn btn-primary" style="background:#4D81B0">작성 취소</button>
					<button type="submit" class="btn btn-primary" onclick="/review/clist" style="background:#4D81B0">돌아가기</button>
				

=======
				<div class="form-group" align="center">
					<button type="submit" class="btn btn-primary" style="width: 160px; background: red;" onclick = "return pleaseInputMessage()">글작성</button>
					<button type="reset" class="btn btn-primary" style="width: 160px; background: red;">작성 취소</button>
					<button  class="btn btn-primary" style="width: 160px; background: red;" onclick="javascript:history.go(-1); return false">목 록</button>
				</div>
>>>>>>> somi
			</form>

		</div>
		</div>
</div>
<%@ include file = "../../footer.jsp" %>
</body>
</html>