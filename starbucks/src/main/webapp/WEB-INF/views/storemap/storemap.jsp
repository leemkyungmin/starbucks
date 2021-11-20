<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0d6b5362840f9081f65363ddeddcf442&libraries=services"></script>
	<link rel="stylesheet" href="${url}/resources/assets/style/storemap.css">
	
	
	
	<div class="wrap">
		<div class="storemap">
			<div id="map" style="width:100%;height:900px;"></div>
			 <div class="hAddr">
		        <span class="title">지도중심기준 행정동 주소정보</span>
		        <span id="centerAddr"></span>
		    </div>
		</div>
		<div class="quick_content">
		
			<form method="post">
				<div class="storemap_layer">
					<section class="find_store_wrap">
						<header class="find_store_header">
							<h2>
								<a href="javascript:void(0)">매장찾기</a>
							</h2>
						</header>
						<article class="find_store_content">
							<article>
								<div class="search_input">
									<div class="serach_input_inner">
										<input type="text" placeholder="매장명 또는 주소" name="quickSearchtxt" id="quickSearchtxt">
										<a href="javascript:void(0)" class="quickSearchBtn">검색</a>
									</div>
								</div>
								<div class="seach_result_count">
									<strong class="quick_search_result"></strong>
									(검색 결과
									<span class="result_number">0</span>
									개)
									<br/>
								</div>
								<div class="result_list">
									<!--
									 최초 페이지가 열리면 
									현재 위치 기준으로 스토어 위치 가져와 마킹 (ajax)
									검색을 quickSearchtxt을 통해 
									검색한 위치 및 매장명 위치 가져와 마킹	 (ajax)
									 -->
								</div>
							</article>
						</article>
					</section>
				</div> 
			</form>
		</div>
	</div>


	<script>
		$().ready(function(){ 
			var markers=[];
			 if (navigator.geolocation) { // GPS를 지원하면
				    navigator.geolocation.getCurrentPosition(function(position) {
				    	
				    	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = {
					        center: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
					    };  

					// 지도를 생성합니다    
					var map = new kakao.maps.Map(mapContainer, mapOption); 

					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					
					// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
					searchAddrFromCoords(map.getCenter(), displayCenterInfo);

					// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
					

					// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
					kakao.maps.event.addListener(map, 'idle', function() {
					    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
					});
					
					function searchAddrFromCoords(coords, callback) {
					    // 좌표로 행정동 주소 정보를 요청합니다
					    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
					}
				
					var position =[];
					var positions =[];
					function getlat_long_location(location,tag){	
						var geocoder = new kakao.maps.services.Geocoder();
						// 주소로 좌표를 검색합니다
						 geocoder.addressSearch(location, function(result, status) {

						    // 정상적으로 검색이 완료됐으면 
						     if (status === kakao.maps.services.Status.OK) {
						    	
						    	tag.setAttribute('data-lat',result[0].y);
						    	tag.setAttribute('data-long',result[0].x);
								
						    } 
						  
						     
						}); 
						
					}
					
					// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
					function displayCenterInfo(result, status) {
					    if (status === kakao.maps.services.Status.OK) {
					        var infoDiv = document.getElementById('centerAddr');

					        for(var i = 0; i < result.length; i++) {
					            // 행정동의 region_type 값은 'H' 이므로
					            if (result[i].region_type === 'H') {
					                infoDiv.innerHTML = result[i].address_name;
					                
					                var addr = result[i].address_name;
					                var tempval = addr.indexOf(' ');
					                var addrPointer = addr.indexOf(' ',tempval+1);
					                
					                var result_addr = addr.substring(0,addrPointer);
					              	
					                $.ajax({
					                	 url:'${url}/store/storeMap_ajax',   
					                	 method:'post',
					                	 data:'location='+result_addr,
					                	 success:function(e){
					                		 $('.result_list').empty();
					                		 $('.result_list').append(e); 
					                		 $('.result_number').text($('.quickResultLstCon').length);
					                		 for(var i=0; i<$('.quickResultLstCon').length; i++){
					                				addr=  $('.quickResultLstCon')[i].dataset.addr;					                				
					                				getlat_long_location(addr,$('.quickResultLstCon')[i]);
					                				
					                		} 	
					                		 
					                	 },error:function(){
					                		 console.log('ajax통신실패');
					                	 }
					                });
					                for (var i = 0; i < markers.length; i++) {
		    					    	
		    					        markers[i].setMap(null);
		    					    }
									markers=[];
									position=[];
									positions=[];
									
					                for(var i=0; i<$('.quickResultLstCon').length; i++){
					                	
					                	var value = new Object();
					                	value.title=$('.quickResultLstCon')[i].dataset.name;
		                				value.lat =  $('.quickResultLstCon')[i].getAttribute('data-lat');
		                				value.longti =  $('.quickResultLstCon')[i].getAttribute('data-long');
		                				position.push(value);
		                    			
		                				positions = [...new Set(position.map(JSON.stringify))].map(JSON.parse);
		                				if(positions.length == $('.quickResultLstCon').length) { 
											
		                					var imageSrc = "${url}/resources/assets/images/commom/maker.png"; 
		                					
				                			for (var i = 0; i < positions.length; i ++) {	
				                				 
				                				 // 마커 이미지의 이미지 크기 입니다
				                			    var imageSize = new kakao.maps.Size(38,60); 
				                			    
				                			    // 마커 이미지를 생성합니다    
				                			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				                			    
				                			    // 마커를 생성합니다
				                			    
				                			    marker= new kakao.maps.Marker({
				                			    	 // 마커를 표시할 지도
				                			        position: new kakao.maps.LatLng(positions[i].lat,positions[i].longti), // 마커를 표시할 위치
				                			        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				                			        image : markerImage // 마커 이미지 
				                			    });
				                			   
				                			    markers.push(marker); 
				                			   
				                			   
				                			    
				                			} 
				                			for (var i = 0; i < markers.length; i++) {
				    					    	
				    					        markers[i].setMap(map);
				    					    }     
		                				}
		                				
					                }
					                
					                
					                
					                break;
					            }
					        }
					    }    
					}
					
				
				    	
				    }, function(error) {
				      console.error(error);
				    }, {
				      enableHighAccuracy: false,
				      maximumAge: 0,
				      timeout: Infinity
				    });
				  } else {
				    alert('GPS를 지원하지 않습니다');
				 }
			 
			
			 
			 
		});
		

		
		</script>

<%@ include file="../Template/fotter.jsp" %>
