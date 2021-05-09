<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="/resources/yun/cms/css/globalCSS.css?a" rel="stylesheet"> 
<link href="/resources/yun/cms/css/bootstrap.css?b" rel="stylesheet"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body class="darkBluePane">
	<div class="container">
		<div class="row justify-content-around">
			<div class="col-md-8 greyPane text-center">
				<form action="signIn.do" id="frm" method="POST">
					<input type="text" name="id" id="inputId" class="clearInputNoBorder greyPane fs-16 mb-5px" placeholder="ID"> <br/>
					<input type="password" name="pw" id="inputPassword" class="clearInputNoBorder greyPane fs-16 mb-5px" placeholder="PassWord"> <br/>
					
					<button onclick="document.getElementById('frm').submit()">로그인</button> <button>회원가입</button>
					
				
				</form>
			</div>
		</div>
	</div>
</body>
</html>