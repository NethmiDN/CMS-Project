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
                <c:forEach items="${userComplaints}" var="complaint">
                    <tr>
                        <td>${complaint.id}</td>
                        <td>${complaint.subject}</td>
                        <td>${complaint.description}</td>
                        <td>${complaint.date_submitted}</td>
                        <td>${complaint.status}</td>
                        <td>
                            <span class="badge ${complaint.status == 'Pending' ? 'bg-warning' :
                                complaint.status == 'In Progress' ? 'bg-info' :
                                complaint.status == 'Resolved' ? 'bg-success' : 'bg-danger'}">
                                    ${complaint.status}
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-primary view-btn" data-id="${complaint.id}"
                                    data-bs-toggle="modal" data-bs-target="#viewComplaintModal">
                                <i class="bi bi-eye"></i>
                            </button>

                            <c:if test="${complaint.status != 'Resolved' && complaint.status != 'Rejected'}">
                                <button class="btn btn-sm btn-warning edit-btn" data-id="${complaint.id}"
                                        data-bs-toggle="modal" data-bs-target="#editComplaintModal">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-sm btn-danger delete-btn" data-id="${complaint.id}"
                                        data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Your modals remain the same -->
<!-- New Complaint Modal -->
<div class="modal fade" id="newComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Submit New Complaint</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="newComplaintForm" action="${pageContext.request.contextPath}/employee/submitComplaint" method="post">
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
            </form>
        </div>
    </div>
</div>

<!-- Edit Complaint Modal -->
<div class="modal fade" id="editComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Complaint</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editComplaintForm" action="${pageContext.request.contextPath}/employee/updateComplaint" method="post">
                <div class="modal-body">
                    <input type="hidden" id="editComplaintId" name="complaintId">
                    <div class="mb-3">
                        <label for="editSubject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="editSubject" name="subject" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" rows="5" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Complaint</button>
                </div>
            </form>
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
                <div class="row mb-3">
                    <div class="col-md-6">
                        <p><strong>ID:</strong> <span id="viewId"></span></p>
                        <p><strong>Subject:</strong> <span id="viewSubject"></span></p>
                        <p><strong>Description:</strong> <span id="viewDescription"></span></p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Date:</strong> <span id="viewDate"></span></p>
                        <p><strong>Status:</strong> <span id="viewStatus"></span></p>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
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
<script src="${pageContext.request.contextPath}/js/employeeDashboard.js"></script>

</body>
</html>