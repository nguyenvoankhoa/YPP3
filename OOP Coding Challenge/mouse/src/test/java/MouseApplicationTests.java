import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;


@SpringBootTest
public class MouseApplicationTests {
    Mouse mouse;
    List<TargetObject> objects;

    @BeforeEach
    public void setUp() {
        objects = new ArrayList<>();
        Shape shape = Shape.builder().build();
        Light light = Light.builder().name("Logitech").color("black").opacity(100).shape(shape).status(true).build();
        Wheel wheel = Wheel.builder().build();
        Point point = new Point(0, 0, 0);
        List<Point> points = new ArrayList<>();
        points.add(point);
        List<Button> buttons = new ArrayList<>();
        Button left = Button.builder()
                .type("Left")
                .shape(Shape.builder().color("black").build())
                .build();
        Button right = Button.builder()
                .type("Right")
                .shape(Shape.builder().color("black").build())
                .build();
        Button next = Button.builder()
                .type("Next")
                .shape(Shape.builder().color("black").build())
                .build();
        Button back = Button.builder()
                .type("Back")
                .shape(Shape.builder().color("black").build())
                .build();
        buttons.add(left);
        buttons.add(right);
        buttons.add(next);
        buttons.add(back);
        Position position = Position.builder().x(0).y(0).build();
        mouse = Mouse.builder()
                .buttons(buttons)
                .light(light)
                .wheel(wheel)
                .position(position)
                .sensitivity(50)
                .build();
    }

    @Test
    public void testMove() {
        mouse.move(2, 3);
        assert (mouse.position.equals(Position.builder().x(2 * 50).y(3 * 50).build()));
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
        assert (mouse.invokeButtonAction("Left", Action.CLICK, objects).equals("Button Left CLICK"));
    }

    @Test
    public void testLeftTargetClick() {
        TargetObject object = TargetObject.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Google")
                .build();
        objects.add(object);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Left", Action.CLICK, objects).equals("Button Left CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testRightButtonClick() {
        assert (mouse.invokeButtonAction("Right", Action.CLICK, objects).equals("Button Right CLICK"));
    }

    @Test
    public void testRightTargetClick() {
        TargetObject object = TargetObject.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Google")
                .build();
        objects.add(object);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.CLICK, objects).equals("Button Right CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testBackButtonClick() {
        assert (mouse.invokeButtonAction("Back", Action.CLICK, objects).equals("Button Back CLICK"));
    }

    @Test
    public void testNextButtonClick() {
        assert (mouse.invokeButtonAction("Next", Action.CLICK, objects).equals("Button Next CLICK"));
    }

    @Test
    public void testUnsupportedButton() {
        assert (mouse.invokeButtonAction("abc", Action.CLICK, objects).equals("Not have this button"));
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
        assert (mouse.invokeButtonAction("Left", Action.DOUBLE_CLICK, objects).equals("Button Left DOUBLE_CLICK"));
    }

    @Test
    public void testLeftTargetDoubleClick() {
        TargetObject object = TargetObject.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Google")
                .build();
        objects.add(object);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Left", Action.DOUBLE_CLICK, objects).equals("Button Left DOUBLE_CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testRightButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Right", Action.DOUBLE_CLICK, objects).equals("Button Right DOUBLE_CLICK"));
    }

    @Test
    public void testRightTargetDoubleClick() {
        TargetObject object = TargetObject.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Google")
                .build();
        objects.add(object);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.DOUBLE_CLICK, objects).equals("Button Right DOUBLE_CLICK at object Google, Google is doing something"));
    }

    @Test
    public void testBackButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Back", Action.DOUBLE_CLICK, objects).equals("Button Back DOUBLE_CLICK"));
    }

    @Test
    public void testNextButtonDoubleClick() {
        assert (mouse.invokeButtonAction("Next", Action.DOUBLE_CLICK, objects).equals("Button Next DOUBLE_CLICK"));
    }

    @Test
    public void testLeftButtonPress() {
        assert (mouse.invokeButtonAction("Left", Action.PRESS, objects).equals("Button Left PRESS"));
    }

    @Test
    public void testLeftTargetPress() {
        TargetObject object = TargetObject.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Google")
                .build();
        objects.add(object);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Left", Action.PRESS, objects).equals("Button Left PRESS at object Google, Google is doing something"));
    }

    @Test
    public void testRightButtonPress() {
        assert (mouse.invokeButtonAction("Right", Action.PRESS, objects).equals("Button Right PRESS"));
    }

    @Test
    public void testRightTargetPress() {
        TargetObject object = TargetObject.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Google")
                .build();
        objects.add(object);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.PRESS, objects).equals("Button Right PRESS at object Google, Google is doing something"));
    }

    @Test
    public void testBackButtonPress() {
        assert (mouse.invokeButtonAction("Back", Action.PRESS, objects).equals("Button Back PRESS"));
    }

    @Test
    public void testNextButtonPress() {
        assert (mouse.invokeButtonAction("Next", Action.PRESS, objects).equals("Button Next PRESS"));
    }

    @Test
    public void testRightOpenMenu() {
        Menu item1 = Menu.builder()
                .name("Show context action").xLeft(115).xRight(125).yTop(145).yBottom(155).isOpen(false)
                .build();
        Menu item2 = Menu.builder()
                .name("Refactor").xLeft(115).xRight(125).yTop(145).yBottom(155).isOpen(false)
                .build();
        List<Menu> menus = new ArrayList<>();
        menus.add(item1);
        menus.add(item2);
        TargetObject targetObject = Menu.builder()
                .xLeft(115)
                .xRight(125)
                .yTop(145)
                .yBottom(155)
                .name("Properties")
                .isOpen(false)
                .submenus(menus)
                .build();

        objects.add(targetObject);
        mouse.position = new Position(120, 150);
        assert (mouse.invokeButtonAction("Right", Action.CLICK, objects).equals("Button Right CLICK at object Properties, open menu, contains submenu: Show context action, Refactor,"));
    }


}
