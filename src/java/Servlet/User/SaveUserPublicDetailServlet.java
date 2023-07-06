/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.UserDAO;
import DAO.UserDetailDAO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB - exceed 2MB => disk, else memory => caching.
        maxFileSize = 1024 * 1024 * 10, // 10MB => maximum upload to server.
        maxRequestSize = 1024 * 1024 * 50) // 50MB => maximum request from server.

public class SaveUserPublicDetailServlet extends HttpServlet {

    private static final String USER_PUBLIC_DETAIL_PAGE = "userPublicDetail.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String userId = request.getParameter("userId");
            String firstName = request.getParameter("txtFirstName");
            String lastName = request.getParameter("txtLastName");
            String specialty = request.getParameter("txtSpecialty");
            String bio = request.getParameter("txtBio");
            String birthdate = request.getParameter("txtBirthDate");
            
            Part filePart = request.getPart("file");

            UserDetailDAO.updateUserPublicDetail(new Integer(userId), firstName, lastName, specialty, bio, birthdate);
            
            if (filePart.getSubmittedFileName().equals("")) {
                UserDTO user = UserDAO.getUserByUserId(new Integer(userId));
                HttpSession session = request.getSession();

                session.setAttribute("user", user);
                request.setAttribute("userId", userId);

                request.getRequestDispatcher("UserPublicDetailServlet").forward(request, response);
            } else {
                request.setAttribute("userId", userId);
                request.getRequestDispatcher("UploadAvatarImageServlet").forward(request, response);
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
