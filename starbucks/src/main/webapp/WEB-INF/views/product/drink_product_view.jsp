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

							<!--  비슷한 상품 보기 ?  -->


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
					<div class="product_view_wrap2">
						<div class="productInvestigate_left">
							<p class="text">특별히 선택한 고품질의 라틴 아메리카 원두 블렌드를 단시간 로스팅 하면 부드러운
								코코아의 섬세한 뉘앙스와 살짝 볶은 견과류 향이 살아납니다. 은은하고 달콤한 풍미가 살아있는 이 커피는 친구를
								초대한 자리에 어울리는 유쾌하고 품위 있는 분위기를 연출하는데 매우 잘 어울립니다. 차분하고 편안하게 즐길 수 있는
								이 커피는 마치 베란다에 놓인 의자에 앉아 커피를 마시는 듯한 느낌을 줍니다. 지역과 마을에서 볼 수 있는 테라스의
								이름을 딴 베란다 블렌드™는 맑은 날 좋은 친구와 마시기 가장 좋은 친근한 커피입니다.</p>
							<ul>
								<li class="lu_01">
									<p>
										<img
											src="//image.istarbucks.co.kr/common/img/coffee/productInvestigate_img01.jpg"
											alt="">
									</p>
									<dl>
										<dt>디자인 스토리</dt>
										<dd class="dg_story">커피가 생산되는 라틴 아메리카 농장에서 종종 만날 수 있는 벌새가
											새겨진 이 디자인은 맑은날 친구와 함께 마시기 좋은 베란다 커피의 친근하고 부드러운 매력을 표현합니다.</dd>
									</dl>
								</li>
								<li>
									<p>
										<img
											src="${url}/resources/assets/images/coffee/coffee_product_sub_info02.jpg"
											alt="">
									</p>
									<dl>
										<dt>커피 테이스팅 노트</dt>
										<dd class="coffee_note">"베란다 블렌드를 한모금 입에 머금은 순간. 따뜻하고
											부드러운 바람이 내 마음을 감싸안은 듯한 평온함을 느끼게 되고, 마지막에 나타나는 뒷맛의 달콤한 느낌은 마치,
											한동안 잊고 지냈던 그리운 친구와 함께 보냈던 소중하고 아름다운 순간들을 떠오르게 한다." by 8대 커피
											앰배서더 김양진(Buffett) 파트너</dd>
									</dl>
								</li>
							</ul>
						</div>
						<div class="productInvestigate_right">
							<dl>
								<dt>Tasting Notes</dt>
								<dd class="tasting_notes">은은하고 달콤한 부드러움</dd>
								<dt>Enjoy with</dt>
								<dd class="enjoy_with">좋은 친구와 함께 보내는 맑은 날, 한가한 시간</dd>
								<dt style="display: none;">Origin</dt>
								<dd class="last" style="display: none;">
									아프리카/아라비아
									<p>
										<img
											src="${url}/resources/assets/images/coffee/coffee_product_sub_info02.jpg"
											alt="아프리카/아라비아">
									</p>
								</dd>
							</dl>
						</div>
					</div>
				</div>
			</section>
		</div>

	</div>
</div>



<%@ include file="../Template/fotter.jsp"%>

