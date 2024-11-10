/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ReviewsTotal {
     private Product proID;
     private int revRating;

    public ReviewsTotal() {
    }

    public ReviewsTotal(Product proID, int revRating) {
        this.proID = proID;
        this.revRating = revRating;
    }

    public Product getProID() {
        return proID;
    }

    public void setProID(Product proID) {
        this.proID = proID;
    }

    public int getRevRating() {
        return revRating;
    }

    public void setRevRating(int revRating) {
        this.revRating = revRating;
    }
     
}
