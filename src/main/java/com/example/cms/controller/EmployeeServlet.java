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

@WebServlet("/employee/*")
public class EmployeeServlet extends HttpServlet {
    private ComplaintsModel complaintsModel;

    @Override
    public void init() {
        complaintsModel = new ComplaintsModel();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        if ("/viewComplaint".equals(path)) {
            int id = Integer.parseInt(req.getParameter("complaintId"));
            Complaints complaint = null;
            try {
                complaint = complaintsModel.getComplaintById(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.setAttribute("complaint", complaint);
            req.getRequestDispatcher("/jsp/viewComplaint.jsp").forward(req, resp);
            return;
        }

        if ("/editComplaintForm".equals(path)) {
            int id = Integer.parseInt(req.getParameter("complaintId"));
            Complaints complaint = null;
            try {
                complaint = complaintsModel.getComplaintById(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.setAttribute("complaint", complaint);
            req.getRequestDispatcher("/jsp/editComplaint.jsp").forward(req, resp);
            return;
        }

        // Default: show dashboard
        List<Complaints> userComplaints = complaintsModel.getComplaintsByUser(String.valueOf(user.getId()));
        req.setAttribute("userComplaints", userComplaints);
        req.getRequestDispatcher("/jsp/EmployeeDashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"EMPLOYEE".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        switch (path) {
            case "/submitComplaint":
                String subject = req.getParameter("subject");
                String description = req.getParameter("description");

                if (subject == null || subject.trim().isEmpty() || description == null || description.trim().isEmpty()) {
                    req.setAttribute("error", "Subject and description are required.");
                    List<Complaints> userComplaints = complaintsModel.getComplaintsByUser(String.valueOf(user.getId()));
                    req.setAttribute("userComplaints", userComplaints);
                    req.getRequestDispatcher("/jsp/EmployeeDashboard.jsp").forward(req, resp);
                    break;
                }

                try {
                    Complaints newComplaint = new Complaints();
                    newComplaint.setSubject(subject);
                    newComplaint.setDescription(description);
                    newComplaint.setStatus("Pending");
                    newComplaint.setUserId(user.getId());
                    newComplaint.setDate_submitted(new java.util.Date()); // Set date here

                    boolean success = complaintsModel.addComplaint(newComplaint);
                    if (success) {
                        session.setAttribute("msg", "Complaint submitted successfully.");
                        resp.sendRedirect(req.getContextPath() + "/employee");
                    } else {
                        req.setAttribute("error", "Failed to submit complaint. Please try again.");
                        List<Complaints> userComplaints = complaintsModel.getComplaintsByUser(String.valueOf(user.getId()));
                        req.setAttribute("userComplaints", userComplaints);
                        req.getRequestDispatcher("/jsp/EmployeeDashboard.jsp").forward(req, resp);
                    }
                } catch (Exception e) {
                    throw new ServletException("Error submitting complaint", e);
                }

                break;

            case "/updateComplaint":
                int editId = Integer.parseInt(req.getParameter("complaintId"));
                Complaints existingComplaint = null;
                try {
                    existingComplaint = complaintsModel.getComplaintById(editId);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (existingComplaint != null && existingComplaint.getUserId() == user.getId()) {
                    existingComplaint.setSubject(req.getParameter("subject"));
                    existingComplaint.setDescription(req.getParameter("description"));
                    complaintsModel.updateComplaint(existingComplaint);
                }
                resp.sendRedirect(req.getContextPath() + "/employee");
                break;

            case "/deleteComplaint":
                int deleteId = Integer.parseInt(req.getParameter("complaintId"));
                Complaints toDelete = null;
                try {
                    toDelete = complaintsModel.getComplaintById(deleteId);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (toDelete != null && toDelete.getUserId() == user.getId() &&
                        !toDelete.getStatus().equalsIgnoreCase("Resolved") &&
                        !toDelete.getStatus().equalsIgnoreCase("Rejected")) {
                    complaintsModel.deleteComplaint(deleteId);
                }
                resp.sendRedirect(req.getContextPath() + "/employee");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/employee");
                break;
        }
    }
}