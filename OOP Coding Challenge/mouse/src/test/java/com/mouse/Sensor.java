package com.mouse;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Sensor {
    int currentX;
    int currentY;

    String action;
    public Sensor(){
        currentX = 0;
        currentY = 0;
    }

    public Sensor(int currentX, int currentY, String action) {
        this.currentX = currentX;
        this.currentY = currentY;
        this.action = action;
    }

    public Sensor generateRandomValue(int maxX, int maxY){
        Random rand = new Random();
        int newX = rand.nextInt(maxX);
        int newY = rand.nextInt(maxY);
        List<String> actionList = new ArrayList<>();
        actionList.add("Left");
        actionList.add("Right");
        actionList.add("Next");
        actionList.add("Back");
        actionList.add("Scroll Up");
        actionList.add("Scroll Down");
        int newAction = rand.nextInt(5);
        String action = actionList.get(newAction);
        return new Sensor(newX, newY, action);
    }
}
