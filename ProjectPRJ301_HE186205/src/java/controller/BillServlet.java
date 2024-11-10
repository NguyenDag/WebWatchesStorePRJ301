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
import model.Account;

/**
 *
 * @author admin
 */
@WebServlet(name = "BillServlet", urlPatterns = {"/bill"})
public class BillServlet extends HttpServlet {

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
            out.println("<title>Servlet BillServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BillServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("bill.jsp").forward(request, response);
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
        DAO d = new DAO();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("account");
//        String recipientName = request.getParameter("recipientName");
//        String address = request.getParameter("address");
//        String phone = request.getParameter("phone");
        String totalPricer = request.getParameter("totalPrice");
//        String message = request.getParameter("message");
        String payment = request.getParameter("payment");
        String shipID_raw = request.getParameter("shipIDvalue");
        double totalPrice = 0;
        int shipID=0;
        int orderID;
        // Lặp qua các sản phẩm và lưu vào bảng Orders
        int i = 0;
        try {
            totalPrice = Double.parseDouble(totalPricer);
            shipID = Integer.parseInt(shipID_raw);
            //them vao orders
            
        } catch (NumberFormatException e) {
        }
        orderID = d.addOrderIntoOrderTable(user.getAccID(), totalPrice, 1, shipID);
            System.out.println("orderID== :" + orderID);
            System.out.println("orderID1== :" + user.getAccID());
            System.out.println("orderID2== :" + totalPrice);
            System.out.println("orderID3== :" + shipID);
        
        while (true) {
            String productID = request.getParameter("productID_" + i);
            if (productID == null) {
                break; // Nếu không còn sản phẩm nào thì dừng lại
            }
            String productPrice = request.getParameter("productPrice_" + i);
            String productQuantity = request.getParameter("productQuantity_" + i);

            // Thực hiện các thao tác cần thiết để lưu thông tin đơn hàng vào bảng Orders
            try {
                //them vao orderdetails
                d.addOrderIntoOrderDetails(orderID, Integer.parseInt(productID), Double.parseDouble(productPrice), Integer.parseInt(productQuantity));
                d.deleteCart(user.getAccID(), Integer.parseInt(productID));
            } catch (NumberFormatException e) {
            }
            i++;
        }
        //them vao infor payment
        d.addOrderIntoPaymentInfor(orderID, payment, totalPrice);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("orderID", orderID);
        // Chuyển hướng về trang thanh toán thành công hoặc thực hiện các xử lý khác
        request.getRequestDispatcher("bill.jsp").forward(request, response);
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
