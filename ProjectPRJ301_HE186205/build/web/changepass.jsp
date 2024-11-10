<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Profile Page</title>
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
                            <li class="flex items-center text-red-500">
                                <a href="changepass" class="flex items-center">
                                    <i class="fas fa-lock mr-2"></i> Change Password
                                </a>
                            </li>
                            <li class="flex items-center text-gray-600">
                                <a href="ordertracking" class="flex items-center">
                                    <i class="fas fa-truck mr-2"></i> Order Tracking
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Main Content -->
                    <div class="bg-white p-6 rounded shadow ml-4" style="width: 80%">
                        <h2 class="text-xl font-bold mb-2">Change Password</h2>
                        <p class="text-gray-600 mb-4">Change your password to secure your account</p>
                        <form action="changepass" method="POST">
                            <div class="grid grid-cols-1 gap-4"> <!-- Adjusted grid to single column for inputs -->

                                <div>
                                    <label class="block text-gray-700">Old Password</label>
                                    <input name="oldPassword" type="password" class="w-full p-2 border rounded" placeholder="Enter your old password" required />
                                </div>
                                <div>
                                    <label class="block text-gray-700">New Password</label>
                                    <input name="newPassword" type="password" class="w-full p-2 border rounded" placeholder="Enter your new password" required />
                                </div>
                                <div>
                                    <label class="block text-gray-700">Confirm New Password</label>
                                    <input name="confirmPassword" type="password" class="w-full p-2 border rounded" placeholder="Confirm your new password" required />
                                </div>
                                <c:if test="${not empty errorMessage}">
                                    <div class="bg-red-100 text-red-700 p-4 rounded mb-4">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                            </div>
                            <div class="mt-4 flex justify-end">
                                <button class="bg-purple-500 text-white px-4 py-2 rounded" id="changePasswordBtn">Change Password</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

    </body>
</html>