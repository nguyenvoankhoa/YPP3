package com.mouse;

import org.junit.Assert;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;


@SpringBootTest
class MouseApplicationTests {
    Mouse mouse;
    List<TargetObject> objects;

    @BeforeEach
    public void setUp() {
        objects = new ArrayList<>();

        List<Light> lights = new ArrayList<>();
        Light light = new Light("Logitech", "black", 100, null);
        lights.add(light);
        Wheel wheel = new Wheel(new Shape());
        Point point = new Point(0, 0, 0);
        List<Point> points = new ArrayList<>();
        points.add(point);
        List<Button> buttons = new ArrayList<>();
        Button left = new Button("Left", new Shape(points, true, "black"));
        Button right = new Button("Right", new Shape(points, true, "black"));
        Button next = new Button("Next", new Shape(points, true, "black"));
        Button back = new Button("Back", new Shape(points, true, "black"));
        buttons.add(left);
        buttons.add(right);
        buttons.add(next);
        buttons.add(back);
        Position position = new Position(0, 0);
        mouse = new Mouse(lights, buttons, wheel, position, 50);
    }

    @Test
    public void testMove() {
        mouse.move(2, 3);
        assert (mouse.position.equals(new Position(2*50, 3*50)));
    }

    @Test
    public void testAdjustSensitivity() {
        int newSensitivity = 100;
        mouse.adjustSensitivity(newSensitivity);
        assert (mouse.sensitivity == newSensitivity);
    }

    @Test
    public void testLeftButtonClick() {
        assert (mouse.invokeButtonClick("Left").equals("Button Left click"));
    }
    @Test
    public void testLeftTargetClick(){
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Icon Google");
        objects.add(targetObject);
        System.out.println(this.mouse.position.x);
        assert(mouse.invokeButtonClick("Left").equals("Button Left click at object Icon Google"));
    }

    @Test
    public void testRightButtonClick() {
        assert (mouse.invokeButtonClick("Right").equals("Button Right click"));
    }

    @Test
    public void testBackButtonClick() {
        assert (mouse.invokeButtonClick("Back").equals("Button Back click"));
    }

    @Test
    public void testNextButtonClick() {
        assert (mouse.invokeButtonClick("Next").equals("Button Next click"));
    }

    @Test
    public void testUnsupportedButton(){
        assert(mouse.invokeButtonClick("abc").equals("Not have this button"));
    }
    @Test
    public void testScrollUp() {
        assert (mouse.wheel.scroll(-100).equals(("Scroll up " + -100)));
    }

    @Test
    public void testScrollDown() {
        assert (mouse.wheel.scroll(100).equals(("Scroll down " + 100)));
    }

    public class TargetObject {
        int xLeft;
        int xRight;
        int yTop;
        int yBottom;
        String name;

        public TargetObject(int xLeft, int xRight, int yTop, int yBottom, String name) {
            this.xLeft = xLeft;
            this.xRight = xRight;
            this.yTop = yTop;
            this.yBottom = yBottom;
            this.name = name;
        }
    }


    public class Mouse {
        public List<Light> lights;
        public List<Button> buttons;
        public Wheel wheel;
        public Position position;

        public int sensitivity;


        public Mouse(List<Light> lights, List<Button> buttons, Wheel wheel, Position position, int sensitivity) {
            this.lights = lights;
            this.buttons = buttons;
            this.wheel = wheel;
            this.position = position;
            this.sensitivity = sensitivity;
        }

        public Position move(int xOffset, int yOffset) {
            this.position.x += xOffset * sensitivity;
            this.position.y += yOffset * sensitivity;
            return this.position;
        }

        public int adjustSensitivity(int newSensitivity) {
            this.sensitivity = newSensitivity;
            return sensitivity;
        }

        public String invokeButtonClick(String type) {
            for (TargetObject targetObject : objects) {
                if (checkInRange(targetObject.xLeft, targetObject.xRight, targetObject.yTop, targetObject.yBottom)) {
                    return ("Button " + type + " click at object " + targetObject.name);
                }
            }
            for (Button btn : buttons) {
                if (btn.type.equals(type)) {
                    return btn.click();
                }
            }
            return "Not have this button";
        }
        public boolean checkInRange(int xLeft, int xRight, int yTop, int yBottom) {
            return position.x >= xLeft && position.x <= xRight && position.y <= yTop && position.y >= yBottom;
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

        public void turnOn() {
            this.status = true;
        }

        public void turnOff() {
            this.status = false;
        }

        public void changeColor(String color) {
            this.color = color;
        }

        public void changeOpacity(int opacity) {
            this.opacity = opacity;
        }
    }

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


    public class Button {
        public String type;
        public Shape shape;


        public Button(String type, Shape shape) {
            this.type = type;
            this.shape = shape;
        }

        public String click(TargetObject object) {
            if(object != null){
                return ("Button " + type + " click at object " + object.name);
            }
            return "Button " + type + " click";
        }

        public String doubleClick(TargetObject object) {
            if(object != null){
                return ("Button " + type + " double click at object " + object.name);
            }
            return "Button " + type + " double click";
        }

        public String press(TargetObject object) {
            if(object != null){
                return ("Button " + type + " double click at object " + object.name);
            }
            return "Button " + type + " press";
        }



    }

    public class Wheel {
        public Shape shape;

        public Wheel(Shape shape) {
            this.shape = shape;
        }

        public String scroll(int length) {
            if (length < 0) {
                return "Scroll up " + length;
            } else {
                return "Scroll down " + length;
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

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Position)) return false;
            Position position = (Position) o;
            return x == position.x && y == position.y;
        }

    }

}
