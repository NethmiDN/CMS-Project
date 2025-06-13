package com.example.cms.controller;

import com.example.cms.dto.User;
import com.example.cms.model.UserModel;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/Signin")
public class SignInServlet extends HttpServlet {

    @Override


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new UserModel().login(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("username",user.getUsername());
            session.setAttribute("id", user.getId());
            session.setAttribute("role", user.getRole());
            // Remove this line
            // resp.sendRedirect("/jsp/AdminDashboard.jsp");
            // Keep this line
            resp.sendRedirect(req.getContextPath() + "/jsp/AdminDashboard.jsp");
        } else {
            // Fix this to properly redirect with an error message
            resp.sendRedirect(req.getContextPath() + "/jsp/signin.jsp?error=Invalid+username+or+password");
        }
    }
}
