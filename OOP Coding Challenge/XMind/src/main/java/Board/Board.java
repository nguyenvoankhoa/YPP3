package board;

import builder.RootBuilder;
import content.Root;
import dependency.IBoardSerialize;
import dependency.IFloatContentManager;
import dependency.IRelationshipManager;
import floatcontent.FloatContent;
import setting.ViewType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board {
    private String theme;
    private String background;
    private String globalFont;
    private int zoomLevel;
    private String title;
    private ViewType viewType;

    private Root root;

    private IRelationshipManager iRelationshipManager;

    private IBoardSerialize iBoardSerialize;

    private IFloatContentManager iFloatContentManager;


    public Board() {
        this.root = new RootBuilder()
                .addId("Root")
                .addContent("Node.Root")
                .addLevel(0)
                .addColor("Black")
                .addChildren("Content 1", "Content 2", "Content 3", "Content 4")
                .build();
        this.title = "Hello";
        this.theme = "New Theme";
        this.globalFont = "Arial";
        this.background = "White";
        this.zoomLevel = 90;
        this.viewType = ViewType.THREE_BY_FOUR;
    }

    public Board(IRelationshipManager iRelationshipManager, IBoardSerialize iBoardSerialize, IFloatContentManager iFloatContentManager) {
        this();
        this.iRelationshipManager = iRelationshipManager;
        this.iBoardSerialize = iBoardSerialize;
        this.iFloatContentManager = iFloatContentManager;
    }
}
