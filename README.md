# 🎓 Clotify E-Commerce

A clean and functional **Java EE** E-Commerce platform built with **JSP & Servlets**, styled using **Bootstrap**, and backed by **MySQL**. This web app features **role-based access**, **product management**, **shopping cart**, **user reviews**, and **real-time analytics**.

---

## 🛠️ Tech Stack

| Technology | Role                              |
| ---------- | --------------------------------- |
| Java EE    | Backend logic with JSP & Servlets |
| MySQL      | Relational database               |
| Bootstrap  | Responsive front-end styling      |
| NetBeans   | Development IDE                   |

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/azriyusof49/clotify.git
cd clotify
```

### 2. Open in NetBeans

* Launch NetBeans
* Go to **File → Open Project**
* Select the `clotify` folder

### 3. Set Up MySQL

* Open **phpMyAdmin** or your preferred MySQL client
* Create a new database called `clotify`
* Import the `clotify.sql` file included in the project root to create tables and insert sample data

---

## ✅ Features

### 👨‍💼 Admin Panel

* Admin login authentication
* Create, update, and delete products
* View and manage user roles
* View user registration trends in a chart

### 👤 User Functionality

* Secure login and registration
* Browse and search products
* Add products to cart and view cart total
* Submit and view reviews

### 📊 Analytics

* 📈 Line Chart: Track user registration over time

---

## 🗼️ Screenshots

### 🔹 Home Page

![Home](homepage.png)

### 🔹 Product Catalog

![Catalog](catalog.png)

### 🔹 Admin Panel

![Add Product](addProduct.png)

![User Management](admin.png)

---

## 🗂️ Folder Structure

```
clotify/
├── src/
│   ├── java/
|   │   ├── cartModule/
|   │   ├── productModule/
|   │   ├── reviewModule/
|   │   └── userModule/
├── web/
├── clotify.sql
├── README.md
└── nbproject/
```

---

## 👨‍💼 Authors

* **Azri Yusof** \[S69911] — [LinkedIn](https://www.linkedin.com/in/azriyusof49)
* **Danial** \[S72342]
* **Muflih** \[S72570]

---

## 📃 License

This project is licensed under the MIT License. See `LICENSE` for more details.
