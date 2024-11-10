<%-- 
    Document   : productmanager
    Created on : Oct 24, 2024, 2:34:27 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Supplier" %>
<%@page import="model.Category" %>
<%@page import="dal.DAO" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Management</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .modal {
                display: none; /* Ẩn modal mặc định */
                position: fixed;
                z-index: 50;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.7); /* Mờ nền với độ trong suốt cao hơn */
            }
            .modal-content {
                background-color: #fefefe;
                margin: 1% auto; /* Giảm khoảng cách từ trên xuống */
                padding: 20px;
                border: 1px solid #888;
                border-radius: 8px; /* Bo góc cho modal */
                width: 90%; /* Chiều rộng modal */
                max-width: 600px; /* Chiều rộng tối đa */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng cho modal */
            }

            .modal-content h2 {
                margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
            }

            .modal-content label {
                font-weight: bold; /* In đậm nhãn */
                margin-bottom: 5px; /* Khoảng cách dưới nhãn */
            }

            .modal-content input,
            .modal-content select {
                border: 1px solid #ccc; /* Đường viền nhẹ cho trường nhập */
                border-radius: 4px; /* Bo góc cho trường nhập */
                padding: 10px; /* Khoảng cách bên trong */
                width: 100%; /* Đảm bảo trường nhập đầy đủ chiều rộng */
                box-sizing: border-box; /* Bao gồm padding và border trong chiều rộng */
            }

            .modal-content button {
                width: 100%; /* Đặt chiều rộng nút 100% */
                padding: 10px; /* Khoảng cách bên trong nút */
                border-radius: 4px; /* Bo góc cho nút */
                margin-top: 10px; /* Khoảng cách trên nút */
            }

            .modal-content .close {
                cursor: pointer; /* Con trỏ cho nút đóng */
                font-size: 20px; /* Kích thước chữ cho nút đóng */
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container mx-auto p-4" style="margin-top: 110px">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-bold mb-4 text-purple-700">Account Management Table</h2>
                
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full bg-white rounded-lg shadow-md">
                    <thead>
                        <tr class="bg-purple-200 text-purple-700 uppercase text-sm leading-normal">
                            <th class="py-3 px-6 text-left">Account ID</th>
                            <th class="py-3 px-6 text-left">Username</th>
                            <th class="py-3 px-6 text-left">Name</th>
                            <th class="py-3 px-6 text-left">Address</th>
                            <th class="py-3 px-6 text-left">Phone</th>
                            <th class="py-3 px-6 text-left">Email</th>
                            <th class="py-3 px-6 text-left">Gender</th>
                            <th class="py-3 px-6 text-left">Role</th>
                            <th class="py-3 px-6 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 text-sm font-light">

                        <c:forEach items="${list}" var="acc">
                            <tr class="border-b border-gray-200 hover:bg-purple-100">
                                <td class="py-3 px-6 text-left whitespace-nowrap">${acc.accID}</td>
                                <td class="py-3 px-6 text-left">${acc.username}</td>
                                <td class="py-3 px-6 text-left">${acc.accname}</td>
                                <td class="py-3 px-6 text-left">${acc.accAddress}</td>
                                <td class="py-3 px-6 text-left">${acc.cusPhone}</td>
                                <td class="py-3 px-6 text-left">${acc.cusEmail}</td>
                                <td class="py-3 px-6 text-left">${acc.gender}</td>
                                <td class="py-3 px-6 text-left">${acc.role == false ? 'Admin' : 'User'}</td>
                                <td class="py-3 px-6 text-left">
                                    <div class="flex space-x-2">
                                        <a href="addtoadmin?accID=${acc.accID}" class="bg-purple-500 text-white px-3 py-1 rounded-md hover:bg-purple-600">
                                            To Admin
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </body>
</html>
