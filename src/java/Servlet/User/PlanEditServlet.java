/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.DateDAO;
import DAO.DietDAO;
import DAO.MealDAO;
import DTO.DietDTO;
import DAO.PlanDAO;
import DTO.PlanDTO;
import DAO.RecipeDAO;
import DTO.DisplayRecipeDTO;
import DTO.DateDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import static Servlet.User.PlanDetailServlet.calculateDistanceInDays;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Daiisuke
 */
@WebServlet(name = "PlanEditServlet", urlPatterns = {"/PlanEditServlet"})
public class PlanEditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        ArrayList<DisplayRecipeDTO> displayList = (ArrayList<DisplayRecipeDTO>) request.getAttribute("searchRecipesList");
        boolean isSearch = Boolean.parseBoolean(request.getParameter("isSearch"));

        //Daily
        if (id != null && !id.isEmpty()) {
            PlanDTO plan = PlanDAO.getUserPlanById(Integer.parseInt(id));
            request.setAttribute("plan", plan);

            DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
            request.setAttribute("diet", diet);

            ArrayList<DateDTO> planDate = DateDAO.getAllDateByPlanID(plan.getId());
            ArrayList<DateDTO> displayDate = new ArrayList<>();
            String error = "";

            LocalDate currentDate = LocalDate.now();
            java.sql.Date startDateSQL = plan.getStart_at();
            LocalDate startLocalDate = startDateSQL.toLocalDate();
            int distanceInDays = (int) calculateDistanceInDays(startLocalDate, currentDate);

            String distanceInDaysParam = request.getParameter("distanceInDays");
            if (distanceInDaysParam != null) {
                distanceInDays = Integer.parseInt(distanceInDaysParam);
                request.setAttribute("distanceInDays", distanceInDays);

                for (DateDTO date : planDate) {
                    LocalDate dateList = date.getDate().toLocalDate();
                    if (dateList.equals(startLocalDate.plusDays(distanceInDays))) {
                        displayDate.add(date);
                        break; // Break after finding the date with the desired distance
                    }
                }
            } else {
                for (DateDTO date : planDate) {
                    LocalDate dateList = date.getDate().toLocalDate();
                    if (dateList.equals(currentDate)) {
                        displayDate.add(date);
                        break; // Break after finding the date with the desired distance
                    }
                }
            }

            request.setAttribute("planDate", displayDate);
            request.setAttribute("allPlanDate", planDate);

            // Meal count based on time.
            for (DateDTO date : displayDate) {
                int meal_count = MealDAO.countRecipeBasedOnTime(date.getId());
                if (meal_count == 10) {
                    error = "Please remove some recipes before adding. (10 max)";
                    request.setAttribute("max_meal_error", error);
                }
            }

            if (isSearch) {
                request.setAttribute("SEARCH_LIST", displayList);
                request.setAttribute("SEARCH_PLAN_REAL", true);
                RequestDispatcher rq = request.getRequestDispatcher("addRecipeToPlan.jsp");
                rq.forward(request, response);
                return;
            } else {
                ArrayList<RecipeDTO> list = RecipeDAO.getRecipeByDietTitle(diet.getTitle());
                displayList = new ArrayList<>();
                for (RecipeDTO r : list) {
                    String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                    String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                    double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                    UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                    DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                    displayList.add(d);
                }
                request.setAttribute("SEARCH_LIST", displayList);
                request.setAttribute("SEARCH_PLAN_REAL", false);
                RequestDispatcher rq = request.getRequestDispatcher("addRecipeToPlan.jsp");
                rq.forward(request, response);
                return;
            }

        }

        //Weekly
        response.sendRedirect("error.jsp");

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
