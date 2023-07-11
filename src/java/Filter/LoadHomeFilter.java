/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import DAO.NewsDAO;
import DAO.RecipeDAO;
import DAO.SuggestionDAO;
import DTO.DisplayRecipeDTO;
import DTO.NewsDTO;
import DTO.RecipeDTO;
import DTO.UserDTO;
import Utils.NavigationBarUtils;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.time.LocalTime;
import java.util.ArrayList;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebFilter(filterName = "LoadHomeFilter", urlPatterns = {"/home.jsp"}, dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.INCLUDE})
public class LoadHomeFilter implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public LoadHomeFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoadHomeFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoadHomeFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("LoadHomeFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();
        String includedJspPath = "/home.jsp";

        // Execute filter logic specific to the included JSP
        UserDTO user = (UserDTO) session.getAttribute("user");
        boolean login = false;

        //-- News section --
        ArrayList<String> listNewsCategories = new ArrayList<>();
        NewsDTO latestNews = NewsDAO.getLatestNews();
        ArrayList<NewsDTO> listNews = NewsDAO.getNext2News(latestNews.getId());

        for (NewsDTO news : listNews) {
            String newsCategory = NewsDAO.getNewsCategoryByNewsId(news.getId());
            listNewsCategories.add(newsCategory);
        }

        request.setAttribute("latestNews", latestNews);
        request.setAttribute("listNews", listNews);
        request.setAttribute("listNewsCategories", listNewsCategories);

        //-- Mr. Worldwide section --
        ArrayList<RecipeDTO> listRecipe = RecipeDAO.getTop6LatestRecipes();
        ArrayList<DisplayRecipeDTO> displayList = new ArrayList<>();

        for (RecipeDTO r : listRecipe) {
            String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
            String category = RecipeDAO.getCategoryByRecipeId(r.getId());
            double rating = RecipeDAO.getRatingByRecipeId(r.getId());
            UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

            DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
            displayList.add(d);
        }

        request.setAttribute("displayRecipeList", displayList);

        //-- What's to eat today section --
        LocalTime currentTime = LocalTime.now();
        String time = "";

        ArrayList<RecipeDTO> recommendList = null;

        //Time define
        LocalTime MorningStartTime = LocalTime.of(6, 0);
        LocalTime AfternoonStartTime = LocalTime.of(12, 0);
        LocalTime EveningStartTime = LocalTime.of(17, 0);
        LocalTime NightStartTime = LocalTime.of(20, 0);

        //BREAKFAST
        if (currentTime.isAfter(MorningStartTime) && currentTime.isBefore(AfternoonStartTime)) {
            recommendList = NavigationBarUtils.searchRecipes("Breakfast", "Category");
            ArrayList<DisplayRecipeDTO> timeRecommendDisplay = new ArrayList<>();

            time = "breakfast";

            for (RecipeDTO r : recommendList) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                timeRecommendDisplay.add(d);
            }

            request.setAttribute("timeTitle", time);
            request.setAttribute("timeRecommendDisplay", timeRecommendDisplay);

            //LUNCH
        } else if (currentTime.isAfter(AfternoonStartTime)
                && currentTime.isBefore(EveningStartTime)) {
            recommendList = NavigationBarUtils.searchRecipes("Lunch", "Category");
            ArrayList<DisplayRecipeDTO> timeRecommendDisplay = new ArrayList<>();

            time = "lunch";

            for (RecipeDTO r : recommendList) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                timeRecommendDisplay.add(d);
            }

            request.setAttribute("timeTitle", time);
            request.setAttribute("timeRecommendDisplay", timeRecommendDisplay);

            //DINNER
        } else if (currentTime.isAfter(EveningStartTime)
                && currentTime.isBefore(NightStartTime)) {
            recommendList = NavigationBarUtils.searchRecipes("Dinner", "Category");
            ArrayList<DisplayRecipeDTO> timeRecommendDisplay = new ArrayList<>();

            time = "dinner";

            for (RecipeDTO r : recommendList) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                timeRecommendDisplay.add(d);
            }

            request.setAttribute("timeTitle", time);
            request.setAttribute("timeRecommendDisplay", timeRecommendDisplay);
            
            //MIDNIGHT
        } else if (currentTime.isAfter(NightStartTime)
                || currentTime.isBefore(MorningStartTime)) {
            recommendList = NavigationBarUtils.searchRecipes("Snack", "Category");
            ArrayList<DisplayRecipeDTO> timeRecommendDisplay = new ArrayList<>();

            time = "midnight snack";

            for (RecipeDTO r : recommendList) {
                String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
                String category = RecipeDAO.getCategoryByRecipeId(r.getId());
                double rating = RecipeDAO.getRatingByRecipeId(r.getId());
                UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

                DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
                timeRecommendDisplay.add(d);
            }

            request.setAttribute("timeTitle", time);
            request.setAttribute("timeRecommendDisplay", timeRecommendDisplay);
        }
        
        //-- Suggestion section  --
        ArrayList<RecipeDTO> suggestionRecipeList;
        ArrayList<DisplayRecipeDTO> displaySuggestionList = new ArrayList<>();

        String selectedSuggestion = (String) session.getAttribute("selectedSuggestion");
        if (selectedSuggestion == null) {
            suggestionRecipeList = SuggestionDAO.getDefaultSuggestionRecipe();
            selectedSuggestion = SuggestionDAO.getDefaultSuggestionTitle();
        } else {
            suggestionRecipeList = SuggestionDAO.getAllRecipesBySuggestion(selectedSuggestion);
        }

        for (RecipeDTO r : suggestionRecipeList) {
            String thumbnailPath = RecipeDAO.getThumbnailByRecipeId(r.getId()).getThumbnailPath();
            String category = RecipeDAO.getCategoryByRecipeId(r.getId());
            double rating = RecipeDAO.getRatingByRecipeId(r.getId());
            UserDTO owner = RecipeDAO.getRecipeOwnerByRecipeId(r.getId());

            DisplayRecipeDTO d = new DisplayRecipeDTO(r.getId(), r.getTitle(), thumbnailPath, category, rating, owner);
            displaySuggestionList.add(d);
        }

        request.setAttribute("selectedSuggestion", selectedSuggestion);
        request.setAttribute("displaySuggestionList", displaySuggestionList);

        Throwable problem = null;
        chain.doFilter(request, response);

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("LoadHomeFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("LoadHomeFilter()");
        }
        StringBuffer sb = new StringBuffer("LoadHomeFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
