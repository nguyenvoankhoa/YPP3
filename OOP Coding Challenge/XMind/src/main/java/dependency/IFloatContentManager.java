package dependency;

import floatcontent.FloatContent;

import java.util.List;

public interface IFloatContentManager {
    List<FloatContent> addContent(FloatContent floatContent);

    void removeContent(String contentId);

    List<FloatContent> getFloatContentList();
}
