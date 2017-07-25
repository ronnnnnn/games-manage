package com.zyark.model;

import java.util.ArrayList;
import java.util.List;

public class Datagrid {

	private Long total = 0L;
	private List rows = new ArrayList();

	public Datagrid() {
		super();
	}

	public Datagrid(Long total, List rows) {
		this.total = total;
		this.rows = rows;
	}

	public Long getTotal() {
		return total;
	}

	public List getRows() {
		return rows;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

}
