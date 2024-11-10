/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Cart {
    /*
    SELECT TOP (1000) [cartID]
      ,[accID]
      ,[proID]
      ,[quantity]
      ,[addedAt]
  FROM [Watches_Store].[dbo].[Cart]
    */
    private int cartID;
    private Account accID;
    private Product proID;
    private int quantity;

    public Cart() {
    }

    public Cart(int cartID, Account accID, Product proID, int quantity) {
        this.cartID = cartID;
        this.accID = accID;
        this.proID = proID;
        this.quantity = quantity;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public Account getAccID() {
        return accID;
    }

    public void setAccID(Account accID) {
        this.accID = accID;
    }

    public Product getProID() {
        return proID;
    }

    public void setProID(Product proID) {
        this.proID = proID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
