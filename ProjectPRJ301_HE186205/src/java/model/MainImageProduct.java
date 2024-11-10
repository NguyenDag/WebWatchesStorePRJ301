/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class MainImageProduct {
    /*
    SELECT top 10 p.[proID]
      ,p.[proName]
      ,p.[catID]
      ,p.[supID]
      ,p.[proDescription]
      ,p.[quantityPerUnit]
      ,p.[unitPrice]
      ,p.[unitsInStock]
      ,p.[unitsOnOrder]
      ,p.[discontinued]
    , p.discount
	  ,proimg.[imgID]
      ,proimg.[imgURL]
      ,proimg.[imgDescription]
      ,proimg.[isRepresentative]
    */
    private int proID;
    private String proName;
    private Category catID;
    private Supplier supID;
    private String proDescription, quantityPerUnit;
    private double unitPrice;
    private int unitsInStock, unitsOnOrder, unitsOrdered;
    private int discount;
    private boolean discontinued;
    private int imgID;
    private String imgURL, imgDescription;
    private boolean isRepresentative;

    public MainImageProduct() {
    }

    public MainImageProduct(int proID, String proName, Category catID, Supplier supID, String proDescription, String quantityPerUnit, double unitPrice, int unitsInStock, int unitsOnOrder, int unitsOrdered, int discount, boolean discontinued, int imgID, String imgURL, String imgDescription, boolean isRepresentative) {
        this.proID = proID;
        this.proName = proName;
        this.catID = catID;
        this.supID = supID;
        this.proDescription = proDescription;
        this.quantityPerUnit = quantityPerUnit;
        this.unitPrice = unitPrice;
        this.unitsInStock = unitsInStock;
        this.unitsOnOrder = unitsOnOrder;
        this.unitsOrdered = unitsOrdered;
        this.discount = discount;
        this.discontinued = discontinued;
        this.imgID = imgID;
        this.imgURL = imgURL;
        this.imgDescription = imgDescription;
        this.isRepresentative = isRepresentative;
    }

    public int getProID() {
        return proID;
    }

    public void setProID(int proID) {
        this.proID = proID;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public Category getCatID() {
        return catID;
    }

    public void setCatID(Category catID) {
        this.catID = catID;
    }

    public Supplier getSupID() {
        return supID;
    }

    public void setSupID(Supplier supID) {
        this.supID = supID;
    }

    public String getProDescription() {
        return proDescription;
    }

    public void setProDescription(String proDescription) {
        this.proDescription = proDescription;
    }

    public String getQuantityPerUnit() {
        return quantityPerUnit;
    }

    public void setQuantityPerUnit(String quantityPerUnit) {
        this.quantityPerUnit = quantityPerUnit;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getUnitsInStock() {
        return unitsInStock;
    }

    public void setUnitsInStock(int unitsInStock) {
        this.unitsInStock = unitsInStock;
    }

    public int getUnitsOnOrder() {
        return unitsOnOrder;
    }

    public void setUnitsOnOrder(int unitsOnOrder) {
        this.unitsOnOrder = unitsOnOrder;
    }

    public int getUnitsOrdered() {
        return unitsOrdered;
    }

    public void setUnitsOrdered(int unitsOrdered) {
        this.unitsOrdered = unitsOrdered;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public boolean isDiscontinued() {
        return discontinued;
    }

    public void setDiscontinued(boolean discontinued) {
        this.discontinued = discontinued;
    }

    public int getImgID() {
        return imgID;
    }

    public void setImgID(int imgID) {
        this.imgID = imgID;
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

    @Override
    public String toString() {
        return "MainImageProduct{" + "proID=" + proID + ", proName=" + proName + ", catID=" + catID + ", supID=" + supID + ", proDescription=" + proDescription + ", quantityPerUnit=" + quantityPerUnit + ", unitPrice=" + unitPrice + ", unitsInStock=" + unitsInStock + ", unitsOnOrder=" + unitsOnOrder + ", unitsOrdered=" + unitsOrdered + ", discount=" + discount + ", discontinued=" + discontinued + ", imgID=" + imgID + ", imgURL=" + imgURL + ", imgDescription=" + imgDescription + ", isRepresentative=" + isRepresentative + '}';
    }

    
}
