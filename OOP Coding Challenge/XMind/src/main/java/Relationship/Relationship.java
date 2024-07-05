package relationship;

public class Relationship {
    private String sourceNode;
    private String targetNode;
    private String style;
    private String color;

    public Relationship() {
        this.style = "Thin";
        this.color = "Black";
    }

    public Relationship(String sourceNode, String targetNode) {
        this();
        this.sourceNode = sourceNode;
        this.targetNode = targetNode;
    }

    public String getSourceNode() {
        return sourceNode;
    }

    public void setSourceNode(String sourceNode) {
        this.sourceNode = sourceNode;
    }

    public String getTargetNode() {
        return targetNode;
    }

    public void setTargetNode(String targetNode) {
        this.targetNode = targetNode;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}
