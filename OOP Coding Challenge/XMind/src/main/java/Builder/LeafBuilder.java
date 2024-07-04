package Builder;

import Content.Leaf;
import Content.Node;

public class LeafBuilder extends GenericBuilder<LeafBuilder> {
    private Node parent;

    public LeafBuilder addParent(Node parent) {
        this.parent = parent;
        return this;
    }

    @Override
    protected LeafBuilder self() {
        return this;
    }

    @Override
    public Leaf build() {
        return new Leaf(content, parent);
    }


}
