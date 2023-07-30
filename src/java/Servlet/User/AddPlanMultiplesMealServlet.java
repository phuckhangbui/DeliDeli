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
 * @author Admin
 */
public class AddPlanMultiplesMealServlet extends HttpServlet {

    private static final String BREAKFAST_START = "08:00";
    private static final String LUNCH_START = "12:00";
    private static final String DINNER_START = "17:00";
    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //int date_id = Integer.parseInt(request.getParameter("date_id"));
            boolean result = false;
            String url = ERROR;

            String[] selectedDates = request.getParameterValues("date_id");
            String[] timeIds = request.getParameterValues("timeId");
            String distanceInDays = request.getParameter("distanceInDays");
            String selectedDate = request.getParameter("selectedDate");
            int recipe_id = Integer.parseInt(request.getParameter("recipe_id"));
            int plan_id = Integer.parseInt(request.getParameter("plan_id"));
            int week_id = Integer.parseInt(request.getParameter("week_id"));
            boolean isDaily = Boolean.parseBoolean(request.getParameter("isDaily"));
            boolean isTemplate = false;

            List<Integer> dateIdList = new ArrayList<>();
            List<Time> timeList = new ArrayList<>();

            Set<String> uniqueTimeIdsSet = new HashSet<>(Arrays.asList(timeIds));

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
                for (String dateId : selectedDates) {
                    result = MealDAO.addMealById(new Integer(dateId), recipe_id, time);
                    //System.out.println("Good");
                }
            }

            if (result) {
                if (isDaily) {
                    url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&distanceInDays=" + distanceInDays;
                } else {
                    url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&selectedDate=" + selectedDate;
                }
                isTemplate = Boolean.parseBoolean(request.getParameter("isTemplate"));
                if (isTemplate) {
                    url = "LoadEditDailyTemplateServlet?id=" + plan_id + "&isSearch=false";
                }
            }

            response.sendRedirect(url);

//
//            if (selectedDates != null) {
//                for (String dateString : selectedDates) {
//                    java.sql.Date date = java.sql.Date.valueOf(dateString);
//                    int date_id = DateDAO.insertMultiplesDate(date, week_id, plan_id);
//                    dateIdList.add(date_id);
//                }
//            }
//            out.println("Week " + week_id);
//            out.println("Plan " + plan_id);
//            out.println("Recipe " + recipe_id);
//
//            if (selectedDates != null) {
//                for (String dateId : selectedDates) {
//                    out.println("Date: " + dateId);
//                }
//            }
//
//            if (timeIds != null) {
//                for (String timeId : timeIds) {
//                    out.println("Time: " + timeId);
//                }
//            }
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
