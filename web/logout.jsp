<%@page import="java.util.Date"%>
<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page import="uts.isd.AccessLog"%>
<%@page import="uts.isd.AccessLogs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="main.jsp"%>

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
        <title>LOGOUT</title>
    </head>
    <body>
        <%
            AccessLog currentAccessLog = (AccessLog) session.getAttribute("accessLog"); //GET STORED ACCESS LOG
            int logID = currentAccessLog.getLogID();
            int userID = currentAccessLog.getUserID();
            Date loginDate = currentAccessLog.getLoginDate();
            Date logoutDate = new Date(); //Get a new date for the logout

            AccessLog newAccessLog = new AccessLog(logID, userID, loginDate, logoutDate); //CREATE THE NEW ACCESS LOG
            AccessLogs accessLogs = accessApp.getAccessLogs();

            for (int i = 0; i <= accessLogs.getList().size() - 1; i++) { //REMOVE THE OLD ACCESS LOG
                AccessLog accessLog1 = accessLogs.getAccessLog(i);
                if (accessLog1.getLogID() == logID) {
                    accessLogs.removeAccessLog(accessLog1);
                }
            }
            accessLogs.addAccessLog(newAccessLog);
            accessApp.setAccessLogs(accessLogs);
            accessApp.updateXML(accessLogs, filePath); //UPDATE XML FILE

            session.invalidate(); //End all sessions
            response.sendRedirect("main.jsp");
        %>
        <p>You have been logged out. Click <a href="main.jsp">here</a> to return to the main page.</p>        
    </body>
</html>
