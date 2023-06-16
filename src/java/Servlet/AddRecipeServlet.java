/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Direction.DirectionDAO;
import Direction.DirectionDTO;
import IngredientDetail.IngredientDetailDAO;
import IngredientDetail.IngredientDetailDTO;
import Recipe.RecipeDAO;
import Recipe.RecipeDTO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author khang
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB - exceed 2MB => disk, else memory => caching.
        maxFileSize = 1024 * 1024 * 10, // 10MB => maximum upload to server.
        maxRequestSize = 1024 * 1024 * 50) // 50MB => maximum request from server.

public class AddRecipeServlet extends HttpServlet {

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

            
            Date currentDate = new Date(System.currentTimeMillis());
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String thumbnail = request.getParameter("thumbnail");
            String pictures = request.getParameter("pictures");
            int prepTime = Integer.parseInt(request.getParameter("prepTimeMinutes"));
            int cookTime = Integer.parseInt(request.getParameter("cookTimeMinutes"));
            int servings = Integer.parseInt(request.getParameter("servings"));
            int diet = Integer.parseInt(request.getParameter("diet"));
            int category = Integer.parseInt(request.getParameter("category"));
            int cuisine = Integer.parseInt(request.getParameter("cuisine"));
            int level = Integer.parseInt(request.getParameter("level"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int status = Integer.parseInt(request.getParameter("status"));

            RecipeDTO newRecipe = new RecipeDTO(title, description, prepTime, cookTime, servings,
                    currentDate, null, cuisine, category, userId, level, status); // Process other parameters as needed...
            int recipeId = RecipeDAO.addRecipe(newRecipe);
            request.setAttribute("recipeId", recipeId);
            out.print(newRecipe.toString());
            String[] ingredientDesc = request.getParameterValues("ingredientDesc");
            String[] ingredientId = request.getParameterValues("ingredientId");

            // Process the ingredient parameters
            List<IngredientDetailDTO> detailList = new ArrayList<IngredientDetailDTO>();
            if (ingredientDesc != null && ingredientId != null && ingredientDesc.length == ingredientId.length) {
                for (int i = 0; i < ingredientDesc.length; i++) {
                    String desc = ingredientDesc[i];
                    int id = Integer.parseInt(ingredientId[i]);
                    IngredientDetailDTO detail = new IngredientDetailDTO(desc, id, recipeId);
                    detailList.add(detail);
                }
            }

            IngredientDetailDAO.addIngredientDetails(detailList);
            // ...

            // Create a list to store DirectionDTO objects;
            
            String directionDesc = request.getParameter("direction");
            DirectionDAO.addDirections(new DirectionDTO (directionDesc, recipeId));
            
            
            request.getRequestDispatcher("UploadImageServlet").forward(request, response);
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
