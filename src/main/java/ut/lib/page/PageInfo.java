package ut.lib.page;

/**
 * <B>NPageInfo</B>
 * @author  miru
 * @version 2005. 6. 16.
 */
public class PageInfo {

    private int totalCnt;
    private int totalPage;
    private int rowSize;
    private int pageSize;
    private int currPage;

    private int firstPageOfRow;
    private int lastPageOfRow;


    public PageInfo() {

    }

    public PageInfo(int totalCnt, int rowSize, int pageSize, int currPage) {
        this.totalCnt = totalCnt;

        this.rowSize = rowSize == 0 ? 10:rowSize;
        this.pageSize = pageSize == 0 ? 10:pageSize;
        this.currPage = currPage == 0 ? 1:currPage;

        setTotalPage();
        setFirstPageOfIndex(currPage);
        setLastPageOfIndex(currPage);
    }


    /**
     * @return Returns the currPage.
     */
    public int getCurrPage() {
        return currPage;
    }
    /**
     * @param currPage The currPage to set.
     */
    public void setCurrPage(int currPage) {
        this.currPage = currPage;
    }
    /**
     * @return Returns the pageSize.
     */
    public int getPageSize() {
        return pageSize;
    }
    /**
     * @param pageSize The pageSize to set.
     */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    /**
     * @return Returns the rowSize.
     */
    public int getRowSize() {
        return rowSize;
    }
    /**
     * @param rowSize The rowSize to set.
     */
    public void setRowSize(int rowSize) {
        this.rowSize = rowSize;
    }
    /**
     * @return Returns the totalCnt.
     */
    public int getTotalCnt() {
        return totalCnt;
    }
    /**
     * @param totalCnt The totalCnt to set.
     */
    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public void setTotalPage() {
        totalPage = (int)Math.ceil((float)totalCnt / (float)rowSize);
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setFirstPageOfIndex(int currPage) {
        firstPageOfRow = ((currPage-1)/pageSize)*pageSize + 1;
    }

    public void setLastPageOfIndex(int currPage) {
        //lastPageOfRow = ((currPage-1)/pageSize+1)*pageSize;
        lastPageOfRow = firstPageOfRow + (pageSize-1);

        if (lastPageOfRow > totalPage) {
            lastPageOfRow = totalPage;
        }
    }

    public int getFirstPageOfRow() {
        return firstPageOfRow;
    }

    public int getLastPageOfRow() {
        return lastPageOfRow;
    }

}
