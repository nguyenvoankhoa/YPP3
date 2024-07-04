package Content;

import java.util.List;

public class Root extends Node {

    public Root() {
    }

    public Root(String content, int level, List<Node> children) {
        super(content, level, children);
    }
}
