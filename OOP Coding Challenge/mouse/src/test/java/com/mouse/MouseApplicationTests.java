package com.mouse;

import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import java.util.ArrayList;
import java.util.List;


@SpringBootTest
class MouseApplicationTests {


	@Test
	void contextLoads() {
		Mouse mouse = new Mouse();
		Light light = new Light("Logitech", "black", 100, null);
		mouse.light.add(light);
		mouse.scroll = new Scroll();
		Button left = new Button("Left",
				new Shape(
						new Point(0,0,0), true, "black", new Line("black", 0)));
		Button right = new Button("Right",
				new Shape(
						new Point(0,0,0), true, "black", new Line("black", 0)));
		Button next = new Button("Next",
				new Shape(
						new Point(0,0,0), true, "black", new Line("black", 0)));
		Button back = new Button("Back",
				new Shape(
						new Point(0,0,0), true, "black", new Line("black", 0)));
		mouse.buttons.add(left);
		mouse.buttons.add(right);
		mouse.buttons.add(next);
		mouse.buttons.add(back);
        Sensor sensor = new Sensor();
		mouse.sensor = sensor.generateRandomValue(2000, 1000);
		mouse.x = mouse.sensor.currentX;
		mouse.y = mouse.sensor.currentY;
		for(Button btn : mouse.buttons){
			if(btn.type == mouse.sensor.action){
				btn.doAction(mouse.x, mouse.y);
			}
		}
		if(mouse.sensor.action.contains("Scroll")){
			mouse.scroll.type = mouse.sensor.action;
			mouse.scroll.doAction(mouse.x, mouse.y);
		}


	}
	public interface EventTrigger{
		void doAction(int x, int y);
	}


	public class Mouse {
		public List<Light> light = new ArrayList<>();
		public List<Button> buttons= new ArrayList<>();
		public Scroll scroll;
		public String value;
		public Sensor sensor;
		public int x;
		public int y;
	}

	public class Light {
		public String name;
		public String color;
		public int opacity;
		public Shape shape;

		public Light(String name, String color, int opacity, Shape shape) {
			this.name = name;
			this.color = color;
			this.opacity = opacity;
			this.shape = shape;
		}
	}
	public class Shape{
		public Point point;
		public boolean fill;
		public String color;
		public Line line;

		public Shape(Point point, boolean fill, String color, Line line) {
			this.point = point;
			this.fill = fill;
			this.color = color;
			this.line = line;
		}
	}
	public class Point{
		int x;
		int y;
		int z;

		public Point(int x, int y, int z) {
			this.x = x;
			this.y = y;
			this.z = z;
		}

	}
	public class Line{
		public String color;
		public int width;

		public Line(String color, int width) {
			this.color = color;
			this.width = width;
		}
	}
	public class Button implements EventTrigger{
		public String type;
		public Shape shape;

		public Position position;

		public Button(String type, Shape shape) {
			this.type = type;
			this.shape = shape;
		}

		@Override
		public void doAction(int x, int y) {
			position = new Position(x, y);
			if(type == "Left"){
				System.out.println("click at "+position.toString());

			} else if (type == "Right") {
				System.out.println("open menu at "+position.toString());
			} else if (type == "Next") {
				System.out.println("next page");
			} else if (type == "Back") {
				System.out.println("Back page");
			}
			else{
				System.out.println("Not supported type");
			}
		}
	}
	public class Scroll implements EventTrigger{
		public String type;
		public int length = 200;
		public Position position;
		@Override
		public void doAction(int x, int y) {
			position = new Position(x, y);
			if(type.contains("Up")){
				System.out.println("Scroll up");
				position.x -= length;
			}else if(type.contains("Down")){
				System.out.println("Scroll down");
				position.x += length;
			}
		}
	}
	public class Position {
		public int x;
		public int y;
		public Position (int x, int y){
			this.x = x;
			this.y = y;
		}

		@Override
		public String toString() {
			return "position{" +
					"x=" + x +
					", y=" + y +
					'}';
		}
	}

}
