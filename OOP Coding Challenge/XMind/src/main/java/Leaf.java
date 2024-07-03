import java.util.List;

public class Leaf extends Node {

    public Leaf(String content) {
        super(content);
    }

    public Leaf(String content, Node parent) {
        this(content);
        this.parent = parent;
    }

    private Node parent;

    public Node getParent() {
        return parent;
    }

    public void setParent(Node parent) {
        this.parent = parent;
    }

    public void move(Node newParent, int displacement) {
        Position newPosition = newParent.getPosition();
        newPosition.setX(newPosition.getX() + displacement);
        setPosition(newPosition);
        this.parent.removeChild(this);
        newParent.addChild(this);
        this.parent = newParent;
    }
}
