

## Overview

The test is the top-level controller of the verification environment.

Its primary responsibility is to create the verification environment, provide the required virtual interfaces, and start the verification process.

Unlike the generator, drivers, monitors, or scoreboard, the test does not directly interact with the DUT. Instead, it coordinates the execution of all verification components.

---

# Purpose

The test performs three main tasks:

* Receives the virtual interfaces from the top-level testbench.
* Creates the verification environment.
* Starts the verification flow.

---

# Test Architecture

```text
                Top Module
                     │
                     ▼
                  Test
                     │
                     ▼
              Verification
               Environment
                     │
      ┌──────────────┼──────────────┐
      ▼              ▼              ▼
 Generator       Drivers       Monitors
                     │
                     ▼
                Dual Port RAM
                     │
                     ▼
          Reference Model
                     │
                     ▼
                Scoreboard
```

The test acts as the entry point to the complete verification environment.

---

# Virtual Interfaces

The test receives four virtual interfaces:

| Interface   | Purpose                 |
| ----------- | ----------------------- |
| `write_drv` | Write driver interface  |
| `read_drv`  | Read driver interface   |
| `write_mon` | Write monitor interface |
| `read_mon`  | Read monitor interface  |

These interfaces are forwarded to the environment, allowing each verification component to communicate with the DUT through the appropriate modport.

---

# Environment Creation

During construction, the test creates an instance of the verification environment.

```systemverilog
env = new(vif1, vif2, vif3, vif4);
```

The environment is responsible for creating and connecting all lower-level verification components.

---

# Verification Flow

The test starts verification in two steps:

```systemverilog
env.build();
env.run();
```

* **Build Phase:** Creates and connects all verification components.
* **Run Phase:** Starts the generator, drivers, monitors, reference model, and scoreboard.

Separating construction from execution improves readability and mirrors the phased execution style commonly used in modern verification methodologies.

---

# Overall Execution Flow

```text
Top Module
     │
     ▼
Test
     │
     ▼
Environment
     │
     ▼
Generator
     │
     ▼
Drivers
     │
     ▼
Dual Port RAM
     │
     ▼
Monitors
     │
     ▼
Reference Model
     │
     ▼
Scoreboard
```

The test initiates the complete verification process but delegates all detailed functionality to the environment and its components.

---

# Summary

The `ram_test` class serves as the top-level controller of the custom SystemVerilog verification environment. By constructing the environment and invoking its build and run tasks, it provides a simple and organized entry point for executing the complete verification flow.
