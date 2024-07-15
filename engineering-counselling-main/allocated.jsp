<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body{
             /*   background-image: url('IMG-20230418-WA0001.jpg');*/
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size:cover;
            } 
            table,td,th{
                border:1px solid black;
                border-collapse: collapse;
                text-align: center;
                padding:3px;
            }
            .head{
                margin-top: 0;
                background-color: #0066ff;
            }
            
            .college{
                text-align: justify;
                margin: 0 auto;
                width: 40em;
                color: white;
                text-transform: capitalize;
                background:linear-gradient(50deg,#01010c,#330066,#01010c,#330066,#01010c);
            }
            .course{
                text-align: justify;
                margin: 0 auto;
                width: 40em;
                background: linear-gradient(50deg,#ccccff,#dcdcf9,#c9c9e2,#ccccff,#dcdcf9);
            }
        </style>
    </head>
    <body>
        
        <%
            Connection c1=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
            Statement st1=c1.createStatement();
            ResultSet rs1=st1.executeQuery("select * from choice where mail in (select mail from ranklist)");
            while(rs1.next()){
                Connection c3=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
                Statement st3=c3.createStatement();
                boolean flag=true;
                String course=rs1.getString("choices");
                String list[]=course.split(" ");
                String n=rs1.getString("studentname");
                String m=rs1.getString("mail");
                for(int i=0;i<list.length && flag;i++){
                    String ov=list[i];
                    String cc=ov.substring(0,4);
                    Integer code=Integer.parseInt(cc);
                    String co=ov.substring(4);
                    Connection c=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
                    Statement st=c.createStatement();
                    ResultSet rs=st.executeQuery("select * from college where collegecode="+code+"");
                    while(rs.next() && flag){
                        int seat=rs.getInt(co);
                        String college=rs.getString("collegename");
                        if(seat>0){
                            Connection c2=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
                            Statement st2=c2.createStatement();
                            boolean dummy=true;
                            Connection c6=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
                            Statement st6=c6.createStatement();
                            ResultSet rs6=st6.executeQuery("select * from allocation");
                            while(rs6.next()){
                                String mail=rs6.getString("mail");
                                if(mail.equals(m)==true){
                                    dummy=false;
                                    break;
                                }
                            }
                            st6.close();
                            if(dummy){
                            seat=seat-1;
                            st2.executeUpdate("update college set "+co+"="+seat+" where collegecode="+code+"");
                            c2.close();
                            st3.executeUpdate("insert into allocation values('"+n+"','"+m+"','"+college+"','"+co+"','allocated')");}
                            flag=false;
                        }
                    }
                    c.close();
                }
                if(flag){
                    boolean dummy=true;
                    Connection c7=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
                    Statement st7=c7.createStatement();
                    ResultSet rs7=st7.executeQuery("select * from allocation");
                    while(rs7.next()){
                        String mail=rs7.getString("mail");
                        if(mail.equals(m)==true){
                            dummy=false;
                            break;
                        }
                    }
                    c7.close();
                    if(dummy){
                    st3.executeUpdate("insert into allocation values('"+n+"','"+m+"','null','null','not allocated')");}
                }
                c3.close();
            }
            c1.close();
            
            String cname;int cse;int it;int ece;int eee;int mech;int civil;int ccode;
     /* Connection c6=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
            Statement st6=c6.createStatement();
            ResultSet rs6=st6.executeQuery("select * from allocation");
            out.println("<center><h3>SEAT ALLOCATED</h3><table><tr><th>student name</th><th>mail</th><th>college name</th><th>course name</th><th>status</th></tr>");
            while(rs6.next()){
                String name=rs6.getString("studentname");
                String mail=rs6.getString("mail");
                String collegename=rs6.getString("collegename");
                String course=rs6.getString("coursename");
                String status=rs6.getString("status");
                out.println("<tr><td style='text-align:left;'>"+name+"</td><td style='text-align:left;'>"+mail+"</td><td>"+collegename+"</td><td>"+course+"</td><td>"+status+"</td></tr>");
            }
             out.println("</table></center>");*/
             Connection c=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
             Statement st=c.createStatement();
             out.println("<center><h1> AVAILABLE SEATS</h1><br></center>");
             ResultSet rs=st.executeQuery("select * from college");
            while(rs.next())
            {
                ccode=rs.getInt("collegecode");
                cname=rs.getString("collegename");
                cse=rs.getInt("cse");
                it=rs.getInt("it");
                ece=rs.getInt("ece");
                eee=rs.getInt("eee");
                mech=rs.getInt("mech");
                civil=rs.getInt("civil");
        %>
        <tr><td>
        <div class="college1">
            <div class="college">        <% out.println("<h3>"+cname+"</h3>"); %></div>
        <div class="course">
                <%
                    if(cse>0){
                        out.println("COMPUTER SCIENCE AND ENGINEERING ------> <b>"+cse+"</b><br>");
                    }
                    if(it>0){
                        out.println("INFORMATION TECHNOLOGY ------> <b>"+it+"</b><br>");
                    }
                    if(ece>0){
                        out.println("ELECRONIC AND COMMUNICATION ENGINEERING ------> <b>"+ece+"</b><br>");
                    }
                    if(eee>0){
                        out.println("ELECTRICAL AND ELECTRONICS ENGINEERING ------> <b>"+eee+"</b><br>");
                    }
                    if(mech>0){
                        out.println("MECHANICAL ENGINEERING ------> <b>"+mech+"</b><br>");
                    }
                    if(civil>0){
                        out.println("CIVIL ENGINEERING ------> <b>"+civil+"</b><br>");
                    }
                %>
                <br>
            </div>
        </div>
        <%      
            out.println("</td></tr>");
            }
        %>
    </body>
</html>
