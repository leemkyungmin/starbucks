<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/my_card.css">
<link
	href="${url}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="${url}/resources/bootstrap/css/sb-admin-2.min.css"
	rel="stylesheet">
<script>
	$().ready(function(){
		
		$('.bxslider').bxSlider({
			auto : false,
			autoControls : true,
			pager : false,
			slideWidth : 899,
			slideWidth :899,
			touchEnabled : (navigator.maxTouchPoints > 0)
		});
		
		$(document).on('click','#money_charge',function(){
			var uclidx = $(this).parent().parent().parent().data('target');
			$('#uclidx').val(uclidx);
			$('#MyModal').modal('show');
		});
		
		$(document).on('click','#card_historybn',function(){
			var uclidx = $(this).parent().parent().parent().data('target');
			card_history_ajax(uclidx,1);
			$('#card_history').modal('show');
		});
		$(document).on('click','#card_history table tfoot li a',function(){
			
			if(!$(this).parent().hasClass('active')){
				var page = $(this).text();
				var uclidx =$(this).parent().data('uclidx');
				card_history_ajax(uclidx,page)
			} 
			
		});
		
		$(document).on('click','#card_delete',function(){
			var cardName = $(this).parent().parent().find('dl').find('dd:eq(0)'); 
			var uclidx =$(this).parent().parent().parent().data('target');
			$('#pw_uclidx').val(uclidx);
			$('#del_card .password_check h4').text(cardName.text());
			$('#del_card').modal('show');
		});
		
		
		function card_history_ajax(uclidx,page){
			var obj = new Object();
			obj.uclidx=uclidx;
			obj.page =page;
			var data = JSON.stringify(obj);
			$.ajax({
				url:'${url}/my/card/card_history',
				data:{
                    data:data
            	},
            	method:'post',
				success:function(e){
					console.log(e);
					$('#card_history .modal-body tbody').remove();
					$('#card_history .modal-body tfoot').remove();
					$('#card_history .modal-body table').append(e);
				},error:function(request, status, error){
					console.log('ajax통신 실패');
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
		}
	});
</script>

<div class="wrap">
	<header class="header_title_wrap">
		<div class="header_title_content">
			<div class="header_title_inner">
				<h4>My 카드</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="my_card_wrap">
			<section class="my_card_inner">
				<div class="title">
					<strong>${udto.getUNickName() }님의 스타벅스 카드</strong>
					<p>총 보유카드 :${fn:length(ucllist) }장</p>
				</div>
				<div class="card_list_wrap">
					<c:if test="${ucllist ne null }">
						<div class="my_card_info">
							<ul class="bxslider">
								<c:forEach var="ucllist" items="${ucllist }">
									<li data-target="${ucllist.getUclIdx() }">
										<div class="user_card_list">
											<a href="javascript:void(0)"> <img
												src="${url}/resources/assets/images/card_img_test/${ucllist.getClImg()}">
											</a>
										</div>
										<div class="user_card_info">
											<dl>
												<dt>카드 이름</dt>
												<dd>${ucllist.getUclName() }</dd>
												<dt>카드 잔액</dt>
												<dd>
													<fmt:formatNumber value="${ucllist.getUclMoney() }"
														pattern="#,###" />
													원
												</dd>
											</dl>
											<div class="user_card_btn">
												<a href="javascript:void(0)" id="money_charge">카드 충전</a> <a
													href="javascript:void(0)" id="card_historybn">카드 내역</a> <a
													href="javascript:void(0)" id="card_delete">카드 삭제</a>
											</div>

										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${ucllist eq null }">
						<div class="my_card_insert">
							<strong>등록된 카드가 없습니다.</strong>
							<p>
								스타벅스만의 특별한 혜택을 이용하시기 위해서는 카드가 필요합니다.<br> 스타벅스 카드를 등록하시고 생일
								무료음료 쿠폰과 다양한 스타벅스의 리워드를 이용하세요.
							</p>
							<span><a href="${url}/my/card/new_card">카드 등록하기</a></span>
						</div>
					</c:if>
				</div>
			</section>
		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>
<div class="modal" id="MyModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">카드 충전하기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="uclidx"> <select id="charge_money">
					<option value="10000" selected="selected">10,000</option>
					<option value="50000">50,000</option>
					<option value="100000">100,000</option>
					<option value="other">직접입력</option>
				</select> <input type="text" name="money" id="money" value="10000"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">원
				<a href="javascript:void(0)" id="chargebtn">충전하기</a>
			</div>

		</div>
	</div>
</div>

<div class="modal" id="card_history" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">카드 내역</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="history_record">
					<colgroup>
						<col width="15%">
						<col width="15.5454%">
						<col width="15.90909%">
					</colgroup>
					<thead>
						<tr>
							<th>날짜</th>
							<th>충전/사용</th>
							<th>금액</th>
						</tr>
					</thead>

				</table>
			</div>

		</div>
	</div>
</div>
<div class="modal" id="del_card" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">카드 삭제</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="password_check">
					<input type="hidden" id="pw_uclidx"> 
					<h4></h4>
					<label for="card_pinNum">핀번호</label> <input type="password"
						id="card_pinNum" placeholder="등록하신 핀번호(8자리)" maxlength="8"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					<a href="javascript:void(0)" id="delete_cardBtn">카드삭제</a>
				</div>
			</div>

		</div>
	</div>
</div>


<script>
	$().ready(function(){
		$('#charge_money').change(function(){
			if($(this).val() == 'other'){
				$('#money').removeAttr("readonly");
				$('#money').val('');
			} else {
				$('#money').attr("readonly",true); 
				$('#money').val($(this).val());
			}
		});
		
		$('#chargebtn').on('click',function(){
			var uclidx=$('#uclidx').val();
			var currentTimeMillis = new Date().getTime()+'${udto.getUNickName()}';
			var tossPayments = TossPayments('test_ck_Z0RnYX2w5322PNvKnZP3NeyqApQE');
			 tossPayments.requestPayment('카드', {
		          amount: $('#money').val(),
		          orderId: currentTimeMillis,
		          orderName: '스타벅스 카드 충전',
		          customerName: '${udto.getUNickName()}',
		          successUrl: 'http://localhost:9090/${url}/my/card/paysuccess?uclidx='+uclidx+'&uidx='+${udto.getUIdx()},
		          failUrl: 'http://localhost:9090/${url}/my/card/my_card_list'
		        })
		});
		
		$(document).on('click','#delete_cardBtn',function(){
			
			if($('#card_pinNum').val().length ==8){
				
				
				var obj = new Object();
				obj.uclidx=$('#pw_uclidx').val();
				obj.pinNum =$('#card_pinNum').val();
					
				var data = JSON.stringify(obj);
					
				$.ajax({
					url:'${url}/my/card/drop_card',
					data:{
						data:data
					},
					method:"post",
					success:function(e){
						alert(e);
						location.reload();
					},error:function(){
						console.log('ajax통신실패');
					}
				});
				
			} else {
				alert('등록하신 핀번호(8자리) 입력해주세요');
			}
			
		});
	
		
		
	});
</script>

<script
	src="${url}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script
	src="${url}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${url}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>
