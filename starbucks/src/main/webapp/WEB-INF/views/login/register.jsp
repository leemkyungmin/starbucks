<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/register.css">
<script> 
	var idcheck =false;
	var pwcheck =false;
	var nicknamecheck = false;
	var emailcheck =false;
	var phonecheck =false;
	
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
				url :'${url}/login/register/sendsms',
				type:'post',
				data : 'phone='+phone_num,
				success:function(data){
					
					if(data == 'true'){
						$('#user_phone').attr('readonly',true);
						$('.phonebtn').css({'display' : 'none'});
						$('.phone_auth').css({'display' : 'block'});
					} else {
						alert('이미 등록된 휴대폰 번호입니다.')
					}
				},error: function(){
					console.log('통신실패');
				} 
			});
		}
		
	};
	function pw_chk(){
		var pw = $('#user_pw').val();
		var pw_chk =$('#user_pw_chk').val();
		if(pw.length >4 && pw_chk.length >4 && pw==pw_chk ) {
			$('.pw_check').css({'display' : 'block','color' : 'green' , 'font-weight' :'bold'});
			$('.pw_check').text('사용가능한 비밀번호입니다.');
			pwcheck =true;
		} else {
			$('.pw_check').text('비밀번호를 확인해주세요');
			$('.pw_check').css({'color' : 'red' , 'font-weight' :'bold'});
			pwcheck = false;
		}
	};
	//인증번호 체크
	function pauth_check(){
		var user_auth_num = $('#auth_check').val();
		var phone = $('#user_phone').val();
		$.ajax({
			url:'${url}/login/register/auth_check',
			data : 'auth='+user_auth_num +'&phone='+phone,
			type:'post',
			success:function(data){
				
				if(data =='success'){
					//인증 성공
					alert('인증성공');
					$('phone_auth').css({'display' : 'none'});
					phonecheck =true;
					
				} else {
					// 인증 실패
					alert('인증 실패 인증번호를 확인해주세요');
					phonecheck =false;
				}
			},error:function(){
				console.log('error');
			}
		});
	};
	
	
	
	function nickname_chk(){
		
		var nick = $('#user_nickname').val();
		
		if(nick.length >0){
			$.ajax({
				url:'${url}/login/register/nicknamecheck',
				type :'post',
				data:'nick='+nick,
				success:function(e){
					
					$('.nickname_check').css({'display' : 'block','font-weight' : 'bold'});				
					if(e=="true"){
						$('.nickname_check').text('사용 가능한 닉네임 입니다.');
						$('.nickname_check').css({'color' : 'green'});
						nicknamecheck =true;
					} else {
						$('.nickname_check').text('이미 사용중인 닉네임 입니다.');
						$('.nickname_check').css({'color' : 'red'});	
						nicknamecheck =false;
					}
					
				},error:function(){
					console.log('통신실패');
				}
			});
		} else {
			$('.nickname_check').css({'display' : 'none'});
			nicknamecheck =false;
		}
		
		
	};
	
	
	
	$().ready(function(){
		
		$(document).on('keyup','#user_id',function(){
			var id = $('#user_id').val();
			if(id.length >3){
				$.ajax({
					url : '${url}/login/register/idcheck',
					type : 'post',
					data :'uids='+id,
					success:function(data){
						
						if(data =='true'){
							idcheck =true;
							$('.id_check').text('사용가능한 아이디입니다.');
							$('.id_check').css({'display' : 'block' , 'color' :'green','font-weight' : 'bold'});
						} else {
							idcheck =false;
							$('.id_check').text('이미 사용중인 아이디입니다.');
							$('.id_check').css({'display' : 'block' , 'color' :'red','font-weight' :'bold'});
						}
					
						
					},error:function(){
						console.log('error');
					}
				});
			} else {
				idcheck =false;
				$('.id_check').text('아이디를 입력해주세요');
				$('.id_check').css({'display' : 'block' , 'color' :'red','font-weight' :'bold'});
			}
			
		});
		
		$(document).on('change','#addr',function(){
			
			var addr = $(this).val();
			var emailaddr = $('#email_addr');
			if(addr !=''){
				emailaddr.val(addr);
				emailaddr.attr('readOnly',true);
			} else {
				emailaddr.val('');
				emailaddr.attr('readOnly',false);
			}
			
		});
		
		$('.registerbtn').on('click',function(){
			
			
			if( idcheck !=true ) {
				alert('아이디가 공백이거나 중복된 아이디입니다.');
				$('#user_id').focus();
			} else if( pwcheck !=true ) {
				alert('비밀번호가 틀립니다.');
				$('#user_pw').focus();
			} else if( nicknamecheck !=true ) {
				alert('닉네임을 입력해주세요');
				$('#user_nickname').focus();
			} else if( phonecheck !=true ) {
				alert('휴대폰 인증해주세요');
			} else {
				var form =$('#rform');
				form.submit();
			}
			
			
		})
		
	});
	
	
	
</script>

	<div class="main_wrap">
		<form action="${url}/login/register" method="post" id="rform">
			<section class="register_wrap"> 
				<div class="register_inner">
					<label for="user_id" class="hid">아이디</label>
					<input type="text" name="user_id" id="user_id" placeholder="아이디" maxlength="20" oninput="this.value = this.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '')">
					<p class="id_check hid" ></p>
					
					<label for="user_pw" class="hid">비밀번호</label>
					<input type="password" name="user_pw" id="user_pw" placeholder="비밀번호" onkeyup="pw_chk();" maxlength="20">
					
					<label for="user_pw_chk" class="hid">비밀번호확인</label>
					<input type="password" name="user_pw_chk" id="user_pw_chk" placeholder="비밀번호확인" onkeyup="pw_chk();" maxlength="20">
					<p class="pw_check hid" ></p> 
					
					<label for="user_nickname" class="hid">닉네임</label>
					<input type="text" name="user_nickname" id="user_nickname" placeholder="닉네임" onkeyup="nickname_chk();" maxlength="10">
					<p class="nickname_check hid"></p>
					<label for="user_email" class="hid">이메일</label>
					<input type="text" name="user_email" id="user_email" placeholder="이메일"> @ 
					<input type="text" name="email_addr" id="email_addr">
					<select id="addr">
						<option value="">직접입력</option>
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
						<input type="button" value="인증" class="authbtn" onclick="pauth_check();" placeholder="인증번호" maxlength="6">	
					</div>
					 <div class="rbtn">
					 	<input type="button" value="회원가입" class="registerbtn">
					 </div>
				</div>
			</section>
		</form>
	</div>
</body>
</html>