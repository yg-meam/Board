package com.BoardMaria.dto;

import java.time.LocalDateTime;

public class LikeVO {

	private int seqno;
	private String userid;
	private String mylikecheck;
	private String mydislikecheck;
	private String likedate;
	private String dislikedate;
	
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
	
	public String getMylikecheck() {
		return mylikecheck;
	}
	public void setMylikecheck(String mylikecheck) {
		this.mylikecheck = mylikecheck;
	}
	
	public String getMydislikecheck() {
		return mydislikecheck;
	}
	public void setMydislikecheck(String mydislikecheck) {
		this.mydislikecheck = mydislikecheck;
	}
	
	public String getLikedate() {
		return likedate;
	}
	public void setLikedate(String likedate) {
		this.likedate = likedate;
	}
	
	public String getDislikedate() {
		return dislikedate;
	}
	public void setDislikedate(String dislikedate) {
		this.dislikedate = dislikedate;
	}
	
}
