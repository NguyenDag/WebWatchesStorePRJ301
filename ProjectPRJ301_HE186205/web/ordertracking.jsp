<%-- 
    Document   : ordertracking
    Created on : Nov 5, 2024, 1:18:39 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Order Tracking Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
        <style>
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.7);
            }
            .modal-content {
                background-color: #fefefe;
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px;
                border-radius: 8px;
            }
        </style>
        <script type="text/javascript">
            function updateOrderStatus(orderID, sttID) {
                // Tạo URL cho servlet statistic với các tham số
                const url = 'ordertracking?orderid=' + orderID + '&sttid=' + sttID;

                // Chuyển hướng đến URL mới
                window.location.href = url;
            }
        </script>
    </head>
    <body>
        <div class="bg-gray-100">
            <a class="text-purple-500 flex items-center" href="home">
                <i class="fas fa-arrow-left mr-2"></i>
                Back
            </a>
            <div class="container mx-auto p-4">
                <div class="flex">

                    <!-- Sidebar -->
                    <div class=" bg-white p-4 rounded shadow" style="width: 20%">
                        <div class="flex items-center mb-4">
                            <img alt="Profile picture" class="rounded-full w-12 h-12" src="${acc.avatar}" />
                            <div class="ml-4">
                                <p class="font-bold">${acc.username}</p>
                                <a class="text-gray-500 text-sm cursor-pointer" >
                                    <i class="fas fa-edit"></i>
                                    My Profile
                                </a>
                            </div>
                        </div>
                        <ul class="space-y-2">
                            <li class="flex items-center text-gray-600">
                                <a href="profile" class="flex items-center">
                                    <i class="fas fa-id-card mr-2"></i> Profile
                                </a>
                            </li>
                            <li class="flex items-center text-gray-600">
                                <a href="changepass" class="flex items-center">
                                    <i class="fas fa-lock mr-2"></i> Change Password
                                </a>
                            </li>
                            <li class="flex items-center text-red-500">
                                <a href="ordertracking" class="flex items-center">
                                    <i class="fas fa-truck mr-2"></i> Order Tracking
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Main Content -->
                    <div class="bg-white p-6 rounded shadow ml-4" style="width: 80%">
                        <h2 class="text-xl font-bold mb-4">Order Tracking</h2>
                        <p class="text-gray-600 mb-4">Track your orders below:</p>

                        <div class="grid grid-cols-1 gap-4">
                            <!-- Sample Order Row -->
                            <c:forEach items="${list}" var="o">
                                <div class="bg-gray-100 p-4 rounded shadow flex items-center justify-between">
                                    <div class="flex-1">
                                        <h3 class="font-bold">Order #111${o.orderID}</h3>
                                        <c:if test="${o.sttID.sttID == 1}"><p>Status: <span class="text-yellow-600">Pending</span></p></c:if>
                                        <c:if test="${o.sttID.sttID == 2}"><p>Status: <span class="text-green-600">Shipped</span></p></c:if>
                                        <c:if test="${o.sttID.sttID == 3}"><p>Status: <span class="text-blue-600">Delivered</span></p></c:if>
                                        <c:if test="${o.sttID.sttID == 4}"><p>Status: <span class="text-red-600">Cancelled</span></p></c:if>

                                        </div>
                                        <div class="flex-1 text-center">
                                            <p>Estimated Delivery: ${o.orderDate}</p>
                                    </div>
                                    <div class="flex-1 text-right">
                                        <c:if test="${o.sttID.sttID == 1}">
                                            <button class="order-update-button" style="margin-left: 10px" 
                                                    onclick="updateOrderStatus(${o.orderID}, ${o.sttID.sttID})">Cancel</button>
                                        </c:if>
                                        <c:if test="${o.sttID.sttID != 1}">
                                            <button class="order-update-button opacity-50 cursor-not-allowed" style="margin-left: 10px" disabled>
                                                Cancel
                                            </button>
                                        </c:if></div>
                                </div>
                            </c:forEach>

                            <!-- Repeat above block for more orders -->
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
