import lombok.Builder;
import lombok.experimental.SuperBuilder;

@SuperBuilder
public class TargetObject{
    public int xLeft;
    public int xRight;
    public int yTop;
    public int yBottom;
    public String name;

    public String doAction() {
        return  this.name + " is doing something";
    }
}
