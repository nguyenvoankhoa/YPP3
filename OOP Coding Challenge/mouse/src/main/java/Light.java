import lombok.Builder;

@Builder
public class Light {
    public String name;
    public String color;
    public int opacity;
    public Shape shape;
    public boolean status;

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