@post @ci @local
Feature: Bootstrap
    Scenario: Re-run bootstrap
        Given bootstrap was run once
        When we run bootstrap a second time
        Then the Kubernetes API is available
