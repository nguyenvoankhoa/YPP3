package com.mouse;

import java.util.List;

public class Menu extends TargetObject {
    public boolean isOpen;
    List<Menu> submenus;

    public Menu(int xLeft, int xRight, int yTop, int yBottom, String name, boolean isOpen, List<Menu> submenus) {
        super(xLeft, xRight, yTop, yBottom, name);
        this.isOpen = isOpen;
        this.submenus = submenus;
    }

    @Override
    public String doAction() {
        String result = "open menu";
        if (submenus.size() > 0) {
            result += ", contains submenu:";
            for (Menu item : submenus) {
                result += " " + item.name +",";
            }
        }
        return result;
    }

}
