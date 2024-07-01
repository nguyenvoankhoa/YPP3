import java.util.ArrayList;
import java.util.List;

public class Shape {
    public List<Point> points;
    public boolean fill;
    public String color;

    public Shape() {
        this.fill = true;
        this.points = new ArrayList<>();
    }

    public Shape(String color) {
        this();
        this.color = color;
    }
}
