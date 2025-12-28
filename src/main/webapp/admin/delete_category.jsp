<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String name = request.getParameter("name");

    if (name != null && !name.trim().isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

            String sql = "DELETE FROM category WHERE ctg_name = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);

            int deleted = ps.executeUpdate();
            conn.close();

            if (deleted > 0) {
                response.sendRedirect("delete_cat.jsp?status=deleted");
            } else {
                response.sendRedirect("delete_cat.jsp?status=notfound");
            }

        } catch (Exception e) {
            response.sendRedirect("delete_cat.jsp?status=error&msg=" + e.getMessage());
        }
    } else {
        response.sendRedirect("delete_cat.jsp?status=invalid");
    }
%>
