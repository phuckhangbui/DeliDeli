/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.UserDAO;
import Utils.ValidateEmail;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    private final static String AVATAR = "profile-pic.svg";
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

            List<String> errorList = new ArrayList<>();

            UserDAO userDAO = new UserDAO();

            Pattern regex = Pattern.compile(EMAIL_PATTERN);
            if (email != null) {
                ValidateEmail validate = new ValidateEmail();
                boolean exists = validate.isAddressValid(email);
                if (exists == false) {
                    errorList.add("The email address is not exist.");
                    request.setAttribute("errorList", errorList);
                    request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                    return;
                }
            }
            if (!regex.matcher(email).matches()) {
                //Incorrect email pattern
                errorList.add("The email address is invalid");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                return;
            }
            if (!password.matches(PASS_PATTERN)) {
                //Incorrect pass pattern
                errorList.add("Password must have a length of 8-16 "
                        + "characters and contain at least one special symbol and one uppercase letter.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                return;
            }
            if (!password.equals(confirmPassword)) {
                //Incorrect confirm pass
                errorList.add("Confirm password do not match.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                return;
            }
            if (UserDAO.checkEmailExist(email)) {
                //Check email exist
                errorList.add("Email already exists.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                return;
            }
            if (userName.contains(" ") || userName.matches(".*[^a-zA-Z0-9].*")) {
                errorList.add("Invalid username. Username must not contain whitespace or special symbols.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                return;
            }
            if (UserDAO.checkUsernameExist(userName)) {
                //Check user name exist
                errorList.add("Username already exists.");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(REGISTRATION_PAGE).forward(request, response);
                return;
            }
            //Insert account
            java.util.Date date = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());
            int userId = UserDAO.insertAccount(userName, email, password, AVATAR, sqlDate, STATUS, ROLE, SETTING, DEFAULT_TOKEN);
            String uploadPath = "C:/project-swp/pictures/user/" + userId;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String defaultAvatarFilePath = "C:/project-swp/pictures/user/0/profile-pic.svg";
            File defaultAvatarFile = new File(defaultAvatarFilePath);

            String userAvatarFileName = AVATAR; 
            File userAvatarFile = new File(uploadPath, userAvatarFileName);

            try ( InputStream inputStream = new FileInputStream(defaultAvatarFile);  OutputStream outputStream = new FileOutputStream(userAvatarFile)) {

                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }

            } catch (IOException e) {
                e.printStackTrace();
                
            }

            userDAO.updateStatusFalse(userName); //Patched this shit up.

            UserDAO.insertUserDetailDefault();
            request.setAttribute("USER_TYPE", "RegisterUser");
            request.setAttribute("MSG_SUCCESS", "You have successfully registered an account!");
            request.getRequestDispatcher(CONFIRM_EMAIL).forward(request, response);

        } catch (Exception ex) {
            Logger.getLogger(RegistrationServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
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
