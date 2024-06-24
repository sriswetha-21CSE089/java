/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package railway;

import java.util.*;

/**
 *
 * @author Swetha
 */
public class ticketbooking {
        static int lower=1;
        static int upper=1;
        static int mid=1;
        static int  rac=1;
        static int wait=1;
        
        static Queue<Integer> racl=new LinkedList<>();
        static Queue<Integer> wl=new LinkedList<>();
        static List<Integer> bookedtic=new ArrayList<>();
        
        static List<Integer> lpos = new ArrayList<>(Arrays.asList(1));
        static List<Integer> mpos = new ArrayList<>(Arrays.asList(1));
        static List<Integer> upos = new ArrayList<>(Arrays.asList(1));
        static List<Integer> rpos = new ArrayList<>(Arrays.asList(1));
        static List<Integer> wpos = new ArrayList<>(Arrays.asList(1));
        
        static Map<Integer,passenger> passmap=new HashMap<>();
        public void booktic(passenger p,int pos,String berthinfo){
            p.allotno=pos;
            p.allotseat=berthinfo;
            passmap.put(p.pid, p);
            bookedtic.add(p.pid);
            System.out.println("---------------------------------------------booked");
        }
        public void addtorac(passenger p,int pos,String berthinfo){
            p.allotno=pos;
            p.allotseat=berthinfo;
            passmap.put(p.pid, p);
            racl.add(p.pid);
            rac--;
            rpos.remove(0);
            System.out.println("--------------------------added to RAC Successfully");
        }
        public void addtowl(passenger p,int pos,String berthinfo){
             p.allotno=pos;
             p.allotseat=berthinfo;
             passmap.put(p.pid, p);
             wl.add(p.pid);
             wait--;
             wpos.remove(0);
             System.out.println("--------------------------added to WL Successfully");
        }
         public void printAvailable()
    {
        System.out.println("Available Lower Berths "  + lower);
        System.out.println("Available Middle Berths "  + mid);
        System.out.println("Available Upper Berths "  + upper);
        System.out.println("Availabel RACs " + rac);
        System.out.println("Available Waiting List " + wait);
        System.out.println("--------------------------");
    }
      public void passdetail(){
          if(passmap.size()==0){
              System.out.print("No passengers");
              return;
          }
          for(passenger i:passmap.values()){
              System.out.println("PASSENGER ID " + i.pid);
            System.out.println(" Name " + i.name );
            System.out.println(" Age " + i.age );
            System.out.println(" Status " + i.allotno + i.allotseat);
            System.out.println("--------------------------");
          }
      }
      public void canceltic(int cid){
          passenger p=passmap.get(cid);
          passmap.remove(Integer.valueOf(cid));
          bookedtic.remove(Integer.valueOf(cid));
          System.out.println("-------------------------------cancelled");
          if(p.allotseat.equals("U")){
              upos.add(p.allotno);
              upper++;
          }
          else if(p.allotseat.equals("M")){
              mpos.add(p.allotno);
              mid++;
          }
          else if(p.allotseat.equals("L")){
              lpos.add(p.allotno);
              lower++;
          }
          if(racl.size()>0){
              passenger pfrac=passmap.get(racl.poll());
              rpos.add(pfrac.allotno);
              racl.remove(Integer.valueOf(pfrac.pid));
              rac++;
              if(wl.size()>0){
                  passenger pfw=passmap.get(wl.poll());
                  wpos.add(pfw.allotno);
                  wl.remove(Integer.valueOf(pfw.pid));
                  pfw.allotno=rpos.get(0);
                  pfw.allotseat="RAC";
                  rpos.remove(0);
                  racl.add(pfw.pid);
                  wait++;
                  rac--;
              }
              main.book(pfrac);
          }
      }
}
