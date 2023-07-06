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
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class AddSuggestionSerlvet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //String[] customSuggestionListValues = request.getParameterValues("customSuggestionList");
            HttpSession session = request.getSession();
            String id = request.getParameter("id");
            String update = request.getParameter("update");
            String suggestion = request.getParameter("suggestion");
            String chosenSuggestion = request.getParameter("chosenSuggestion");
            String link = "";

            if (update == null) {
                link = "createSuggestion.jsp";
            } else {
                link = "updateSuggestion.jsp";
            }

            RecipeDTO recipe = RecipeDAO.getRecipeByRecipeId(new Integer(id));
            ArrayList<RecipeDTO> customSuggestionList = (ArrayList<RecipeDTO>) session.getAttribute("customSuggestionList");
            ArrayList<RecipeDTO> listRecipe = RecipeDAO.getAllRecipes();
            if (customSuggestionList == null) {
                customSuggestionList = new ArrayList<>();
            } else {
                boolean isDuplicate = false;
                for (RecipeDTO existingRecipe : customSuggestionList) {
                    if (existingRecipe.getId() == recipe.getId()) {
                        isDuplicate = true;
                        break;
                    }
                }

                if (isDuplicate) {
                    request.setAttribute("error", "Recipe already added");
                    request.setAttribute("suggestion", suggestion);
                    request.setAttribute("chosenSuggestion", chosenSuggestion);
                    request.setAttribute("update", update);
                    request.setAttribute("listRecipe", listRecipe);
                    session.setAttribute("customSuggestionList", customSuggestionList);
                    request.getRequestDispatcher(link).forward(request, response);
                    return;
                }
            }

            customSuggestionList.add(recipe);

            session.setAttribute("customSuggestionList", customSuggestionList);

            request.setAttribute("suggestion", suggestion);
            request.setAttribute("chosenSuggestion", chosenSuggestion);
            request.setAttribute("update", update);
            request.setAttribute("listRecipe", listRecipe);
            request.getRequestDispatcher(link).forward(request, response);
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
