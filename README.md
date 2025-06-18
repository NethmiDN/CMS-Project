# Complaint Management System (CMS) – JSP & Jakarta EE

## Project Overview

This is a **Web-Based Complaint Management System (CMS)** developed as part of IJSE GDSE Advanced API Development assignment. The system enables internal municipal employees and admins to manage complaints through a secure, role-based portal. The application demonstrates the use of JavaServer Pages (JSP), Jakarta EE Servlets, MySQL, Apache DBCP, and adheres strictly to the MVC architecture. All backend communication is performed via synchronous HTML form submissions (no AJAX).

---

## Features

### Authentication Module
- User login with session management
- Role-based access control (Employee / Admin)

### Complaint Management Module

**Employee Role:**
- Submit new complaints
- View personal complaints history
- Edit or delete own unresolved complaints

**Admin Role:**
- View all complaints
- Update status & add remarks
- Delete any complaint

---

## Technology Stack

- **Frontend:** JSP, HTML, CSS, JavaScript (for validation only)
- **Backend:** Jakarta EE Servlets, JavaBeans (POJOs), DTO pattern
- **Database:** MySQL (accessed via Apache Commons DBCP connection pool)
- **Server:** Apache Tomcat

---

## System Architecture

- **Model:** JavaBeans (for data) & DTO classes (for DB operations)
- **View:** JSP pages (renders forms, lists, and details)
- **Controller:** Servlets (handle GET/POST, business logic, session management)

**All state-changing operations:** via HTTP POST and HTML `<form>`  
**All read-only operations:** via HTTP GET  
**No AJAX, fetch, or XMLHttpRequest is used.**

---

## Repository Structure

```
/src/
  /main/
    /java/
      /model/           # JavaBeans (POJOs) for User, Complaint, etc.
      /dto/             # DTO classes for DB access
      /servlet/         # Controller (Servlets)
    /webapp/
      /WEB-INF/
        /jsp/           # JSP view files
        /css/           # CSS
        /js/            # JavaScript (for validation)
/db/
  schema.sql            # MySQL database schema
README.md
```

---

## Setup & Configuration Guide

### Prerequisites

- Java JDK 11 or newer
- Apache Tomcat 9/10 (local)
- MySQL Server
- Maven (for build management)
- Apache Commons DBCP library

### 1. Clone Repository

```bash
git clone https://github.com/NethmiDN/CMS-Project.git
cd <CMS-Project>
```

### 2. Database Setup

- Create a database (e.g., `cms_db`).
- Import the schema:

```bash
mysql -u <username> -p cms_db < db/schema.sql
```

- (Optional) Insert initial user data as needed for demo.

### 3. Configure Database Connection

- Edit `/src/main/webapp/WEB-INF/db.properties`:

```
db.url=jdbc:mysql://localhost:3306/cms_db
db.username=<your-db-username>
db.password=<your-db-password>
db.driver=com.mysql.cj.jdbc.Driver
```

- Ensure Apache Commons DBCP and MySQL connector JARs are in `/WEB-INF/lib/`.

### 4. Build & Deploy

- Build with Maven or your IDE.
- Deploy the WAR to your local Tomcat's `webapps` directory.
- Start Tomcat and visit: `http://localhost:8080/<context-root>/`

---

## Usage Guide

### Employee

1. Login with employee credentials.
2. Submit a new complaint via the provided form.
3. View, edit, or delete own complaints (if not resolved).

### Admin

1. Login as admin.
2. View all complaints.
3. Update complaint statuses and remarks.
4. Delete any complaint.

---

## Demo Video

**YouTube:**  
[JakartaEE Project 2025 - IJSE 72 Nethmi Diwyanga Nanayakkara Galle](<https://youtu.be/yMlJYc3zYpM>)

---

## Academic Integrity

This project is strictly individual work. Do not copy or share code.  
Violations will result in disciplinary action.

---

## Contact

**Author:** Nethmi Diwyanga Nanayakkara  
**Email:** nethminanayakkara277@gmail.com

---

## License

This repository is for educational and demonstration purposes only.
