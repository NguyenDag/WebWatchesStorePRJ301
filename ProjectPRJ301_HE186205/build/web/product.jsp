<%-- 
    Document   : product.jsp
    Created on : Oct 4, 2024, 3:34:58 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.ImageProduct" %>
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

        <title>Product</title>


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

        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' rel='stylesheet'>
        <link href='https://use.fontawesome.com/releases/v5.7.2/css/all.css' rel='stylesheet'>
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <link href="css/product.css" rel="stylesheet" />

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
            .badge {
                position: absolute;
                top: 0.5rem;
                right: 0.5rem;
                background-color: #f56565;
                color: #ffffff;
                font-size: 0.75rem;
                font-weight: bold;
                padding: 0.25rem 0.5rem;
                border-radius: 0.25rem;
            }

            .star_container i {
                color: #a5a293; /* Đặt màu vàng cho các ngôi sao */
            }

            .product-name {
                font-weight: bold;
                font-size: 1rem; /* Điều chỉnh kích thước phông chữ nếu cần */
            }

            .card {
                padding: 1rem; /* Thêm padding cho card */
                border: 1px solid #e2e8f0; /* Thêm đường viền cho card */
                border-radius: 0.5rem; /* Bo tròn góc cho card */
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* Thêm bóng cho card */
                transition: transform 0.2s; /* Hiệu ứng chuyển động */
            }

            .card:hover {
                transform: scale(1.05); /* Phóng to khi hover */
            }
            .product-name-ellipsis {
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2; /* Limit to 2 lines */
                overflow: hidden; /* Hide overflow */
                text-overflow: ellipsis; /* Add ellipsis */
                font-size: 1rem; /* Adjust font size if needed */
                /*color: #4B0082;  Color for product name */
                margin: 0.5rem 0; /* Adjust margins as needed */
            }
            a.activet{
                background-color: purple;
                color:white
            }
        </style>
        <script type="text/javascript">
    // Hàm để lưu trạng thái checkbox vào localStorage
    function saveCheckboxState() {
        const suppliers = document.getElementsByName('supplier');
        const categories = document.getElementsByName('category');

        // Lưu trạng thái các checkbox của nhà cung cấp
        suppliers.forEach(supplier => {
            localStorage.setItem(supplier.value, supplier.checked);
        });

        // Lưu trạng thái các checkbox của danh mục
        categories.forEach(category => {
            localStorage.setItem(category.value, category.checked);
        });
    }

    // Hàm để khôi phục trạng thái checkbox từ localStorage
    function loadCheckboxState() {
        const suppliers = document.getElementsByName('supplier');
        const categories = document.getElementsByName('category');

        // Khôi phục trạng thái các checkbox của nhà cung cấp
        suppliers.forEach(supplier => {
            const isChecked = localStorage.getItem(supplier.value) === 'true';
            supplier.checked = isChecked;
        });

        // Khôi phục trạng thái các checkbox của danh mục
        categories.forEach(category => {
            const isChecked = localStorage.getItem(category.value) === 'true';
            category.checked = isChecked;
        });
    }

    // Gọi hàm loadCheckboxState khi tải trang
    window.onload = function() {
        // Đặt mặc định chọn "All" cho cả hai khi tải trang
        const allSuppliers = document.getElementById('allSuppliers');
        const allCategories = document.getElementById('allCategories');
        allSuppliers.checked = true;
        allCategories.checked = true;

        loadCheckboxState();

        // Bỏ chọn tất cả các checkbox khác khi "All" được chọn
        allSuppliers.addEventListener('change', function() {
            const suppliers = document.getElementsByName('supplier');
            suppliers.forEach(supplier => {
                if (supplier !== allSuppliers) {
                    supplier.checked = false; // Bỏ chọn các checkbox khác
                }
            });
            saveCheckboxState(); // Lưu trạng thái
        });

        allCategories.addEventListener('change', function() {
            const categories = document.getElementsByName('category');
            categories.forEach(category => {
                if (category !== allCategories) {
                    category.checked = false; // Bỏ chọn các checkbox khác
                }
            });
            saveCheckboxState(); // Lưu trạng thái
        });

        // Gán sự kiện cho các checkbox để lưu trạng thái khi được chọn
        const suppliers = document.getElementsByName('supplier');
        const categories = document.getElementsByName('category');

        suppliers.forEach(supplier => {
            supplier.addEventListener('change', saveCheckboxState);
        });

        categories.forEach(category => {
            category.addEventListener('change', saveCheckboxState);
        });
    };

    function setCheck(obj) {
        const fries = document.getElementsByName('filter');
        const suppliers = document.getElementsByName('supplier');
        const categories = document.getElementsByName('category');

        // Nếu checkbox "All" được chọn
        if (obj.id === 'c0' && fries[0].checked) {
            // Bỏ chọn tất cả các checkbox khác
            for (var i = 1; i < fries.length; i++) {
                fries[i].checked = false;
            }
        } else {
            // Nếu một checkbox khác được chọn, bỏ chọn "All"
            if (fries[1].checked || fries[2].checked || fries[3].checked) {
                fries[0].checked = false;
            }
        }

        // Tạo chuỗi truy vấn
        const params = new URLSearchParams();
        for (let i = 0; i < fries.length; i++) {
            if (fries[i].checked) {
                params.append('filter', fries[i].value);
            }
        }

        // Thêm các supplier đã chọn
        for (let i = 0; i < suppliers.length; i++) {
            if (suppliers[i].checked) {
                params.append('supplier', suppliers[i].value);
            }
        }

        // Thêm các category đã chọn
        for (let i = 0; i < categories.length; i++) {
            if (categories[i].checked) {
                params.append('category', categories[i].value);
            }
        }

        // Gửi yêu cầu AJAX
        fetch('/project/search?' + params.toString(), {
            method: 'GET'
        })
        .then(response => response.text())
        .then(data => {
            document.getElementById('products').innerHTML = data; // Cập nhật danh sách sản phẩm
        })
        .catch(error => console.error('Error:', error));
    }

    function sortProducts() {
        const sortValue = document.getElementById('sort').value;
        if (sortValue) {
            // Chuyển hướng đến servlet với tham số sort
            window.location.href = `search?sort=` + sortValue;
        }
    }
</script>
        <script type="text/javascript">
    function setCheck(obj) {
        var fries = document.getElementsByName('filter'); // Những checkbox filter
        var suppliers = document.getElementsByName('supplier'); // Những checkbox supplier
        var categories = document.getElementsByName('category'); // Những checkbox category

        // Nếu checkbox "All" được chọn
        if (obj.id === 'c0' && fries[0].checked) {
            // Bỏ chọn tất cả các checkbox khác
            for (var i = 1; i < fries.length; i++) {
                fries[i].checked = false;
            }
        } else {
            // Nếu một checkbox khác được chọn, bỏ chọn "All"
            if (fries[1].checked || fries[2].checked || fries[3].checked) {
                fries[0].checked = false;
            }
        }

        // Tạo chuỗi truy vấn
        const params = new URLSearchParams();
        
        // Thêm các filter đã chọn
        for (let i = 0; i < fries.length; i++) {
            if (fries[i].checked) {
                params.append('filter', fries[i].value);
            }
        }

        // Thêm các supplier đã chọn
        for (let i = 0; i < suppliers.length; i++) {
            if (suppliers[i].checked) {
                params.append('supplier', suppliers[i].value);
            }
        }

        // Thêm các category đã chọn
        for (let i = 0; i < categories.length; i++) {
            if (categories[i].checked) {
                params.append('category', categories[i].value);
            }
        }

        // Gửi yêu cầu AJAX
        fetch('/project/search?' + params.toString(), {
            method: 'GET'
        })
        .then(response => response.text())
        .then(data => {
            document.getElementById('products').innerHTML = data; // Cập nhật danh sách sản phẩm
        })
        .catch(error => console.error('Error:', error));
    }

    function sortProducts() {
        const sortValue = document.getElementById('sort').value;
        if (sortValue) {
            // Chuyển hướng đến servlet với tham số sort
            window.location.href = `search?sort=` + sortValue;
        }
    }
</script>
    </head>

    <body class="sub_page">

        <%@include file="header.jsp" %>

        <div style="margin-top: 120px">
            <div class="container">
                <div class="bg-white rounded d-flex align-items-center justify-content-between" id="header">
                    <button class="btn btn-hide text-uppercase" type="button" data-toggle="collapse" data-target="#filterbar"
                            aria-expanded="false" aria-controls="filterbar" id="filter-btn" onclick="changeBtnTxt()">
                        <span class="fas fa-angle-left" id="filter-angle"></span> 
                        <span id="btn-txt">Hide filters</span>
                    </button>

                    <nav class="navbar navbar-expand-lg navbar-light pl-lg-0 pl-auto">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mynav" aria-controls="mynav" 
                                aria-expanded="false" aria-label="Toggle navigation" onclick="chnageIcon()" id="icon">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="mynav" onchange="sortProducts()" >
                            <ul class="navbar-nav d-lg-flex align-items-lg-center">
                                <li class="nav-item active">
                                    <select name="sort" id="sort" >
                                        <option value="0" hidden selected>Sort by</option>
                                        <option value="1">Price</option>
                                        <option value="2">Popularity</option>
                                        
                                    </select>
                                </li>

                                <li class="nav-item d-lg-none d-inline-flex"></li>
                            </ul>
                        </div>
                    </nav>

                    <c:set var="page" value="page" />

                    <div class="ml-auto mt-3 mr-2">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link " href="#" aria-label="Previous">
                                        <span aria-hidden="true" class="font-weight-bold">&lt;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                                <c:forEach begin="${1}" end="${num}" var="i">
                                    <li class="page-item"><a class="page-link" href="search?page=${i}">${i}</a></li>
                                    </c:forEach>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true" class="font-weight-bold">&gt;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
               <jsp:useBean id="dao" class="dal.DAO"/>
<c:set var="all" value="${dao.getTotalProducts()}" />
<div id="content" class="my-5">
    <div id="filterbar" class="collapse">
        <form id="f1" action="search" method="post">

            <div class="box border-bottom">
                <div class="box-label text-uppercase d-flex align-items-center">Suppliers 
                    <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#inner-box" aria-expanded="false" 
                            aria-controls="inner-box" id="out" onclick="outerFilter()"> 
                        <span class="fas fa-plus"></span> 
                    </button>
                </div>
                <div id="inner-box" class="collapse mt-2 mr-1">
                    <div class="my-1"> 
    <label class="tick">All(${all})
        <input type="checkbox" name="supplier" value="All" id="allSuppliers" checked>
        <span class="check"></span> 
    </label>
</div>
                    <c:forEach items="${requestScope.suplist}" var="s">
                        <c:set var="numsup" value="${dao.getTotalProductsBySupID(s.supID)}" />
                        <div class="my-1"> 
                            <label class="tick">${s.supName}(${numsup})
                                <input type="checkbox" name="supplier" value="${s.supName}" 
                                       <c:if test="${s.supName == selectedSupplier}">checked</c:if>
                                > 
                                <span class="check"></span> 
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="box border-bottom">
                <div class="box-label text-uppercase d-flex align-items-center">Categories 
                    <button class="btn ml-auto" type="button" data-toggle="collapse" data-target="#inner-box2" aria-expanded="false"
                            aria-controls="inner-box2"><span class="fas fa-plus"></span></button> 
                </div>
                <div id="inner-box2" class="collapse mt-2 mr-1">
                    <div class="my-1"> 
    <label class="tick">All Categories
        <input type="checkbox" name="category" value="All" id="allCategories" checked>
        <span class="check"></span> 
    </label>
</div>
                    <c:forEach items="${requestScope.catlist}" var="cat">
                        <c:set var="numcat" value="${dao.getTotalProductsByCatID(cat.catID)}" />
                        <div class="my-1"> 
                            <label class="tick">${cat.catName}(${numcat})
                                <input type="checkbox" name="category" value="${cat.catName}" 
                                       <c:if test="${cat.catName == selectedCategory}">checked</c:if>
                                > 
                                <span class="check"></span> 
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div>
                <input type="submit" value="EXE">
            </div>
        </form>
    </div>
</div>


                    <div id="products">
                        <div class="row mx-0">

                            <!--nhap de test in san pham theo suppliers-->
                            <c:if test="${empty requestScope.products}">
                                <h3>No products available</h3>
                            </c:if>
                            <c:forEach items="${requestScope.products}" var="p">
                                <c:set var="rate" value="${d.getRateForProductByProID(p.proID)}"/>
                                <div class="col-lg-4 col-md-6 pt-md-0 pt-3">
                                    <a href="productdetail?proID=${p.proID}" class="card d-flex flex-column align-items-center position-relative">
                                        <c:if test="${p.discount != null && p.discount > 0}">
                                            <span class="badge">-${p.discount}%</span>
                                        </c:if>
                                        <div class="card-img" style="height: 200px">

                                            <c:set var="img" value="${dao.getMainImageForProduct(p.proID, true)}"/>

                                            <img src="${img.imgURL}" 
                                                 alt="Product Image" height="100" id="shirt"/>
                                        </div>
                                        <div class="product-name text-center mt-2 product-name-ellipsis">${p.proName}</div>
                                        <c:if test="${p.discount != null && p.discount > 0}">
                                            <div class="d-flex align-items-center price mt-2">
                                                <div class="mr-3">
                                                    <span class="text-md font-bold text-purple-600">$ ${(p.unitPrice)-(p.unitPrice)*(p.discount)/100}</span>
                                                </div>
                                                <div class="text-xs text-gray-500 line-through">
                                                    <span class="font-bold">$ ${p.unitPrice}</span>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${p.discount != null && p.discount == 0}">
                                            <div class="d-flex align-items-center price mt-2">
                                                <div class="mr-3">
                                                    <span class="text-md font-bold text-purple-600">$ ${(p.unitPrice)}</span>
                                                </div>
                                            </div>
                                        </c:if>

                                        <div class="like mt-2">
                                            <div class="star_container d-flex align-items-center">
                                                <c:if test="${rate.revRating>0}">
                                                    <c:forEach begin="${1}" end="${rate.revRating}">
                                                        <i class="fa fa-star text-warning" aria-hidden="true"></i>
                                                    </c:forEach>

                                                    <c:forEach begin="${1}" end="${5-rate.revRating}">
                                                        <i class="fa fa-star text-gray" aria-hidden="true"></i>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${empty rate.revRating}">
                                                    <c:forEach begin="${1}" end="${5}">
                                                        <i class="fa fa-star text-warning" aria-hidden="true"></i>
                                                    </c:forEach>
                                                </c:if>


                                                <span class="text-gray-500 text-sm ml-2">Sold ${p.unitsOrdered}</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type='text/javascript'
        src='https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js'></script>
        <script type='text/javascript' src='#'></script>
        <script type='text/javascript' src='#'></script>
        <script type='text/javascript' src='#'></script>
        <script type='text/javascript'>// For Filters
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    var filterBtn = document.getElementById('filter-btn');
                                                    var btnTxt = document.getElementById('btn-txt');
                                                    var filterAngle = document.getElementById('filter-angle');

                                                    $('#filterbar').collapse(false);
                                                    var count = 0, count2 = 0;
                                                    function changeBtnTxt() {
                                                        $('#filterbar').collapse(true);
                                                        count++;
                                                        if (count % 2 != 0) {
                                                            filterAngle.classList.add("fa-angle-right");
                                                            btnTxt.innerText = "show filters"
                                                            filterBtn.style.backgroundColor = "#36a31b";
                                                        } else {
                                                            filterAngle.classList.remove("fa-angle-right")
                                                            btnTxt.innerText = "hide filters"
                                                            filterBtn.style.backgroundColor = "#ff935d";
                                                        }

                                                    }

                                                    // For Applying Filters
                                                    $('#inner-box').collapse(false);
                                                    $('#inner-box2').collapse(false);

                                                    // For changing NavBar-Toggler-Icon
                                                    var icon = document.getElementById('icon');

                                                    function chnageIcon() {
                                                        count2++;
                                                        if (count2 % 2 != 0) {
                                                            icon.innerText = "";
                                                            icon.innerHTML = '<span class="far fa-times-circle" style="width:100%"></span>';
                                                            icon.style.paddingTop = "5px";
                                                            icon.style.paddingBottom = "5px";
                                                            icon.style.fontSize = "1.8rem";


                                                        } else {
                                                            icon.innerText = "";
                                                            icon.innerHTML = '<span class="navbar-toggler-icon"></span>';
                                                            icon.style.paddingTop = "5px";
                                                            icon.style.paddingBottom = "5px";
                                                            icon.style.fontSize = "1.2rem";
                                                        }
                                                    }

                                                    // Showing tooltip for AVAILABLE COLORS
                                                    $(function () {
                                                        $('[data-tooltip="tooltip"]').tooltip()
                                                    })

                                                    // For Range Sliders
                                                    var inputLeft = document.getElementById("input-left");
                                                    var inputRight = document.getElementById("input-right");

                                                    var thumbLeft = document.querySelector(".slider > .thumb.left");
                                                    var thumbRight = document.querySelector(".slider > .thumb.right");
                                                    var range = document.querySelector(".slider > .range");

                                                    var amountLeft = document.getElementById('amount-left')
                                                    var amountRight = document.getElementById('amount-right')

                                                    function setLeftValue() {
                                                        var _this = inputLeft,
                                                                min = parseInt(_this.min),
                                                                max = parseInt(_this.max);

                                                        _this.value = Math.min(parseInt(_this.value), parseInt(inputRight.value) - 1);

                                                        var percent = ((_this.value - min) / (max - min)) * 100;

                                                        thumbLeft.style.left = percent + "%";
                                                        range.style.left = percent + "%";
                                                        amountLeft.innerText = parseInt(percent * 100);
                                                    }
                                                    setLeftValue();

                                                    function setRightValue() {
                                                        var _this = inputRight,
                                                                min = parseInt(_this.min),
                                                                max = parseInt(_this.max);

                                                        _this.value = Math.max(parseInt(_this.value), parseInt(inputLeft.value) + 1);

                                                        var percent = ((_this.value - min) / (max - min)) * 100;

                                                        amountRight.innerText = parseInt(percent * 100);
                                                        thumbRight.style.right = (100 - percent) + "%";
                                                        range.style.right = (100 - percent) + "%";
                                                    }
                                                    setRightValue();

                                                    inputLeft.addEventListener("input", setLeftValue);
                                                    inputRight.addEventListener("input", setRightValue);

                                                    inputLeft.addEventListener("mouseover", function () {
                                                        thumbLeft.classList.add("hover");
                                                    });
                                                    inputLeft.addEventListener("mouseout", function () {
                                                        thumbLeft.classList.remove("hover");
                                                    });
                                                    inputLeft.addEventListener("mousedown", function () {
                                                        thumbLeft.classList.add("active");
                                                    });
                                                    inputLeft.addEventListener("mouseup", function () {
                                                        thumbLeft.classList.remove("active");
                                                    });

                                                    inputRight.addEventListener("mouseover", function () {
                                                        thumbRight.classList.add("hover");
                                                    });
                                                    inputRight.addEventListener("mouseout", function () {
                                                        thumbRight.classList.remove("hover");
                                                    });
                                                    inputRight.addEventListener("mousedown", function () {
                                                        thumbRight.classList.add("active");
                                                    });
                                                    inputRight.addEventListener("mouseup", function () {
                                                        thumbRight.classList.remove("active");
                                                    });
                                                });

        </script>
        <script type='text/javascript'>var myLink = document.querySelector('a[href="#"]');
            myLink.addEventListener('click', function (e) {
                e.preventDefault();
            });</script>
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
                                            <div class="star_container">
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
        <section class="footer_section">
            <div class="container">
                <p>
                    &copy; <span id="displayYear"></span> All Rights Reserved By
                    <a href="https://html.design/">Free Html Templates</a>
                </p>
            </div>
        </section>
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

    </body>
</html>
