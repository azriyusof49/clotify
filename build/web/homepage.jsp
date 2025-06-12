<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Clotify — Home</title>

  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <!-- Your custom styles -->
  <link rel="stylesheet" href="style.css" />
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Clotify</a>
      <button class="navbar-toggler btn-gold" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navMenu">
        <ul class="navbar-nav ms-auto">
          <%
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            if("admin".equalsIgnoreCase(role)){
              %>
                <li class="nav-item"><a class="nav-link" href="admin_homepage.jsp">Admin Page</a></li>
              <%
            }
            if(username != null){
              %>
                <li class="nav-item"><a class="nav-link" href="index.html">Logout</a></li>
              <%
            }else{
              %>
                <li class="nav-item"><a class="nav-link" href="index.html">Login</a></li>
              <%
            }
          %>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <header class="py-5 text-center">
    <div class="container">
      <h1 class="display-4 mb-3">Welcome to Clotify</h1>
      <p class="lead mb-4">Your one-stop shop for custom clothing and style inspiration.</p>
      <c:choose>
        <c:when test="${empty sessionScope.user}">
          <a href="index.html" class="btn btn-gold btn-lg">Get Started</a>
        </c:when>
        <c:otherwise>
          <a href="catalog.jsp" class="btn btn-gold btn-lg">Browse Catalog</a>
        </c:otherwise>
      </c:choose>
    </div>
  </header>

  <!-- Feature Cards -->
  <section class="py-5">
    <div class="container">
      <div class="row g-4">
        <div class="col-md-4">
          <div class="card h-100">
            <div class="card-body">
              <h5 class="card-title">Customize</h5>
              <p class="card-text">Design your own tees, hoodies, and more with our easy-to-use editor.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card h-100">
            <div class="card-body">
              <h5 class="card-title">Quality</h5>
              <p class="card-text">We use premium fabrics and top-notch printing so your designs last.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card h-100">
            <div class="card-body">
              <h5 class="card-title">Community</h5>
              <p class="card-text">Share your creations, get feedback, and join a vibrant design community.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="py-4 text-center">
    <div class="container">
      <p class="mb-1">&copy; 2025 Clotify. All rights reserved.</p>
      <small><a href="privacy.jsp" class="text-gold">Privacy Policy</a> | <a href="terms.jsp" class="text-gold">Terms of Service</a></small>
    </div>
  </footer>

  <!-- Bootstrap JS -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
  ></script>
</body>
</html>
