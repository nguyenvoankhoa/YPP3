package board;

import builder.RootBuilder;
import content.Root;
import dependency.IBoardSerialize;
import dependency.IRelationshipManager;
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

    public Board(IRelationshipManager iRelationshipManager, IBoardSerialize iBoardSerialize) {
        this();
        this.iRelationshipManager = iRelationshipManager;
        this.iBoardSerialize = iBoardSerialize;
    }

    @Override
    public String toString() {
        return "Board{" +
                "theme='" + theme + '\'' +
                ", background='" + background + '\'' +
                ", globalFont='" + globalFont + '\'' +
                ", zoomLevel=" + zoomLevel +
                ", title='" + title + '\'' +
                ", viewType=" + viewType +
                ", root=" + root +
                ", iRelationshipManager=" + iRelationshipManager +
                ", iBoardSerialize=" + iBoardSerialize +
                '}';
    }
}
