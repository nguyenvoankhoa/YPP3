import java.util.ArrayList;
import java.util.List;

public class MouseBuilder {
    public Light light;
    public List<Button> buttons;
    public Wheel wheel;
    public Position position;
    public int sensitivity;

    public MouseBuilder() {
        buttons = new ArrayList<>();
    }

    public MouseBuilder addButtons(String... buttons) {
        for (String btn : buttons) {
            Button button = new Button(btn);
            this.buttons.add(button);
        }
        return this;
    }

    public MouseBuilder addLight(String color) {
        this.light = new Light(color);
        return this;
    }

    public MouseBuilder addPosition(int x, int y) {
        this.position = new Position(x, y);
        return this;
    }

    public MouseBuilder addWheel() {
        this.wheel = new Wheel();
        return this;
    }

    public MouseBuilder addSensity(int sensitivity) {
        this.sensitivity = sensitivity;
        return this;
    }

    public Mouse build() {
        return new Mouse(light, buttons, wheel, position, 100);
    }

}
