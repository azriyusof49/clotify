<%-- 
    Document   : cart
    Created on : Jun 10, 2025, 7:36:29 PM
    Author     : Azuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cartModule.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style.css" />
    <style>
        .item-image img {
            max-width: 100px;
        }
        .remove-item {
            border: none;
            background: transparent;
            font-size: 1.5rem;
            color: red;
        }
        .cart-item {
            border-bottom: 1px solid #ddd;
        }
        .sticky-summary {
            position: sticky;
            top: 20px;
        }
    </style>
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="homepage.jsp">CLOTIFY</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarContent">
                
               <div class="nav-icons ms-auto">
                    <a href="review.jsp"><i class="fas fa-heart"></i> Review</a>
                    <a href="cart.jsp"><i class="fas fa-shopping-bag"></i> Cart</a>
                    <a href="index.html"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <%
        int userId = (Integer) session.getAttribute("userId");
        cartData dao = new cartData();
        List<cart> cartItems = dao.getCartItems(userId);
        double total = 0;
    %>
    <div class="container py-5 mt-6">

        <h1 class="text-center mb-4">SHOPPING CART</h1>
        <h3 class="align-items-start">
            <a href="catalog.jsp" class="btn btn-link text-decoration-none text-black">
                <i class="fas fa-arrow-left me-2"></i>Back to Shop
            </a>
        </h3>
        <div class="row g-4">
            <!-- Cart Items -->
            <div class="col-lg-8">
                <% for (cart item : cartItems) {
                    double subtotal = item.getPrice() * item.getQuantity();
                    total += subtotal;
                %>
                    <div class="card mb-3">
                        <div class="card-body cart-item">
                            <div class="d-flex align-items-start gap-3">
                                <button class="remove-item"><a href="cartDelete?productid=<%=item.getProductId()%>&userId=<%= userId%>" class="nav-link">&times;</a></button>
                                <div class="item-image">
                                    <img src="<%= item.getImgURL() %>" alt="AIRism Cotton Pique Polo" class="img-fluid">
                                </div>
                                <div class="flex-grow-1">
                                    <h5 class="mb-1"><%= item.getName()%></h5>
                                    <p class="mb-1">Size: <%= item.getSize()%></p>
                                    <p class="fw-bold item-price">RM <%= item.getPrice() %></p>

                                    <div class="d-flex align-items-center gap-2">
                                        <label class="mb-0">QUANTITY: <%= item.getQuantity() %></label>
                                    </div>

                                    <div class="mt-2">SUBTOTAL: <strong><span class="subtotal-amount">RM <%= subtotal %></span></strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="card sticky-summary">
                    <div class="card-body">
                        <h4 class="mb-3">ORDER SUMMARY (<%= cartItems.size() %> ITEM<%= cartItems.size() > 1 ? "S" : "" %>)</h4>
                        <div class="d-flex justify-content-between summary-line">
                            <span>Item(s) subtotal</span>
                            <span>RM <%= String.format("%.2f", total) %></span>
                        </div>
                        <div class="d-flex justify-content-between fw-bold my-2 summary-line">
                            <span>SUBTOTAL</span>
                            <span>RM <%= String.format("%.2f", total) %></span>
                        </div>
                        <div class="d-flex justify-content-between text-danger fw-bold mb-3 summary-line">
                            <span>ORDER TOTAL</span>
                            <span>RM <%= String.format("%.2f", total) %></span>
                        </div>

                        <div class="list-group mb-3">
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                <span><i class="fa-solid fa-ticket"></i> Coupon</span>
                                <span>&rsaquo;</span>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                <span><i class="fa-solid fa-gift"></i> Gift option</span>
                                <span>&rsaquo;</span>
                            </a>
                        </div>

                        <p class="small text-muted">Place your order before 12pm for Same-Day Click & Collect delivery at selected stores in Klang Valley. Available Mon-Fri (excl. public holidays).</p>

                        <div class="d-grid gap-2">
                            <button class="btn btn-dark">CHECKOUT</button>
                            <button class="btn btn-outline-secondary"><a href="catalog.jsp" class="nav-link">CONTINUE SHOPPING</a></button>
                        </div>

                        <% double remaining = 150.00 - total; %>
                        <% if (remaining > 0) { %>
                            <p class="text-success mt-3">If you purchase additional RM <%= String.format("%.2f", remaining) %>, you will get free shipping</p>
                        <% } else { %>
                            <p class="text-success mt-3">You are eligible for free shipping!</p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
