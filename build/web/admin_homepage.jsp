<%-- 
    Document   : admin_homepage
    Created on : May 13, 2025, 12:07:26 AM
    Author     : Azuri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="userModule.*"%>
<%@page import="productModule.*"%>
<%@page import="reviewModule.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Admin Dashboard</title>
  <!-- Bootstrap CSS -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Custom Gold/Black Theme -->
  <link rel="stylesheet" href="style.css" />
</head>
<body>
  <%
    List<product> listProduct = productData.getAllProducts();
    List<review> listReview = reviewData.getAllReview();
    List<User> list = UserData.getAllUsers();
    int TotalUsers = list.size();
    int TotalProduct = listProduct.size();

     Map<String, Integer> userGrowth = UserData.getUserGrowthData();
      StringBuilder dates = new StringBuilder();
      StringBuilder counts = new StringBuilder();

      for (Map.Entry<String, Integer> entry : userGrowth.entrySet()) {
          dates.append("'").append(entry.getKey()).append("',");
          counts.append(entry.getValue()).append(",");
      }

      if (dates.length() > 0) dates.setLength(dates.length() - 1); // Remove last comma
      if (counts.length() > 0) counts.setLength(counts.length() - 1);
  %>
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <a class="navbar-brand" href="homepage.jsp">Clotify Admin</a>
      <button class="navbar-toggler btn-gold" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="adminNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="btn nav-btn" data-bs-toggle="modal" data-bs-target="#addProductModal"><i class="fa-solid fa-clipboard-list"></i> Add Product</a></li>
          <li class="nav-item">
            <a class="btn nav-btn" href="homepage.jsp"><i class="fa-solid fa-house"></i> Home</a>
          </li>
          <li class="nav-item">
            <a class="btn nav-btn" href="index.html"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="addProduct" method="post">
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
          </div>
          <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
          </div>
          <div class="mb-3">
            <label for="category" class="form-label">Category</label>
            <select name="category" id="category" class="form-control">
              <option value="Tshirt">Tshirt</option>
              <option value="Pants">Pants</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="imgURL" class="form-label">Image URL</label>
            <input type="url" class="form-control" id="imgURL" name="imgURL">
          </div>
          <div class="mb-3">
            <label for="size" class="form-label">Size</label>
            <select name="size" id="size" class="form-control">
              <option value="S">S</option>
              <option value="M">M</option>
              <option value="L">L</option>
              <option value="XL">XL</option>
              <option value="XXL">XXL</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="stock" class="form-label">Stock</label>
            <input type="number" class="form-control" id="stock" name="stock" required>
          </div>
          <div class="mb-3">
            <label for="price" class="form-label">Price Per Units</label>
            <input type="number" class="form-control" id="price" name="price" required>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Add Product</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

 <!-- Update Product -->
<div class="modal fade" id="updateProduct" tabindex="-1" aria-labelledby="updateProductLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateProductLabel">Update Product</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="updateProduct" method="post">
          <input type="hidden" id="updateProductId" name="productId" value="true">
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="updateName" name="updateName" required>
          </div>
          <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="updateDescription" name="updateDescription" rows="3"></textarea>
          </div>
          <div class="mb-3">
            <label for="category" class="form-label">Category</label>
            <select name="updateCategory" id="updateCategory" class="form-control">
              <option value="Tshirt">Tshirt</option>
              <option value="Pants">Pants</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="imgURL" class="form-label">Image URL</label>
            <input type="url" class="form-control" id="updateImgURL" name="updateImgURL">
          </div>
          <div class="mb-3">
            <label for="size" class="form-label">Size</label>
            <select name="updateSize" id="updateSize" class="form-control">
              <option value="S">S</option>
              <option value="M">M</option>
              <option value="L">L</option>
              <option value="XL">XL</option>
              <option value="XXL">XXL</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="stock" class="form-label">Stock</label>
            <input type="number" class="form-control" id="updateStock" name="updateStock" required>
          </div>
          <div class="mb-3">
            <label for="price" class="form-label">Price Per Units</label>
            <input type="number" class="form-control" id="updatePrice" name="updatePrice" required>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Update Product</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

  <!-- Dashboard Content -->
  <div class="container-fluid py-4">
    <!-- Metrics Row -->
    <div class="row g-4 mb-4">
      <div class="col-md-6">
        <div class="card h-100">
          <div class="card-body text-center">
            <h6 class="card-title">Total Users</h6>
            <h2><%= TotalUsers%></h2>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card h-100">
          <div class="card-body text-center">
            <h6 class="card-title">Total Product</h6>
            <h2><%= TotalProduct%></h2>
          </div>
        </div>
      </div>
    </div>

    <!-- Chart Section -->
    <div class="row mb-4">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">User Growth (Last 30 Days)</h5>
            <!-- Placeholder for a chart library (e.g., Chart.js) -->
            <canvas id="userGrowthChart" style="height: 100px;"></canvas>
          </div>
        </div>
      </div>
    </div>

    <!-- Recent Users Table -->
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Recent Registrations</h5>
            <div class="table-responsive">
              <table class="table table-striped">
                <thead>
                  <tr>
                    <th>User ID</th><th>Username</th><th>Roles</th><th>Email</th><th>Last Update</th>
                  </tr>
                </thead>
                <tbody>
                  <% 
                    if (list != null && !list.isEmpty()) {
                      for (User e : list) {
                  %>
                        <tr>
                          <td><%= e.getId() %></td>
                          <td><%= e.getUsername() %></td>
                          <td><%= e.getRole() %></td>
                          <td><%= e.getEmail() %></td>
                          <td><%= e.getTimestamp() %></td>
                        </tr>
                  <% 
                      }
                    } else {
                  %>
                      <tr>
                        <td colspan="4" class="text-center">No users found.</td>
                      </tr>
                  <% 
                    } 
                  %>
                </tbody>
              </table>
            </div>
            <h5 class="card-title">Update Role</h5>
            <form action="updateRole" method="post">
              <label for="username" class="form-label">Users : </label>
              <select name="username" id="username" class="form-select form-select-sm" aria-label="Small select example">
                <option selected>Choose Users</option>
                <% 
                    if (list != null && !list.isEmpty()) {
                      for (User e : list) {
                  %>
                        <option value="<%= e.getUsername()%>"><%= e.getUsername()%></option>
                  <% 
                      }
                    } else {
                  %>
                      <option value="Null">No Users Found</option>
                  <% 
                    } 
                  %>
              </select>
              <label for="username" class="form-label mt-2">Role : </label>
              <select class="form-select form-select-sm" aria-label="Small select example" name="role">
                <option selected>Choose Role</option>
                <option value="admin">Admin</option>
                <option value="user">Users</option>
              </select>
              <div class="form-check mt-3">
                <input class="form-check-input" type="checkbox" value="" id="checkDefault" required>
                <label class="form-check-label" for="checkDefault">
                  Confirm
                </label>
              </div>
              <button type="submit" class="btn btn-primary mt-2">Update Role</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Product List</h5>
            <div class="table-responsive">
              <table class="table table-striped uniqlo-table">
                <thead>
                  <tr>
                    <th>Product ID</th><th>Name</th><th>Category</th><th>Size</th><th>Stock (units)</th><th>Price Per Units</th><th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <% 
                    String ProductID;
                    if (listProduct != null && !listProduct.isEmpty()) {
                      for (product eProduct : listProduct) {
                  %>
                        <tr>
                          <td><%= eProduct.getProductId() %></td>
                          <td><%= eProduct.getName() %></td>
                          <td><%= eProduct.getCategory() %></td>
                          <td><%= eProduct.getSize() %></td>
                          <td><%= eProduct.getStock() %></td>
                          <td>RM <%= String.format("%.2f", eProduct.getPrice()) %></td>
                          <td>
                            <a 
                              href="#" 
                              class="btn btn-secondary me-1" 
                              data-bs-toggle="modal" 
                              data-bs-target="#updateProduct"
                              data-id="<%= eProduct.getProductId() %>"
                              data-name="<%= eProduct.getName() %>"
                              data-description="<%= eProduct.getDescription() %>"
                              data-category="<%= eProduct.getCategory() %>"
                              data-size="<%= eProduct.getSize() %>"
                              data-imgurl="<%= eProduct.getImgURL() %>"
                              data-stock="<%= eProduct.getStock() %>"
                              data-price="<%= eProduct.getPrice() %>"
                            >
                              Update
                            </a>
                            <a href="deleteProduct?id=<%= eProduct.getProductId() %>" class="btn btn-primary">Delete</a>
                          </td>
                        </tr>
                  <% 
                      }
                    } else {
                  %>
                      <tr>
                        <td colspan="4" class="text-center">No products found.</td>
                      </tr>
                  <% 
                    } 
                  %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Review List</h5>
            <div class="table-responsive">
              <table class="table table-striped uniqlo-table">
                <thead>
                  <tr>
                    <th>Review ID</th><th>Rating</th><th>Comment</th><th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <% 
                    if (listReview != null && !listReview.isEmpty()) {
                      for (review re : listReview) {
                  %>
                        <tr>
                          <td><%= re.getReviewid() %></td>
                          <td><%= re.getRatting() %></td>
                          <td><%= re.getComment() %></td>
                          <td>
                            <a href="deleteReview?id=<%= re.getReviewid() %>" class="btn btn-primary">Delete</a>
                          </td>
                        </tr>
                  <% 
                      }
                    } else {
                  %>
                      <tr>
                        <td colspan="4" class="text-center">No review found.</td>
                      </tr>
                  <% 
                    } 
                  %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="py-3 text-center">
    <div class="container">
      <small class="text-gold">&copy; 2025 Clotify. All rights reserved.</small>
    </div>
  </footer>

  <!-- Bootstrap JS & Chart.js (or your chosen chart library) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
      const ctx = document.getElementById('userGrowthChart').getContext('2d');
      const userGrowthChart = new Chart(ctx, {
          type: 'line',
          data: {
              labels: [<%= dates.toString() %>],
              datasets: [{
                  label: 'New Users',
                  data: [<%= counts.toString() %>],
                  backgroundColor: 'rgba(72, 114, 255, 0.2)',
                  borderColor: '#222831',
                  borderWidth: 2,
                  tension: 0.3
              }]
          },
          options: {
              scales: {
                  y: {
                      beginAtZero: false,
                      ticks: {
                          precision: 0
                      }
                  }
              }
          }
      });
  </script>
  <script>
  var updateModal = document.getElementById('updateProduct');
  updateModal.addEventListener('show.bs.modal', function (event) {
    var button = event.relatedTarget;

    document.getElementById('updateProductId').value = button.getAttribute('data-id');
    document.getElementById('updateName').value = button.getAttribute('data-name');
    document.getElementById('updateCategory').value = button.getAttribute('data-category');
    document.getElementById('updateSize').value = button.getAttribute('data-size');
    document.getElementById('updateStock').value = button.getAttribute('data-stock');
    document.getElementById('updatePrice').value = button.getAttribute('data-price');
    document.getElementById('updateDescription').value = button.getAttribute('data-description');
    document.getElementById('updateImgURL').value = button.getAttribute('data-imgurl');
  });
</script>
</body>
</html>
