/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.MealDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
public class PlanRemoveRecipeServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;

        boolean result = false;
        boolean isTemplate = false;
        int meal_id = Integer.parseInt(request.getParameter("meal_id"));
        int plan_id = Integer.parseInt(request.getParameter("plan_id"));

        String distanceInDaysParam = request.getParameter("distanceInDays");

        if (meal_id > 0 && plan_id > 0) {
            result = MealDAO.removeRecipeFromPlan(meal_id);
            int distanceInDays = Integer.parseInt(distanceInDaysParam);
            if (result && distanceInDays == 1337) {
                isTemplate = Boolean.parseBoolean(request.getParameter("isTemplate"));
                if (isTemplate) {
                    url = "LoadEditDailyTemplateServlet?id=" + plan_id + "&isSearch=false";
                } else {
                    url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&distanceInDays=" + distanceInDaysParam;
                }
            } else {
                url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&distanceInDays=" + distanceInDaysParam;
            }
        }

        if (url != null) {
            response.sendRedirect(url);
        } else {
            response.sendRedirect(ERROR);
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
