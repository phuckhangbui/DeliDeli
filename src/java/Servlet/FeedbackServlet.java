/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Recipe.RecipeDTO;
import Review.ReviewDAO;
import Review.ReviewDTO;
import User.UserDTO;
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
public class FeedbackServlet extends HttpServlet {

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
            UserDTO user = (UserDTO) session.getAttribute("user");
            int rating = Integer.parseInt(request.getParameter("rating"));
            String review = request.getParameter("txtReview");
            if (review == null) {
                review = "";
            }
            int recipeId = Integer.parseInt(request.getParameter("recipeId"));
            ArrayList<ReviewDTO> reviewList = ReviewDAO.getReviewByRecipeId(recipeId);
            boolean alreadyReview = false;
            if (user != null && reviewList.size() > 0) {
                for (ReviewDTO r : reviewList) {

                    //User already review this, cannot review more
                    if (r.getUser_id() == user.getId()) {
                        alreadyReview = true;
                    }
                }

                if (!alreadyReview) {
                    //Do the review
                    int result = ReviewDAO.makeFeedback(user.getId(), recipeId, rating, review);
                    response.sendRedirect("MainController?action=getRecipeDetailById&id=" + recipeId + "&activeScroll=true");

                } else {
                    // forward user to edit review?
                    out.print("Already review, could only edit the review");
                }
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
