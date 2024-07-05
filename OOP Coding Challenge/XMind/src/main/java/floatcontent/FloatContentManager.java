package floatcontent;

import dependency.IFloatContentManager;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class FloatContentManager implements IFloatContentManager {
    List<FloatContent> floatContentList;

    public FloatContentManager() {
        floatContentList = new ArrayList<>();
    }

    public List<FloatContent> addContent(FloatContent floatContent) {
        getFloatContentList().add(floatContent);
        return getFloatContentList();
    }

    public void removeContent(String contentId) {
        getFloatContentList().removeIf(c -> c.getId().equals(contentId));
    }
}
