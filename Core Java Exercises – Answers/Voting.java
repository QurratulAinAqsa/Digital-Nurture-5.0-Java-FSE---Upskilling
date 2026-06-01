class InvalidAgeException extends Exception {
    InvalidAgeException(String msg){
        super(msg);
    }
}

public class Voting {
    static void checkAge(int age)
            throws InvalidAgeException {

        if(age < 18)
            throw new InvalidAgeException("Age below 18");

        System.out.println("Eligible");
    }

    public static void main(String[] args) {

        try {
            checkAge(16);
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
}