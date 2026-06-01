import java.util.*;

public class HashMapDemo {
    public static void main(String[] args) {

        HashMap<Integer,String> map =
                new HashMap<>();

        map.put(101,"Alice");
        map.put(102,"Bob");

        System.out.println(map.get(101));
    }
}