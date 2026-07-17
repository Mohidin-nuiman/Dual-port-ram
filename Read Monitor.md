

## Overview

The read monitor is a passive verification component responsible for observing completed read operations on the RAM interface.

It captures the read address and the data returned by the DUT, packages the information into a transaction object, and forwards the observed transaction to the verification components responsible for checking correctness.

Unlike the drivers, the read monitor never controls DUT signals.

---

# Purpose

The read monitor performs the following functions:

* Observes read operations on the interface
* Detects valid read transactions
* Samples the read address
* Samples the data returned by the DUT
* Creates transaction objects
* Sends copies of the transaction to both the scoreboard and the reference model

---

# Communication Flow

```text
                 Dual Port RAM
                       │
                       ▼
                Read Interface
                       │
                       ▼
                 Read Monitor
                  /         \
                 /           \
                ▼             ▼
          Scoreboard   Reference Model
```

The read monitor acts as a bridge between the DUT and the verification components.

---

# Virtual Interface

```systemverilog
virtual ram_if.read_mon vif;
```

The monitor accesses the DUT signals through the read monitor interface.

Using a virtual interface allows the monitor to remain independent of the DUT hierarchy.

---

# Detecting a Read Operation

The monitor waits until the read enable signal becomes active.

```systemverilog
wait(vif.r_mon_cb.read_en);
```

Only valid read transactions are captured.

This prevents idle bus values from being interpreted as memory accesses.

---

# Sampling Signals

When a valid read occurs, the monitor samples:

| Signal      | Description                   |
| ----------- | ----------------------------- |
| `read_addr` | Address requested from memory |
| `read_data` | Data returned by the DUT      |

These values represent the actual response produced by the RAM.

---

# Transaction Duplication

After sampling the interface, the monitor creates independent copies of the observed transaction.

One copy is forwarded to the scoreboard.

The second copy is forwarded to the reference model.

This allows multiple verification components to process the same observation independently without modifying shared data.

---

# Mailbox Communication

```text
Read Monitor
      │
      ├────────► Scoreboard
      │
      └────────► Reference Model
```

Using separate mailboxes improves modularity and allows each verification component to operate independently.

---

# Advantages

* Completely passive implementation
* Captures actual DUT responses
* Separates observation from checking
* Supports multiple consumers through transaction duplication
* Easily extendable for additional analysis components

---

# Summary

The read monitor observes completed memory read operations, captures the address and returned data, and distributes independent transaction copies to the scoreboard and the reference model. This organization keeps the verification environment modular and enables independent checking of the DUT's behavior.
