import lombok.Builder;

import java.util.List;

@Builder
public class Mouse {
    public Light light;
    public List<Button> buttons;
    public Wheel wheel;
    public Position position;

    public int sensitivity;

    public Position move(int xOffset, int yOffset) {
        this.position.x += xOffset * sensitivity;
        this.position.y += yOffset * sensitivity;
        return this.position;
    }

    public int adjustSensitivity(int newSensitivity) {
        this.sensitivity = newSensitivity;
        return sensitivity;
    }

    public String invokeButtonAction(String type, Action action, List<TargetObject> objects) {
        TargetObject object = objects.stream()
                .filter(o-> o != null)
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