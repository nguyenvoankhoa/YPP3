package com.mouse;

import java.util.List;
import java.util.stream.Collectors;

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
        result += (submenus == null) ? "" :
                ", contains submenu:" + submenus.stream().map(item -> " " + item.name).collect(Collectors.joining(","));
        return result;
    }

}
