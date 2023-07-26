/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

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
public class UserController extends HttpServlet {

    private String url = "errorpage.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");

            String action = request.getParameter("action");
            
            System.out.println("Current user action - " + action);
                        if (action == null || action.equals("")) {
                url = "error.jsp";
            } else {
                switch (action.trim()) {
                    case "userPublicDetail":
                        url = "UserPublicDetailServlet";
                        break;
                    case "userEmailSetting":
                        url = "UserEmailSettingServlet";
                        break;
                    case "userPasswordSetting":
                        url = "UserPasswordSettingServlet";
                        break;
                    case "saveUserPublicDetail":
                        url = "SaveUserPublicDetailServlet";
                        break;
                    case "saveUserRecipe":
                        url = "SaveUserRecipeServlet";
                        break;
                    case "changeUserEmail":
                        url = "ChangeUserEmailServlet";
                        break;
                    case "changeUserPassword":
                        url = "ChangeUserPasswordServlet";
                        break;
                    case "getFeedback":
                        url = "FeedbackServlet";
                        break;
                    case "editFeedback":
                        url = "EditFeedbackServlet";
                        break;
                    case "deleteFeedBack":
                        url = "DeleteFeedbackServlet";
                        break;
                    case "addRecipe":
                        url = "AddRecipeServlet";
                        break;
                    case "editRecipe":
                        url = "EditRecipeServlet";
                        break;
                    case "deleteRecipe":
                        url = "DeleteRecipeServlet";
                        break;
                    case "addPlan":
                        url = "AddPlanServlet";
                        break;
                    case "getPlanDetailById":
                        url = "PlanDetailServlet";
                        break;
                    case "editPlan":
                        url = "PlanEditServlet";
                        break;
                    case "disablePlanConfirmed":
                        url = "DisablePlanServlet";
                        break;
                    case "removeAllRecipeConfirmed":
                        url = "RemoveAllRecipeServlet";
                        break;
                    case "deletePlanConfirmed":
                        url = "DeletePlanServlet";
                        break;
                    case "loadEditRecipe":
                        url = "LoadEditRecipeServlet";
                        break;
                    case "loadRecipeManagement":
                        url = "LoadRecipeManagementServlet";
                        break;
                    case "loadUserReview":
                        url = "LoadUserReviewServlet";
                        break;
                    case "categoryLoadToPlan":
                        url = "CategoryLoadServlet";
                        break;
                    case "planManagement":
                        url = "PlanManagementServlet";
                        break;
                    case "recipePlanSearch":
                        url = "PlanSearchServlet";
                        break;
                    case "addPlanRecipe":
                        url = "PlanAddRecipeServlet";
                        break;
                    case "planNotification":
                        url = "PlanRecipeNotificationServlet";
                        break;
                    case "removePlanRecipe":
                        url = "PlanRemoveRecipeServlet";
                        break;
                    case "editPlanSave":
                        url = "PlanInformationEditServlet";
                        break;
                    case "loadSavedRecipe":
                        url = "LoadSavedRecipeServlet";
                        break;
                    case "deleteSavedRecipe":
                        url = "DeleteSavedRecipeServlet";
                        break;
                    case "addDailyPlan":
                        url = "AddDailyPlanServlet";
                        break;
                    case "useDailyPlanTemplate":
                        url = "UseDailyPlanTemplateServlet";
                        break;
                    case "addWeeklyPlan":
                        url = "AddWeeklyPlanServlet";
                        break;
                    case "useWeeklyPlanTemplate":
                        url = "UseWeeklyPlanTemplateServlet";
                        break;
                    case "editStartTimeRecipe":
                        url = "EditStartTimeRecipeServlet";
                        break;
                    case "addPlanMultiplesMeal":
                        url = "AddPlanMultiplesMealServlet";
                        break;
                    case "loadEditRecipeDetail":
                        url = "LoadEditRecipeDetailServlet";
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
