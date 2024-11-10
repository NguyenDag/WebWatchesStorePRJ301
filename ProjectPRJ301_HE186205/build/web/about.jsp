<%-- 
    Document   : about
    Created on : Oct 4, 2024, 3:32:56 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .image-container {
                position: relative;
                text-align: center;
                img{
                    width: 80%;
                }
                h2{
                    color: orange;
                }
                p{
                    color: black;
                    font-size: 20px;
                }
                margin-bottom: 20px;
            }
            .centered-text {
                position: absolute;
                top: 55%;
                left: 70%;
                transform: translate(-50%, -50%);
            }
            .product img {
                max-width: 100%;
                height: auto;
            }
            .product {
                text-align: center;
            }
            .menu-item:hover .submenu {
                display: block;
            }
            .header_section {
                overflow: hidden;
                background-color: white;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
            }
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .content {
                margin: 50px auto;
                padding: 20px;
                width: 60%;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                color: #333333;
            }
            h2 {
                color: #007bff;
            }
            p {
                line-height: 1.6;
            }
            .core-values {
                display: flex;
                justify-content: space-around;
                margin-top: 30px;
            }
            .core-value {
                background-color: #333333;
                color: #ffffff;
                padding: 20px;
                border-radius: 10px;
                width: 18%;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                position: relative;
            }
            .core-value h3 {
                margin-bottom: 10px;
                font-size: 1.2em;
            }
            .core-value .number {
                position: absolute;
                top: -20px;
                left: 50%;
                transform: translateX(-50%);
                background-color: #800080; /* Màu tím */
                color: #ffffff;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2em;
                font-weight: bold;
            }
            .core-values {
                display: flex;
                justify-content: space-around;
                margin: 30px auto; /* Thay đổi margin để căn giữa và tạo khoảng cách */
                width: 70%; /* Đảm bảo chiều rộng giống như phần content */
            }
            .core-value {
                background-color: #525252;
                h3{
                    color: orange;
                }
                p{
                    color: #fff;
                }
                padding: 20px;
                border-radius: 10px;
                width: 18%;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                position: relative;
                margin: 10px; /* Thêm khoảng cách giữa các core value */
            }
        </style>
    </head>

    <body class="sub_page">

        <div class="hero_area">

            <div class="hero_area">
                <!-- header section strats -->
                
                <!-- end header section -->
                <div>
                    <%@include file="header.jsp" %>
                </div>

                <!--banner for header-->
                <div class="container-fluid">

                    <div class="image-container">
                        <img src="images/backforabout.jpg" alt="Watches">
                        <div class="centered-text">
                            <h2 style="font-family: sans-serift"><strong>Trusted by 80,000+ customers</strong></h2>
                            <p>Genuine products, warranty and after-sales service</p>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-2 col-6">
                            <div class="product">
                                <img src="https://th.bing.com/th/id/OIP.yg1d7FJ8uHOIURiQhMhQFAHaFj?rs=1&pid=ImgDetMain" alt="Watch 1">
                                <p>Đồng hồ 1</p>
                            </div>
                        </div>
                        <div class="col-md-2 col-6">
                            <div class="product">
                                <img src="https://th.bing.com/th/id/OIP.BMCE3JifQfY9JJd8WJOJ0AHaFj?pid=ImgDet&w=474&h=355&rs=1" alt="Watch 2">
                                <p>Đồng hồ 2</p>
                            </div>
                        </div>
                        <div class="col-md-2 col-6">
                            <div class="product">
                                <img src="https://th.bing.com/th/id/OIP.jokmwUiGesSzNpsiQiImdQHaFj?pid=ImgDet&w=474&h=355&rs=1" alt="Watch 3">
                                <p>Đồng hồ 3</p>
                            </div>
                        </div>
                        <div class="col-md-2 col-6">
                            <div class="product">
                                <img src="https://th.bing.com/th/id/OIP.09S_WEexb39DtkGFcz_rXgHaFj?rs=1&pid=ImgDetMain" alt="Watch 4">
                                <p>Đồng hồ 4</p>
                            </div>
                        </div>
                        <div class="col-md-2 col-6">
                            <div class="product">
                                <img src="https://epropertynepal.com/system/photos/3104/original_66.jpg?1530530061" alt="Watch 5">
                                <p>Đồng hồ 5</p>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


            </div>

            <!-- about section -->

            <section class="about_section layout_padding">
                <div class="container-fluid" >
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
                                <h2 style="color: purple; text-align: center; font-family: sans-serift">
                                    About Our Shop
                                </h2>
                                <p id="text">WATCHSTOREVN is the ideal destination for those who are passionate about genuine watches.
                                    Established in 2020, WATCHSTOREVN has quickly affirmed its position 
                                    in the watch industry with more than 80,000+ trusted customers. 
                                    <span id="dots">...</span><span id="more"> We are proud to be an authorized dealer of many 
                                        famous watch brands from Japan and Switzerland such as Omega, Tissot and Orient.<br/>
                                        At WATCHSTOREVN, we are committed to providing 100% genuine products, with a 20-time compensation 
                                        policy if counterfeit goods are detected. Customers not only own high-quality watches but also enjoy 
                                        dedicated after-sales services, including professional warranty and maintenance.<br/>
                                        With a variety of designs from classic to modern, from elegant to sporty, WATCHSTOREVN 
                                        always meets all customers' needs and styles. Come to us to experience the difference and 
                                        find the perfect watch for yourself.
                                    </span></p>
                                <button onclick="toggleText()" id="myBtn">Read More</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- end about section -->

            <!--content section-->

            <div class="content">
                <h2 style="color: purple; text-align: center; font-family: sans-serift">Introduction to WATCHSTOREVN</h2>
                <p>
                    WATCHSTOREVN is the ideal destination for those who are passionate about genuine watches. Established in 2020, WATCHSTOREVN has quickly asserted its position in the watch industry with over 80,000 trusted customers. We are proud to be an authorized dealer of many prestigious watch brands from Japan and Switzerland such as Omega, Tissot, and Orient.
                </p>
                <p>
                    At WATCHSTOREVN, we are committed to providing 100% genuine products, with a compensation policy of 20 times the value if counterfeit goods are detected. Customers not only own high-quality watches but also enjoy dedicated after-sales services, including professional warranty and maintenance.
                </p>
                <p>
                    With a diverse range of models from classic to modern, from elegant to sporty, WATCHSTOREVN always meets the needs and styles of customers. Come to us to experience the difference and find the perfect watch for yourself.
                </p>
            </div>
            <div>
                <h2 style="color: purple; text-align: center; font-family: sans-serift">CORPORATE CORE VALUES</h1>
            </div>
            <div class="core-values">
                <div class="core-value">
                    <div class="number">1</div>
                    <h3>Quality Always Comes First</h3>
                    <p>We are committed to providing the highest quality products.</p>
                </div>
                <div class="core-value">
                    <div class="number">2</div>
                    <h3>Commitment to Dedication</h3>
                    <p>Always put customers first in all services.</p>
                </div>
                <div class="core-value">
                    <div class="number">3</div>
                    <h3>Attractive Policies</h3>
                    <p>Attractive promotions and discount policies.</p>
                </div>
                <div class="core-value">
                    <div class="number">4</div>
                    <h3>Continuous Improvement & Innovation</h3>
                    <p>Constantly improving and innovating products.</p>
                </div>
                <div class="core-value">
                    <div class="number">5</div>
                    <h3>Sustainable Development</h3>
                    <p>Towards sustainable and long-term development.</p>
                </div>
            </div>
            <!--end content section-->


            <!-- info section -->
            <section class="info_section layout_padding2">
                <div class="container">
                    <div class="info_logo">
                        <h2>
                            HandTime
                        </h2>
                    </div>
                    <div class="row">

                        <div class="col-md-3">
                            <div class="info_contact">
                                <h5>
                                    About Shop
                                </h5>
                                <div>
                                    <div class="img-box">
                                        <img src="images/location-white.png" width="18px" alt="">
                                    </div>
                                    <p>
                                        Address
                                    </p>
                                </div>
                                <div>
                                    <div class="img-box">
                                        <img src="images/telephone-white.png" width="12px" alt="">
                                    </div>
                                    <p>
                                        +01 1234567890
                                    </p>
                                </div>
                                <div>
                                    <div class="img-box">
                                        <img src="images/envelope-white.png" width="18px" alt="">
                                    </div>
                                    <p>
                                        demo@gmail.com
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="info_info">
                                <h5>
                                    Informations
                                </h5>
                                <p>
                                    ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                                </p>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="info_insta">
                                <h5>
                                    Instagram
                                </h5>
                                <div class="insta_container">
                                    <div class="row m-0">
                                        <div class="col-4 px-0">
                                            <a href="">
                                                <div class="insta-box b-1">
                                                    <img src="images/w1.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-4 px-0">
                                            <a href="">
                                                <div class="insta-box b-1">
                                                    <img src="images/w2.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-4 px-0">
                                            <a href="">
                                                <div class="insta-box b-1">
                                                    <img src="images/w3.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-4 px-0">
                                            <a href="">
                                                <div class="insta-box b-1">
                                                    <img src="images/w4.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-4 px-0">
                                            <a href="">
                                                <div class="insta-box b-1">
                                                    <img src="images/w5.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                        <div class="col-4 px-0">
                                            <a href="">
                                                <div class="insta-box b-1">
                                                    <img src="images/w6.png" alt="">
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="info_form ">
                                <h5>
                                    Newsletter
                                </h5>
                                <form action="">
                                    <input type="email" placeholder="Enter your email">
                                    <button>
                                        Subscribe
                                    </button>
                                </form>
                                <div class="social_box">
                                    <a href="">
                                        <img src="images/fb.png" alt="">
                                    </a>
                                    <a href="">
                                        <img src="images/twitter.png" alt="">
                                    </a>
                                    <a href="">
                                        <img src="images/linkedin.png" alt="">
                                    </a>
                                    <a href="">
                                        <img src="images/youtube.png" alt="">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- end info_section -->

            <!-- footer section -->

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

            <script>
                function toggleText() {
                    var dots = document.getElementById("dots");
                    var moreText = document.getElementById("more");
                    var btnText = document.getElementById("myBtn");

                    if (dots.style.display === "none") {
                        dots.style.display = "inline";
                        btnText.innerHTML = "Read More";
                        moreText.style.display = "none";
                    } else {
                        dots.style.display = "none";
                        btnText.innerHTML = "Less";
                        moreText.style.display = "inline";
                    }
                }
            </script>
    </body>
</html>
