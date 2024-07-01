import lombok.Builder;

@Builder
public class Wheel {
    public Shape shape;

    public String scroll(int length) {
        return length < 0 ? "Scroll up " + length : "Scroll down " + length;
    }
}