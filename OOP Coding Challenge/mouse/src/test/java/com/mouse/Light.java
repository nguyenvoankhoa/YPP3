package com.mouse;

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