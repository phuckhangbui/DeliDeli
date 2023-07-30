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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class EditStartTimeRecipeServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;

        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int date_id = Integer.parseInt(request.getParameter("date_id"));
            int plan_id = Integer.parseInt(request.getParameter("plan_id"));
            int meal_id = Integer.parseInt(request.getParameter("meal_id"));
            String start_timeStr = request.getParameter("start_time");
            String distanceInDays = request.getParameter("distanceInDays");
            String selectedDate = request.getParameter("selectedDate");
            boolean isDaily = Boolean.parseBoolean(request.getParameter("isDaily"));

            boolean isTemplate = false;

            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            java.util.Date parsedStart = timeFormat.parse(start_timeStr);

            Time start_time = new Time(parsedStart.getTime());

            boolean result = MealDAO.changeStartTimeOfRecipe(meal_id, date_id, start_time);

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

            if (url != null) {
                response.sendRedirect(url);
            } else {
                response.sendRedirect(ERROR);
            }

//            System.out.println("Success");
//            out.println(date_id);
//            out.println(plan_id);
//            out.println(meal_id);
//            out.println(start_timeStr);
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
