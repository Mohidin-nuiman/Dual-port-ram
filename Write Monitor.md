
## Overview

The write monitor is a passive verification component that observes write operations on the RAM interface.

Unlike the driver, the monitor never controls DUT signals. Its responsibility is to capture completed write transactions and forward them to the scoreboard for verification.

---

# Purpose

The write monitor performs the following tasks:

* Observes write activity on the interface
* Detects valid write transactions
* Samples the write address and write data
* Packages the observed information into a transaction object
* Sends the transaction to the scoreboard through a mailbox

---

# Communication Flow

```text
Dual Port RAM
      │
      ▼
Write Interface
      │
      ▼
Write Monitor
      │
      ▼
Mailbox
      │
      ▼
Scoreboard
```

The monitor acts as an observer, collecting information without affecting DUT behavior.

---

# Virtual Interface

```systemverilog
virtual ram_if.write_mon vif;
```

The monitor accesses the DUT signals through the interface using the write monitor modport.

This keeps the monitor independent of the DUT hierarchy and improves reusability.

---

# Detecting a Write Operation

The monitor waits until the write enable signal becomes active.

```systemverilog
wait(vif.w_mon_cb.write_en);
```

Only after a valid write request is detected does the monitor capture the transaction information.

This prevents idle interface values from being interpreted as valid memory operations.

---

# Sampling Signals

When a write operation is detected, the monitor samples:

| Signal       | Description                   |
| ------------ | ----------------------------- |
| `write_addr` | Memory location being written |
| `write_data` | Data stored into memory       |

These sampled values represent the actual activity occurring on the interface.

---

# Creating a Transaction

After sampling the interface, the monitor creates a copy of the observed transaction.

The copied transaction is then sent through a mailbox to the scoreboard.

This allows the scoreboard to process the information independently without modifying the monitor's local data.

---

# Mailbox Communication

```text
Write Monitor
      │
      ▼
Mailbox
      │
      ▼
Scoreboard
```

The mailbox provides synchronized communication between the monitor and the scoreboard while preserving the order of observed transactions.

---

# Advantages

* Completely passive operation
* Does not influence DUT behavior
* Captures real interface activity
* Modular and reusable implementation
* Clean separation between observation and checking

---

# Summary

The write monitor observes completed write operations on the RAM interface, converts them into transaction objects, and forwards them to the scoreboard. By passively monitoring interface activity, it enables the verification environment to compare the DUT's behavior against the expected results without interfering with normal operation.
