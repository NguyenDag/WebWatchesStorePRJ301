<%-- 
    Document   : checkout
    Created on : Oct 22, 2024, 11:07:28 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.ImageProduct" %>
<%@page import="model.CartTotal" %>
<%@page import="dal.DAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        <script src="https://cdn.tailwindcss.com">
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
        <style>
            .product-container {
                width: 500px; /* Set a fixed width for the container */
                overflow: hidden; /* Hide overflow content */
                white-space: nowrap; /* Prevent text from wrapping to the next line */
                text-overflow: ellipsis; /* Add ellipsis (...) for overflowed text */
            }

            .product-name {
                font-size: 16px; /* Adjust font size as needed */
                color: #333; /* Set text color */
            }
        </style>
        <script>

            function calculateTotal() {
                let total = 0;
                const items = document.querySelectorAll('.product-item');
                items.forEach(item => {
                    const price = parseFloat(item.dataset.price);
                    const quantity = parseInt(item.dataset.number);
                    total += price * quantity;
                });
                document.getElementById('total-price').innerText = total.toFixed(2) + '$';
                // Cập nhật giá trị cho trường ẩn totalPrice
                document.getElementById('totalPrice').value = total.toFixed(2);
            }

            document.addEventListener('DOMContentLoaded', calculateTotal);
            function updateShipID() {
                // Lấy giá trị của phương thức vận chuyển được chọn
                const shipID = document.getElementById('shipping').value;
                // Cập nhật giá trị vào trường ẩn
                document.getElementById('shipIDvalue').value = shipID;
            }

            // Gọi hàm này một lần để thiết lập giá trị ban đầu khi trang được tải
            document.addEventListener('DOMContentLoaded', function () {
                updateShipID(); // Để đảm bảo giá trị ban đầu được thiết lập
            });
        </script>
    </head>
    <body>
        <div class="container mx-auto p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold text-purple-800">
                    INVOICE
                </h1>
                <a class="text-purple-500 flex items-center" href="cart">
                    <i class="fas fa-arrow-left mr-2"></i>
                    Back
                </a>
            </div>
            <div id="main-content">
                <div class="flex justify-center">
                    <div class="w-full max-w-4xl bg-white p-6 rounded-lg shadow-md">
                        <div class="max-h-96 overflow-y-auto">
                            <c:forEach items="${requestScope.list}" var="cart">
                                <jsp:useBean id="dao" class="dal.DAO"/>   
                                <c:set var="img" value="${dao.getMainImageForProduct(cart.proID.proID, true)}"/>
                                <div class="flex items-center justify-between border-b pb-4 mb-4 product-item" data-price="${cart.proID.unitPrice}" data-number="${cart.totalQuantity}">
                                    <div class="flex items-center">
                                        <img alt="Samsung Galaxy M11 64GB" class="w-20 h-20 mr-4" height="100"
                                             src="${img.imgURL}"
                                             width="100" />
                                        <div class="product-container">
                                            <h2 class="text-xl font-semibold text-purple-800 product-name">
                                                ${cart.proID.proName}
                                            </h2>
                                            <p class="text-gray-500">
                                                Color: white
                                            </p>
                                        </div>
                                    </div>
                                    <div class="flex items-center">
                                        <p class="text-xl font-semibold text-blue-600 mr-4 product-price">
                                            ${cart.proID.unitPrice}$
                                        </p>
                                        <div style="width: 85px;">
                                            <p class="text-gray-700">Quantity: ${cart.totalQuantity}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="w-full max-w-4xl mx-auto bg-white p-6 rounded-lg shadow-md mt-6">
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="name">
                            Recipient Name:
                        </label>
                        <input class="w-full border rounded p-2" id="name" placeholder="Enter recipient name" type="text"
                               value="${account.accname}" />
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="address">
                            Address:
                        </label>
                        <input class="w-full border rounded p-2" id="address" placeholder="Enter address" type="text"
                               value="${account.accAddress}" />
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="phone">
                            Phone Number:
                        </label>
                        <input class="w-full border rounded p-2" id="phone" placeholder="Enter phone number" type="text"
                               value="${account.cusPhone}" />
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="shipping">
                            Shipping Method:
                        </label>
                        <select class="w-full border rounded p-2" id="shipping" name="shipID" onchange="updateShipID()" >
                            <c:forEach items="${requestScope.ships}" var="ship">
                                <option value="${ship.shipID}"> 
                                    ${ship.shipMethod} 
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="message">
                            Message to Shop:
                        </label>
                        <textarea class="w-full border rounded p-2" id="message"
                                  placeholder="Enter your message"></textarea>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="payment">
                            Payment Method:
                        </label>
                        <select class="w-full border rounded p-2" id="payment" name="payment">
                            <option value="credit-card">
                                Credit Card
                            </option>
                            <option value="paypal">
                                PayPal
                            </option>
                            <option value="cod">
                                Cash on Delivery
                            </option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="discount-code">
                            Discount Code:
                        </label>
                        <button class="w-full border rounded p-2 text-left" id="discount-code"
                                onclick="showDiscountModal()">
                            Select Discount Code
                        </button>
                    </div>
                    <div class="flex justify-end items-center border-t pt-4">
                        <!--                        <div class="flex items-center">
                                                    <p class="text-xl font-semibold text-purple-800">Total:</p>
                                                    <p class="text-sm text-gray-600 ml-2" id="item-count">4 items</p>
                                                </div>-->
                        <div class="flex flex-col items-end">
<!--                            <div class="flex flex-col items-end mb-2">
                                <p class="text-sm text-gray-600" style="font-size: 1rem;">Discount: <span id="discount-percentage" class="font-semibold text-purple-600">0%</span></p>
                                <p class="text-sm text-gray-600" style="font-size: 1rem;">Shipping: <span id="shipping-cost" class="font-semibold text-purple-600">20$</span></p>
                            </div>-->
                            <div class="flex items-center mt-2"> <!-- Added margin-top here -->

                                <!--chinh phan nay de khi bấm pay now sẽ chuyển về trang bill và thông tin sản phẩm được lưu vào bảng historyOrder-->
                                <form id="checkout-form" action="bill" method="POST">
                                    <input type="hidden" name="recipientName" id="recipientName" value="${account.accname}">
                                    <input type="hidden" name="address" id="address" value="${account.accAddress}">
                                    <input type="hidden" name="phone" id="phone" value="${account.cusPhone}">
                                    <!--total price ch lay value-->
                                    <input type="hidden" name="totalPrice" id="totalPrice" >
                                    <input type="hidden" name="message" id="message" value="">
                                    <input type="hidden" name="payment" value="${param.payment}"> 
                                    <input type="hidden" name="shipIDvalue" id="shipIDvalue" value="">
                                    <!-- Thông tin sản phẩm -->
                                    <c:forEach items="${requestScope.list}" var="cart" varStatus="status">
                                        <input type="hidden" name="productID_${status.index}" value="${cart.proID.proID}">
                                        <input type="hidden" name="productName_${status.index}" value="${cart.proID.proName}">
                                        <input type="hidden" name="productPrice_${status.index}" value="${cart.proID.unitPrice}">
                                        <input type="hidden" name="productQuantity_${status.index}" value="${cart.totalQuantity}">
                                    </c:forEach>

                                    <div class="flex justify-end items-center border-t pt-4">
                                        <div class="flex flex-col items-end">
                                            <div class="flex flex-col items-end mb-2">
                                                <p class="text-sm text-gray-600" style="font-size: 1rem;">Discount: <span id="discount-percentage" class="font-semibold text-purple-600">15%</span></p>
                                                <p class="text-sm text-gray-600" style="font-size: 1rem;">Shipping: <span id="shipping-cost" class="font-semibold text-purple-600">20$</span></p>
                                            </div>
                                            <div class="flex items-center mt-2">
                                                <p class="text-xl font-semibold text-purple-800 mr-4" id="total-price">2261$</p>
                                                <button type="submit" class="bg-purple-500 text-white p-3 rounded-lg font-semibold transition duration-300 hover:bg-purple-600">Pay Now</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden" id="discount-modal">
                <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
                    <h2 class="text-2xl font-bold text-purple-800 mb-4">
                        Available Discount Codes
                    </h2>
                    <ul>
                        <li class="mb-2">
                            <button class="w-full text-left p-2 border rounded hover:bg-gray-100"
                                    onclick="hideDiscountModal(); document.getElementById('discount-code').innerText = 'DISCOUNT10 - 10% off';">
                                DISCOUNT10 - 10% off
                            </button>
                        </li>
                        <li class="mb-2">
                            <button class="w-full text-left p-2 border rounded hover:bg-gray-100"
                                    onclick="hideDiscountModal(); document.getElementById('discount-code').innerText = 'FREESHIP - Free Shipping';">
                                FREESHIP - Free Shipping
                            </button>
                        </li>
                        <li class="mb-2">
                            <button class="w-full text-left p-2 border rounded hover:bg-gray-100"
                                    onclick="hideDiscountModal(); document.getElementById('discount-code').innerText = 'SAVE20 - $20 off';">
                                SAVE20 - $20 off
                            </button>
                        </li>
                    </ul>
                    <button class="mt-4 bg-purple-500 text-white p-2 rounded" onclick="hideDiscountModal()">
                        Close
                    </button>
                </div>
            </div>
        </div>
    </body>
</html>
