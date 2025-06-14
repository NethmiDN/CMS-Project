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