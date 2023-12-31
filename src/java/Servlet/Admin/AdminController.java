/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
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
public class AdminController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String url = "errorpage.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");

            String action = request.getParameter("action");
            if (action == null || action.equals("")) {
                url = "error.jsp";
            } else {
                switch (action.trim()) {
                    case "adminDashboard":
                        url = "AdminDashboardServlet";
                        break;
                    case "manageAccount":
                        url = "ManageAccountServlet";
                        break;
                    case "deactivateAcc":
                        url = "DeactivateAccountServlet";
                        break;
                    case "activateAcc":
                        url = "ActivateAccountServlet";
                        break;
                    case "deleteAcc":
                        url = "DeleteAccountServlet";
                        break;
                    case "manageRecipe":
                        url = "ManageRecipeServlet";
                        break;
                    case "confirmRecipe":
                        url = "ConfirmRecipeServlet";
                        break;
                    case "rejectRecipe":
                        url = "RejectRecipeServlet";
                        break;
                    case "searchAccount":
                        url = "SearchAccountServlet";
                        break;
                    case "showUserDetail":
                        url = "ShowUserDetailServlet";
                        break;
                    case "showRecipeDetail":
                        url = "ShowRecipeDetailServlet";
                        break;
                    case "manageNews":
                        url = "ManageNewsServlet";
                        break;
                    case "showNewsDetail":
                        url = "ShowNewsDetailServlet";
                        break;
                    case "createNews":
                        url = "CreateNewsServlet";
                        break;
                    case "loadNewsForUpdate":
                        url = "LoadNewsForUpdateServlet";
                        break;
                    case "updateNews":
                        url = "UpdateNewsServlet";
                        break;
                    case "deleteNews":
                        url = "DeleteNewsServlet";
                        break;
                    case "addPlan":
                        url = "AddPlanServlet";
                        break;
                    case "suggestionRecipe":
                        url = "SuggestionRecipeServlet";
                        break;
                    case "addSuggestion":
                        url = "AddSuggestionSerlvet";
                        break;
                    case "createSuggestion":
                        url = "CreateSuggestionSerlvet";
                        break;
                    case "filterSuggestion":
                        url = "FilterSuggestionServlet";
                        break;
                    case "removeSuggestion":
                        url = "RemoveSuggestionServlet";
                        break;
                    case "manageSuggestion":
                        url = "ManageSuggestionServlet";
                        break;
                    case "updateSuggestion":
                        url = "UpdateSuggestionServlet";
                        break;
                    case "deleteSuggestion":
                        url = "DeleteSuggestionServlet";
                        break;
                    case "loadSuggestionForUpdate":
                        url = "LoadSuggestionForUpdateServlet";
                        break;
                    case "loadSuggestionForCreate":
                        url = "LoadSuggestionForCreateServlet";
                        break;
                    case "createBroadcast":
                        url = "CreateBroadcastServlet";
                        break;
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
