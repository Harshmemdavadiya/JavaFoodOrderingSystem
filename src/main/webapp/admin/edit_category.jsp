<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-4">
    <h2>Edit Category</h2>

    <%
        String oldName = request.getParameter("name");
        String newName = request.getParameter("new_name");

        boolean showForm = true;
        String alert = null;
        String alertType = "danger";

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

                String sql = "UPDATE category SET ctg_name = ? WHERE ctg_name = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, newName);
                ps.setString(2, oldName);

                int updated = ps.executeUpdate();
                conn.close();

                if (updated > 0) {
                    alert = "✅ Category updated successfully!";
                    alertType = "success";
                    showForm = false; // hide form
                } else {
                    alert = "⚠️ Update failed. Category may not exist.";
                    alertType = "warning";
                }
            } catch (Exception e) {
                alert = "❌ Error: " + e.getMessage();
                alertType = "danger";
            }
        }
    %>

    <%-- Show Bootstrap alert --%>
    <% if (alert != null) { %>
    <div class="alert alert-<%= alertType %>"><%= alert %></div>
    <% } %>

    <%-- Show the form only if not updated yet --%>
    <% if (showForm && oldName != null && !oldName.trim().isEmpty()) { %>
    <form method="post" action="edit_category.jsp?name=<%= oldName %>">
        <div class="mb-3">
            <label>New Category Name</label>
            <input type="text" name="new_name" class="form-control" value="<%= (newName != null) ? newName : oldName %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="view_category.jsp" class="btn btn-secondary">Cancel</a>
    </form>
    <% } else if (!showForm) { %>
    <a href="view_category.jsp" class="btn btn-success">Back to Category List</a>
    <% } else { %>
    <div class="alert alert-danger">No category name provided.</div>
    <a href="view_category.jsp" class="btn btn-secondary">Back</a>
    <% } %>

</div>

</body>
</html>
