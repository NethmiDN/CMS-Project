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
        String sql = "INSERT INTO complaints (user_id, subject, description, status, date_submitted) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, complaint.getUserId());
            ps.setString(2, complaint.getSubject());
            ps.setString(3, complaint.getDescription());
            ps.setString(4, complaint.getStatus());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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

    // Delete a complaint
    public void deleteComplaint(int id) {
        String sql = "DELETE FROM complaints WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get a complaint by ID
    public Complaints getComplaintById(int id) {
        String sql = "SELECT * FROM complaints WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapComplaintFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
}
