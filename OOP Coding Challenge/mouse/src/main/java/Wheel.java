public class Wheel {
    private Shape shape;

    public Wheel() {
        this.shape = new Shape();
    }

    public Action scrollUp(int length) {
        return Action.SCROLL_UP;
    }

    public Action scrollDown(int length) {
        return Action.SCROLL_DOWN;
    }
}
