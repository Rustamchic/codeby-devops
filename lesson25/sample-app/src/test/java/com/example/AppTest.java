package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppTest {
    @Test
    void sum_works() {
        assertEquals(5, App.sum(2, 3));
    }
}
