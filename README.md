# Introduction

This repo provides example subscription structures and access control functions.

# Subscriptions

We might think of a subscription as the configuration of a tenant within a certain business function.  Every access to MINDAInfo functions requires that a subscription exists.

Subscriptions are a method of collecting:

+ `capabilities`
+ `resources`
+ `subjects`


Subscriptions are functionally equivalent to `Identity Service` `activities` and `Team Service` `teams`.  There are structural differences:

+ `capabilities` replace `activities`.  `capabilities` are a more abstract business definition of the services offered within a `subscription`.  They should be more stable than an `activity` and more understandable to the business.

# Access Control Decisions

The decision types supported are as follows:

+ Does the current subject (user) have access to the `subscription`
+ Does the `subscription` have access to the capability

# Running the Tests

The structures are tested by defining a dummy service that will utilise the test structures to perform access control decisions.

To run the tests:

```
rspec
```
