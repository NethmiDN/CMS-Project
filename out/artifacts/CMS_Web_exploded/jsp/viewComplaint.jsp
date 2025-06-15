<%--
  Created by IntelliJ IDEA.
  User: Nethmi
  Date: 6/15/2025
  Time: 1:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.cms.dto.Complaints" %>
<%
    Complaints complaint = (Complaints) request.getAttribute("complaint");
%>
<html>
<head>
    <title>View Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
<div class="container">
    <h2>Complaint Details</h2>
    <table class="table table-bordered">
        <tr><th>ID</th><td><%= complaint.getId() %></td></tr>
        <tr><th>Subject</th><td><%= complaint.getSubject() %></td></tr>
        <tr><th>Description</th><td><%= complaint.getDescription() %></td></tr>
        <tr><th>Status</th><td><%= complaint.getStatus() %></td></tr>
        <tr><th>Date Submitted</th><td><%= complaint.getDate_submitted() %></td></tr>
    </table>
    <a href="<%= request.getContextPath() %>/employee" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>

