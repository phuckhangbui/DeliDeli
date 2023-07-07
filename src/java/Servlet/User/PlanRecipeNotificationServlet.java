/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.MealDAO;
import DAO.NotificationDAO;
import DTO.MealDTO;
import DTO.NotificationDTO;
import DTO.PlanDateDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.time.LocalTime;
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

        HttpSession session = request.getSession();
        PlanDateDTO currentPlanToday = (PlanDateDTO) session.getAttribute("currentPlanActivate");
//        System.out.println("[NOTIFICATION]: currentPlanToday - " + currentPlanToday.getDate());
//        System.out.println("[NOTIFICATION]: PlanRecipeNotificationServlet - " + currentPlanToday.getStart_time());
        UserDTO user = (UserDTO) session.getAttribute("user");

        MealDTO currentMeal = MealDAO.getMealByTimeAndDate(currentPlanToday.getStart_time(), currentPlanToday.getDate_id());
//        System.out.println("[NOTIFICATION]: currentMeal - " + currentMeal.getRecipe_id());

        if (currentMeal != null) {

            boolean result = MealDAO.updateMealNotificationStatusById(currentMeal.getId());

            if (result) {

                String title = "It's " + currentMeal.getStart_time() + " ! Time to eat";
                String desc = "Your plan schedule calling you ! ";
                java.sql.Timestamp sendDate = new java.sql.Timestamp(System.currentTimeMillis());
                int userId = user.getId();
                int notificationType = 3;
                int recipeId = currentMeal.getRecipe_id();
                int planId = currentPlanToday.getPlan_id();

//                System.out.println("[NOTIFICATION - REPORT]: UserID - " + userId);
//                System.out.println("[NOTIFICATION - REPORT]: Title - " + title);
//                System.out.println("[NOTIFICATION - REPORT]: Desc - " + desc);
//                System.out.println("[NOTIFICATION - REPORT]: SendDatee - " + sendDate);
//                System.out.println("[NOTIFICATION - REPORT]: recipeId - " + recipeId);
//                System.out.println("[NOTIFICATION - REPORT]: PlanID - " + planId);

                NotificationDTO notification = new NotificationDTO(0, title, desc, sendDate, false, userId, notificationType, recipeId, 0, "");

                NotificationDAO.addNotification(notification);

//                System.out.println("Notification SENT!");

            } else {
                System.out.println("There's something wrong with updateMealNotificationStatusById");
            }
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
