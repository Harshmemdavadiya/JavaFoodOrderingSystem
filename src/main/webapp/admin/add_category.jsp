<%@ page import="java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<!-- ✅ ADD THIS LINE if SweetAlert2 is not in header.jsp -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="content" id="main-content">
    <div class="container mt-4">
        <h2 class="mb-4">Add Categories</h2>

        <!-- Add Category Form -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-primary text-white">
                <i class="fas fa-plus-circle me-2"></i> Add New Category
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/add_category_srlt" method="post">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="categoryName" name="ctg_name" required>
                    </div>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save me-1"></i> Add Category</button>
                </form>
            </div>
        </div>
    </div>
</div>

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

                </tr>
                </thead>
                <tbody>
                <%
                    while (rs.next()) {
                        String name = rs.getString("ctg_name");
                %>
                <tr>
                    <td><%= name %></td>


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
<!-- ✅ SweetAlert2 Script to show success/fail message -->
<script>
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get("status");

    if (status === "success") {
        Swal.fire({
            icon: 'success',
            title: 'Category Added!',
            text: 'Category was added successfully.',
            timer: 3000,
            showConfirmButton: false,
            timerProgressBar: true
        }).then(() => {
            window.location.href = "add_category.jsp"; // Reload clean URL
        });
    }

    if (status === "fail") {
        Swal.fire({
            icon: 'error',
            title: 'Failed!',
            text: 'Category could not be added.',
            timer: 3000,
            showConfirmButton: false,
            timerProgressBar: true
        }).then(() => {
            window.location.href = "add_category.jsp"; // Retry on same page
        });
    }
</script>
