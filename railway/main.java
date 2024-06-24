/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package railway;

import java.util.Scanner;
import railway.passenger;
import railway.ticketbooking;
/**
 *
 * @author Swetha
 */
public class main {

    /**
     * @param args the command line arguments
     */
     public static void book(passenger p){
         ticketbooking t=new ticketbooking();
         if(t.wait==0){
             System.out.println("no seat available");
             return;
         }
         if((p.prefer.equals("L") && t.lower > 0 )||
           (p.prefer.equals("M") && t.mid > 0) ||
           (p.prefer.equals("U") && t.upper > 0)){
             System.out.println("prefered berth given");
             if(p.prefer.equals("L")){
                 System.out.println("lower berth given");
                 t.booktic(p,t.lpos.get(0),"L");
                 t.lpos.remove(0);
                 t.lower--;
                 
             }
             else if(p.prefer.equals("M")){
                 System.out.println("middle berth given");
                 t.booktic(p,t.mpos.get(0),"M");
                 t.mpos.remove(0);
                 t.mid--;  
             }
             else if(p.prefer.equals("U")){
                 System.out.println("upper berth given");
                 t.booktic(p,t.upos.get(0),"U");
                 t.upos.remove(0);
                 t.upper--;  
             }
         }
         else if(t.lower>0){
                 System.out.println("lower berth given");
                 t.booktic(p,t.lpos.get(0),"L");
                 t.lpos.remove(0);
                 t.lower--;
         }
         else if(t.mid>0){
                System.out.println("middle berth given");
                 t.booktic(p,t.mpos.get(0),"M");
                 t.mpos.remove(0);
                 t.mid--;  
         }
         else if(t.upper>0){
                 System.out.println("upper berth given");
                 t.booktic(p,t.upos.get(0),"U");
                 t.upos.remove(0);
                 t.upper--;  
         }
         else if(t.rac>0){
             System.out.println("rac available");
             t.addtorac(p,t.rpos.get(0),"RAC");
             
         }
         else if(t.wait>0){
             System.out.println("Waiting list available");
             t.addtowl(p,t.wpos.get(0),"WL");    
         }
     }
     public static void cancel(int cid){
          ticketbooking t=new ticketbooking();
         if(!t.passmap.containsKey(cid)){
             System.out.print("unknown passenger");
            // System.out.print(t.passmap+" "+cid);
         }
         else
             t.canceltic(cid);
     }
    public static void main(String[] args) {
        // TODO code application logic here
        Scanner o=new Scanner(System.in);
        
        boolean loop=true;
        while(loop){
            System.out.println("1.book ticket\n2.cancel ticket\n3.print availability\n4.print booked tickets\n5.exit\n");
            int n=o.nextInt();
            switch(n){
                case 1:{
                    System.out.println("enter name,age,seat preference(L,M,U):\n");
                    String name=o.next();
                    int age=o.nextInt();
                    String seat=o.next();
                    passenger p=new passenger(name,age,seat);
                    book(p);
                }
                break;
                case 2:{
                      System.out.println("enter passenger id:");
                      int cid=o.nextInt();
                      cancel(cid);
                }
                break;
                case 3:{
                     ticketbooking t=new ticketbooking();
                     t.printAvailable();
                }
                break;
                case 4:{
                     ticketbooking t=new ticketbooking();
                     t.passdetail();
                }
                break;
                case 5:{
                    loop=false;
                }
                break;
                default:break;
            }
            
        }
    }
    
}
