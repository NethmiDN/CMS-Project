<%--
  Created by IntelliJ IDEA.
  User: Nethmi
  Date: 6/13/2025
  Time: 8:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/employeeDashboard.css">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <%
            String msg = request.getParameter("msg");
            if ("success".equals(msg)) {
        %>
        <div class="alert alert-success">Complaint submitted successfully.</div>
        <%
            }
        %>
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
            <h2>My Complaints Dashboard</h2>
            <p class="text-muted">Track and manage your submitted complaints</p>
        </div>
        <div class="col-md-4 text-end">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                <i class="bi bi-plus-circle me-1"></i> Submit New Complaint
            </button>
        </div>
    </div>

    <!-- Complaints Table -->
    <div class="card">
        <div class="card-body">
            <table class="table table-hover" id="complaintsTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Subject</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    java.util.List<com.example.cms.dto.Complaints> userComplaints =
                            (java.util.List<com.example.cms.dto.Complaints>) request.getAttribute("userComplaints");
                    if (userComplaints != null && !userComplaints.isEmpty()) {
                        for (com.example.cms.dto.Complaints complaint : userComplaints) {
                %>
                <tr>
                    <td><%= complaint.getId() %></td>
                    <td><%= complaint.getSubject() %></td>
                    <td><%= complaint.getDescription() %></td>
                    <td><%= complaint.getDate_submitted() %></td>
                    <td>
            <span class="badge <%= complaint.getStatus().equals("Pending") ? "bg-warning" :
                complaint.getStatus().equals("In Progress") ? "bg-info" :
                complaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                <%= complaint.getStatus() %>
            </span>
                    </td>
                    <td>

                        <% if (!complaint.getStatus().equals("Resolved") && !complaint.getStatus().equals("Rejected")) { %>
                        <!-- Change this to redirect to the edit page instead of using a modal -->
                        <a href="${pageContext.request.contextPath}/employee/editComplaintForm?complaintId=<%= complaint.getId() %>"
                           class="btn btn-sm btn-warning" title="Edit">
                            <i class="bi bi-pencil"></i>
                        </a>

                        <form action="${pageContext.request.contextPath}/employee/deleteComplaint" method="post" style="display:inline;"
                              onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                            <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                            <button type="submit" class="btn btn-sm btn-danger" title="Delete">
                                <i class="bi bi-trash"></i>
                            </button>
                        </form>
                        <% } %>
                    </td>

                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="6" class="text-center">No complaints found</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- New Complaint Modal -->
<div class="modal fade" id="newComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Submit New Complaint</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <c:if test="${not empty error}">
                <div style="color: red; font-weight: bold; margin-bottom: 10px;">
                        ${error}
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.msg}">
                <div style="color: green; font-weight: bold; margin-bottom: 10px;">
                        ${sessionScope.msg}
                </div>
                <c:remove var="msg" scope="session"/>
            </c:if>
            <form action="${pageContext.request.contextPath}/employee/submitComplaint" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="subject" name="subject" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Submit Complaint</button>
                </div>
                <c:if test="${not empty error}">
                    <div style="color:red;">${error}</div>
                </c:if>
            </form>

        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this complaint? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/employee/deleteComplaint" method="post">
                    <input type="hidden" id="deleteComplaintId" name="complaintId">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>