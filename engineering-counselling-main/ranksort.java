package rank;
import java.util.Comparator;
public class ranksort implements Comparator<pair>
{
    public int compare(pair p1,pair p2){
        if(p1.first.compareTo(p2.first)<0){
            return 1;
        }
        else{
            return -1;
        }
    }
}