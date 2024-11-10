/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ImageProduct {
    /*
SELECT [imgID]
      ,[proID]
      ,[imgURL]
      ,[imgDescription]
      ,[isRepresentative]
  FROM [dbo].[ProductImages]

    */
    
    private int imgID;
    private Product proID;
    private String imgURL, imgDescription;
    private boolean isRepresentative;

    public ImageProduct() {
    }

    public ImageProduct(int imgID, Product proID, String imgURL, String imgDescription, boolean isRepresentative) {
        this.imgID = imgID;
        this.proID = proID;
        this.imgURL = imgURL;
        this.imgDescription = imgDescription;
        this.isRepresentative = isRepresentative;
    }

    public int getImgID() {
        return imgID;
    }

    public void setImgID(int imgID) {
        this.imgID = imgID;
    }

    public Product getProID() {
        return proID;
    }

    public void setProID(Product proID) {
        this.proID = proID;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public String getImgDescription() {
        return imgDescription;
    }

    public void setImgDescription(String imgDescription) {
        this.imgDescription = imgDescription;
    }

    public boolean isIsRepresentative() {
        return isRepresentative;
    }

    public void setIsRepresentative(boolean isRepresentative) {
        this.isRepresentative = isRepresentative;
    }
    
}
