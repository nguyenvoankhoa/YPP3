public class TargetObject {
    private int xLeft;
    private int xRight;
    private int yTop;
    private int yBottom;
    private String name;
    private boolean isActive;

    public TargetObject(int xLeft, int xRight, int yTop, int yBottom, String name) {
        this.xLeft = xLeft;
        this.xRight = xRight;
        this.yTop = yTop;
        this.yBottom = yBottom;
        this.name = name;
    }

    public int getxLeft() {
        return xLeft;
    }

    public int getxRight() {
        return xRight;
    }

    public int getyTop() {
        return yTop;
    }

    public int getyBottom() {
        return yBottom;
    }

    public String getName() {
        return name;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void start() {
        setActive(true);
    }
}
