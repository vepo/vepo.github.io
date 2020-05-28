---
title: "5G Network Functions"
description: ""
tags: [5G]
series: 5G
layout: default
comments: true
published: false
---

# Introdutory Glossary

* **SBI**: Service Based Interface
* **NRF**: Network Function Repository
* **SMF**: Session Management Function
* **AMF**: Access and Mobility Management Function

# Principles and Guidelines for Services Definition

_Defined on **3GPP TS 29.501**_

5GC SBI API specifications should apply a protocol design framework as follows:

1. REST-style service operations should implement the Level 2 of the Richardson maturity model, with standard HTTP methods, whenever it is a good match for the style of interaction to model, e.g. service operations that can naturally map to one of the standard methods (CRUD operations), this should be the preferred modelling attempt;
2. service operations may use custom API operations (RPC-style interaction), when it is seen a better fit for the style of interaction to model, e.g. non-CRUD service operations;
3. it is possible to mix REST-style operations and RPC-style operations in the same API.

**NOTE**: Level 3 (HATEOAS) of the Richardson maturity model in the 5G Service-Based Architecture can be implemented by an API but is optional. Hypermedia usage guidelines are provided in clause 4.7 of the present specification.


# NRF: Network Function Repository

_Defined on **3GPP TS 29.510**_

The Network Function (NF) Repository Function (NRF) is the network entity in the 5G Core Network (5GC) supporting the following functionality:
* Maintains the NF profile of available NF instances and their supported services;
* Allows other NF instances to subscribe to, and get notified about, the registration in NRF of new NF instances of a given type;
* Supports service discovery function. It receives NF Discovery Requests from NF instances, and provides the information of the available NF instances fulfilling certain criteria (e.g., supporting a given service).


# PCF: Policy Control Function

_Defined on **3GPP TS 29.512**_

The PCF is responsible for policy control decisions and flow based chargin controls functionalities. The PCF provides the following:

* policies for application and service data flow detection, gating, QoS, flow based charging, traffic steering

        control, access traffic steering, switching and steering within a MA PDU Session, access network information
        report and RAN support information to the SMF.

## Rules

PCF is based on rules. Rule isa set of policy information elements associated with a PDU Session. There are two types of rules:

* Session rule
* PCC rule
