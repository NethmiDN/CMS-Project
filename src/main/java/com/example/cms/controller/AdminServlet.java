package com.example.cms.controller;

import com.example.cms.dto.Complaints;
import com.example.cms.dto.User;
import com.example.cms.model.ComplaintsModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final ComplaintsModel complaintsModel = new ComplaintsModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all complaints from DB
        List<Complaints> complaintsList = null;
        try {
            complaintsList = complaintsModel.getAllComplaints();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("complaints", complaintsList);

        // Forward to the admin dashboard JSP
        request.getRequestDispatcher("/jsp/AdminDashboard.jsp").forward(request, response);
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
