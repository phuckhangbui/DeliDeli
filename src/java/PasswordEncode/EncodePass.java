/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PasswordEncode;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Daiisuke
 */
public class EncodePass {

    //SHA256 hashing.
    public byte[] getSHA(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256"); //one-way hash
        return md.digest(input.getBytes(StandardCharsets.UTF_8)); //digest to get the hash.
    }

    public String toHexString(byte[] hash) {
        BigInteger number = new BigInteger(1, hash); //byte array 'hash' to BigInteger
        StringBuilder hexString = new StringBuilder(number.toString(16)); //convert to hex (16)
        while (hexString.length() < 32) {
            hexString.insert(0, '0'); //Making sure it fits 32 char else add 0 into string.
        }
        return hexString.toString(); //Result
    }

}
