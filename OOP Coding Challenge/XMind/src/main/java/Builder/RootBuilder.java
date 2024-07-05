package builder;

import content.Root;

public class RootBuilder extends GenericBuilder<RootBuilder> {
    @Override
    protected RootBuilder self() {
        return this;
    }

    public Root build() {
        return new Root(id, content, children);
    }
}
