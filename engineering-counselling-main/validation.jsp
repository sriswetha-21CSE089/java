<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body{
            /*    background-image: url('IMG-20230418-WA0001.jpg');*/
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size:cover;
            }
            a{
                text-decoration: none;
                color: #000000;
            }
            td{
                background-color: skyblue;
                border: 2px solid black;
                padding:15px;
            }
            .box{
                margin-top: 7%;
                background-color: #0066ff;
                border: 2px solid black;
                padding:20px;
                margin-left: 25%;
                margin-right: 25%;
            }
        </style>
    </head>
    <body>
        <%
            String n=request.getParameter("student");
            String name=request.getParameter("t1");
            String m=request.getParameter("mail");
            String date=request.getParameter("t3");
            double maths=Double.parseDouble(request.getParameter("mat"));
            double chemistry=Double.parseDouble(request.getParameter("che"));
            double physics=Double.parseDouble(request.getParameter("phy"));
            double cutoff=maths+chemistry/2+physics/2;
            String com=request.getParameter("com");
            Connection c=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
            Statement st=c.createStatement();
            boolean flag=true;
            if(n!=null && m!=null && date!=null && cutoff!=0){
                ResultSet rs=st.executeQuery("select * from student_info");
                while(rs.next()){
                    if(rs.getString("mail").equals(m)){
                        flag=false;
                        break;
                    }
                }
                if(flag){
                st.executeUpdate("insert into student_info values('"+name+"','"+m+"',"+cutoff+",'"+date+"','"+com+"')");
                }
            }
        %>
    <center>
        <div class="box">
            <h3>CONFIRMATION PAGE FOR APPLICATION FORM</h3>
            <p>THANK YOU FOR SUBMITTING THIS FORM</p>
            <p>WE HAVE SUCCESSFULLY RECEIVED IT</p>
            <P>BELOW IS A SUMMARY OF THE INFORMATION YOU PROVIDED.</P>
            <table><tr><td>
            <%
                out.println("NAME : "+name+"<br><br>");
                out.println("EMAIL : "+m+"<br><br>");
                out.println("DOB : "+date+"<br><br>");
                out.println("COMMUNITY : "+com+"<br><br>");
                out.println("AGGREGATE MARK : "+cutoff+"<br><br>");
                out.println("</td></tr></table>");
            %>      
        </div>
    </center>
        
    </body>
</html>