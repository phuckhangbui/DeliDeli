/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.PlanDAO;
import DTO.DateDTO;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
public class PlanInformationEditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int plan_id = Integer.parseInt(request.getParameter("plan_id"));
        boolean result = false;
        boolean checkWeek = false;
        boolean checkDate = false;
        String url = "error.jsp";

        String start_date_str = request.getParameter("start_date");
        java.sql.Date start_date = java.sql.Date.valueOf(start_date_str);
        LocalDate startDate = LocalDate.parse(start_date_str);
        LocalDate end_date_str = startDate.plusDays(6);
        java.sql.Date end_date = java.sql.Date.valueOf(end_date_str);

        String plan_title = request.getParameter("plan_title");
        int diet_id = Integer.parseInt(request.getParameter("recipeDietId"));
        String plan_description = request.getParameter("plan_description");
        String plan_note = request.getParameter("plan_note");

        ArrayList<DateDTO> dateBeforeUpdate = DateDAO.getAllDateByPlanID(plan_id);

        try {
            if (plan_id > 0) {
                result = PlanDAO.updatePlanByID(plan_id, diet_id, plan_title, plan_description, plan_note, start_date, end_date);
                if (result) {
                    checkWeek = PlanDAO.updateWeekByPlanID(plan_id, start_date);
                    if (checkWeek) {
                        for (DateDTO list : dateBeforeUpdate) {
//                            System.out.println("Date List - " + list.getId());
                            checkDate = DateDAO.updateDate(list.getId(), start_date);
                            startDate = startDate.plusDays(1);
                            start_date = java.sql.Date.valueOf(startDate);
//                            System.out.println("Date reiterate - " + start_date);
                        }
                    }
                }
            }

            if (result && checkWeek && checkDate) {
                url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false";
            }
            
        } catch (Exception ex) {
            System.out.println("[PlanInformationEditServlet - ERROR]: " + ex.getMessage());
            response.sendRedirect(url);
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
