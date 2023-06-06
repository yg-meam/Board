package com.BoardMaria.dto;

import java.util.List;

public class User {
	
	private String userid;
	private String username;
	private String password;
	private String gender;
	private String hobby;
	private String job;
	private String description;
	private String startdate;
	private String zipcode;
	private String address;
	private String telno;
	private String email;
	private String authkey;
	private String role;
	private String org_filename;
	private String stored_filename;
	private long filesize;
	private String lastpwdate;
	private int pwcheck;
	private int pwdiff;
	
	
	public int getPwdiff() {
		return pwdiff;
	}
	public void setPwdiff(int pwdiff) {
		this.pwdiff = pwdiff;
	}
	public String getLastpwdate() {
		return lastpwdate;
	}
	public void setLastpwdate(String lastpwdate) {
		this.lastpwdate = lastpwdate;
	}
	public int getPwcheck() {
		return pwcheck;
	}
	public void setPwcheck(int pwcheck) {
		this.pwcheck = pwcheck;
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
	
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
