package com.lkm.starbucks.commom;

public class PageMaker {

	public static String getPageView(String path, int page, int recordPerPage, int totalRecord) {
		
		StringBuffer sb = new StringBuffer();
		
		// page : 현재 페이지 번호
		// recordPerPage : 한 페이지에 표시할 레코드(게시글) 개수
		// totalRecord : 전체 레코드 개수
		int totalPage = 0; // 전체 페이지 개수
		int pagePerBlock = 3; // 한 블록에 표시할 페이지 개수
		int beginPageOfBlock = 0; // 블록의 시작 페이지 번호 (beginBlock)
		int endPageOfBlock = 0; // 블록의 끝 페이지 번호 (endBlock)
		
		// 전체 레코드 개수와 한 페이지에 표시할 레코드 개수를 알면 전체 페이지 개수를 알 수 있다.
		totalPage = (int)(totalRecord / recordPerPage);
		if ( totalRecord % recordPerPage != 0 ) {
			totalPage++;
		}
		
		// totalPage 조정 (잘못된 연산/이동 대비용)
		if ( page > totalPage ) {
			totalPage = page;
		}
		
		// 블록에 표시할 시작 페이지 번호와 끝 페이지 번호 계산
		beginPageOfBlock = (int)(((page - 1) / pagePerBlock) * pagePerBlock) + 1;
		endPageOfBlock = beginPageOfBlock + pagePerBlock - 1;
		
		// endPageOfBlock 조정
		if ( endPageOfBlock > totalPage ) {
			endPageOfBlock = totalPage;
		}
		
		// 이전 버튼 표시
		// 이전 버튼의 링크 필요 유무에 따라 if 처리
		// 1. 이전 버튼의 링크가 필요 없는 경우 : beginPageOfBlock < pagePerBlock
		// 2. 이전 버튼의 링크가 필요한 경우 : 그 이외의 경우
		if ( beginPageOfBlock < pagePerBlock ) {
			sb.append("<span style='color: lightgray;'>◀</span>&nbsp;&nbsp;");
		} else {
			sb.append("<a href='" + path + "?page=" + (beginPageOfBlock - 1) + "'>◀</a>&nbsp;&nbsp;");
		}
		
		// 페이지 번호 표시
		// 페이지 번호의 링크 필요 유무에 따라 if 처리
		// 1. 페이지 번호의 링크가 필요 없는 경우 : page == nowPage
		// 2. 페이지 번호의 링크가 필요한 경우 : 그 이외의 경우
		for ( int p = beginPageOfBlock; p <= endPageOfBlock; p++ ) {
			if ( p == page ) {
				sb.append("<span style='color: lightgray;'>" + p + "</span>&nbsp;&nbsp;");
			} else {
				sb.append("<a href='" + path + "?page=" + p + "'>" + p + "</a>&nbsp;&nbsp;");
			}
		}
		
		// 다음 버튼 표시
		// 다음 버튼의 링크 필요 유무에 따라 if 처리
		// 1. 다음 버튼의 링크가 필요 없는 경우 : endPageOfBlock == totalPage
		// 2. 다음 버튼의 링크가 필요한 경우 : 그 이외의 경우
		if ( endPageOfBlock == totalPage ) {
			sb.append("<span style='color: lightgray;'>▶</span>");
		} else {
			sb.append("<a href='" + path + "?page=" + (endPageOfBlock + 1) + "'>▶</a>");
		}
		
		return sb.toString();
		
	}
	
public static String getPageView2(String path, int page, int recordPerPage, int totalRecord) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("<ul>");
		// page : 현재 페이지 번호
		// recordPerPage : 한 페이지에 표시할 레코드(게시글) 개수
		// totalRecord : 전체 레코드 개수
		int totalPage = 0; // 전체 페이지 개수
		int pagePerBlock = 10; // 한 블록에 표시할 페이지 개수
		int beginPageOfBlock = 0; // 블록의 시작 페이지 번호 (beginBlock)
		int endPageOfBlock = 0; // 블록의 끝 페이지 번호 (endBlock)
		
		// 전체 레코드 개수와 한 페이지에 표시할 레코드 개수를 알면 전체 페이지 개수를 알 수 있다.
		totalPage = (int)(totalRecord / recordPerPage);
		if ( totalRecord % recordPerPage != 0 ) {
			totalPage++; 
		}
		
		// totalPage 조정 (잘못된 연산/이동 대비용)
		if ( page > totalPage ) {
			totalPage = page;
		}
		
		// 블록에 표시할 시작 페이지 번호와 끝 페이지 번호 계산
		beginPageOfBlock = (int)(((page - 1) / pagePerBlock) * pagePerBlock) + 1;
		endPageOfBlock = beginPageOfBlock + pagePerBlock - 1;
		
		// endPageOfBlock 조정
		if ( endPageOfBlock > totalPage ) {
			endPageOfBlock = totalPage;
		}
		
		// 이전 버튼 표시
		// 이전 버튼의 링크 필요 유무에 따라 if 처리
		// 1. 이전 버튼의 링크가 필요 없는 경우 : beginPageOfBlock < pagePerBlock
		// 2. 이전 버튼의 링크가 필요한 경우 : 그 이외의 경우
		if ( beginPageOfBlock <= pagePerBlock ) {
			
		} else {
			sb.append("<li class='controll' id='prev'>"); 
			sb.append("<a href='javascript:void(0)'>");
			sb.append("<img src='../resources/assets/images/commom/prev.jpg'>");
			sb.append("</a>");
			sb.append("</li>");
		}
		
		// 페이지 번호 표시
		// 페이지 번호의 링크 필요 유무에 따라 if 처리
		// 1. 페이지 번호의 링크가 필요 없는 경우 : page == nowPage
		// 2. 페이지 번호의 링크가 필요한 경우 : 그 이외의 경우
		for ( int p = beginPageOfBlock; p <= endPageOfBlock; p++ ) {
			if ( p == page ) {
				sb.append("<li class='active' id='pager_controll'>");
				sb.append("<a href='javascript:void(0)'>"+ p );
				sb.append("</a>");
				sb.append("</li>");
			} else {
				sb.append("<li id='pager_controll'>");
				sb.append("<a href='javascript:void(0)'>"+ p );
				sb.append("</a>");
				sb.append("</li>");
			}
		}
		
		// 다음 버튼 표시
		// 다음 버튼의 링크 필요 유무에 따라 if 처리
		// 1. 다음 버튼의 링크가 필요 없는 경우 : endPageOfBlock == totalPage
		// 2. 다음 버튼의 링크가 필요한 경우 : 그 이외의 경우
		if ( endPageOfBlock == totalPage ) {
		} else {
			sb.append("<li class='controll' id='next'>"); 
			sb.append("<a href='javascript:void(0)'>");
			sb.append("<img src='../resources/assets/images/commom/next.jpg'>");
			sb.append("</a>");
			sb.append("</li>");
		}
		
		sb.append("</ul>");
		
		return sb.toString();
		
	}
	
	
}
