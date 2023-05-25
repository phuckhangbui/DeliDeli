<%-- 
    Document   : generateToken
    Created on : May 24, 2023, 6:10:53 PM
    Author     : Daiisuke
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="tokenServlet">
            <h1>Generated token: <%= session.getAttribute("TOKEN")%></h1> <br/>
            <h1>Token received from server: <%= request.getAttribute("TOKENDB")%></h1>
            <input type="submit" value="Generate Token" />
            <br/>
        </form>    

        <%
            String generatedToken = (String) session.getAttribute("TOKEN");
            String TokenFromServer = (String) request.getAttribute("TOKENDB");

            if (generatedToken != null && TokenFromServer != null && generatedToken.equals(TokenFromServer)) {
                out.print("<h2>Token matched!</h2>");
            } else {
                out.print("<h2>Token mismatched!</h2>");
            }
        %>
        
        <form action="emailConfirmServlet" method="POST">
            <h2 style="color: indianred">Enter here get confirmation.</h2> 
            <input type="submit" value="Generate confirmation email" />
        </form>
    </body>
</html>
