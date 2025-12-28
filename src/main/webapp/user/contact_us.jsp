<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Include Header -->
    <jsp:include page="header.jsp"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom CSS -->
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #000;
        }

        /* Contact Section */
        .contact-section {
            background: linear-gradient(rgba(0,0,0,0.55), rgba(0,0,0,0.55)),
            url('<%= request.getContextPath() %>/images/contact_us.jpg') center/cover no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 10px;
            margin: 0;
        }

        /* Contact Form */
        .contact-form {
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 25px;
            width: 100%;
            max-width: 380px;
            border-radius: 15px;
            color: white;
            box-shadow: 0 8px 25px rgba(0,0,0,0.4);
            animation: fadeIn 0.8s ease-in-out;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .contact-form h2 {
            font-size: 22px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 18px;
            color: #ff7043;
        }

        label {
            font-size: 14px;
            font-weight: 500;
            margin-top: 8px;
        }

        input, textarea {
            padding: 10px 12px;
            border-radius: 6px;
            border: none;
            margin-top: 5px;
            margin-bottom: 14px;
            width: 100%;
            background-color: rgba(255,255,255,0.95);
            color: #000;
            font-size: 14px;
            outline: none;
            transition: box-shadow 0.2s;
        }

        input:focus, textarea:focus {
            box-shadow: 0 0 8px rgba(255,112,67,0.6);
        }

        textarea {
            height: 90px;
            resize: none;
        }

        .btn-submit {
            background: linear-gradient(45deg, #ff5722, #e64a19);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 25px;
            font-size: 15px;
            transition: all 0.25s ease;
            display: block;
            margin: auto;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 14px rgba(255,87,34,0.4);
        }

        footer {
            background-color: #111;
            color: white;
            padding: 15px 0;
            text-align: center;
        }
    </style>
</head>
<body>

<!-- Contact Section -->
<div class="contact-section">
    <div class="contact-form">
        <h2>Contact Us</h2>
        <form method="post" action="<%= request.getContextPath() %>/Contact_Handler" >
            <label for="name">Name</label>
            <input type="text" name="name" id="name" placeholder="Enter your name" required>

            <label for="email">Email</label>
            <input type="email" name="email" id="email" placeholder="Enter your email" required>

            <label for="message">Message</label>
            <textarea name="message" id="message" placeholder="Enter your message" required></textarea>

            <button type="submit" class="btn-submit">Send Message</button>
        </form>
    </div>
</div>

<!-- Include Footer -->
<jsp:include page="footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
