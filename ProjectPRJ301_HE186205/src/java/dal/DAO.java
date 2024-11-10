/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import model.Account;
import model.Cart;
import model.CartTotal;
import model.Category;
import model.ImageProduct;
import model.MainImageProduct;
import model.Order;
import model.OrderStatus;
import model.Product;
import model.ProductReview;
import model.ReviewsTotal;
import model.Shipping;
import model.Supplier;

/**
 *
 * @author admin
 */
public class DAO extends DBContext {

    //check authen
    public Account checkAuthen(String username, String password) throws SQLException {
        String sql = "SELECT [accID]\n"
                  + "      ,[username]\n"
                  + "      ,[password]\n"
                  + "      ,[role]\n"
                  + "      ,[accname]\n"
                  + "      ,[accAddress]\n"
                  + "      ,[cusPhone]\n"
                  + "      ,[cusEmail]\n"
                  + "      ,[avatar]\n"
                  + "      ,[gender]"
                  + "  FROM [dbo].[Accounts]\n"
                  + "    where username=? and password = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("accID"));
                acc.setUsername(username);
                acc.setPassword(password);
                acc.setRole(rs.getBoolean("role"));
                acc.setAccname(rs.getString("accname"));
                acc.setAccAddress(rs.getString("accAddress"));
                acc.setCusPhone(rs.getString("cusPhone"));
                acc.setCusEmail(rs.getString("cusEmail"));
                acc.setAvatar(rs.getString("avatar"));
                acc.setGender(rs.getString("gender"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //lay tat ca acc
    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT [accID]\n"
                  + "      ,[username]\n"
                  + "      ,[password]\n"
                  + "      ,[role]\n"
                  + "      ,[accname]\n"
                  + "      ,[accAddress]\n"
                  + "      ,[cusPhone]\n"
                  + "      ,[cusEmail]\n"
                  + "      ,[avatar]\n"
                  + "      ,[gender]\n"
                  + "  FROM [dbo].[Accounts]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("accID"));
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password"));
                acc.setRole(rs.getBoolean("role"));
                acc.setAccname(rs.getString("accname"));
                acc.setAccAddress(rs.getString("accAddress"));
                acc.setCusPhone(rs.getString("cusPhone"));
                acc.setCusEmail(rs.getString("cusEmail"));
                acc.setAvatar(rs.getString("avatar"));
                acc.setGender(rs.getString("gender"));
                list.add(acc);
            }
            return list;
        } catch (SQLException e) {
        }

        return null;
    }

    public Account getAccountByAccID(int accID) {
        String sql = "SELECT [accID]\n"
                  + "      ,[username]\n"
                  + "      ,[password]\n"
                  + "      ,[role]\n"
                  + "      ,[accname]\n"
                  + "      ,[accAddress]\n"
                  + "      ,[cusPhone]\n"
                  + "      ,[cusEmail]\n"
                  + "      ,[avatar]\n"
                  + "      ,[gender]\n"
                  + "  FROM [dbo].[Accounts]\n"
                  + "  WHERE [accID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("accID"));
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password"));
                acc.setRole(rs.getBoolean("role"));
                acc.setAccname(rs.getString("accname"));
                acc.setAccAddress(rs.getString("accAddress"));
                acc.setCusPhone(rs.getString("cusPhone"));
                acc.setCusEmail(rs.getString("cusEmail"));
                acc.setAvatar(rs.getString("avatar"));
                acc.setGender(rs.getString("gender"));
                return acc;
            }
        } catch (SQLException e) {
        }

        return null;
    }

    //get user by email
    public Account getAccountBycusEmail(String cusEmail) {
        String sql = "SELECT [accID]\n"
                  + "      ,[username]\n"
                  + "      ,[password]\n"
                  + "      ,[role]\n"
                  + "      ,[accname]\n"
                  + "      ,[accAddress]\n"
                  + "      ,[cusPhone]\n"
                  + "      ,[cusEmail]\n"
                  + "      ,[avatar]\n"
                  + "      ,[gender]\n"
                  + "  FROM [dbo].[Accounts]\n"
                  + "  WHERE [cusEmail] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cusEmail);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("accID"));
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password"));
                acc.setRole(rs.getBoolean("role"));
                acc.setAccname(rs.getString("accname"));
                acc.setAccAddress(rs.getString("accAddress"));
                acc.setCusPhone(rs.getString("cusPhone"));
                acc.setCusEmail(cusEmail);
                acc.setAvatar(rs.getString("avatar"));
                acc.setGender(rs.getString("gender"));
                return acc;
            }
        } catch (SQLException e) {
        }

        return null;
    }

    //doc ca bang ra select List
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT [catID]\n"
                  + "      ,[catName]\n"
                  + "      ,[catDescription]\n"
                  + "  FROM [dbo].[Categories]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setCatID(rs.getInt("catID"));
                c.setCatName(rs.getString("catName"));
                c.setCatDescription(rs.getString("catDescription"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //get a category by id
    public Category getCategoryById(int catID) {
        String sql = "SELECT [catID]\n"
                  + "      ,[catName]\n"
                  + "      ,[catDescription]\n"
                  + "  FROM [dbo].[Categories]\n"
                  + "  WHERE [catID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, catID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Category c = new Category();
                c.setCatID(rs.getInt("catID"));
                c.setCatName(rs.getString("catName"));
                c.setCatDescription(rs.getString("catDescription"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //get all supplier 
    public List<Supplier> getALLSuppliers() {
        List<Supplier> list = new ArrayList<>();
        String sql = "SELECT [supID]\n"
                  + "      ,[supName]\n"
                  + "      ,[supAddress]\n"
                  + "      ,[supPhone]\n"
                  + "      ,[supEmail]\n"
                  + "  FROM [dbo].[Suppliers]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Supplier s = new Supplier();
                s.setSupID(rs.getInt("supID"));
                s.setSupName(rs.getString("supName"));
                s.setSupAddress(rs.getString("supAddress"));
                s.setSupPhone(rs.getString("supPhone"));
                s.setSupEmail(rs.getString("supEmail"));
                list.add(s);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //get a supplier by id
    public Supplier getSupplierById(int supID) {
        String sql = "SELECT [supID]\n"
                  + "      ,[supName]\n"
                  + "      ,[supAddress]\n"
                  + "      ,[supPhone]\n"
                  + "      ,[supEmail]\n"
                  + "  FROM [dbo].[Suppliers]\n"
                  + "  WHERE [supID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, supID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Supplier s = new Supplier();
                s.setSupID(rs.getInt("supID"));
                s.setSupName(rs.getString("supName"));
                s.setSupAddress(rs.getString("supAddress"));
                s.setSupPhone(rs.getString("supPhone"));
                s.setSupEmail(rs.getString("supEmail"));
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder], unitsOrdered, [discount]\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();

                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));

                list.add(d);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //lấy 10 sản phẩm sale
    public List<Product> getTopSaleProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP 10 \n"
                  + "      [proID],\n"
                  + "      [proName],\n"
                  + "      [catID],\n"
                  + "      [supID],\n"
                  + "      [proDescription],\n"
                  + "      [quantityPerUnit],\n"
                  + "      [unitPrice],\n"
                  + "      [unitsInStock],\n"
                  + "      [unitsOnOrder], unitsOrdered,[discount]\n"
                  + "      [discontinued]\n"
                  + "FROM [dbo].[Products]\n"
                  + "ORDER BY [unitsOnOrder] DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();

                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));

                list.add(d);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //lấy sản phẩm theo loại(Category)
    public List<Product> getProductsByCatID(int catID) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder], unitsOrdered, [discount]\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n"
                  + "  WHERE [catID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, catID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();

                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(catID));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));

                list.add(d);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //sap xep san pham theo gia
    public List<Product> getAllProductsSortedByPrice() {
        List<Product> list = new ArrayList<>();
        DAO d = new DAO();
        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder]\n"
                  + "      ,[unitsOrdered]\n"
                  + "      ,[discount]\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n"
                  + "  ORDER BY [unitPrice] ASC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProID(rs.getInt("proID"));
                product.setProName(rs.getString("proName"));
                product.setCatID(d.getCategoryById(rs.getInt("catID")));
                product.setSupID(d.getSupplierById(rs.getInt("supID")));
                product.setProDescription(rs.getString("proDescription"));
                product.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                product.setUnitPrice(rs.getDouble("unitPrice"));
                product.setUnitsInStock(rs.getInt("unitsInStock"));
                product.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                product.setUnitsOrdered(rs.getInt("unitsOrdered"));
                product.setDiscount(rs.getInt("discount"));
                product.setDiscontinued(rs.getBoolean("discontinued"));

                list.add(product);
            }
            return list;
        } catch (SQLException e) {
        }

        return null;
    }

    //sap xep san pham theo ordered
    public List<Product> getAllProductsSortedByOrdered() {
        List<Product> list = new ArrayList<>();
        DAO d = new DAO();
        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder]\n"
                  + "      ,[unitsOrdered]\n"
                  + "      ,[discount]\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n"
                  + "  ORDER BY [unitsOrdered] DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProID(rs.getInt("proID"));
                product.setProName(rs.getString("proName"));
                product.setCatID(d.getCategoryById(rs.getInt("catID")));
                product.setSupID(d.getSupplierById(rs.getInt("supID")));
                product.setProDescription(rs.getString("proDescription"));
                product.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                product.setUnitPrice(rs.getDouble("unitPrice"));
                product.setUnitsInStock(rs.getInt("unitsInStock"));
                product.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                product.setUnitsOrdered(rs.getInt("unitsOrdered"));
                product.setDiscount(rs.getInt("discount"));
                product.setDiscontinued(rs.getBoolean("discontinued"));

                list.add(product);
            }
            return list;
        } catch (SQLException e) {
        }

        return null;
    }

    //lấy sản phẩm theo proID
    public Product getProductsByProID(int proID) {

        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder], unitsOrdered, discount\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n"
                  + "  WHERE [proID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, proID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product d = new Product();

                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));
                return d;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //lấy sản phẩm theo nhà sản xuất
    public List<Product> getProductsBySupID(int supID) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder], unitsOrdered, discount\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n"
                  + "  WHERE [supID] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, supID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();

                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(supID));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));

                list.add(d);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //lay san pham theo category(lien quan den product.jsp)
    public List<Product> getSearchProducts(String[] supNames, String[] catNames) {
    List<Product> listProducts = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT p.[proID]\n"
            + "      ,p.[proName]\n"
            + "      ,p.[catID]\n"
            + "      ,p.[supID]\n"
            + "      ,p.[proDescription]\n"
            + "      ,p.[quantityPerUnit]\n"
            + "      ,p.[unitPrice]\n"
            + "      ,p.[unitsInStock]\n"
            + "      ,p.[unitsOnOrder], unitsOrdered\n"
            + "      ,p.[discount]\n"
            + "      ,p.[discontinued]\n"
            + "	   ,s.supName\n"
            + "  FROM [dbo].[Products] p JOIN Suppliers s ON p.supID = s.supID\n"
            + "       JOIN Categories c ON p.catID = c.catID\n"
            + "  WHERE 1=1 ");

    // Đếm số lượng tham số
    int paramIndex = 1;

    // Kiểm tra nếu có nhà cung cấp nào được chọn
    if (supNames != null && supNames.length > 0 && !supNames[0].equals("All")) {
        sql.append(" AND s.supName IN (");
        for (int i = 0; i < supNames.length; i++) {
            sql.append("?");
            if (i < supNames.length - 1) {
                sql.append(", ");
            }
        }
        sql.append(") ");
    }

    // Kiểm tra nếu có danh mục nào được chọn
    if (catNames != null && catNames.length > 0 && !catNames[0].equals("All")) {
        sql.append(" AND c.catName IN (");
        for (int i = 0; i < catNames.length; i++) {
            sql.append("?");
            if (i < catNames.length - 1) {
                sql.append(", ");
            }
        }
        sql.append(") ");
    }

    try {
        PreparedStatement st = connection.prepareStatement(sql.toString());

        // Đặt tham số cho suppliers
        if (supNames != null && supNames.length > 0 && !supNames[0].equals("All")) {
            for (String supName : supNames) {
                st.setString(paramIndex++, supName);
            }
        }

        // Đặt tham số cho categories
        if (catNames != null && catNames.length > 0 && !catNames[0].equals("All")) {
            for (String catName : catNames) {
                st.setString(paramIndex++, catName);
            }
        }

        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Product d = new Product();
            d.setProID(rs.getInt("proID"));
            d.setProName(rs.getString("proName"));
            d.setCatID(getCategoryById(rs.getInt("catID")));
            d.setSupID(getSupplierById(rs.getInt("supID")));
            d.setProDescription(rs.getString("proDescription"));
            d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
            d.setUnitPrice(rs.getDouble("unitPrice"));
            d.setUnitsInStock(rs.getInt("unitsInStock"));
            d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
            d.setUnitsOrdered(rs.getInt("unitsOrdered"));
            d.setDiscount(rs.getInt("discount"));
            d.setDiscontinued(rs.getBoolean("discontinued"));

            listProducts.add(d);
        }
        return listProducts;
    } catch (SQLException e) {
        e.printStackTrace(); // In ra lỗi nếu có
    }

    return listProducts; // Trả về danh sách sản phẩm, có thể rỗng
}

    public List<Product> getProductsByProName(String proName) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT [proID]\n"
                  + "      ,[proName]\n"
                  + "      ,[catID]\n"
                  + "      ,[supID]\n"
                  + "      ,[proDescription]\n"
                  + "      ,[quantityPerUnit]\n"
                  + "      ,[unitPrice]\n"
                  + "      ,[unitsInStock]\n"
                  + "      ,[unitsOnOrder]\n"
                  + "      ,[unitsOrdered]\n"
                  + "      ,[discount]\n"
                  + "      ,[discontinued]\n"
                  + "  FROM [dbo].[Products]\n"
                  + "  WHERE [proName] LIKE ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + proName + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();
                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));
                list.add(d);
            }
            return list;
        } catch (SQLException e) {
        }

        return null;
    }

    public List<Product> getListByPage(List<Product> list, int start, int end) {
        List<Product> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    //check chon node All ch
    public boolean isAllSelected(String[] selectedProducts) {
        for (String product : selectedProducts) {
            if (product.equals("All")) {
                return true;
            }
        }
        return false;
    }

    //Lay anh cho san pham
    public List<ImageProduct> getImagesForProductByProID(int proID) {
        List<ImageProduct> listImages = new ArrayList<>();
        String sql = "SELECT [imgID]\n"
                  + "      ,[proID]\n"
                  + "      ,[imgURL]\n"
                  + "      ,[imgDescription]\n"
                  + "      ,[isRepresentative]\n"
                  + "  FROM [dbo].[ProductImages]\n"
                  + "	where proID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, proID);
            ResultSet rs = st.executeQuery();
            DAO d = new DAO();
            while (rs.next()) {
                ImageProduct ip = new ImageProduct();
                ip.setImgID(rs.getInt("imgID"));
                ip.setProID(d.getProductsByProID(proID));
                ip.setImgURL(rs.getString("imgURL"));
                ip.setImgDescription(rs.getString("imgDescription"));
                ip.setIsRepresentative(rs.getBoolean("isRepresentative"));
                listImages.add(ip);
            }
        } catch (Exception e) {
        }
        return listImages;
    }

    //Lay anh DAI DIEN cho san pham
    public ImageProduct getMainImageForProduct(int proID, boolean isRepresentative) {
        String sql = "SELECT [imgID]\n"
                  + "      ,[proID]\n"
                  + "      ,[imgURL]\n"
                  + "      ,[imgDescription]\n"
                  + "      ,[isRepresentative]\n"
                  + "  FROM [dbo].[ProductImages]\n"
                  + "	where proID = ? and isRepresentative = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, proID);
            st.setBoolean(2, isRepresentative);
            ResultSet rs = st.executeQuery();
            DAO d = new DAO();
            while (rs.next()) {
                ImageProduct ip = new ImageProduct();
                ip.setImgID(rs.getInt("imgID"));
                ip.setProID(d.getProductsByProID(proID));
                ip.setImgURL(rs.getString("imgURL"));
                ip.setImgDescription(rs.getString("imgDescription"));
                ip.setIsRepresentative(isRepresentative);
                return ip;
            }
        } catch (Exception e) {
        }
        return null;
    }

    //Lay anh main cho san pham tu java class MainImageProduct
    public List<MainImageProduct> getTopSaleForProduct() {
        List<MainImageProduct> list = new ArrayList<>();
        String sql = "SELECT top 10 p.[proID]\n"
                  + "      ,p.[proName]\n"
                  + "      ,p.[catID]\n"
                  + "      ,p.[supID]\n"
                  + "      ,p.[proDescription]\n"
                  + "      ,p.[quantityPerUnit]\n"
                  + "      ,p.[unitPrice]\n"
                  + "      ,p.[unitsInStock]\n"
                  + "      ,p.[unitsOnOrder], p.unitsOrdered, p.discount\n"
                  + "      ,p.[discontinued]\n"
                  + "	  ,proimg.[imgID]\n"
                  + "      ,proimg.[imgURL]\n"
                  + "      ,proimg.[imgDescription]\n"
                  + "      ,proimg.[isRepresentative]\n"
                  + "  FROM [dbo].[Products] p join [dbo].[ProductImages] proimg on p.proID = proimg.proID\n"
                  + "  where proimg.[isRepresentative] = 1\n"
                  + "  order by p.[unitsOrdered] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            DAO d = new DAO();
            while (rs.next()) {
                MainImageProduct i = new MainImageProduct();
                i.setProID(rs.getInt("proID"));
                i.setProName(rs.getString("proName"));
                i.setCatID(getCategoryById(rs.getInt("catID")));
                i.setSupID(getSupplierById(rs.getInt("supID")));
                i.setProDescription(rs.getString("proDescription"));
                i.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                i.setUnitPrice(rs.getDouble("unitPrice"));
                i.setUnitsInStock(rs.getInt("unitsInStock"));
                i.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                i.setUnitsOrdered(rs.getInt("unitsOrdered"));
                i.setDiscount(rs.getInt("discount"));
                i.setDiscontinued(rs.getBoolean("discontinued"));
                i.setImgID(rs.getInt("imgID"));
                i.setImgURL(rs.getString("imgURL"));
                i.setImgDescription(rs.getString("imgDescription"));
                i.setIsRepresentative(rs.getBoolean("isRepresentative"));

                list.add(i);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //Lay flash sale cho san pham tu java class MainImageProduct
    public List<MainImageProduct> getFlashSaleForProduct() {
        List<MainImageProduct> list = new ArrayList<>();
        String sql = "SELECT top 10 p.[proID]\n"
                  + "      ,p.[proName]\n"
                  + "      ,p.[catID]\n"
                  + "      ,p.[supID]\n"
                  + "      ,p.[proDescription]\n"
                  + "      ,p.[quantityPerUnit]\n"
                  + "      ,p.[unitPrice]\n"
                  + "      ,p.[unitsInStock]\n"
                  + "      ,p.[unitsOnOrder], p.unitsOrdered, p.discount\n"
                  + "      ,p.[discontinued]\n"
                  + "	  ,proimg.[imgID]\n"
                  + "      ,proimg.[imgURL]\n"
                  + "      ,proimg.[imgDescription]\n"
                  + "      ,proimg.[isRepresentative]\n"
                  + "  FROM [dbo].[Products] p join [dbo].[ProductImages] proimg on p.proID = proimg.proID\n"
                  + "  where proimg.[isRepresentative] = 1\n"
                  + "  order by p.[discount] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            DAO d = new DAO();
            while (rs.next()) {
                MainImageProduct i = new MainImageProduct();
                i.setProID(rs.getInt("proID"));
                i.setProName(rs.getString("proName"));
                i.setCatID(getCategoryById(rs.getInt("catID")));
                i.setSupID(getSupplierById(rs.getInt("supID")));
                i.setProDescription(rs.getString("proDescription"));
                i.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                i.setUnitPrice(rs.getDouble("unitPrice"));
                i.setUnitsInStock(rs.getInt("unitsInStock"));
                i.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                i.setUnitsOrdered(rs.getInt("unitsOrdered"));
                i.setDiscount(rs.getInt("discount"));
                i.setDiscontinued(rs.getBoolean("discontinued"));
                i.setImgID(rs.getInt("imgID"));
                i.setImgURL(rs.getString("imgURL"));
                i.setImgDescription(rs.getString("imgDescription"));
                i.setIsRepresentative(rs.getBoolean("isRepresentative"));

                list.add(i);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //lay rate cua moi san pham
    public List<ReviewsTotal> getRateForProducts() {
        List<ReviewsTotal> list = new ArrayList<>();
        String sql = "SELECT \n"
                  + "    proID,\n"
                  + "    AVG(revRating) AS averageRating\n"
                  + "FROM \n"
                  + "    ProductReviews\n"
                  + "GROUP BY \n"
                  + "    proID;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ReviewsTotal rt = new ReviewsTotal();
                rt.setProID(getProductsByProID(rs.getInt("proID")));
                rt.setRevRating(rs.getInt("averageRating"));
                list.add(rt);
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    //lay rate cua moi san pham
    public ReviewsTotal getRateForProductByProID(int proID) {
        String sql = "SELECT \n"
                  + "    proID,\n"
                  + "    AVG(revRating) AS averageRating\n"
                  + "FROM \n"
                  + "    ProductReviews\n"
                  + "WHERE proID = ? \n GROUP BY \n"
                  + "    proID;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, proID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ReviewsTotal rt = new ReviewsTotal();
                rt.setProID(getProductsByProID(rs.getInt("proID")));
                rt.setRevRating(rs.getInt("averageRating"));
                return rt;
            }
        } catch (Exception e) {
        }
        return null;
    }

    //check tai khoan nguoi dung da ton tai chua
    public Account checkAccountOfUser(String username) throws SQLException {
        Account acc = new Account();
        String sql = "SELECT [accID]\n"
                  + "      ,[username]\n"
                  + "      ,[password]\n"
                  + "      ,[role]\n"
                  + "      ,[accname]\n"
                  + "      ,[accAddress]\n"
                  + "      ,[cusPhone]\n"
                  + "      ,[cusEmail]\n"
                  + "      ,[avatar]\n"
                  + "      ,[gender]\n"
                  + "  FROM [dbo].[Accounts]\n"
                  + "  WHERE username = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                acc.setAccID(rs.getInt("accID"));
                acc.setUsername(username);
                acc.setPassword(rs.getString("password"));
                acc.setRole(rs.getBoolean("role"));
                acc.setAccname(rs.getString("accname"));
                acc.setAccAddress(rs.getString("accAddress"));
                acc.setCusPhone(rs.getString("cusPhone"));
                acc.setCusEmail(rs.getString("cusEmail"));
                acc.setGender(rs.getString("gender"));
                acc.setAvatar(rs.getString("avatar"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //danh cho admin quan ly All
    public List<CartTotal> getProductsFromCart() {
        List<CartTotal> list = new ArrayList<>();
        String sql = "  SELECT \n"
                  + "    accID,\n"
                  + "    proID,\n"
                  + "    SUM(quantity) AS totalQuantity\n"
                  + "    FROM Watches_Store.dbo.Cart\n"
                  + "    GROUP BY \n"
                  + "    accID, proID";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CartTotal ct = new CartTotal();
                ct.setAccID(getAccountByAccID(rs.getInt("accID")));
                ct.setProID(getProductsByProID(rs.getInt("proID")));
                ct.setTotalQuantity(rs.getInt("totalQuantity"));
                list.add(ct);
            }
            return list;
        } catch (Exception e) {
        }

        return null;
    }

    //danh cho tung user
    public List<CartTotal> getProductsFromCartByAccID(Integer accID) {
        List<CartTotal> list = new ArrayList<>();
        String sql = "SELECT accID,\n"
                  + "         proID,\n"
                  + "         SUM(quantity) AS totalQuantity\n"
                  + "  FROM \n"
                  + "     Watches_Store.dbo.Cart\n"
                  + "  WHERE \n"
                  + "     accID = ? \n"
                  + "  GROUP BY \n"
                  + "     accID, proID;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (accID != null) {
                st.setInt(1, accID); // Sử dụng setInt để đặt giá trị cho accID

                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    CartTotal ct = new CartTotal();
                    ct.setAccID(getAccountByAccID(rs.getInt("accID")));
                    ct.setProID(getProductsByProID(rs.getInt("proID")));
                    ct.setTotalQuantity(rs.getInt("totalQuantity"));
                    list.add(ct);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi để dễ debug
        }

        return list; // Trả về danh sách
    }

    //danh cho bill
    public CartTotal getProductFromCartByProID(int proID) {
        String sql = "SELECT accID,\n"
                  + "         proID,\n"
                  + "         SUM(quantity) AS totalQuantity\n"
                  + "  FROM \n"
                  + "     Watches_Store.dbo.Cart\n"
                  + "  WHERE \n"
                  + "     proID = ? \n"
                  + "  GROUP BY \n"
                  + "     accID, proID;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, proID); // Sử dụng setInt để đặt giá trị cho accID

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                CartTotal ct = new CartTotal();
                ct.setAccID(getAccountByAccID(rs.getInt("accID")));
                ct.setProID(getProductsByProID(rs.getInt("proID")));
                ct.setTotalQuantity(rs.getInt("totalQuantity"));
                return ct;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại lỗi để dễ debug
        }

        return null; // Trả về danh sách
    }

    public List<Shipping> getAllShippings() {
        List<Shipping> list = new ArrayList<>();
        String sql = "SELECT [shipID]\n"
                  + "      ,[shipMethod]\n"
                  + "      ,[shipCost]\n"
                  + "      ,[shipDate]\n"
                  + "  FROM [dbo].[Shipping]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Shipping s = new Shipping();
                s.setShipID(rs.getInt("shipID"));
                s.setShipCost(rs.getDouble("shipCost"));
                s.setShipMethod(rs.getString("shipMethod"));
                s.setShipDate(rs.getString("shipDate"));
                list.add(s);
            }
            return list;
        } catch (SQLException e) {
        }
        return null;
    }

    //add tai khoan moi vao DATABASE
    public void addAccount(Account acc) throws SQLException {
        String sql = "INSERT INTO [dbo].[Accounts] "
                  + "([username], [password], [role], [accname], [accAddress], [cusPhone], [cusEmail], [gender]) "
                  + "VALUES (?, ?, 1, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            //hoan thanh xong phan add account
            st.setString(1, acc.getUsername());
            st.setString(2, acc.getPassword());
            st.setString(3, acc.getAccname());
            st.setString(4, acc.getAccAddress());
            st.setString(5, acc.getCusPhone());
            st.setString(6, acc.getCusEmail());
            st.setString(7, acc.getGender());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateAccount(Account acc) {
        String sql = "UPDATE Accounts\n"
                  + "SET \n"
                  + "    username = ?,\n"
                  + "    [password] = ?,\n"
                  + "    [role] = ?,\n"
                  + "    accname = ?,\n"
                  + "    accAddress = ?,\n"
                  + "    cusPhone = ?,\n"
                  + "    cusEmail = ?,\n"
                  + "    avatar = ?,\n"
                  + "    gender = ?\n"
                  + "WHERE accID = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            //hoan thanh xong phan add account
            st.setString(1, acc.getUsername());
            st.setString(2, acc.getPassword());
            st.setBoolean(3, acc.isRole());
            st.setString(4, acc.getAccname());
            st.setString(5, acc.getAccAddress());
            st.setString(6, acc.getCusPhone());
            st.setString(7, acc.getCusEmail());
            st.setString(8, acc.getAvatar());
            st.setString(9, acc.getGender());
            st.setInt(10, acc.getAccID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //cap nhat mat khau
    public void updatePassword(int accID, String password) {
        String sql = "UPDATE Accounts\n"
                  + "SET [password] = ?,\n"
                  + "WHERE accID = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setInt(2, accID);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addProductToStore(String proName, int cat, int supID,
              String quantityPerUnit, double unitPrice, int unitsInStock) {
        String sql = "INSERT INTO Products (\n"
                  + "  proName, \n"
                  + "  catID, \n"
                  + "  supID, \n"
                  + "  proDescription, \n"
                  + "  quantityPerUnit, \n"
                  + "  unitPrice, \n"
                  + "  unitsInStock, \n"
                  + "  unitsOnOrder, \n"
                  + "  unitsOrdered, \n"
                  + "  discount, \n"
                  + "  discontinued\n"
                  + ") VALUES\n"
                  + "  (?, ?, ?, 'hhh', ?, ?, ?, 0, 0, 0, 1);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, proName);
            st.setInt(2, cat);
            st.setInt(3, supID);
            st.setString(4, quantityPerUnit);
            st.setDouble(5, unitPrice);
            st.setInt(6, unitsInStock);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addProductToCart(int accID, int proID, int quantity) {
        String sql = "INSERT INTO Cart (accID, proID, quantity) VALUES (?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accID);
            st.setInt(2, proID);
            st.setInt(3, quantity);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public int addOrderIntoOrderTable(int accID, double totalCost, int sttID, int shipID) {
        String sql = "INSERT INTO Orders (\n"
                  + "    accID, \n"
                  + "    totalCost, \n"
                  + "    sttID, \n"
                  + "    shipID\n"
                  + ") VALUES \n"
                  + "(?, ?, ?, ?);";
        int orderID = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setInt(1, accID);
            st.setDouble(2, totalCost);
            st.setInt(3, sttID);
            st.setInt(4, shipID);
            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                // Lấy khóa tự động được tạo ra
                try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderID = generatedKeys.getInt(1); // Lấy orderID vừa được tạo
                    }
                }
            }
        } catch (SQLException e) {
        }
        return orderID;
    }

    public void addOrderIntoOrderDetails(int orderID, int proID, double unitPrice, int quantity) {
        String sql = "INSERT INTO OrderDetails (orderID, proID, unitPrice, quantity)\n"
                  + "VALUES\n"
                  + "    (?, ?, ?, ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            st.setInt(2, proID);
            st.setDouble(3, unitPrice);
            st.setInt(4, quantity);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addOrderIntoPaymentInfor(int orderID, String payMethod, double payAmount) {
        String sql = "INSERT INTO PaymentInformation (orderID, payMethod, payAmount)\n"
                  + "VALUES\n"
                  + "    (?, ?, ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            st.setString(2, payMethod);
            st.setDouble(3, payAmount);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteProduct(int proID) {
        String sql = "DELETE FROM [dbo].[Cart]\n"
                  + "      WHERE proID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, proID);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteCart(int accID, int proID) {
        String sql = "DELETE FROM [dbo].[Cart]\n"
                  + "      WHERE accID = ? and proID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accID);
            st.setInt(2, proID);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteProductAdmin(int proID) {
        String sql = "DECLARE @proID INT = ?;\n"
                  + "\n"
                  + "DELETE FROM ProductReviews\n"
                  + "WHERE proID = @proID;\n"
                  + "\n"
                  + "DELETE FROM ProductImages\n"
                  + "WHERE proID = @proID;\n"
                  + "\n"
                  + "DELETE FROM OrderDetails\n"
                  + "WHERE proID = @proID;\n"
                  + "\n"
                  + "DELETE FROM Cart\n"
                  + "WHERE proID = @proID;\n"
                  + "\n"
                  + "DELETE FROM Products\n"
                  + "WHERE proID = @proID;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, proID);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateProduct(int proID, String proName, int catID, int supID,
              String quantityPerUnit, double unitPrice, int unitsInStock, String prodes,
              boolean discontinued) {
        String sql = "UPDATE [Watches_Store].[dbo].[Products] SET "
                  + "proName = ?, catID = ?, supID = ?, [proDescription] = ?, "
                  + "quantityPerUnit = ?, unitPrice = ?, unitsInStock = ?, "
                  + " discontinued = ? WHERE proID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, proName);
            st.setInt(2, catID);
            st.setInt(3, supID);
            st.setString(4, prodes);
            st.setString(5, quantityPerUnit);
            st.setDouble(6, unitPrice);
            st.setInt(7, unitsInStock);
            st.setBoolean(8, discontinued);
            st.setInt(9, proID);

            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateProductAmin(int proID, String proName,
              String quantityPerUnit, double unitPrice, int unitsInStock,
              boolean discontinued) {
        String sql = "UPDATE [Watches_Store].[dbo].[Products]\n"
                  + "SET \n"
                  + "    [proName] = ?,\n"
                  + "    [quantityPerUnit] = ?,\n"
                  + "    [unitPrice] = ?,\n"
                  + "    [unitsInStock] = ?,\n"
                  + "    [discontinued] = ?\n"
                  + "WHERE \n"
                  + "    [proID] = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, proName);
            st.setString(2, quantityPerUnit);
            st.setDouble(3, unitPrice);
            st.setInt(4, unitsInStock);
            st.setBoolean(5, discontinued);
            st.setInt(6, proID);

            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateQuantityOfProduct(int accID, int proID, int quantity) {
        String sql = "UPDATE Cart\n"
                  + "SET quantity = ? \n"
                  + "WHERE cartID = (\n"
                  + "    SELECT TOP 1 cartID\n"
                  + "    FROM Cart\n"
                  + "    WHERE proID = ? AND accID=?\n"
                  + ");";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, proID);
            st.setInt(3, accID);
            st.executeUpdate();

        } catch (SQLException e) {
        }
    }

    //set lai role cho user
    public void updateRole(int accID) {
        String sql = "UPDATE Accounts\n"
                  + "SET [role] = 0\n"
                  + "WHERE accID = " + accID;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public int getTotalProductsInCartByAccID(int accID) {
        String sql = "SELECT COUNT(DISTINCT proID) AS totalproducts\n"
                  + "FROM Cart\n"
                  + "WHERE accID = ?\n"
                  + "GROUP BY accID;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accID);
            ResultSet rs = st.executeQuery();

            // Check if there is a result
            if (rs.next()) {
                Integer num = rs.getInt("totalproducts");
                return (num != null) ? num : 0;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
        }
        return 0; // Return 0 if no records found or an exception occurred
    }

    //lay tong san pham
    public int getTotalProducts() {
        String sql = "SELECT COUNT(proID) AS totalproducts FROM Products;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            // Check if there is a result
            if (rs.next()) {
                Integer num = rs.getInt("totalproducts");
                return (num != null) ? num : 0;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
        }
        return 0; // Return 0 if no records found or an exception occurred
    }

    //lay san pham theo category
    public int getTotalProductsByCatID(int catID) {
        String sql = "SELECT COUNT(proID) AS totalproducts FROM Products WHERE catID = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, catID);
            ResultSet rs = st.executeQuery();

            // Check if there is a result
            if (rs.next()) {
                Integer num = rs.getInt("totalproducts");
                return (num != null) ? num : 0;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
        }
        return 0; // Return 0 if no records found or an exception occurred
    }

    //lay san pham theo supplier
    public int getTotalProductsBySupID(int supID) {
        String sql = "SELECT COUNT(proID) AS totalproducts FROM Products WHERE supID = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, supID);
            ResultSet rs = st.executeQuery();

            // Check if there is a result
            if (rs.next()) {
                Integer num = rs.getInt("totalproducts");
                return (num != null) ? num : 0;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
        }
        return 0; // Return 0 if no records found or an exception occurred
    }

    //-----------------------------------------------------------------------------
    //cac ham xu ly phan statistic(statistic.jsp)
    public double getRevenue() {
        String sql = "select sum(totalCost) as revenue from Orders";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            if (rs.next()) { // Kiểm tra xem có dữ liệu không
                return rs.getDouble("revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lại thông tin lỗi
        }
        return 0;
    }

    //ham lấy số tài khoản user
    public int getNumAccount() {
        String sql = "  SELECT COUNT(*) AS total_accounts \n"
                  + "FROM Accounts;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_accounts");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public double getRevenueByMonth(int month) {
        String sql = "SELECT\n"
                  + "    MONTH(orderDate) AS month,\n"
                  + "    SUM(totalCost) AS total_revenue\n"
                  + "FROM Orders\n"
                  + "WHERE YEAR(orderDate) = 2024 and MONTH(orderDate) = ?\n"
                  + "GROUP BY MONTH(orderDate);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, month);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_revenue");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    //lấy số đơn hàng theo tháng trong năm hiện tại
    public int getTotalOrderByMonth(int month) {
        String sql = "SELECT \n"
                  + "    MONTH(orderDate) AS month,\n"
                  + "    COUNT(orderID) AS total_orders\n"
                  + "FROM Orders\n"
                  + "WHERE YEAR(orderDate) = YEAR(GETDATE()) AND MONTH(orderDate) = ? \n"
                  + "GROUP BY \n"
                  + "    MONTH(orderDate)\n"
                  + "ORDER BY \n"
                  + "    month;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, month);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_orders");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    //lấy số đơn hàng theo năm
    public int getTotalOrderByYear(int year) {
        String sql = "SELECT \n"
                  + "    YEAR(orderDate) AS year,\n"
                  + "    COUNT(orderID) AS total_orders\n"
                  + "FROM Orders\n"
                  + "WHERE YEAR(orderDate) = ?\n"
                  + "GROUP BY \n"
                  + "    YEAR(orderDate)\n"
                  + "ORDER BY \n"
                  + "    year;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_orders");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    //lay doanh thu theo nam
    public double getRevenueByYear(int year) {
        String sql = "SELECT \n"
                  + "    YEAR(orderDate) AS year,\n"
                  + "    SUM(totalCost) AS total_revenue\n"
                  + "FROM Orders\n"
                  + "WHERE YEAR(orderDate) = ? \n"
                  + "GROUP BY YEAR(orderDate);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_revenue");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    //ham lay top san pham ALL
    public List<Product> getTop3Sale() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT \n"
                  + "    p.[proID],\n"
                  + "    p.[proName],\n"
                  + "    p.[catID],\n"
                  + "    p.[supID],\n"
                  + "    p.[proDescription],\n"
                  + "    p.[quantityPerUnit],\n"
                  + "    p.[unitPrice],\n"
                  + "    p.[unitsInStock],\n"
                  + "    p.[unitsOnOrder],\n"
                  + "    p.[unitsOrdered],\n"
                  + "    p.[discount],\n"
                  + "    p.[discontinued]\n"
                  + "FROM \n"
                  + "    Products p\n"
                  + "WHERE \n"
                  + "    p.proID IN (\n"
                  + "        SELECT TOP 3 \n"
                  + "            p2.proID\n"
                  + "        FROM \n"
                  + "            Orders o\n"
                  + "        JOIN \n"
                  + "            OrderDetails od ON o.orderID = od.orderID\n"
                  + "        JOIN \n"
                  + "            Products p2 ON od.proID = p2.proID\n"
                  + "        GROUP BY \n"
                  + "            p2.proID\n"
                  + "        ORDER BY \n"
                  + "            SUM(od.quantity) DESC\n"
                  + "    );";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();
                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));
                list.add(d);
            }
            return list;
        } catch (SQLException e) {
        }
        return null;
    }

    //ham lay top san pham ban chay 1 2 3(theo thang, theo nam)
    public List<Product> getTop3SaleOfProducts(int year, int month) {
        List<Product> list = new ArrayList<>();
        String sql;
        if (month == 0) {
            sql = "SELECT \n"
                      + "    p.[proID],\n"
                      + "    p.[proName],\n"
                      + "    p.[catID],\n"
                      + "    p.[supID],\n"
                      + "    p.[proDescription],\n"
                      + "    p.[quantityPerUnit],\n"
                      + "    p.[unitPrice],\n"
                      + "    p.[unitsInStock],\n"
                      + "    p.[unitsOnOrder],\n"
                      + "    p.[unitsOrdered],\n"
                      + "    p.[discount],\n"
                      + "    p.[discontinued]\n"
                      + "FROM \n"
                      + "    Products p\n"
                      + "WHERE \n"
                      + "    p.proID IN (\n"
                      + "        SELECT TOP 3 \n"
                      + "            p2.proID\n"
                      + "        FROM \n"
                      + "            Orders o\n"
                      + "        JOIN \n"
                      + "            OrderDetails od ON o.orderID = od.orderID\n"
                      + "        JOIN \n"
                      + "            Products p2 ON od.proID = p2.proID\n"
                      + "        WHERE \n"
                      + "            YEAR(o.orderDate) = " + year + "\n"
                      + "        GROUP BY \n"
                      + "            p2.proID\n"
                      + "        ORDER BY \n"
                      + "            SUM(od.quantity) DESC\n"
                      + "    );";
        } else {
            sql = "SELECT \n"
                      + "    p.[proID],\n"
                      + "    p.[proName],\n"
                      + "    p.[catID],\n"
                      + "    p.[supID],\n"
                      + "    p.[proDescription],\n"
                      + "    p.[quantityPerUnit],\n"
                      + "    p.[unitPrice],\n"
                      + "    p.[unitsInStock],\n"
                      + "    p.[unitsOnOrder],\n"
                      + "    p.[unitsOrdered],\n"
                      + "    p.[discount],\n"
                      + "    p.[discontinued]\n"
                      + "FROM \n"
                      + "    Products p\n"
                      + "WHERE \n"
                      + "    p.proID IN (\n"
                      + "        SELECT TOP 3 \n"
                      + "            p2.proID\n"
                      + "        FROM \n"
                      + "            Orders o\n"
                      + "        JOIN \n"
                      + "            OrderDetails od ON o.orderID = od.orderID\n"
                      + "        JOIN \n"
                      + "            Products p2 ON od.proID = p2.proID\n"
                      + "        WHERE \n"
                      + "            YEAR(o.orderDate) = " + year + " AND MONTH(o.orderDate) = " + month + "\n"
                      + "        GROUP BY \n"
                      + "            p2.proID\n"
                      + "        ORDER BY \n"
                      + "            SUM(od.quantity) DESC\n"
                      + "    );";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product d = new Product();
                d.setProID(rs.getInt("proID"));
                d.setProName(rs.getString("proName"));
                d.setCatID(getCategoryById(rs.getInt("catID")));
                d.setSupID(getSupplierById(rs.getInt("supID")));
                d.setProDescription(rs.getString("proDescription"));
                d.setQuantityPerUnit(rs.getString("quantityPerUnit"));
                d.setUnitPrice(rs.getDouble("unitPrice"));
                d.setUnitsInStock(rs.getInt("unitsInStock"));
                d.setUnitsOnOrder(rs.getInt("unitsOnOrder"));
                d.setUnitsOrdered(rs.getInt("unitsOrdered"));
                d.setDiscount(rs.getInt("discount"));
                d.setDiscontinued(rs.getBoolean("discontinued"));
                list.add(d);
            }
            return list;
        } catch (SQLException e) {
        }
        return null;
    }
    //ket thu phan statistic

    //----------------------------------------------------------------------------
    //cap nhat trang thai don hang
    //cap nhat trang thai don hang(admin quan ly)
    public void updateStatusOrderAmin(int currentStatus, int orderID) {
        String sql = "UPDATE Orders SET sttID = ? WHERE orderID = ?";
        int nextStatus = getNextStatus(currentStatus);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, nextStatus);
            st.setInt(2, orderID);
            st.executeUpdate();
        } catch (SQLException e) {
        }

    }

    public void updateStatusOrderUser(int orderID) {
        String sql = "UPDATE Orders SET sttID = 4 WHERE orderID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            st.executeUpdate();
        } catch (SQLException e) {
        }

    }

    private int getNextStatus(int currentStatus) {
        return switch (currentStatus) {
            case 1 ->
                2;
            case 2 ->
                3;
            default ->
                currentStatus;
        }; // Không thay đổi nếu đã là Delivered hay trạng thái khác
    }

    public OrderStatus getOrderStatusByID(int sttID) {
        String sql = "SELECT [sttID]\n"
                  + "      ,[sttName]\n"
                  + "      ,[sttDescription]\n"
                  + "  FROM [dbo].[OrderStatus]\n"
                  + "  where sttID = " + sttID;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new OrderStatus(rs.getInt("sttID"), rs.getString("sttName"), rs.getString("sttDescription"));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public Shipping getShippingByShipID(int shipID) {
        String sql = "SELECT [shipID]\n"
                  + "      ,[shipMethod]\n"
                  + "      ,[shipCost]\n"
                  + "      ,[shipDate]\n"
                  + "  FROM [dbo].[Shipping]\n"
                  + "  where shipID= " + shipID;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Shipping(rs.getInt("shipID"), rs.getString("shipMethod"), rs.getDouble("shipCost"), rs.getString("shipDate"));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Order> getListOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT top 20 [orderID]\n"
                  + "      ,[accID]\n"
                  + "      ,[orderDate]\n"
                  + "      ,[totalCost]\n"
                  + "      ,[sttID]\n"
                  + "      ,[shipID]\n"
                  + "  FROM [dbo].[Orders]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setAccID(getAccountByAccID(rs.getInt("accID")));
                o.setOrderDate(rs.getDate("orderDate"));
                o.setOrderID(rs.getInt("orderID"));
                o.setSttID(getOrderStatusByID(rs.getInt("sttID")));
                o.setTotalCost(rs.getDouble("totalCost"));
                o.setShipID(getShippingByShipID(rs.getInt("shipID")));
                list.add(o);
            }
            return list;
        } catch (SQLException e) {
        }
        return null;
    }

    //lay tong don hang theo tung user
    public List<Order> getListOrdersUser(int accID) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT top 10 [orderID]\n"
                  + "      ,[accID]\n"
                  + "      ,[orderDate]\n"
                  + "      ,[totalCost]\n"
                  + "      ,[sttID]\n"
                  + "      ,[shipID]\n"
                  + "  FROM [dbo].[Orders] WHERE accID = " + accID;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setAccID(getAccountByAccID(rs.getInt("accID")));
                o.setOrderDate(rs.getDate("orderDate"));
                o.setOrderID(rs.getInt("orderID"));
                o.setSttID(getOrderStatusByID(rs.getInt("sttID")));
                o.setTotalCost(rs.getDouble("totalCost"));
                o.setShipID(getShippingByShipID(rs.getInt("shipID")));
                list.add(o);
            }
            return list;
        } catch (SQLException e) {
        }
        return null;
    }

    //-----------------------Ket thuc cap nhat status--------------
    public static void main(String[] args) {
        DAO d = new DAO();

//        System.out.println(d.getTotalProductsInCartByAccID(2));
//            d.updateQuantityOfProduct(2, 1, 5);
//            d.addOrderIntoOrderTable(2, 1000, 2, 1);
//        int a = d.addOrderIntoOrderTable(2, 2012, 1, 2);
//        System.out.println(a);
        int revenue = d.getTotalOrderByYear(2024);
        System.out.println(revenue);
//        List<Product> pros = d.getTop3SaleOfProducts(2024, 1);
//        for (Product pro : pros) {
//            System.out.println(pro.getProName());
//        }
//        d.updateStatusOrderAmin(1, 3);
        Shipping a = d.getShippingByShipID(1);
        System.out.println(a.getShipID());
        List<Account> l = d.getAllAccounts();
        for (Account account : l) {
            System.out.println(account.getAccname());
        }
    }

}
