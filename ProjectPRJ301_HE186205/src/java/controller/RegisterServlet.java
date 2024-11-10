/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import model.Account;

/**
 *
 * @author admin
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        String gender = request.getParameter("gender");
        DAO d = new DAO();
        try {
            if (fullname.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty()
                      || username.trim().isEmpty() || password.trim().isEmpty() || cpassword.trim().isEmpty()) {
                request.setAttribute("error", "Please fill in all fields");
                request.setAttribute("fullname", fullname);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("username", username);
                request.setAttribute("gender", gender);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (phone.trim().length() != 10 && phone.trim().length() != 11) {
                request.setAttribute("error", "Please enter a valid phone number (10 or 11 digits)");
                request.setAttribute("fullname", fullname);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("username", username);
                request.setAttribute("gender", gender);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (!password.equals(cpassword)) {
                request.setAttribute("error", "Passwords do not match");
                request.setAttribute("fullname", fullname);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("username", username);
                request.setAttribute("gender", gender);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            Account user = d.checkAccountOfUser(username);
            if (user != null) {
                request.setAttribute("error", "Username already exists");
                request.setAttribute("fullname", fullname);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.setAttribute("username", username);
                request.setAttribute("gender", gender);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            } else {
                Account newUser = new Account();
                newUser.setUsername(username);
                newUser.setAccAddress(address);
                newUser.setAccname(fullname);
                newUser.setCusEmail(email);
                newUser.setCusPhone(phone);
                newUser.setPassword(password);
                newUser.setGender(gender);
                d.addAccount(newUser);
                response.sendRedirect(request.getContextPath() + "/login");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi
            request.setAttribute("error", "Database error. Please try again.");
            request.setAttribute("fullname", fullname);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("username", username);
            request.setAttribute("gender", gender);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
