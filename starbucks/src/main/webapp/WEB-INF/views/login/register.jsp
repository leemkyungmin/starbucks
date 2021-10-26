<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/register.css">
<script>
	function phone_auth_check(){
		var phone_num = $('#user_phone').val();
		
		if(phone_num =='' || phone_num ==null){
			alert('휴대폰번호를 입력해주세요');
			phone_num.focus();
		} else if(phone_num <11) {
			alert('휴대폰번호를 정확하게 입력해주세요');
			phone_num.focus();
		} else {
			$.ajax({
				url :'${url}/login/sendsms',
				type:'post',
				data : 'phone='+phone_num,
				success:function(data){
					$('#user_phone').attr('readonly',true);
					$('.phonebtn').css({'display' : 'none'});
					$('.phone_auth').css({'display' : 'block'});
				},error: function(){
					console.log('통신실패');
				} 
			});
		}
		
	}
	function pauth_check(){
		var user_auth_num = $('#auth_check').val();
		var phone = $('#user_phone').val();
		$.ajax({
			url:'${url}/login/auth_check',
			data : 'auth='+user_auth_num +'&phone='+phone,
			type:'post',
			success:function(data){
				
				if(data =='success'){
					//인증 성공
					alert('인증성공');
					$('phone_auth').css({'display' : 'none'});
					
				} else {
					// 인증 실패
					alert('인증 실패 인증번호를 확인해주세요');
				}
			},error:function(){
				console.log('error');
			}
		});
	}
</script>

	<div class="main_wrap">
		<form action="${url}/login/register" method="post">
			<section class="register_wrap"> 
				<div class="register_inner">
					<label for="user_id" class="hid">아이디</label>
					<input type="text" name="user_id" id="user_id" placeholder="아이디" maxlength="20">
					<p class="id_check hid" ></p>
					
					<label for="user_pw" class="hid">비밀번호</label>
					<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호" maxlength="20">
					
					<label for="user_pw_chk" class="hid">비밀번호확인</label>
					<input type="password" name="user_pw_chk" id="user_pw_chk" placeholder="비밀번호확인" maxlength="20">
					<p class="pw_check hid" ></p> 
					
					<label for="user_nickname" class="hid">닉네임</label>
					<input type="text" name="user_nickname" id="user_nickname" placeholder="닉네임" maxlength="10">
					
					<label for="user_email" class="hid">이메일</label>
					<input type="text" name="user_email" id="user_email" placeholder="이메일"> @ 
					<input type="text" name="email_addr" id="email_addr">
					<select id="addr">
						<option value="직접입력">직접입력</option>
						<option value="gmail.com">지메일</option>
						<option value="naver.com">네이버</option>
						<option value="hanmail.net">한메일</option>
						<option value="daum.net">다음</option>
					</select>
					<label for="user_phone" class="hid">휴대폰번호</label>
					<input type="text" name="user_phone" id="user_phone" placeholder=" ( - )를제외한 휴대폰번호" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11">
					<input type="button" value="휴대폰인증" class="phonebtn" onclick="phone_auth_check();">
					<p class="phone_chk hid"></p>
					<div class="phone_auth hid">
						<input type="text" name="auth_check" id="auth_check">
						<input type="button" value="인증" class="authbtn" onclick="pauth_check();">	
					</div>
					
				</div>
			</section>
		</form>
	</div>
</body>
</html>