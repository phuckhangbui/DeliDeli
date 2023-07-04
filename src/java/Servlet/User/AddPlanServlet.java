/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.PlanDAO;
import DTO.PlanDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
public class AddPlanServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Miscellaneous variables
        boolean result = false;
        boolean checkAddDate = false;
        boolean checkAddWeek = false;

        // Basic Information
        int id = 0;
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String note = request.getParameter("note");
        int dietID = Integer.parseInt(request.getParameter("recipeDietId"));
        int userID = Integer.parseInt(request.getParameter("userId"));
        boolean status = false;

        // Simple week calculator 
        String start_date_str = request.getParameter("start_date");
        java.sql.Date start_date = java.sql.Date.valueOf(start_date_str);
        LocalDate startDate = LocalDate.parse(start_date_str);
        LocalDate end_date_str = startDate.plusDays(6);
        java.sql.Date end_date = java.sql.Date.valueOf(end_date_str);

        // Adding plan
        try {
            result = PlanDAO.insertPlan(name, description, note, start_date, end_date, status, userID, dietID);
            id = PlanDAO.getPlanByUserIdAndName(userID, name);
        } catch (Exception ex) {
            System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
        }

        // Creating each day in that particular week.
        try {
            checkAddWeek = PlanDAO.insertWeek(id, start_date);
            int weekId = PlanDAO.getWeekIDByPlanId(id);
            checkAddDate = PlanDAO.insertAllDatesWithinAWeek(start_date, end_date, weekId, id);
        } catch (Exception ex) {
            System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
        }

        if (result) {
            request.setAttribute("USER_PLAN", result);
            RequestDispatcher rq = request.getRequestDispatcher("addRecipeToPlan.jsp");
            rq.forward(request, response);
        } else {
            response.sendRedirect("errorpage.html");
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
