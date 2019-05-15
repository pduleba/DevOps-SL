package com.pduleba.webapp.controller.rest.it;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pduleba.webapp.Application;
import com.pduleba.webapp.dto.order.Order;
import com.pduleba.webapp.dto.util.RestResponse;
import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.Arrays;
import java.util.List;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
// Start whole context (not web layer only like using @WebMvcTest)
@AutoConfigureMockMvc
// As a result if will do @Import({ApplicationConfig.class}) --- Create web application context
@SpringBootTest(
        webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
        classes = Application.class
)
@TestPropertySource(locations = "classpath:application.yml")
// Control context caching during tests execution (clear for each test execution complete)
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class RDSControllerTest {

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

    @Test
    public void When_findAll_Expect_notEmptyListOfOrders() throws Exception {

        // given
        List<Order> orders = Arrays.asList(order);
        final int EXPECTED_ORDERS_SIZE = 3;

        // when
        MvcResult mvcResult = mockMvc
                .perform(MockMvcRequestBuilders
                        .get("/api/rds/findAll")
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
        TestCase.assertEquals(EXPECTED_ORDERS_SIZE, response.getBody().size());
    }


    @Test
    public void When_save_Expect_orderWithId() throws Exception {

        // given

        // when
        MvcResult mvcResult = mockMvc
                .perform(MockMvcRequestBuilders
                        .put("/api/rds/save")
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
        TestCase.assertEquals(order, response.getBody());
    }
}
