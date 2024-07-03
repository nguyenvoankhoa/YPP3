public class Board {
    private String theme;
    private String background;
    private String globalFont;
    private int zoomLevel;
    private String title;
    private ViewType viewType;

    private Root root;

    public Board() {
        this.root = new RootBuilder()
                .addContent("Root")
                .addLevel(0)
                .addColor("Black")
                .addChildren("Content 1", "Content 2", "Content 3", "Content 4")
                .build();
    }

    public Board(String theme, String background, String globalFont, int zoomLevel, String title, ViewType viewType) {
        this();
        this.theme = theme;
        this.background = background;
        this.globalFont = globalFont;
        this.zoomLevel = zoomLevel;
        this.title = title;
        this.viewType = viewType;
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

    public boolean saveMindmap(Board board, String filepath) {
        return true;
    }
}
