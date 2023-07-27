/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.DietDAO;
import DAO.PlanDAO;
import DAO.RecipeDAO;
import DTO.DateDTO;
import DTO.DietDTO;
import DTO.DisplayRecipeDTO;
import DTO.PlanDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import static Servlet.User.PlanDetailServlet.calculateDistanceInDays;
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
 * @author khang
 */
public class LoadEditPlanDetailServlet extends HttpServlet {

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

            String id = request.getParameter("id");

            //Daily
            if (id != null && !id.isEmpty()) {
                PlanDTO plan = PlanDAO.getUserPlanById(Integer.parseInt(id));
                request.setAttribute("plan", plan);

                java.sql.Date startDateSQL = plan.getStart_at();
                java.sql.Date endDateSQL = plan.getEnd_at();

                long millisDiff = endDateSQL.getTime() - startDateSQL.getTime();

                if (plan.isDaily()) {
                    int planLength = (int) (millisDiff / (1000 * 60 * 60 * 24));

                    request.setAttribute("planLength", planLength);
                    request.getRequestDispatcher("editDailyPlanDetail.jsp").forward(request, response);
                } else {
                    int planLength = (int) (millisDiff / (1000 * 60 * 60 * 24 * 7)) + 1;

                    request.setAttribute("planLength", planLength);
                    request.getRequestDispatcher("editWeeklyPlanDetail.jsp").forward(request, response);
                }
            }

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
