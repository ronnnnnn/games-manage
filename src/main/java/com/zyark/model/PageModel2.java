package com.zyark.model;

public class PageModel2 {
	private int page;
	private int rows;
	private String sort;
	private String order;
	private String ids;

	public PageModel2() {
		super();
	}

	public PageModel2(int page, int rows) {
		this.page = page;
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
}
