package com.mouse;

public class Position {
    public int x;
    public int y;

    public Position(int x, int y) {
        this.x = x;
        this.y = y;
    }

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