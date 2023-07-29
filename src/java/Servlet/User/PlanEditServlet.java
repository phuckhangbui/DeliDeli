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
import DAO.WeekDAO;
import DTO.DisplayRecipeDTO;
import DTO.DateDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import DTO.WeekDTO;
import static Servlet.User.PlanDetailServlet.calculateDistanceInDays;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
        boolean foundMatchingDate = false;
        boolean error = false;

        //Daily
        if (id != null && !id.isEmpty()) {
            PlanDTO plan = PlanDAO.getUserPlanById(Integer.parseInt(id));
            request.setAttribute("plan", plan);

            if (plan.isDaily()) {

                WeekDTO week = WeekDAO.getWeekByPlanID(plan.getId());

                if (week != null) {
                    request.setAttribute("week", week);
                } else {
                    request.setAttribute("week", new WeekDTO()); // Provide a default WeekDTO object with default values
                }

                DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
                request.setAttribute("diet", diet);

                ArrayList<DateDTO> planDate = DateDAO.getAllDateByPlanID(plan.getId());
                ArrayList<DateDTO> displayDate = new ArrayList<>();

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
                            foundMatchingDate = true;
                            displayDate.add(date);
                            break;
                        }
                    }

                    if (!foundMatchingDate && !planDate.isEmpty()) {
                        DateDTO firstDate = planDate.get(0);
                        displayDate.add(firstDate);
                    }
                }

                // Select 1 day
                request.setAttribute("planDate", displayDate);

                // Send all of the date exist within the plan.
                request.setAttribute("allPlanDate", planDate);

                // Meal count based on time.
                for (DateDTO date : displayDate) {
                    int meal_count = MealDAO.countRecipeBasedOnTime(date.getId());
                    if (meal_count > 10) {
                        error = true;
                    }
                }

                request.setAttribute("max_meal_error", error);

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

                //Weekly
            } else {

                DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
                request.setAttribute("diet", diet);
                WeekDTO week = null;

                String selectedDateStr = request.getParameter("selectedDate");
                System.out.println("selectedDateStr - " + selectedDateStr);

                if (selectedDateStr != null && !selectedDateStr.isEmpty()) {
                    java.util.Date utilDate = null;
                    try {
                        // HTML input (if date selected)

                        SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
                        utilDate = sdfInput.parse(selectedDateStr);

                        SimpleDateFormat sdfOutput = new SimpleDateFormat("yyyy-MM-dd");
                        selectedDateStr = sdfOutput.format(utilDate);
                        request.setAttribute("selectedDate", selectedDateStr);

                        week = WeekDAO.getWeekByDate(selectedDateStr, plan.getId());

                    } catch (ParseException e) {
                        e.printStackTrace();
                    }

                } else {
                    // Plan object input (if date not selected)

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    selectedDateStr = sdf.format(plan.getStart_at());
                    request.setAttribute("selectedDate", selectedDateStr);

                    week = WeekDAO.getWeekByDate(selectedDateStr, plan.getId());

                }

                if (week != null) {
                    request.setAttribute("week", week);
                } else {
                    request.setAttribute("week", new WeekDTO());
                }

                ArrayList<DateDTO> planDate = DateDAO.getAllDateByPlanID(plan.getId());
                ArrayList<DateDTO> displayDate = DateDAO.getAllDateByPlanIDAndWeekID(plan.getId(), week.getId());

                // Get 7 days in a week.
                request.setAttribute("planDate", displayDate);

                // Get all days in all weeks within the plan.
                request.setAttribute("allPlanDate", planDate);

                // Set the error for maxing morning, afternnoon, night (10).
                request.setAttribute("max_meal_error", error);

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
        }

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
