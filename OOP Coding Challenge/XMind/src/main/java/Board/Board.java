package Board;

import Builder.RootBuilder;
import Content.Root;
import Relationship.IRelationshipManager;
import Setting.ViewType;


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
                .addContent("Node.Root")
                .addLevel(0)
                .addColor("Black")
                .addChildren("Content 1", "Content 2", "Content 3", "Content 4")
                .build();
    }

    public Board(String title) {
        this.root = new RootBuilder().addContent("Node.Root")
                .addLevel(0)
                .addColor("Black").build();
        this.title = title;
        this.theme = "New Theme";
        this.globalFont = "Arial";
        this.background = "White";
        this.zoomLevel = 90;
    }

    public Board(String theme, String background, String globalFont, int zoomLevel, String title, ViewType viewType, IBoardSerialize boardSerializer, IRelationshipManager relationshipManager) {
        this();
        this.theme = theme;
        this.background = background;
        this.globalFont = globalFont;
        this.zoomLevel = zoomLevel;
        this.title = title;
        this.viewType = viewType;
        this.iBoardSerialize = boardSerializer;
        this.iRelationshipManager = relationshipManager;
    }

    public IRelationshipManager getIRelationshipManager() {
        return iRelationshipManager;
    }

    public void setIRelationshipManager(IRelationshipManager iRelationshipManager) {
        this.iRelationshipManager = iRelationshipManager;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public String getGlobalFont() {
        return globalFont;
    }

    public void setGlobalFont(String globalFont) {
        this.globalFont = globalFont;
    }

    public int getZoomLevel() {
        return zoomLevel;
    }

    public void setZoomLevel(int zoomLevel) {
        this.zoomLevel = zoomLevel;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public ViewType getViewType() {
        return viewType;
    }

    public void setViewType(ViewType viewType) {
        this.viewType = viewType;
    }

    public Root getRoot() {
        return root;
    }

    public void setRoot(Root root) {
        this.root = root;
    }

    public IBoardSerialize getIBoardSerialize() {
        return iBoardSerialize;
    }

    public void setIBoardSerialize(IBoardSerialize iBoardSerialize) {
        this.iBoardSerialize = iBoardSerialize;
    }


}
