package com.pduleba.webapp.dto.order;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Order {

    private Integer id;
    @NotEmpty(message = "Name is required")
    private String name;
    @Min(value = 0, message = "Amount must be greater or equal 0")
    @NotNull(message = "Amount is required")
    private Integer amount;

}
