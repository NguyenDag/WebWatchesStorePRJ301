/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Account {

    /*
    SELECT [accID]
      ,[username]
      ,[password]
      ,[role]
      ,[accname]
      ,[accAddress]
      ,[cusPhone]
      ,[cusEmail]
  FROM [dbo].[Accounts]
    
     */
    private int accID;
    private String username, password;
    private boolean role;
    private String accname, accAddress, cusPhone, cusEmail, avatar, gender;

    public Account() {
    }

    public Account(int accID, String username, String password, boolean role, String accname, String accAddress, String cusPhone, String cusEmail, String avatar, String gender) {
        this.accID = accID;
        this.username = username;
        this.password = password;
        this.role = role;
        this.accname = accname;
        this.accAddress = accAddress;
        this.cusPhone = cusPhone;
        this.cusEmail = cusEmail;
        this.avatar = avatar;
        this.gender = gender;
    }

    public int getAccID() {
        return accID;
    }

    public void setAccID(int accID) {
        this.accID = accID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isRole() {
        return role;
    }

    public void setRole(boolean role) {
        this.role = role;
    }

    public String getAccname() {
        return accname;
    }

    public void setAccname(String accname) {
        this.accname = accname;
    }

    public String getAccAddress() {
        return accAddress;
    }

    public void setAccAddress(String accAddress) {
        this.accAddress = accAddress;
    }

    public String getCusPhone() {
        return cusPhone;
    }

    public void setCusPhone(String cusPhone) {
        this.cusPhone = cusPhone;
    }

    public String getCusEmail() {
        return cusEmail;
    }

    public void setCusEmail(String cusEmail) {
        this.cusEmail = cusEmail;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

}
