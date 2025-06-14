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
import java.util.Enumeration;
import java.util.List;

@WebServlet("/employee/*")
public class EmployeeServlet extends HttpServlet {
    private ComplaintsModel complaintsModel;

    @Override
    public void init() {
        complaintsModel = new ComplaintsModel();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        if ("/getComplaint".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Complaints complaint = complaintsModel.getComplaintById(id);
            resp.setContentType("application/json");
            resp.getWriter().write(complaint.toJson());
            return;
        }

        // Default: show dashboard
        List<Complaints> userComplaints = complaintsModel.getComplaintsByUserId(Integer.parseInt(String.valueOf(user.getId())));
        req.setAttribute("userComplaints", userComplaints);
        req.getRequestDispatcher("/jsp/EmployeeDashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        HttpSession session = req.getSession();

        // Debug session before attempting to get user
        System.out.println("Session ID: " + session.getId());

        // Print all session attributes
        Enumeration<String> attributeNames = session.getAttributeNames();
        System.out.println("All session attributes:");
        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            System.out.println("  " + name + " = " + session.getAttribute(name));
        }

        // Get user from session - try different possible attribute names
        User user = (User) session.getAttribute("user");

        // If user is null, try other common attribute names
        if (user == null) {
            user = (User) session.getAttribute("loggedInUser");
        }

        // Enhanced debug info
        System.out.println("User from session: " + (user == null ? "NULL" :
                "ID: " + user.getId() + ", Role: '" + user.getRole() + "'"));

        // Case-insensitive role check
        if (user == null || (!"EMPLOYEE".equalsIgnoreCase(user.getRole()) &&
                !"employee".equalsIgnoreCase(user.getRole()))) {
            System.out.println("User validation failed - redirecting to index");
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        if ("/submitComplaint".equals(path)) {
            String subject = req.getParameter("subject");
            String description = req.getParameter("description");
            Complaints complaint = new Complaints();
            complaint.setSubject(subject);
            complaint.setDescription(description);
            complaint.setStatus("Pending");
            complaint.setUserId(user.getId());

            boolean success = complaintsModel.addComplaint(complaint);
            if (success) {
                // Change this redirect to match your servlet mapping
                resp.sendRedirect(req.getContextPath() + "/employee");
            } else {
                resp.sendRedirect(req.getContextPath() + "/employee?error=fail");
            }
        }else if ("/updateComplaint".equals(path)) {
            int id = Integer.parseInt(req.getParameter("complaintId"));
            String subject = req.getParameter("subject");
            String description = req.getParameter("description");
            String status = req.getParameter("status");
            Complaints complaint = complaintsModel.getComplaintById(id);
            complaint.setSubject(subject);
            complaint.setDescription(description);
            if (status != null) {
                complaint.setStatus(status);
            }
            complaintsModel.updateComplaint(complaint);
            resp.sendRedirect(req.getContextPath() + "/employee");
        } else if ("/deleteComplaint".equals(path)) {
            int id = Integer.parseInt(req.getParameter("complaintId"));
            complaintsModel.deleteComplaint(id);
            resp.sendRedirect(req.getContextPath() + "/employee");
        }
    }
}