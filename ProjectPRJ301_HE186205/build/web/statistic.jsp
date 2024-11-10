<%-- 
    Document   : home.jsp
    Created on : Nov 6, 2024, 2:09:15 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Statistics Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }

            .container {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }

            .box {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                text-align: center;
                border: 2px solid #6f42c1;
                transition: transform 0.2s;
            }

            .box:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }

            h1 {
                color: #6f42c1;
                text-align: center;
                margin-bottom: 20px;
            }

            select {
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #6f42c1;
                margin-top: 10px;
            }

            canvas {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .chart-container {
                grid-column: span 3;
                /* Biểu đồ chiếm 3 cột */
            }

            .data-container {
                grid-column: span 1;
                /* Thống kê chiếm 1 cột */
            }

            .charts {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }

            @media (max-width: 768px) {
                .container {
                    grid-template-columns: 1fr;
                }

                .chart-container {
                    grid-column: span 1;
                }

                .data-container {
                    grid-column: span 1;
                }

                .charts {
                    grid-template-columns: 1fr;
                }
            }
            .box h2 {
                color: #6f42c1;
                margin-bottom: 15px;
            }

            .box label {
                margin-right: 10px;
                font-weight: bold;
            }

            .box select {
                margin: 10px 0;
            }

            .top-product {
                background-color: #f8f9fa; /* Light background for top products */
                border: 1px solid #6f42c1; /* Border color */
                border-radius: 5px;
                padding: 10px;
                margin: 5px 0;
                text-align: left; /* Align text to the left */
            }

            .top-product p {
                margin: 0; /* Remove default margin */
                font-size: 1.1em; /* Slightly larger font size */
            }

            .top-product:nth-child(odd) {
                background-color: #e9ecef; /* Alternate background color for odd items */
            }
            .top-product-text {
                font-size: 1.2em; /* Increase font size */
                font-weight: bold; /* Make font bold */
                color: #6f42c1; /* Change to a standout color */
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2); /* Optional: add a subtle shadow for depth */
            }
            .statistic-text {
                font-size: 1.4em; /* Increase font size */
                font-weight: bold; /* Make the font bold */
                color: #007bff; /* Use a bright color for visibility */
                padding: 10px; /* Add padding for spacing */
                text-align: center; /* Center align text */
                display: block; /* Ensure it takes full width */
                border-bottom: 2px solid #e9ecef; /* Optional: add a bottom border for separation */
                margin-bottom: 10px; /* Space between boxes */
                transition: color 0.3s; /* Smooth color transition on hover */
            }

            .statistic-text:hover {
                color: #0056b3; /* Change color on hover for interactivity */
            }

            .order-management-container {
                background-color: #f8f8f8;
                border-radius: 0.5rem;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                padding: 1.5rem;
                margin-top: 2rem;
            }

            .order-management-container h2 {
                color: #6f42c1;
                margin-bottom: 1rem;
            }

            .order-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #fff;
                border-radius: 0.5rem;
                box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.06), 0 1px 2px -1px rgba(0, 0, 0, 0.06);
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .order-info {
                flex: 1;
            }

            .order-info h3 {
                font-size: 1.125rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
            }

            .order-status {
                font-weight: medium;
            }

            .estimated-delivery,
            .order-reason {
                color: #6b7280;
            }

            .order-actions {
                display: flex;
                align-items: center;
            }

            .order-status-select {
                border: 1px solid #6b7280;
                border-radius: 0.25rem;
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
                color: #6b7280;
                margin-right: 1rem;
            }

            .order-update-button {
                background-color: #6f42c1;
                color: #fff;
                border: none;
                border-radius: 0.2rem;
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .order-update-button:hover {
                background-color: #4c1487;
            }

            .order-status-display {
                display: inline-block; /* Đảm bảo nó là một khối nội tuyến */
                padding: 8px 12px; /* Thêm padding để tạo khoảng cách cho nội dung */
                font-weight: bold; /* Làm cho chữ đậm hơn */
                color: #fff; /* Đổi màu chữ thành trắng */
                text-align: center; /* Canh giữa chữ */
                transition: background-color 0.3s ease, transform 0.2s ease; /* Hiệu ứng chuyển tiếp */
            }

            .order-status-display.text-green-600 {
                background-color: #38a169; /* Màu nền cho trạng thái 'Shipped' */
            }

            .order-status-display.text-yellow-600 {
                background-color: #f6e05e; /* Màu nền cho trạng thái 'In Transit' */
                color: #000; /* Chữ màu đen cho dễ đọc */
            }

            .order-status-display.text-red-600 {
                background-color: #e53e3e; /* Màu nền cho trạng thái 'Cancelled' */
            }

            /* Hiệu ứng hover */
            .order-status-display:hover {
                transform: scale(1.05); /* Phóng to một chút khi hover */
            }

        </style>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script type="text/javascript">
            function updateOrderStatus(orderID, sttID) {
                // Tạo URL cho servlet statistic với các tham số
                const url = 'statistic?orderid=' + orderID + '&sttid=' + sttID;

                // Chuyển hướng đến URL mới
                window.location.href = url;
            }

            function retainSelection() {
                // Giữ lại giá trị đã chọn cho năm
                var selectedYear = "<%= request.getParameter("year") != null ? request.getParameter("year") : "0" %>";
                document.getElementById("topProductsYear").value = selectedYear;

                // Giữ lại giá trị đã chọn cho tháng
                var selectedMonth = "<%= request.getParameter("month") != null ? request.getParameter("month") : "0" %>";
                document.getElementById("topProductsMonth").value = selectedMonth;
            }
            // Gọi hàm retainSelection khi trang được tải
            window.onload = retainSelection;
        </script>
    </head>
    <body>
        <a class="text-purple-500 flex items-center" href="home">
            <i class="fas fa-arrow-left mr-2" style="text-decoration: none"></i>
            Back
        </a>
        <h1>Statistics Dashboard</h1>

        <div class="container">

            <div class="chart-container">
                <h2>Select a time frame to view sales and profit charts</h2>
                <select id="timeFrame">
                    <option value="year">By Year</option>
                    <option value="month">By Month</option>
                </select>
                <div class="charts" style="margin-top: 20px;">
                    <canvas id="salesChart"></canvas>
                    <canvas id="productsChart"></canvas>
                </div>
            </div>
            <div class="data-container">
                <div class="box">
                    <span class="statistic-text">Total Revenue: ${revenue} $</span>
                </div>
                <div class="box">
                    <span class="statistic-text">Total Profit: ${revenue * 40 / 100} $</span>
                </div>
                <div class="box">
                    <span class="statistic-text">Number of Users: ${numAcc}</span>
                </div>
                <div class="box">
                    <h2>Top Selling Products</h2>
                    <form id="topProductsForm" action="statistic" method="GET">
                        <label for="topProductsYear">Select Year:</label>
                        <select id="topProductsYear" name="year">
                            <option value="0">All</option>
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                        </select>
                        <br/>
                        <label for="topProductsMonth">Select Month:</label>
                        <select id="topProductsMonth" name="month">
                            <option value="0">All</option>
                            <option value="1">January</option>
                            <option value="2">February</option>
                            <option value="3">March</option>
                            <option value="4">April</option>
                            <option value="5">May</option>
                            <option value="6">June</option>
                            <option value="7">July</option>
                            <option value="8">August</option>
                            <option value="9">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                        <br/>

                        <input type="submit" id="getTopProducts" value="Search" />

                    </form>
                    <c:forEach items="${list1}" var="t" varStatus="i">
                        <div class="top-product">
                            <span class="top-product-text">Top ${i.index + 1}: ${t.proName}</span>
                        </div>
                    </c:forEach>
                </div>

            </div>
        </div>

        <div class="order-management-container">
            <h2 class="font-bold">Order Management</h2>
            <p class="text-gray-600">View and manage your orders below:</p>

            <c:forEach items="${listOrders}" var="ls">
                <div class="order-row">
                    <div class="order-info">
                        <h3>Order #111${ls.orderID}</h3>
                        <p>Status: <span class="text-yellow-600">${ls.sttID.sttDescription}</span></p>
                        <p class="estimated-delivery">Estimated Delivery: ${ls.orderDate}</p>
                    </div>
                    <div class="order-actions">
                        <span class="order-status-display text-green-600" >${ls.sttID.sttName}</span>
                        <button class="order-update-button" style="margin-left: 10px" onclick="updateOrderStatus(${ls.orderID}, ${ls.sttID.sttID})">Update</button>
                    </div>
                </div>
            </c:forEach>

            <!-- Repeat above block for more orders -->
        </div>

        <script type="text/javascript">
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            const productsCtx = document.getElementById('productsChart').getContext('2d');
            let salesChart, productsChart;

            const dataYearSales = {
                labels: ['2020', '2021', '2022', '2023', '2024'],
                datasets: [
                    {
                        label: 'Revenue',
                        data: [${requestScope.revenue2020}, ${revenue2021}, ${revenue2022}, ${revenue2023}, ${revenue2024}],
                        backgroundColor: 'rgba(75, 192, 192, 0.5)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1,
                        type: 'bar'
                    },
                    {
                        label: 'Profit',
                        data: [${revenue2020*40/100}, ${revenue2021*40/100}, ${revenue2022*35/100}, ${revenue2023*38/100}, ${revenue2024*40/100}],
                        backgroundColor: 'rgba(255, 99, 132, 0.5)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1,
                        type: 'bar'
                    }
                ]
            };

            const dataMonthSales = {
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                datasets: [
                    {
                        label: 'Revenue',
                        data: [${revenue01}, ${revenue02}, ${revenue03}, ${revenue04}, ${revenue05},${revenue06},${revenue07},${revenue08},${revenue09},${revenue10},${revenue11},${revenue12}],
                        backgroundColor: 'rgba(153, 102, 255, 0.5)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1,
                        type: 'bar'
                    },
                    {
                        label: 'Profit',
                        data: [${revenue01*20/100}, ${revenue02*30/100}, ${revenue03*40/100}, ${revenue04*33/100}, ${revenue05*40/100},${revenue06*25/100},${revenue07*20/100},${revenue08*24/100},${revenue09*38/100},${revenue10*44/100},${revenue11*26/100},${revenue12*34/100}],
                        backgroundColor: 'rgba(255, 206, 86, 0.5)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1,
                        type: 'bar'
                    }
                ]
            };

            // Dữ liệu cho số đơn hàng theo năm
            const dataYearOrders = {
                labels: ['2020', '2021', '2022', '2023', '2024'],
                datasets: [{
                        label: 'Number of Orders',
                        data: [${numOrder2020}, ${numOrder2021}, ${numOrder2022}, ${numOrder2023}, ${numOrder2024}], // Thay đổi với biến số đơn hàng tương ứng
                        backgroundColor: 'rgba(255, 159, 64, 0.5)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1
                    }]
            };

            // Dữ liệu cho số đơn hàng theo tháng
            const dataMonthOrders = {
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                datasets: [{
                        label: 'Number of Orders',
                        data: [${numOrder01}, ${numOrder02}, ${numOrder03}, ${numOrder04}, ${numOrder05}, ${numOrder06}, ${numOrder07}, ${numOrder08}, ${numOrder09}, ${numOrder10}, ${numOrder11}, ${numOrder12}], // Thay đổi với biến số đơn hàng tương ứng
                        backgroundColor: 'rgba(75, 192, 192, 0.5)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
            };

            const optionsSales = {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            };

            const optionsProducts = {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            };

//            let currentOrdersData = dataYearOrders;
            function updateCharts(timeFrame) {
                if (salesChart) {
                    salesChart.destroy(); // Hủy biểu đồ cũ
                }
                // Cập nhật biểu đồ sản phẩm
                if (productsChart) {
                    productsChart.destroy(); // Hủy biểu đồ sản phẩm cũ
                }

                let salesData, productsData;
                if (timeFrame === 'year') {
                    salesData = dataYearSales;
                    productsData = dataYearOrders;
                } else if (timeFrame === 'month') {
                    salesData = dataMonthSales;
                    productsData = dataMonthOrders;
                }

                salesChart = new Chart(salesCtx, {
                    type: 'bar',
                    data: salesData,
                    options: optionsSales
                });


                productsChart = new Chart(productsCtx, {
                    type: 'bar',
                    data: productsData,
                    options: optionsProducts
                });
            }

            document.getElementById('timeFrame').addEventListener('change', (event) => {
                updateCharts(event.target.value);
            });

            // Khởi tạo biểu đồ mặc định
            updateCharts('year');

        </script>
    </body>
</html>
