<%-- 
    Document   : header
    Created on : Oct 6, 2024, 9:46:51 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.DAO" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Basic -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- Site Metas -->
        <link rel="icon" href="images/fevicon/fevicon.png" type="image/gif" />
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <title>HandTime</title>


        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

        <!-- fonts style -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">

        <!-- font awesome style -->
        <link href="css/font-awesome.min.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet" />
        <!-- responsive style -->
        <link href="css/responsive.css" rel="stylesheet" />
        <style>
            .header_section {
                background-color: white;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Thêm bóng cho header */
            }

            .user_options {
                display: flex;
                justify-content: flex-end; /* Canh giữa các liên kết đăng nhập và đăng ký */
            }

            .navbar-brand {
                font-size: 24px;
                line-height: 1.2;
                display: inline-block;
            }

            .nav-item {
                position: relative; /* Cần thiết cho vị trí của dropdown */
            }

            .dropdown-toggle {
                display: inline-flex; /* Căn chỉnh biểu tượng và văn bản */
                align-items: center; /* Căn giữa theo chiều dọc */
                padding: 10px 15px; /* Padding cho khu vực nhấp chuột tốt hơn */
                text-decoration: none; /* Xóa gạch chân */
                color: #333; /* Màu văn bản */
                position: relative;
            }

            .dropdown-menu {
                display: none; /* Ẩn dropdown theo mặc định */
                position: absolute; /* Vị trí tương đối với phần tử cha */
                top: 80%; /* Đặt dropdown ngay dưới nav item */
                left: 0; /* Canh trái */
                background-color: white; /* Màu nền cho dropdown */
                border: 1px solid #ccc; /* Đường viền tùy chọn */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Bóng tùy chọn */
                z-index: 1050; /* Đảm bảo hiển thị trên các nội dung khác */
            }

            .nav-item:hover .dropdown-menu {
                display: block; /* Hiện dropdown khi hover */
            }

            .dropdown-item {
                padding: 8px 12px; /* Padding cho các mục */
                color: #333; /* Màu văn bản */
                text-decoration: none; /* Xóa gạch chân */
                display: block; /* Làm cho các liên kết có thể nhấp đầy đủ */
            }

            .dropdown-item:hover {
                background-color: #f0f0f0; /* Thay đổi màu nền khi hover */
            }



            .search_bar {
                display: flex;
                justify-content: center;
                margin-top: 10px; /* Khoảng cách giữa menu và thanh tìm kiếm */
                padding: 10px 0; /* Padding cho thanh tìm kiếm */
            }

            .search_bar input {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 320px; /* Chiều rộng thanh tìm kiếm */
                max-width: 400px; /* Chiều rộng tối đa */
            }

            .search_bar button {
                padding: 10px;
                margin-left: 5px;
                background-color: #007bff; /* Màu nền cho nút tìm kiếm */
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .search_bar button:hover {
                background-color: #0056b3; /* Thay đổi màu nền khi hover */
            }
            .custom_nav-container {
                padding: 0;
            }
        </style>
    </head>
    <body class="sub_page">
        <div class="hero_area">
            <header class="header_section">
                <div class="container-fluid">
                    <div class="user_options">
                        <c:set var="accid" value="${sessionScope.account.accID}" />
                        <jsp:useBean id="d" class="dal.DAO"/>   
                        <c:set var="quan" value="${d.getTotalProductsInCartByAccID(accid)}"/>
                        <c:if test="${sessionScope.account.role == '0'}">
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" id="productManagementDropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-cogs" aria-hidden="true"></i> Product Management
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="productManagementDropdown">
                                    <li><a class="dropdown-item" href="accountmanager">Account Management</a></li>
                                    <li><a class="dropdown-item" href="productmanager">Product Management</a></li>
                                    <li><a class="dropdown-item" href="statistic">Order Management</a></li>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.account == null}">
                            <a href="login" class="nav-link"><i class="fa fa-sign-in" aria-hidden="true"></i> Đăng nhập</a>
                            <a href="register" class="nav-link"><i class="fa fa-user-plus" aria-hidden="true"></i> Đăng ký</a>
                        </c:if>
                        <c:if test="${sessionScope.account != null}">
                            <a href="profile" id="username" class="nav-link">${sessionScope.account.username}</a>
                            <a href="logout" class="nav-link"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
                        </c:if>
                        <a href="cart" class="nav-link position-relative">
                            <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                            <span class="badge" style="position: absolute; top: 4px; right: -2px; color: black; border-radius: 50%; padding: 4px 6px; font-size: 12px;">
                                ${quan}
                            </span>
                        </a>
                    </div>

                    <nav class="navbar navbar-expand-lg custom_nav-container">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="home">
                                <span>Hand Time</span>
                            </a>
                        </div>

                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class=""> </span>
                        </button>

                        <div class="collapsee navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav">
                                <li class="nav-item <c:if test="${pageContext.request.requestURI.endsWith('home.jsp')}">active</c:if>">
                                        <a class="nav-link" href="home">Home <span class="sr-only">(current)</span></a>
                                    </li>
                                    <li class="nav-item <c:if test="${pageContext.request.requestURI.endsWith('about.jsp')}">active</c:if>">
                                        <a class="nav-link" href="about.jsp">About</a>
                                    </li>
                                    <li id="pro" class="nav-item <c:if test="${pageContext.request.requestURI.endsWith('product.jsp')}">active</c:if>">
                                        <a class="nav-link" href="search">Products</a>
                                    </li>
                                    <li class="nav-item <c:if test="${pageContext.request.requestURI.endsWith('testimonial.jsp')}">active</c:if>">
                                        <a class="nav-link" href="testimonial.jsp">Testimonial</a>
                                    </li>
                                    <li class="nav-item <c:if test="${pageContext.request.requestURI.endsWith('contact.jsp')}">active</c:if>">
                                    <a class="nav-link" href="contact.jsp">Contact Us</a>
                                </li>
                            </ul>
                        </div>

                        <div class="search_bar">
                            <form action="search" method="post">
                                <input name="searchPro" type="text" placeholder="Search...">
                                <button type="submit">Search</button>
                            </form>

                        </div>
                    </nav>
                </div>
            </header>
        </div>
        <!-- end header section -->

    </body>
</html>
