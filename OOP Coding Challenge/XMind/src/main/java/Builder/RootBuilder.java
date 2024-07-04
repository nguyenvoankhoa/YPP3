package Builder;

import Content.Root;

public class RootBuilder extends GenericBuilder<RootBuilder> {
    @Override
    protected RootBuilder self() {
        return this;
    }

    public Root build() {
        return new Root(content, level, children);
    }
}
