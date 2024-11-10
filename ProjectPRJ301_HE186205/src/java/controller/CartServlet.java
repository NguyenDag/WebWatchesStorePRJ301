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
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.CartTotal;
import org.apache.tomcat.dbcp.dbcp2.SQLExceptionList;

/**
 *
 * @author admin
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("account");

        // Kiểm tra xem người dùng có tồn tại hay không
        if (user == null || user.equals("")) {
            response.sendRedirect("login");
            return; // Kết thúc phương thức nếu không có người dùng
        }

        DAO d = new DAO();
        int accID;

        try {
            accID = user.getAccID(); // Lấy accID từ đối tượng user
        } catch (NullPointerException e) {
            // Xử lý trường hợp nếu user không có accID
            response.sendRedirect("login");
            return; // Kết thúc phương thức
        }

        try {
            List<CartTotal> list = d.getProductsFromCartByAccID(accID);
            request.setAttribute("list", list);
            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } catch (Exception e) {
            // Xử lý ngoại lệ (có thể ghi log hoặc thông báo lỗi cho người dùng)
            e.printStackTrace(); // Ghi log lỗi
            request.setAttribute("errorMessage", "An error occurred while retrieving cart items.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
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

        processRequest(request, response);
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
        processRequest(request, response);
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
