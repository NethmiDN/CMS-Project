<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Complaints Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminDashboard.css">
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">Complaint Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <div class="d-flex">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-light btn-sm" id="logout_btn">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <!-- Dashboard Header -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h2>Admin Dashboard - Complaints List</h2>
            <p class="text-muted">Manage all user complaints</p>
        </div>
    </div>

    <!-- Display messages -->
    <% if(request.getParameter("error") != null) { %>
    <div class="alert alert-danger">
        <%= request.getParameter("error") %>
    </div>
    <% } %>

    <% if(request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <!-- Complaints Table -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Subject</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Date Submitted</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    java.util.List<com.example.cms.dto.Complaints> complaints = (java.util.List<com.example.cms.dto.Complaints>) request.getAttribute("complaints");
                    if (complaints != null && !complaints.isEmpty()) {
                        for (com.example.cms.dto.Complaints complaint : complaints) {
                %>
                <tr>
                    <td><%= complaint.getId() %></td>
                    <td><%= complaint.getUserId() %></td>
                    <td><%= complaint.getSubject() %></td>
                    <td><%= complaint.getDescription() %></td>
                    <td>
                        <span class="badge <%= complaint.getStatus().equals("Pending") ? "bg-warning" :
                            complaint.getStatus().equals("In Progress") ? "bg-info" :
                            complaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                            <%= complaint.getStatus() %>
                        </span>
                    </td>
                    <td><%= complaint.getDate_submitted() %></td>
                    <td>
                        <!-- View complaint details -->
                        <form action="${pageContext.request.contextPath}/admin/viewComplaint" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                            <button type="submit" class="btn btn-sm btn-info" title="View Complaint">
                                <i class="bi bi-eye"></i>
                            </button>
                        </form>

                        <!-- Update status modal trigger -->
                        <form action="${pageContext.request.contextPath}/admin/editStatus" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= complaint.getId() %>" />
                            <button type="submit" class="btn btn-sm btn-warning" title="Edit Status">
                                <i class="bi bi-pencil"></i>
                            </button>
                        </form>

                        <!-- Delete complaint -->
                        <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;"
                              onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                            <button type="submit" class="btn btn-sm btn-danger" title="Delete Complaint">
                                <i class="bi bi-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="7" class="text-center">No complaints found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%-- Modal to edit status --%>
<%
    com.example.cms.dto.Complaints complaint = (com.example.cms.dto.Complaints) request.getAttribute("complaint");
    if (complaint != null) {
%>
<div class="modal show" tabindex="-1" style="display: block; background-color: rgba(0,0,0,0.5);">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Update Status for Complaint #<%= complaint.getId() %></h5>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-close" aria-label="Close"></a>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">

                    <div class="mb-3">
                        <label for="statusSelect" class="form-label">Status</label>
                        <select class="form-select" id="statusSelect" name="status" required>
                            <option value="Pending" <%= "Pending".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="In Progress" <%= "In Progress".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
                            <option value="Resolved" <%= "Resolved".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    }
%>

<%-- Modal to view complaint details --%>
<%
    com.example.cms.dto.Complaints viewComplaint = (com.example.cms.dto.Complaints) request.getAttribute("viewComplaint");
    if (viewComplaint != null) {
%>
<div class="modal show" tabindex="-1" style="display: block; background-color: rgba(0,0,0,0.5);">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Complaint Details #<%= viewComplaint.getId() %></h5>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-close" aria-label="Close"></a>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <strong>Subject:</strong>
                    <p><%= viewComplaint.getSubject() %></p>
                </div>
                <div class="mb-3">
                    <strong>Description:</strong>
                    <p><%= viewComplaint.getDescription() %></p>
                </div>
                <div class="mb-3">
                    <strong>Status:</strong>
                    <span class="badge <%= viewComplaint.getStatus().equals("Pending") ? "bg-warning" :
                        viewComplaint.getStatus().equals("In Progress") ? "bg-info" :
                        viewComplaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                        <%= viewComplaint.getStatus() %>
                    </span>
                </div>
                <div class="mb-3">
                    <strong>Submitted By:</strong>
                    <p>User #<%= viewComplaint.getUserId() %></p>
                </div>
                <div class="mb-3">
                    <strong>Date Submitted:</strong>
                    <p><%= viewComplaint.getDate_submitted() %></p>
                </div>
            </div>
            <div class="modal-footer">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Close</a>
            </div>
        </div>
    </div>
</div>
<%
    }
%>

<!-- Bootstrap JS (for modal functionality) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>