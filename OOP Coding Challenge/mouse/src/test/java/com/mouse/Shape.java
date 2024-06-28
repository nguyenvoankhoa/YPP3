package com.mouse;

import java.util.List;

public class Shape {
    public List<Point> points;
    public boolean fill;
    public String color;

    public Shape() {
    }

    public Shape(List<Point> points, boolean fill, String color) {
        this.points = points;
        this.fill = fill;
        this.color = color;
    }
}
