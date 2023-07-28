/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.DietDAO;
import DTO.DietDTO;
import DAO.PlanDAO;
import DTO.PlanDTO;
import DTO.DateDTO;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
public class PlanDetailServlet extends HttpServlet {

    public static long calculateDistanceInDays(LocalDate startDate, LocalDate endDate) {
        return ChronoUnit.DAYS.between(startDate, endDate);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        boolean foundMatchingDate = false;
        boolean isDaily = false;

        PlanDTO plan = PlanDAO.getUserPlanById(new Integer(id));
        request.setAttribute("plan", plan);

        // Daily
        if (plan.isDaily()) {
            ArrayList<DateDTO> planDate = DateDAO.getAllDateByPlanID(plan.getId());
            ArrayList<DateDTO> displayDate = new ArrayList<>();

            LocalDate currentDate = LocalDate.now();
            java.sql.Date startDateSQL = plan.getStart_at();
            LocalDate startLocalDate = startDateSQL.toLocalDate();
            int distanceInDays = (int) calculateDistanceInDays(startLocalDate, currentDate);

//        System.out.println("distanceInDays - " + distanceInDays);
            // distanceInDays here act as an param to detect whether the date changed at page by user.
            String distanceInDaysParam = request.getParameter("distanceInDays");

//        System.out.println("distanceInDaysParam - " + distanceInDaysParam);
            if (distanceInDaysParam != null) {
                distanceInDays = Integer.parseInt(distanceInDaysParam);
                request.setAttribute("distanceInDays", distanceInDays);

                // A little note for myself (how it traverse through date automatically)
                // After calculate the distance date, the plan will change the date based on the distance in date value
                // dateList is the every date inside that plan, it will traverse through every date til they find the 
                // startLocalDate (plan startdate) == dateList and add it to the arrayList to display on JSP.
                for (DateDTO date : planDate) {
                    LocalDate dateList = date.getDate().toLocalDate();
                    if (dateList.equals(startLocalDate.plusDays(distanceInDays))) {
                        displayDate.add(date);
                        break;
                    }
                }
                // If currentDate is out of plan date scope then return plan start date
            } else {
                for (DateDTO date : planDate) {
                    LocalDate dateList = date.getDate().toLocalDate();

                    if (dateList.equals(currentDate)) {
                        displayDate.add(date);
                        foundMatchingDate = true;
                        break;
                    }
                }
                if (!foundMatchingDate && !planDate.isEmpty()) {
                    DateDTO firstDate = planDate.get(0);
                    displayDate.add(firstDate);
                }
            }

            request.setAttribute("planDate", displayDate);
            request.setAttribute("allPlanDate", planDate);

            DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
            request.setAttribute("diet", diet);

            //ArrayList<MealDTO> meal = MealDAO.getAllMealByDateId(planDate);
            RequestDispatcher rq = request.getRequestDispatcher("userViewPlan.jsp");
            rq.forward(request, response);

            // Weekly    
        } else {
            ArrayList<DateDTO> planDate = DateDAO.getAllDateByPlanID(plan.getId());
            ArrayList<DateDTO> displayDate = new ArrayList<>();

            LocalDate currentDate = LocalDate.now();
            java.sql.Date startDateSQL = plan.getStart_at();
            LocalDate startLocalDate = startDateSQL.toLocalDate();
            int distanceInDays = (int) calculateDistanceInDays(startLocalDate, currentDate);

            String distanceInDaysParam = request.getParameter("distanceInDays");

            request.setAttribute("planDate", planDate);
//            request.setAttribute("allPlanDate", planDate);

            DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
            request.setAttribute("diet", diet);

            //ArrayList<MealDTO> meal = MealDAO.getAllMealByDateId(planDate);
            RequestDispatcher rq = request.getRequestDispatcher("userViewPlanWeekly.jsp");
            rq.forward(request, response);
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
