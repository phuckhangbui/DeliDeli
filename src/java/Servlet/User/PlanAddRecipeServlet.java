/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.MealDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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

            String dateId = request.getParameter("date_id");
            String[] timeId = request.getParameterValues("timeId");
            int recipe_id = Integer.parseInt(request.getParameter("recipe_id"));
            //int recipe_count = Integer.parseInt(request.getParameter("recipe_count"));
            int plan_id = Integer.parseInt(request.getParameter("plan_id"));
            int week_id = Integer.parseInt(request.getParameter("week_id"));
            String plantStart = request.getParameter("plan_start");

            //List<Integer> dateIdList = new ArrayList<>();
            List<Time> timeList = new ArrayList<>();

//            if (selectedDates != null) {
//                for (String dateString : selectedDates) {
//                    java.sql.Date date = java.sql.Date.valueOf(dateString);
//                    int date_id = DateDAO.insertMultiplesDate(date, week_id, plan_id);
//                    dateIdList.add(date_id);
//                }
//            }


// Convert the array to a Set to remove duplicates
            Set<String> uniqueTimeIdsSet = new HashSet<>(Arrays.asList(timeId));

// Convert the Set back to an array
            String[] uniqueTimeIds = uniqueTimeIdsSet.toArray(new String[0]);
            if (uniqueTimeIds != null) {
                for (String timeStr : uniqueTimeIds) {
                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                    java.util.Date parsedStart = timeFormat.parse(timeStr);
                    Time time = new Time(parsedStart.getTime());
                    timeList.add(time);
                }
            }

            for (Time time : timeList) {
                result = MealDAO.addMealById(new Integer(dateId), recipe_id, time);
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
