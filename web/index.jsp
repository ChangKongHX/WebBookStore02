<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/1/29
  Time: 19:20
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>JustABookStore首页</title>
  <link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>
<div id="header" class="wrap">
  <div id="logo">JustABookStore</div>
  <div id="navbar">
    <div class="userMenu">
      <ul>
        <li>欢迎您，<%=session.getAttribute("userName")%></li>
        <li class="current"><a href="index.jsp">首页</a></li>
        <li><a href="orderlist.jsp">我的订单</a></li>
        <li><a href="shopping.jsp">购物车</a></li>
        <li><a href="#">注销</a></li>
      </ul>
    </div>
    <form method="get" name="search" action="">
      搜索：<input class="input-text" type="text" name="keywords" /><input class="input-btn" type="submit" name="submit" value="" />
    </form>
  </div>
</div>
<%
  try{
    String url = "jdbc:mysql://localhost:3306/bookstore";
    String username = "root";
    String password = "mysqladmin";
    Connection conn = null;
    Statement statement = null;
    Class.forName("com.mysql.jdbc.Driver");
    conn  = DriverManager.getConnection(url,username,password);
    ResultSet rs = null;
    statement = conn.createStatement();
%>
<div id="content" class="wrap">
  <div class="list bookList">
    <form method="post" name="shoping" action="itemAdd.jsp">
      <table>
        <tr class="title">
          <th class="checker"></th>
          <th>书名</th>
          <th>数量</th>
          <th class="price">价格</th>
          <th class="store">库存</th>
          <th class="view">图片预览</th>
        </tr>
        <%
          String sql = "select * from books";
          rs = statement.executeQuery(sql);
          int intPageSize;
          int intRowCount;
          int intPageCount;
          int intPage;
          String strPage;
          int i;
          intPageSize = 5;
          strPage = request.getParameter("page");
          if(strPage == null){
            intPage = 1;
          }else{
            intPage = java.lang.Integer.parseInt(strPage);
          }
          if(intPage<1){
            intPage=1;
          }
          rs.last();
          intRowCount = rs.getRow();
          intPageCount = (intRowCount + intPageSize - 1)/intPageSize;
          if(intPage>intPageCount){
            intPage=intPageCount;
          }
          if(intPageCount>0)
            rs.absolute((intPage-1)*intPageSize+1);
          i=0;
          while(i<intPageSize&&!rs.isAfterLast()){
        %>
        <tr>
          <td><input type="checkbox" name="bookId" value="<%=rs.getInt("bId")%>" /></td>
          <td class="title"><%=rs.getString("bookName")%></td>
          <td><input class="input-text" type="text" name="nums" id="nums"  value="1" onblur="getPrice();"/></td>
          <td>￥<%=rs.getString("b_price")%></td>
          <td><%=rs.getInt("stock")%></td>
          <td class="thumb"><img src="<%=rs.getString("image")%>" /></td>
        </tr>
        <%
            rs.next();
            i++;
          }
          rs.close();
          statement.close();
          conn.close();
        %>
        <tr>
          <td colspan="5"> 共<%=intRowCount%>个记录,分<%=intPageCount%>页显示/当前第<%=intPage%>页
            <%
                for(int j =1;j<= intPageCount;j++){
                  out.print("&nbsp;&nbsp;<a href='index.jsp?page="+ j +"'>" + j +"</a>");
                }
              }catch (Exception e){
                e.printStackTrace();
              }
            %></td>
        </tr>
      </table>
      <%
        SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
        String time = timeFormat.format(new Date());
        session.setAttribute("time",time);
      %>
      <div class="button"><input class="input-btn" type="submit" name="submit" value="" /></div>
    </form>
  </div>
</div>
<div id="footer" class="wrap">
  JustABookStore &copy; 版权所有
</div>
</body>
</html>

