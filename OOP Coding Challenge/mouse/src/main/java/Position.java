import lombok.Builder;

@Builder
public class Position {
    public int x;
    public int y;


    @Override
    public String toString() {
        return "position{" +
                "x=" + x +
                ", y=" + y +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        return (this == o) ? true : (o instanceof Position) && ((Position) o).x == x && ((Position) o).y == y;
    }


}