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
        Light light = new Light("Logitech", "black", 100, new Shape(), true);
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
        mouse = new Mouse(light, buttons, wheel, position, 50);
    }

    @Test
    public void testMove() {
        mouse.move(2, 3);
        assert (mouse.position.equals(new Position(2 * 50, 3 * 50)));
    }

    @Test
    public void testAdjustSensitivity() {
        int newSensitivity = 100;
        mouse.adjustSensitivity(newSensitivity);
        assert (mouse.sensitivity == newSensitivity);
    }

    @Test
    public void testChangeLightColor() {
        mouse.light.changeColor("red");
        assert (mouse.light.color.equals("red"));
    }

    @Test
    public void testTurnOffColor() {
        mouse.light.turnOff();
        assert (mouse.light.status == false);
    }

    @Test
    public void testTurnOnColor() {
        mouse.light.turnOn();
        assert (mouse.light.status == true);
    }

    @Test
    public void testLeftButtonClick() {
        assert (mouse.invokeButtonAction("Left", Action.CLICK).equals("Button Left CLICK"));
    }

    @Test
    public void testLeftTargetClick() {
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Left", Action.CLICK).equals("Button Left CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testRightButtonClick() {
        assert (mouse.invokeButtonAction("Right", Action.CLICK).equals("Button Right CLICK"));
    }

    @Test
    public void testRightTargetClick() {
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.CLICK).equals("Button Right CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testBackButtonClick() {
        assert (mouse.invokeButtonAction("Back", Action.CLICK).equals("Button Back CLICK"));
    }

    @Test
    public void testNextButtonClick() {
        assert (mouse.invokeButtonAction("Next", Action.CLICK).equals("Button Next CLICK"));
    }

    @Test
    public void testUnsupportedButton() {
        assert (mouse.invokeButtonAction("abc", Action.CLICK).equals("Not have this button"));
    }

    @Test
    public void testScrollUp() {
        assert (mouse.wheel.scroll(-100).equals(("Scroll up " + -100)));
    }

    @Test
    public void testScrollDown() {
        assert (mouse.wheel.scroll(100).equals(("Scroll down " + 100)));
    }

    @Test
    public void testLeftButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Left", Action.DOUBLE_CLICK).equals("Button Left DOUBLE_CLICK"));
    }

    @Test
    public void testLeftTargetDoubleClick() {
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Left", Action.DOUBLE_CLICK).equals("Button Left DOUBLE_CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testRightButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Right", Action.DOUBLE_CLICK).equals("Button Right DOUBLE_CLICK"));
    }

    @Test
    public void testRightTargetDoubleClick() {
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.DOUBLE_CLICK).equals("Button Right DOUBLE_CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testBackButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Back", Action.DOUBLE_CLICK).equals("Button Back DOUBLE_CLICK"));
    }

    @Test
    public void testNextButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Next", Action.DOUBLE_CLICK).equals("Button Next DOUBLE_CLICK"));
    }

    @Test
    public void testLeftButtonPress() {
        assert (mouse.invokeButtonAction("Left", Action.PRESS).equals("Button Left PRESS"));
    }

    @Test
    public void testLeftTargetPress() {
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Left", Action.PRESS).equals("Button Left PRESS at object Google, Google is doing something"));
    }

    @Test
    public void testRightButtonPress() {
        assert (mouse.invokeButtonAction("Right", Action.PRESS).equals("Button Right PRESS"));
    }

    @Test
    public void testRightTargetPress() {
        TargetObject targetObject = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.PRESS).equals("Button Right PRESS at object Google, Google is doing something"));
    }

    @Test
    public void testBackButtonPress() {
        assert (mouse.invokeButtonAction("Back", Action.PRESS).equals("Button Back PRESS"));
    }

    @Test
    public void testNextButtonPress() {
        assert (mouse.invokeButtonAction("Next", Action.PRESS).equals("Button Next PRESS"));
    }

    @Test
    public void testRightOpenMenu() {
        Menu item1 = new Menu(115, 125, 145, 155, "Show context action", false, null);
        Menu item2 = new Menu(115, 125, 145, 155, "Refactor", false, null);
        List<Menu> menus = new ArrayList<>();
        menus.add(item1);
        menus.add(item2);
        TargetObject targetObject = new Menu(115, 125, 145, 155, "Properties", false, menus);
        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.CLICK).equals("Button Right CLICK at object Properties, open menu, contains submenu: Show context action, Refactor,"));
    }

    public class Mouse {
        public Light light;
        public List<Button> buttons;
        public Wheel wheel;
        public Position position;

        public int sensitivity;


        public Mouse(Light light, List<Button> buttons, Wheel wheel, Position position, int sensitivity) {
            this.light = light;
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

        public String invokeButtonAction(String type, Action action) {
            TargetObject object = objects.stream()
                    .filter(o -> checkInRange(o.xLeft, o.xRight, o.yTop, o.yBottom))
                    .findFirst()
                    .orElse(null);
            return buttons.stream().filter(btn -> btn.type.equals(type))
                    .findFirst()
                    .map(btn -> btn.action(object, action))
                    .orElse("Not have this button");
        }

        public boolean checkInRange(int xLeft, int xRight, int yTop, int yBottom) {
            return position.x >= xLeft && position.x <= xRight && position.y >= yTop && position.y <= yBottom;
        }


    }

}
