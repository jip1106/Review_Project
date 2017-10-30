<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
 
<!DOCTYPE html>
<html lang="en">
<head>
<title>memberInfo</title>
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
		@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.woff')}
		@font-face{font-family:'CoreGTM5'; src:url('/review/resources/fonts/CoreGTM5.otf.eot')}
	
		body, table, div, p, a, h1, h2, h3, button, .header, li a.navbar-brand, .btn {
			font-family:'CoreGTM5';
		}
	</style>
	
     <script type="text/javascript">
    	
    	function checkpw(){
    		if(document.getElementById('password').value != document.getElementById('passwordCheck').value){
    			alert("비밀번호를 확인해주세요!");
    			document.updateForm.passwordCheck.focus();
    			return false;
    		}
    		return true;
    	}
    	
    	function goMain(){
    		location.href = "/review/views/main/main.jsp";
    		return false;
    	}
     </script>
</head>
<body>
<%@ include file="../../../header.jsp" %>
<%@ include file="leftmenu.jsp"%>

<div class="container">
	<div class="row">

		<div style="margin-left: 10%; margin-right: 10%;" >
			<form action="/review/mupdate" method="post" id="memberUpdateForm" name="updateForm" onsubmit = "return checkpw();">	<!-- 수정 -->
				<!-- Tab content -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="personal-info">
						<h3 style="color: black;"><b>회원 정보</b></h3>
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">아이디</th>
										<td><input type="text" id= "id" name="id" class="form-control" value="<%=member.getId() %>" readonly></td> 
									</tr>
									<tr>
										<th scope="row">비밀번호</th>
										<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호" required></td>
									</tr>
									<tr>
										<th scope="row">비밀번호 확인</th>
										<td><input type="password" id="passwordCheck" name="passwordCheck" class="form-control" placeholder="비밀번호확인" required> 
										</td>
									</tr>
									<tr>
										<th scope="row">이름</th>
										<td><input type="text" class="form-control"
											id="sign-up__name" name="name" placeholder="이름" value = "<%=member.getName()%>"required></td>
									</tr>
									<tr>
										<th scope="row">이메일</th>
										<td><input type="email" class="form-control" id="sign-up__email" name="email" placeholder="이메일" 
										value = "<%=member.getEmail()%>" required></td>
									</tr>
									<tr>
										<th scope="row">경고 횟수</th>
										<td><input type="text" class="form-control"
												id="warning_count" name="wc" class="form-control" value="<%=member.getWarningCount()%>"readonly></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- / .table-responsive -->
					</div>
					<div>
						<%if(member.getWarningCount()>=1){ %>
							<h2>신고 게시판에 신고가 들어 왔습니다<br>
								경고횟수가 3번 이상이면 강제 탈퇴 되니 조심해 주세요</h2>
						<%}%>						
						
					</div>
					<br><br>
					<div align="center"> 
						<input type="submit" class="btn btn-primary" value="수정하기" style="width: 150px; background: red;"> &nbsp;&nbsp;
						<input type="reset" class="btn btn-primary" value="취소하기" style="width: 150px;  background: red;"> &nbsp;&nbsp;
						<button class="btn btn-primary" style="width: 150px;  background: red;" onclick = "return goMain()">메인 화면으로</button>
				
					</div> 
				
				</div>
				<!-- / .tab-content -->
			</form>
			
			
		</div> 
	</div>
	<!-- / .row -->
</div>

<!-- / .container -->
<!-- / .container -->
</body>
</html>