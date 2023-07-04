/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DirectionDAO;
import DTO.DirectionDTO;
import DAO.IngredientDetailDAO;
import DTO.IngredientDetailDTO;
import DAO.NutritionDAO;
import DTO.NutritionDTO;
import DAO.RecipeDAO;
import DTO.RecipeDTO;
import DAO.RecipeDietDAO;
import DTO.RecipeDietDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author khang
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB - exceed 2MB => disk, else memory => caching.
        maxFileSize = 1024 * 1024 * 10, // 10MB => maximum upload to server.
        maxRequestSize = 1024 * 1024 * 50) // 50MB => maximum request from server.

public class EditRecipeServlet extends HttpServlet {

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

            Timestamp currentDate = new Timestamp(System.currentTimeMillis());
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String thumbnail = request.getParameter("thumbnail");
            String pictures = request.getParameter("pictures");
            int prepTime = Integer.parseInt(request.getParameter("prepTimeMinutes"));
            int cookTime = Integer.parseInt(request.getParameter("cookTimeMinutes"));
            int servings = Integer.parseInt(request.getParameter("servings"));

            int category = Integer.parseInt(request.getParameter("category"));
            int cuisine = Integer.parseInt(request.getParameter("cuisine"));
            int level = Integer.parseInt(request.getParameter("level"));

            int userId = Integer.parseInt(request.getParameter("userId"));
            int status = Integer.parseInt(request.getParameter("status"));
            int recipeId = Integer.parseInt(request.getParameter("recipeId"));
            RecipeDTO newRecipe = new RecipeDTO(recipeId, title, description, prepTime, cookTime, servings,
                    null, currentDate, cuisine, category, userId, level, status); // Process other parameters as needed...

            RecipeDAO.editRecipe(newRecipe);
            request.setAttribute("recipeId", recipeId);
            out.print(newRecipe.toString());

            //Process nutrition
            int calories = Integer.parseInt(request.getParameter("calories"));
            int fat = Integer.parseInt(request.getParameter("fat"));
            int carbs = Integer.parseInt(request.getParameter("carbs"));
            int protein = Integer.parseInt(request.getParameter("protein"));

            NutritionDTO nutrition = new NutritionDTO(recipeId, calories, fat, carbs, protein);
            NutritionDAO.deleteNutrition(recipeId);
            NutritionDAO.addNutrition(nutrition);

            //Process Diet
            String[] txtDiet = request.getParameterValues("diet");

            List<RecipeDietDTO> dietList = new ArrayList<RecipeDietDTO>();
            if (txtDiet != null) {
                for (int j = 0; j < txtDiet.length; j++) {
                    int dietId = Integer.parseInt(txtDiet[j]);
                    RecipeDietDTO diet = new RecipeDietDTO(0, recipeId, dietId);
                    dietList.add(diet);
                }
            }
            RecipeDietDAO.deleteRecipeDiet(recipeId);
            RecipeDietDAO.addRecipeDiet(dietList);

            // Process the ingredient parameters
            String[] ingredientDesc = request.getParameterValues("ingredientDesc");
            String[] ingredientId = request.getParameterValues("ingredientId");

            List<IngredientDetailDTO> detailList = new ArrayList<IngredientDetailDTO>();
            if (ingredientDesc != null && ingredientId != null && ingredientDesc.length == ingredientId.length) {
                for (int i = 0; i < ingredientDesc.length; i++) {
                    String desc = ingredientDesc[i];
                    int id = Integer.parseInt(ingredientId[i]);
                    IngredientDetailDTO detail = new IngredientDetailDTO(desc, id, recipeId);
                    detailList.add(detail);
                }
            }
            IngredientDetailDAO.deleteIngredientDetails(recipeId);
            IngredientDetailDAO.addIngredientDetails(detailList);
            // ...

            // Create a list to store DirectionDTO objects;
            String directionDesc = request.getParameter("direction");
            DirectionDAO.deleteDirection(recipeId);
            DirectionDAO.addDirections(new DirectionDTO(directionDesc, recipeId));

            request.getRequestDispatcher("UploadImageServlet").include(request, response);
            if (status == 1) {
                request.getRequestDispatcher("UserController?action=loadRecipeManagement&page=private&userId" + userId)
                        .include(request, response);
            }else{
                request.getRequestDispatcher("UserController?action=loadRecipeManagement&page=pending&userId" + userId)
                        .include(request, response);
            }
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
