/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.FavoriteDAO;
import DAO.RecipeDAO;
import DAO.ReviewDAO;
import DAO.UserDAO;
import DAO.UserDetailDAO;
import DTO.DisplayRecipeDTO;
import DTO.DisplayReviewDTO;
import DTO.FavoriteDTO;
import DTO.RecipeDTO;
import DTO.ReviewDTO;
import DTO.UserDTO;
import DTO.UserDetailDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author khang
 */
public class LoadPublicProfileServlet extends HttpServlet {

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
            String accountName = request.getParameter("accountName");
            UserDTO account = UserDAO.getAccountByName(accountName);

            UserDetailDTO accountDetail = null;
            ArrayList<DisplayRecipeDTO> accountPublicRecipe = new ArrayList<>();
            ArrayList<DisplayReviewDTO> displayReviewList = new ArrayList<>();
            ArrayList<DisplayRecipeDTO> favoriteList = new ArrayList<>();
            if (account != null) {
                accountDetail = UserDetailDAO.getUserDetailByUserId(account.getId());

                // Get account favorite recipes list
                ArrayList<FavoriteDTO> favoriteRecipeList = FavoriteDAO.getAllFavoriteRecipeByUserId(account.getId());
                for (FavoriteDTO r : favoriteRecipeList) {
                    String title = RecipeDAO.getRecipeByRecipeId(r.getRecipe_id()).getTitle();
                    String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                    String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                    double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                    UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                    DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), title, thumbnailPath, category, rating, owner);
                    favoriteList.add(d);
                }

                //get accountPublicRecipeList
                ArrayList<RecipeDTO> recipeList = RecipeDAO.getRecipeByUserIdAndType(account.getId(), 2);
                for (RecipeDTO r : recipeList) {
                    String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                    String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                    double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                    UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                    DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                    accountPublicRecipe.add(d);
                }

                //get reviewList
                ArrayList<ReviewDTO> reviewList = ReviewDAO.getReviewByUserId(account.getId());
                if (reviewList.size() > 0) {
                    for (ReviewDTO r : reviewList) {
                        String title = RecipeDAO.getRecipeByRecipeId(r.getRecipe_id()).getTitle();
                        String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getRecipe_id()).getThumbnailPath();
                        String category = RecipeDAO.getCategoryByRecipeId(r.getRecipe_id());
                        UserDTO recipeOwner = RecipeDAO.getRecipeOwnerByRecipeId(r.getRecipe_id());

                        DisplayReviewDTO d = new DisplayReviewDTO(r.getId(), r.getRating(), r.getContent(), r.getRecipe_id(), title,
                                thumbnailPath, category, recipeOwner);

                        displayReviewList.add(d);
                    }
                }

                //get favoriteList
            }

            request.setAttribute("account", account);
            request.setAttribute("accountDetail", accountDetail);
            request.setAttribute("accountPublicRecipe", accountPublicRecipe);
            request.setAttribute("reviewList", displayReviewList);
            request.setAttribute("favoriteList", favoriteList);

            request.getRequestDispatcher("userCommunityProfile.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
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
