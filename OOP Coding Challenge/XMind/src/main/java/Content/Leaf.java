package content;

import dependency.IFloatContentManager;
import floatcontent.FloatContent;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Optional;

@Getter
@Setter
public class Leaf extends Node {
    private Node parent;

    public Leaf(String id, String content) {
        super(id, content);
    }

    public Leaf(String id, String content, List<Node> children, Position position) {
        super(id, content, children, position);
    }

    public Leaf(String id, String content, List<Node> children, Position position, Node parent) {
        super(id, content, children, position);
        this.parent = parent;
    }

    public void move(Position position, String nodeId, Root root, IFloatContentManager iFloatContentManager) {
        Node cur = root.findChild(nodeId);
        this.parent.removeChild(nodeId);
        Node potentialParent = root.findNodeInRange(position);
        Optional.ofNullable(potentialParent)
                .ifPresentOrElse(p -> p.addChild(cur),
                        () -> iFloatContentManager.addContent((FloatContent) cur));
    }


}
