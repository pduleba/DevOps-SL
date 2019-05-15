package com.pduleba.webapp.mapper.order;

import com.pduleba.webapp.bo.order.OrderEntity;
import com.pduleba.webapp.dao.order.OrderRepository;
import com.pduleba.webapp.dto.order.Order;
import lombok.AllArgsConstructor;
import org.mapstruct.ObjectFactory;
import org.mapstruct.TargetType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.persistence.EntityNotFoundException;
import java.util.Optional;

@Component
@AllArgsConstructor(onConstructor = @__({@Autowired}))
public class OrderFactory {

    protected OrderRepository orderRepository;

    @ObjectFactory
    protected Order toDto() {
        return Order.builder().build();
    }

    @ObjectFactory
    protected OrderEntity fromDto(Order dto, @TargetType Class<OrderEntity> type) {
        Optional<Integer> id = Optional.ofNullable(Optional.ofNullable(dto).orElse(Order.builder().build()).getId());
        OrderEntity result = OrderEntity.builder().build();

        if (id.isPresent()) {
            result = orderRepository.findById(id.get())
                    .orElseThrow(() -> new EntityNotFoundException(String.format("Entity %d not found", id.get())));
        }

        return result;
    }
}
