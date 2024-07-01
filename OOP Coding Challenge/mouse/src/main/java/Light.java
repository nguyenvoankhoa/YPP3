public class Light {
    public String name;
    public String color;
    public boolean status;

    public Light(String color) {
        this.color = color;
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
}
