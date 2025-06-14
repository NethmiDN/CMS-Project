document.addEventListener('DOMContentLoaded', function() {
    // View complaint details
    document.querySelectorAll('.view-btn').forEach(button => {
        button.addEventListener('click', function() {
            const complaintId = this.getAttribute('data-id');
            fetch(`${contextPath}/employee/getComplaint?id=${complaintId}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('viewId').textContent = data.id;
                    document.getElementById('viewSubject').textContent = data.subject;
                    document.getElementById('viewDescription').textContent = data.description;
                    document.getElementById('viewDate').textContent = data.date_submitted;
                    document.getElementById('viewStatus').textContent = data.status;
                })
                .catch(error => console.error('Error fetching complaint details:', error));
        });
    });

    // Edit complaint
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function() {
            const complaintId = this.getAttribute('data-id');
            document.getElementById('editComplaintId').value = complaintId;

            // Fetch current data to fill the form
            fetch(`${contextPath}/employee/getComplaint?id=${complaintId}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('editSubject').value = data.subject;
                    document.getElementById('editDescription').value = data.description;
                })
                .catch(error => console.error('Error fetching complaint details:', error));
        });
    });

    // Delete complaint
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function() {
            const complaintId = this.getAttribute('data-id');
            document.getElementById('deleteComplaintId').value = complaintId;
        });
    });
});