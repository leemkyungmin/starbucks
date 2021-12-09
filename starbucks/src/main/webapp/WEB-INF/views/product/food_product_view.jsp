<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<link rel="stylesheet" href="${url}/resources/assets/style/coffee_product_view.css">
<script>
	$().ready(function(){
		$('.zoomImg').elevateZoom({
			zoomWindowWidth :710,
			zoomWindowHeight :468,
			zoomWindowFadeIn: 100,
			zoomWindowFadeOut: 100,
			lensFadeIn: 100,
			lensFadeOut: 100
		});
		
		$('.myDrink a').on('click',function(){
			var name ='${fdto.getFName()}';
			var type='FOOD';
			var price ='${fdto.getFPrice()}';
			var idx ='${fdto.getFIdx()}';
			
			insert_myMenu(name,type,price,idx,'menu/drink_list');
			
		});
		
	});
</script>
<div class="wrap">
	<div class="coffee_content">
		<div class="sub_title_wrap">
			<div class="sub_title_inner">
				<h2>${title}</h2>
			</div>
		</div>

		<div class="coffee_product_inner">
			<section class="coffee_info">
				<div class="coffee_info_content">
					<div class="product_wrap01">
						<div class="product_picture">
							<div class="product_main_img">
								<p>
									<a href="javascript:void(0);"> 
										<img class="zoomImg" alt="${fdto.getFName()}" src="${url}/resources/assets/images/food_img_test/${fdto.getFLargeimg()}"
										data-zoom-image="${url}/resources/assets/images/food_img_test/${fdto.getFLargeimg()}">
									</a>
								</p>
								<p class="more_btn">
									<a href="javascript:void(0);">
										<img src="${url}/resources/assets/images/commom/more.png" alt="">
									</a>
								</p>	
							</div>

						</div>
						<div class="product_Detail">
							<div class="product_Detail_inner">
								<header>
									<h4>${fdto.getFName()}</h4>
								</header>
								<div class="myDrink">
									<a href="javascript:void(0)">나만의 상품으로 등록</a>
								</div>
								<p class="tt01">${fdto.getFInfo()}</p>
								<div class="product_nutrition_info">
									<div class="product_info_title">
										<p class="title">제품 영양 정보</p>
										<div class="proudct_size">${fdto.getFSize()}(g)</div>
									</div>
									<div class="nutrition_content">
										<ul>
											<li class="kcal">
												<dl> 
											 		<dt>1회 제공량 (kcal)</dt>
													<dd>${fdto.getFKcal() }</dd>
												</dl>
											</li>
											<li class="saturate">
												<dl>
													<dt>포화지방 (g)</dt>
													<dd>${fdto.getFSaturate() }</dd>
												</dl>
											</li>
											<li class="protein">
												<dl>
													<dt>단백질 (g)</dt>
													<dd>${fdto.getFProtein() }</dd>
												</dl>
											</li>
										</ul>
										
										<ul>
											<li class="salt">
												<dl>
													<dt>나트륨 (mg)</dt>
													<dd>${fdto.getFSalt() }</dd>
												</dl>
											</li>
											<li class="sugar">
												<dl>
													<dt>당류 (g)</dt>
													<dd>${fdto.getFSugar() }</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt></dt>
													<dd></dd>
												</dl>
											</li>
										</ul>
									</div>
								</div>
								<c:if test="${fdto.getFNotice() ne null }">
									<div class="allergy_notice">
										<div class="allergy_inner">
											<p>알레르기 유발요인:${fdto.getFNotice() }</p>
										</div>
									</div>
								
								</c:if>
									
								 
								 
							</div>
						</div>
					</div>
					
				</div>
			</section>
		</div>
		
	</div>
</div>



<%@ include file="../Template/fotter.jsp"%>

