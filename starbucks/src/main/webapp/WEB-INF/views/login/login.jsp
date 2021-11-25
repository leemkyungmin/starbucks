<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>
<link rel="stylesheet" href="${url}/resources/assets/style/login.css">
<script>
	$().ready(function(){
		
		if( ${sessionScope.udto !=null} ){
			location.href = document.referrer;
		}
		
		var savedId =localStorage.getItem('id');
		
		if( savedId !=null ){
			$('#user_id').val(savedId);
			$('#saveidBtn').prop('checked','checked');
		}
		//localStorage에 저장된 아이디가 있으면 
		
		if(localStorage.getItem('savedId') !=null){
			$('#saveidBtn').attr('checked',true);
			$('#user_id').val(localStorage.getItem('savedId'));
		}
		
		$('.login_btn').click(function(){ 
			
			var id =$('#user_id');
			var pw =$('#user_pw');
			if(id.val().length ==0 ){
				alert('아이디를 입력해주세요');
				id.foucs();
				return ;
			} else if(pw.val().length ==0){
				alert('비밀번호를 입력해주세요'); 
				pw.focus();
				return ;
			} else {
				
				//ajax 로그인 처리 
				$.ajax({
					url:'${url}/login/logincheck', 
					type:'post',
					data :'id='+id.val().trim()+'&pw='+pw.val().trim(),
					success :function(result){
						if( result !='fail') {
							if($('#saveidBtn').is(':checked')){
								localStorage.setItem('id',id.val().trim());
							} else {
								localStorage.removeItem('id');
							}
							
							alert(result+'님 반갑습니다.');
							if(${redirect eq null}){
								
								location.href = document.referrer;
							} else {
								location.href='${url}/${redirect}';
							}
							
							
							
						} else {
							alert('아이디 비밀번호를 확인해주세요 ');
						}
					}
				});
			}
			
		});
				
	});
	
</script>
	<div class="login_background">
		<div class="login_wrap">
			<div class="login_inner">
				<form id="login_fm"  method="post">
					<strong class="login_inner_title">로그인</strong>
					<section class="login_area">
						<p class="jTitle">
							<span class="style_green">Welcome!</span>
							스타벅스커피 코리아에 오신 것을 환영합니다.
						</p>
						<div class="login_form">
							<label for="user_id" class="hide">아이디</label>
							<input type="text" name="user_Id" id="user_id" placeholder="아이디를 입력해 주세요" required>
							<label for="user_pw" class="hide">비밀번호</label>
							<input type="password" name ="user_pw" id="user_pw" placeholder="비밀번호를 입력해주세요" required autocomplete="off">
							
							<span class="saveId_wrap">
								<input type="checkbox" name="saveidBtn" id="saveidBtn">
								<label for="saveidBtn" class="saveid">아이디 저장</label>
							</span>
							
							<p class="p_login_btn">
								<a class="login_btn" href="javascript:void(0);" role='submit'>로그인</a>
							</p>
							<p class="warning_txt">
								* 타 사이트와 비밀번호를 동일하게 사용할 경우 도용의 위험이 있으므로, 정기적인 비밀번호 변경을 해주시길 바랍니다.
								<br>
								* 스타벅스 커피 코리아의 공식 홈페이지는 Internet Explorer 9.0 이상, Chrome, Firefox, Safari 브라우저에 최적화 되어있습니다.
										
							</p>
							
						</div>
						<div class="register_util_btn">
							<ul>
								<li>
									<a href="${url}/login/register">회원가입</a>
								</li>
								<li>
									<a href="${url}/login/find_id">아이디 찾기</a>
								</li>
								<li>
									<a href="${url}/login/find_pw">비밀번호 찾기</a>
								</li>
							</ul>
						</div>
											
						 
					</section>
				</form>	
			</div>
		</div>
	</div>
	

<%@ include file ="../Template/fotter.jsp" %>
</body>
</html>