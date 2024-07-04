package Board;

public interface IBoardSerialize {
    boolean saveMindMap(Board board, String filepath);
    Board importMindMap(String filePath);
}
