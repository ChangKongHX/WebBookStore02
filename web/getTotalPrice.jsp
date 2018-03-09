<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/2/1
  Time: 14:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String count = request.getParameter("count");       //得到被修改图书的修改后的数量
    String iId = request.getParameter("iId");     //得到被修改订单的编号
    String userName = (String) session.getAttribute("userName");
    String url = "jdbc:mysql://localhost:3306/bookstore";
    String username = "root";
    String password = "mysqladmin";
    Connection conn1 = null;
    Statement statement = null;
    Class.forName("com.mysql.jdbc.Driver");
    conn1 = DriverManager.getConnection(url, username, password);
    statement = conn1.createStatement();
    String sql = "update items set count=?,createDate=?,total_price=? where iId=?";
    String sql1 = "SELECT * FROM items";
    SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
    String time = timeFormat.format(new Date());            //生成修改时间，订单时间改变
    ResultSet rs1 = statement.executeQuery(sql1);
    double totalPrice = 0;          //定义总价
    String price = null;
    while(rs1.next()){
        if(userName.equals(rs1.getString("userName"))) {
            if (rs1.getInt("iId")==Integer.parseInt(iId)) {
                price = rs1.getString("price");
            } else {
                totalPrice += rs1.getInt("count") * Double.parseDouble(rs1.getString("price"));
            }
        }
    }
    String total_price = Double.toString(Double.parseDouble(price)*Integer.parseInt(count));
    totalPrice+=Double.parseDouble(total_price);
    Connection conn = DriverManager.getConnection(url, username, password);
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1,Integer.parseInt(count));
    pstmt.setString(2,time);
    pstmt.setString(3,total_price);
    pstmt.setInt(4,Integer.parseInt(iId));
    pstmt.executeUpdate();
    out.print(totalPrice);
%>
</body>
</html>
