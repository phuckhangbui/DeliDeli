/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.Admin;

import DAO.AdminDAO;
import DTO.UserDTO;
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
public class SearchAccountServlet extends HttpServlet {

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
            String keyword = request.getParameter("txtSearch");
            String currentRole = request.getParameter("role");

            ArrayList<UserDTO> listAccSearched = AdminDAO.searchAccount(keyword);
            int totalResults = listAccSearched.size();
            int resultsPerPage = 10;
            int totalPage = (int) Math.ceil((double) totalResults / resultsPerPage);
            int currentPage = 1;

            ArrayList<UserDTO> paginatedList = new ArrayList<>();
            if (totalResults > 0) {
                paginatedList = new ArrayList<>(listAccSearched.subList(0, Math.min(resultsPerPage, totalResults)));
            }
            
            System.out.println(paginatedList);

            request.setAttribute("listAccSearched", paginatedList);
            request.setAttribute("endPage", totalPage);
            request.setAttribute("tag", String.valueOf(currentPage));
            request.setAttribute("role", currentRole);
            request.getRequestDispatcher("manageAccount.jsp").forward(request, response);

//            String keyword = request.getParameter("txtSearch");
//            String currentRole = request.getParameter("currentRole");
//            String tag = request.getParameter("tag");
//
//            ArrayList<UserDTO> listAccSearched = AdminDAO.searchAccount(keyword);
//            int totalResults = listAccSearched.size();
//            int resultsPerPage = 5;
//            int endPage = totalResults / resultsPerPage;
//            if (totalResults % resultsPerPage != 0) {
//                endPage++;
//            }
//            request.setAttribute("listAccSearched", listAccSearched);
//            request.setAttribute("endPage", endPage);
//            //request.setAttribute("tag", "");
//            request.setAttribute("tag", tag);
//            request.setAttribute("role", currentRole);
//            request.getRequestDispatcher("manageAccount.jsp").forward(request, response);
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
