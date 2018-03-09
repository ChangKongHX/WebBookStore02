package com.changkong;

public class Item {//订单明细类
    int iid = -1;   //明细编号
    int oid = -1;   //订单编号
    int bid = -1;   //图书编号
    int count = -1; //购买数量
    String price = null;    //单价
    String totalPrice = null;   //总价
    String createDate = null;   //下单时间

    public int getIid() {
        return iid;
    }

    public void setIid(int iid) {
        this.iid = iid;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String  getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String  totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
}
