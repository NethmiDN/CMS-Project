document.addEventListener('DOMContentLoaded', function() {
    // View complaint details
    document.querySelectorAll('.view-btn').forEach(button => {
        button.addEventListener('click', function() {
            const complaintId = this.getAttribute('data-id');
            fetch(`${contextPath}/admin/getComplaint?id=${complaintId}`)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('viewId').textContent = data.id;
                    document.getElementById('viewSubject').textContent = data.subject;
                    document.getElementById('viewDescription').textContent = data.description;
                    document.getElementById('viewUser').textContent = data.userId;
                    document.getElementById('viewDate').textContent = data.date_submitted;
                    document.getElementById('viewStatus').textContent = data.status;
                })
                .catch(error => console.error('Error fetching complaint details:', error));
        });
    });

    // Update complaint status
    document.querySelectorAll('.update-btn').forEach(button => {
        button.addEventListener('click', function() {
            const complaintId = this.getAttribute('data-id');
            document.getElementById('complaintId').value = complaintId;

            // Optional: Pre-fill current status in the modal
            const row = this.closest('tr');
            const status = row.querySelector('td:nth-child(6) span').textContent.trim();
            const statusSelect = document.getElementById('statusSelect');

            for(let i = 0; i < statusSelect.options.length; i++) {
                if(statusSelect.options[i].value === status) {
                    statusSelect.selectedIndex = i;
                    break;
                }
            }
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