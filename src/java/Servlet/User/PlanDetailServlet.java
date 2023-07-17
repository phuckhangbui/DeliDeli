/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.DietDAO;
import DTO.DietDTO;
import DAO.MealDAO;
import DTO.MealDTO;
import DAO.PlanDAO;
import DTO.PlanDTO;
import DTO.DateDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");

        //Daily
        PlanDTO plan = PlanDAO.getUserPlanById(new Integer(id));
        request.setAttribute("plan", plan);

        ArrayList<DateDTO> planDate = DateDAO.getAllDateByPlanID(plan.getId());
        ArrayList<DateDTO> displayDate = new ArrayList<>();

        LocalDate currentDate = LocalDate.now();
        java.sql.Date startDate = plan.getStart_at();
        LocalDate startLocalDate = startDate.toLocalDate();
        int distanceInDays = 0;

        String distanceInDaysParam = request.getParameter("distanceInDays");
        if (distanceInDaysParam != null) {
            distanceInDays = Integer.parseInt(distanceInDaysParam);
            request.setAttribute("distanceInDays", distanceInDays);

            for (DateDTO date : planDate) {
                LocalDate dateList = date.getDate().toLocalDate();
                if (dateList.equals(startLocalDate.plusDays(distanceInDays))) {
                    displayDate.add(date);
                    break; // Break after finding the date with the desired distance
                }
            }
        } else {
            for (DateDTO date : planDate) {
                LocalDate dateList = date.getDate().toLocalDate();
                if (dateList.equals(currentDate)) {
                    displayDate.add(date);
                    break; // Break after finding the date with the desired distance
                }
            }
        }

        request.setAttribute("planDate", displayDate);
        request.setAttribute("allPlanDate", planDate);

        DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
        request.setAttribute("diet", diet);

        //ArrayList<MealDTO> meal = MealDAO.getAllMealByDateId(planDate);
        RequestDispatcher rq = request.getRequestDispatcher("userViewPlan.jsp");
        rq.forward(request, response);

        //Weekly
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
