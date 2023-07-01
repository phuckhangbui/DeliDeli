/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.UserDAO;
import DAO.UserDetailDAO;
import Utils.ValidateEmail;
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
public class ChangeUserEmailServlet extends HttpServlet {

    private final static String EMAIL_PATTERN = "\\b[\\w.%-]+@[-.\\w]+\\.[A-Za-z]{2,4}\\b";
    private static final String USER_EMAIL_SETTING_PAGE = "userEmailSetting.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            List<String> errorList = new ArrayList<>();
            HttpSession session = request.getSession();
            
            String userId = request.getParameter("userId");
            String email = request.getParameter("txtEmail");
            
            request.setAttribute("userId", userId);
            
            if (email != null) {
                ValidateEmail validate = new ValidateEmail();
                boolean exists = validate.isAddressValid(email);
                if (exists == false) {
                    errorList.add("The email address is not exist.");
                    request.setAttribute("errorList", errorList);
                    request.getRequestDispatcher(USER_EMAIL_SETTING_PAGE).forward(request, response);
                    return;
                }
            }
            
            if (!email.matches(EMAIL_PATTERN)) {
                errorList.add("Invalid email format. Please enter a valid email address.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher("UserController?action=userEmailSetting").forward(request, response);
            } else if (UserDAO.checkEmailExist(email)) {
                errorList.add("Email already exists.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher("UserController?action=userEmailSetting").forward(request, response);
            } else {
                int result = UserDetailDAO.updateUserEmail(new Integer(userId), email);
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
