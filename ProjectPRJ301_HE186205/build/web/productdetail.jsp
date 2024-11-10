<%-- 
    Document   : productdetail
    Created on : Oct 17, 2024, 3:24:46 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List" %>
<%@page import="model.ImageProduct" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product detail</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"/>
        <style>
            /*            .hidden {
                            display: none;
                        }*/
            /* Additional styles for better appearance */
            .product-details {
                border-top: 2px solid #e5e7eb; /* Light gray border */
                margin-top: 2rem; /* Space between sections */
                padding-top: 1rem; /* Padding for product details */
            }
            .product-title {
                color: #1f2937; /* Dark gray */
            }
            .product-price {
                color: #dc2626; /* Red */
            }
            .product-category a {
                color: #3b82f6; /* Blue */
            }
            .product-category a:hover {
                text-decoration: underline; /* Underline on hover */
            }
            .carousel {
                display: flex;
                /*overflow: hidden;*/
                scroll-behavior: smooth;
            }
            .carousel-item {
                min-width: 16.66%;
                transition: transform 0.5s ease;
            }
            #mainImage {
                width: 100%;
                height: 500px;
                object-fit: contain;
                object-position: center;
            }
            .nav-item a {
                font-size: 16px !important;
                font-weight: 500;
            }

            #pro {
                color: #ffffff;
                background-color: #8019c8;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div>
            <%@include file="header.jsp" %>
        </div>

        <div style="margin-top: 100px">
            <c:set var="pro" value="${requestScope.product}" />
            <c:set var="mainimg" value="${requestScope.mainimage}" />

            <div class="container mx-auto p-6">
                <a href="search" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 inline-flex items-center mb-4">
                    <i class="fas fa-arrow-left"></i> Back
                </a>

                <div class="flex flex-col md:flex-row bg-white shadow-lg rounded-lg p-6">
                    <!-- Image Section -->
                    <div class="md:w-1/2">
                        <div class="relative">
                            <img id="mainImage" alt="Luxury sports watch" class="w-full rounded-lg" height="400"
                                 src="${mainimg.imgURL}"
                                 width="600" />
                            <button id="prevButton"
                                    class="absolute left-0 top-1/2 transform -translate-y-1/2 bg-white rounded-full p-2 shadow-md">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button id="nextButton"
                                    class="absolute right-0 top-1/2 transform -translate-y-1/2 bg-white rounded-full p-2 shadow-md">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                        <div class="flex mt-4 space-x-2">
                            <c:forEach items="${requestScope.listimg}" var="img">
                                <img alt="Thumbnail 1" class="thumbnail w-16 h-16 rounded-lg" height="60"
                                     src="${img.imgURL}"
                                     width="60" />
                            </c:forEach>
                        </div> 
                    </div>
                    <!-- Details Section -->
                    <div class="md:w-1/2 md:pl-6 mt-6 md:mt-0">
                        <h1 class="text-2xl font-bold">
                            ${pro.proName}
                            <span class="bg-green-100 text-green-800 text-xs font-semibold ml-2 px-2.5 py-0.5 rounded">
                                NEW
                            </span>
                        </h1>
                        <p class="text-green-600 font-semibold mt-2">
                            In Stock
                        </p>
                        <div class="flex items-center mt-2">
                            <p class="text-red-600 text-3xl font-bold">
                                $ ${pro.unitPrice-(pro.discount*pro.unitPrice)/100}
                            </p>
                            <p class="text-gray-600 ml-4 line-through text-base font-normal" style="color: black; font-size: 20px;">
                                $ ${pro.unitPrice}
                            </p>
                            <span class="bg-red-100 text-red-800 text-xs font-semibold ml-2 px-2.5 py-0.5 rounded" style="margin-top: -18px">

                                -${pro.discount}%

                            </span>
                        </div>

                        <p class="text-gray-600 mt-2">
                            ${pro.proDescription}
                        </p>

                        <form action="addproducttocart" method="post" class="mt-4">
                            <h2 class="text-lg font-semibold">
                                QUANTITY
                            </h2>
                            <input id="quantityInput" name="quantity" class="mt-2 p-2 border rounded w-16" type="number" value="1" min="1" />
                            <input type="hidden" name="proID" value="${pro.proID}" /> <!-- ID sản phẩm -->

                            <c:if test="${sessionScope.account != null}">
                                <input type="hidden" name="accID" value="${sessionScope.account.accID}" /> 
                            </c:if>
                            <div class="mt-6 flex space-x-4">
                                <button type="submit" id="addToBasketButton" class="bg-orange-500 text-white px-4 py-2 rounded hover:bg-orange-600">
                                    Add to Cart
                                </button>
                                <a href="checkout.jsp" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 inline-flex items-center justify-center">
                                    Buy Now
                                </a>
                            </div>
                            <!-- Notification Message -->
                            <div id="notification" class="mt-4 text-green-600 font-semibold hidden">
                                Product added to basket successfully!
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <script>
                document.getElementById('addToBasketButton').addEventListener('click', function () {
// Hiện thông báo
                    var notification = document.getElementById('notification');
                    notification.classList.remove('hidden'); // Bỏ lớp 'hidden' để hiện thông báo

// Tự động ẩn thông báo sau 3 giây
                    setTimeout(function () {
                        notification.classList.add('hidden'); // Thêm lại lớp 'hidden' để ẩn thông báo
                    }, 3000);
                });
            </script>

            <div class="max-w-4xl mx-auto p-4 bg-white shadow-md product-details">
                <h1 class="text-xl font-bold mb-4">PRODUCT DETAILS</h1>
                <div class="grid grid-cols-2 gap-4 px-4 py-2">
                    <div class="text-gray-500">Category</div>
                    <div class="product-category text-blue-600">
                        <a href="home" class="hover:underline">Shopee</a> > 
                        <a href="search" class="hover:underline">Watches</a> > 
                        <a href="#" class="hover:underline">Men's Watches</a>
                    </div>
                    <div class="text-gray-500">Promotional Quantity</div>
                    <div class="text-black">${pro.unitsOrdered}</div>
                    <div class="text-gray-500">Remaining Products</div>
                    <div class="text-black">${pro.unitsInStock}</div>
                    <div class="text-gray-500">Watch Description</div>
                    <div class="text-black">${pro.proDescription}</div>
                    <div class="text-gray-500">Ships From</div>
                    <div class="text-black">Hanoi</div>
                </div>
            </div>
        </div>

        <div>
            <div class="max-w-4xl mx-auto p-4">
                <div class="mt-4">
                    <ul class="list-none space-y-2">
                        <li class="flex items-center"><i class="fas fa-truck mr-2"></i> DELIVERY & PAYMENT (COD) NATIONWIDE</li>
                        <li class="flex items-center"><i class="fas fa-hand-point-right mr-2"></i> 3-MONTH WARRANTY FOR THE MACHINE, 6-MONTH WARRANTY FOR THE BATTERY, 1-TO-1 EXCHANGE WITHIN 7 DAYS IF THE PRODUCT HAS A MANUFACTURER'S DEFECT</li>
                        <li class="flex items-center"><i class="fas fa-times-circle mr-2"></i> NO WARRANTY FOR EXTERNAL SCRATCHES</li>
                    </ul>
                </div>
                <div class="mt-4 text-sm text-gray-600">
                    <p>#watch #menwatch #sale #luxury #fashionwatch #menfashion #affordablewatch #couplewatch #waterresistant #highendwatch #beautifulwatch #fashionwatch #menwatch #beautifulwatch #affordablewatch</p>
                </div>
            </div>
        </div>

        <div>
            <div class="max-w-4xl mx-auto p-4">
                <h1 class="text-2xl font-semibold mb-4 text-purple-800">
                    PRODUCT REVIEWS
                </h1>
                <div class="bg-purple-100 p-4 rounded-lg mb-6">
                    <div class="flex items-center mb-2">
                        <span class="text-4xl font-bold text-purple-600">
                            4.2
                        </span>
                        <span class="text-xl ml-2 text-purple-800">
                            out of 5
                        </span>
                    </div>
                    <div class="flex items-center mb-4">
                        <div class="flex text-purple-500">
                            <i class="fas fa-star">
                            </i>
                            <i class="fas fa-star">
                            </i>
                            <i class="fas fa-star">
                            </i>
                            <i class="fas fa-star">
                            </i>
                            <i class="fas fa-star-half-alt">
                            </i>
                        </div>
                    </div>
                    <div class="flex flex-wrap gap-2">
                        <button class="bg-purple-500 text-white px-4 py-2 rounded">
                            All
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            5 Stars (498)
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            4 Stars (63)
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            3 Stars (44)
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            2 Stars (19)
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            1 Star (88)
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            With Comments (212)
                        </button>
                        <button class="bg-white border border-purple-300 text-purple-700 px-4 py-2 rounded">
                            With Images / Videos (89)
                        </button>
                    </div>
                </div>
                <div class="flex items-start mb-4">
                    <div class="w-12 h-12 rounded-full bg-purple-200 flex items-center justify-center">
                        <i class="fas fa-user text-purple-500">
                        </i>
                    </div>
                    <div class="ml-4">
                        <div class="flex items-center mb-2">
                            <span class="font-semibold text-purple-800">
                                giathinao
                            </span>
                            <div class="flex text-purple-500 ml-2">
                                <i class="fas fa-star">
                                </i>
                                <i class="fas fa-star">
                                </i>
                                <i class="fas fa-star">
                                </i>
                                <i class="fas fa-star">
                                </i>
                                <i class="fas fa-star">
                                </i>
                            </div>
                        </div>
                        <div class="text-purple-500 text-sm mb-2">
                            2024-04-05 13:24 | Category: Mcykcy, Black Face + Box
                        </div>
                        <div class="text-purple-700 mb-2">
                            <p>
                                Material: leather
                            </p>
                            <p>
                                Color: black
                            </p>
                            <p>
                                Matches description: yes
                            </p>
                            <p>
                                Good product, worth the price
                            </p>
                        </div>
                        <div class="flex space-x-2">
                            <img alt="Image of a watch" class="w-20 h-20 object-cover" height="100" src="https://storage.googleapis.com/a1aa/image/mG4vlrV828JfY6DNKh4z8f5yjegXmg2On1QgOefeCAtFta35E.jpg" width="100"/>
                            <img alt="Image of a watch" class="w-20 h-20 object-cover" height="100" src="https://storage.googleapis.com/a1aa/image/mG4vlrV828JfY6DNKh4z8f5yjegXmg2On1QgOefeCAtFta35E.jpg" width="100"/>
                            <img alt="Image of a watch" class="w-20 h-20 object-cover" height="100" src="https://storage.googleapis.com/a1aa/image/mG4vlrV828JfY6DNKh4z8f5yjegXmg2On1QgOefeCAtFta35E.jpg" width="100"/>
                            <img alt="Image of a watch" class="w-20 h-20 object-cover" height="100" src="https://storage.googleapis.com/a1aa/image/mG4vlrV828JfY6DNKh4z8f5yjegXmg2On1QgOefeCAtFta35E.jpg" width="100"/>
                        </div>
                        <div class="flex items-center mt-2 text-purple-500 text-sm">
                            <i class="fas fa-thumbs-up mr-1">
                            </i>
                            1
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <div class="container mx-auto p-4">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-lg font-semibold text-purple-900">
                        OTHER PRODUCTS FROM THE SHOP
                    </h2>
                    <a class="text-purple-500" href="#">
                        View All &gt;
                    </a>
                </div>
                <div class="relative">
                    <div class="carousel">
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="Electronic sports watch..." class="w-full h-40 object-cover rounded" height="200" src="https://storage.googleapis.com/a1aa/image/ecaiAMLNtnVfdUkR1btYq5uNBuHlJRngd5N3jvIA1IeUb7OnA.jpg" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    -90%
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        Favorite
                                    </span>
                                    <span class="bg-yellow-500 text-white text-xs px-1 rounded">
                                        Discount ₫1k
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    Electronic sports watch...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ₫1.000
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        Sold 3k
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="Wokai fashion watch..." class="w-full h-40 object-cover rounded" height="200" src="https://storage.googleapis.com/a1aa/image/j62ascqJOj4wH5x9xRdWiuzlBgbjzJ0pZawGo6aV5jAbb35E.jpg" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    -20%
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        Favorite
                                    </span>
                                    <span class="bg-yellow-500 text-white text-xs px-1 rounded">
                                        Discount ₫1k
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    Wokai fashion watch...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ₫8.000
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        Sold 104
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="Wokai fashion watch d..." class="w-full h-40 object-cover rounded" height="200" src="https://storage.googleapis.com/a1aa/image/LfprCAVYDm2QYareHWD287iwyS3c6K3peB2BpuvlxOQTb7OnA.jpg" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    -20%
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        Favorite
                                    </span>
                                    <span class="bg-yellow-500 text-white text-xs px-1 rounded">
                                        Discount ₫1k
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    Wokai fashion watch d...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ₫8.000
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        Sold 200
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="Wokai watch with character..." class="w-full h-40 object-cover rounded" height="200" src="https://storage.googleapis.com/a1aa/image/XOf6Vs8cTpQnByM9WEkaMmzeDd6JfgNUSE7kHSZDAZfd22dOB.jpg" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    -10%
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        Favorite
                                    </span>
                                    <span class="bg-yellow-500 text-white text-xs px-1 rounded">
                                        Discount ₫1k
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    Wokai watch with character...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ₫9.000
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        Sold 55
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="Women's fashion watch Rate..." class="w-full h-40 object-cover rounded" height="200" src="https://storage.googleapis.com/a1aa/image/Je1ANUVCJrwEfU540EcH0yqIuAoh55oSP2S9y7tHVhXltdnTA.jpg" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    -90%
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        Favorite
                                    </span>
                                    <span class="bg-yellow-500 text-white text-xs px-1 rounded">
                                        Discount ₫1k
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    Women's fashion watch Rate...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ₫1.000
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        Sold 454
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="Men's leather strap watch Woka..." class="w-full h-40 object-cover rounded" height="200" src="https://storage.googleapis.com/a1aa/image/vAenQucfzNtZdEQRrUnCETnxMS0s2QNd4iCFnfGANE9Mb7OnA.jpg" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    -10%
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        Favorite
                                    </span>
                                    <span class="bg-yellow-500 text-white text-xs px-1 rounded">
                                        Discount ₫1k
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    Men's leather strap watch Woka...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ₫9.000
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        Sold 13
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item bg-white p-2 rounded shadow">
                            <div class="relative">
                                <img alt="More products..." class="w-full h-40 object-cover rounded" height="200" src="https://via.placeholder.com/200x200?text=More+Products" width="200"/>
                                <span class="absolute top-2 right-2 bg-purple-500 text-white text-xs px-1 rounded">
                                    ...
                                </span>
                            </div>
                            <div class="mt-2">
                                <div class="flex items-center mb-1">
                                    <span class="bg-purple-500 text-white text-xs px-1 rounded mr-1">
                                        More
                                    </span>
                                </div>
                                <p class="text-sm text-purple-900">
                                    More products...
                                </p>
                                <div class="flex items-center justify-between mt-1">
                                    <span class="text-purple-500 font-semibold">
                                        ...
                                    </span>
                                    <span class="text-gray-500 text-xs">
                                        ...
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="absolute top-1/2 left-0 transform -translate-y-1/2 bg-purple-500 text-white p-2 rounded-full" onclick="scrollCarousel(-1)">
                        <i class="fas fa-chevron-left">
                        </i>
                    </button>
                    <button class="absolute top-1/2 right-0 transform -translate-y-1/2 bg-purple-500 text-white p-2 rounded-full" onclick="scrollCarousel(1)">
                        <i class="fas fa-chevron-right">
                        </i>
                    </button>
                </div>
            </div>
            <script>
                function scrollCarousel(direction) {
                    const carousel = document.querySelector('.carousel');
                    const itemWidth = carousel.querySelector('.carousel-item').offsetWidth;
                    carousel.scrollBy({
                        left: direction * itemWidth,
                        behavior: 'smooth'
                    });
                }

                <%
                    List<ImageProduct> imageProducts = (List<ImageProduct>) request.getAttribute("listimg");
                %>
                const images = [
                <% 
                    for (int i = 0; i < imageProducts.size(); i++) {
                        ImageProduct product = imageProducts.get(i); // This line gets the element at index i
                        out.print("\"" + product.getImgURL() + "\"");
                        if (i < imageProducts.size() - 1) {
                            out.print(", ");
                        }
                    }
                %>
                ];

                let currentIndex = 0;

                document.getElementById('prevButton').addEventListener('click', () => {
                    currentIndex = (currentIndex > 0) ? currentIndex - 1 : images.length - 1;
                    document.getElementById('mainImage').src = images[currentIndex];
                });

                document.getElementById('nextButton').addEventListener('click', () => {
                    currentIndex = (currentIndex < images.length - 1) ? currentIndex + 1 : 0;
                    document.getElementById('mainImage').src = images[currentIndex];
                });

                document.querySelectorAll('.thumbnail').forEach((thumbnail, index) => {
                    thumbnail.addEventListener('click', () => {
                        currentIndex = index;
                        document.getElementById('mainImage').src = images[currentIndex];
                    });
                });

                document.getElementById('quantityInput').addEventListener('input', (event) => {
                    if (event.target.value < 1) {
                        event.target.value = 1;
                    }
                });
            </script>
        </div>

    </body>
</html>
