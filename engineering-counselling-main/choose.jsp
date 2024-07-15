
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
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
            .box{
                border: 2px solid black;
                padding:2px;
                margin-left: 28%;
                margin-right:28%;
                background-color: skyblue;
            }
            .head{
                margin-top: 0;
                background-color: #0066ff;

            }
            a{
                text-decoration: none;
                color: #0000ff;
            }
        </style>
    </head>
    <body>
        <center>
        
        <h3>CONFIRMATION PAGE FOR CHOICE FILLING</h3>
        </center>
        <%
            String n=request.getParameter("student");
            String m=request.getParameter("mail");
            Enumeration<String>s=request.getParameterNames();
            String str="";
            out.println("<div class='box'>");
            while(s.hasMoreElements()){
                String s1=s.nextElement();
                String val=request.getParameter(s1);
                if(val.equals(n)!=true && val.equals(m)!=true){
                try{
                    int cc=Integer.parseInt(s1);
                    out.println("<h3>"+val+"</h3>");
                }
                catch(Exception e){
                    str=str+s1+" ";
                    out.println("<p style='margin-left:15px;'>"+val+"   </p>");
                }
                }
            }
            Connection c=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
            Statement st=c.createStatement();
            boolean flag=true;
            ResultSet rs=st.executeQuery("select * from choice");
            while(rs.next()){
                if(rs.getString("mail").equals(m)){
                    flag=false;
                    break;
                }
            }
            if(flag){
            st.executeUpdate("insert into choice values('"+n+"','"+m+"','"+str+"')");}
            
        %>
        
    </body>
</html>
