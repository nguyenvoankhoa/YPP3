package content;

import setting.Structure;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Getter
@Setter
public class Node {
    private String id;
    private String content;
    private String color;
    private String background;
    private Position position;
    private List<Node> children;
    private boolean isOpen;
    private String shape;
    private String font;

    private Structure structure;

    public Node() {
        this.color = "Black";
        this.position = new Position();
        this.children = new ArrayList<>();
        this.isOpen = true;
        this.font = "Arial";
        this.background = "White";
        this.shape = "Rectangle";
        this.structure = Structure.FISH_BONE;
    }

    public Node(String id, String content) {
        this();
        this.id = id;
        this.content = content;
    }

    public Node(String id, String content, List<Node> children) {
        this(id, content);
        this.children = children;
    }

    public Node(String id, String content, List<Node> children, Position position) {
        this(id, content);
        this.children = children;
        this.position = position;
    }


    public void setStructure(Structure structure) {
        this.structure = structure;
        Optional.ofNullable(children)
                .ifPresent(nodes -> nodes.forEach(node -> node.setStructure(structure)));
    }

    public List<Node> addChild(Node child) {
        Optional.of(child)
                .filter(Leaf.class::isInstance)
                .map(c -> (Leaf) c)
                .ifPresent(leaf -> leaf.setParent(this));
        children.add(child);
        return children;
    }

    public List<Node> removeChild(String childId) {
        this.children.removeIf(n -> n.id.equals(childId));
        return this.children;
    }

    public void collapse() {
        setOpen(false);
    }

    public void expand() {
        setOpen(true);
    }

    public Node findById(String id) {
        return Optional.of(this)
                .filter(node -> getId().equals(id))
                .orElseGet(() -> getChildren().stream()
                        .map(node -> node.findById(id))
                        .filter(Objects::nonNull)
                        .findFirst()
                        .orElse(null));
    }

    @Override
    public String toString() {
        return "Node{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", color='" + color + '\'' +
                ", background='" + background + '\'' +
                ", position=" + position +
                ", children=" + children +
                ", isOpen=" + isOpen +
                ", shape='" + shape + '\'' +
                ", font='" + font + '\'' +
                ", structure=" + structure +
                '}';
    }
}
