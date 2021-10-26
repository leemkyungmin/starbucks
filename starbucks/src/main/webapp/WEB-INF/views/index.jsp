<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="Template/header.jsp" %>
<link rel="stylesheet" href="${url}/resources/assets/style/index.css">
		
	<!-- index 페이지  -->
	
	<script>
		$().ready(function(){
			var timer = 500;
			$('.main_slogan').animate( {
				opacity :'1'
			},timer , function(){
				$('.product_set.set01').animate( {
					opacity :'1'
				},timer,function(){
					$('.product_set.set02').animate( {
						opacity :'1'	
				},timer,function(){
					$('.product_set.set03').animate( {
						opacity :'1'
				},timer);
				});
			});
			});
			
			$(window).on('scroll',function(){
				
				var offsetY = window.pageYOffset;
				
				//배너 이미지 애니메이션
				if(offsetY >111){
					if($('.banner_img').css('opacity') =='0'){
						$('.banner_img').animate({
							opacity :'1',
							left : '14'
						},1000);
						$('.banner_txt').animate({
							opacity :'1',
							right :'4'
						},1000);
					}
					if(offsetY >1019){
						var timer = 500;
						if( $('.fav_txt01').css('opacity') =='0' && $('.fav_txt02').css('opacity') =='0'){
							console.log('start');
							$('.fav_txt01').animate({
								opacity :'1',
								left : '200'
							},timer,function(){
								$('.fav_txt02').animate({
									opacity :'1',
									left : '92'
								},timer);
							});
						} 
					} else {
						if( $('.fav_txt02').css('opacity') =='1' && $('.fav_txt01').css('opacity') =='1'){
							console.log('end');
							$('.fav_txt02').animate({
								opacity :'0',
								left : '-200'
							},timer,function(){
								$('.fav_txt01').animate({
									opacity :'0',
									left : '-92'
								},timer);
							});
						}
					}
				} else {
					if($('.banner_img').css('opacity') =='1'){
						$('.banner_img').animate({
							opacity :'0',
							left : '-14'
						},1000);
						$('.banner_txt').animate({
							opacity :'0',
							right :'-4'
						},1000);
					}
				}
				
				//좋아하는 상품 애니메이션
			
				
			});
			
		});
		
	</script>
	
	<div class="wrap_content">
		<div class="main_wrap">
			<div class="main_inner">
				<div class="main_slogan">
					<img alt="main_slogan" src="${url}/resources/assets/images/index/main_slogan.png" class="pc_slogan">
					<img alt="main_slogan" src="${url}/resources/assets/images/index/m_main_slogan.png" class="m_slogan">
				</div>
				<div class="main_product">
					<div class="product_set set01">
						<img alt="frappuccino" src="${url}/resources/assets/images/index/frappuccino.png" class="pc_drink">
						<img alt="frappuccino" src="${url}/resources/assets/images/index/m_frappuccino.png" class="m_drink">
					</div>
					<div class="product_set set02">
						<img alt="latte" src="${url}/resources/assets/images/index/latte.png" class="pc_drink">
						<img alt="latte" src="${url}/resources/assets/images/index/m_latte.png" class="m_drink">
					</div>
					<div class="product_set set03">
						<img alt="blacktea" src="${url}/resources/assets/images/index/blacktea.png" class="pc_drink">
						<img alt="blacktea" src="${url}/resources/assets/images/index/m_blacktea.png" class="m_drink">
					</div>
					
				</div>
			</div>
		</div>
		<section class="main_banner_product">
			<div class="main_banner_inner">
				<div class="banner_img">
					<img alt="커피의 미래를 위한 스타벅스의 노력. 스타벅스 쓰리 리전 블렌드 250g" src="${url}/resources/assets/images/index/banner/bean2.png" class="pc_bean">
					<img alt="커피의 미래를 위한 스타벅스의 노력. 스타벅스 쓰리 리전 블렌드 250g" src="${url}/resources/assets/images/index/banner/m_bean2.png" class="m_bean">
				</div>
				<div class="banner_txt">
					<img alt="지속가능성을 위해 스타벅스와 함께 노력하는 세 지역에서 만들어진 원두를 만나보세요." src="${url}/resources/assets/images/index/banner/bean2_txt.png" class="pc_bean_txt">				
					<img alt="지속가능성을 위해 스타벅스와 함께 노력하는 세 지역에서 만들어진 원두를 만나보세요." src="${url}/resources/assets/images/index/banner/m_bean2_txt.png" class="m_bean_txt">					
				</div>
			</div>
		</section>
		<section class="new_product_wrap"> 
			<div class="new_product_inner">
				<div class="new_title">
					<img alt="신 상품 제목" src="${url}/resources/assets/images/index/new_product/new_been_title.png" class= "pc_new">
				</div>
				<div class="new_product">
					<img alt="신 상품" src="${url}/resources/assets/images/index/new_product/new_bean.jpg" class="pc_new">
					<img alt="신 상품" src="${url}/resources/assets/images/index/new_product/m_new_bean.jpg" class="m_new">
				</div>
			</div>
		</section>
		<section class="fav_wrap">
			<div class="fav_inner">
				<div class="fav_txt01">
					PICK YOUR FAVORITE
				</div>
				<div class="fav_txt02">
					다양한 메뉴를 스타벅스에서 즐겨보세요. 스타벅스만의 특별함을 경험할 수 있는 최상의 선택 음료, 스타벅스 커피와 완벽한 어울림을 자랑하는 푸드, 다양한 시도와 디자인으로 가치를 더하는 상품, 소중한 사람에게 마음을 전하는 가장 좋은 방법 스타벅스 카드
				</div>
				<div class="fav_img">　
				</div>
			</div>
		</section>
	</div>
	
	<!-- fotter 시작 지점 -->
<%@ include file="Template/fotter.jsp" %>
	
</body>
</html>