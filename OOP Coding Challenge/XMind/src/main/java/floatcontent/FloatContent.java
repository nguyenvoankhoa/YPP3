package floatcontent;

import content.Leaf;
import content.Node;
import content.Position;
import content.Root;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class FloatContent extends Node{

    List<FloatContent> floatContents;

    public FloatContent(String id, String content) {
        super(id, content);
        floatContents = new ArrayList<>();
    }

    public FloatContent(String id, String content, List<Node> children) {
        super(id, content, children);
    }

    public void move(Position newPosition, String id, Root root) {
        Node content = findChild(id);
        Node parent = root.findNodeInRange(newPosition);

        Optional.ofNullable(parent)
                .map(p -> (Leaf) content)
                .ifPresentOrElse(p -> parent.addChild(p), () -> content.setPosition(newPosition));
    }

}
