<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Food</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    body { background-color: #f8f9fa; }
    .content-wrapper { margin-left: 250px; padding: 30px; }
    table img { max-width: 80px; border-radius: 8px; }
    .btn-sm { padding: 5px 10px; }
    @media (max-width: 768px) {
      .content-wrapper { margin-left: 0; padding: 15px; }
      table img { max-width: 60px; }
    }
    /* Fade-out animation */
    .fade-out {
      opacity: 0;
      transition: opacity 1s ease-out;
    }
  </style>
</head>
<body>
<div class="content-wrapper">
  <div class="card shadow p-4">
    <h2 class="mb-4 text-center">Manage Food Items</h2>

    <!-- Success/Error Alert -->
    <%
      String msg = request.getParameter("msg");
      if ("success".equals(msg)) {
    %>
    <div id="alertBox" class="alert alert-success d-flex align-items-center" role="alert">
      <i class="fa fa-check me-2"></i> Food updated successfully!
    </div>
    <% } else if ("error".equals(msg)) { %>
    <div id="alertBox" class="alert alert-danger d-flex align-items-center" role="alert">
      <i class="fa fa-times me-2"></i> Failed to update food!
    </div>
    <% } %>

    <div class="table-responsive">
      <table class="table table-bordered table-striped table-hover align-middle text-center">
        <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Image</th>
          <th>Name</th>
          <th>Price (₹)</th>
          <th>Category</th>
          <th>Description</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
          Connection conn = null;
          PreparedStatement ps = null;
          ResultSet rs = null;

          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

            String sql = "SELECT f.food_id, f.food_name, f.price, f.description, f.image_path, " +
                    "c.ctg_name FROM foods f " +
                    "JOIN category c ON f.category_id = c.ctg_id";

            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
              int id = rs.getInt("food_id");
              String name = rs.getString("food_name");
              double price = rs.getDouble("price");
              String desc = rs.getString("description");
              String img = rs.getString("image_path");
              String category = rs.getString("ctg_name");
        %>
        <tr>
          <td><%=id%></td>
          <td><img src="<%=request.getContextPath() + "/" + img %>" alt="Food"></td>
          <td><%=name%></td>
          <td>₹<%=price%></td>
          <td><%=category%></td>
          <td><%=desc%></td>
          <td>
            <button class="btn btn-sm btn-primary"
                    onclick="openEditModal(<%=id%>, '<%=name%>', <%=price%>, '<%=desc%>')">
              <i class="fa fa-edit"></i> Edit
            </button>
          </td>
        </tr>
        <%
            }
          } catch(Exception e) {
            out.println("<tr><td colspan='7' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
          } finally {
            if (rs != null) try { rs.close(); } catch(Exception ignored){}
            if (ps != null) try { ps.close(); } catch(Exception ignored){}
            if (conn != null) try { conn.close(); } catch(Exception ignored){}
          }
        %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Update Food Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Update Food Item</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form action="<%= request.getContextPath() %>/UpdateFoodServlet" method="post" enctype="multipart/form-data">

        <div class="modal-body">
          <input type="hidden" name="id" id="foodId">

          <div class="mb-3">
            <label class="form-label">Food Name</label>
            <input type="text" name="foodName" id="foodName" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Price (₹)</label>
            <input type="number" name="price" id="price" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" id="description" class="form-control" rows="3"></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label">Upload New Image (Optional)</label>
            <input type="file" name="image" class="form-control" accept="image/*">
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Update</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Open modal with selected row data
  function openEditModal(id, name, price, desc) {
    document.getElementById('foodId').value = id;
    document.getElementById('foodName').value = name;
    document.getElementById('price').value = price;
    document.getElementById('description').value = desc;

    var myModal = new bootstrap.Modal(document.getElementById('editModal'));
    myModal.show();
  }

  // Hide alert after 5 seconds with fade-out
  setTimeout(function() {
    const alertBox = document.getElementById('alertBox');
    if (alertBox) {
      alertBox.classList.add("fade-out");
      setTimeout(()=> alertBox.style.display = "none", 1000); // remove after fade
    }
  }, 5000);
</script>

</body>
</html>
