import board.Board;
import board.BoardSerializer;
import builder.LeafBuilder;
import dependency.IBoardSerialize;
import dependency.IRelationshipManager;
import floatcontent.FloatContent;
import content.Leaf;
import content.Position;
import content.Root;
import floatcontent.FloatContentManager;
import dependency.IFloatContentManager;
import relationship.Relationship;
import relationship.RelationshipManager;
import setting.Structure;
import setting.ViewType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class XMindApplicationTests {
    Board board;
    Root root;

    @BeforeEach
    public void setUp() {
        IBoardSerialize boardSerializer = new BoardSerializer();
        IRelationshipManager relationshipManager = new RelationshipManager();
        IFloatContentManager floatContentManager = new FloatContentManager();
        board = new Board(relationshipManager, boardSerializer, floatContentManager);
        root = board.getRoot();
    }

    @Test
    void testAddChildren() {
        Leaf leaf = new LeafBuilder().addContent("Leaf 1").addParent(root).build();
        int beforeAddSize = root.getChildren().size();
        root.addChild(leaf);
        int afterAddSize = root.getChildren().size();
        assertEquals(beforeAddSize + 1, afterAddSize);
    }

    @Test
    void testRemoveChildren() {
        Leaf leaf = new LeafBuilder().addId("abc").addContent("Leaf 1").addParent(root).build();
        root.addChild(leaf);
        int beforeRemoveSize = root.getChildren().size();
        root.removeChild(leaf.getId());
        int afterRemoveSize = root.getChildren().size();
        assertEquals(beforeRemoveSize - 1, afterRemoveSize);
    }

    @Test
    void testCollapse() {
        root.collapse();
        assertEquals(root.isOpen(), false);
    }

    @Test
    void testExpand() {
        root.expand();
        assertEquals(root.isOpen(), true);
    }

    @Test
    void testLeafMove() {
        Leaf leaf = new LeafBuilder().addId("abc").addContent("Leaf 1").addParent(root).build();
        Leaf leaf1 = new LeafBuilder().addPosition(new Position(4, 5)).addId("def").addContent("Leaf 2").addParent(root).build();
        root.addChild(leaf);
        root.addChild(leaf1);
        leaf.move(new Position(5, 6), leaf.getId(), root, board.getIFloatContentManager());
        assertEquals(leaf.getParent().getId(), (leaf1.getId()));
    }

    @Test
    void testFloatContentMove(){
        FloatContent floatContent = new FloatContent("1", "Content 1");
        floatContent.setPosition(new Position(2, 3));
        board.getIFloatContentManager().addContent(floatContent);
        Position newPosition = new Position(100, 200);
        floatContent.move(newPosition, "1", root);
        assertEquals(floatContent.getPosition(), newPosition);

    }

    @Test
    void testEditContent() {
        root.setContent("New Content");
        assert (root.getContent().equals("New Content"));
    }

    @Test
    void testRemoveAll() {
        root.removeAll();
        assertEquals(root.getChildren(), null);
    }


    @Test
    void testAdjustZoomLevel() {
        board.setZoomLevel(100);
        assert (board.getZoomLevel() == 100);
    }

    @Test
    void testAdjustViewport() {
        board.setViewType(ViewType.THREE_BY_FOUR);
        assertEquals(board.getViewType(), ViewType.THREE_BY_FOUR);
    }


    @Test
    void testRemoveRelationship() {
        Leaf src = new Leaf("abc", "Node 1");
        Leaf target = new Leaf("def", "Node 2");
        root.addChild(src);
        root.addChild(target);
        board.getIRelationshipManager().addRelationship("abc", "def");
        Relationship relationship = board.getIRelationshipManager().getRelationships().get(0);
        int relaBefore = board.getIRelationshipManager().getRelationships().size();
        board.getIRelationshipManager().removeRelationship(relationship);
        int relaAfter = board.getIRelationshipManager().getRelationships().size();
        assert (relaBefore - 1 == relaAfter);
    }

    @Test
    void testAddRelationship() {
        Leaf src = new Leaf("abc", "Node 1");
        Leaf target = new Leaf("def", "Node 2");
        root.addChild(src);
        root.addChild(target);
        assert (board.getIRelationshipManager().addRelationship("abc", "def").size() > 0);
    }

    @Test
    void testStructure() {
        root.setStructure(Structure.FISH_BONE);
        assertEquals(root.getStructure(), Structure.FISH_BONE);
    }

    @Test
    void testAddFloatContent() {
        FloatContent floatContent = new FloatContent("abc", "Content 1");
        board.getIFloatContentManager().addContent(floatContent);
        assertEquals(board.getIFloatContentManager().getFloatContentList().size(), 1);
    }

    @Test
    void testRemoveFloatContent() {
        FloatContent floatContent = new FloatContent("abc", "Content 1");
        board.getIFloatContentManager().addContent(floatContent);
        board.getIFloatContentManager().removeContent("abc");
        assertEquals(board.getIFloatContentManager().getFloatContentList().size(), 0);
    }

    @Test
    void testSave() {
        board.getIRelationshipManager().addRelationship("abc", "def");
        String filepath = "src/main/resources/test.json";
        assert (board.getIBoardSerialize().saveMindMap(board, filepath));
    }

    @Test
    void testImport() {
        String filepath = "src/main/resources/test.json";
        assert (board.getIBoardSerialize().importMindMap(filepath) != null);
    }

}
