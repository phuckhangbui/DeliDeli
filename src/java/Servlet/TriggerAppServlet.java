/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.NewsDAO;
import DAO.RecipeDAO;
import DAO.SuggestionDAO;
import DTO.DisplayRecipeDTO;
import DTO.NewsDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author khang
 */
public class TriggerAppServlet extends HttpServlet {

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
            HashMap<Integer, String> cateMap
                    = Utils.NavigationBarUtils.getMap("Category");
            HashMap<Integer, String> cuisineMap
                    = Utils.NavigationBarUtils.getMap("Cuisine");
            HashMap<Integer, String> levelMap
                    = Utils.NavigationBarUtils.getMap("Level");
            HashMap<Integer, String> ingredientMap
                    = Utils.NavigationBarUtils.getMap("Ingredient");
            HashMap<Integer, String> dietMap
                    = Utils.NavigationBarUtils.getMap("Diet");
            HashMap<Integer, String> newsMap
                    = Utils.NavigationBarUtils.getMap("NewsCategory");

            HttpSession session = request.getSession();
            session.setAttribute("cateMap", cateMap);
            session.setAttribute("cuisineMap", cuisineMap);
            session.setAttribute("levelMap", levelMap);
            session.setAttribute("ingredientMap", ingredientMap);
            session.setAttribute("dietMap", dietMap);
            session.setAttribute("newsMap", newsMap);

            //-- News section --
            ArrayList<String> listNewsCategories = new ArrayList<>();
            NewsDTO latestNews = NewsDAO.getLatestNews();
            ArrayList<NewsDTO> listNews = NewsDAO.getNext2News(latestNews.getId());

            for (NewsDTO news : listNews) {
                String newsCategory = NewsDAO.getNewsCategoryByNewsId(news.getId());
                listNewsCategories.add(newsCategory);
            }

            session.setAttribute("latestNews", latestNews);
            session.setAttribute("listNews", listNews);
            session.setAttribute("listNewsCategories", listNewsCategories);
            
            //-- Mr. Worldwide section --
            ArrayList<RecipeDTO> listRecipe = RecipeDAO.getTop6LatestRecipes();
            ArrayList<DisplayRecipeDTO> displayList = new ArrayList<>();
            
            for (RecipeDTO r : listRecipe) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                displayList.add(d);
            }

            session.setAttribute("displayRecipeList", displayList);

            //-- Suggestion section  --
            ArrayList<RecipeDTO> suggestionRecipeList;
            ArrayList<DisplayRecipeDTO> displaySuggestionList = new ArrayList<>();

            String selectedSuggestion = (String) session.getAttribute("selectedSuggestion");
            if (selectedSuggestion == null) {
                suggestionRecipeList = SuggestionDAO.getDefaultSuggestionRecipe();
                selectedSuggestion = SuggestionDAO.getDefaultSuggestionTitle();
            } else {
                suggestionRecipeList = SuggestionDAO.getAllRecipesBySuggestion(selectedSuggestion);
            }
            
            for (RecipeDTO r : suggestionRecipeList) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                displaySuggestionList.add(d);
            }

            session.setAttribute("selectedSuggestion", selectedSuggestion);
            session.setAttribute("displaySuggestionList", displaySuggestionList);
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
