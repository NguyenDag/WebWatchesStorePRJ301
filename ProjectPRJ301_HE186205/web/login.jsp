<%-- 
    Document   : login
    Created on : Oct 4, 2024, 5:36:24 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Form</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                height: 100vh;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .row{
                display: flex;
            }
            .col-md-6 {
                display: flex;
                flex-direction: column;
            }
            .login-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .login-container h2 {
                margin: 0 0 20px;
                text-align: center;
            }
            .login-container label {
                display: block;
                margin-bottom: 5px;
            }
            .login-container input[type="text"],
            .login-container input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .login-container input[type="checkbox"] {
                margin-right: 10px;
            }
            .login-container .remember-me {
                display: flex;
                align-items: center;
            }
            .login-container .forgot-password {
                text-align: right;
                display: block;
                margin-bottom: 20px;
            }
            .login-container button {
                width: 100%;
                padding: 10px;
                background-color: #ff4b5c;
                border: none;
                border-radius: 4px;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
            }
            .login-container button:hover {
                background-color: #ff1f3a;
            }
            .image-background img {
                width: 100%;
                height: auto;
                border-radius: 8px;
            }


            .container.right-panel-active .overlay-left {
                transform: translateX(0);
            }

            .overlay-right {
                right: 0;
                transform: translateX(0);
            }

            .container.right-panel-active .overlay-right {
                transform: translateX(20%);
            }

            .social-container {
                margin: 20px 0;
                display: flex;
                justify-content: center;
            }

            .social-container a {
                border: 1px solid #DDDDDD;
                border-radius: 50%;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                margin: 0 5px;
                height: 40px;
                width: 40px;
            }
            #register {
                display: inline-block; /* Thay đổi để nút có thể căn giữa */
                padding: 10px 20px; /* Thêm padding cho nút */
                background-color: green; /* Màu nền cho nút */
                border: none;
                border-radius: 4px;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
                text-align: center; /* Canh giữa chữ trong nút */
                text-decoration: none; /* Xóa gạch chân */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu */
            }

            #register:hover {
                background-color: darkgreen; /* Màu khi hover */
            }

            .register-container {
                text-align: center; /* Canh giữa nội dung */
                margin-top: 20px; /* Khoảng cách trên */
            }
            .back-button {
                position: absolute;
                top: 20px;
                left: 20px;
                background-color: transparent;
                border: none;
                color: #007bff;
                font-size: 16px;
                cursor: pointer;
                text-decoration: underline;
            }

            .back-button:hover {
                color: #0056b3; /* Màu khi hover */
            }
        </style>
    </head>
    <body>
        <div class="container">

            <div class="row justify-content-center align-items-center" style="height: 100vh;">

                <div class="col-md-6">
                    <div class="login-container">
                        <div class="mb-4">
                            <a class="text-purple-500 flex items-center" href="home" style="text-decoration: none">
                                <i class="fas fa-arrow-left mr-2"></i>
                                Back
                            </a>
                        </div>
                        <h2>Log In</h2>
                        <c:set var="cookies" value="${pageContext.request.cookies}" />
                        <form action="login" method="post">
                            <div class="social-container">
                                <a href="#" class="social"><i class="fa-brands fa-facebook-f"></i></a>
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/project/LoginGoogleHandler&response_type=code
		   &client_id=812911348456-534fm3coqu1u85q0grt9r6q0qovk81uh.apps.googleusercontent.com&approval_prompt=force" class="social"><i class="fab fa-google-plus-g"></i></a>
                                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                            </div>
                            <h5 style="text-align: center">Or use your account</h5>
                            <h5 style="color: red">${requestScope.error}</h5>
                            <label for="username">UserName</label>
                            <input type="text" id="username" name="username"
                                   value="${cookie.cuser.value}" required>

                            <label for="password">Password</label>
                            <input type="password" id="password" name="password"
                                   value="${cookie.cpass.value}" required>

                            <div class="remember-me">
                                <input type="checkbox" ${(cookie.crem!=null?'checked':'')} id="remember" name="remember" value="ON">
                                <label for="remember">Remember me</label>
                            </div>

                            <!--<a href="#" class="forgot-password">Forgot Password</a>-->

                            <button type="submit">Log in</button>

                        </form>
                        <hr/><!-- comment -->
                        <div class="register-container">
                            <a href="register.jsp" id="register">Create new account</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="image-background">
                        <img src="images/a-1.jpg" alt="loi anh"/>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
