<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <title>View Categories</title>
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
                        <a href="edit_category.jsp?name=<%= name %>" class="btn btn-sm btn-primary me-2">
                            <i class="fas fa-edit"></i> Edit
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
