<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/2/2
  Time: 10:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String id = request.getParameter("iId");
    String url = "jdbc:mysql://localhost:3306/bookstore";
    String username = "root";
    String password = "mysqladmin";
    Connection conn = null;
    //Statement statement = null;
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);
    String sql = "delete from items where iId=" + id;
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.executeUpdate();
    pstmt.close();
    response.sendRedirect("shopping.jsp");
%>
</body>
</html>
