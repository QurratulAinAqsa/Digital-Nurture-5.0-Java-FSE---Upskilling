import java.util.*;
public class GuessGame {
    public static void main(String[] args) {

        Random r = new Random();
        int secret = r.nextInt(100)+1;

        Scanner sc = new Scanner(System.in);
        int guess;

        do {
            guess = sc.nextInt();

            if(guess > secret)
                System.out.println("Too High");
            else if(guess < secret)
                System.out.println("Too Low");

        } while(guess != secret);

        System.out.println("Correct!");
    }
}