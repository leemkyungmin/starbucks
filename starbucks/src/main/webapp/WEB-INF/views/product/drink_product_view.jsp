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
										<img class="zoomImg" alt="${drink.getDName()}" src="${url}/resources/assets/images/drink_img_test/${drink.getDLargeimg()}"
										data-zoom-image="${url}/resources/assets/images/drink_img_test/${drink.getDLargeimg()}">
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
									<h4>${drink.getDName()}</h4>
								</header>
								<div class="myDrink">
									<a href="javascript:void(0)">나만의 상품으로 등록</a>
								</div>
								<p class="tt01">${drink.getDInfo()}</p>
								<div class="product_nutrition_info">
									<div class="product_info_title">
										<p class="title">제품 영양 정보</p>
										<div class="proudct_size">${drink.getDSize()}</div>
									</div>
									<div class="nutrition_content">
										<ul>
											<li class="kcal">
												<dl> 
											 		<dt>1회 제공량 (kcal)</dt>
													<dd>${drink.getDKcal() }</dd>
												</dl>
											</li>
											<li class="saturate">
												<dl>
													<dt>포화지방 (g)</dt>
													<dd>${drink.getDSaturate() }</dd>
												</dl>
											</li>
											<li class="protein">
												<dl>
													<dt>단백질 (g)</dt>
													<dd>${drink.getDProtein() }</dd>
												</dl>
											</li>
										</ul>
										
										<ul>
											<li class="salt">
												<dl>
													<dt>나트륨 (mg)</dt>
													<dd>${drink.getDSalt() }</dd>
												</dl>
											</li>
											<li class="sugar">
												<dl>
													<dt>당류 (g)</dt>
													<dd>${drink.getDSugar() }</dd>
												</dl>
											</li>
											<li class="caffeine">
												<dl>
													<dt>카페인 (mg)</dt>
													<dd>${drink.getDCaffeine() }</dd>
												</dl>
											</li>
										</ul>
									</div>
								</div>
								
								<!-- <p class="coffee_type_icon">
									<img alt="${ckt.getCktName()}"
										src="${url}/resources/assets/images/coffee/${ckt.getCktImg()}">
									<strong>${ckt.getCktName()}</strong> 
									<span class="info">${ckt.getCktInfo() }</span>
								</p>
								 -->
								 
								 
								 
							</div>
						</div>
					</div>
					
				</div>
			</section>
		</div>
		
	</div>
</div>



<%@ include file="../Template/fotter.jsp"%>

