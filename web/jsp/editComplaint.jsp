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
    <title>Edit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
<div class="container">
    <h2>Edit Complaint</h2>
    <form action="<%= request.getContextPath() %>/employee/updateComplaint" method="post">
        <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">

        <div class="mb-3">
            <label class="form-label">Subject</label>
            <input type="text" class="form-control" name="subject" value="<%= complaint.getSubject() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description" rows="5" required><%= complaint.getDescription() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
        <a href="<%= request.getContextPath() %>/employee" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>

