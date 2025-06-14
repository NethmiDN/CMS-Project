<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #f8f9fa;
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(135deg, #667eea, #764ba2) !important;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .navbar-nav .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            font-weight: 500;
            transition: color 0.3s, transform 0.2s;
            padding: 5px 15px;
        }

        .navbar-nav .nav-link:hover {
            color: #ffffff !important;
            transform: translateY(-2px);
        }

        .navbar-nav .nav-link.active {
            color: white !important;
            font-weight: 600;
        }

        .navbar .btn-light {
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            font-weight: 500;
            transition: all 0.3s;
        }

        .navbar .btn-light:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }

        .card {
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #4a5568;
            font-weight: 600;
            position: relative;
            margin-bottom: 10px;
        }

        h2:after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(to right, #667eea, #764ba2);
        }

        .status-pending {
            background-color: #fff8e1;
            border-left: 4px solid #ffc107;
        }

        .status-in-progress {
            background-color: #e3f2fd;
            border-left: 4px solid #2196f3;
        }

        .status-resolved {
            background-color: #e8f5e9;
            border-left: 4px solid #4caf50;
        }

        .status-rejected {
            background-color: #ffebee;
            border-left: 4px solid #f44336;
        }

        .btn {
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6ecc, #6a4391);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #718096;
            border: none;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff6b6b, #ee5253);
            border: none;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #ee5253, #d63031);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(238, 82, 83, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #feca57, #ff9f43);
            border: none;
            color: white;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #ff9f43, #ee8d2d);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 159, 67, 0.4);
            color: white;
        }

        .table {
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 12px;
            overflow: hidden;
        }

        .table th {
            background-color: #f8f9fa;
            border-top: none;
            color: #4a5568;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
            padding: 15px 10px;
        }

        .table tbody tr {
            transition: background-color 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        .badge {
            padding: 6px 10px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        .badge.bg-warning {
            background-color: #ffeaa7 !important;
            color: #b68c09;
        }

        .badge.bg-info {
            background-color: #81ecec !important;
            color: #0984e3;
        }

        .badge.bg-success {
            background-color: #55efc4 !important;
            color: #00b894;
        }

        .badge.bg-danger {
            background-color: #ff7675 !important;
            color: #d63031;
        }

        .form-control, .form-select {
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
        }

        .btn-group .btn {
            border: 1px solid;
            font-size: 13px;
        }

        .input-group .form-control {
            border-radius: 8px 0 0 8px;
        }

        .input-group .btn {
            border-radius: 0 8px 8px 0;
        }

        .modal-content {
            border-radius: 16px;
            border: none;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 16px 16px 0 0;
            border-bottom: none;
        }

        .modal-title {
            font-weight: 600;
        }

        .modal .btn-close {
            filter: brightness(0) invert(1);
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">Complaint Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Reports</a>
                </li>
            </ul>
            <div class="d-flex">
                    <span class="navbar-text me-3">
                        Welcome, ${sessionScope.username}
                    </span>
                <a href="${pageContext.request.contextPath}/Logout" class="btn btn-light btn-sm">Logout</a>
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

    <!-- Filters and Search -->
    <div class="row mb-4">
        <div class="col-md-8">
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-outline-primary active">All</button>
                <button type="button" class="btn btn-outline-warning">Pending</button>
                <button type="button" class="btn btn-outline-info">In Progress</button>
                <button type="button" class="btn btn-outline-success">Resolved</button>
                <button type="button" class="btn btn-outline-danger">Rejected</button>
            </div>
        </div>
        <div class="col-md-4">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search complaints..." id="searchInput">
                <button class="btn btn-outline-secondary" type="button">
                    <i class="bi bi-search"></i>
                </button>
            </div>
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
                    <th>Department</th>
                    <th>Submitted By</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${complaints}" var="complaint">
                    <tr>
                        <td>${complaint.id}</td>
                        <td>${complaint.subject}</td>
                        <td>${complaint.department}</td>
                        <td>${complaint.userName}</td>
                        <td>${complaint.dateSubmitted}</td>
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
                            <button class="btn btn-sm btn-warning update-btn" data-id="${complaint.id}"
                                    data-bs-toggle="modal" data-bs-target="#updateStatusModal">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-sm btn-danger delete-btn" data-id="${complaint.id}"
                                    data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
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
                            <p><strong>Department:</strong> <span id="viewDepartment"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Submitted By:</strong> <span id="viewUser"></span></p>
                            <p><strong>Date:</strong> <span id="viewDate"></span></p>
                            <p><strong>Status:</strong> <span id="viewStatus"></span></p>
                        </div>
                    </div>
                    <div class="mb-3">
                        <strong>Description:</strong>
                        <p id="viewDescription" class="p-2 border rounded"></p>
                    </div>
                    <div class="mb-3">
                        <strong>Admin Remarks:</strong>
                        <p id="viewRemarks" class="p-2 border rounded"></p>
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
                            <option value="Rejected">Rejected</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="remarks" class="form-label">Admin Remarks</label>
                        <textarea class="form-control" id="remarks" name="remarks" rows="4"></textarea>
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Update button click handlers
        document.querySelectorAll('.update-btn').forEach(button => {
            button.addEventListener('click', function() {
                const complaintId = this.getAttribute('data-id');
                document.getElementById('complaintId').value = complaintId;

                // You'd typically fetch the current status and remarks here via AJAX
                // For demo purposes, we'll just set the ID
            });
        });

        // Delete button click handlers
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const complaintId = this.getAttribute('data-id');
                document.getElementById('deleteComplaintId').value = complaintId;
            });
        });

        // View button click handlers
        document.querySelectorAll('.view-btn').forEach(button => {
            button.addEventListener('click', function() {
                const complaintId = this.getAttribute('data-id');
                // Fetch complaint details via AJAX and populate the modal
                // For demo purposes, this is empty
            });
        });
    });
</script>
</body>
</html>