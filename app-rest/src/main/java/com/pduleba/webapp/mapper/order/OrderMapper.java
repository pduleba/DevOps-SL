package com.pduleba.webapp.mapper.order;

import com.pduleba.webapp.bo.order.OrderEntity;
import com.pduleba.webapp.dto.order.Order;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring", uses = OrderFactory.class)
public interface OrderMapper {

    Order toDto(OrderEntity bo);

    default
    List<Order> toDto(List<OrderEntity> bos) {
        return Optional.ofNullable(bos)
                .orElse(Collections.emptyList())
                .stream()
                .map(bo -> toDto(bo))
                .collect(Collectors.toList());
    }

    @Mapping(target = "path", ignore = true)
    OrderEntity fromDto(Order dto);

    default
    List<OrderEntity> fromDto(List<Order> dtos) {
        return Optional.ofNullable(dtos)
                .orElse(Collections.emptyList())
                .stream()
                .map(dto -> fromDto(dto))
                .collect(Collectors.toList());
    }
}
