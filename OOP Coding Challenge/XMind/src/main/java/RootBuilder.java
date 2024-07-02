
public class RootBuilder extends GenericBuilder<RootBuilder> {
    public Root build() {
        return new Root(content, level, children);
    }
}
