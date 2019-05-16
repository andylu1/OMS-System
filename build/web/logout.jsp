
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <p>You have been logged out. Click <a href="main.jsp">here</a> to return to the main page.</p>
        <%session.invalidate();%>
    </body>
</html>
