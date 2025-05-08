package de.thws.powerplants.core.mappers;

import de.thws.powerplants.adapters.in.api.json.JsonGroup;
import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import de.thws.powerplants.core.domain.Group;

public class GroupMapper {

    public static Group toGroupDTO(JsonGroup jsonGroup) {
        Group group = new Group();

        group.setPublicName(jsonGroup.getPublicName());
        group.setDescription(jsonGroup.getDescription());
        group.setPictureUrl(jsonGroup.getPictureUrl());

        return group;
    }

    public static JsonGroup toJsonGroup(GroupEntity groupEntity) {
        JsonGroup jsonGroup = new JsonGroup();

        jsonGroup.setId(groupEntity.getId());
        jsonGroup.setPublicName(groupEntity.getPublicName());
        jsonGroup.setDescription(groupEntity.getDescription());
        jsonGroup.setPictureUrl(groupEntity.getPictureUrl());

        return jsonGroup;
    }
}
