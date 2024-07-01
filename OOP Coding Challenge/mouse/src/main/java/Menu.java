import lombok.Builder;
import lombok.experimental.SuperBuilder;

import java.util.List;
import java.util.stream.Collectors;
@SuperBuilder
public class Menu extends TargetObject {
    public boolean isOpen;
    List<Menu> submenus;

    @Override
    public String doAction() {
        String result = "open menu";
        result += (submenus == null) ? "" :
                ", contains submenu:" + submenus.stream().map(item -> " " + item.name).collect(Collectors.joining(","));
        return result;
    }

}
