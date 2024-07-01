public class Wheel {
    private Shape shape;

    public Shape getShape() {
        return shape;
    }

    public void setShape(Shape shape) {
        this.shape = shape;
    }

    public Action scroll(int length) {
        return length < 0 ? Action.SCROLL_UP : Action.SCROLL_DOWN;
    }
}
