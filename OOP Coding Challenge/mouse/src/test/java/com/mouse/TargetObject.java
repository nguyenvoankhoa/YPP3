package com.mouse;

public class TargetObject implements ITargetObject{
    int xLeft;
    int xRight;
    int yTop;
    int yBottom;
    String name;

    public TargetObject(int xLeft, int xRight, int yTop, int yBottom, String name) {
        this.xLeft = xLeft;
        this.xRight = xRight;
        this.yTop = yTop;
        this.yBottom = yBottom;
        this.name = name;
    }

    @Override
    public String doAction() {
        return  this.name + " is doing something";
    }
}
