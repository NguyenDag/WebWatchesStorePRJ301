/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import at.favre.lib.crypto.bcrypt.BCrypt;

/**
 *
 * @author admin
 */
public class Encript {

    public String hashPassword(String plainPassword) {
        return BCrypt.withDefaults().hashToString(10, plainPassword.toCharArray());
    }

    public boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.verifyer().verify(plainPassword.toCharArray(), hashedPassword).verified;
    }
}
