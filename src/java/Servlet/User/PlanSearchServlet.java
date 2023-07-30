/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.RecipeDAO;
import DTO.DisplayRecipeDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import Utils.NavigationBarUtils;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Daiisuke
 */
public class PlanSearchServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        boolean isTemplate = false;
        String url = ERROR;

        Boolean isPlan = Boolean.parseBoolean(request.getParameter("isPlan"));
        String txtsearch = request.getParameter("txtsearch").toLowerCase();
        String searchBy = request.getParameter("searchBy");
        String plan_id = request.getParameter("planId").toLowerCase();
        int dietId = Integer.parseInt(request.getParameter("dietId"));
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int distanceInDays = Integer.parseInt(request.getParameter("distanceInDays"));
        boolean isDaily = Boolean.parseBoolean(request.getParameter("isDaily"));
        String selectedDate = request.getParameter("selectedDate");

        if (isPlan) {
            ArrayList<RecipeDTO> list = NavigationBarUtils.searchRecipeForPlan(txtsearch, searchBy, user_id, dietId);
            ArrayList<DisplayRecipeDTO> displayList = new ArrayList<>();
            for (RecipeDTO r : list) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                displayList.add(d);
            }
            request.setAttribute("searchRecipesList", displayList);

            if (isDaily) {
                url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&distanceInDays=" + distanceInDays;
            } else {
                url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=false&selectedDate=" + selectedDate;
            }
            isTemplate = Boolean.parseBoolean(request.getParameter("isTemplate"));
            if (isTemplate) {
                if (isDaily) {
                    url = "LoadEditDailyTemplateServlet?id=" + plan_id + "&isSearch=false";
                } else {
                    url = "LoadEditWeeklyTemplateServlet?id=" + plan_id + "&isSearch=false";
                }

            }
            request.getRequestDispatcher(url).forward(request, response);
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
