package Servlet.User;

import DAO.DailyPlanTemplateDAO;
import DAO.DateDAO;
import DAO.DietDAO;
import DAO.MealDAO;
import DAO.PlanDAO;
import DAO.RecipeDAO;
import DAO.WeekDAO;
import DTO.DateDTO;
import DTO.DietDTO;
import DTO.DisplayRecipeDTO;
import DTO.PlanDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import DTO.WeekDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Walking Bag
 */
public class LoadEditWeeklyTemplateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String id = request.getParameter("id");
            ArrayList<DisplayRecipeDTO> displayList = (ArrayList<DisplayRecipeDTO>) request.getAttribute("searchRecipesList");
            boolean isSearch = Boolean.parseBoolean(request.getParameter("isSearch"));
            boolean foundMatchingDate = false;
            boolean error = false;

            //Weekly
            if (id != null && !id.isEmpty()) {
                PlanDTO plan = PlanDAO.getUserPlanById(Integer.parseInt(id));
                request.setAttribute("plan", plan);

                DietDTO diet = DietDAO.getTypeById(plan.getDiet_id());
                request.setAttribute("diet", diet);

                WeekDTO week = WeekDAO.getWeekTemplateByPlanID(plan.getId());
                request.setAttribute("week", week);

                int templateId = DailyPlanTemplateDAO.getWeeklyTemplateIdByPlanId(plan.getId());
                ArrayList<DateDTO> templateDate = DateDAO.getWeeklyTemplate(plan.getId());

                request.setAttribute("templateDate", templateDate);
                request.setAttribute("templateId", templateId);

                request.setAttribute("max_meal_error", error);

                if (isSearch) {
                    request.setAttribute("SEARCH_LIST", displayList);
                    request.setAttribute("SEARCH_PLAN_REAL", true);
                    RequestDispatcher rq = request.getRequestDispatcher("editWeeklyTemplate.jsp");
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
                    RequestDispatcher rq = request.getRequestDispatcher("editWeeklyTemplate.jsp");
                    rq.forward(request, response);
                    return;
                }

            }
            response.sendRedirect("error.jsp");
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
