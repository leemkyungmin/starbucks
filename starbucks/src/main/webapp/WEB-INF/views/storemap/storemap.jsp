
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Template/header.jsp"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0d6b5362840f9081f65363ddeddcf442&libraries=services"></script>
<link rel="stylesheet" href="${url}/resources/assets/style/storemap.css">




<div class="wrap">
	<div class="storemap">
		<div id="map" style="width: 100%; height: 900px;"></div>
		
	</div>
	<div class="quick_content"> 

		<form onSubmit="return false;">
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
									<input type="text" placeholder="매장명 또는 주소" 
										name="quickSearchtxt" id="quickSearchtxt" autocomplete='off'> <a
										href="javascript:void(0)" class="quickSearchBtn">검색</a>
								</div>
							</div>
							<div class="seach_result_count">
								<strong class="quick_search_result"></strong> (검색 결과 <span
									class="result_number">0</span> 개) <br />
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
					<header class="find_road_header">
						<h2 class="btn_find_road">
							<a href="javascript:void(0);">길찾기</a>
						</h2>
					</header>
					<article></article>
				</section>
			</div>
		</form>
	</div>
</div>


<script>
	$().ready(function() {


		var $markera = new Array();

		if (navigator.geolocation) { // GPS를 지원하면
			navigator.geolocation.getCurrentPosition(function(position) {
				localStorage.setItem('lat', position.coords.latitude);
				localStorage.setItem('long', position.coords.longitude);
			}, function(error) {
				console.error(error);
			}, {
				enableHighAccuracy : false,
				maximumAge : 0,
				timeout : Infinity
			});
		} else {
			alert('GPS를 지원하지 않습니다');
		}
		
		var markers = new Array();
		var overlays = [];
		var position = [];
		var positions =[];
		var overlayarr =[];
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		if(localStorage.getItem('lat') !=null){
			map.setCenter(new kakao.maps.LatLng(localStorage.getItem('lat'), localStorage.getItem('long')))
		}
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		function searchAddrFromCoords(coords, callback) {
			 // 좌표로 행정동 주소 정보를 요청합니다
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
		}

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		    makemarker();
		});
		
		function movemap(addr){
			$.ajax({
           	 url:'${url}/store/storeMap_ajax',   
           	 method:'post',
           	 data:'location='+addr,
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
		}
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
		function makemarker(){
			overlayarr.forEach(function(overlay) {
		        overlay.setMap(null);
		   });
			
			 for (var i = 0; i < markers.length; i++) {
			        markers[i].setMap(null);
			        
			}
			markers=[];
			position=[];
			positions=[];
			overlays=[];
			overlayarr=[];
			for(var i=0; i<$('.quickResultLstCon').length; i++){
            	
            	var value = new Object();
            	value.title=$('.quickResultLstCon')[i].dataset.name;
				value.lat =  $('.quickResultLstCon')[i].getAttribute('data-lat');
				value.longti =  $('.quickResultLstCon')[i].getAttribute('data-long');
				position.push(value);
    			
				positions = [...new Set(position.map(JSON.stringify))].map(JSON.parse);
				
				 var closeOverlay = function() {
					 
					 overlayarr.forEach(function(overlay) {
					        overlay.setMap(null);
					   });

					 	
					 };
				
				var $wrap = $('<div class="marker_pop" />');
				var $info = $('<div class="info" />');
				var $title = $('<div class="title" />').text( $(".quickResultLstCon")[i].getAttribute("data-name"));
				var $close = $('<div class="close" title="닫기" />').click(closeOverlay);
				var $body = $('<div class="overlay_body" />'); // body 안쪽은 생략
				var $desc =$('<div class="desc" />');
				var $addr =$('<p class="addr"/>').text($('.quickResultLstCon')[i].getAttribute('data-addr'));
				var $number =$(' <p class="number"/>').text('1522-3232');

				$wrap.append($info);
				$desc.append($addr).append($number);
				$body.append($desc);
				$info.append($title).append($body);
				$title.append($close);

				var content = $wrap[0];
				
			    var obj_content = new Object();
			    obj_content.content = content;
			    obj_content.lat =  $('.quickResultLstCon')[i].getAttribute('data-lat');
			    obj_content.longti =  $('.quickResultLstCon')[i].getAttribute('data-long');
			    overlays.push(obj_content);
				
				
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
        			    
        			    var overlay = new kakao.maps.CustomOverlay({
        	                position: new kakao.maps.LatLng(overlays[i].lat,overlays[i].longti)
        	            });
        		        
        		        overlay.setContent(overlays[i].content);
        		        overlayarr.push(overlay);
        			    kakao.maps.event.addListener(marker, 'click', displayOverlay(map, overlay));
        			    
        			   
				       
				        
				        
        			    
        			} 
        			for (var i = 0; i < markers.length; i++) {
				        markers[i].setMap(map);
				        
				    }     
				}
				
            }
			
            
        
		}
		
		
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		    	
		        var infoDiv = document.getElementById('centerAddr');

		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {
		               
		                var addr = result[i].address_name;
		                var tempval = addr.indexOf(' ');
		                var addrPointer = addr.indexOf(' ',tempval+1);
		                
		                var result_addr = addr.substring(0,addrPointer);
		                
		                movemap(result_addr);
		                makemarker();						
		            }   
		        }
		    }    
		}
		
		$('.result_list').on('mouseover',function(){
			$('.quickResultLstCon').on('click',function(){
				
				var latti =  $(this).data('lat');
				var longti =  $(this).data('long');
				
				 var moveLatLon = new kakao.maps.LatLng(latti, longti);
				    
				    // 지도 중심을 이동 시킵니다
				 map.setCenter(moveLatLon);
				 
				
				    

			});
								
		});
		
		
		function displayOverlay(map, overlay) {
            return function() {
            	overlayarr.forEach(function(overlay) {
			        overlay.setMap(null);
			   });
                overlay.setMap(map);
            }
        }
		
		$('.quickSearchBtn').on('click',function(){
			
			quicksearch();
			
		});
		
		$('#quickSearchtxt').on('keyup',function(){
			if (window.event.keyCode == 13) {
				quicksearch();
			}
		});
		
		
		
		function quicksearch(){
			var searchtxt =$('#quickSearchtxt');
			if( searchtxt.val() !='') {
				movemap(searchtxt.val());
				makemarker();
				
				setTimeout(() => {
					if($('.quickResultLstCon').length ==0) {
						alert('검색된 결과가 없습니다.');
						history.go(0);
					}else {
						var latti = $('.quickResultLstCon')[0].getAttribute('data-lat');
						var longti = $('.quickResultLstCon')[0].getAttribute('data-long');
						 var moveLatLon = new kakao.maps.LatLng(latti, longti);
						    
						    // 지도 중심을 이동 시킵니다
						 map.setCenter(moveLatLon);
						 searchtxt.val('');
					}
				}, 500);
				
				
			} else {
				alert('검색어를 검색해주세요');
				searchtxt.focus();
			}
		}
		
		
	});
</script>

<%@ include file="../Template/fotter.jsp"%>
