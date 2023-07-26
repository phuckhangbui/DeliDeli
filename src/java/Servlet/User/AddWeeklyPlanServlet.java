/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.PlanDAO;
import DAO.WeeklyPlanTemplateDAO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author khang
 */
public class AddWeeklyPlanServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");

            String start_date_str = request.getParameter("start_date");
            java.sql.Date start_date = java.sql.Date.valueOf(start_date_str);
            int planLength = Integer.parseInt(request.getParameter("planLength"));

            // Calculate end date
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(start_date);
            calendar.add(Calendar.DATE, planLength * 7);

            java.sql.Date end_date = new java.sql.Date(calendar.getTimeInMillis());

            calendar.setTime(end_date);
            

            String name = (String) session.getAttribute("createPlanTitle");  // title in fe, name in be lmao
            String description = (String) session.getAttribute("createPlanDescription");
            int dietId = (int) session.getAttribute("createPlanDietId");
            boolean status = false;
            boolean result = false;
            int id = 0;

            try {
                result = PlanDAO.insertPlan(name, description, "", start_date, end_date, status, user.getId(), dietId, false);
                id = PlanDAO.getPlanByUserIdAndName(user.getId(), name);
                
                int weekTemplateId = WeeklyPlanTemplateDAO.insertWeekTemplate(id, start_date);
                WeeklyPlanTemplateDAO.insertDateOfWeeklyTemplate(start_date, weekTemplateId, id);
            } catch (Exception ex) {
                System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
                response.sendRedirect("error.jsp");
            }

            try {
                // Loop from start_date to end_date
                Calendar loopDate = Calendar.getInstance();
                loopDate.setTime(start_date);
                
                for(int i = 0; i< planLength; i++) {
                    // Insert daily meal
                    java.sql.Date currentDate = new java.sql.Date(loopDate.getTimeInMillis());
                    int weekId = DateDAO.insertWeekForWeekly(currentDate, id);
                    DateDAO.insertAllDatesWithinAWeek(currentDate, weekId, id);
                    
                    // Increment loop date by seven day
                    loopDate.add(Calendar.DATE, 7);
                }
            } catch (Exception ex) {
                System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
                response.sendRedirect("error.jsp");
            }

            
            session.setAttribute("createPlanTitle", null);
            session.setAttribute("createPlanDescription", null);
            session.setAttribute("createPlanDietId", null);
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
