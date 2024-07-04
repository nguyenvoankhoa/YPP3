import Board.Board;
import Board.BoardSerializer;
import Builder.LeafBuilder;
import Content.FloatContent;
import Content.Leaf;
import Content.Node;
import Content.Position;
import Relationship.Relationship;
import Relationship.RelationshipManager;
import Setting.ViewType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class XMindApplicationTests {
    Board board;
    Node root;

    @BeforeEach
    public void setUp() {
        BoardSerializer boardSerializer = new BoardSerializer();
        RelationshipManager relationshipManager = new RelationshipManager();
        board = new Board("Bright", "White", "Arial", 90, "Xmind Test", ViewType.SIXTEEN_BY_FOUR, boardSerializer, relationshipManager);
        root = board.getRoot();
    }

    @Test
    public void testAddChildren() {
        Leaf leaf = new LeafBuilder().addContent("Node.Node.Leaf 1").addParent(root).build();
        int beforeAddSize = root.getChildren().size();
        root.addChild(leaf);
        int afterAddSize = root.getChildren().size();
        assert (beforeAddSize + 1 == afterAddSize);
    }

    @Test
    public void testRemoveChildren() {
        Leaf leaf = new LeafBuilder().addContent("Node.Node.Leaf 1").addParent(root).build();
        root.addChild(leaf);
        int beforeRemoveSize = root.getChildren().size();
        root.removeChild(leaf);
        int afterRemoveSize = root.getChildren().size();
        assert (beforeRemoveSize - 1 == afterRemoveSize);
    }

    @Test
    public void testCollapse() {
        root.collapse();
        assert (!root.isOpen());
    }

    @Test
    public void testExpand() {
        root.expand();
        assert (root.isOpen());
    }

    @Test
    public void testMove() {
        Leaf leaf = new LeafBuilder().addContent("Node.Node.Leaf 1").addParent(root).build();
        Leaf leaf2 = new LeafBuilder().addContent("Node.Node.Leaf 2").addParent(root).build();
        root.addChild(leaf);
        root.addChild(leaf2);
        leaf.move(leaf2);
        assert (leaf.getParent().getId() == leaf2.getId());
    }

    @Test
    public void testEditContent() {
        root.editContent("New Content");
        assert (root.getContent().equals("New Content"));
    }

    @Test
    public void testRemoveAll() {
        root.removeAll();
        assert (root.getChildren() == null);
    }

    @Test
    public void testImport() {
        String filepath = "src/main/resources/test.json";
        assert (board.getIBoardSerialize().importMindMap(filepath) != null);

    }


    @Test
    public void testFloatContentMove() {
        Position position = new Position(3, 4);
        FloatContent floatContent = new FloatContent();
        floatContent.move(position);
        assert (floatContent.getPosition().getX() == position.getX() && floatContent.getPosition().getY() == position.getY());
    }

    @Test
    public void testAdjustZoomLevel() {
        board.setZoomLevel(100);
        assert (board.getZoomLevel() == 100);
    }

    @Test
    public void testAdjustViewport() {
        board.setViewType(ViewType.THREE_BY_FOUR);
        assert (board.getViewType().equals(ViewType.THREE_BY_FOUR));
    }

    @Test
    public void testSave() {
        String filepath = "src/main/resources/test.json";
        assert (board.getIBoardSerialize().saveMindMap(board, filepath));
    }

    @Test
    public void testRemoveRelationship() {
        Leaf src = new Leaf("abc");
        Leaf target = new Leaf("def");
        board.getIRelationshipManager().addRelationship(src, target);
        Relationship relationship = board.getIRelationshipManager().getRelationships().get(0);
        int relaBefore = board.getIRelationshipManager().getRelationships().size();
        board.getIRelationshipManager().removeRelationship(relationship);
        int relaAfter = board.getIRelationshipManager().getRelationships().size();
        assert (relaBefore - 1 == relaAfter);
    }

    @Test
    public void testAddRelationship() {
        Leaf src = new Leaf("abc");
        Leaf target = new Leaf("def");
        assert (board.getIRelationshipManager().addRelationship(src, target).size() > 0);
    }
}
