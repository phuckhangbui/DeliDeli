/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.DirectionDAO;
import DAO.FavoriteDAO;
import DTO.DirectionDTO;
import DAO.IngredientDetailDAO;
import DTO.IngredientDetailDTO;
import DAO.NutritionDAO;
import DTO.NutritionDTO;
import DAO.RecipeDAO;
import DTO.RecipeDTO;
import DTO.RecipeImageDTO;
import DAO.ReviewDAO;
import DAO.UserDAO;
import DTO.DisplayReviewDTO;
import DTO.ReviewDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class RecipeDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String id = request.getParameter("id"); //Requires the recipeID Param
            System.out.println("[RECIPE_DETAILED]: ID Recieved = " + id);

            //RECIPE----------------------------------------------------------------------------------
            RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(new Integer(id));
            request.setAttribute("recipe", recipe);

            String category = RecipeDAO.getCategoryByRecipeId(new Integer(id));
            request.setAttribute("category", category);

            String imgPath = RecipeDAO.getImageByRecipeId(new Integer(id)).getImgPath();
            request.setAttribute("imgPath", imgPath);

            String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(recipe.getId()).getThumbnailPath();
            request.setAttribute("thumbnailPath", thumbnailPath);

            UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(new Integer(id));
            request.setAttribute("owner", owner);

            int totalReview = RecipeDAO.getTotalReviewByRecipeId(new Integer(id));
            request.setAttribute("totalReview", totalReview);

            double avgRating = RecipeDAO.getRatingByRecipeId(new Integer(id));
            request.setAttribute("avgRating", avgRating);

            ArrayList<IngredientDetailDTO> ingredientDetailList = IngredientDetailDAO.getIngredientDetailByRecipeId(new Integer(id));
            request.setAttribute("ingredientDetailList", ingredientDetailList);

            NutritionDTO nutrition = NutritionDAO.getNutrition(new Integer(id));
            request.setAttribute("nutrition", nutrition);

            DirectionDTO direction = DirectionDAO.getDirectionByRecipeId(new Integer(id));
            request.setAttribute("direction", direction);

            //REVIEW----------------------------------------------------------------------------------
            ArrayList<ReviewDTO> reviewList = ReviewDAO.getReviewByRecipeId(new Integer(id));
            ArrayList<DisplayReviewDTO> displayList = new ArrayList<>();
            if (reviewList.size() > 0) {
                for (ReviewDTO r : reviewList) {
                    String title = RecipeDAO.getRecipeByRecipeId(r.getRecipe_id()).getTitle();
                    thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getRecipe_id()).getThumbnailPath();
                    category = RecipeDAO.getCategoryByRecipeId(r.getRecipe_id());
                    UserDTO recipeOwner = RecipeDAO.getRecipeOwnerByRecipeId(r.getRecipe_id());
                    DisplayReviewDTO d = new DisplayReviewDTO(r.getId(), r.getRating(), r.getContent(), r.getRecipe_id(), title,
                            thumbnailPath, category, recipeOwner, UserDAO.getUserByUserId(r.getUser_id()), r.getCreate_at(), r.getUpdate_at());

                    displayList.add(d);
                }
            }

            // User review for edit
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user != null) {
                ReviewDTO userReview = ReviewDAO.getReviewByRecipeAndUser(user.getId(), Integer.parseInt(id));
                DisplayReviewDTO userDisplayReview = null;
                if (userReview != null) {
                    String title = RecipeDAO.getRecipeByRecipeId(userReview.getRecipe_id()).getTitle();
                    thumbnailPath = RecipeDAO.getThumbnailByRecipeId(userReview.getRecipe_id()).getThumbnailPath();
                    category = RecipeDAO.getCategoryByRecipeId(userReview.getRecipe_id());
                    UserDTO recipeOwner = RecipeDAO.getRecipeOwnerByRecipeId(userReview.getRecipe_id());
                    userDisplayReview = new DisplayReviewDTO(userReview.getId(), userReview.getRating(), userReview.getContent(), userReview.getRecipe_id(), title,
                            thumbnailPath, category, recipeOwner, UserDAO.getUserByUserId(userReview.getUser_id()), userReview.getCreate_at(), userReview.getUpdate_at());

                }
                request.setAttribute("userDisplayReview", userDisplayReview);
                
            //check save recipe
                boolean isSave = FavoriteDAO.isSaveRecipe(user.getId(), recipe.getId());
                request.setAttribute("isSaveRecipe", isSave);
                
            }

            request.setAttribute("reviewList", reviewList);
            request.setAttribute("displayReviewList", displayList);

            request.getRequestDispatcher("recipeDetail.jsp").forward(request, response);

//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet RecipeDetailServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Recipe id: " + id + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
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
