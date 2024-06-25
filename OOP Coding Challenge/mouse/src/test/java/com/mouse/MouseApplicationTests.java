package com.mouse;

import org.junit.Assert;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;


@SpringBootTest
class MouseApplicationTests {


    @Test
    void contextLoads() {
        List<Light> lights = new ArrayList<>();
        Light light = new Light("Logitech", "black", 100, null);
        lights.add(light);
        Wheel wheel = new Wheel(new Shape());
        Point point = new Point(0, 0, 0);
        List<Point> points = new ArrayList<>();
        points.add(point);
        List<Button> buttons = new ArrayList<>();
        Button left = new Button("Left",
                new Shape(points, true, "black", new Line("black", 0)));
        Button right = new Button("Right",
                new Shape(points, true, "black", new Line("black", 0)));
        Button next = new Button("Next",
                new Shape(points, true, "black", new Line("black", 0)));
        Button back = new Button("Back",
                new Shape(points, true, "black", new Line("black", 0)));
        buttons.add(left);
        buttons.add(right);
        buttons.add(next);
        buttons.add(back);
        Position position = new Position(0, 0);
        Mouse mouse = new Mouse(lights, buttons, wheel, position);


    }


    public class Mouse {
        public List<Light> light;
        public List<Button> buttons;
        public Wheel wheel;
        public Position position;

        public Mouse(List<Light> light, List<Button> buttons, Wheel wheel, Position position) {
            this.light = light;
            this.buttons = buttons;
            this.wheel = wheel;
            this.position = position;
        }

        public Position move(int xOffset, int yOffset) {
            this.position.x += xOffset;
            this.position.y += yOffset;
            return this.position;
        }
        public void click(String type) {
            for (Button btn : buttons) {
                if (btn.type == type) {
                    btn.action("click");
                }
            }
        }
        public void doubleClick(String type) {
            for (Button btn : buttons) {
                if (btn.type == type) {
                    btn.action("double click");
                }
            }
        }
        public void press(String type) {
            for (Button btn : buttons) {
                if (btn.type == type) {
                    btn.action("press");
                }
            }
        }
    }

    public class Light {
        public String name;
        public String color;
        public int opacity;
        public Shape shape;

        public boolean status;

        public Light(String name, String color, int opacity, Shape shape) {
            this.name = name;
            this.color = color;
            this.opacity = opacity;
            this.shape = shape;
        }
        public void turnOn(){
            this.status = true;
        }
        public void turnOff(){
            this.status = false;
        }
        public void changeColor(String color){
            this.color = color;
        }
        public void changeOpacity(int opacity){
            this.opacity = opacity;
        }
    }

    public class Shape {
        public List<Point> points;
        public boolean fill;
        public String color;

        public Line line;

        public Shape() {
        }

        public Shape(List<Point> points, boolean fill, String color, Line line) {
            this.points = points;
            this.fill = fill;
            this.color = color;
            this.line = line;
        }
    }

    public class Point {
        int x;
        int y;
        int z;

        public Point(int x, int y, int z) {
            this.x = x;
            this.y = y;
            this.z = z;
        }

    }

    public class Line {
        public String color;
        public int width;

        public Line(String color, int width) {
            this.color = color;
            this.width = width;
        }
    }

    public class Button {
        public String type;
        public Shape shape;
        public Position position;

        public Button(String type, Shape shape) {
            this.type = type;
            this.shape = shape;
        }

        public void action(String action) {
            System.out.println("Button " + type + action);
        }

    }

    public class Wheel {
        public Shape shape;
        public Wheel(Shape shape) {
            this.shape = shape;
        }

        public void scroll(int length) {
            if (length < 0) {
                System.out.println("Scroll up " + length);
            } else {
                System.out.println("Scroll down " + length);
            }
        }
    }

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
    }

}
