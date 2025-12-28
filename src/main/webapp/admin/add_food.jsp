<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Food</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .content-wrapper { margin-left: 250px; padding: 30px; transition: all 0.3s ease; }
        .card { border-radius: 15px; background-color: white; max-width: 600px; margin: 0 auto; }
        h2 { color: #343a40; }
        .btn-primary { background-color: #007bff; border: none; transition: 0.3s; }
        .btn-primary:hover { background-color: #0056b3; }
        @media (max-width: 768px) { .content-wrapper { margin-left: 0 !important; padding: 15px; } }
    </style>
</head>
<body>
<div class="content-wrapper">
    <div class="card shadow-lg p-4">
        <h2 class="mb-4 text-center">Add New Food Item</h2>

        <%-- SweetAlert2 Messages --%>
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>
        <script>
            <% if(success != null){ %>
            Swal.fire({ icon:'success', title:'Success!', text:'<%= success %>', timer:2000, showConfirmButton:false });
            <% } else if(error != null){ %>
            Swal.fire({ icon:'error', title:'Oops!', text:'<%= error %>' });
            <% } %>
        </script>

        <form action="<%=request.getContextPath()%>/AddFood_srlt" method="post" enctype="multipart/form-data">
            <!-- Food Name -->
            <div class="mb-3">
                <label class="form-label">Food Name</label>
                <input type="text" class="form-control" name="food_Name" placeholder="Enter food name" required>
            </div>

            <!-- Price -->
            <div class="mb-3">
                <label class="form-label">Price (₹)</label>
                <input type="number" step="0.01" class="form-control" name="price" placeholder="Enter price" required>
            </div>

            <!-- Category Dropdown -->
            <div class="mb-3">
                <label class="form-label">Category</label>
                <select class="form-select" name="category" required>
                    <option value="" disabled selected>Select category</option>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db","root","system");
                            PreparedStatement pst = conn.prepareStatement("SELECT ctg_id, ctg_name FROM category");
                            ResultSet rs = pst.executeQuery();
                            while(rs.next()){
                    %>
                    <option value="<%= rs.getInt("ctg_id") %>"><%= rs.getString("ctg_name") %></option>
                    <%
                            }
                            rs.close(); pst.close(); conn.close();
                        } catch(Exception e){
                            out.println("<option disabled>Error loading categories</option>");
                        }
                    %>
                </select>
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea class="form-control" name="description" rows="3" placeholder="Enter short description"></textarea>
            </div>

            <!-- Image Upload -->
            <div class="mb-3">
                <label class="form-label">Food Image</label>
                <input type="file" class="form-control" name="image" accept="image/*" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary px-4"><i class="fa fa-plus"></i> Add Food</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
