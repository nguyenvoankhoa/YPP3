import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;


public class MouseApplicationTests {
    Mouse mouse;
    List<TargetObject> objects;

    @BeforeEach
    public void setUp() {
        objects = new ArrayList<>();
        mouse = new MouseBuilder()
                .addButtons("Left", "Right", "Next", "Back")
                .addLight("Green")
                .addPosition(120, 150)
                .addWheel()
                .addSensitivity(100)
                .build();
    }

    @Test
    public void testMove() {
        mouse.move(2, 45);
        int expectedX = (int) (120 + 2 * 100 * Math.cos(Math.toRadians(45)));
        int expectedY = (int) (150 + 2 * 100 * Math.sin(Math.toRadians(45)));
        assert (mouse.position.equals(new Position(expectedX, expectedY)));
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
        assert (!mouse.light.status);
    }

    @Test
    public void testTurnOnColor() {
        mouse.light.turnOn();
        assert (mouse.light.status);
    }

    @Test
    public void testLeftButtonClick() {
        mouse.invokeButtonAction("Left", Action.CLICK, objects);
        assert (mouse.getButtonByType("Left").getAction()).equals(Action.CLICK);
    }

    @Test
    public void testLeftTargetClick() {
        TargetObject object = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(object);
        mouse.position = new Position(120, 150);
        mouse.invokeButtonAction("Left", Action.CLICK, objects);
        assert (mouse.getButtonByType("Left").getAction()).equals(Action.CLICK);
        assert (object.isActive());
    }

    @Test
    public void testRightButtonClick() {
        mouse.invokeButtonAction("Right", Action.CLICK, objects);
        assert (mouse.getButtonByType("Right").getAction()).equals(Action.CLICK);
    }

    @Test
    public void testRightTargetClick() {
        TargetObject object = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(object);
        mouse.position = new Position(120, 150);
        mouse.invokeButtonAction("Right", Action.CLICK, objects);
        assert (mouse.getButtonByType("Right").getAction()).equals(Action.CLICK);
        assert (object.isActive());
    }

    @Test
    public void testBackButtonClick() {
        mouse.invokeButtonAction("Back", Action.CLICK, objects);
        assert (mouse.getButtonByType("Back").getAction()).equals(Action.CLICK);
    }

    @Test
    public void testNextButtonClick() {
        mouse.invokeButtonAction("Next", Action.CLICK, objects);
        assert (mouse.getButtonByType("Next").getAction()).equals(Action.CLICK);
    }


    @Test
    public void testScrollUp() {
        assert (mouse.wheel.scrollUp(100)).equals(Action.SCROLL_UP);
    }

    @Test
    public void testScrollDown() {
        assert (mouse.wheel.scrollDown(100)).equals(Action.SCROLL_DOWN);
    }

    @Test
    public void testLeftButtonDoubleClick() {
        mouse.invokeButtonAction("Left", Action.DOUBLE_CLICK, objects);
        assert (mouse.getButtonByType("Left").getAction()).equals(Action.DOUBLE_CLICK);
    }

    @Test
    public void testLeftTargetDoubleClick() {
        TargetObject object = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(object);
        mouse.invokeButtonAction("Left", Action.DOUBLE_CLICK, objects);
        assert (mouse.getButtonByType("Left").getAction()).equals(Action.DOUBLE_CLICK);
        assert (object.isActive());
    }

    @Test
    public void testRightButtonDoubleClick() {
        mouse.invokeButtonAction("Right", Action.DOUBLE_CLICK, objects);
        assert (mouse.getButtonByType("Right").getAction()).equals(Action.DOUBLE_CLICK);
    }

    @Test
    public void testRightTargetDoubleClick() {
        TargetObject object = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(object);
        mouse.invokeButtonAction("Right", Action.DOUBLE_CLICK, objects);
        assert (mouse.getButtonByType("Right").getAction()).equals(Action.DOUBLE_CLICK);
        assert (object.isActive());
    }

    @Test
    public void testLeftButtonPress() {
        mouse.invokeButtonAction("Left", Action.PRESS, objects);
        assert (mouse.getButtonByType("Left").getAction()).equals(Action.PRESS);
    }

    @Test
    public void testLeftTargetPress() {
        TargetObject object = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(object);
        mouse.invokeButtonAction("Left", Action.PRESS, objects);
        assert (mouse.getButtonByType("Left").getAction()).equals(Action.PRESS);
        assert (object.isActive());
    }

    @Test
    public void testRightButtonPress() {
        mouse.invokeButtonAction("Right", Action.PRESS, objects);
        assert (mouse.getButtonByType("Right").getAction()).equals(Action.PRESS);
    }

    @Test
    public void testRightTargetPress() {
        TargetObject object = new TargetObject(115, 125, 145, 155, "Google");
        objects.add(object);
        mouse.invokeButtonAction("Right", Action.PRESS, objects);
        assert (mouse.getButtonByType("Right").getAction()).equals(Action.PRESS);
        assert (object.isActive());
    }


}
