<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/mymenu.css">
<link href="${url}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="${url}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery.templates/beta1/jquery.tmpl.min.js"></script>
<script>
	$()
			.ready(
					function() {
						var orderList = new Array();
						var tot = new Object();
						var slider = $('.bxslider').bxSlider({
							auto : false,
							autoControls : true,
							pager : false,
							slideWidth : 499,
							slideWidth : 499,
							touchEnabled : (navigator.maxTouchPoints > 0),
						});

						var order = new Object();
						var orderList = new Array();

						$('.chkAll')
								.change(
										function() {
											if ($(this).parent().hasClass(
													'ez-checked')) {
												$(this).parent().removeClass(
														'ez-checked');
												$(this).parents('table').find(
														'.ez-checkbox')
														.removeClass(
																'ez-checked');
												$(this)
														.parents('table')
														.find(
																'input:checkbox[name="drinkShop_view_ck2"]')
														.prop('checked', false);

											} else {
												$(this).parent().addClass(
														'ez-checked');
												$(this).parents('table').find(
														'.ez-checkbox')
														.addClass('ez-checked');
												$(this)
														.parents('table')
														.find(
																'input:checkbox[name="drinkShop_view_ck2"]')
														.prop('checked', true);
											}
										});

						$(document)
								.on(
										'click',
										'input:checkbox[name="drinkShop_view_ck2"]',
										function() {
											if (!$(this).is(':checked')) {
												$(this).parent().removeClass(
														'ez-checked');
											} else {
												$(this).parent().addClass(
														'ez-checked');
											}

											var checkboxLen = $(this)
													.parents('table')
													.find('tbody')
													.find(
															'input:checkbox[name="drinkShop_view_ck2"]').length; // ?????? ??????????????? ??????
											var checkboxCheckedLen = $(this)
													.parents('table')
													.find('tbody')
													.find(
															'input:checkbox[name="drinkShop_view_ck2"]:checked').length; // ?????? ???????????? ??? ????????? ??????????????? ??????

											if (checkboxLen == checkboxCheckedLen) {
												$(this).parents('table').find(
														'thead').find('div')
														.addClass('ez-checked');
												$(this)
														.parents('table')
														.find('thead')
														.find(
																'input:checkbox[name="drinkShop_view_ck_all"]')
														.prop("checked", true);
											} else {
												$(this).parents('table').find(
														'thead').find('div')
														.removeClass(
																'ez-checked');
												$(this)
														.parents('table')
														.find('thead')
														.find(
																'input:checkbox[name="drinkShop_view_ck_all"]')
														.prop("checked", false);
											}

										});

						$(document)
								.on(
										'click',
										'.myMenu_wrap dl dt h4 a',
										function() {
											var type = $(this).data('target');

											$('.myMenu_wrap dl dt')
													.removeClass('on');
											$(this).parent().parent().addClass(
													'on');

											$('.myMenu_wrap dl article').css({
												'display' : 'none'
											});
											$(this).parent().parent().next()
													.children().css({
														'display' : 'block'
													});
											$
													.ajax({
														url : '${url}/my/menu/myMenu_ajax',
														data : 'type=' + type,
														method : 'post',
														success : function(e) {
															console
																	.log(e.length);
															var html = '';
															if (e.length == 0) {
																html += '<tr class="odd">';
																html += '<td colspan="6">';
																if (type == 'FOOD') {
																	html += 'My ????????? ?????? ????????? ????????????.';
																} else if (type == 'DRINK') {
																	html += 'My ????????? ?????? ????????? ????????????.';
																} else {
																	html += 'My ????????? ?????? ????????? ????????????.';
																}
																html += '</td>';
																html += '</tr>';
															} else {
																for (var i = 0; i < e.length; i++) {

																	if (i % 2 == 0) {
																		html += '<tr class="odd" data-mcidx="'+e[i].mcIdx+'">';
																	} else {
																		html += '<tr class="even" data-mcidx="'+e[i].mcIdx+'">';
																	}
																	html += '<td>';
																	html += '<div class="ez-checkbox">';
																	html += '<input type="checkbox" name="drinkShop_view_ck2" title="??????" value="'+e[i].mcIdx+'" class="ez-hide">';
																	html += '</div>';
																	html += '</td>';
																	html += '<td>';
																	html += e[i].mcIdx;
																	html += '</td>';
																	html += '<td>';
																	html += e[i].mcName;
																	html += '</td>';
																	html += '<td>';
																	html += e[i].mcPrice
																			.toString()
																			.replace(
																					/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g,
																					",");
																	html += '</td>';
																	html += '<td>';
																	html += '<input type="text" name="mcprice" value="'
																			+ e[i].mcCount
																			+ '" oninput="this.value = this.value.replace(/[^0-9.]/g, "").replace(/(\..*)\./g, "$1");">';
																	html += '</td>';
																	html += '<td>';
																	html += e[i].mcDate;
																	html += '</td>';
																	html += '</tr>';
																}
															}

															if (type == 'FOOD') {
																$(
																		'.food_cart tbody')
																		.text(
																				'');
																$(
																		'.food_cart tbody')
																		.append(
																				html);
															} else if (type == 'DRINK') {
																$(
																		'.drink_cart tbody')
																		.text(
																				'');
																$(
																		'.drink_cart tbody')
																		.append(
																				html);
															} else {
																$(
																		'.product_cart tbody')
																		.text(
																				'');
																$(
																		'.product_cart tbody')
																		.append(
																				html);
															}

														},
														error : function() {
															console
																	.log('ajax?????? ??????');
														}
													});

										});

						$(document)
								.on(
										'click',
										'#buy_myMenu',
										function() {

											var checkboxCheckedLen = $(this)
													.parents('article')
													.find('table')
													.find(
															'input:checkbox[name="drinkShop_view_ck2"]:checked').length;

											

											if (checkboxCheckedLen == 0) {
												alert('????????? ????????? ????????????.');
											} else {
												var total = 0;
												orderList=[];
												
												for (var i = 0; i < checkboxCheckedLen; i++) {
													var tr = $(this).parents(
															'article').find(
															'table').find(
															'input:checkbox[name="drinkShop_view_ck2"]:checked:eq('
																	+ i + ')')
															.parents('tr');
													var mcidx = tr.find(
															'td:eq(1)').text();
													var mcname = tr.find(
															'td:eq(2)').text();
													var mcprice = tr.find(
															'td:eq(3)').text();
													var mccount = tr.find(
															'td:eq(4)').find(
															'input').val();
													var mctotal = (mcprice
															.replace(",", ""))
															* (mccount * 1);

													var order = new Object();

													order.mcidx = mcidx;
													order.mcname = mcname;
													order.mcprice = mcprice;
													order.mccount = mccount;
													order.mctotal = mctotal
															.toString()
															.replace(
																	/\B(?=(\d{3})+(?!\d))/g,
																	",");
													orderList.push(order);
													total += mctotal;
												}

												tot.total = total
														.toString()
														.replace(
																/\B(?=(\d{3})+(?!\d))/g,
																",");
												
												$('#MyModal table tbody').text(
														'');
												$('#MyModal table tfoot').text(
														'');
												$("#order-list")
														.tmpl(orderList)
														.appendTo("#orderlist");
												$("#totalprice").tmpl(tot)
														.appendTo("#total");
												
												$('#MyModal').modal('show');
												
												$('#branch_idx').val('');
												console.log(JSON
														.stringify(orderList));

												

											}

										});
						$(document).on('click','#searchBtn', function() {
							
							var search_item =$('#branch_info').val();
							
							if(search_item.length ==0 || branch_info==''){
								alert('?????? ??? ???????????? ??????????????????');
								$('#branch_info').focus();
							} else {
								$.ajax({
									url:'${url}/my/menu/branch_list',
									data:'item='+search_item,
									method:'post',
									success:function(e){
										$('#branch_list').text('');
										$("#branch").tmpl(e).appendTo("#branch_list");
										
									},error:function(){
										console.log('ajax?????? ??????');
									}
								});
							}
							
							
						});
						
						$(document).on('click','#branch_list li',function(){
							
							var bname =$(this).find('dt').text();
							if(confirm('???????????? ??????:'+bname+'?????????.')){
								$('#branch_idx').val($(this).data('bidx'));
								
								$('.search_wrap').animate({
									opacity :'0',
									left : '14'
								},500);
								slider.destroySlider();
								slider.reloadSlider({
									slideWidth : 499,
									mode : 'horizontal',// ?????? ?????? ?????? ????????????
									speed : 1000, // ?????? ????????? ??????
									pager : false, // ?????? ?????? ????????? ?????? ?????? ??????
									slideMargin : 10, // ?????????????????? ??????
									auto : false, // ?????? ?????? ??????
									controls : true, // ?????? ?????? ?????? ?????? ??????
									touchEnabled : (navigator.maxTouchPoints > 0),

								});
								$('.search_wrap').css({'display':'none'});
								$('.card_wrap').animate({ 
									opacity :'1',
									right : '14',
								},500);
								
								
							}
							
						});
				
						$(document).on('click','#buyproductBtn',function(){
							var pinNum = $(this).parent().find('#cardpinNum').val();
							
							if(pinNum.length <8 || pinNum==''){
								alert('?????? ???????????? ????????????.');
								$(this).parent().find('#cardpinNum').focus();
							} else {
								var uclidx=$(this).data('uclidx')+"";
								
								var obj = new Object();
								obj.uclidx=uclidx;
								obj.bidx =$('#branch_idx').val();
								obj.tot =tot;
								obj.pinNum =pinNum;
								obj.status ='???????????????',
								obj.orderlist =orderList;  
								
								var data = JSON.stringify(obj);
	
								$.ajax({
									url:'${url}/menu/buyproduct',
									data:{
										data:data
									},
									method:'post',
									success:function(e){
										
										if( e=="?????????" ){
											alert('???????????? ???????????????.');
											location.href="${url}/login/loginPage?redirect_url=${url}/my/menu/mymenu";
										} else if( e=='????????????' ) {
											
											alert('?????? ?????? ??????');
											location.href="${url}/my/card/my_card_list";
										} else if('?????????'){
											alert('???????????? ?????? ???????????? ????????????.');
										} else {
											alert('????????????');
											location.href="${url}/my/order/orderList";
											
										}
										//?????? ?????? ?????? ?????? 
										
									},error:function(){
										console.log('ajax?????? ??????');
									}
								});
							}
							
						});
			
					});
</script>

<script id="branch" type="text/x-jquery-tmpl"> 
	<li data-bidx={{= bidx}}>
		<dl>
			<dt>{{= bname}}</dt>
			<dd>{{= blocation}}</dd>
		</dl>
	</li>
</script>


<script id="order-list" type="text/x-jquery-tmpl"> 
	<tr>
		<td>{{= mcidx}}</td>
		<td>{{= mcname}}</td>
		<td>{{= mcprice}}???</td>
		<td>{{= mccount}}</td>
		<td>{{= mctotal}}???</td>
	</tr>
</script>
<script id="totalprice" type="text/x-jquery-tmpl"> 
	<tr>
		<td colspan="1">??????</td>
		<td colspan="4">{{= total}}???</td>
	</tr>
</script>



<div class="wrap">
	<header class="header_title_wrap">
		<div class="header_title_content">
			<div class="header_title_inner">
				<h4>My ??????</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="myMenu_wrap">
			<dl>
				<!-- ?????? -->
				<dt class="tab drink_tab on">
					<h4>
						<a href="javascript:void(0)" data-target="DRINK">????????? ??????</a>
					</h4>
				</dt>
				<dd>
					<article class="tab drink_wrap" style="display: block">
						<fieldset>
							<table class="drink_cart">
								<colgroup>
									<col width="52">
									<col width="60">
									<col width="300">
									<col width="100">
									<col width="177">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><div class="ez-checkbox">
												<input type="checkbox" name="drinkShop_view_ck_all" class="chkAll ez-hide" title="?????? ??????">
											</div></th>
										<th class="en" scope="col">??????</th>
										<th scope="col">?????????</th>
										<th scope="col">??????</th>
										<th scope="col">??????</th>
										<th scope="col">?????????</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(mclist) eq 0 }">
										<tr class="odd">
											<td colspan="6">My ????????? ?????? ????????? ????????????.</td>
										</tr>
									</c:if>
									<c:forEach var="mclist" items="${mclist}" varStatus="mcCount">
										<fmt:parseDate value="${mclist.getMcDate()}" var="date" pattern="yyyy-MM-dd" />
										<c:if test="${mcCount.count%2 eq 1}">
											<tr class="odd" data-mcidx="${mclist.getMcIdx() }">
										</c:if>
										<c:if test="${mcCount.count%2 eq 0}">
											<tr class="even" data-mcidx="${mclist.getMcIdx() }">
										</c:if>
										<td>
											<div class="ez-checkbox">
												<input type="checkbox" name="drinkShop_view_ck2" title="??????" value="${mclist.getMcIdx() }" class="ez-hide">
											</div>
										</td>
										<td>${mclist.getMcIdx() }</td>
										<td>${mclist.getMcName() }</td>
										<td><fmt:formatNumber value="${mclist.getMcPrice() }" pattern="#,###" /></td>
										<td><input type="text" name="mcprice" value="${mclist.getMcCount() }" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
										<td><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="myMenu_btns">
								<ul>
									<li><a href="javascript:void(0)">????????????</a></li>
									<li><a href="javascript:void(0)">?????? ??????</a></li>
									<li><a href="javascript:void(0)" id="buy_myMenu">????????????</a></li>
								</ul>
							</div>
						</fieldset>
					</article>
				</dd>

				<!-- ?????? -->
				<dt class="tab food_tab">
					<h4>
						<a href="javascript:void(0)" data-target="FOOD">????????? ??????</a>
					</h4>
				</dt>
				<dd>
					<article class="food_wrap">
						<fieldset>
							<table class="food_cart">
								<colgroup>
									<col width="52">
									<col width="60">
									<col width="300">
									<col width="100">
									<col width="177">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><div class="ez-checkbox ">
												<input type="checkbox" name="drinkShop_view_ck_all" class="chkAll ez-hide" title="?????? ??????">
											</div></th>
										<th class="en" scope="col">??????</th>
										<th scope="col">?????????</th>
										<th scope="col">??????</th>
										<th scope="col">??????</th>
										<th scope="col">?????????</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
							<div class="myMenu_btns">
								<ul>
									<li><a href="javascript:void(0)">????????????</a></li>
									<li><a href="javascript:void(0)">?????? ??????</a></li>
									<li><a href="javascript:void(0)" id="buy_myMenu">????????????</a></li>
								</ul>
							</div>
						</fieldset>
					</article>
				</dd>

				<!-- ?????? -->

				<dt class="tab product_tab">
					<h4>
						<a href="javascript:void(0)" data-target="PRODUCT">????????? ??????</a>
					</h4>
				</dt>
				<dd>
					<article class="product_wrap">
						<fieldset>
							<table class="product_cart">
								<colgroup>
									<col width="52">
									<col width="60">
									<col width="300">
									<col width="100">
									<col width="177">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><div class="ez-checkbox">
												<input type="checkbox" name="drinkShop_view_ck_all" class="chkAll ez-hide" title="?????? ??????">
											</div></th>
										<th class="en" scope="col">??????</th>
										<th scope="col">?????????</th>
										<th scope="col">??????</th>
										<th scope="col">??????</th>
										<th scope="col">?????????</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
							<div class="myMenu_btns">
								<ul>
									<li><a href="javascript:void(0)">????????????</a></li>
									<li><a href="javascript:void(0)">?????? ??????</a></li>
									<li><a href="javascript:void(0)" id="buy_myMenu">????????????</a></li>
								</ul>
							</div>

						</fieldset>
					</article>
				</dd>

			</dl>



		</div>
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>

<div class="modal" id="MyModal" tabindex="-1" data-backdrop="static" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">???????????????</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="order_wrap">
					<table>
						<colgroup>
							<col width="50">
							<col width="200">
							<col width="100">
							<col width="50">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<td>??????</td>
								<td>?????????</td>
								<td>??????</td>
								<td>??????</td>
								<td>??????</td>
							</tr>
						</thead>
						<tbody id="orderlist">

						</tbody>
						<tfoot id="total">
						</tfoot>
					</table>
				</div>

				<div class="select_branch_wrap">
					<div class="search_wrap">
						<h4>????????????</h4>
						<input type="hidden" id="branch_idx">
						<div class="search_box_wrap">
							<input type="text" id="branch_info" placeholder="????????? ?????? ?????? ?????????"> <a href="javascript:void(0)" id="searchBtn">??????</a>
						</div>
						<div class="branch_list_wrap">
							<ul id="branch_list">

							</ul>
						</div>
					</div>


				</div>


				<!-- ?????? wrap -->
				<div class="card_wrap">
					<div class="card_wrap_title">
						<h4>????????? ?????? ??????</h4>
					</div>
					<div class="card_info">
						<c:if test="${fn:length(ucllist) eq 0 }">
							<p>????????? ????????? ????????????.</p>
							<a href="javascript:void(0)">????????? ?????? ??????????????????</a>
						</c:if>
						
						<ul class="bxslider">
							<c:forEach var="ucllist" items="${ucllist }">
								<li>
									<dl>
										<dt>
											<img src="${url}/resources/assets/images/card_img_test/${ucllist.getClImg()}">
										</dt>
										<dd>
											<div class="card_info_inner">
												<dl>
													<dt>????????????</dt>
													<dd>${ucllist.getUclName() }</dd>
													<dt>?????? ??????</dt>
													<dd>
														<fmt:formatNumber value="${ucllist.getUclMoney() }" pattern="#,###" />
														???
													</dd>
												</dl>
											</div>
											<div class="card_pin_form">
												<input type="password" name="cardpinNum" id="cardpinNum" placeholder="?????? ?????????(8??????)" maxlength="8"> <a href="javascript:void(0)" id="buyproductBtn" data-uclidx="${ucllist.getUclIdx() }">????????????</a>
											</div>
										</dd>
									</dl>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>



			</div>

		</div>
	</div>
</div>
<script src="${url}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${url}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${url}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>