/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DailyPlanTemplateDAO;
import DAO.DateDAO;
import DAO.MealDAO;
import DAO.PlanDAO;
import DTO.DateDTO;
import DTO.PlanDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
public class RemoveAllRecipeServlet extends HttpServlet {

    private final static String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int plan_id = Integer.parseInt(request.getParameter("plan_id"));
        int date_id = Integer.parseInt(request.getParameter("date_id"));
        int distanceInDays = Integer.parseInt(request.getParameter("distanceInDays"));
        boolean isTemplate = false;
        boolean result = false;
        String url = ERROR;

        if (plan_id > 0 && date_id > 0) {
            result = MealDAO.deleteAllMealByDate(plan_id, date_id);
        } else {
            response.sendRedirect(url);
            return;
        }

        if (result) {
            url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&distanceInDays=" + distanceInDays;
            isTemplate = Boolean.parseBoolean(request.getParameter("isTemplate"));
            if (isTemplate) {
                url = "LoadEditDailyTemplateServlet?id=" + plan_id + "&isSearch=false";
            }
        }
        
        response.sendRedirect(url);
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
