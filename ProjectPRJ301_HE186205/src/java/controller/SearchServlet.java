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
import model.Category;
import model.ImageProduct;
import model.MainImageProduct;
import model.Product;
import model.Supplier;

/**
 *
 * @author admin
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath() + "</h1>");
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

        DAO d = new DAO();

    // Lấy tất cả các giá trị cho supplier và category
    String[] selectedSuppliers = request.getParameterValues("supplier");
    String[] selectedCategories = request.getParameterValues("category");

    List<Supplier> suplist = d.getALLSuppliers();
    List<Category> catlist = d.getAll();
    List<Product> products1 = d.getAllProducts();
    String sort = request.getParameter("sort");

    // Xử lý sắp xếp
    if (sort != null) {
        if (sort.equals("1")) {
            products1 = d.getAllProductsSortedByPrice();
        } else if (sort.equals("2")) {
            products1 = d.getAllProductsSortedByOrdered();
        }
    }

    // Phân trang
    int page, numperpage = 9;
    int size = products1.size();
    int num = (size % numperpage == 0 ? (size / numperpage) : (size / numperpage + 1));
    String xpage = request.getParameter("page");
    page = (xpage == null) ? 1 : Integer.parseInt(xpage);

    int start = (page - 1) * numperpage;
    int end = Math.min(page * numperpage, size);
    
    // Lọc sản phẩm theo selectedSuppliers và selectedCategories
    if (selectedSuppliers != null && selectedCategories != null) {
        products1 = d.getSearchProducts(selectedSuppliers, selectedCategories);
    }

    // Lấy danh sách sản phẩm theo trang
    List<Product> products = d.getListByPage(products1, start, end);
    List<MainImageProduct> topsale = d.getTopSaleForProduct();
    List<MainImageProduct> flashsale = d.getFlashSaleForProduct();

    // Cài đặt các thuộc tính cho JSP
    request.setAttribute("page", page);
    request.setAttribute("num", num);
    request.setAttribute("topsale", topsale);
    request.setAttribute("flashsale", flashsale);
    request.setAttribute("products", products);
    request.setAttribute("suplist", suplist);
    request.setAttribute("catlist", catlist);
    request.setAttribute("selectedSuppliers", selectedSuppliers);
    request.setAttribute("selectedCategories", selectedCategories);

    request.getRequestDispatcher("product.jsp").forward(request, response);
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
    
    // Lấy tất cả các giá trị cho supplier và category
    String[] selectedSuppliers = request.getParameterValues("supplier");
    String[] selectedCategories = request.getParameterValues("category");

    List<Supplier> suplist = d.getALLSuppliers();
    List<Category> catlist = d.getAll();
    String input = request.getParameter("searchPro");
    List<MainImageProduct> topsale = d.getTopSaleForProduct();
    List<MainImageProduct> flashsale = d.getFlashSaleForProduct();

    request.setAttribute("topsale", topsale);
    request.setAttribute("flashsale", flashsale);
    List<Product> products1 = new ArrayList<>();

    try {
        // Kiểm tra và xử lý tìm kiếm
        if (selectedSuppliers != null && selectedCategories != null) {
            products1 = d.getSearchProducts(selectedSuppliers, selectedCategories);
        } else {
            products1 = d.getAllProducts(); // Nếu không có lựa chọn nào
        }

        // Tìm kiếm theo tên sản phẩm
        if (input != null && !input.isEmpty()) {
            products1 = d.getProductsByProName(input);
        }

        // Phân trang
        int page, numperpage = 9;
        int size = products1.size();
        int num = (size % numperpage == 0 ? (size / numperpage) : (size / numperpage + 1));
        String xpage = request.getParameter("page");
        page = (xpage == null) ? 1 : Integer.parseInt(xpage);
        
        int start = (page - 1) * numperpage;
        List<Product> products = d.getListByPage(products1, start, Math.min(page * numperpage, size));

        // Cài đặt các thuộc tính cho JSP
        request.setAttribute("page", page);
        request.setAttribute("num", num);
        request.setAttribute("products", products);
        request.setAttribute("suplist", suplist);
        request.setAttribute("catlist", catlist);
        request.setAttribute("selectedSuppliers", selectedSuppliers);
        request.setAttribute("selectedCategories", selectedCategories);
    } catch (NumberFormatException e) {
        e.printStackTrace(); // Xử lý lỗi nếu có
    }

    request.getRequestDispatcher("product.jsp").forward(request, response);
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
