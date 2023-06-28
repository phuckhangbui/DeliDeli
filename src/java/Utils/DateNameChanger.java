/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;

/**
 *
 * @author Daiisuke
 */
public class DateNameChanger {

    public static String formatDateWithOrdinalIndicator(Date date, SimpleDateFormat dateFormat) {
        String formattedDate = dateFormat.format(date);
        int day = Integer.parseInt(formattedDate.replaceAll("\\D+", ""));

        String ordinalIndicator;
        if (day >= 11 && day <= 13) {
            // It's an english tradition to have 11 to 13 formatted as th.
            ordinalIndicator = "th";
        } else {
            switch (day % 10) {
                case 1:
                    ordinalIndicator = "st";
                    break;
                case 2:
                    ordinalIndicator = "nd";
                    break;
                case 3:
                    ordinalIndicator = "rd";
                    break;
                default:
                    ordinalIndicator = "th";
                    break;
            }
        }
        
        return formattedDate + ordinalIndicator;
    }
}
