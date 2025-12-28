<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration - Delicious Food Ordering</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            font-family: 'Roboto', sans-serif;
        }
        .form-box {
            background: #fff;
            max-width: 850px;
            margin: 60px auto;
            padding: 40px 35px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        }
        .form-box h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
            color: #333;
        }
        .form-control:focus {
            border-color: #6a11cb;
            box-shadow: 0 0 5px rgba(106,17,203,0.4);
        }
        .register-btn {
            width: 100%;
            padding: 12px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            color: #fff;
            transition: 0.3s;
        }
        .register-btn:hover {
            opacity: 0.9;
        }
        .error-msg {
            color: red;
            font-size: 13px;
            margin-top: 2px;
            display: none;
        }
        textarea {
            resize: none;
        }
        .cta {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        .cta a {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
        }
        .cta a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="form-box">
    <h2>Create Your Account</h2>

    <!-- ✅ Status Messages -->
    <%
        String status = request.getParameter("status");
        if ("email_exists".equals(status)) {
    %>
    <div class="alert alert-warning text-center">Email already exists! Please try another.</div>
    <%
    } else if ("fail".equals(status)) {
    %>
    <div class="alert alert-danger text-center">Registration failed! Please try again.</div>
    <%
    } else if ("success".equals(status)) {
    %>
    <div class="alert alert-success text-center">
        Registration successful! Redirecting to login in 4 seconds...
    </div>
    <script>
        setTimeout(function() {
            window.location.href = "user_login.jsp";
        }, 4000);
    </script>
    <%
        }
    %>

    <!-- ✅ Only show form if not success -->
    <%
        if (!"success".equals(status)) {
    %>
    <form action="<%= request.getContextPath() %>/Registration_srlt" method="post" id="registerForm">

        <div class="row g-3">
            <!-- Username -->
            <div class="col-md-6">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" required>
            </div>

            <!-- First Name -->
            <div class="col-md-6">
                <label class="form-label">First Name</label>
                <input type="text" class="form-control" name="first_name" required>
            </div>

            <!-- Last Name -->
            <div class="col-md-6">
                <label class="form-label">Last Name</label>
                <input type="text" class="form-control" name="last_name" required>
            </div>

            <!-- Email -->
            <div class="col-md-6">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" required>
            </div>

            <!-- Phone -->
            <div class="col-md-6">
                <label class="form-label">Phone</label>
                <input type="text" class="form-control" name="phone" id="phone" required>
                <div class="error-msg" id="phoneError">Phone number must be exactly 10 digits.</div>
            </div>

            <!-- Password -->
            <div class="col-md-6">
                <label class="form-label">Password</label>
                <input type="password" class="form-control" name="password" id="password" required>
                <div class="error-msg" id="passError">Password must be at least 4 characters.</div>
            </div>

            <!-- Re-enter Password -->
            <div class="col-md-6">
                <label class="form-label">Re-enter Password</label>
                <input type="password" class="form-control" name="repassword" id="repassword" required>
                <div class="error-msg" id="repassError">Passwords do not match.</div>
            </div>

            <!-- Address -->
            <div class="col-md-12">
                <label class="form-label">Address</label>
                <textarea class="form-control" name="address" rows="3" required></textarea>
            </div>
        </div>

        <div class="mt-4">
            <button type="submit" class="register-btn">Register</button>
        </div>
    </form>
    <%
        } // end if form should show
    %>

    <div class="cta">
        Already have an account? <a href="../user/user_login.jsp">Login Here</a>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Inline Validation Script -->
<script>
    const form = document.getElementById("registerForm");
    if(form){
        const phone = document.getElementById("phone");
        const password = document.getElementById("password");
        const repassword = document.getElementById("repassword");

        form.addEventListener("submit", function(e) {
            let valid = true;

            if (!/^\d{10}$/.test(phone.value.trim())) {
                document.getElementById("phoneError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("phoneError").style.display = "none";
            }

            if (password.value.length < 4) {
                document.getElementById("passError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("passError").style.display = "none";
            }

            if (password.value !== repassword.value) {
                document.getElementById("repassError").style.display = "block";
                valid = false;
            } else {
                document.getElementById("repassError").style.display = "none";
            }

            if (!valid) e.preventDefault();
        });
    }
</script>

</body>
</html>
