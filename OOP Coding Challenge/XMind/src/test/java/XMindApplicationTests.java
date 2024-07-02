import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

class XMindApplicationTests {
    Node root;

    @BeforeEach
    public void setUp() {
        root = new RootBuilder()
                .addContent("Root")
                .addLevel(0)
                .addColor("Black")
                .addChildren("Content 1", "Content 2", "Content 3", "Content 4")
                .build();
    }

    @Test
    public void testAddChildren() {
        Leaf leaf = new LeafBuilder().addContent("Leaf 1").addParent(root).build();
        int beforeAddSize = root.children.size();
        root.addChild(leaf);
        int afterAddSize = root.children.size();
        assert (beforeAddSize + 1 == afterAddSize);
    }

    @Test
    public void testRemoveChildren() {
        Leaf leaf = new LeafBuilder().addContent("Leaf 1").addParent(root).build();
        root.addChild(leaf);
        int beforeRemoveSize = root.children.size();
        root.removeChild(leaf);
        int afterRemoveSize = root.children.size();
        assert (beforeRemoveSize - 1 == afterRemoveSize);
    }

    @Test
    public void testCollapse(){
        root.collapse();
        assert (!root.isOpen());
    }

    @Test
    public void testExpand(){
        root.expand();
        assert (root.isOpen());
    }

    @Test
    public void testMove(){

    }

    @Test
    public void testEditContent(){

    }

}
