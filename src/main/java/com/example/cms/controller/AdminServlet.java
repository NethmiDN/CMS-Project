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
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Validate admin access
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        String pathInfo = req.getPathInfo();
        String path = pathInfo == null ? "" : pathInfo;

        // Handle get complaint details for modals
        if ("/getComplaint".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            ComplaintsModel complaintsModel = new ComplaintsModel();
            Complaints complaint = complaintsModel.getComplaintById(id);

            if (complaint != null) {
                resp.setContentType("application/json");
                resp.getWriter().write(complaint.toJson());
                return;
            }
        } else {
            // Debug output
            System.out.println("AdminServlet: Processing GET request");

            // Get all complaints
            ComplaintsModel complaintsModel = new ComplaintsModel();
            List<Complaints> complaints = complaintsModel.getAllComplaints();

            // Debug output
            System.out.println("AdminServlet: Retrieved " + complaints.size() + " complaints");

            // Set the complaints as request attribute
            req.setAttribute("complaints", complaints);

            // Forward to the dashboard JSP
            req.getRequestDispatcher("/jsp/AdminDashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Validate admin access
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        String pathInfo = req.getPathInfo();
        String path = pathInfo == null ? "" : pathInfo;

        ComplaintsModel complaintsModel = new ComplaintsModel();

        if ("/updateComplaint".equals(path)) {
            // Handle complaint status update
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            String status = req.getParameter("status");

            // Debug the parameters
            System.out.println("Updating complaint: ID=" + complaintId + ", Status=" + status);

            boolean success = complaintsModel.updateComplaintStatus(complaintId, status, "");

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin?error=updateFailed");
            }
        } else if ("/deleteComplaint".equals(path)) {
            // Handle complaint deletion
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));  // Changed from deleteComplaintId

            boolean success = complaintsModel.deleteComplaint(complaintId);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin?error=deleteFailed");
            }
        }
    }
}