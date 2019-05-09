package com.pduleba.webapp.service;

import com.pduleba.webapp.bo.order.OrderEntity;
import com.pduleba.webapp.dao.order.OrderRepository;
import com.pduleba.webapp.dto.order.Order;
import com.pduleba.webapp.mapper.order.OrderMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor(onConstructor = @__(@Autowired))
public class OrderService {

    private OrderMapper orderMapper;
    private OrderRepository orderRepository;

    public List<Order> findAll() {
        return orderMapper.toDto(orderRepository.findAll());
    }

    public Optional<Order> findById(Integer orderId) {
        Optional<OrderEntity> orderEntity = orderRepository.findById(orderId);

        return Optional.ofNullable(orderMapper.toDto(orderEntity.orElse(null)));
    }

    public Order save(Order order) {
        return orderMapper.toDto(orderRepository.save(orderMapper.fromDto(order)));
    }

    public Optional<Order> delete(Integer orderId) {
        Optional<OrderEntity> orderEntity = orderRepository.findById(orderId);

        if (orderEntity.isPresent()) {
            orderRepository.delete(orderEntity.get());
        }

        return Optional.ofNullable(orderMapper.toDto(orderEntity.orElse(null)));
    }
}
