package com.example.helloworld;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppTest {
    @Test
    void message_is_expected() {
        assertEquals("Hello World!", App.message());
    }
}
