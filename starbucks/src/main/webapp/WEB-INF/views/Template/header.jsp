<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="url" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="${url}/resources/assets/style/header.css">
<script src="${url}/resources/assets/js/header.js"></script>
<title>StarBucks</title>

<script type="text/javascript">
	$().ready(function(){
		//로그인 상태 확인 
		if(${sessionScope.login !=null} ){
			$('.sign_out').css({'display' :'block'});
			$('.sign_in').css({'display' :'none'});	
		} else {
			$('.sign_out').css({'display' :'none'});
			$('.sign_in').css({'display' :'block'});	
		}
		
		//로그아웃 
		$(document).on('click','#sign_out',function(){
			if(${sessionScope.login !=null} ){
				if(confirm('로그아웃 하시겠습니까?')){
					$.ajax({
						url:'${url}/login/logout',
						type:'get',
						success:function(e){
							if(e =='success'){
								alert('정상적으로 로그아웃 되었습니다.');
							} else {
								alert('로그아웃 실패 ');
							}
							location.href='${url}/';
						},error:function(){
							console.log('ajax통신 실패');
						}
					});
				}
			}
		});
		
		$('#sign_in').click(function(){
			if(${sessionScope.login ==null} ){
				location.href="${url}/login/loginPage";
			}
		});
		
		
		$(document).on('mouseenter', '.menu_inner ul li',function(){
			var ch = $(this).find('.menu_sub_wrap');
			var a = $(this).find('a').first();
		
			
			if(ch.css('display') == 'none'){
				
				//메뉴 색상 초기화
				$('.menu_nav').removeAttr('style');
				$('.menu_nav >a').removeAttr('style');
				
				//선택된 메뉴 
				$(this).css({'background' : '#2c2a29', });
				a.css({'text-decoration' : 'underline' ,'color' : '#669900'});
				
				//모든 하위 메뉴창 닫기 
				$('.menu_sub_wrap').css({'display' : 'none' });
				
				ch.slideDown();
			}
		
		});
		$(document).on('mouseleave', '.menu_inner ul li .menu_sub_wrap',function(){
			var a = $(this).prev();
			a.removeAttr( 'style' );
			a.parent().removeAttr('style');
			
			$(this).slideUp();
		});
		
	});
		
</script>

</head>
<body>
	<div class="header-wrap">
		<div class="header_inner">
			<div class="header_user_menu">
				<h1 class="logo">
					<a id="logo_img" href="${url}/">스타벅스</a>
				</h1>
				<nav class="util_nav">
					<ul>
						<li class="util_nav01 sign_out" style="display:none">
							<a href="javascript:void(0)" id="sign_out">Sign out</a>
						</li>
						<li class="util_nav01 sign_in" >
							<a href="javascript:void(0)" id="sign_in">Sign in</a>
						</li>
						<li class="util_nav01 My_Starbucks" >
							<a href="javascript:void(0)" id="mystarbucks">My_Starbucks</a>
						</li>
						<li class="util_nav01 Customer_service">
							<a href="javascript:void(0)" id="customer_service">Customer_service</a>
						</li>
						<li class="util_nav01 Find_a_Store">
							<a href="${url}/store/storeMap">Find_a_Store</a>
						</li>
	
					</ul>
				</nav>
			</div>
			<nav class="header_menu">
				<div class="menu_inner">
					<ul>
						<li class="menu_nav nav01">
							<a>COFFEE</a>
							<div class="menu_sub_wrap">
								<div class="menu_sub">
									<div class="sub_inner">
										<ul>
											<li class="menu_sub_title">
												<a href="${url}/coffee/coffee_list">커피</a>
											</li>
											<li>
												<a href="${url}/coffee/coffee_list">스타벅스 원두</a>
											</li>
											<li>
												<a href="${url}/coffee/coffee_list?Category=2">스타벅스 비아</a>
											</li>
											<li>
												<a href="${url}/coffee/coffee_list?Category=3">스타벅스앳홈 by 캡슐</a>
											</li>
										</ul>
										
										<ul>
											<li class="menu_sub_title">
												<a href="${url}/coffee/coffeeFind">나와 어울리는 커피</a>
											</li>
										</ul>
									</div> 
								</div>
							</div>
						</li>
						
						<li class="menu_nav nav02">
							<a>Menu</a>
							<div class="menu_sub_wrap">
								<div class="menu_sub">
									<div class="sub_inner">
										<ul>
											<li class="menu_sub_title">
												<a href="${url}/menu/drink_list">음료</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=cold_blue">콜드 브루</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=brood">브루드 커피</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=expresso">에스프레소</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?frappucino">프라푸치노</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?">블랜디드</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=fizzo">스타벅스 피치오 </a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=tea">티(티바니)</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=etc">기타 제조음료</a>
											</li>
											<li>
												<a href="${url}/menu/drink_list?type=juice">스타벅스 주스(병 음료)</a>
											</li>
										</ul>
										
										<ul>
											<li class="menu_sub_title">
												<a href="${url}/coffee/coffeeFind">나와 어울리는 커피</a>
											</li>
										</ul>
									</div> 
								</div>
							</div>
						</li>
						<li class="menu_nav nav03">
							<a>STORE</a>
							<div class="menu_sub_wrap">
								<div class="menu_sub">
									<div class="sub_inner">
										<ul>
											<li class="menu_title">
												<a href="${url}/store/storeMap">매장 찾기</a>
											</li>
											<li>
												<a href="${url}/store/storeMap">퀵 검색</a>
											</li>
											<li>
												<a href="${url}/store/storeMap?type=location">지역 검색</a>
											</li>
											
										</ul>
										
									</div> 
								</div>
							</div>
						</li>
						
						
						<li class="menu_nav nav04">
							<a>WHAT'S NEW</a>
							<div class="menu_sub_wrap">
								<div class="menu_sub">
									<div class="sub_inner">
										<ul>
											<li class="menu_sub_title">
												<a href="${url}/event/eventList">이벤트</a>
											</li>
											
										</ul>
										
										<ul>
											<li class="menu_sub_title">
												<a href="${url}/notice/noticeList">공지사항</a>
											</li>
										</ul>
									</div> 
								</div>
							</div>
						</li>
						
					</ul>
				</div>
			</nav>
		</div>
	</div>