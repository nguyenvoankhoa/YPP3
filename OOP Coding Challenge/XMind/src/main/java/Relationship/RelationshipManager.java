package Relationship;

import Content.Node;

import java.util.List;
import java.util.ArrayList;

public class RelationshipManager implements IRelationshipManager{
    private List<Relationship> relationships;

    public RelationshipManager() {
        this.relationships = new ArrayList<>();
    }

    public List<Relationship> getRelationships() {
        return relationships;
    }

    public void setRelationships(List<Relationship> relationships) {
        this.relationships = relationships;
    }

    public void removeRelationship(Relationship relationship) {
        relationships.stream()
                .filter(r -> r.getSourceNode().equals(relationship.getSourceNode()) && r.getTargetNode().equals(relationship.getTargetNode()))
                .findFirst()
                .ifPresent(r -> {
                    relationships.remove(r);
                });
    }

    public List<Relationship> addRelationship(Node src, Node target) {
        relationships.add(new Relationship(src, target));
        return this.relationships;
    }
}
