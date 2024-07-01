import lombok.Builder;

@Builder
public class Button {
    public String type;
    public Shape shape;


    public String action(TargetObject object, Action action) {
        return object != null ?
                ("Button " + type + " " + action.toString() + " at object " + object.name + ", " + object.doAction())
                : "Button " + type + " " + action.toString();
    }

}