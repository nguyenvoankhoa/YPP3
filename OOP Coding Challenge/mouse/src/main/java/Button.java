public class Button {
    private String type;
    private Shape shape;
    private Action action;

    public Button() {
        Shape shape = new Shape("Black");
    }

    public Button(String type) {
        this();
        this.type = type;

    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Shape getShape() {
        return shape;
    }

    public void setShape(Shape shape) {
        this.shape = shape;
    }

    public Action getAction() {
        return action;
    }

    public void setAction(Action action) {
        this.action = action;
    }

    public void invokeObjectAction(TargetObject object) {
        object.start();
    }
}
