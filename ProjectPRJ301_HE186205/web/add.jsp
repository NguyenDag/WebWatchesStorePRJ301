<%-- 
    Document   : new
    Created on : Sep 26, 2024, 3:49:03 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Add a new category</h1>
        <h4 style="color: red">${requestScope.error}</h4>
        <form action="add">
<!--            private int productid;
            private String productname;
            private int supplierid;
            private Category cid;
            private String quantityperunit;
            private double unitprice;
            private int unitsinstock, quantitysold, starrating, discontinued;
            private String image, describe, releasedate;
            private double discount;
            private int status;-->
            enter id:<input type="number" name="id"><br/>
            enter name:<input type="text" name="name"><br/>
            enter describe:<input type="text" name="desc"><br/>
            <button type="submit">SAVE</button>
        </form>
    </body>
</html>
