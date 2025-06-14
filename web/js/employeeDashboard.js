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