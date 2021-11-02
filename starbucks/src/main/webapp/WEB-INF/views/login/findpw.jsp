<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>
<link rel="stylesheet" href="${url}/resources/assets/style/findid.css">
	
	<script>
		$().ready(function(){
			$('#find_idbtn').on('click',function(){
				var uphone =$('#user_phone');
				var uid =$('#user_id');
				var list =[{'uPhone' : uphone.val(),'uIds' :uid.val()}];
				console.log(list);
				if( uphone.val() != '' && uphone.val().length==11 && uid.val() !='' ){
					
					$.ajax({
						url:'${url}/login/find_pw',
						data: {'list' :JSON.stringify(list)},
						datatype :'json',
						type:'post',
						success:function(data){
							console.log(data);
							if(data ==true){
								alert('등록하신 휴대폰번호로 비밀번호 보냈습니다.');
								//location.href = document.referrer;
							} else {
								alert('등록하신 휴대폰번호로 가입된 정보가없습니다.');
							}
							
 						},error:function(){1
							console.log('error');
						}
					});
					
				} else {
					alert('아이디,휴대폰 번호를 확인해주세요');
					uphone.focus();
				}
			}); 
		});
	</script>

	<div class="wrap">
		<div class="find_id_wrap">
			
			<strong class="find_title">아이디찾기</strong>
			
				<section class="find_id_inner">
					<section class="find_id_img">
						<div class="find_img"></div>
						<p>
							<strong>아이디가 기억나지 않으세요? </strong>
							<span class="find_id_content">등록하신 휴대폰 번호로 아이디를 확인할수있습니다.</span>
						</p>
							
					</section>
					<section class="find_id_form">
						<label for="user_id" class="hid">아이디</label>
						<input type="text" name="user_id" id="user_id" maxlength="20" placeholder="아이디 ">
						<label for="user_phone" class="hid">전화번호</label>
						<input type="text" name="user_phone" id="user_phone" maxlength="11" placeholder="( - )을 제외한 휴대폰번호 ">
						<input type="button" id="find_idbtn" value="비밀번호 찾기">
					</section>
				</section>
			
		</div>
	</div>
 
<%@ include file="../Template/fotter.jsp" %>