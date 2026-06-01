import java.util.Scanner;

public class Calculator {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter first number: ");
        double a = sc.nextDouble();

        System.out.print("Enter second number: ");
        double b = sc.nextDouble();

        System.out.print("Enter operator (+,-,*,/): ");
        char op = sc.next().charAt(0);

        switch(op){
            case '+': System.out.println(a+b); break;
            case '-': System.out.println(a-b); break;
            case '*': System.out.println(a*b); break;
            case '/': System.out.println(a/b); break;
        }
    }
}