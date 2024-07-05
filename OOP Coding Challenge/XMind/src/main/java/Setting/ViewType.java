package setting;

public enum ViewType {
    SIXTEEN_BY_FOUR("16:4"),
    THREE_BY_FOUR("3:4");
    private final String ratio;

    ViewType(String ratio) {
        this.ratio = ratio;
    }

    public String getRatio() {
        return ratio;
    }
}
