<%@page import="java.util.ArrayList"%>
<%@page import="javax.xml.bind.Unmarshaller"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="javax.xml.bind.JAXBContext"%>
<%@page import="uts.isd.Customer"%>
<%@page import="uts.isd.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% String filePath = application.getRealPath("WEB-INF/customers.xml");%>
<jsp:useBean id="customerApp" class="uts.isd.CustomerApplication" scope="application">
    <jsp:setProperty name="customerApp" property="filePath" value="<%=filePath%>"/>
</jsp:useBean>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>login Action</title>
    </head>
    <body>
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            Customers customers = customerApp.getCustomers();
            Customer customer = customers.login(username, password);

            if (customer != null) {
                session.setAttribute("customer", customer);
        %>
        <p>Login successful. Click <a href="main.jsp">here</a> to return to the main page.</p>
        <% } else { %>
        <p>Password incorrect. Click <a href="login.jsp">here</a> to try again.</p>
        <% }%>
    </body>
</html>
