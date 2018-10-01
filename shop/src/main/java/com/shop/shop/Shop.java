package com.shop.shop;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.shop.shop.Constant.*;

@Entity
@Table(name="shop")
public class Shop {
	
	@Id
	String totalid;
	
	int sid;
	String name;
	String enrolldt;
	String update_dt;
	int flags;
	
	public Shop() {}
	
	public Shop(String name) {
		sid = ++ConstantClass.SID;
		totalid =  sid + "10";
		this.name = name;
		String df = new SimpleDateFormat("yyyyMMdd").format(new Date());
		this.enrolldt = df;
		this.update_dt = df;
		flags = ConstantClass.NOTDEL;
	}
	
	public Shop(String name, String enroll_dt) {
		sid = ++ConstantClass.SID;
		totalid = sid + "10";
		this.name = name;
		this.enrolldt = enroll_dt;
		String df = new SimpleDateFormat("yyyyMMdd").format(new Date());
		this.update_dt = df;
		flags = ConstantClass.NOTDEL;
	}
	
	public int getFlags() {
		return flags;
	}
	public void setFlags(int flags) {
		this.flags = flags;
	}
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	
	public String getTotalid() {
		return totalid;
	}
	public void setTotalid(String totalid) {
		this.totalid = totalid;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEnrolldt() {
		return enrolldt;
	}
	public void setEnrolldt(String enroll_dt) {
		this.enrolldt = enroll_dt;
	}

	public String getUpdate_dt() {
		return update_dt;
	}
	public void setUpdate_dt(String update_dt) {
		this.update_dt = update_dt;
	}
}
