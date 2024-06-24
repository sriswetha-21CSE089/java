/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package railway;

/**
 *
 * @author Swetha
 */
public class passenger {
    static int id=1;
    String name;
    int age;
    String prefer;
    int allotno;
    String allotseat;
    int pid;
    passenger(String name,int age,String seat){
        this.name=name;
        this.age=age;
        this.prefer=seat;
        pid=id++;
        allotno=-1;
        allotseat="";
    }
    
}
