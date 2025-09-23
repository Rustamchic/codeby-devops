package com.example.hellodevops;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppTest {
    @Test
    void message_is_expected() {
        assertEquals("Hello Devops!", App.message());
    }
}
