<%-- 
    Document   : cart
    Created on : Oct 22, 2024, 10:58:34 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page import="model.Product" %>
<%@page import="model.ImageProduct" %>
<%@page import="model.CartTotal" %>
<%@page import="dal.DAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>cart Page</title>
        <script src="https://cdn.tailwindcss.com">
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
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
                top: 100%; /* Đặt dropdown ngay dưới nav item */
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
            .sticky-bottom {
                position: sticky;
                bottom: 0;
                background-color: white;
                z-index: 10;
                box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
            }
            .custom_nav-container .navbar-nav {
                margin: auto;
            }

            .custom_nav-container .navbar-nav .nav-item .nav-link {
                padding: 5px 25px;
                color: #000000 ;
                text-align: center;
                text-transform: uppercase;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .custom_nav-container .navbar-nav .nav-item:hover .nav-link, .custom_nav-container .navbar-nav .nav-item.active .nav-link {
                color: #ffffff !important;
                background-color: #8019c8 !important;
            }
            .product-quantity {
                width: 60px; /* Kích thước ô nhập */
                text-align: center; /* Căn giữa nội dung */
                border: 1px solid #ccc; /* Viền nhẹ */
                border-radius: 4px; /* Bo góc */
                padding: 5px; /* Khoảng cách bên trong */
                font-size: 16px; /* Kích thước chữ */
                transition: border-color 0.3s; /* Hiệu ứng chuyển tiếp cho viền */
            }

            .product-quantity:focus {
                border-color: #4a90e2; /* Màu viền khi ô được chọn */
                outline: none; /* Bỏ viền mặc định khi chọn */
            }

            .update-btn {
                padding: 5px 12px; /* Khoảng cách bên trong */
                background-color: #4a90e2; /* Màu nền nút */
                color: white; /* Màu chữ */
                border: none; /* Bỏ viền */
                border-radius: 4px; /* Bo góc */
                cursor: pointer; /* Đổi con trỏ khi di chuột */
                transition: background-color 0.3s; /* Hiệu ứng chuyển tiếp cho màu nền */
            }

            .update-btn:hover {
                background-color: #357ab8; /* Màu nền khi di chuột qua */
            }

            .flex {
                gap: 10px; /* Khoảng cách giữa các phần tử */
            }
        </style>
        <script>

        </script>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container mx-auto p-6" style="margin-top: 100px">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold text-purple-800">YOUR PRODUCTS</h1>
<!--                <div class="flex-grow flex items-center justify-center mx-4">
                    <form action="search" method="GET" class="flex items-center">
                        <input type="text" name="query" placeholder="Search products..." class="border rounded-lg p-2 mr-4 w-80" />
                        <button type="submit" class="bg-purple-500 text-white px-4 py-2 rounded-lg hover:bg-purple-600">Search</button>
                    </form>
                </div>-->
                <a class="text-purple-500 flex items-center" href="home">
                    <i class="fas fa-home mr-2"></i> Home
                </a>
            </div>


            <div class="flex justify-center">
                <div class="w-full max-w-4xl bg-white p-6 rounded-lg shadow-md">
                    <div class="max-h-96 overflow-y-auto">
                        <c:if test="${empty requestScope.list}">
                            <p class="text-center text-red-500">Your cart is empty!</p>
                        </c:if>
                        <c:forEach items="${requestScope.list}" var="cart">
                            <jsp:useBean id="dao" class="dal.DAO" />
                            <c:set var="pro" value="${dao.getProductsByProID(cart.proID.proID)}" />
                            <c:set var="img" value="${dao.getMainImageForProduct(cart.proID.proID, true)}"/>
                            <c:set var="proid" value="${cart.proID.proID}" />

                            <div class="flex items-center justify-between border-b pb-4 mb-4">
                                <div class="flex items-center">
                                    <input class="product-checkbox" type="checkbox" data-price="${cart.proID.unitPrice}" data-number="${cart.totalQuantity}" name="selectedProducts" value="${cart.proID.proID}" />
                                    <img alt="Product Image" class="w-20 h-20 mr-4" src="${img.imgURL}" />
                                    <a href="productdetail?proID=${cart.proID.proID}">
                                        <div> 
                                            <h2 class="text-xl font-semibold text-purple-800">${cart.proID.proName}</h2>
                                            <p class="text-gray-500">Color: white</p>
                                        </div>
                                    </a>
                                </div>
                                <div class="flex items-center">
                                    <p class="text-xl font-semibold text-blue-600 mr-4 product-price">${cart.proID.unitPrice}$</p>
                                    <div class="flex items-center border rounded">
                                        <button class="decrease-btn px-2 text-gray-600" data-proid="${cart.proID.proID}" >-</button>
                                        <input class="w-10 text-center border-l border-r product-quantity" type="text" value="${cart.totalQuantity}" />
                                        <button class="increase-btn px-2 text-gray-600" data-proid="${cart.proID.proID}" >+</button>
                                    </div>
                                    <button class="ml-4 text-red-500" onclick="doDelete('${cart.proID.proID}')"> 
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>

                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="w-full max-w-4xl mx-auto bg-white p-6 rounded-lg shadow-md mt-6 sticky-bottom">
                <div class="flex justify-between items-center border-t pt-4">
                    <div class="flex items-center">
                        <label class="text-lg font-semibold text-purple-800" for="discount-code">Discount Code:</label>
                        <input class="ml-2 border rounded p-2" id="discount-code" placeholder="Enter code" type="text" />
                    </div>
                </div>
                <div class="flex justify-between items-center border-t pt-4">
                    <div class="flex items-center">
                        <input class="mr-2" id="select-all" type="checkbox" />
                        <label class="text-lg font-semibold text-purple-800" for="select-all">Select All</label>
                    </div>
                    <div class="flex items-center">
                        <div class="mr-8">
                            <p class="text-xl font-semibold text-purple-800">Total:</p>
                            <p class="text-sm text-gray-600" id="item-count">0 items</p>
                        </div>
                        <div class="mr-4">
                            <p class="text-xl font-semibold text-purple-800" id="total-price">0$</p>
                        </div>
                        <form id="checkout-form" action="checkout" method="POST">
                            <input type="hidden" id="selected-products" name="selectedProducts" value="" />
                            <button type="submit" class="bg-purple-500 text-white p-3 rounded-lg font-semibold">Checkout</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Xử lý nút tăng số lượng
            document.querySelectorAll(".increase-btn").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    var input = this.parentElement.querySelector(".product-quantity");
                    input.value = parseInt(input.value) + 1;
                    updateQuantity(input.dataset.proid, input.value);
                    calculateTotal();
                });
            });

            // Xử lý nút giảm số lượng
            document.querySelectorAll(".decrease-btn").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    var input = this.parentElement.querySelector(".product-quantity");
                    if (parseInt(input.value) > 1) {
                        input.value = parseInt(input.value) - 1;
                        updateQuantity(input.dataset.proid, input.value);
                        calculateTotal();
                    }
                });
            });

            // Hàm cập nhật số lượng sản phẩm
            function updateQuantity(proId, quantity) {
                fetch('updatecart?proID=' + proId + '&quantity=' + quantity, {
                    method: 'GET'
                }).then(response => {
                    if (response.ok) {
                        console.log('Quantity updated successfully');
                    } else {
                        console.error('Failed to update quantity');
                    }
                });
            }
            function doDelete(id) {
                if (confirm('Are you sure to delete id ' + id + '?')) {
                    window.location = 'deletecart?proID=' + id;
                }
            }

            function calculateTotal() {
                let subtotal = 0;
                let numPro = 0;
                const checkboxes = document.querySelectorAll('.product-checkbox:checked');

                checkboxes.forEach(checkbox => {

                    const price = parseFloat(checkbox.dataset.price);
                    const quantity = parseInt(checkbox.dataset.number);
                    subtotal += price * quantity;
                    numPro += 1;
                });

                let discountPercentage = 0;
                let discountAmount = 0;
                if (subtotal > 500000) {
                    discountPercentage = 10; // Giảm 10%
                } else if (subtotal > 200000) {
                    discountPercentage = 5; // Giảm 5%
                }

                discountAmount = (subtotal * discountPercentage) / 100; // Tính discount
                const total = subtotal - discountAmount; // Tính total

                // Cập nhật các giá trị vào HTML
                document.getElementById('total-price').innerText = '$' + subtotal.toFixed(2);
                document.getElementById('item-count').innerText = numPro + ' items';
//                document.getElementById('discount').innerText = discountPercentage + '%';
//                document.getElementById('save').innerText = '$' + discountAmount.toFixed(2);
            }

            // Gọi hàm tính tổng khi trang được tải
            window.onload = calculateTotal;


            // Thêm sự kiện cho checkbox
            document.querySelectorAll('.product-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', calculateTotal);
            });

            // Thêm sự kiện cho checkbox "Select All"
            document.getElementById('select-all').addEventListener('change', function () {
                const checkboxes = document.querySelectorAll('.product-checkbox');
                checkboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                });
                calculateTotal(); // Cập nhật tổng khi chọn/tắt chọn tất cả
            });
            // Update the hidden input before submitting the form
            document.getElementById('checkout-form').addEventListener('submit', function () {
                const selectedProducts = [];
                document.querySelectorAll('.product-checkbox:checked').forEach(checkbox => {
                    selectedProducts.push(checkbox.value);
                });
                document.getElementById('selected-products').value = selectedProducts.join(',');
            });
        </script>
    </body>
</html>



