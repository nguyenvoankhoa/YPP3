import java.util.List;
import java.util.Optional;

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

    public Position move(double displacement, double degree) {
        double thetaDegree = Math.toRadians(degree);
        int newX = (int) (position.getX() + displacement * sensitivity * Math.cos(thetaDegree));
        int newY = (int) (position.getY() + displacement * sensitivity * Math.sin(thetaDegree));
        this.position.setX(newX);
        this.position.setY(newY);
        return this.position;
    }

    public int adjustSensitivity(int newSensitivity) {
        this.sensitivity = newSensitivity;
        return sensitivity;
    }

    public void invokeButtonAction(String type, Action action, List<TargetObject> objects) {
        Optional<TargetObject> object = objects.stream()
                .filter(o -> o != null)
                .filter(o -> checkInRange(o.getxLeft(), o.getxRight(), o.getyTop(), o.getyBottom()))
                .findFirst();
        buttons.stream()
                .filter(btn -> btn.getType().equals(type))
                .findFirst()
                .ifPresent(btn -> {
                    btn.setAction(action);
                    object.ifPresent(btn::invokeObjectAction);
                });
    }


    public boolean checkInRange(int xLeft, int xRight, int yTop, int yBottom) {
        return position.getX() >= xLeft && position.getX() <= xRight && position.getY() >= yTop && position.getY() <= yBottom;
    }

    public Button getButtonByType(String type) {
        var button = buttons.stream()
                .filter(btn -> btn.getType().equals(type))
                .findFirst()
                .orElse(null);
        return button;
    }
}
