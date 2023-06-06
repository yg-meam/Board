package com.BoardMaria.dto;

public class ReplyVO {

	private int replyseqno;
	private String replywriter;
	private String replycontent;
	private String userid;
	private String replyregdate;
	private int seqno;
	
	
	public int getReplyseqno() {
		return replyseqno;
	}
	public void setReplyseqno(int replyseqno) {
		this.replyseqno = replyseqno;
	}
	
	public String getReplywriter() {
		return replywriter;
	}
	public void setReplywriter(String replywriter) {
		this.replywriter = replywriter;
	}
	
	public String getReplycontent() {
		return replycontent;
	}
	public void setReplycontent(String replycontent) {
		this.replycontent = replycontent;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getReplyregdate() {
		return replyregdate;
	}
	public void setReplyregdate(String replyregdate) {
		this.replyregdate = replyregdate;
	}
	
	public int getSeqno() {
		return seqno;
	}
	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}
}
