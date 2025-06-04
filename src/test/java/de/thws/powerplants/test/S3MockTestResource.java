package de.thws.powerplants.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.adobe.testing.s3mock.S3MockApplication;
import io.quarkus.test.common.QuarkusTestResourceLifecycleManager;

// todo this is ultra heavyweight, we need an better alternative
public class S3MockTestResource implements QuarkusTestResourceLifecycleManager {

    private S3MockApplication s3MockApplication;

    @Override
    public Map<String, String> start() {

        s3MockApplication = S3MockApplication.start(props());

        Map<String, String> config = new HashMap<>();
        config.put("s3.endpoint", "http://localhost:" + s3MockApplication.getHttpPort());
        return config;
    }

    @Override
    public void stop() {
        if (s3MockApplication != null) {
            s3MockApplication.stop();
        }
    }

    private Map<String, Object> props() {
        Map<String, Object> args = new HashMap<>();
        args.put(S3MockApplication.PROP_HTTP_PORT, "0");
        args.put(S3MockApplication.PROP_INITIAL_BUCKETS, List.of("images"));
        return args;
    }
}
