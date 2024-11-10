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
public class Order {
    /*
    SELECT TOP (1000) [orderID]
      ,[accID]
      ,[orderDate]
      ,[totalCost]
      ,[sttID]
      ,[shipID]
    */
    private int orderID;
    private Account accID;
    private Date orderDate;
    private double totalCost;
    private OrderStatus sttID;
    private Shipping shipID;

    public Order() {
    }

    public Order(int orderID, Account accID, Date orderDate, double totalCost, OrderStatus sttID, Shipping shipID) {
        this.orderID = orderID;
        this.accID = accID;
        this.orderDate = orderDate;
        this.totalCost = totalCost;
        this.sttID = sttID;
        this.shipID = shipID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Account getAccID() {
        return accID;
    }

    public void setAccID(Account accID) {
        this.accID = accID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public OrderStatus getSttID() {
        return sttID;
    }

    public void setSttID(OrderStatus sttID) {
        this.sttID = sttID;
    }

    public Shipping getShipID() {
        return shipID;
    }

    public void setShipID(Shipping shipID) {
        this.shipID = shipID;
    }

}
