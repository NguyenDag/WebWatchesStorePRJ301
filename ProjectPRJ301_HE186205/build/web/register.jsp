<%-- 
    Document   : register
    Created on : Oct 18, 2024, 3:55:59 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
        <style>
            .profile-card {
                background-image: url('https://wallpapercave.com/wp/wp1853754.png');
                background-size: cover;
                background-position: center;
                position: relative;
                color: white;
            }

            .profile-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.5);
                border-radius: 0.5rem;
            }

            .profile-card-content {
                position: relative;
                z-index: 1;
            }
        </style>
    </head>
    <body>
        <div style="width: 80%; margin: 0 auto; padding: 20px; border: 1px solid #ccc">


            <div class="container mx-auto p-4">
                <!-- Back Button -->
                <div class="mb-4">
                    <a class="text-purple-500 flex items-center" href="login.jsp">
                        <i class="fas fa-arrow-left mr-2"></i>
                        Back
                    </a>
                </div>
                <div class="flex flex-col md:flex-row md:space-x-4">
                    <!-- Profile Card -->
                    <div class="profile-card bg-white p-6 rounded-lg shadow-md w-full md:w-1/3">
                        <div class="profile-card-content">
                            <h2 class="text-xl font-semibold mb-4">Watch Store</h2>
                            <!-- Optionally include an image here if needed -->
                        </div>
                    </div>
                    <!-- Profile Form -->
                    <div class="bg-white p-6 rounded-lg shadow-md w-full md:w-2/3">
                        <form action="register" method="post">
                            <h2 class="text-3xl font-bold text-center mb-4">Register</h2> <!-- Centered Login Title -->
                            <c:if test="${not empty error}">
                                <div class="bg-red-100 text-red-700 p-4 rounded mb-4">
                                    ${error}
                                </div>
                            </c:if>
                            <h2 class="text-xl font-semibold mb-4">Full Name</h2>
                            <input class="border border-gray-300 p-1 w-full mb-4" type="text" name="fullname" value="${fullname != null ? fullname : ''}"/>
                            <h2 class="text-xl font-semibold mb-4">Email</h2>
                            <input class="border border-gray-300 p-1 w-full mb-4" type="email" name="email" value="${email != null ? email : ''}"/>
                            <div class="flex items-center mb-4">
                                <div class="w-1/2 pr-2">
                                    <h2 class="text-xl font-semibold mb-4">Phone</h2>
                                    <input class="border border-gray-300 p-1 w-full" type="text" name="phone" value="${phone != null ? phone : ''}"/>
                                </div>
                                <div class="w-1/2 pl-2">
                                    <h2 class="text-xl font-semibold mb-4">Gender</h2>
                                    <select name="gender" class="border border-gray-300 p-1 w-full">
                                        <option value="male" ${gender != null && gender == 'male' ? 'selected' : ''}>Male</option>
                                        <option value="female" ${gender != null && gender == 'female' ? 'selected' : ''}>Female</option>
                                        <option value="other" ${gender != null && gender == 'other' ? 'selected' : ''}>Others</option>
                                    </select>
                                </div>
                            </div>
                            <h2 class="text-xl font-semibold mb-4">Address</h2>
                            <input class="border border-gray-300 p-1 w-full mb-4" type="text" name="address" value="${address != null ? address : ''}"/>
                            <h2 class="text-xl font-semibold mb-4">Username</h2>
                            <input class="border border-gray-300 p-1 w-full mb-4" type="text" name="username" value="${username != null ? username : ''}"/>
                            <h2 class="text-xl font-semibold mb-4">Password</h2>
                            <input class="border border-gray-300 p-1 w-full mb-4" type="password" name="password"/>
                            <h2 class="text-xl font-semibold mb-4">Confirm Password</h2>
                            <input class="border border-gray-300 p-1 w-full mb-4" type="password" name="cpassword"/>

                            <!-- Buttons -->
                            <div class="flex justify-center mt-4">
                                <button type="submit" class="bg-purple-500 text-white px-4 py-2 rounded">Register</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
