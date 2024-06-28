package com.mouse;

public class Wheel {
    public Shape shape;

    public Wheel(Shape shape) {
        this.shape = shape;
    }

    public String scroll(int length) {
        return length < 0 ? "Scroll up " + length : "Scroll down " + length;
    }
}