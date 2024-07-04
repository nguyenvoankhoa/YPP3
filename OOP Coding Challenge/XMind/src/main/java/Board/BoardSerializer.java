package Board;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.FileReader;
import java.io.FileWriter;

public class BoardSerializer implements IBoardSerialize{
    private Gson gson;

    public BoardSerializer() {
        gson = new GsonBuilder().setPrettyPrinting().create();
    }

    public boolean saveMindMap(Board board, String filepath) {
        try (FileWriter fileWriter = new FileWriter(filepath)) {
            gson.toJson(board, fileWriter);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }


    public Board importMindMap(String filePath) {
        Board board = null;
        try (FileReader reader = new FileReader(filePath)) {
            Board jsonData = gson.fromJson(reader, Board.class);
            board = new Board(jsonData.getTitle());
            board.setRoot(jsonData.getRoot());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return board;
    }
}
