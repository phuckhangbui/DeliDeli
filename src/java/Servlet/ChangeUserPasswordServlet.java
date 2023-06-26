/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import User.UserDAO;
import User.UserDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ChangeUserPasswordServlet extends HttpServlet {

    private final static String PASS_PATTERN = "^(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,16}$";
    private static final String USER_PASSWORD_SETTING_PAGE = "userPasswordSetting.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            List<String> errorList = new ArrayList<>();
            HttpSession session = request.getSession();

            String userId = request.getParameter("userId");
            String oldPassword = request.getParameter("txtOldPassword");
            String newPassword = request.getParameter("txtNewPassword");
            String confirmNewPassword = request.getParameter("txtConfirmNewPassword");
            
            if (!UserDAO.checkOldPassword(new Integer(userId), oldPassword)) {
                errorList.add("Invalid old password.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(USER_PASSWORD_SETTING_PAGE).forward(request, response);
            } else if (!newPassword.matches(PASS_PATTERN)) {
                errorList.add("Invalid new password. Password must have a length of 8-16 "
                        + "characters and contain at least one special symbol and one uppercase letter.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(USER_PASSWORD_SETTING_PAGE).forward(request, response);
            } else if (!newPassword.matches(confirmNewPassword)) {
                errorList.add("Confirm password do not match.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(USER_PASSWORD_SETTING_PAGE).forward(request, response);
            } else {
                int result = UserDetailDAO.updateUserPassword(new Integer(userId), newPassword);
                if (result > 0) {
                    session.removeAttribute("user");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
