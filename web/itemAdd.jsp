<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/1/30
  Time: 20:46
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String arr[] = request.getParameterValues("bookId");        //得到图书的id号
    String nums[] = request.getParameterValues("nums");         //得到购买数量
    String time = (String) session.getAttribute("time");
    if(arr!=null&&arr.length>0){
        String url = "jdbc:mysql://localhost:3306/bookstore";
        String username = "root";
        String password = "mysqladmin";
        Connection conn = null;
        Statement statement = null;
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        String sql = "insert into items values(?,?,?,?,?,?,?,?,?,?)";
        String sql1 = "select * from books";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        for(int i=0;i<arr.length;++i){
            Connection conn1 = null;
            conn1 = DriverManager.getConnection(url, username, password);
            statement = conn1.createStatement();
            ResultSet rs = statement.executeQuery(sql1);
            int iId = 1000;        //在application设定订单编号的起始位置
            int tempId = 0;
            if(application.getAttribute("iId")==null) { //为空，说明服务器被第一次访问
                application.setAttribute("iId", iId);   //设定id
            }
            while(rs.next()){
                if(Integer.parseInt(arr[i])==rs.getInt("bId")){
                    int temp = Integer.parseInt(arr[i])-1;
                    pstmt.setInt(1,(int)application.getAttribute("iId"));   //
                    tempId = (int)application.getAttribute("iId");
                    application.setAttribute("iId",++tempId);
                    pstmt.setInt(2,Integer.parseInt(arr[i]));   //
                    pstmt.setInt(3,Integer.parseInt(arr[i]));   //插入图书编号
                    pstmt.setString(4,time);                    //下单时间
                    pstmt.setInt(5,Integer.parseInt(nums[temp]));                          //设置数量
                    pstmt.setString(6,rs.getString("b_price")); //图书单价
                    pstmt.setString(7,rs.getString("b_price")); //设置总价
                    pstmt.setString(8,(String) session.getAttribute("userName"));
                    pstmt.setString(9,rs.getString("image"));
                    pstmt.setString(10,rs.getString("bookName"));
                    pstmt.executeUpdate();                      //执行插入语句
                }
            }
        }
        //pstmt.close();
        //conn.close();
        response.sendRedirect("shopping.jsp");
    }
    else{
        out.print("您没有选择任何商品");
        response.sendRedirect("shopping.jsp");
    }
%>
</body>
</html>
