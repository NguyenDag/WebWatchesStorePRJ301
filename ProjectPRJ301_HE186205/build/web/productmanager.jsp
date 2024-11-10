<%-- 
    Document   : productmanager
    Created on : Oct 24, 2024, 2:34:27 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.ckeditor.com/4.19.1/standard/ckeditor.js"></script>
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
                <h2 class="text-2xl font-bold mb-4 text-purple-700">Product Management Table</h2>
                <button class="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600" onclick="openAddProductModal()">
                    Add Product
                </button>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full bg-white rounded-lg shadow-md">
                    <thead>
                        <tr class="bg-purple-200 text-purple-700 uppercase text-sm leading-normal">
                            <th class="py-3 px-6 text-left">Product ID</th>
                            <th class="py-3 px-6 text-left">Product Name</th>
                            <th class="py-3 px-6 text-left">Category</th>
                            <th class="py-3 px-6 text-left">Supplier</th>
                            <th class="py-3 px-6 text-left">Quantity/Unit</th>
                            <th class="py-3 px-6 text-left">Unit Price</th>
                            <th class="py-3 px-6 text-left">Stock Quantity</th>
                            <th class="py-3 px-6 text-left">Order Quantity</th>
                            <th class="py-3 px-6 text-left">Units Ordered</th>
                            <th class="py-3 px-6 text-left">Discontinued</th>
                            <th class="py-3 px-6 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 text-sm font-light">

                        <c:forEach items="${requestScope.list}" var="pro">
                            <jsp:useBean id="dao" class="dal.DAO"/> 
                            <c:set var="sup" value="${dao.getSupplierById(pro.supID.supID)}"/>
                            <c:set var="cat" value="${dao.getCategoryById(pro.catID.catID)}"/>
                            <tr class="border-b border-gray-200 hover:bg-purple-100">
                                <td class="py-3 px-6 text-left whitespace-nowrap">${pro.proID}</td>
                                <td class="py-3 px-6 text-left">${pro.proName}</td>
                                <td class="py-3 px-6 text-left">${cat.catName}</td>
                                <td class="py-3 px-6 text-left">${pro.supID.supName}</td>
                                <td class="py-3 px-6 text-left">${pro.quantityPerUnit}</td>
                                <td class="py-3 px-6 text-left">${pro.unitPrice}$</td>
                                <td class="py-3 px-6 text-left">${pro.unitsInStock}</td>
                                <td class="py-3 px-6 text-left">${pro.unitsOnOrder}</td>
                                <td class="py-3 px-6 text-left">${pro.unitsOrdered}</td>
                                <td class="py-3 px-6 text-left">${pro.discontinued?'Yes':'No'}</td>
                                <td class="py-3 px-6 text-left">
                                    <div class="flex space-x-2">

                                        <button class="bg-purple-500 text-white px-3 py-1 rounded-md hover:bg-purple-600" 
                                                onclick="openModal(${pro.proID}, '${pro.proName}', '${cat.catID}', '${cat.catName}', '${sup.supID}', '${sup.supName}', '${pro.proDescription}' , ${pro.quantityPerUnit}, ${pro.unitPrice}, ${pro.unitsInStock}, '${pro.discontinued}')">
                                            Update
                                        </button>
                                        <button class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600" 
                                                onclick="confirmDelete('${pro.proID}')">Delete</button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!--update san pham-->
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2 class="text-2xl font-bold mb-4">Update Product</h2>
                <form>
                    <input type="hidden" id="productId"  value="${pro.proID}"/>
                    <input type="hidden" id="categoryID" value="" /> 
                    <input type="hidden" id="supplierID" value="" />
                    <div>
                        <label class="block mb-2">Product Name:</label>
                        <input type="text" id="productName" class="border rounded w-full p-2" value="xyz"/>
                    </div>
                    <div>
                        <label class="block mb-2">Category:</label>
                        <input type="text" id="categoryName" class="border rounded w-full p-2" disabled/>
                    </div>
                    <div>
                        <label class="block mb-2">Supplier:</label>
                        <input type="text" id="supplierName" class="border rounded w-full p-2" disabled/>
                    </div>
                    <div>
                        <label class="block mb-2">Quantity/Unit:</label>
                        <input type="text" id="quantityPerUnit" class="border rounded w-full p-2" />
                    </div>
                    <div>
                        <label class="block mb-2">Unit Price:</label>
                        <input type="number" id="unitPrice" class="border rounded w-full p-2" />
                    </div>
                    <div>
                        <label class="block mb-2">Stock Quantity:</label>
                        <input type="number" id="unitsInStock" class="border rounded w-full p-2" />
                    </div>
                    <div>
                        <label class="block mb-2">Discontinued:</label>
                        <select id="discontinued" class="border rounded w-full p-2">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </div>
                    <button type="button" onclick="saveChanges()" class="bg-green-500 text-white px-4 py-2 rounded-md mt-4">Save Changes</button>
                </form>
            </div>
        </div>
        <!-- Modal for Adding Product -->
        <div id="addProductModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden" style="margin-top: 20px; z-index: 5000 !important">
            <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
                <h2 class="text-2xl font-bold text-purple-800 mb-4">Add New Product</h2>
                <div class="max-h-96 overflow-y-auto">
                <form id="addProductForm">
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="productName1">Product Name:</label>
                        <input type="text" id="productName1" class="w-full border rounded p-2" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="category1">Category:</label>
                        <select id="category1" class="w-full border rounded p-2" required>
                            <c:forEach items="${listcat}" var="ls">
                                <option value="${ls.catID}"> 
                                    ${ls.catName} 
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="supplier1">Supplier:</label>
                        <select id="supplier1" class="w-full border rounded p-2" required>
                            <!-- Populate suppliers here -->
                            <c:forEach items="${listsup}" var="ls1">
                                <option value="${ls1.supID}"> 
                                    ${ls1.supName} 
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="productDescription1">Product Description:</label>
                        <textarea id="productDescription1" class="w-full border rounded p-2" required></textarea>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="quantityPerUnit1">Quantity/Unit:</label>
                        <input type="number" id="quantityPerUnit1" class="w-full border rounded p-2" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="unitPrice1">Unit Price:</label>
                        <input type="number" id="unitPrice1" class="w-full border rounded p-2" step="0.01" required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-lg font-semibold text-purple-800" for="unitsInStock1">Stock Quantity:</label>
                        <input type="number" id="unitsInStock1" class="w-full border rounded p-2" required>
                    </div>
                    <div class="flex justify-end">
                        <button type="button" class="bg-purple-500 text-white px-4 py-2 rounded-md hover:bg-purple-600" onclick="addProduct()">Add Product</button>
                        <button type="button" class="ml-2 bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600" onclick="closeAddProductModal()">Cancel</button>
                    </div>
                </form>
                </div>
            </div>
        </div>


        <%@include file="footer.jsp" %>
        <script>
    // Initialize CKEditor for product description
    CKEDITOR.replace('productDescription1', {
        toolbar: [
            {name: 'document', items: ['Source', '-', 'Save', 'NewPage', 'Preview', 'Print', '-', 'Templates']},
            {name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo']},
            {name: 'editing', items: ['Find', 'Replace', '-', 'SelectAll', '-', 'Scayt']},
            {name: 'forms', items: ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField']},
            '/',
            {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']},
            {name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language']},
            {name: 'links', items: ['Link', 'Unlink', 'Anchor']},
            {name: 'insert', items: ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe']},
            '/',
            {name: 'styles', items: ['Styles', 'Format', 'Font', 'FontSize']},
            {name: 'colors', items: ['TextColor', 'BGColor']},
            {name: 'tools', items: ['Maximize', 'ShowBlocks']},
            {name: 'about', items: ['About']}
        ]
    });
</script>

        <script>
            function openModal(id, name, categoryID, categoryName, supplierID, supplierName,prodes, quantity, price, stock, discontinued) {
                document.getElementById("productId").value = id;
                document.getElementById("productName").value = name;
                document.getElementById("categoryName").value = categoryName;
                document.getElementById("categoryID").value = categoryID;
                document.getElementById("supplierName").value = supplierName;
                document.getElementById("supplierID").value = supplierID;
                document.getElementById("quantityPerUnit").value = quantity;
                document.getElementById("unitPrice").value = price;
                document.getElementById("unitsInStock").value = stock;
                document.getElementById("discontinued").value = discontinued;
                document.getElementById("productDescription1").value = prodes;

                document.getElementById("myModal").style.display = "block"; // Hiển thị modal
            }

            function closeModal() {
                document.getElementById("myModal").style.display = "none"; // Ẩn modal
            }

            // Đóng modal khi nhấn ra ngoài
            window.onclick = function (event) {
                if (event.target === document.getElementById("myModal")) {
                    closeModal();
                }
            };
            function saveChanges() {
                const productId = document.getElementById("productId").value;
                const productName = document.getElementById("productName").value;
                const quantityPerUnit = document.getElementById("quantityPerUnit").value;
                const unitPrice = document.getElementById("unitPrice").value;
                const unitsInStock = document.getElementById("unitsInStock").value;
                const discontinued = document.getElementById("discontinued").value;
                const categoryID = document.getElementById('categoryID').value;
                const supplierID = document.getElementById('supplierID').value;
                const prodes = document.getElementById('productDescription1').value;


                console.log(`Product ID:`);
//                console.log(`Product Name: ${productName}`);
//                console.log(`Quantity/Unit: ${quantityPerUnit}`);
//                console.log(`Unit Price: ${unitPrice}`);
//                console.log(`Units In Stock: ${unitsInStock}`);
//                console.log(`Discontinued: ${discontinued}`);

                // Chuyển hướng đến servlet với các tham số
                window.location.href = 'updateadmin?proID=' + productId + '&proName=' + productName +'&prodes='+prodes+ '&quantityPerUnit=' + quantityPerUnit + '&unitPrice=' + unitPrice + '&unitsInStock=' + unitsInStock + '&discontinued=' + discontinued + '&category=' + categoryID + '&supplier=' + supplierID;
            }
            function confirmDelete(productId, productName) {
                const confirmation = confirm(`Do you want to delete product productName?`);
                if (confirmation) {
                    // Thực hiện hành động xóa ở đây
                    //sua lai ham xoa san pham trong servlet
                    window.location = 'deleteadmin?proID=' + productId;
                    // Ví dụ: gửi yêu cầu xóa đến server
                    console.log(`Sản phẩm với ID ${productId} đã được xóa.`);
                    // Bạn có thể gọi một hàm để xóa sản phẩm từ danh sách hoặc từ server
                } else {
                    console.log('Hành động xóa đã bị hủy.');
                }
            }
            function openAddProductModal() {
                document.getElementById('addProductModal').classList.remove('hidden');
            }

            function closeAddProductModal() {
                document.getElementById('addProductModal').classList.add('hidden');
            }

            function addProduct() {
                // Capture form data and send to server (implement AJAX or form submission here)
                const productName = document.getElementById('productName1').value;
                const category = document.getElementById('category1').value;
                const supplier = document.getElementById('supplier1').value;
                const quantityPerUnit = document.getElementById('quantityPerUnit1').value;
                const unitPrice = document.getElementById('unitPrice1').value;
                const unitsInStock = document.getElementById('unitsInStock1').value;
                //phan nay ch hoan thanh
                window.location.href = 'addproductadmin?proName=' + productName + '&quantityPerUnit=' + quantityPerUnit + '&unitPrice=' + unitPrice + '&unitsInStock=' + unitsInStock + '&category=' + category + '&supplier=' + supplier;

            }
        </script>
    </body>
</html>
