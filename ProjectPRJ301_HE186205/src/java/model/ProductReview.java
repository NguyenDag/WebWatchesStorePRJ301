/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ProductReview {
    /*SELECT [revID]
      ,[proID]
      ,[accID]
      ,[revText]
      ,[revRating]*/
    private int revID;
    private Product proID;
    private Account accID;
    private String revText;
    private int revRating;

    public ProductReview() {
    }

    public ProductReview(int revID, Product proID, Account accID, String revText, int revRating) {
        this.revID = revID;
        this.proID = proID;
        this.accID = accID;
        this.revText = revText;
        this.revRating = revRating;
    }

    public int getRevID() {
        return revID;
    }

    public void setRevID(int revID) {
        this.revID = revID;
    }

    public Product getProID() {
        return proID;
    }

    public void setProID(Product proID) {
        this.proID = proID;
    }

    public Account getAccID() {
        return accID;
    }

    public void setAccID(Account accID) {
        this.accID = accID;
    }

    public String getRevText() {
        return revText;
    }

    public void setRevText(String revText) {
        this.revText = revText;
    }

    public int getRevRating() {
        return revRating;
    }

    public void setRevRating(int revRating) {
        this.revRating = revRating;
    }
    
}
