public class LeafBuilder extends GenericBuilder<LeafBuilder> {
    private Node parent;

    public LeafBuilder addParent(Node parent) {
        this.parent = parent;
        return this;
    }
    @Override
    public Leaf build() {
        return new Leaf(content, parent);
    }


}
