<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/1/30
  Time: 10:53
  TODO：通过查询数据库信息判断用户名是否重复
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

<script type="text/javascript">alert("页面转向")</script>

<%
    request.setCharacterEncoding("utf-8");
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
    //遍历数据库查询用户名是否存在
    String name = request.getParameter("userName");     //得到用户名
    String result = "false";            //服务器响应内容,kong表示为空，true表示用户名存在，false表示用户名不存在
    if(name==null||name.length()<=0){             //为空时
        result = "kong";
    }else {//不为空时判断用户名是否存在
        while (rs.next()) {
            if (name.equals(rs.getString("username"))) {//用户名存在
                result = "true";
                break;
            }
        }
    }
    out.print(result);
%>
</body>
</html>
