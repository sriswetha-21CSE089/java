<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body{
        /*        background-image: url('IMG-20230418-WA0001.jpg');*/
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size:cover;
            }  
            table{
                text-transform: capitalize;
                font-weight: bold;
                border:1px solid black;
                padding:2px;
               
            }
            .head{
                margin-top: 0;
                background-color: #0066ff;
            }
        </style>
    </head>
    <body>
        <center>
        <h4>STUDENT DETAILS</h4>
        <%
        String n=request.getParameter("student");
        String m=request.getParameter("mail");
        %>
        <form action="validation.jsp" method="post">
        <table>
            <tr><td><label>name:</label></td><td><input type="text" name="t1"></td></tr>
            <tr><td><label>year of 12th pass:</label></td><td><input type="text" name="t2"></td></tr>
            <tr><td><label>date of birth:</label></td><td><input type="date" name="t3"></td></tr>
            
            <tr><td><label>maths mark:</label></td><td><input type="text" name="mat"></td></tr>
            <tr><td><label>chemistry mark:</label></td><td><input type="text" name="che"></td></tr>
            <tr><td><label>physics mark:</label></td><td><input type="text" name="phy"></td></tr>
            
            <!--<tr><td><label>total mark in 12th:</label></td><td><input type="text" name="t4"></td></tr>-->
            <!--<tr><td><label>percentage:</label></td><td><input type="text" name="t5"></td></tr>-->
            <tr><td><label>community:</label></td><td><input type="text" name="com"></td></tr>
            
            <tr><td><label>upload 12th mark sheet:</label></td><td><input type="file" name="t6"></td></tr>
            <tr><td><label>upload your photo:</label></td><td><input type="file" name="t7"></td></tr>
            <% 
            out.println("<input type='hidden' name='student' value='"+n+"'>");
            out.println("<input type='hidden' name='mail' value='"+m+"'>");
            %>
        </table><br><br>
        <input type="submit">
        </form>
        <div id="demo"></div>
    </center>
    </body>
</html>
