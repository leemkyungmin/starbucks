<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/new_card_view.css">
<link
	href="${url}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${url}/resources/bootstrap/css/sb-admin-2.min.css"
	rel="stylesheet">
<link href="${url}/resources/assets/style/myreward_history.css"
	rel="stylesheet">
<!-- Custom styles for this page -->
<link rel="stylesheet" href="${url}/resources/assets/style/new_card_view.css">

<script>
	$().ready(function(){
		randomNum();
		$(document).on('click','.new_card_btn a',function(){
			$('#MyModal').modal("show");
		});
		
		$(document).on('click','.creat_random_num',function(){
			randomNum();
		});
		
		$(document).on('click','#register',function(){
			
			var pin_num =$('#pin_num');
			
			if(pin_num.val().length !=8 ){
				alert('핀번호를 입력해주세요');
				pin_num.focus();
			} else {
				
				var clidx =${cdto.getClIdx()};
				var cardnum = $('#card_num1').val()+''+$('#card_num2').val()+''+$('#card_num3').val()+''+$('#card_num1').val();
				var percard = $('#per_card').is(':checked') ==true ? '1' : '0';
				var cardname = ( $('#card_name').val().length ==0 ? '${cdto.getClName()}' : $('#card_name').val()  ) ;
				
				var obj = new Object();
				
				obj.cardname=cardname;
				obj.cardnum=cardnum;
				obj.percard=percard;
				obj.clidx=clidx+'';
				obj.pin_num=pin_num.val();
				
				var data = JSON.stringify(obj);
				$.ajax({
					url : '${url}/my/card/insert_newcard',
					data : {
                        data : data
                	},
					method:'post',
					dataType : "json",
					success:function(data){
						
						if(data =='sign_in'){
							alert('로그인후 가능합니다.');
							location.href='/login/loginPage?redirect_url=my/card/new_card';
						} else if( data =='1'){
							alert('카드 등록성공');
							location.href="/my/card/my_card_list";
						} 
						
					},
					error:function(){
						console.log('ajax통신 실패');
					}
				});
				
			}
			
		});
		
	});
	
	function randomNum(){
		
		var str = '';
		
		for(var i=0; i<16; i++){
			str += Math.floor(Math.random() * 10);
		}
		var num1 =str.substring(0,4);
		var num2 =str.substring(4,8);
		var num3 =str.substring(8,12);
		var num4 =str.substring(12,16);
		
		$('#card_num1').val(num1);
		$('#card_num2').val(num2);
		$('#card_num3').val(num3);
		$('#card_num4').val(num4);
	}
	
</script>
<div class="wrap">
	<div class="title_wrap">
		<div class="title_inner">
			<h2>카드</h2>
		</div>
	</div>
	<div class="wrap_content">
		<div class="card_info_wrap">
			<div class="card_info_left">
				<div class="card_pic">
					<img src="${url}/resources/assets/images/card_img_test/${cdto.getClImg()}">
				</div>
			</div>
			<div class="card_info_right">
				<div class="card_name_wrap">
					<h3>${cdto.getClName() }</h3>
					<p>스타벅스 카드 출시 년도 : ${fn:substring(cdto.getClReg_date(),0,4) }년 ${fn:substring(cdto.getClReg_date(),5,7)}월 </p>
				</div>
				<div class="card_info_wrap_content">
					<div class="card_info_head">
						<p class="tt1">스타벅스 카드  안내 및 특징</p>
						<div class="new_card_btn">
							<a href="javascript:void(0)">스타벅스 카드 등록</a>
						</div>
						<div class="card_info_content">
							<c:set var="cinfo" value="${fn:split(cdto.getClInfo(),'/') }"></c:set> 
							<ul>
								<c:forEach var="info" items="${cinfo}">
									<li>
										${info }
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
			

		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>
<div class="modal" id="MyModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">카드 신청하기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<section class="create_newcard">
					<div class="newcard_title">
						<h3>${cdto.getClName() } 카드 등록하기</h3>
					</div>
					<div class="newcard_register">
						<dl>
							<dt>카드명</dt>
							<dd>
								<input type="text" name="card_name" id="card_name" placeholder="카드명 최대 20자(선택)">
								<span>
									 * 카드명은 미입력 시 자동으로 부여됩니다.
								</span>
							</dd>
						</dl>
						<dl>
							<dt>카드번호</dt>
							<dd>
								<input type="text" name="cardnum1" id="card_num1" readonly="readonly" maxlength="4">-
								<input type="text" name="cardnum2" id="card_num2" readonly="readonly" maxlength="4">-
								<input type="text" name="cardnum3" id="card_num3" readonly="readonly" maxlength="4">-
								<input type="text" name="cardnum4" id="card_num4" readonly="readonly" maxlength="4">
								
								<a href="javascript:void(0)" class="creat_random_num">랜덤번호</a>
							</dd>
						</dl>
						<dl>
							<dt>PIN 번호</dt>
							<dd>
								<input type="password" name="pin_num" id="pin_num" maxlength="8" placeholder="PIN 번호 8자리 입력(필수)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
								<input type="checkbox" name="per_card" id="per_card" >
								<label for="per_card">등록 후 대표카드 설정</label>
							</dd>
						</dl>
					</div>
					<div class="register_btn">
						<a href="javascript:void(0)" id="register">등록</a>
					</div>
				</section>
			</div>
			
		</div>
	</div>
</div>

<script src="${url}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script
	src="${url}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script
	src="${url}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${url}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script
	src="${url}/resources/bootstrap/vendor/datatables/jquery.dataTables.min.js"></script>
<script
	src="${url}/resources/bootstrap/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<!-- <script src="${url}/resources/bootstrap/js/demo/datatables-demo.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"
	integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>