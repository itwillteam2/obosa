package Page;

public class Paging {

		private int pageSize; // 표시할 페이지 수
		private int listSize; // 출력 게시 글 수
		private int totalPages; // 총 페이지 수
	    private int pageNo; // 페이지 번호
	    private int prevPage; // 이전 페이지 번호
	    private int startPage; // 시작 페이지
	    private int endPage; // 끝 페이지 
	    private int nextPage; // 다음 페이지 번호
	    private int finalPage; // 마지막 페이지 번호
	    private int totalCount;

		public int getPageSize() {
			return pageSize;
		}

		public void setPageSize(int pageSize) {
			this.pageSize = pageSize;
		}

		public int getListSize() {
			return listSize;
		}

		public void setListSize(int listSize) {
			this.listSize = listSize;
		}

		public int getTotalPages() {
			return totalPages;
		}

		public void setTotalPages(int totalPages) {
			this.totalPages = totalPages;
		}

		public int getPageNo() {
			return pageNo;
		}

		public void setPageNo(int pageNo) {
			this.pageNo = pageNo;
		}

		public int getPrevPage() {
			return prevPage;
		}

		public void setPrevPage(int prevPage) {
			this.prevPage = prevPage;
		}

		public int getStartPage() {
			return startPage;
		}

		public void setStartPage(int startPage) {
			this.startPage = startPage;
		}

		public int getEndPage() {
			return endPage;
		}

		public void setEndPage(int endPage) {
			this.endPage = endPage;
		}

		public int getNextPage() {
			return nextPage;
		}

		public void setNextPage(int nextPage) {
			this.nextPage = nextPage;
		}

		public int getFinalPage() {
			return finalPage;
		}

		public void setFinalPage(int finalPage) {
			this.finalPage = finalPage;
		}

		public int getTotalCount() {
			return totalCount;
		}

		public void setTotalCount(int totalCount) {
			this.totalCount = totalCount;
		}
		
		
		 public Paging () {}
			 
		     public void makePage(int totalCount,  int pageNo, int pageSize, int listSize) {
		    	int totalPages = totalCount % listSize == 0?totalCount/listSize:totalCount/listSize+1;  
		        if(totalPages==0) totalPages=1;
		        	;
		        int currentBlock = pageNo%pageSize==0?pageNo/pageSize:(pageNo/pageSize)+1;
		        int startPage = (currentBlock - 1) * pageSize + 1; // 시작 페이지 (페이징 네비 기준)
		        	this.setStartPage(startPage);
		        int endPage = startPage + pageSize - 1; // 끝 페이지 (페이징 네비 기준)
		        if (endPage > totalPages)  endPage = totalPages;
		        	this.setEndPage(endPage);
		        int prevPage = startPage - 1;
		        	this.setPrevPage(prevPage);
		        int nextPage = endPage +1;
		        	this.setNextPage(nextPage);
		        	this.setFinalPage(totalPages);
		        	this.setPageNo(pageNo);
		        	this.setTotalCount(totalCount);
		        	this.setListSize(listSize);
		        	this.setPageSize(pageSize);
		    }

	}
