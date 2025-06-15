package com.example.cms.controller;

import com.example.cms.dto.Complaints;
import com.example.cms.model.ComplaintsModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final ComplaintsModel complaintsModel = new ComplaintsModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        try {
            if (path != null && path.equals("/viewComplaint")) {
                // Handle viewing a single complaint
                int id = Integer.parseInt(request.getParameter("id"));
                Complaints complaint = complaintsModel.getComplaintById(id);
                request.setAttribute("complaint", complaint);

                request.getRequestDispatcher("/jsp/viewComplaint.jsp").forward(request, response);
            } else {
                // Default: load all complaints
                List<Complaints> complaintsList = complaintsModel.getAllComplaints();
                request.setAttribute("complaints", complaintsList);
                request.getRequestDispatcher("/jsp/AdminDashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));
            String status = request.getParameter("status");

            try {
                complaintsModel.updateComplaintStatus(complaintId, status);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } else if ("delete".equals(action)) {
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));

            complaintsModel.deleteComplaintById(complaintId);
        }

        // Redirect back to dashboard to reflect changes
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
