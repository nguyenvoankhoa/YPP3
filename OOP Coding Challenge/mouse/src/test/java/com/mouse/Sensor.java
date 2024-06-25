package com.mouse;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Sensor {
    int currentX;
    int currentY;
    String action;

    int variance;

    public Sensor() {
        currentX = 0;
        currentY = 0;
    }

    public Sensor(int currentX, int currentY, String action, int variance) {
        this.currentX = currentX;
        this.currentY = currentY;
        this.action = action;
        this.variance = variance;
    }

    public Sensor generateRandomValue(int maxX, int maxY) {
        Random rand = new Random();
        int newX = rand.nextInt(maxX);
        int newY = rand.nextInt(maxY);
        List<String> actionList = new ArrayList<>();
        actionList.add("Left");
        actionList.add("Right");
        actionList.add("Next");
        actionList.add("Back");
        actionList.add("Scroll");
        int newAction = rand.nextInt(4);
        String action = actionList.get(newAction);
        int variance = rand.nextInt(300);
        return new Sensor(newX, newY, action, variance);
    }
}
