package com.BoardMaira.util;

public class Page {

	public String getPageList(int pageNum, int postNum, int pageListCount, int totalCount, String keyword) {
		//pageNum : 현재 페이지 번호
		//postNum : 현재 화면에 보여지는 게시물 행 갯수(10)
		//pageListCount : list 하단에 보여질 페이지 갯수(5)
		//totalCount : 전체 행 갯수 -> 총 게시물 갯수
		//totalPage : 전체 페이지 갯수
		//section : 한 개의 페이지 목록 ex) 1 2 3 4 5 -> section1, 6 7 8 9 10 -> section2
		//totalSection : 전체 section 갯수 ex) 만약 전체 페이지가 100이고 pageListCount가 5일 경우 totalSection은 20
		
		int totalPage = (int)Math.ceil((double)totalCount / postNum); //전체 페이지 갯수
		int totalSection = (int)Math.ceil((double)totalPage / pageListCount); //전체 section 갯수
		int section = (int)Math.ceil((double)pageNum / pageListCount); //section 갯수
		
		String pageList = "";
		
		/*postNum와 pageListCount가 10일 경우
		//페이지리스트에서 마지막 번호
		int endPageNum = (int)(Math.ceil((double)pageNum / pageListCount)*pageListCount);
		
		//페이지리스트에서의 시작 번호
		int startPageNum = endPageNum - (pageListCount - 1);
		
		//실제 마지막 페이지 번호
		int realEndPageNum = (int)(Math.ceil((double)totalCount/pageListCount));
		if(endPageNum > realEndPageNum) {
			endPageNum = realEndPageNum;
		}
		
		//이전 페이지 버튼 나오는 조건
		boolean prev = startPageNum == 1?false:true;
		
		//다으 페이지 버튼 나오는 조건
		boolean next = endPageNum * pageListCount >= totalCount?false:true;
				
		
		
		//이전 버튼 출력 조건
		if(prev) pageList += "<a href=list?page=" + Integer.toString(startPageNum - 1) + ">◀</a>";
		
		//페이지리스트 출력
		for(int i = startPageNum; i <= endPageNum; i++) {
			//링크가 붙는 페이지 번호
			if(pageNum != i) {
				pageList +=" [<a href=list?page=" + Integer.toString(i) + ">" + Integer.toString(i) + "</a>] ";
			}
			//링크가 붙지 않는 페이지 번호
			if(pageNum == i) {
				pageList +=" [<span style='font-weight: bold'>" + Integer.toString(i) + "</span>] ";
			}
		}
		
		//다음 버튼 출력 조건
		if(next) pageList += "<a href=list?page=" + Integer.toString(endPageNum + 1) + ">▶</a>";
		*/
		

		if(totalPage != 1) {
			for(int i = 1; i <= pageListCount; i++) {
				//1.이전 페이지(◀) 출력 조건
				//  - section 값이 1보다 커야함
				//  - i == 1
				if(section > 1 && i == 1) {
					pageList += "<a href=list?page=" + Integer.toString((section - 2) * pageListCount + pageListCount) + "&keyword=" + keyword + ">◀</a>"; //10페이지에 있을 때 ◀를 누를 경우 5페이지로 넘어감
				}
				
				//2.페이지 출력 중단 ex) 전체 페이지가 8까지만 있어도 10까지 출력되지 않고 8까지만 출력
				if(totalPage < (section - 1) * pageListCount + i) {
					break;
				}
				
				//3.인자로 가져온 페이지값과 계산해서 나온 페이지값이 같으면 링클를 안 붙이고 다르면 다른 페이지로 이동할 수 있는 링크를 붙임
				if(pageNum != (section - 1) * pageListCount + i) {
					pageList += " [<a href=list?page=" + Integer.toString((section - 1) * pageListCount + i) + "&keyword=" + keyword + ">" + Integer.toString((section - 1) * pageListCount + i) + "</a>] ";
				} else {
					pageList += " [<span style='font-weight: bold'>" + Integer.toString((section - 1) * pageListCount + i) + "</span>] ";
				}
				
				//4.다음 페이지 출력 조건
				//  - i == pageListCount : 페이지리스트 갯수만큼 페이지번호 출력
				//  - totalSection > 1 : section이 1개 이상 존재
				//  - totalPage >= i + (section -1) * pageListCount + 1 : 아직까지 출력할 페이지가 남아 있음
				if(i == pageListCount && totalSection > 1 && totalPage >= i + (section -1) * pageListCount + 1) {
					pageList += "<a href=list?page=" + Integer.toString(section * pageListCount + 1) + "&keyword=" + keyword + ">▶</a>";
				}
			}
		}
		return pageList;
	}
	
	public String getPageAddress(int pageNum, int postNum, int pageListCount, int totalCount, String keyword) {
		int totalPage = (int)Math.ceil((double)totalCount / postNum); //전체 페이지 갯수
		int totalSection = (int)Math.ceil((double)totalPage / pageListCount); //전체 section 갯수
		int section = (int)Math.ceil((double)pageNum / pageListCount); //section 갯수
		
		String pageList = "";
		
		if(totalPage != 1) {
			for(int i = 1; i <= pageListCount; i++) {
				//1.이전 페이지(◀) 출력 조건
				//  - section 값이 1보다 커야함
				//  - i == 1
				if(section > 1 && i == 1) {
					pageList += "<a href=/user/addrSearch?page=" + Integer.toString((section - 2) * pageListCount + pageListCount) + "&addrSearch=" + keyword + ">◀</a>"; //10페이지에 있을 때 ◀를 누를 경우 5페이지로 넘어감
				}
				
				//2.페이지 출력 중단 ex) 전체 페이지가 8까지만 있어도 10까지 출력되지 않고 8까지만 출력
				if(totalPage < (section - 1) * pageListCount + i) {
					break;
				}
				
				//3.인자로 가져온 페이지값과 계산해서 나온 페이지값이 같으면 링클를 안 붙이고 다르면 다른 페이지로 이동할 수 있는 링크를 붙임
				if(pageNum != (section - 1) * pageListCount + i) {
					pageList += " [<a href=/user/addrSearch?page=" + Integer.toString((section - 1) * pageListCount + i) + "&addrSearch=" + keyword + ">" + Integer.toString((section - 1) * pageListCount + i) + "</a>] ";
				} else {
					pageList += " [<span style='font-weight: bold'>" + Integer.toString((section - 1) * pageListCount + i) + "</span>] ";
				}
				
				//4.다음 페이지 출력 조건
				//  - i == pageListCount : 페이지리스트 갯수만큼 페이지번호 출력
				//  - totalSection > 1 : section이 1개 이상 존재
				//  - totalPage >= i + (section -1) * pageListCount + 1 : 아직까지 출력할 페이지가 남아 있음
				if(i == pageListCount && totalSection > 1 && totalPage >= i + (section -1) * pageListCount + 1) {
					pageList += "<a href=/user/addrSearch?page=" + Integer.toString(section * pageListCount + 1) + "&addrSearch=" + keyword + ">▶</a>";
				}
			}
		}
		return pageList;
	}
	
}
