/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.Admin;

import DAO.RecipeDAO;
import DTO.RecipeDTO;
import DAO.SuggestionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class RemoveSuggestionServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            String recipeId = request.getParameter("id");
            String tag = request.getParameter("tag");
            String update = request.getParameter("update");
            String selectedSuggestion = request.getParameter("suggestion");
            
            if (tag == null) {
                RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(Integer.parseInt(recipeId));
                
                ArrayList<RecipeDTO> customSuggestionList = (ArrayList<RecipeDTO>) session.getAttribute("customSuggestionList");
                
                Iterator<RecipeDTO> iterator = customSuggestionList.iterator();
                while (iterator.hasNext()) {
                    RecipeDTO existingRecipe = iterator.next();
                    if (existingRecipe.getId() == recipe.getId()) {
                        iterator.remove();
                        break;
                    }
                }
                
                session.setAttribute("customSuggestionList", customSuggestionList);
                if (update == null) {
                    request.getRequestDispatcher("createSuggestion.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("updateSuggestion.jsp?suggestion=" + selectedSuggestion + "&update=" + update).forward(request, response);
//                    response.sendRedirect("updateSuggestion.jsp?suggestion=" + selectedSuggestion);
                }
            } else {
                //ArrayList<RecipeDTO> suggestionRecipeList = (ArrayList<RecipeDTO>) request.getAttribute("suggestionRecipeList");
                int suggestionId = SuggestionDAO.getSuggestionIdFromSuggestionRecipe(selectedSuggestion);
                
                int result = SuggestionDAO.deleteSuggestionRecipeByRecipeId(suggestionId, new Integer(recipeId));
                
                if (result > 0) {
                    ArrayList<RecipeDTO> suggestionRecipeList = SuggestionDAO.getAllRecipesBySuggestion(selectedSuggestion);
                    
                    if (suggestionRecipeList.isEmpty()) {
                        SuggestionDAO.deleteSuggestion(selectedSuggestion);
                    }
                    request.setAttribute("selectedSuggestion", selectedSuggestion);
                    request.setAttribute("suggestionRecipeList", suggestionRecipeList);
                    request.getRequestDispatcher("ManageSuggestionServlet").forward(request, response);
                }
            }

//            out.println(recipe);
//            for (RecipeDTO recipeDTO : customSuggestionList) {
//                out.println(recipeDTO.getId());
//            }
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
