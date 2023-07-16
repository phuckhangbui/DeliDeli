/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.MealDAO;
import DAO.NotificationDAO;
import DAO.RecipeDAO;
import DTO.DateDTO;
import DTO.MealDTO;
import DTO.NotificationDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Daiisuke
 */
public class PlanRecipeNotificationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        
        // Need to be remaked

//        HttpSession session = request.getSession();
//        DateDTO currentPlanToday = (DateDTO) session.getAttribute("currentPlanActivate");
////        System.out.println("[NOTIFICATION]: currentPlanToday - " + currentPlanToday.getDate());
////        System.out.println("[NOTIFICATION]: PlanRecipeNotificationServlet - " + currentPlanToday.getStart_time());
//        UserDTO user = (UserDTO) session.getAttribute("user");
//
////        MealDTO currentMeal = MealDAO.getMealByTimeAndDate(currentPlanToday.getStart_time(), currentPlanToday.getDate_id());
//        System.out.println("[NOTIFICATION]: currentMeal - " + currentMeal.getRecipe_id());
//
//        boolean result = MealDAO.updateMealNotificationStatusById(currentMeal.getId());
//        RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(currentMeal.getRecipe_id());
//
//        if (result) {
//            String title = "Your meal at " + currentMeal.getStart_time() + " is ready";
//            String desc = "You've planned your schedule ahead, what you'll be eating now: " + recipe.getTitle();
//            java.sql.Timestamp sendDate = new java.sql.Timestamp(System.currentTimeMillis());
//            int userId = user.getId();
//            int notificationType = 3;
//            int recipeId = currentMeal.getRecipe_id();
//            System.out.println("RecipeID: " + recipeId);
//            int planId = currentPlanToday.getPlan_id();
//
//            NotificationDTO notification = new NotificationDTO(0, title, desc, sendDate, false, userId, notificationType, recipeId, 0, "");
//
//            NotificationDAO.addNotification(notification);
//
//        }

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
