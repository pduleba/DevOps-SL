package com.pduleba.webapp.controller.rest.ut;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pduleba.webapp.controller.rest.OrderController;
import com.pduleba.webapp.dto.order.Order;
import com.pduleba.webapp.dto.util.RestResponse;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import com.pduleba.webapp.service.OrderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.Arrays;
import java.util.List;

import static junit.framework.TestCase.assertEquals;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
// Start web layer only (not whole context like using @AutoConfigureMockMvc)
@WebMvcTest(OrderController.class)
// It is easier to inject some beans then mocking it via @MockBean
@ComponentScan(basePackageClasses = {HateoasMapper.class})
// Control context caching during tests execution (clear after all tests execution complete)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
public class OrderControllerTest {

    private final Order order = Order
            .builder()
            .id(1)
            .name("Duck")
            .amount(100)
            .build();

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private OrderService orderService;
    @Autowired
    private HateoasMapper hateoasMapper;

    @Test
    public void When_findAll_Expect_notEmptyListOfOrders() throws Exception {

        // given
        List<Order> orders = Arrays.asList(order);
        when(orderService.findAll()).thenReturn(orders);

        // when
        MvcResult mvcResult = mockMvc
                .perform(MockMvcRequestBuilders
                        .get("/api/order/findAll")
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_JSON)
                        .characterEncoding("UTF-8"))
                .andExpect(status().isOk())
                .andReturn();
        RestResponse<List<Order>> response = objectMapper.readValue(mvcResult
                .getResponse()
                .getContentAsString(), new TypeReference<RestResponse<List<Order>>>() {
        });

        // then
        verify(orderService).findAll();
        assertEquals(orders.size(), response.getBody().size());
    }

    @Test
    public void When_save_Expect_orderWithId() throws Exception {

        // given
        when(orderService.save(order)).thenReturn(order);

        // when
        MvcResult mvcResult = mockMvc
                .perform(MockMvcRequestBuilders
                        .put("/api/order/save")
                        .content(objectMapper.writeValueAsString(order))
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_JSON)
                        .characterEncoding("UTF-8"))
                .andExpect(status().isOk())
                .andReturn();
        RestResponse<Order> response = objectMapper.readValue(mvcResult
                .getResponse()
                .getContentAsString(), new TypeReference<RestResponse<Order>>() {
        });

        // then
        verify(orderService).save(eq(order));
        assertEquals(order, response.getBody());
    }
}
