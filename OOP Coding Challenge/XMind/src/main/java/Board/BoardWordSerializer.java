package board;

import dependency.IBoardSerialize;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;

public class BoardWordSerializer implements IBoardSerialize {
    @Override
    public boolean saveMindMap(Board board, String filepath) {
        try (XWPFDocument document = new XWPFDocument()) {
            XWPFParagraph titleParagraph = document.createParagraph();
            XWPFRun titleRun = titleParagraph.createRun();
            titleRun.setText("Board Details");
            titleRun.setBold(true);
            titleRun.setFontSize(20);
            Field[] fields = Board.class.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                XWPFParagraph paragraph = document.createParagraph();
                XWPFRun run = paragraph.createRun();
                run.setText(field.getName() + ": " + field.get(board));
            }
            try (FileOutputStream out = new FileOutputStream(filepath)) {
                document.write(out);
                return true;
            }
        } catch (IOException | IllegalAccessException e) {
            e.printStackTrace();
        }
        return false;
    }
}
