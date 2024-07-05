package dependency;

import relationship.Relationship;

import java.util.List;

public interface IRelationshipManager {
    void removeRelationship(Relationship relationship);

    List<Relationship> addRelationship(String src, String target);

    List<Relationship> getRelationships();


}
