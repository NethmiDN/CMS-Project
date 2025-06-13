package com.example.cms.controller;

import com.example.cms.dto.User;
import com.example.cms.model.UserModel;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/Signup")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean success = new UserModel().register(user);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/jsp/signin.jsp");
//            resp.sendRedirect("/signin.jsp?message=Registration successful! Please log in.");
        } else {
            resp.sendRedirect("signup.jsp?error=Registration failed. Please try again.");
        }
    }
}
