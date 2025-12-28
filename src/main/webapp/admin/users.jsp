<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="header.jsp" %> <%-- Sidebar/Menu Include --%>
<head>
    <meta charset="UTF-8">
    <title>Admin | All Users</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#f4f6f9; font-family:'Poppins',sans-serif; }

        .users-page {
            margin-left: 250px; /* sidebar width */
            padding: 30px;
        }

        .users-container {
            background:white;
            border-radius:15px;
            padding:20px;
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
            max-width:1300px;
            margin:auto;
        }

        .users-title {
            font-size:2rem;
            font-weight:700;
            margin-bottom:20px;
            text-align:center;
        }

        @media(max-width: 992px){
            .users-page { margin-left: 0; padding:15px; }
        }
    </style>
</head>
<body>

<div class="users-page">
    <div class="users-container">
        <h2 class="users-title">👥 All Registered Users</h2>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
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

                        String sql = "SELECT u_id, username, first_name, last_name, email, phone, address FROM users ORDER BY u_id DESC";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while(rs.next()) {
                            int userId = rs.getInt("u_id");
                            String username = rs.getString("username");
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                            String address = rs.getString("address");
                %>
                <tr>
                    <td><%= userId %></td>
                    <td><%= username %></td>
                    <td><%= firstName + " " + lastName %></td>
                    <td><%= email %></td>
                    <td><%= phone %></td>
                    <td style="text-align:left;"><%= address %></td>
                </tr>
                <%
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='6' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
                    } finally {
                        if(rs!=null) try{rs.close();}catch(Exception ignore){}
                        if(ps!=null) try{ps.close();}catch(Exception ignore){}
                        if(conn!=null) try{conn.close();}catch(Exception ignore){}
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
