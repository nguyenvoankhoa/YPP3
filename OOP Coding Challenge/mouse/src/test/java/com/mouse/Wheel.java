package com.mouse;
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