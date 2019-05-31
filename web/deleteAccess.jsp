<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page import="uts.isd.AccessLog"%>
<%@page import="uts.isd.AccessLogs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String filePath = application.getRealPath("WEB-INF/customers.xml"); //Link to XML
    String filePath1 = application.getRealPath("WEB-INF/accessLog.xml"); //Link to XML
%>

<jsp:useBean id="customerApp" class="uts.isd.CustomerApplication" scope="application">
    <jsp:setProperty name="customerApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>

<jsp:useBean id="accessApp" class="uts.isd.AccessLogApplication" scope="application">
    <jsp:setProperty name="accessApp" property="filePath" value="<%=filePath1%>"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DELETE ACCESS LOG</title>
    </head>
    <body>
        <h1>DELETE ACCESS LOG</h1>
        <%
            int logID = Integer.parseInt(request.getParameter("logID"));
            AccessLogs accessLogs = accessApp.getAccessLogs(); //Get a list of all the access logs

            for (int i = 0; i <= accessLogs.getList().size() - 1; i++) { //Loop and remove the matching access log ID
                AccessLog accessLog1 = accessLogs.getAccessLog(i);
                if (accessLog1.getLogID() == logID) {
                    accessLogs.removeAccessLog(accessLog1);
                }
            }
            accessApp.setAccessLogs(accessLogs); //Update the list of access logs without the removed one
            accessApp.updateXML(accessLogs, filePath); //Update the XML file
            response.sendRedirect("viewAccess.jsp");
        %>
    </body>
</html>
