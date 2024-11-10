<%-- 
    Document   : home
    Created on : Oct 4, 2024, 2:44:06 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.ReviewsTotal" %>
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

        <title>Home</title>


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
            .text-md {
                font-size: 1rem;
                /* Adjust to your needs */
            }

            .font-bold {
                font-weight: bold;
            }

            .text-purple-600 {
                color: #6b46c1;
                /* Tailwind CSS color for purple-600 */
            }

            .mb-2 {
                margin-bottom: 0.5rem;
                /* Adjust to your needs */
            }

            .text-xs {
                font-size: 0.75rem;
                /* Adjust to your needs */
            }

            .text-gray-500 {
                color: #a0aec0;
                /* Tailwind CSS color for gray-500 */
            }

            .line-through {
                text-decoration: line-through;
            }

            .ml-2 {
                margin-left: 0.5rem;
                /* Adjust to your needs */
            }
            .img-box img {
                transition: transform 0.3s ease-in-out;
            }

            .img-box:hover img {
                transform: scale(1.1);
            }
        </style>

    </head>

    <body>
        <div>
            <%@include file="header.jsp" %>
        </div>
        <jsp:useBean id="dao" class="dal.DAO"/>
        <!--banner for header-->
        <div style="width: 100%">
            <div><img style="width: 100%; height: auto; margin: auto" src="images/background.jpg" alt="#"/></div>

            <div style="background-color: purple; width: 80%; margin: auto">
                <h1 style="text-align: center; padding: 10px 0 10px">LUXURY WATCHES</h1>
            </div>

        </div>
        <!--service section--> 

        <section class="service_section">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6 col-lg-3">
                        <div class="box ">
                            <div class="img-box">
                                <img src="images/feature-1.png" alt="">
                            </div>
                            <div class="detail-box">
                                <h5>
                                    Fast Delivery
                                </h5>
                                <p>
                                    variations of passages of Lorem Ipsum available
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="box ">
                            <div class="img-box">
                                <img src="images/feature-2.png" alt="">
                            </div>
                            <div class="detail-box">
                                <h5>
                                    Free Shiping
                                </h5>
                                <p>
                                    variations of passages of Lorem Ipsum available
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="box ">
                            <div class="img-box">
                                <img src="images/feature-3.png" alt="">
                            </div>
                            <div class="detail-box">
                                <h5>
                                    Best Quality
                                </h5>
                                <p>
                                    variations of passages of Lorem Ipsum available
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="box ">
                            <div class="img-box">
                                <img src="images/feature-4.png" alt="">
                            </div>
                            <div class="detail-box">
                                <h5>
                                    24x7 Customer support
                                </h5>
                                <p>
                                    variations of passages of Lorem Ipsum available
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- end service section -->


        <!-- about section -->

        <section class="about_section layout_padding">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <div class="img_container">
                            <div class="img-box b1">
                                <img src="images/a-1.jpg" alt="">
                            </div>
                            <div class="img-box b2">
                                <img src="images/a-2.jpg" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-box">
                            <h2>
                                About Our Shop
                            </h2>
                            <p>
                                There are many variations of passages of Lorem Ipsum
                                There are many variations of
                                passages of Lorem Ipsum
                            </p>
                            <a href="about.jsp">
                                Read More
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end about section -->


        <!-- product section -->

        <section class="product_section ">
            <div class="container">
                <div class="product_heading">
                    <h2>
                        Top Sale Watches
                    </h2>
                </div>
                <div class="product_container">

                    <c:forEach items="${requestScope.topsale}" var="ts">
                        <c:set var="rate1" value="${d.getRateForProductByProID(ts.proID)}"/>
                        <div class="box">
                            <span style="position: absolute; top: 0.5rem; right: 0.5rem; background-color: #f56565; color: #ffffff; font-size: 0.75rem; font-weight: bold; padding: 0.25rem 0.5rem; border-radius: 0.25rem;">
                                -${ts.discount}%
                            </span>
                            <div class="box-content">
                                <a href="productdetail?proID=${ts.proID}">

                                    <div class="img-box">
                                        <img src="${ts.imgURL}" alt="loi">
                                    </div>
                                    <div class="detail-box">
                                        <div class="text">
                                            <!--                                        ghep them de test, xoa sau khi chen anh tu co so du lieu
                                                                                    cai thien lai do dai cua ten san pham-->
                                            <h2 class="name">
                                                ${ts.proName}
                                            </h2>
                                            <!--chinh lai muc gia phu hop hon, ngan hon de khop voi box-->
                                            <p class="text-md font-bold text-purple-600 mb-2">
                                                $ ${(ts.unitPrice)-(ts.unitPrice)*(ts.discount)/100}
                                                <span class="text-xs text-gray-500 line-through ml-2">
                                                    $ ${ts.unitPrice}
                                                </span>
                                            </p>
                                        </div>
                                        <div class="like">
                                            <div class="star_container">
                                                <c:if test="${rate1.revRating>0}">
                                                    <c:forEach begin="${1}" end="${rate1.revRating}">
                                                        <i class="fa fa-star text-warning" aria-hidden="true"></i>
                                                    </c:forEach>

                                                    <c:forEach begin="${1}" end="${5-rate1.revRating}">
                                                        <i class="fa fa-star text-gray" aria-hidden="true"></i>
                                                    </c:forEach>
                                                </c:if>
                                                    <c:if test="${empty rate1.revRating}">
                                                    <c:forEach begin="${1}" end="${5}">
                                                        <i class="fa fa-star text-warning" aria-hidden="true"></i>
                                                    </c:forEach>
                                                </c:if>
                                                <span class="text-gray-500 text-sm ml-2">
                                                    Sold ${ts.unitsOrdered}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </section>

        <!-- end product section -->


        <!-- product section -->

        <section class="product_section ">
            <div class="container">
                <div class="product_heading">
                    <h2>
                        Flash Sale
                    </h2>
                </div>
                <div class="product_container">
                    <c:forEach items="${requestScope.flashsale}" var="ts">
                        <c:set var="rate2" value="${d.getRateForProductByProID(ts.proID)}"/>
                        <div class="box">
                            <span style="position: absolute; top: 0.5rem; right: 0.5rem; background-color: #f56565; color: #ffffff; font-size: 0.75rem; font-weight: bold; padding: 0.25rem 0.5rem; border-radius: 0.25rem;">
                                -${ts.discount}%
                            </span>
                            <div class="box-content">
                                <a href="productdetail?proID=${ts.proID}">
                                    <div class="img-box">
                                        <img src="${ts.imgURL}" alt="loi">
                                    </div>
                                    <div class="detail-box">
                                        <div class="text">
                                            <!--ghep them de test, xoa sau khi chen anh tu co so du lieu-->
                                            <!--cai thien lai do dai cua ten san pham-->
                                            <h2 class="name">
                                                ${ts.proName}
                                            </h2>
                                            <!--chinh lai muc gia phu hop hon, ngan hon de khop voi box-->
                                            <p class="text-md font-bold text-purple-600 mb-2">
                                                $ ${(ts.unitPrice)-(ts.unitPrice)*(ts.discount)/100}
                                                <span class="text-xs text-gray-500 line-through ml-2">
                                                    $ ${ts.unitPrice}
                                                </span>
                                            </p>
                                        </div>
                                        <div class="like">
                                            <div class="star_container" style="color: #a5a293">
                                                <c:if test="${rate2.revRating>0}">
                                                    <c:forEach begin="${1}" end="${rate2.revRating}">
                                                        <i class="fa fa-star text-warning" aria-hidden="true"></i>
                                                    </c:forEach>

                                                    <c:forEach begin="${1}" end="${5-rate2.revRating}">
                                                        <i class="fa fa-star text-gray" aria-hidden="true"></i>
                                                    </c:forEach>
                                                </c:if>
                                                    <c:if test="${empty rate2.revRating}">
                                                    <c:forEach begin="${1}" end="${5}">
                                                        <i class="fa fa-star text-warning" aria-hidden="true"></i>
                                                    </c:forEach>
                                                </c:if>
                                                <span class="text-gray-500 text-sm ml-2">
                                                    Sold ${ts.unitsOrdered}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>


        <!-- end product section -->

        <!-- contact section -->
        <section class="contact_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>
                        Contact Us
                    </h2>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form_container">
                            <form action="">
                                <div>
                                    <input type="text" placeholder="Your Name" />
                                </div>
                                <div>
                                    <input type="text" placeholder="Phone Number" />
                                </div>
                                <div>
                                    <input type="email" placeholder="Email" />
                                </div>
                                <div>
                                    <input type="text" class="message-box" placeholder="Message" />
                                </div>
                                <div class="btn_box">
                                    <button>
                                        SEND
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-6 ">
                        <div class="map_container">
                            <div class="map">
                                <div id="googleMap"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end contact section -->


        <!-- client section -->
        <section class="client_section layout_padding-bottom">
            <div class="container">
                <div class="heading_container heading_center">
                    <h2>
                        Testimonial
                    </h2>
                </div>
            </div>
            <div id="customCarousel2" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-10 mx-auto">
                                    <div class="box">
                                        <div class="img-box">
                                            <img src="images/client.jpg" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <div class="client_info">
                                                <div class="client_name">
                                                    <h5>
                                                        Morojink
                                                    </h5>
                                                    <h6>
                                                        Customer
                                                    </h6>
                                                </div>
                                                <i class="fa fa-quote-left" aria-hidden="true"></i>
                                            </div>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                                                labore
                                                et
                                                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                                                aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                                cillum
                                                dolore eu fugia
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-10 mx-auto">
                                    <div class="box">
                                        <div class="img-box">
                                            <img src="images/client.jpg" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <div class="client_info">
                                                <div class="client_name">
                                                    <h5>
                                                        Morojink
                                                    </h5>
                                                    <h6>
                                                        Customer
                                                    </h6>
                                                </div>
                                                <i class="fa fa-quote-left" aria-hidden="true"></i>
                                            </div>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                                                labore
                                                et
                                                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                                                aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                                cillum
                                                dolore eu fugia
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-10 mx-auto">
                                    <div class="box">
                                        <div class="img-box">
                                            <img src="images/client.jpg" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <div class="client_info">
                                                <div class="client_name">
                                                    <h5>
                                                        Morojink
                                                    </h5>
                                                    <h6>
                                                        Customer
                                                    </h6>
                                                </div>
                                                <i class="fa fa-quote-left" aria-hidden="true"></i>
                                            </div>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                                                labore
                                                et
                                                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                                                aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                                cillum
                                                dolore eu fugia
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <ol class="carousel-indicators">
                    <li data-target="#customCarousel2" data-slide-to="0" class="active"></li>
                    <li data-target="#customCarousel2" data-slide-to="1"></li>
                    <li data-target="#customCarousel2" data-slide-to="2"></li>
                </ol>
            </div>
        </section>
        <!-- end client section -->

        <%@include file="footer.jsp" %>
        <!-- jQery -->
        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
        <!-- popper js -->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
        </script>
        <!-- bootstrap js -->
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <!-- custom js -->
        <script type="text/javascript" src="js/custom.js"></script>
        <!-- Google Map -->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap">
        </script>
        <!-- End Google Map -->

    </body>
</html>
