<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/1/30
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String register=request.getParameter("register");
    if(register != null) {
        String url = "jdbc:mysql://localhost:3306/bookstore";
        String username = "root";
        String password = "mysqladmin";
        Connection conn = null;
        //if (register.equals("add")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                String sql = "insert into userinfo values(?,?,?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                String name = request.getParameter("userName");
                pstmt.setString(1, name);
                pstmt.setString(2, request.getParameter("passWord"));
                pstmt.setString(3, request.getParameter("email"));
                pstmt.executeUpdate();
                pstmt.close();
                session.setAttribute("userName",name);
                response.sendRedirect("../index.jsp");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException E) {
                E.printStackTrace();
            }
     //   }
    }
%>
</body>
</html>
