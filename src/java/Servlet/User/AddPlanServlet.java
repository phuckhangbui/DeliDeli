/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.PlanDAO;
import DTO.PlanDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
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
public class AddPlanServlet extends HttpServlet {

//    private static final String ADD_PLAN = "addPlan.jsp";
    private static final String ERROR = "error.jsp";
    private static final String ADD_PLAN = "UserController?action=categoryLoadToPlan";
    private static final String DAILY_PlAN = "addDailyPlan.jsp";
    private static final String WEEKLY_PlAN = "addWeeklyPlan.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;

        if (request.getMethod().equals("POST")) {
            // Miscellaneous variables
            boolean result = false;
            boolean isWeekAdded = false;
            boolean areDatesAdded = false;
            String period = request.getParameter("period");
            String error = "";

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int dietID = Integer.parseInt(request.getParameter("recipeDietId"));

            System.out.println(title);
            System.out.println(description);
            System.out.println(dietID);
            System.out.println(period);
            HttpSession session = request.getSession();
            
            session.setAttribute("createPlanTitle", title);
            session.setAttribute("createPlanDescription", description);
            session.setAttribute("createPlanDietId", dietID);
            
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (!PlanDAO.checkPlanTitleDuplicateByUserID(title, user.getId())) {
                error = "Your have already used the plan's title " + title + " before, please choose other title.";
                request.setAttribute("createPlanError", error);
                url = ADD_PLAN;
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
                return;
            }

            if (period.equalsIgnoreCase("daily")) {

                int id = 0;
                String name = request.getParameter("name");
                description = request.getParameter("description");
                String note = request.getParameter("note");
                dietID = Integer.parseInt(request.getParameter("recipeDietId"));
                int userID = Integer.parseInt(request.getParameter("userId"));
                boolean status = false;
                boolean isDaily = true;

                String start_date_str = request.getParameter("start_date");
                java.sql.Date start_date = java.sql.Date.valueOf(start_date_str);
                String end_date_str = request.getParameter("end_date");
                java.sql.Date end_date = java.sql.Date.valueOf(end_date_str);

                if (!PlanDAO.checkPlanTitleDuplicateByUserID(name, userID)) {
                    error = "Recipe title must be unique !";
                    request.setAttribute("errorList", error);
                    url = ADD_PLAN;
                    RequestDispatcher rd = request.getRequestDispatcher(url);
                    rd.forward(request, response);
                    return;
                }

                if (!name.isEmpty() && !description.isEmpty()) {
                    try {
                        result = PlanDAO.insertPlan(name, description, note, start_date, end_date, status, userID, dietID, isDaily);
                        id = PlanDAO.getPlanByUserIdAndName(userID, name);
                    } catch (Exception ex) {
                        System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
                        response.sendRedirect(ERROR);
                    }

                    try {
                        areDatesAdded = DateDAO.insertDateForDaily(start_date, id);
                    } catch (Exception ex) {
                        System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
                        response.sendRedirect(ERROR);
                    }
                }   

                if (result && areDatesAdded) {
                    url = "UserController?action=editPlan&id=" + id + "&isSearch=false";
                    response.sendRedirect(url);
                    return;
                }

            } else {
                url = WEEKLY_PlAN;
            }

            request.getRequestDispatcher(url).forward(request, response);

//            if (period.equalsIgnoreCase("daily")) {
//
//                int id = 0;
//
//                boolean status = false;
//                String start_date_str = request.getParameter("start_date");
//                java.sql.Date start_date = java.sql.Date.valueOf(start_date_str);
//                String end_date_str = request.getParameter("end_date");
//                java.sql.Date end_date = java.sql.Date.valueOf(end_date_str);
//                if (!PlanDAO.checkPlanTitleDuplicateByUserID(name, userID)) {
//                    errorList.add("Recipe title must be unique !");
//                    request.setAttribute("errorList", errorList);
//                    url = ADD_PLAN;
//                    RequestDispatcher rd = request.getRequestDispatcher(url);
//                    rd.forward(request, response);
//                    return;
//                }
//                if (!name.isEmpty() && !description.isEmpty()) {
//                    try {
//                        result = PlanDAO.insertPlan(name, description, note, start_date, end_date, status, userID, dietID);
//                        id = PlanDAO.getPlanByUserIdAndName(userID, name);
//                    } catch (Exception ex) {
//                        System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
//                        response.sendRedirect(ERROR);
//                    }
//
//                    try {
//                        isWeekAdded = PlanDAO.insertWeek(id, start_date);
//                        int weekId = PlanDAO.getWeekIDByPlanId(id);
//                        areDatesAdded = DateDAO.insertDate(start_date, weekId, id);
//                    } catch (Exception ex) {
//                        System.out.println("[addPlanServlet - ERROR]: " + ex.getMessage());
//                        response.sendRedirect(ERROR);
//                    }
//                }
//                if (result && isWeekAdded && areDatesAdded) {
//                    url = "UserController?action=getPlanDetailById&id=" + id;
//                    response.sendRedirect(url);
//                    return;
//                }
//            } else {
//            }
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
