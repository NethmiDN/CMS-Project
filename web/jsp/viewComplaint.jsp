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
    <title>Complaint Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Complaint Details</h2>
    <hr>
    <p><strong>ID:</strong> <%= complaint.getId() %></p>
    <p><strong>Subject:</strong> <%= complaint.getSubject() %></p>
    <p><strong>Description:</strong> <%= complaint.getDescription() %></p>
    <p><strong>Submitted By:</strong> <%= complaint.getUserId() %></p>
    <p><strong>Date:</strong> <%= complaint.getDate_submitted() %></p>
    <p><strong>Status:</strong> <%= complaint.getStatus() %></p>

    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary mt-3">Back to Dashboard</a>

</div>
</body>
</html>