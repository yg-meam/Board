package com.BoardMaria.dto;

public class FileVO {
	
	private int fileseqno;
	private int seqno;
	private String userid;
	private String org_filename;
	private String stored_filename;
	private long filesize;
	private String checkfile;
	
	public int getFileseqno() {
		return fileseqno;
	}
	public void setFileseqno(int fileseqno) {
		this.fileseqno = fileseqno;
	}
	public int getSeqno() {
		return seqno;
	}
	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getOrg_filename() {
		return org_filename;
	}
	public void setOrg_filename(String org_filename) {
		this.org_filename = org_filename;
	}
	public String getStored_filename() {
		return stored_filename;
	}
	public void setStored_filename(String stored_filename) {
		this.stored_filename = stored_filename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public String getCheckfile() {
		return checkfile;
	}
	public void setCheckfile(String checkfile) {
		this.checkfile = checkfile;
	}	

}
