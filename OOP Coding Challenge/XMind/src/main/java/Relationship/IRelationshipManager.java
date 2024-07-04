package Relationship;

import Content.Node;

import java.util.List;

public interface IRelationshipManager {
    void removeRelationship(Relationship relationship);

    List<Relationship> addRelationship(Node src, Node target);

    List<Relationship> getRelationships();

//    void setRelationships(List<Relationship> relationships);
}
