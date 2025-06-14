document.addEventListener('DOMContentLoaded', function() {
    // View complaint details
    document.querySelectorAll('.view-btn').forEach(button => {
        button.addEventListener('click', function() {
            const complaintId = this.getAttribute('data-id');

            // Debug output
            console.log(`Viewing complaint with ID: ${complaintId}`);

            fetch(`${document.querySelector('meta[name="contextPath"]').getAttribute('content')}/admin/getComplaint?id=${complaintId}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Received complaint data:', data);
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

            // Debug output
            console.log(`Setting complaint ID for update: ${complaintId}`);

            document.getElementById('complaintId').value = complaintId;

            // Get current status from table row
            const statusText = this.closest('tr').querySelector('td:nth-child(6) span').textContent.trim();
            const statusSelect = document.getElementById('statusSelect');

            console.log(`Current status: ${statusText}`);

            // Set the current status in the dropdown
            for(let i = 0; i < statusSelect.options.length; i++) {
                if(statusSelect.options[i].text === statusText) {
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