/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Shipping {
    /*[shipID]
      ,[shipMethod]
      ,[shipCost]
      ,[shipDate]*/
    private int shipID;
    private String shipMethod;
    private double shipCost;
    private String shipDate;

    public Shipping() {
    }

    public Shipping(int shipID, String shipMethod, double shipCost, String shipDate) {
        this.shipID = shipID;
        this.shipMethod = shipMethod;
        this.shipCost = shipCost;
        this.shipDate = shipDate;
    }

    public int getShipID() {
        return shipID;
    }

    public void setShipID(int shipID) {
        this.shipID = shipID;
    }

    public String getShipMethod() {
        return shipMethod;
    }

    public void setShipMethod(String shipMethod) {
        this.shipMethod = shipMethod;
    }

    public double getShipCost() {
        return shipCost;
    }

    public void setShipCost(double shipCost) {
        this.shipCost = shipCost;
    }

    public String getShipDate() {
        return shipDate;
    }

    public void setShipDate(String shipDate) {
        this.shipDate = shipDate;
    }
    
}
