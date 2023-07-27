/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DailyPlanTemplateDAO;
import DAO.DateDAO;
import DAO.MealDAO;
import DAO.PlanDAO;
import DAO.WeekDAO;
import DAO.WeeklyPlanTemplateDAO;
import DTO.DateDTO;
import DTO.MealDTO;
import DTO.PlanDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Daiisuke
 */
public class PlanInformationEditServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String des = request.getParameter("des");
        String note = request.getParameter("note");
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        PlanDTO plan = PlanDAO.getPlanById(id);
        Date start_date = plan.getStart_at();
        Date end_date = plan.getEnd_at();

        int planLength = Integer.parseInt(request.getParameter("planLength"));

        if (plan.isDaily()) {

            // Calculate end date
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(start_date);
            calendar.add(Calendar.DATE, planLength);

            java.sql.Date end_date_after = new java.sql.Date(calendar.getTimeInMillis());

            PlanDAO.updatePlanByID(id, des, note, end_date_after);

            LocalDate endBefore = end_date.toLocalDate();
            LocalDate endAfter = end_date_after.toLocalDate();

            if (endBefore.isEqual(endAfter)) {

            }
            if (endBefore.isBefore(endAfter)) {
                //add more date to plan
                Calendar loopDate = Calendar.getInstance();
                loopDate.setTime(end_date);

                while (loopDate.getTime().before(end_date_after) || loopDate.getTime().equals(end_date_after)) {
                    // Insert daily meal for the new date
                    java.sql.Date currentDate = new java.sql.Date(loopDate.getTimeInMillis());
                    boolean isMealInserted = DateDAO.insertDateForDaily(currentDate, id);

                    // Increment loop date by one day
                    loopDate.add(Calendar.DATE, 1);
                }

                //apply template for the new date
                int templateId = DailyPlanTemplateDAO.getDailyTemplateIdByPlanId(id);

                ArrayList<MealDTO> templateMeals = MealDAO.getAllMealByDateId(templateId);
                //list of all normal date in that plan
                ArrayList<Integer> idList = DailyPlanTemplateDAO.getSyncDateId(id);
                //delete old meal from the sync date -- leave the unsync date alone
                DailyPlanTemplateDAO.deleteSyncDateMeal(id, idList);

                if (templateMeals.size() > 0) {
                    //sync normal date with template meal
                    DailyPlanTemplateDAO.syncWithDailyTemplate(idList, templateMeals);
                }

            } else {
                //shorten the time of plan -> delete the date that are not in the plan
                Calendar loopDate = Calendar.getInstance();
                loopDate.setTime(end_date_after);

                while (loopDate.getTime().before(end_date) || loopDate.getTime().equals(end_date)) {
                    // Delete date
                    java.sql.Date currentDate = new java.sql.Date(loopDate.getTimeInMillis());
                    DateDTO date = DateDAO.getDateIdByPlanIdAndDate(id, currentDate);

                    MealDAO.deleteAllMealByDate(id, date.getId());
                    DateDAO.deleteDateByDateId(date.getId());

                    // Increment loop date by one day
                    loopDate.add(Calendar.DATE, 1);
                }
            }
        } //WEEKLY 
        else {
            // Calculate end date

            long millisDiff = plan.getEnd_at().getTime() - plan.getStart_at().getTime();
            int planLengthOld = (int) (millisDiff / (1000 * 60 * 60 * 24 * 7)) + 1; // for weekly

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(start_date);
            calendar.add(Calendar.DATE, (planLength * 7) - 1);

            java.sql.Date end_date_after = new java.sql.Date(calendar.getTimeInMillis());

            PlanDAO.updatePlanByID(id, des, note, end_date_after);

            LocalDate endBefore = end_date.toLocalDate();
            LocalDate endAfter = end_date_after.toLocalDate();

            if (planLength == planLengthOld) {

            }
            if (planLength > planLengthOld) {
                // get the different
                int diff = planLength - planLengthOld;
                //get the start of the new week
                Calendar endDate = Calendar.getInstance();
                endDate.setTime(end_date);
                endDate.add(calendar.DATE, 1);
                
                //add new week and date of that week
                for(int i= 0; i < diff; i++){
                    java.sql.Date currentDate = new java.sql.Date(endDate.getTimeInMillis());
                    int weekId = DateDAO.insertWeekForWeekly(currentDate, id);
                    DateDAO.insertAllDatesWithinAWeek(currentDate, weekId, id);
                    endDate.add(calendar.DATE, 7);
                }
                
                //get template week id
                int templateId = WeeklyPlanTemplateDAO.getWeeklyTemplateIdByPlanId(id);

                //list of all normal Week in that plan
                ArrayList<Integer> weeklyIdList = WeeklyPlanTemplateDAO.getSyncWeekId(id);
                ArrayList<DateDTO> dateInTemplate = DateDAO.getAllDateByPlanIDAndWeekID(id, templateId);

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

                        DateDTO modifiedDate = DateDAO.getDateIdByPlanIdAndDateInWeeklyPlan(id, currentDate);
                        //delete meal of that date
                        MealDAO.deleteAllMealByDate(id, modifiedDate.getId());
                        //copy meal of the template to that date
                        WeeklyPlanTemplateDAO.syncWithTemplate(modifiedDate.getId(), templateMeals);

                    }
                }

            } else {
                //shorten the time of plan -> delete the date that are not in the plan
                Calendar loopDate = Calendar.getInstance();
                loopDate.setTime(end_date_after);
                loopDate.add(Calendar.DATE, 1);

                while (loopDate.getTime().before(end_date) || loopDate.getTime().equals(end_date)) {
                    // Delete date
                    java.sql.Date currentDate = new java.sql.Date(loopDate.getTimeInMillis());
                    DateDTO date = DateDAO.getDateIdByPlanIdAndDate(id, currentDate);

                    MealDAO.deleteAllMealByDate(id, date.getId());
                    DateDAO.deleteDateByDateId(date.getId());
                    
                    //Delete week -> delete week that have no date 
                    ArrayList<Integer> emptyWeekList = WeeklyPlanTemplateDAO.getEmptyWeekId(id);
                    for(Integer weekId : emptyWeekList){
                        WeekDAO.deleteWeekOnId(weekId);
                    }
                    
                    // Increment loop date by one day
                    loopDate.add(Calendar.DATE, 1);
                }
            }
        }
        request.getRequestDispatcher("UserController?action=getPlanDetailById&id=" + id).forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(PlanInformationEditServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(PlanInformationEditServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
