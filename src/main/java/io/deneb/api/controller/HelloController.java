package io.deneb.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
        return """
            Hello, Date: %s
            """.formatted(LocalDateTime.now());
    }

}
