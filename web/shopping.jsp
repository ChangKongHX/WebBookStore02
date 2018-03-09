<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: ChangKong
  Date: 2018/1/30
  Time: 19:28
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
                <li><a href="orderlist.jsp">我的订单</a></li>
                <li class="current"><a href="shopping.jsp">购物车</a></li>
                <li><a href="#">注销</a></li>
            </ul>
        </div>
        <form method="get" name="search" action="">
            搜索：<input class="input-text" type="text" name="keywords" /><input class="input-btn" type="submit" name="submit" value="" />
        </form>
    </div>
</div>
<div id="content" class="wrap">
    <div class="list bookList">
        <form method="post" name="shoping" action="shoppingSuccess.html">
            <%
                String userName = (String) session.getAttribute("userName");
                String url = "jdbc:mysql://localhost:3306/bookstore";
                String username = "root";
                String password = "mysqladmin";
                Connection conn = null;
                Statement statement = null;
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                statement = conn.createStatement();
                String sql1 = "SELECT * FROM items";
                ResultSet rs1 = statement.executeQuery(sql1);
            %>
            <table>
                <tr class="title">
                    <th class="view">图片预览</th>
                    <th>书名</th>
                    <th class="nums">数量</th>
                    <th class="price">价格</th>
                    <th>操作</th>
                </tr>
                <%while(rs1.next()){
                   if(rs1.getString("userName").equals(userName)){//通过当前客户用户名，得到订单信息
                %>
                <tr>
                    <td class="thumb"><img src="<%=rs1.getString("image")%>" /></td>
                    <td class="title"><%=rs1.getString("bookName")%></td>
                    <td><input class="input-text" type="text" name="nums" id="<%=rs1.getInt("iId")%>"  value="<%=rs1.getInt("count")%>" onblur="getPrice(<%=rs1.getInt("iId")%>);"/></td>
                    <td>￥<span><%=rs1.getString("price")%></span></td>
                    <td><a href="delete.jsp?iId=<%=rs1.getInt("iId")%>">删除</a></td>
                    <td><input type="hidden" name="valueForIid" value="<%=rs1.getInt("iId")%>" id="valueForIid"></td>
                </tr>
                <%
                   }
                }
                %>
            </table>
            <div class="button">
                <h4>总价：￥<span id="totalPrice"></span>元</h4>
                <input class="input-chart" type="submit" name="submit" value="" />
            </div>
        </form>
    </div>
</div>
<div id="footer" class="wrap">
    JustABookStore &copy; 版权所有
</div>
<script>
    var xmlHttp = null;
    function createXMLHttpRequest(){    //创建XMLHttpRequest对象
        //在IE浏览器下创建
        try{
            xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch(e){
            try{
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch(oc){
                xmlHttp = null;
            }
        }
        //非IE浏览器
        if(!xmlHttp && typeof XMLHttpRequest !="undefined"){
            xmlHttp = new XMLHttpRequest();
        }
    }

    function getPrice(temp) {
        //alert("进入调用");
        var count = document.getElementById(temp).value;
        var iId = temp;
        var url = "getTotalPrice.jsp?count="+count+"&iId="+iId;
        createXMLHttpRequest();         //创建核心对象
        xmlHttp.onreadystatechange = callBackPrice;          //指定回调函数
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function callBackPrice() {
        //alert(xmlHttp.status);
        if(xmlHttp.readyState==4){
            //只处理正常返回
            if(xmlHttp.status==200){
                var result = xmlHttp.responseText;
                //alert(result);
                document.getElementById("totalPrice").innerHTML = result.toString();
            }
        }
    }
</script>
</body>
</html>

