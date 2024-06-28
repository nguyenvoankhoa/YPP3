package com.mouse;

public class Button {
    public String type;
    public Shape shape;


    public Button(String type, Shape shape) {
        this.type = type;
        this.shape = shape;
    }

    public String action(TargetObject object, Action action) {
        if (object != null) {
            return ("Button " + type + " " + action.toString() + " at object " + object.name + ", " + object.doAction());
        }
        return "Button " + type + " " + action.toString();
    }

}