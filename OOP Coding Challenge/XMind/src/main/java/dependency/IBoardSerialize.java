package dependency;

import board.Board;

public interface IBoardSerialize {
    boolean saveMindMap(Board board, String filepath);
//    Board importMindMap(String filePath);
}
