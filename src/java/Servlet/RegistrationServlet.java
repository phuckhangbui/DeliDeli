/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import User.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Admin
 */
public class RegistrationServlet extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String REGISTRATION_PAGE = "registration.jsp";
    private final static String PASS_PATTERN = "^(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,16}$";
    private final static String EMAIL_PATTERN = "\\b[\\w.%-]+@[-.\\w]+\\.[A-Za-z]{2,4}\\b";
    private final static int STATUS = 1;
    private final static int ROLE = 1;
    private final static int SETTING = 1;
    private final static String DEFAULT_TOKEN = "";
    private static final String CONFIRM_EMAIL = "EmailConfirmServlet";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("txtEmail"); //Get user email
            String userName = request.getParameter("txtUserName");
            String password = request.getParameter("txtPass");
            String confirmPassword = request.getParameter("txtConfirmPass");
            
            UserDAO userDAO = new UserDAO();
            
            Pattern regex = Pattern.compile(EMAIL_PATTERN);
            if (!password.matches(PASS_PATTERN)) {
                //Incorrect pass pattern
                request.setAttribute("MSG_INCORRECT_PASSWORD", "Invalid password. Password must have a length of 8-16 "
                        + "characters and contain at least one special symbol and one uppercase letter.");
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
            } else if (!password.equals(confirmPassword)) {
                //Incorrect confirm pass
                request.setAttribute("MSG_INCORRECT_CONFIRM_PASSWORD", "Confirm password do not match.");
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
            } else if (!regex.matcher(email).matches()) {
                //Incorrect email pattern
                request.setAttribute("MSG_INCORRECT_EMAIL", "Invalid email.");
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
            } else if (UserDAO.checkEmailExist(email)) {
                //Check email exist
                request.setAttribute("MSG_EMAIL_EXIST", "Email already exists.");
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
            } else if (userName.contains(" ") || userName.matches(".*[^a-zA-Z0-9].*")) {
                request.setAttribute("MSG_INCORRECT_USERNAME", "Invalid username. Username must not contain whitespace or special symbols.");
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
            } else if (UserDAO.checkUsernameExist(userName)) {
                //Check user name exist
                request.setAttribute("MSG_USERNAME_EXIST", "Username already exists.");
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
            } else {
                //Insert account
                java.util.Date date = new java.util.Date();
                java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                boolean check = UserDAO.insertAccount(userName, email, password, sqlDate, STATUS, ROLE, SETTING,DEFAULT_TOKEN);
                userDAO.updateStatusFalse(userName); //Patched this shit up.
                if (check) {
                    request.setAttribute("USER_TYPE", "RegisterUser");
                    request.setAttribute("MSG_SUCCESS", "You have successfully registered an account!");
                    request.getRequestDispatcher(CONFIRM_EMAIL).forward(request, response);
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
