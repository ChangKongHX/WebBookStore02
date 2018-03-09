<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/2/1
  Time: 20:16
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
<div id="header" class="wrap">
    <div id="logo"></div>
    <div id="navbar">
        <div class="userMenu">
            <ul>
                <li>欢迎您，<%=session.getAttribute("userName")%></li>
                <li><a href="index.jsp">首页</a></li>
                <li class="current"><a href="orderlist.jsp">我的订单</a></li>
                <li><a href="shopping.jsp">购物车</a></li>
                <li><a href="#">注销</a></li>
            </ul>
        </div>
        <form method="get" name="search" action="">
            搜索：<input class="input-text" type="text" name="keywords" /><input class="input-btn" type="submit" name="submit" value="" />
        </form>
    </div>
</div>
<div id="content" class="wrap">
    <div class="list orderList">
        <table>
            <tr class="title">
                <th class="orderId">订单编号</th>
                <th>订单商品</th>
                <th>商品名称</th>
                <th class="userName">收货人</th>
                <th class="price">订单金额</th>
                <th class="createTime">下单时间</th>
                <th class="status">商品数量</th>
            </tr>
            <%
                String userName = (String) session.getAttribute("userName");
                String url = "jdbc:mysql://localhost:3306/bookstore";
                String username = "root";
                String password = "mysqladmin";
                Connection conn1 = null;
                Statement statement = null;
                Class.forName("com.mysql.jdbc.Driver");
                conn1 = DriverManager.getConnection(url, username, password);
                statement = conn1.createStatement();
                String sql1 = "SELECT * FROM items";
                ResultSet rs1 = statement.executeQuery(sql1);
                while(rs1.next()){
                    if(userName.equals(rs1.getString("userName"))) {
            %>
            <tr>
                <td><%=rs1.getInt("iId")%></td>
                <td class="thumb"><img src="<%=rs1.getString("image")%>" /></td>
                <td><%=rs1.getString("bookName")%></td>
                <td><%=userName%></td>
                <td>￥<%=Double.parseDouble(rs1.getString("price"))*rs1.getInt("count")%></td>
                <td><%=rs1.getString("createDate")%></td>
                <td><%=rs1.getInt("count")%></td>
            </tr>
            <%
                    }
                }
            %>

        </table>
    </div>
</div>
<div id="footer" class="wrap">
    JustABookStore &copy; 版权所有
</div>
</body>
</html>

