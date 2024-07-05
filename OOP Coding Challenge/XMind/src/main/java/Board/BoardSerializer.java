package board;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dependency.IBoardSerialize;

import java.io.FileReader;
import java.io.FileWriter;

public class BoardSerializer implements IBoardSerialize {
    private Gson gson;

    public BoardSerializer() {
        this.gson = new GsonBuilder()
                .setPrettyPrinting()
                .create();
    }

    @Override
    public boolean saveMindMap(Board board, String filepath) {
        try (FileWriter fileWriter = new FileWriter(filepath)) {
//            gson.toJson(board, fileWriter);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public Board importMindMap(String filePath) {
        Board board = null;
        try (FileReader reader = new FileReader(filePath)) {
            board = new Board();
//            board = gson.fromJson(reader, Board.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return board;
    }

}
