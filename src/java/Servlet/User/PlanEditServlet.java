/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DietDAO;
import DTO.DietDTO;
import DAO.PlanDAO;
import DTO.PlanDTO;
import DAO.PlanDateDAO;
import DTO.DisplayRecipeDTO;
import DTO.PlanDateDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
@WebServlet(name = "PlanEditServlet", urlPatterns = {"/PlanEditServlet"})
public class PlanEditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        ArrayList<DisplayRecipeDTO> displayList = (ArrayList<DisplayRecipeDTO>) request.getAttribute("searchRecipesList");
        boolean isSearch = Boolean.parseBoolean(request.getParameter("isSearch"));

        if (id != null && !id.isEmpty()) {
            PlanDTO plan = PlanDAO.getUserPlanById(Integer.parseInt(id));
            request.setAttribute("plan", plan);

            DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
            request.setAttribute("diet", diet);

            ArrayList<PlanDateDTO> planDate = PlanDateDAO.getAllDateByPlanId(plan.getId());
            request.setAttribute("planDate", planDate);

            if (isSearch) {
                request.setAttribute("SEARCH_LIST", displayList);
                request.setAttribute("SEARCH_PLAN_REAL", true);
                RequestDispatcher rq = request.getRequestDispatcher("addRecipeToPlan.jsp");
                rq.forward(request, response);
                return;
            } else {
                request.setAttribute("SEARCH_PLAN_REAL", false);
                RequestDispatcher rq = request.getRequestDispatcher("addRecipeToPlan.jsp");
                rq.forward(request, response);
                return;
            }
        }

        response.sendRedirect("error.jsp");

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
