<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Delete Food</title>

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
  </style>
</head>
<body>
<div class="content-wrapper">
  <div class="card shadow p-4">
    <h2 class="mb-4 text-center">Delete Food Items</h2>

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
            <!-- Delete button -->
            <a href="<%= request.getContextPath() %>/DeleteFoodServlet?id=<%=id%>"
               onclick="return confirm('Are you sure you want to delete this food?')"
               class="btn btn-sm btn-danger">
              <i class="fa fa-trash"></i> Delete
            </a>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Show alert message from URL params
  const params = new URLSearchParams(window.locatison.search);
  const msg = params.get("msg");

  if (msg === "deleted") {
    showAlert("Food deleted successfully!", "success");
  } else if (msg === "error") {
    showAlert("Failed to delete food!", "danger");
  }

  // Function to display alert for 5 seconds
  function showAlert(message, type) {
    const alertDiv = document.createElement("div");
    alertDiv.className = `alert alert-${type} text-center`;
    alertDiv.innerText = message;
    document.querySelector(".content-wrapper").prepend(alertDiv);

    // Remove alert after 5 seconds
    setTimeout(() => alertDiv.remove(), 5000);
  }
</script>

</body>
</html>
