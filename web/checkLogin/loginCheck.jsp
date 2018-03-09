<%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/1/29
  Time: 20:51
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    //数据库连接
    String url = "jdbc:mysql://localhost:3306/bookstore";
    String username = "root";
    String password = "mysqladmin";
    Connection conn = null;
    Statement statement = null;
    Class.forName("com.mysql.jdbc.Driver");
    conn  = DriverManager.getConnection(url,username,password);
    statement = conn.createStatement();
    String sql = "select * from userinfo";
    ResultSet rs = statement.executeQuery(sql);
    //判断用户名和密码
    String name = request.getParameter("userName");         //用户名
    String pass = request.getParameter("passWord");         //密码
    while(rs.next()){
        if(name.equals(rs.getString("username"))){
            if(pass.equals(rs.getString("passWord"))) {//表示登陆成功
                session.setAttribute("userName", name); //绑定会话消息
                response.sendRedirect("../index.jsp");
            }
        }else{      //表示登陆失败
            out.print("用户名或密码错误！！");
%>
    <!--<script type="text/javascript">alert("用户名或密码错误！！");</script>-->
            <a href="../login.html">返回重新登录</a>
<%
            //response.sendRedirect("../login.html");
        }
    }
%>
</body>
</html>
