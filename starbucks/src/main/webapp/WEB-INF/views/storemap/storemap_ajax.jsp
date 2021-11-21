<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 

	<div class="ajax_result_list">
		<ul class="quickSearchResultlist">
			<c:forEach var="list" items="${bilist }">
				<li class="quickResultLstCon bidx${list.getBIdx() }"  data-addr="${list.getBLocation()}" style="background:#fff"  data-index="0" data-name="${list.getBName() }" data-bidx="${list.getBIdx() }" >	
					<strong id="store_name"  data-name="${list.getBName() }" >${list.getBName() }  </strong>	
					<p class="result_details">${list.getBLocation() }<br>${list.getBNumber() }</p>	<i class="pin_general">리저브 매장 2번</i>
				</li>
			</c:forEach>
		</ul>
	</div>

	
	

