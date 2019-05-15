package com.pduleba.webapp.controller.rest;

import com.pduleba.webapp.dto.order.Order;
import com.pduleba.webapp.dto.util.RestResponse;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import com.pduleba.webapp.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@RestController
@RequestMapping("/api/rds")
public class RDSController extends AbstractController<RDSController> {

    private OrderService orderService;

    @Autowired
    public RDSController(OrderService orderService, HateoasMapper hateoasMapper) {
        super(methodOn(RDSController.class), hateoasMapper);
        this.orderService = orderService;
    }

    @GetMapping("/findAll")
    public RestResponse<List<Order>> findAll() {
        List<Order> orders = orderService.findAll();
        return hateoasMapper.toResource(orders, resource.findAll());
    }

    @GetMapping("/findById/{orderId}")
    public RestResponse<Order> findById(@PathVariable("orderId") Integer orderId) {
        Optional<Order> order = orderService.findById(orderId);
        return hateoasMapper.toResource(order.orElse(null), resource.findById(orderId));
    }

    @PutMapping("/save")
    public RestResponse<Order> save(@Valid @RequestBody Order dto) {
        Order order = orderService.save(dto);
        return hateoasMapper.toResource(order, resource.save(order));
    }

    @DeleteMapping("/delete/{orderId}")
    public RestResponse<Order> delete(@PathVariable("orderId") Integer orderId) {
        Optional<Order> order = orderService.delete(orderId);
        return hateoasMapper.toResource(order.orElse(null), resource.delete(orderId));
    }
}
