<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<html>
<head>
    <title>Employee Dashboard</title>
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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 600;
            letter-spacing: 0.5px;
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

        .card-title {
            color: #4a5568;
            font-size: 16px;
            font-weight: 500;
        }

        .card-text {
            font-weight: 600;
            font-size: 24px;
            margin-top: 8px;
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

        .table {
            border-collapse: separate;
            border-spacing: 0;
        }

        .table th {
            background-color: #f8f9fa;
            border-top: none;
            color: #4a5568;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
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
            color: white;
            filter: brightness(0) invert(1);
        }

        .form-label {
            color: #4a5568;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
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
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                        New Complaint
                    </a>
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
    <!-- Rest of your code remains the same -->
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

    <!-- Status Summary Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center bg-light">
                <div class="card-body">
                    <h5 class="card-title">Total Complaints</h5>
                    <h2 class="card-text">${totalComplaints}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center status-pending">
                <div class="card-body">
                    <h5 class="card-title">Pending</h5>
                    <h2 class="card-text">${pendingComplaints}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center status-in-progress">
                <div class="card-body">
                    <h5 class="card-title">In Progress</h5>
                    <h2 class="card-text">${inProgressComplaints}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center status-resolved">
                <div class="card-body">
                    <h5 class="card-title">Resolved</h5>
                    <h2 class="card-text">${resolvedComplaints}</h2>
                </div>
            </div>
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
                        <td>${complaint.department}</td>
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
                        <label for="department" class="form-label">Department</label>
                        <select class="form-select" id="department" name="department" required>
                            <option value="">Select Department</option>
                            <option value="HR">Human Resources</option>
                            <option value="IT">Information Technology</option>
                            <option value="Finance">Finance</option>
                            <option value="Operations">Operations</option>
                            <option value="Facilities">Facilities</option>
                            <option value="Other">Other</option>
                        </select>
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
                        <label for="editDepartment" class="form-label">Department</label>
                        <select class="form-select" id="editDepartment" name="department" required>
                            <option value="HR">Human Resources</option>
                            <option value="IT">Information Technology</option>
                            <option value="Finance">Finance</option>
                            <option value="Operations">Operations</option>
                            <option value="Facilities">Facilities</option>
                            <option value="Other">Other</option>
                        </select>
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
                        <p><strong>Department:</strong> <span id="viewDepartment"></span></p>
                    </div>
                    <div class="col-md-6">
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Edit button click handlers
        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function() {
                const complaintId = this.getAttribute('data-id');
                document.getElementById('editComplaintId').value = complaintId;

                // Fetch complaint data via AJAX and populate the form
                fetch('${pageContext.request.contextPath}/employee/getComplaint?id=' + complaintId)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('editSubject').value = data.subject;
                        document.getElementById('editDepartment').value = data.department;
                        document.getElementById('editDescription').value = data.description;
                    })
                    .catch(error => console.error('Error:', error));
            });
        });

        // View button click handlers
        document.querySelectorAll('.view-btn').forEach(button => {
            button.addEventListener('click', function() {
                const complaintId = this.getAttribute('data-id');

                // Fetch and display complaint details
                fetch('${pageContext.request.contextPath}/employee/getComplaint?id=' + complaintId)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('viewId').textContent = data.id;
                        document.getElementById('viewSubject').textContent = data.subject;
                        document.getElementById('viewDepartment').textContent = data.department;
                        document.getElementById('viewDate').textContent = data.dateSubmitted;
                        document.getElementById('viewStatus').textContent = data.status;
                        document.getElementById('viewDescription').textContent = data.description;
                        document.getElementById('viewRemarks').textContent = data.remarks || 'No remarks yet';
                    })
                    .catch(error => console.error('Error:', error));
            });
        });

        // Delete button click handlers
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function() {
                const complaintId = this.getAttribute('data-id');
                document.getElementById('deleteComplaintId').value = complaintId;
            });
        });
    });
</script>
</body>
</html>