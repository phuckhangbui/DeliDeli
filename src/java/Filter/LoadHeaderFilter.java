/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import DAO.DateDAO;
import DAO.NotificationDAO;
import DAO.NotificationTypeDAO;
import DAO.PlanDAO;
import DAO.PlanDateDAO;
import DTO.DateDTO;
import DTO.DisplayNotificationDTO;
import DTO.NotificationDTO;
import DTO.NotificationTypeDTO;
import DTO.PlanDTO;
import DTO.PlanDateDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
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
 * @author khang
 */
@WebFilter(filterName = "LoadHeaderFilter", urlPatterns = {"/header.jsp"}, dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.INCLUDE})
public class LoadHeaderFilter implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public LoadHeaderFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoadHeaderFilter:DoBeforeProcessing");
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
            log("LoadHeaderFilter:DoAfterProcessing");
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
            log("LoadHeaderFilter:doFilter()");
        }

        doBeforeProcessing(request, response);
        //code
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();
        String includedJspPath = "/header.jsp";

        // Execute filter logic specific to the included JSP
        UserDTO user = (UserDTO) session.getAttribute("user");
        boolean login = false;

        if (user != null) {
            ArrayList<NotificationDTO> list = NotificationDAO.getNotificationList(user.getId());
            ArrayList<DisplayNotificationDTO> displayList = new ArrayList<>();

            for (NotificationDTO n : list) {
                NotificationTypeDTO type = NotificationTypeDAO.getNotificationType(n.getNotification_type());
                DisplayNotificationDTO d = new DisplayNotificationDTO(n.getId(), n.getTitle(),
                        n.getDescription(), n.getSend_date(), n.is_read(), n.getUser_id(),
                        n.getRecipe_id(), n.getPlan_id(), n.getLink(), type);
                displayList.add(d);
            }
            int[] count = NotificationDAO.getNotificationCount(user.getId());

            request.setAttribute("count", count);
            request.setAttribute("displayList", displayList);

            // Plan Notification & Auto Activator
            LocalDate currentDate = LocalDate.now();
            Date currentDateNow = Date.valueOf(currentDate);
            PlanDateDTO currentPlanRecipeActive = null;
            boolean isPlanStatus = false;
            boolean isActivatePlan = false;
            // Get activated plan
            PlanDTO activePlan = PlanDAO.getCurrentActivePlan(user.getId());
            // Get plan about to get activated today.
            PlanDTO planToActivate = PlanDAO.getTodayPlan(user.getId(), currentDateNow);

            //Activate plan
            if (planToActivate != null) {
                if (currentDate.isEqual(planToActivate.getStart_at().toLocalDate()) && !isPlanStatus) {
                    isActivatePlan = PlanDAO.updateStatusByPlanID(planToActivate.getId(), true);
                }
            }

            if (activePlan != null) {
//                // Deactivate plan
//                if (activePlan.getEnd_at() != null && currentDate.isAfter(activePlan.getEnd_at().toLocalDate())) {
//                    isPlanStatus = PlanDAO.updateStatusByPlanID(activePlan.getId(), false);
//                }
//
//                if (!currentDate.isEqual(activePlan.getStart_at().toLocalDate())) {
//                    isPlanStatus = PlanDAO.updateStatusByPlanID(activePlan.getId(), false);
//                }

                // Plan Notification
                currentPlanRecipeActive = PlanDateDAO.getActiveRecipePlan(currentDateNow, activePlan.getId());
                LocalTime currentTime = LocalTime.now();
                if (currentPlanRecipeActive != null && currentPlanRecipeActive.getStart_time() != null) {
                    Time startTimeFromDB = currentPlanRecipeActive.getStart_time();
                    LocalTime startTime = startTimeFromDB.toLocalTime();
                    if (currentTime.equals(startTime) || currentTime.isAfter(startTime)) {
                        request.setAttribute("planNotificationActivate", true);
                        session.setAttribute("currentPlanActivate", currentPlanRecipeActive);
                    } else {
                        request.setAttribute("planNotificationActivate", false);
                    }
                } else {
                    request.setAttribute("planNotificationActivate", false);
                }
            } else {
                request.setAttribute("planNotificationActivate", false);
            }

            // Check user plan date & update date based on current time. (daily)
            // Currently, only one plan can be active.
            if (activePlan != null) {
                if (currentDateNow.after(activePlan.getEnd_at())) {
                    isPlanStatus = PlanDAO.updateStatusByPlanID(activePlan.getId(), false);
                } else {
                    DateDTO date = DateDAO.getDateByPlanID(activePlan.getId());
                    if (date != null) {
                        DateDAO.updateDate(date.getId(), currentDateNow);
                    }
                }
            }
        }

        Throwable problem = null;

        chain.doFilter(request, response);

        //code
        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem
                != null) {
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
                log("LoadHeaderFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("LoadHeaderFilter()");
        }
        StringBuffer sb = new StringBuffer("LoadHeaderFilter(");
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
