package com.changkong;

public class Order {//订单类，保存用户订单信息
    int oid = -1;           //订单编号
    String userName = null; //用户名

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
