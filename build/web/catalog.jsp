<%-- 
    Document   : catalog
    Created on : Jun 10, 2025, 6:47:36 PM
    Author     : Azuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="userModule.*"%>
<%@page import="productModule.*"%>
<%@page import="cartModule.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CLOTIFY | Product Catalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style.css" />
</head>
<body>
    <%
        List<product> listProduct = productData.getAllProducts();
        int userId = (Integer) session.getAttribute("userId");
    %>
    <!-- Main Navigation -->
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
    
    <!-- Hero Section -->
    <section class="hero mt-6">
        <div class="container">
            <h1>SUMMER COLLECTION</h1>
            <p>Lightweight, breathable fabrics for your warmest days</p>
            <button class="btn btn-uniqlo">SHOP NOW</button>
        </div>
    </section>
    
    <!-- Catalog Section -->
    <section class="catalog py-5">
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h2 class="section-title">Featured Products</h2>
                </div>

                <div class="col-md-6 text-md-end">
                    <div class="filters">
                        <button class="filter-btn active" data-filter="all">All</button>
                        <button class="filter-btn" data-filter="tshirt">Tshirt</button>
                        <button class="filter-btn" data-filter="pants">Pants</button>
                    </div>
                </div>
            </div>
            
            <div class="row" id="product-container">
                <% 
                    if (listProduct != null && !listProduct.isEmpty()) {
                    for (product eProduct : listProduct) { %>
                        <div class="col-md-6 col-lg-4 col-xl-3 product-card-wrapper" data-category="<%= eProduct.getCategory().toLowerCase() %>">
                            <div class="product-card">
                                <div class="product-img">
                                    <img src="<%= eProduct.getImgURL() %>" alt="<%= eProduct.getName() %>" class="img-fluid">
                                </div>
                                <div class="product-info">
                                    <h3 class="product-title"><%= eProduct.getName() %></h3>
                                    <p class="text-muted">Size: <%= eProduct.getSize() %></p>
                                    <h5 class="card-title">Description</h5>
                                    <p class="text-muted"><%= eProduct.getDescription() %></p>
                                    <div class="product-price">RM<%= String.format("%.2f", eProduct.getPrice()) %></div>
                                    <button class="btn btn-uniqlo add-to-cart-btn"><a href="addCart?userid=<%=userId%>&productid=<%=eProduct.getProductId()%>" class="nav-link">Add to Cart</a></button>
                                </div>
                            </div>
                        </div>
                <% } 
                } else { %>
                    <div class="col-12">
                        <div class="no-products text-center">
                            <i class="fas fa-search fa-3x mb-3"></i>
                            <h4>No products found</h4>
                            <p>Try again later.</p>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-3 mb-4">
                    <h4 class="footer-title">Customer Service</h4>
                    <div class="footer-links">
                        <a href="#">Contact Us</a>
                        <a href="#">FAQs</a>
                        <a href="#">Shipping</a>
                        <a href="#">Returns & Exchanges</a>
                        <a href="#">Product Care</a>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <h4 class="footer-title">About Clotify</h4>
                    <div class="footer-links">
                        <a href="#">Our Story</a>
                        <a href="#">Sustainability</a>
                        <a href="#">Careers</a>
                        <a href="#">Store Locations</a>
                        <a href="#">Clotify App</a>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <h4 class="footer-title">Legal</h4>
                    <div class="footer-links">
                        <a href="#">Terms & Conditions</a>
                        <a href="#">Privacy Policy</a>
                        <a href="#">Accessibility</a>
                        <a href="#">Cookie Policy</a>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <h4 class="footer-title">Newsletter</h4>
                    <p>Subscribe for updates and special offers</p>
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" placeholder="Your email address">
                        <button class="btn btn-uniqlo" type="button">Subscribe</button>
                    </div>
                    
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-pinterest-p"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="copyright">
                <p>&copy; 2025 Clotify Co., Ltd. All rights reserved.</p>
            </div>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple filter functionality
        document.querySelectorAll('.filter-btn').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');

                const filter = this.getAttribute('data-filter');
                const products = document.querySelectorAll('.product-card-wrapper');

                products.forEach(product => {
                    if (filter === 'all' || product.getAttribute('data-category') === filter) {
                        product.style.display = 'block';
                    } else {
                        product.style.display = 'none';
                    }
                });
            });
        });

    </script> 
</body>
</html>
