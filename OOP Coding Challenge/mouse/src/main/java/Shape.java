import lombok.Builder;

import java.util.List;
@Builder
public class Shape {
    public List<Point> points;
    public boolean fill;
    public String color;

}
