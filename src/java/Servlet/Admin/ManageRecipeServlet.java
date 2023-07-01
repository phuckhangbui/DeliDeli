/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.Admin;

import DAO.AdminDAO;
import DAO.RecipeDAO;
import DTO.RecipeDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class ManageRecipeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String index = request.getParameter("index");
            String status = request.getParameter("status");

            ArrayList<RecipeDTO> listRecipe;

            if (index == null) {
                index = "1";
            }

            int total = 0;
            int endPage = 0;

            if (status != null && !status.equals("all")) {
                if (!status.equals("")) {
                    listRecipe = AdminDAO.pagingRecipe(new Integer(index), status);
                    total = AdminDAO.getTotalRecipesBasedOnStatus(status);
                    endPage = total / 10;
                    if (total % 10 != 0) {
                        endPage++;
                    }
                } else {
                    listRecipe = new ArrayList<>();
                    total = 0;
                    endPage = 0;
                }
            } else {
                listRecipe = AdminDAO.pagingRecipe(new Integer(index), "");
                total = AdminDAO.getTotalRecipesBasedOnStatus("");
                endPage = total / 10;
                if (total % 10 != 0) {
                    endPage++;
                }
            }

            ArrayList<Integer> listRecipeStatus = AdminDAO.getAllRecipeStatus();

            request.setAttribute("listRecipe", listRecipe);
            request.setAttribute("listRecipeStatus", listRecipeStatus);

            request.setAttribute("tag", index);
            request.setAttribute("endPage", endPage);
            request.setAttribute("status", status);

            request.getRequestDispatcher("manageRecipe.jsp").forward(request, response);
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
