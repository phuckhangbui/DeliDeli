/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DailyPlanTemplateDAO;
import DAO.MealDAO;
import DAO.PlanDAO;
import DTO.MealDTO;
import DTO.PlanDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author khang
 */
public class UseDailyPlanTemplateServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int planId = Integer.parseInt(request.getParameter("planId"));
            PlanDTO plan = PlanDAO.getPlanById(planId);
            if(plan == null){
                response.sendRedirect("error.jsp");
            }
            
            //get template date id
            int templateId = DailyPlanTemplateDAO.getDailyTemplateIdByPlanId(planId);
            
            ArrayList<MealDTO> templateMeals = MealDAO.getAllMealByDateId(templateId);
            //list of all normal date in that plan
            ArrayList<Integer> idList = DailyPlanTemplateDAO.getSyncDateId(planId);
            //delete old meal from the normal date
            DailyPlanTemplateDAO.deleteSyncDateMeal(planId, idList);
           
            
            if(templateMeals.size() > 0){                
                
                //sync normal date with template date
                DailyPlanTemplateDAO.syncWithDailyTemplate(idList, templateMeals);
            }
            
            
        }catch(Exception ex){
            response.sendRedirect("error.jsp");
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
