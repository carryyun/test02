<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="wrap header">
	<div class="container nop">
		<div class="row">
			<div class="col-md-6">
				<section>
					<span><a href="#">가드</a></span>
					<span>메뉴1</span>
					<span>메뉴2</span>
					<span>메뉴3</span>
				</section>
			</div>
			<div class="col-md-6">
				<div id="signDiv" class="col-md-12">
					<section class="float-right">
						<span></span>
						<span id="signUpBtn">회원가입</span>
						<span id="signInBtn">로그인</span>
					</section>
				</div>
				<div id="userDiv" class="col-md-12">
					<section class="float-right">
						<span id="signOutBtn">로그아웃</span>
					</section>
				</div>
				
			</div>
		</div>
		
	</div>
</div>


<script>
const mainpage="upbitTest10";
$(document).ready(function(){
	
	if( ${sessionScope.curUser == null} ){
		$('#signDiv').css('display','block');
		$('#userDiv').css('display','none');
		document.getElementById('signInBtn').addEventListener( 'click', e =>{
			 location.href = "login";
		} );
	}else{
		$('#signDiv').css('display','none');
		$('#userDiv').css('display','block');
		
		document.getElementById('signOutBtn').addEventListener( 'click', e =>{
			$.ajax({
				url:"signOut.do",
				type: "POST",
				success: function(data){
					location.href=mainpage;
				
				}
			});
			 
		} );
	}
	
});
</script>