<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Template/header.jsp"%>
<link rel="stylesheet"
	href="${url}/resources/assets/style/reward_info.css">
<script>
	$().ready(function(){
		$('.arrow a').on('click',function(){
						
			var parent_tag = $(this).parent().parent();
			
			if(parent_tag.hasClass('on')){
				parent_tag.removeClass('on');
				parent_tag.parent().find('.box').css({'display' :'block'});
			} else {
				parent_tag.addClass('on');
				parent_tag.parent().find('.box').css({'display' :'none'});
			}
		});
	});
</script>
<div class="wrap">
	<header class="header_title_wrap">
		<div class="heaer_title_content">
			<div class="header_title_inner">
				<h4>리워드 및 혜택</h4>
			</div>
		</div>
	</header>
	<div class="wrap_content">
		<div class="reward_info_content">
			<section class="rewardcard_info_wrap">
				<div class="rewardcard_info_inner">
					<dl class="info ms_info_box1 jms_info_box1">
						<dt class="tbox">
							<h5>
								스타벅스 리워드 <span class="en">(Starbucks Rewards)란?</span>
							</h5>
							<span class="arrow"><a href="javascript:void(0);">닫기</a></span>
						</dt>
						<dd class="box" style="display: block;">
							<p class="t1">스타벅스만의 특별한 혜택,스타벅스 리워드를 이용해보세요!</p>
							<p class="t2">
								스타벅스 리워드는 스타벅스를 사랑해주시는 고객님을 위해 별을 적립하여 혜택으로 돌려드리는 특별한 리워드
								프로그램입니다.<br>스타벅스를 즐기는 최고의 방법, 스타벅스 카드를 등록하고 스타벅스 리워드 혜택을
								누려보세요.
							</p>
						</dd>
					</dl>
				</div>
			</section>

			<section class="rewardcard_info2_wrap">
				<div class="rewardcard_info_inner">
					<dl class="info ms_info_box2 info_box2">
						<dt class="tbox">
							<h5>스타벅스 별이란?</h5>
							<span class="arrow"><a href="javascript:void(0);">닫기</a></span>
						</dt>
						<dd class="box" style="display: block;">
							<p class="t1">계정에 등록하신 스타벅스 카드로 결제를 하셨나요?</p>
							<p class="t2">
								등록된 카드로 결제 시마다 계정으로 별★을 적립해드립니다.<br>적립된 별★은 스타벅스 리워드 <span
									class="en">(Starbucks Rewards)</span> 프로그램을 통해 다양한 혜택으로
								돌려드립니다.
							</p>
							<ul class="utxt">
								<li>- 별 ★ 의 유효기간은 1년이며, 유효기간이 지나면 별★이 사라집니다.</li>
							</ul>
							<p class="t3">별★을 모아 등급별 특별한 혜택을 누리세요!</p>
							<ul class="r_star_bg_wrap">
								<li class="r_star_bg1"><strong class="r_star_num">0</strong>
									<dl>
										<dt class="en">Welcome Level</dt>
										<dd>스타벅스 카드를 최초 등록 시</dd>
									</dl></li>
								<li class="r_star_bg2"><strong class="r_star_num">5</strong>
									<dl>
										<dt>
											<span class="en c_007042">Green Level</span>
										</dt>
										<dd>별★을 5개 모았을 경우</dd>
									</dl></li>
								<li class="r_star_bg3"><strong class="r_star_num">30</strong>
									<dl>
										<dt>
											<span class="en c_88722e">Gold Level</span>
										</dt>
										<dd>별★을 30개 모았을 경우</dd>
									</dl></li>
							</ul>
							<ul class="utxt">
								<li>- 각 레벨 진입은 해당 등급조건을 충족한 익일부터 적용됩니다.</li>
								<li>- <span class="en">Welcome level</span>이 된 후 별을 모은 시점부터
									1년 안에 30개의 별을 모으시면 <span class="en">Gold level</span>로 승급되며, <br>&nbsp;&nbsp;&nbsp;승급한
									날짜로부터 1년간 별 30개를 추가 적립하시면<span class="en">Gold Level</span>이 1년
									연장됩니다.
								</li>
							</ul>
						</dd>
					</dl>
				</div>
			</section>

			<section class="rewardcard_info3_wrap">
				<div class="rewardcard_info_inner">
					<dl class="info ms_info_box3 info_box3">
						<dt class="tbox">
							<h5>회원 등급별 혜택</h5>
							<span class="arrow"><a href="javascript:void(0);">자세히
									보기</a></span>
						</dt>
						<dd class="box" style="display: block;">
							<ul class="level_wrap newLaverWrap">
								<li class="level1">
									<dl>
										<dt>
											<strong class="num en">0</strong>
											<p class="en">
												Welcome Level<br>
												<span class="level_guide">스타벅스 카드를 등록하세요.</span>
											</p>
										</dt>
										<dd>
											<ul>
												<li>- 스타벅스 카드로 음료 구매 시, <span class="en">Free
														Extra</span> 1개 제공
												</li>
												<li>- 회원 가입 후 첫 구매 시, 익일 웰컴 첫 구매 <span class="en">e</span>-쿠폰
													제공
												</li>
												<li>- 기능 설정 후 스타벅스 카드로 결제 시, 현금영수증 자동 발행</li>
												<li>- 분실 신고 시점의 카드 잔액 보호</li>
												<li>- 자동 충전 5만원 이상 설정 후, 자동 충전 발생 시마다 익일 <span
													class="en">BOGO e</span>-쿠폰 제공<br>(충전 금액 합산은 적용되지
													않습니다.)
												</li>
											</ul>
										</dd>
									</dl>
								</li>
								<li class="level2">
									<dl>
										<dt>
											<strong class="num en">5</strong>
											<p class="en c_007042">
												Green Level<br>
												<span class="level_guide">별 5개만 모아도 레벨 업!</span>
											</p>
										</dt>
										<dd>
											<p class="include_level_adv">
												<strong class="t_1d191b">Welcome Level</strong> 혜택 모두 포함
											</p>
											<p class="leverTxt">(웰컴 첫 구매쿠폰 제외)</p>
											<ul class="leverGList">
												<li>- 생일 축하 무료 음료 <span class="en">e</span>-쿠폰 제공
												</li>
												<li>- 스타벅스 리저브™ 원두 구매 시, 스타벅스 리저브™ 음료 <span class="en">or</span>
													카페 아메리카노(Hot/Iced) e-쿠폰 제공
												</li>
												<li>※ 단, 결제수단 변경 및 교환 거래, 임직원 할인 또는 e-Gift Item 구매 시
													미제공</li>
												<li>- <span class="en">250g</span>원두 <span class="en">or</span>
													12개입 VIA 구매 시, 카페 아메리카노(<span class="en">Hot/Iced</span>) <span
													class="en">e</span>-쿠폰 제공
												</li>
												<li>※ 단, 결제수단 변경 및 교환 거래, 임직원 할인 또는 e-Gift Item 구매 시
													미제공</li>
												<li>- 티바나 패키지 티 구매 시, 풀 리프 티(<span class="en">Hot/Iced</span>)
													e-쿠폰 제공
												</li>
												<li>※ 단, 결제수단 변경 및 교환 거래, 임직원 할인 또는 e-Gift Item 구매 시
													미제공</li>
												<li>- <span class="en">Beverage BOGO e</span>-쿠폰(이벤트 진행
													시 발급)
												</li>
												<li>- 회원 전용 이벤트</li>
											</ul>
										</dd>
									</dl>
								</li>
								<li class="level3">
									<dl>
										<dt>
											<strong class="num en">30</strong>
											<p class="en c_88722e">
												Gold Level<br>
												<span class="level_guide">별 12개 적립 시 무료 음료<br>
													1잔을 드립니다.
												</span>
											</p>

										</dt>
										<dd>
											<p class="include_level_adv">
												<strong class="t_006633">Green Level</strong> 혜택 모두 포함
											</p>
											<ul>
												<li>- 나만의 <span class="en">Gold Card</span> 발급
												</li>
												<li>- 별 ★ 12개 적립 시마다 무료 음료 쿠폰 제공</li>
												<li>- <span class="en">Personalized Offer e</span>-쿠폰
													제공
												</li>
											</ul>
										</dd>
									</dl>
								</li>
							</ul>

						</dd>
					</dl>
				</div>
			</section>

		</div>



		<!-- side_tab -->
		<%@ include file="/WEB-INF/views/Template/mystarbucks_side_tab.jsp"%>
	</div>
</div>

<%@ include file="/WEB-INF/views/Template/fotter.jsp"%>
