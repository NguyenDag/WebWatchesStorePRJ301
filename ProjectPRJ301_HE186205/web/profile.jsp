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
                    <div class="w-1/4 bg-white p-4 rounded shadow">
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
                            <li class="flex items-center text-red-500">
                                <a href="profile" class="flex items-center">
                                    <i class="fas fa-id-card mr-2"></i> Profile
                                </a>
                            </li>
                            <li class="flex items-center text-gray-600 ">
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
                    <div class="w-3/4 bg-white p-6 rounded shadow ml-4">
                        <h2 class="text-xl font-bold mb-2">My Profile</h2>
                        <p class="text-gray-600 mb-4">Manage your profile information to secure your account</p>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-gray-700">Username</label>
                                <input class="w-full p-2 border rounded" disabled type="text" value="${acc.username}" />
                                <p class="text-gray-500 text-sm">Username can only be changed once.</p>
                            </div>
                            <div>
                                <label class="block text-gray-700">Name</label>
                                <p class="w-full p-2 border rounded bg-gray-200 text-gray-700">${acc.accname}</p>
                            </div>
                            <div>
                                <label class="block text-gray-700">Email</label>
                                <p class="w-full p-2 border rounded bg-gray-200 text-gray-700">${acc.cusEmail}</p>
                            </div>
                            <div>
                                <label class="block text-gray-700">Phone Number</label>
                                <p class="w-full p-2 border rounded bg-gray-200 text-gray-700">${acc.cusPhone}</p>
                            </div>
                            <div>
                                <label class="block text-gray-700">Address</label>
                                <p class="w-full p-2 border rounded bg-gray-200 text-gray-700">${acc.accAddress}</p>
                            </div>
                            <div>
                                <label class="block text-gray-700">Gender</label>
                                <p class="w-full p-2 border rounded bg-gray-200 text-gray-700">
                                    <span class="mr-2">${acc.gender}</span>
                                </p>
                            </div>
                        </div>
                        <div class="mt-4 flex justify-end">
                            <button class="bg-purple-500 text-white px-4 py-2 rounded" id="changeProfileBtn">Change Profile</button>
                        </div>
                    </div>

                    <!-- Profile Picture -->
                    <div class="w-1/4 bg-white p-6 rounded shadow ml-4">
                        <form action="upload" method="post" enctype="multipart/form-data">
                            <img alt="Profile picture" class="rounded-full w-24 h-24 mx-auto" src="${acc.avatar}" />
                            <input type="file" name="photo" placeholder="Enter photo"/>
                            <button type="submit" class="mt-4 bg-gray-200 text-gray-700 px-4 py-2 rounded w-full">Save</button>
                            <p class="text-gray-500 text-center mt-2">Maximum file size 1 MB</p>
                            <p class="text-gray-500 text-center">Formats: .JPEG, .PNG</p>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <form action="profile" method="POST">
            <div id="profileModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2 class="text-xl font-bold mb-2">Edit Profile</h2>
                    <div>
                        <label class="block text-gray-700">Name</label>
                        <input id="modalNameInput" class="w-full p-2 border rounded" type="text" value="${acc.accname}" name="fullname"/>
                    </div>
                    <input class="w-full p-2 border rounded" disabled type="hidden" value="${acc.username}" name="username"/>
                    <div>
                        <label class="block text-gray-700">Email</label>
                        <input id="modalEmailInput" class="w-full p-2 border rounded" type="email" value="${acc.cusEmail}" name="email"/>
                    </div>
                    <div>
                        <label class="block text-gray-700">Phone Number</label>
                        <input id="modalPhoneInput" class="w-full p-2 border rounded" type="text" value="${acc.cusPhone}" name="phone"/>
                    </div>
                    <div>
                        <label class="block text-gray-700">Address</label>
                        <input id="modalAddressInput" class="w-full p-2 border rounded" type="text" value="${acc.accAddress}" name="address"/>
                    </div>
                    <!--        <div>
                                <label class="block text-gray-700">Gender</label>
                                <div class="flex items-center space-x-4">
                                    <label class="flex items-center"><input id="modalGenderMale" class="mr-2" name="modalGender" type="radio" value="male" /> Male</label>
                                    <label class="flex items-center"><input id="modalGenderFemale" class="mr-2" name="modalGender" type="radio" value="female" /> Female</label>
                                    <label class="flex items-center"><input id="modalGenderOther" class="mr-2" name="modalGender" type="radio" value="other" /> Other</label>
                                </div>
                            </div>-->
                    <button class="mt-4 bg-red-500 text-white px-4 py-2 rounded" id="saveProfileBtn">Save</button>
                </div>
            </div>
        </form>
        <script>
            // Get modal elements
            var modal = document.getElementById("profileModal");
            var changeProfileBtn = document.getElementById("changeProfileBtn");
            var closeModal = document.getElementsByClassName("close")[0];

            // Open modal on button click
            changeProfileBtn.onclick = function () {
                modal.style.display = "block";
                // Populate modal fields with current values
                document.getElementById("modalNameInput").value = document.getElementById("nameInput").value;
                document.getElementById("modalEmailInput").value = document.getElementById("emailInput").value;
                document.getElementById("modalPhoneInput").value = document.getElementById("phoneInput").value;
                document.getElementById("modalAddressInput").value = document.getElementById("addressInput").value;
            };

            // Close modal when the close button is clicked
            closeModal.onclick = function () {
                modal.style.display = "none";
            };

            // Close modal when clicking outside of the modal content
            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };

            // Save profile updates
            document.getElementById("saveProfileBtn").onclick = function () {
                // Save the data (this is where you'd make an API call in a real application)
                document.getElementById("nameInput").value = document.getElementById("modalNameInput").value;
                document.getElementById("emailInput").value = document.getElementById("modalEmailInput").value;
                document.getElementById("phoneInput").value = document.getElementById("modalPhoneInput").value;
                document.getElementById("addressInput").value = document.getElementById("modalAddressInput").value;

                // Close the modal
                modal.style.display = "none";
            };
        </script>
    </body>
</html>