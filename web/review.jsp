<%-- 
    Document   : review
    Created on : Jun 12, 2025, 12:35:10 AM
    Author     : Azuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="reviewModule.*"%>
<%@page import="userModule.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Reviews</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            padding-bottom: 180px; /* to ensure review form doesn’t overlap with content */
        }
        .review-bubble {
            background-color: var(--uniqlo-light-gray);
            border-radius: 1rem;
            padding: 1rem;
            margin-bottom: 1rem;
            position: relative;
        }
        .review-bubble::before {
            content: '';
            position: absolute;
            bottom: 100%;
            left: 30px;
            border: 10px solid transparent;
            border-bottom-color: var(--uniqlo-light-gray);
        }
        .star-rating i {
            color: #FFD700;
        }
        .star-input .fa-star {
            cursor: pointer;
            color: #ccc;
        }
        .star-input .fa-star.checked {
            color: #FFD700;
        }
        .floating-review-box {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background-color: white;
            border-top: 1px solid var(--uniqlo-border);
            padding: 20px;
            box-shadow: 0 -2px 10px rgba(0,0,0,0.1);
            z-index: 1000;
        }
    </style>
</head>
<body>
    <%
        List<review> chats = reviewData.getAllReview();
        int userId = (Integer) session.getAttribute("userId");
    %>
    <div class="container py-5">
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
        <h1 class="text-center mb-4 mt-6">Customer Review</h1>
        <h3 class="align-items-start">
            <a href="catalog.jsp" class="btn btn-link text-decoration-none text-black">
                <i class="fas fa-arrow-left me-2"></i>Back to Shop
            </a>
        </h3>
        <div class="mb-5" style="max-height: 400px; overflow-y: auto;">
            <%
                for (review re : chats) {
                    User e = UserData.getUserById(re.getUserid());
            %>
                    <div class="review-bubble">
                        <div class="d-flex justify-content-between">
                            <strong><%= e.getUsername() %></strong>
                            <div class="star-rating">
                                <%
                                    int rating = re.getRatting();
                                    for (int i = 1; i <= 5; i++) {
                                        if (i <= rating) {
                                %>
                                    <i class="fas fa-star"></i>
                                <%
                                        } else {
                                %>
                                    <i class="far fa-star"></i>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                        <p class="mt-2"><%= re.getComment() %></p>
                    </div>
            <%
                }
            %>
        </div>

        <!-- Submit Review -->
        <div class="floating-review-box">
            <h4 class="mb-3">Leave a Review</h4>
            <form action="addReview" method="post">
                <input type="hidden" name="userId" value="<%= userId%>">
                <input type="hidden" name="rating" id="rating" value="0">
                <div class="mb-3 star-input">
                    <label class="form-label">Your Rating</label>
                    <div>
                        <i class="far fa-star" data-value="1"></i>
                        <i class="far fa-star" data-value="2"></i>
                        <i class="far fa-star" data-value="3"></i>
                        <i class="far fa-star" data-value="4"></i>
                        <i class="far fa-star" data-value="5"></i>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="reviewText" class="form-label">Your Comment</label>
                    <textarea class="form-control" id="reviewText" rows="3" placeholder="Share your experience..." name="comment"></textarea>
                </div>
                <button type="submit" class="btn btn-uniqlo">Submit Review</button>
            </form>
        </div>
    </div>

    <script>
        const stars = document.querySelectorAll('.star-input i');
        const ratingInput = document.getElementById('rating');

        stars.forEach((star, index) => {
            star.addEventListener('click', () => {
                const rating = index + 1;
                ratingInput.value = rating;
                stars.forEach((s, i) => {
                    s.classList.toggle('fas', i < rating);
                    s.classList.toggle('far', i >= rating);
                    s.classList.toggle('checked', i < rating);
                });
            });
        });
    </script>
</body>
</html>

