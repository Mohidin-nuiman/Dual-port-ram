# Dual Port RAM using SystemVerilog

A parameterized **Simple Dual Port RAM** designed in **SystemVerilog** along with a custom object-oriented verification environment. This project demonstrates the complete verification flow, from transaction generation to functional checking using a reference model and scoreboard.

---

# Project Overview

This project implements a synthesizable **Simple Dual Port RAM (SDP RAM)** with:

* Independent Read and Write Ports
* Parameterized Address Width
* Parameterized Data Width
* Synchronous Read
* Synchronous Write
* Custom layered SystemVerilog verification environment
* Reference Model for expected data generation
* Scoreboard-based functional checking

The objective of this repository is not only to implement a Dual Port RAM but also to demonstrate how a structured verification environment can be built using object-oriented SystemVerilog concepts.

---

# Features

* ✔ Parameterized memory depth and data width
* ✔ Synthesizable RTL
* ✔ Separate Read and Write interfaces
* ✔ Synchronous Read
* ✔ Synchronous Write
* ✔ Layered verification architecture
* ✔ Transaction-based stimulus generation
* ✔ Mailbox-based communication
* ✔ Passive monitors
* ✔ Reference model (Golden Model)
* ✔ Functional scoreboard
* ✔ Easy-to-understand project structure

---

# Dual Port RAM Architecture


                    +---------------------------+
                    |      Dual Port RAM        |
                    |                           |
 Write Enable ----->|                           |
 Write Address ---->|                           |
 Write Data ------->|                           |
                    |       Memory Array        |
 Read Enable -----> |                           |
 Read Address ----->|                           |
                    |                           |
 Read Data <---------                           |
                    +---------------------------+
```

This implementation is a Simple Dual Port RAM, where:

* One dedicated port performs write operations.
* One dedicated port performs read operations.
* Both ports share the same clock.

---



# Verification Components

| Component       | Description                          |
| --------------- | ------------------------------------ |
| Transaction     | Represents a RAM operation           |
| Generator       | Generates test transactions          |
| Write Driver    | Drives write interface signals       |
| Read Driver     | Drives read interface signals        |
| Write Monitor   | Observes write operations            |
| Read Monitor    | Observes read operations             |
| Reference Model | Predicts expected RAM behavior       |
| Scoreboard      | Compares expected and actual data    |
| Environment     | Connects all verification components |
| Test            | Starts the verification environment  |

---

# RTL Specifications

| Parameter      | Default                |
| -------------- | ---------------------- |
| Address Width  | 8 bits                 |
| Data Width     | 32 bits                |
| Memory Depth   | 256 Locations          |
| Total Capacity | 8192 bits (1024 Bytes) |

---

# Supported Operations

* Write Operation
* Read Operation
* Simultaneous Read and Write
* Parameterized Memory Configuration


# Project Directory

```text
dual-port-ram/
│
├── rtl/
│   └── dual_port_ram.sv
│
├── tb/
│   ├── interface.sv
│   ├── transaction.sv
│   ├── generator.sv
│   ├── write_driver.sv
│   ├── read_driver.sv
│   ├── write_monitor.sv
│   ├── read_monitor.sv
│   ├── reference_model.sv
│   ├── scoreboard.sv
│   ├── environment.sv
│   ├── test.sv
│   └── top.sv
│
├── docs/
│
└── README.md
```

---

# Learning Objectives

This project demonstrates:

* Parameterized RTL design
* Memory architecture
* Object-oriented SystemVerilog
* Layered verification methodology
* Mailbox-based communication
* Virtual interfaces
* Clocking blocks
* Monitors and Drivers
* Reference model implementation
* Functional checking using a scoreboard

---

# Future Improvements

Possible extensions include:

* Randomized test scenarios
* Functional coverage
* Assertions (SVA)
* True Dual Port RAM
* Byte-enable support
* Multiple clocks
* ECC support
* UVM-based verification environment
* Burst transactions
* Regression testing

---

# Simulation

The verification environment performs the following sequence:

1. Generate memory transactions.
2. Drive write and read operations.
3. Capture DUT activity.
4. Predict expected results using the reference model.
5. Compare DUT output with expected values.
6. Report PASS or FAIL for every transaction.

---

# Requirements

* SystemVerilog-compatible simulator (QuestaSim, ModelSim, VCS, Xcelium, EDA Playground etc.)

---

# Author
Mohidin Nuiman

Digital Design & Verification Engineer

---

# License

This project is open source and available under the MIT License.


