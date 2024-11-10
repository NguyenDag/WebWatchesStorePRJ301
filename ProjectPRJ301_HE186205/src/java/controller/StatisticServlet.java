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
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name = "TopProStatisticServlet", urlPatterns = {"/statistic"})
public class StatisticServlet extends HttpServlet {

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
            out.println("<title>Servlet TopProStatisticServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TopProStatisticServlet at " + request.getContextPath() + "</h1>");
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
        String year_raw = request.getParameter("year");
        String month_raw = request.getParameter("month");
        String orderid_raw = request.getParameter("orderid");
        String sttid_raw = request.getParameter("sttid");
        int month=0, year=0;
        int orderid=0;
        int sttid=0;
        try {
            orderid = Integer.parseInt(orderid_raw);
            sttid = Integer.parseInt(sttid_raw);
        } catch (NumberFormatException e) {
        }
        DAO d = new DAO();
        d.updateStatusOrderAmin(sttid, orderid);
        
        try {
            month = Integer.parseInt(month_raw);
            year = Integer.parseInt(year_raw);
            
            
        } catch (NumberFormatException e) {
        }
        log("str order: "+orderid_raw);
        log("order id: "+String.valueOf(orderid));
        log(String.valueOf(sttid));
        
        
        List<Product> list;
        if (month == 0 && year == 0) {
            list = d.getTop3Sale();
        } else {
            list = d.getTop3SaleOfProducts(year, month);
        }
        double revenue = d.getRevenue();
        int numAcc = d.getNumAccount();
        
        List<Order> listOrders = d.getListOrders();
        double revenue2020 = d.getRevenueByYear(2020);
        double revenue2021 = d.getRevenueByYear(2021);
        double revenue2022 = d.getRevenueByYear(2022);
        double revenue2023 = d.getRevenueByYear(2023);
        double revenue2024 = d.getRevenueByYear(2024);

        double revenue01 = d.getRevenueByMonth(1);
        double revenue02 = d.getRevenueByMonth(2);
        double revenue03 = d.getRevenueByMonth(3);
        double revenue04 = d.getRevenueByMonth(4);
        double revenue05 = d.getRevenueByMonth(5);
        double revenue06 = d.getRevenueByMonth(6);
        double revenue07 = d.getRevenueByMonth(7);
        double revenue08 = d.getRevenueByMonth(8);
        double revenue09 = d.getRevenueByMonth(9);
        double revenue10 = d.getRevenueByMonth(10);
        double revenue11 = d.getRevenueByMonth(11);
        double revenue12 = d.getRevenueByMonth(12);

        int numOrder2020 = d.getTotalOrderByYear(2020);
        int numOrder2021 = d.getTotalOrderByYear(2021);
        int numOrder2022 = d.getTotalOrderByYear(2022);
        int numOrder2023 = d.getTotalOrderByYear(2023);
        int numOrder2024 = d.getTotalOrderByYear(2024);

        int numOrder01 = d.getTotalOrderByMonth(1);
        int numOrder02 = d.getTotalOrderByMonth(2);
        int numOrder03 = d.getTotalOrderByMonth(3);
        int numOrder04 = d.getTotalOrderByMonth(4);
        int numOrder05 = d.getTotalOrderByMonth(5);
        int numOrder06 = d.getTotalOrderByMonth(6);
        int numOrder07 = d.getTotalOrderByMonth(7);
        int numOrder08 = d.getTotalOrderByMonth(8);
        int numOrder09 = d.getTotalOrderByMonth(9);
        int numOrder10 = d.getTotalOrderByMonth(10);
        int numOrder11 = d.getTotalOrderByMonth(11);
        int numOrder12 = d.getTotalOrderByMonth(12);
        
        request.setAttribute("listOrders", listOrders);
        request.setAttribute("list1", list);
        request.setAttribute("revenue", revenue);
        request.setAttribute("numAcc", numAcc);
        request.setAttribute("revenue2020", revenue2020);
        request.setAttribute("revenue2021", revenue2021);
        request.setAttribute("revenue2022", revenue2022);
        request.setAttribute("revenue2023", revenue2023);
        request.setAttribute("revenue2024", revenue2024);
        request.setAttribute("revenue01", revenue01);
        request.setAttribute("revenue02", revenue02);
        request.setAttribute("revenue03", revenue03);
        request.setAttribute("revenue04", revenue04);
        request.setAttribute("revenue05", revenue05);
        request.setAttribute("revenue06", revenue06);
        request.setAttribute("revenue07", revenue07);
        request.setAttribute("revenue08", revenue08);
        request.setAttribute("revenue09", revenue09);
        request.setAttribute("revenue10", revenue10);
        request.setAttribute("revenue11", revenue11);
        request.setAttribute("revenue12", revenue12);

        request.setAttribute("numOrder2020", numOrder2020);
        request.setAttribute("numOrder2021", numOrder2021);
        request.setAttribute("numOrder2022", numOrder2022);
        request.setAttribute("numOrder2023", numOrder2023);
        request.setAttribute("numOrder2024", numOrder2024);

        request.setAttribute("numOrder01", numOrder01);
        request.setAttribute("numOrder02", numOrder02);
        request.setAttribute("numOrder03", numOrder03);
        request.setAttribute("numOrder04", numOrder04);
        request.setAttribute("numOrder05", numOrder05);
        request.setAttribute("numOrder06", numOrder06);
        request.setAttribute("numOrder07", numOrder07);
        request.setAttribute("numOrder08", numOrder08);
        request.setAttribute("numOrder09", numOrder09);
        request.setAttribute("numOrder10", numOrder10);
        request.setAttribute("numOrder11", numOrder11);
        request.setAttribute("numOrder12", numOrder12);

        request.getRequestDispatcher("statistic.jsp").forward(request, response);
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
        String year_raw = request.getParameter("year");
        String month_raw = request.getParameter("month");
        int month = 0, year = 0;
        DAO d = new DAO();

        try {
            month = Integer.parseInt(month_raw);
            year = Integer.parseInt(year_raw);

        } catch (NumberFormatException e) {
        }
        List<Product> list;
        if (month == 0 && year == 0) {
            list = d.getTop3Sale();
        } else {
            list = d.getTop3SaleOfProducts(year, month);
        }
        request.setAttribute("list1", list);
        request.getRequestDispatcher("statistic.jsp").forward(request, response);
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
