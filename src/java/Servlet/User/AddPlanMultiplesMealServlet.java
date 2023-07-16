/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.MealDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class AddPlanMultiplesMealServlet extends HttpServlet {

    private static final String BREAKFAST_START = "08:00";
    private static final String LUNCH_START = "12:00";
    private static final String DINNER_START = "17:00";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //int date_id = Integer.parseInt(request.getParameter("date_id"));
            String[] selectedDates = request.getParameterValues("date_id");
            String[] selectedMeals = request.getParameterValues("meal");
            int recipe_id = Integer.parseInt(request.getParameter("recipe_id"));
            int recipe_count = Integer.parseInt(request.getParameter("recipe_count"));
            int plan_id = Integer.parseInt(request.getParameter("plan_id"));
            int week_id = Integer.parseInt(request.getParameter("week_id"));
            String plantStart = request.getParameter("plan_start");

            List<Integer> dateIdList = new ArrayList<>();

            if (selectedDates != null) {
                for (String dateString : selectedDates) {
                    java.sql.Date date = java.sql.Date.valueOf(dateString);
//                    out.println(date);
//                    out.println(week_id);
                    int date_id = DateDAO.insertMultiplesDate(date, week_id, plan_id);
                    dateIdList.add(date_id);
                }
            }

            //out.println(dateIdList);
            for (Integer dateId : dateIdList) {
                //BREAKFAST_START
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                java.util.Date parsedStart = timeFormat.parse(BREAKFAST_START);
                Time breakfastStartTime = new Time(parsedStart.getTime());

                //BREAKFAST_START
                timeFormat = new SimpleDateFormat("HH:mm");
                parsedStart = timeFormat.parse(LUNCH_START);
                Time lunchStartTime = new Time(parsedStart.getTime());

                //BREAKFAST_START
                timeFormat = new SimpleDateFormat("HH:mm");
                parsedStart = timeFormat.parse(DINNER_START);
                Time dinnerStartTime = new Time(parsedStart.getTime());
                if (selectedMeals != null) {
                    for (String meal : selectedMeals) {
                        switch (meal) {
                            case "breakfast":
//                            System.out.println("breakfast");
                                for (int i = 0; i < recipe_count; i++) {
                                    // Add the recipe to the plan with the current start time
                                    boolean result = MealDAO.addMealById(dateId, recipe_id, breakfastStartTime);

                                    // Increment the start time by 1 hour for the next recipe
                                    Calendar cal = Calendar.getInstance();
                                    cal.setTime(breakfastStartTime);
                                    cal.add(Calendar.HOUR_OF_DAY, 1);
                                    breakfastStartTime = new Time(cal.getTime().getTime());
                                }
                                break;
                            case "lunch":
//                            System.out.println("lunch");
                                for (int i = 0; i < recipe_count; i++) {
                                    // Add the recipe to the plan with the current start time
                                    boolean result = MealDAO.addMealById(dateId, recipe_id, lunchStartTime);

                                    // Increment the start time by 1 hour for the next recipe
                                    Calendar cal = Calendar.getInstance();
                                    cal.setTime(lunchStartTime);
                                    cal.add(Calendar.HOUR_OF_DAY, 1);
                                    lunchStartTime = new Time(cal.getTime().getTime());
                                }
                                break;
                            case "dinner":
//                            System.out.println("dinner");
                                for (int i = 0; i < recipe_count; i++) {
                                    // Add the recipe to the plan with the current start time
                                    boolean result = MealDAO.addMealById(dateId, recipe_id, dinnerStartTime);

                                    // Increment the start time by 1 hour for the next recipe
                                    Calendar cal = Calendar.getInstance();
                                    cal.setTime(dinnerStartTime);
                                    cal.add(Calendar.HOUR_OF_DAY, 1);
                                    dinnerStartTime = new Time(cal.getTime().getTime());
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }
            }

//            String[] selectedDateIds = request.getParameterValues("date_id");
//            if (selectedDateIds != null) {
//                for (String dateId : selectedDateIds) {
//                    out.println("Date: " + dateId);
//                }
//            }
//
//            out.println("Week " + week_id);
//            out.println("Plan " + plan_id);
//            out.println("Recipe " + recipe_id);
//            out.println("Count " + recipe_count);
//            out.println("BREAKFAST_START " + breakfastStartTime);
//            out.println("LUNCH_START " + lunchStartTime);
//            out.println("DINNER_START " + dinnerStartTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
