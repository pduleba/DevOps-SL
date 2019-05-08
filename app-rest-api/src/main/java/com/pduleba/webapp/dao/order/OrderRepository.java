package com.pduleba.webapp.dao.order;

import com.pduleba.webapp.bo.order.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository <OrderEntity, Integer> {
}
