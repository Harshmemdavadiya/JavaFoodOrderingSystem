# 🍔 Food Ordering System

A modern and responsive **Food Ordering System** built using **Java, JSP, Servlets, JDBC, MySQL, Maven, HTML, CSS, Bootstrap, and JavaScript**.

![Java](https://img.shields.io/badge/Java-17-orange)
![JSP](https://img.shields.io/badge/JSP-Servlet-blue)
![JDBC](https://img.shields.io/badge/JDBC-Database-success)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-Build-C71A36?logo=apachemaven&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-10-F8DC75?logo=apachetomcat&logoColor=black)

---

# 📖 About

The **Food Ordering System** is a dynamic web application developed using **Java, JSP, Servlets, JDBC, MySQL, Maven, HTML, CSS, Bootstrap, and JavaScript**.

It enables customers to browse food items, add them to the cart, place orders, and manage their profiles. The application also provides an **Admin Panel** for managing food categories, menu items, users, and customer orders.

This project follows the **MVC (Model-View-Controller)** architecture and is ideal for learning Java Web Development using JSP and Servlets.

---

# ✨ Features

## 👤 User Module

- 👤 User Registration & Login
- 🍽️ Browse Food Menu
- 🔍 Search Food Items
- 🛒 Add to Cart
- ➕ Update Cart Quantity
- ❌ Remove Items from Cart
- 📦 Place Orders
- 📜 View Order History
- 👤 Manage Profile

---

## 🔐 Admin Module

- 🔑 Admin Login
- 📊 Dashboard
- 📂 Manage Categories
- 🍕 Manage Food Items
- 👥 Manage Users
- 📦 Manage Orders
- 🔄 Update Order Status

---

# 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Java | Backend Programming |
| JSP | Dynamic Web Pages |
| Servlet | Request Handling |
| JDBC | Database Connectivity |
| MySQL | Database |
| HTML5 | Page Structure |
| CSS3 | Styling |
| Bootstrap 5 | Responsive UI |
| JavaScript | Client-side Scripting |
| Maven | Dependency Management |
| Apache Tomcat | Application Server |

---

## 📁 Project Structure

```text
FoodOrderingSystem/
│
├── 📁 .idea/                          # IntelliJ IDEA configuration
├── 📁 .mvn/                           # Maven Wrapper
│
├── 📁 src/
│   └── 📁 main/
│       ├── 📁 java/
│       │   ├── 📁 admin/              # Admin module
│       │   ├── 📁 org/
│       │   │   └── 📁 example/
│       │   │       └── 📁 food_ordering/
│       │   │           └── 📄 User.java
│       │   └── 📁 user/               # User module
│       │
│       └── 📁 webapp/
│           ├── 📁 WEB-INF/            # Deployment Descriptor
│           ├── 📁 admin/              # Admin JSP Pages
│           ├── 📁 css/                # Stylesheets
│           ├── 📁 images/             # Images & Icons
│           ├── 📁 js/                 # JavaScript Files
│           ├── 📁 user/               # User JSP Pages
│           ├── 📄 abc.html
│           └── 📄 index.jsp
│
├── 📄 .gitignore                      # Git Ignore File
├── 📄 mvnw                            # Maven Wrapper (Linux/macOS)
├── 📄 mvnw.cmd                        # Maven Wrapper (Windows)
├── 📄 pom.xml                         # Maven Configuration
├── 📄 request.http                    # HTTP Request Collection
└── 📄 README.md                       # Project Documentation
```

---
# 🚀 Getting Started

## Prerequisites

Before running this project, make sure you have:

- Java JDK 17 or above
- Apache Maven
- Apache Tomcat 10
- MySQL Server
- IntelliJ IDEA or Eclipse IDE

---

## Clone Repository

```bash
git clone https://github.com/Harshmemdavadiya/FoodOrderingSystem.git
```

---

## Open Project

Import the project into **IntelliJ IDEA** or **Eclipse IDE**.

---

## Configure Database

Create a MySQL database.

```sql
CREATE DATABASE food_ordering;
```

Import the SQL file into MySQL.

Update your JDBC configuration.

```java
String url = "jdbc:mysql://localhost:3306/food_ordering";
String username = "root";
String password = "your_password";
```

---

## Build Project

```bash
mvn clean install
```

---

## Run the Project

Deploy the project on **Apache Tomcat**.

Open your browser and visit:

```text
http://localhost:8080/FoodOrderingSystem/
```

---

# 📸 Screenshots

> Add your project screenshots here.

```
screenshots/
│
├── home.png
├── login.png
├── register.png
├── menu.png
├── cart.png
├── checkout.png
├── admin-dashboard.png
├── orders.png
```

---

# 🗄️ Database Tables

- 👤 Users
- 🔑 Admin
- 📂 Categories
- 🍕 Food Items
- 🛒 Cart
- 📦 Orders
- 📋 Order Details

---

# 🔮 Future Enhancements

- 💳 Online Payment Gateway
- 📧 Email Notifications
- 📍 Order Tracking
- ⭐ Food Ratings & Reviews
- 🎁 Coupon & Discount System
- ❤️ Wishlist
- 📱 Mobile Responsive Improvements

---

# 👨‍💻 Developer

**Harsh Memdavadiya**

🎓 MCA Student

💻 Java Developer

📧 harshmali482@gmail.con

🔗 LinkedIn: https://www.linkedin.com/in/harsh-memdavadiya-804257305

🐙 GitHub: https://github.com/Harshmemdavadiya

---

# ⭐ Show Your Support

If you like this project, don't forget to give it a **⭐ Star** on GitHub.

---

<p align="center">
Made with ❤️ by <strong>Harsh Memdavadiya</strong>
</p>
