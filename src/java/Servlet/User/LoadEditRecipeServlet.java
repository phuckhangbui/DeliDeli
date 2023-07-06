/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DirectionDAO;
import DAO.IngredientDetailDAO;
import DAO.NutritionDAO;
import DAO.RecipeDAO;
import DAO.RecipeDietDAO;
import DTO.IngredientDetailDTO;
import DTO.NutritionDTO;
import DTO.RecipeDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author khang
 */
public class LoadEditRecipeServlet extends HttpServlet {

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
            int recipeId = Integer.parseInt(request.getParameter("recipeId"));
            RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(recipeId);
            Set<Integer> dietSet = RecipeDietDAO.getDietSetByRecipeId(recipeId);
            NutritionDTO nutrition = NutritionDAO.getNutrition(recipeId);
            ArrayList<IngredientDetailDTO> ingredientList = IngredientDetailDAO.getIngredientDetailByRecipeId(recipe.getId());
            String direction = DirectionDAO.getDirectionByRecipeId(recipe.getId()).getDesc();
            
            request.setAttribute("recipe", recipe);
            request.setAttribute("dietSet", dietSet);
            request.setAttribute("nutrition", nutrition);
            request.setAttribute("ingredientList", ingredientList);
            request.setAttribute("direction", direction);

            request.getRequestDispatcher("editRecipe.jsp").forward(request, response);
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
