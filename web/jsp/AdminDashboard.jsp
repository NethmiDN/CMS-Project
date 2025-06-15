<%--
  Created by IntelliJ IDEA.
  User: Nethmi
  Date: 6/13/2025
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminDashboard.css">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
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
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-light btn-sm">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row mb-4">
        <div class="col">
            <h2>Complaints Dashboard</h2>
            <p class="text-muted">Manage all system complaints</p>
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
                    <th>Submitted By</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    java.util.List<com.example.cms.dto.Complaints> complaintsList =
                            (java.util.List<com.example.cms.dto.Complaints>) request.getAttribute("complaints");
                    if (complaintsList != null && !complaintsList.isEmpty()) {
                        for (com.example.cms.dto.Complaints complaint : complaintsList) {
                %>
                <tr>
                    <td><%= complaint.getId() %></td>
                    <td><%= complaint.getSubject() %></td>
                    <td><%= complaint.getDescription() %></td>
                    <td><%= complaint.getUserId() %></td>
                    <td><%= complaint.getDate_submitted() %></td>
                    <td>
            <span class="badge <%= complaint.getStatus().equals("Pending") ? "bg-warning" :
                complaint.getStatus().equals("In Progress") ? "bg-info" :
                complaint.getStatus().equals("Resolved") ? "bg-success" : "bg-danger" %>">
                <%= complaint.getStatus() %>
            </span>
                    </td>
                    <td>
                        <button class="btn btn-sm btn-primary view-btn" data-id="<%= complaint.getId() %>"
                                data-bs-toggle="modal" data-bs-target="#viewComplaintModal">
                            <i class="bi bi-eye"></i>
                        </button>
                        <button class="btn btn-sm btn-warning update-btn" data-id="<%= complaint.getId() %>"
                                data-bs-toggle="modal" data-bs-target="#updateStatusModal">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <button class="btn btn-sm btn-danger delete-btn" data-id="<%= complaint.getId() %>"
                                data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="7" class="text-center">No complaints found</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- View Complaint Modal -->
<div class="modal fade" id="viewComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Complaint Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Complaint details will be loaded here dynamically -->
                <div id="complaintDetails">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <p><strong>ID:</strong> <span id="viewId"></span></p>
                            <p><strong>Subject:</strong> <span id="viewSubject"></span></p>
                            <p><strong>Description:</strong> <span id="viewDescription"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Submitted By:</strong> <span id="viewUser"></span></p>
                            <p><strong>Date:</strong> <span id="viewDate"></span></p>
                            <p><strong>Status:</strong> <span id="viewStatus"></span></p>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Update Status Modal -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Complaint Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="updateStatusForm" action="${pageContext.request.contextPath}/admin/updateComplaint" method="post">
                <div class="modal-body">
                    <input type="hidden" id="complaintId" name="complaintId">

                    <div class="mb-3">
                        <label for="statusSelect" class="form-label">Status</label>
                        <select class="form-select" id="statusSelect" name="status" required>
                            <option value="Pending">Pending</option>
                            <option value="In Progress">In Progress</option>
                            <option value="Resolved">Resolved</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
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
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/deleteComplaint" method="post">
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