import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.lang.reflect.Type;
import java.util.*;

public class Board {
    private String theme;
    private String background;
    private String globalFont;
    private int zoomLevel;
    private String title;
    private ViewType viewType;

    private Root root;

    private List<Relationship> relationships;


    public Board() {
        this.root = new RootBuilder()
                .addContent("Root")
                .addLevel(0)
                .addColor("Black")
                .addChildren("Content 1", "Content 2", "Content 3", "Content 4")
                .build();
        relationships = new ArrayList<>();
    }

    public Board(String title) {
        this.root = new RootBuilder().addContent("Root")
                .addLevel(0)
                .addColor("Black").build();
        this.title = title;
        this.theme = "New Theme";
        this.globalFont = "Arial";
        this.background = "White";
        this.zoomLevel = 90;
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

    public List<Relationship> getRelationships() {
        return relationships;
    }

    public void setRelationships(List<Relationship> relationships) {
        this.relationships = relationships;
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
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try (FileWriter fileWriter = new FileWriter(filepath)) {
            gson.toJson(board, fileWriter);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public Board importMindmap(String filePath) {
        Board board = null;
        try (FileReader reader = new FileReader(filePath)) {
            Gson gson = new Gson();
            Board mindmap = gson.fromJson(reader, Board.class);
            board = new Board(mindmap.title);
            board.setRoot(mindmap.root);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return board;
    }

}
