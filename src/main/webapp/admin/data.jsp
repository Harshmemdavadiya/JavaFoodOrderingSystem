<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Uploaded Images</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        img {
            max-width: 150px;
            max-height: 150px;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
<h2>Uploaded Images Gallery</h2>

<table>
    <tr>
        <th>Name</th>
        <th>Image</th>
    </tr>

    <%
        String url = "jdbc:mysql://localhost:3306/food_db";
        String user = "root";
        String pass = "system";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pass);

            String sql = "SELECT name, image_path FROM demo";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                String name = rs.getString("name");
                String imagePath = rs.getString("image_path");
    %>
    <tr>
        <td><%= name %></td>
        <td>
            <img src="<%= request.getContextPath() + "/" + imagePath %>" alt="No Image">
            <br>
            <small><%= request.getContextPath() + "/" + imagePath %></small>
        </td>
    </tr>
    <%
            }

            if (!hasData) {
                out.println("<tr><td colspan='2' style='color:red;'>No records found!</td></tr>");
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='2' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
        }
    %>

</table>
</body>
</html>
