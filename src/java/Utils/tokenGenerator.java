/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.security.SecureRandom;
import java.util.Base64;

/**
 *
 * @author Daiisuke
 */
public class tokenGenerator {
    private static final SecureRandom secureRandom = new SecureRandom();
    private static final Base64.Encoder base64encoder = Base64.getUrlEncoder();
    
    public static String tokenGenerate(){
        byte[] randomBytes = new byte[32];
        secureRandom.nextBytes(randomBytes);
        //Generate random set of bytes.
        return base64encoder.encodeToString(randomBytes);
        //Encode the bytes into strings.
    }
}
