/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class OrderStatus {
    /*sttID INT PRIMARY KEY IDENTITY(1,1),
  sttName VARCHAR(255),
  sttDescription TEXT*/
    private int sttID;
    private String sttName, sttDescription;

    public OrderStatus() {
    }

    public OrderStatus(int sttID, String sttName, String sttDescription) {
        this.sttID = sttID;
        this.sttName = sttName;
        this.sttDescription = sttDescription;
    }

    public int getSttID() {
        return sttID;
    }

    public void setSttID(int sttID) {
        this.sttID = sttID;
    }

    public String getSttName() {
        return sttName;
    }

    public void setSttName(String sttName) {
        this.sttName = sttName;
    }

    public String getSttDescription() {
        return sttDescription;
    }

    public void setSttDescription(String sttDescription) {
        this.sttDescription = sttDescription;
    }
    
}
