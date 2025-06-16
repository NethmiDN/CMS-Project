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

        if ("/editComplaintForm".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("complaintId"));
                Complaints complaint = complaintsModel.getComplaintById(id);

                if (complaint == null || complaint.getUserId() != user.getId()) {
                    session.setAttribute("error", "Complaint not found or access denied.");
                    resp.sendRedirect(req.getContextPath() + "/employee");
                    return;
                }

                req.setAttribute("complaint", complaint);
                req.getRequestDispatcher("/jsp/editComplaint.jsp").forward(req, resp);
            } catch (Exception e) {
                session.setAttribute("error", "Invalid complaint ID.");
                resp.sendRedirect(req.getContextPath() + "/employee");
            }
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
            case "/updateComplaint":
                try {
                    int complaintId = Integer.parseInt(req.getParameter("complaintId"));
                    Complaints existing = complaintsModel.getComplaintById(complaintId);

                    if (existing != null && existing.getUserId() == user.getId()) {
                        if (existing.getStatus().equalsIgnoreCase("Resolved") || existing.getStatus().equalsIgnoreCase("Rejected")) {
                            session.setAttribute("error", "Cannot edit resolved or rejected complaints.");
                            resp.sendRedirect(req.getContextPath() + "/employee");
                            return;
                        }

                        existing.setSubject(req.getParameter("subject"));
                        existing.setDescription(req.getParameter("description"));

                        if (complaintsModel.updateComplaint(existing)) {
                            session.setAttribute("msg", "Complaint updated successfully.");
                        } else {
                            session.setAttribute("error", "Update failed.");
                        }
                    } else {
                        session.setAttribute("error", "Invalid complaint or access denied.");
                    }

                    resp.sendRedirect(req.getContextPath() + "/employee");

                } catch (Exception e) {
                    session.setAttribute("error", "An error occurred: " + e.getMessage());
                    resp.sendRedirect(req.getContextPath() + "/employee");
                }
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/employee");
                break;
        }
    }
}
