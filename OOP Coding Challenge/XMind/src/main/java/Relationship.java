public class Relationship {
    private Node sourceNode;
    private Node targetNode;
    private String style;
    private String color;

    public Relationship() {
        this.style = "Thin";
        this.color = "Black";
    }

    public Relationship(Node sourceNode, Node targetNode) {
        this();
        this.sourceNode = sourceNode;
        this.targetNode = targetNode;
    }

    public void removeRelationship() {
        this.targetNode = null;
        this.sourceNode = null;
    }

    public Node getSourceNode() {
        return sourceNode;
    }

    public void setSourceNode(Node sourceNode) {
        this.sourceNode = sourceNode;
    }

    public Node getTargetNode() {
        return targetNode;
    }

    public void setTargetNode(Node targetNode) {
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
