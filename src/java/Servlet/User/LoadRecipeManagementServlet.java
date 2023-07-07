/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.RecipeDAO;
import DTO.DisplayRecipeDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
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
 * @author khang
 */
public class LoadRecipeManagementServlet extends HttpServlet {

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
            int userId = Integer.parseInt(request.getParameter("userId"));

            String page = request.getParameter("page");
            ArrayList<RecipeDTO> recipeList = new ArrayList<>();
            ArrayList<DisplayRecipeDTO> displayList = new ArrayList<>();

            String url = "";
            switch (page.trim()) {
                case "private":
                    url = "privateRecipeManagement.jsp";
                    recipeList = RecipeDAO.getRecipeByUserIdAndType(userId, 1);
                    break;
                case "pending":
                    url = "pendingRecipeManagement.jsp";
                    recipeList = RecipeDAO.getRecipeByUserIdAndType(userId, 2);
                    break;
                case "public":
                    url = "publicRecipeManagement.jsp";
                    recipeList = RecipeDAO.getRecipeByUserIdAndType(userId, 3);
                    break;
                case "rejected":
                    url = "rejectedRecipeManagement.jsp";
                    recipeList = RecipeDAO.getRecipeByUserIdAndType(userId, 4);
                    break;
            }
            for (RecipeDTO r : recipeList) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                displayList.add(d);
            }

            String requestURI = request.getRequestURI();

            // Remove the protocol, domain, and port from the URL

            HttpSession session = request.getSession();
            String managementUrl = "UserController?action=loadRecipeManagement&userId="+userId + "&page=" + page.trim();
            session.setAttribute("managementUrl", managementUrl);
            request.setAttribute("displayRecipeList", displayList);

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
