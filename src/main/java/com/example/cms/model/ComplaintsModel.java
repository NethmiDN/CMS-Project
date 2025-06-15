package com.example.cms.model;

import com.example.cms.dto.Complaints;
import com.example.cms.util.DataSource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static com.example.cms.util.DataSource.getConnection;

public class ComplaintsModel {

    // Add a complaint
    public boolean addComplaint(Complaints complaint) {
        String sql = "INSERT INTO complaints ( user_id, subject, description, status,date_submitted) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaint.getUserId());
            ps.setString(2, complaint.getSubject());
            ps.setString(3, complaint.getDescription());
            ps.setString(4, complaint.getStatus());
            ps.setDate(5, (Date) complaint.getDate_submitted());

            System.out.println("Executing SQL: " + sql);
            System.out.println("With values: " + complaint.getSubject() + ", " + complaint.getDescription() + ", " + complaint.getStatus() + ", " + complaint.getUserId());

            int rows = ps.executeUpdate();
            System.out.println("Rows inserted: " + rows);

            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Update a complaint
    public void updateComplaint(Complaints complaint) {
        String sql = "UPDATE complaints SET subject=?, description=?, status=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, complaint.getSubject());
            ps.setString(2, complaint.getDescription());
            ps.setString(3, complaint.getStatus());
            ps.setInt(4, complaint.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateComplaintStatus(int id, String status) throws SQLException {
        String sql = "UPDATE complaints SET status = ? WHERE id = ?";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
//            stmt.setString(2, remarks);
            stmt.setInt(2, id);

            return stmt.executeUpdate() > 0;
        }
    }


    public boolean deleteComplaint(int complaintId) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "DELETE FROM complaints WHERE id = ?")) {

            statement.setInt(1, complaintId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting complaint: " + e.getMessage());
            return false;
        }
    }

    // Get a complaint by ID
    public Complaints getComplaintById(int id) throws SQLException {
        Complaints complaint = null;
        String sql = "SELECT * FROM complaints WHERE id = ?";
        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                complaint = new Complaints();
                complaint.setId(rs.getInt("id"));
                complaint.setSubject(rs.getString("subject"));
                complaint.setDescription(rs.getString("description"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setDate_submitted(rs.getDate("date_submitted"));
                complaint.setStatus(rs.getString("status"));
            }
        }
        return complaint;
    }


    public List<Complaints> getComplaintsByUserId(int userId) {
        List<Complaints> complaints = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM complaints WHERE user_id = ? ORDER BY id DESC")) {

            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Complaints complaint = mapComplaintFromResultSet(resultSet);
                    complaints.add(complaint);
                }
            }
            System.out.println("Retrieved " + complaints.size() + " complaints for user ID: " + userId);
        } catch (SQLException e) {
            System.err.println("Error retrieving complaints: " + e.getMessage());
            e.printStackTrace();
        }
        return complaints;
    }

    private Complaints mapComplaintFromResultSet(ResultSet resultSet) throws SQLException {
        Complaints complaint = new Complaints();
        complaint.setId(resultSet.getInt("id"));
        complaint.setUserId(resultSet.getInt("user_id"));
        complaint.setSubject(resultSet.getString("subject"));
        complaint.setDescription(resultSet.getString("description"));
        complaint.setDate_submitted(resultSet.getTimestamp("date_submitted"));
        complaint.setStatus(resultSet.getString("status"));
        return complaint;
    }

    // Get all complaints for a user
    public List<Complaints> getComplaintsByUser(String userId) {
        List<Complaints> list = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE user_id=? ORDER BY date_submitted DESC";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, Integer.parseInt(userId));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToComplaint(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Helper to map ResultSet to Complaints DTO
    private Complaints mapResultSetToComplaint(ResultSet rs) throws SQLException {
        Complaints c = new Complaints();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setSubject(rs.getString("subject"));
        c.setDescription(rs.getString("description"));
        c.setStatus(rs.getString("status"));
        c.setDate_submitted(rs.getTimestamp("date_submitted"));
        return c;
    }

    public List<Complaints> getAllComplaints() throws SQLException {
        List<Complaints> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints ORDER BY date_submitted DESC";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Complaints complaint = new Complaints();
                complaint.setId(rs.getInt("id"));
                complaint.setSubject(rs.getString("subject"));
                complaint.setDescription(rs.getString("description"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setDate_submitted(rs.getDate("date_submitted"));
                complaint.setStatus(rs.getString("status"));
//                complaint.setRemarks(rs.getString("remarks"));
                complaints.add(complaint);
            }
        }

        return complaints;
    }

    public boolean deleteComplaintById(int complaintId) {
        String sql = "DELETE FROM complaints WHERE complaint_id = ?";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaintId);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}
