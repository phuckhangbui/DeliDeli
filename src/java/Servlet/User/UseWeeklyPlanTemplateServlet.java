/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DailyPlanTemplateDAO;
import DAO.DateDAO;
import DAO.MealDAO;
import DAO.PlanDAO;
import DAO.WeeklyPlanTemplateDAO;
import DTO.DateDTO;
import DTO.MealDTO;
import DTO.PlanDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.omg.CORBA.Current;

/**
 *
 * @author khang
 */
public class UseWeeklyPlanTemplateServlet extends HttpServlet {

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
            int planId = Integer.parseInt(request.getParameter("id"));
            PlanDTO plan = PlanDAO.getPlanById(planId);
            if (plan == null) {
                response.sendRedirect("error.jsp");
            }

            java.sql.Date startDateSQL = plan.getStart_at();
            java.sql.Date endDateSQL = plan.getEnd_at();

            long millisDiff = endDateSQL.getTime() - startDateSQL.getTime();

            int planLength = (int) (millisDiff / (1000 * 60 * 60 * 24 * 7)) + 1;

            //get template week id
            int templateId = WeeklyPlanTemplateDAO.getWeeklyTemplateIdByPlanId(planId);

            //list of all normal Week in that plan
            ArrayList<Integer> weeklyIdList = WeeklyPlanTemplateDAO.getSyncWeekId(planId);
            ArrayList<DateDTO> dateInTemplate = DateDAO.getAllDateByPlanIDAndWeekID(planId, templateId);

            for (DateDTO date : dateInTemplate) {
                //loop each date in the week template, get the meals
                ArrayList<MealDTO> templateMeals = MealDAO.getAllMealByDateId(date.getId());
                //delete old meal from the date of the sync week

                //loop for each simlar date in that template
                for (int i = 0; i < planLength; i++) {
                    Calendar loopDate = Calendar.getInstance();
                    loopDate.setTime(date.getDate());
                    loopDate.add(Calendar.DATE, i * 7);
                    java.sql.Date currentDate = new java.sql.Date(loopDate.getTimeInMillis());

                    DateDTO modifiedDate = DateDAO.getDateIdByPlanIdAndDateInWeeklyPlan(planId, currentDate);
                    //delete meal of that date
                    MealDAO.deleteAllMealByDate(planId, modifiedDate.getId());
                    //copy meal of the template to that date
                    WeeklyPlanTemplateDAO.syncWithTemplate(modifiedDate.getId(), templateMeals);

                }
            }
            
            
            //forward to the edit weekly template page again
            request.getRequestDispatcher("#").forward(request, response);

        } catch (Exception ex) {
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
