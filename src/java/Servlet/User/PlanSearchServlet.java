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

/**
 *
 * @author Daiisuke
 */
public class PlanSearchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Boolean isPlan = Boolean.parseBoolean(request.getParameter("isPlan"));
        String txtsearch = request.getParameter("txtsearch").toLowerCase();
        String searchBy = request.getParameter("searchBy").toLowerCase();
        String plan_id = request.getParameter("planId").toLowerCase();

        if (isPlan != null && isPlan) {
            ArrayList<RecipeDTO> list = NavigationBarUtils.searchRecipes(txtsearch, searchBy);
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
            String url = "UserController?action=editPlan&id=" + plan_id + "&isSearch=true";
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
