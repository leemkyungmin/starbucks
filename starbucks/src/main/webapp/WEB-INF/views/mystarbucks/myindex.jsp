<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>
<link rel="stylesheet" href="${url}/resources/assets/style/myindex.css">
	
	<div class="wrap">
		<header class="header_title_wrap">
			<div class="heaer_title_content">
				<div class="header_title_inner">
					<h4>
						My Starbucks
					</h4>
				</div>
			</div>
		</header>
		
		<div class="wrap_content">
			<div class="mystarbucks_content">
				<div class="user_info">
					<div class="user_level">
						<div class="user_pic">
							<c:if test="${udto.getUPicture() eq null }">
								<i class="far fa-user-circle fa-5x"></i>
							</c:if>
							<c:if test="${udto.getUPicture() ne null }">
								<img src="${udto.getUPicture() }">
							</c:if>
						</div>
						<div class="user_content_info">
							<p>
								<span class="user_txt_bold">${udto.getUNickName()}</span>
								님은 현재 
								<span class="user_txt_bold">
								${udto.getUGrade() } </span>
								입니다.
							</p>
						</div>
					</div>
					<div class="user_star">
						<div class="star_title">
							<h3>My 리워드</h3>
						</div>
						<div class="star_pic">
							<i class="far fa-star fa-5x"></i>
							<p class="star_count">${udto.getUStarcount() }</p>
						</div>
						<c:if test="${udto.getUGrade() eq 'Welcome Level' }">
							<div class="levelup_content">
								<p> 
									<span class="star_left_count">${5-udto.getUStarcount() }</span>개의 별<span class="star_txt">★</span>이 다모이면	
								</p>
								<p>
									<span class="content_green">Green Level</span> 만의 특별한 혜택이
								</p>
							</div>
						</c:if>
						<c:if test="${udto.getUGrade() eq 'Green Level' }">
							<div class="levelup_content">
								<p> 
									<span class="star_left_count">${30-udto.getUStarcount() }</span>개의 별<span class="star_txt">★</span>이 다모이면	
								</p>
								<p>
									<span class="content_green">Gold Level</span> 만의 특별한 혜택이
								</p>
							</div>
						</c:if>
						<c:if test="${udto.getUGrade() eq 'Gold Level' }">
							<div class="levelup_content">
								<p> 
									별<span class="star_left_count">12</span>개의 적립시 무료 음료<br/>1잔을 드립니다.
								</p>
								
							</div>
						</c:if>
					</div>
				</div>
				
				<div class="mycard_list">
					<div class="mycard_title">
						<h3>
							My 스타벅스 카드
						</h3>
						<p>
							총 보유카드 :<span class="card_count_bold">${cardcount}</span>개
						</p>
					</div>
					<div class="Repcard_pic">
						<c:if test="${cardcount eq 0 }">
							<i class="far fa-credit-card fa-5x"></i>
						</c:if>
						<c:if test="${cardcount ne 0 }">
							111111
							<img src="${cldto.getClImg() }"> <!--  -->
						</c:if>
					</div>
					<div class="Repcard_info">
						<div class="repcard_inner">
							<c:if test="${cardcount eq 0 }">
								<p>
									아직 등록하신 카드가 없습니다 .<br/>
								</p>
									<a href="${url}/my/card/new_card">카드 등록하러가기</a> 
							</c:if>
							<c:if test="${cardcount ne 0 }">
								<div class="my_card_info">
									<h4>${cldto.getClName() }</h4>
									<p>카드 잔액 : ${cldto.getClMoney() }</p>
								</div>
									<div class="my_card_controll">
										<a href="javascript:void(0)">충전하기</a>
										<a href="javascript:void(0)">카드 혜택</a> 
									</div>
							</c:if>
						</div>
					</div>
					
					
				</div>
			</div>
			<%@ include file="../Template/mystarbucks_side_tab.jsp" %>
		</div>
			
	</div>
	

<%@ include file="../Template/fotter.jsp" %>
