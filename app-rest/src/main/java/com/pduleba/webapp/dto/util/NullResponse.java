package com.pduleba.webapp.dto.util;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NullResponse {

    @Builder.Default
    private String message = "Execution complete";
}
