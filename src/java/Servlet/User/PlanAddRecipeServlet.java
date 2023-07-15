/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.MealDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
public class PlanAddRecipeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try ( PrintWriter out = response.getWriter()) {

            boolean result = false;

            int date_id = Integer.parseInt(request.getParameter("date_id"));
            int plan_id = Integer.parseInt(request.getParameter("plan_id"));
            int recipe_id = Integer.parseInt(request.getParameter("recipe_id"));
            String start_timeStr = request.getParameter("start_time");
            String meal = request.getParameter("meal");
            int recipe_count = Integer.parseInt(request.getParameter("recipe_count"));
            //String end_timeStr = request.getParameter("end_time");

            Time start_time = null;

            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            java.util.Date parsedStart = timeFormat.parse(start_timeStr);
            start_time = new Time(parsedStart.getTime());

//            System.out.println("recipe_id recieved - " + recipe_id);
//            System.out.println("plan_id recieved - " + plan_id);
//            System.out.println("date_id recieved - " + date_id);
//            System.out.println("start_time recieved - " + start_time);
//            System.out.println("end_time recieved - " + end_time);
            if (date_id != 0 && plan_id != 0 && recipe_id != 0 && start_timeStr != null) {
                for (int i = 0; i < recipe_count; i++) {
                    // Add the recipe to the plan with the current start time
                    result = MealDAO.addMealById(date_id, recipe_id, start_time);

                    // Increment the start time by 1 hour for the next recipe
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(start_time);
                    cal.add(Calendar.HOUR_OF_DAY, 1);
                    start_time = new Time(cal.getTime().getTime());
                }
            }

//            out.println(date_id);
//            out.println(plan_id);
//            out.println(recipe_id);
//            out.println(start_timeStr);
//            out.println(recipe_count);

            if (result) {
                response.sendRedirect("UserController?action=editPlan&id=" + plan_id + "&isSearch=false");
            } else {
                response.sendRedirect("error.jsp");
            }
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
