<%-- 
    Document   : bill
    Created on : Oct 30, 2024, 3:19:39 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f7f7f7;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;

            }
            .container {
                background-color: #6a0dad; /* Màu tím chủ đạo */
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 100%; /* Chiều rộng full */
                max-width: 1000px; /* Giới hạn chiều rộng tối đa */
                margin: 0 auto; /* Canh giữa */
                color: #fff;
            }
            h1 {
                font-size: 2.5rem;
                margin-bottom: 20px;
            }
            p {
                font-size: 1.2rem;
                margin-bottom: 20px;
            }
            .order-details {
                background-color: #5d3a9b; /* Màu tím nhạt hơn cho phần chi tiết */
                padding: 20px;
                border-radius: 10px;
                margin: 20px 0;
            }
            .btn {
                background-color: #ffffff;
                color: #6a0dad;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #eaeaea;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container">
            <h1>Payment Successful!</h1>
            <p>Thank you for placing your order with us.</p>
            <div class="order-details">
                <h2>Order Details</h2>
                <p>Order ID: <strong>#${orderID}</strong></p>
                <p>Total Amount: <strong>$${totalPrice}</strong></p>
                <!--<p>Order Date: <strong></strong></p>-->
            </div>
            <button class="btn" onclick="window.location.href = 'home'" style="background-color: white">Back to Home</button>
        </div>
    </body>
</html>
