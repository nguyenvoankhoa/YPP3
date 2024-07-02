import java.util.ArrayList;
import java.util.List;

public abstract class GenericBuilder<T extends GenericBuilder<T>> {
    protected String content;
    protected String color;
    protected String background;
    protected Position position;
    protected List<Node> children = new ArrayList<>();
    protected int level;
    protected boolean isOpen;
    protected String font;

    public T addBackground(String background) {
        this.background = background;
        return (T) this;
    }

    public T addPosition(Position position) {
        this.position = position;
        return (T) this;
    }

    public T addOpen(boolean status) {
        this.isOpen = status;
        return (T) this;
    }

    public T addLevel(int level) {
        this.level = level;
        return (T) this;
    }

    public T addFont(String font) {
        this.font = font;
        return (T) this;
    }

    public T addIsOpen(boolean isOpen) {
        this.isOpen = isOpen;
        return (T) this;
    }

    public T addChildren(String... children) {
        for (String str : children) {
            Leaf leaf = new Leaf(str);
            this.children.add(leaf);
        }
        return (T) this;
    }

    public T addContent(String content) {
        this.content = content;
        return (T) this;
    }

    public T addColor(String color) {
        this.color = color;
        return (T) this;
    }

    public abstract Node build();
}
