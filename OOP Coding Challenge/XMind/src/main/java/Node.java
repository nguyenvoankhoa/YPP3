import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public abstract class Node {
    protected String id;
    protected String content;
    protected String color;
    protected String background;
    protected Position position;
    protected List<Node> children;
    protected int level;
    protected boolean isOpen;

    protected String font;

    public Node() {
        this.id = UUID.randomUUID().toString();
        this.color = "Black";
        this.position = new Position();
        this.children = new ArrayList<>();
        this.isOpen = true;
        this.font = "Arial";
        this.background = "White";
    }

    public Node(String content, int level, List<Node> children) {
        this();
        this.content = content;
        this.level = level;
        this.children = children;
    }

    public boolean isOpen() {
        return isOpen;
    }

    public void setOpen(boolean open) {
        isOpen = open;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFont() {
        return font;
    }

    public void setFont(String font) {
        this.font = font;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public Position getPosition() {
        return position;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public List<Node> getChildren() {
        return children;
    }

    public void setChildren(List<Node> children) {
        this.children = children;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public void setChildLevel() {
        for (Node child : this.children) {
            child.level = getLevel() + 1;
        }
    }

    public List<Node> addChild(Node child) {
        this.children.add(child);
        setChildLevel();
        return this.children;
    }

    public List<Node> removeChild(Node child) {
        this.children = this.children.stream()
                .filter(n -> n.id != child.id)
                .collect(Collectors.toList());
        return this.children;
    }

    public Node editContent(String content) {
        setContent(content);
        return this;
    }


    public void collapse() {
        setOpen(false);
    }

    public void expand() {
        setOpen(true);
    }


}
