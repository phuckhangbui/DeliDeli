/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import PasswordEncode.EncodePass;
import User.UserDAO;
import User.UserDTO;
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
public class LoginServlet extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String HOME_PAGE = "home.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String MOD_PAGE = "mod.jsp";
    private static final String RECIPE_PAGE = "MainController?action=getRecipeDetailById&id=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            List<String> errorList = new ArrayList<>();

            String recipeID = request.getParameter("recipeID"); //Redirect back to page.
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPass");

            EncodePass encode = new EncodePass();
            password = encode.toHexString(encode.getSHA(password));
            System.out.println("[DAO - InsertAccount]: Hash generated: " + password);

            UserDTO user = UserDAO.getAccount(email, password);
            HttpSession session = request.getSession();

            if (user != null) {
                if (!UserDAO.checkUserStatus(email, password)) {
                    //Block
                    errorList.add("Your account is blocked");
                    request.setAttribute("errorList", errorList);
                    request.getRequestDispatcher(LOGIN_PAGE).forward(request, response);
                } else if (user.getRole() == 1 && recipeID != null) {
                    session.setAttribute("user", user);
                    request.getRequestDispatcher(RECIPE_PAGE + recipeID + "&activeScroll=true").forward(request, response);
                } else if (user.getRole() == 1) {
                    session.setAttribute("user", user);
                    request.getRequestDispatcher(HOME_PAGE).forward(request, response);
                } else if (user.getRole() == 2) {
                    session.setAttribute("user", user);
                    request.getRequestDispatcher(ADMIN_PAGE).forward(request, response);
                } else {
                    session.setAttribute("user", user);
                    request.getRequestDispatcher(MOD_PAGE).forward(request, response);
                }
            } else {
                //Incorrect email or pass
                errorList.add("Incorrect email or password!");
                request.setAttribute("errorList", errorList);
                request.getRequestDispatcher(LOGIN_PAGE).forward(request, response);
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
