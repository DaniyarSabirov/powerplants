package de.thws.powerplants.infrastructure;

import io.quarkus.runtime.Quarkus;
import io.quarkus.runtime.annotations.QuarkusMain;

@QuarkusMain
public class Program {

    public static void main(String[] args) {
        Quarkus.run(args);
    }
}
