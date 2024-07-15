<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="rank.*" %>
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
            table,td,th{
                border:1px solid black;
                border-collapse: collapse;
                padding: 3px;
                text-align: center;
                text-transform: uppercase;
            }
        </style>
    </head>
    <body></body>
    
        <%
            Connection c=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
            Statement st=c.createStatement();
            st.executeUpdate("truncate table ranklist");
            ResultSet rs=st.executeQuery("select * from student_info");
            
            ArrayList<pair>arr=new ArrayList<pair>();
            while(rs.next()){
                String name=rs.getString("studentname");
                String mail=rs.getString("mail");
                double cutoff=rs.getDouble("cutoff");
                String dob=rs.getString("dob");
                String com=rs.getString("community");
                String res=String.valueOf(cutoff)+" "+name;
                arr.add(new pair(res,mail,dob,com));
            }
            Collections.sort(arr,new ranksort());
            for(int i=0;i<arr.size();i++){
                String ov=arr.get(i).first;
                String m=arr.get(i).last;
                String dateofbirth=arr.get(i).dob;
                String community=arr.get(i).com;
                double cut=Double.parseDouble(ov.substring(0,4));
                String na=ov.substring(6);
                Connection c3=DriverManager.getConnection("jdbc:derby://localhost:1527/miniproject");
                Statement st3=c3.createStatement();
                boolean flag=true;
                ResultSet rs2=st3.executeQuery("select * from ranklist");
                while(rs2.next()){
                    String mail=rs2.getString("mail");
                    if(mail.equals(m)==true){
                        flag=false;
                        break;
                    }
                }
                c3.close();
                if(flag){
                st.executeUpdate("insert into ranklist values('"+m+"',"+cut+",'"+na+"','"+dateofbirth+"','"+community+"')");   }
            }
            ResultSet rs4=st.executeQuery("select count(mail) as c1,community from ranklist group by community");
            int index=1;
            Hashtable <String,String>arr1=new Hashtable<String,String>();
            while(rs4.next()){
                int c1=rs4.getInt("c1");
                String com1=rs4.getString("community");
                arr1.put(com1,String.valueOf(c1)+String.valueOf(c1));
            }
            ResultSet rs1=st.executeQuery("select * from ranklist");
            out.println("<center><h3>GENERAL ACADEMIC-PROVISIONAL RANK LIST</h3><br><table><tr><th>RANK</th><th>NAME OF THE CANDIDATE</th><th>DATE OF BIRTH</th><th>AGGREGATE MARK</th><th>COMMUNITY</th><th>COMMUNITY RANK</th></tr>");
            while(rs1.next()){
                double cut=rs1.getDouble("cutoff");
                String n=rs1.getString("studentname");
                String dob=rs1.getString("dob");
                String com=rs1.getString("community");
                String rank=arr1.get(com);
                int len=rank.length()/2;
                int ori=Integer.parseInt(rank.substring(0,len));
                int r=Integer.parseInt(rank.substring(len));
                out.println("<tr><td>"+index+"</td><td style='text-align:left;'>"+n+"</td><td>"+dob+"</td><td>"+cut+"</td><td>"+com+"</td><td>"+(r-ori+1)+"</td></tr>");
                index++;
                r++;
                arr1.replace(com, String.valueOf(ori)+String.valueOf(r));
            
            }
             out.println("</table></center>");
        %>
</html>
