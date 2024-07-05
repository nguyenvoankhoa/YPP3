package board;

import dependency.IBoardSerialize;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class BoardPNGSerializer implements IBoardSerialize {
    @Override
    public boolean saveMindMap(Board board, String filepath) {
        int width = 400;
        int height = 200;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = image.createGraphics();
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, width, height);
        g2d.setColor(Color.BLACK);
        g2d.setFont(new Font("Arial", Font.BOLD, 16));
        int x = 50;
        int y = 100;
        g2d.drawString(board.toString(), x, y);
        g2d.dispose();
        File output = new File(filepath);
        try {
            ImageIO.write(image, "PNG", output);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}
