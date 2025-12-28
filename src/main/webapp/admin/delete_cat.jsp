<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <title>View Categories</title>
    <!-- Bootstrap 5 and Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>

<div class="content" id="main-content">
    <div class="container mt-4">
        <h2 class="mb-4 ms-3">Category List</h2>

        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");
                stmt = conn.createStatement();
                String sql = "SELECT * FROM category";
                rs = stmt.executeQuery(sql);
        %>

        <div class="table-responsive ms-3">
            <table class="table table-bordered table-striped table-hover shadow-sm">
                <thead class="table-dark">
                <tr>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    while (rs.next()) {
                        String name = rs.getString("ctg_name");
                %>
                <tr>
                    <td><%= name %></td>
                    <td>


                        <!-- Delete Button (Red) -->
                        <a href="delete_category.jsp?name=<%= name %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this category?');">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <%
        } catch (Exception e) {
        %>
        <div class="alert alert-danger ms-3">Error: <%= e.getMessage() %></div>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
