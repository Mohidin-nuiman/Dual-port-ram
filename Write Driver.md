

## Overview

The write driver converts high-level write transactions into signal-level activity that can be applied to the RAM.

It acts as the bridge between the transaction-based verification environment and the pin-level DUT interface.

---

# Purpose

The write driver performs the following tasks:

* Receives write transactions from the generator
* Drives write control signals through the interface
* Synchronizes all signal activity with the system clock
* Implements the write protocol expected by the DUT

---

# Communication Flow

```text
Generator
      │
      ▼
Mailbox
      │
      ▼
Write Driver
      │
      ▼
Interface
      │
      ▼
Dual Port RAM
```

The generator produces transactions, while the write driver converts them into actual hardware signals.

---

# Receiving Transactions

The driver continuously waits for new write transactions.

```systemverilog
mbx1.get(t1);
```

The mailbox blocks until a transaction becomes available, ensuring that transactions are processed in the same order they were generated.

---

# Virtual Interface

```systemverilog
virtual ram_if.write_drv vif;
```

The virtual interface provides access to the DUT signals through the interface.

Using a virtual interface keeps the driver independent of the top-level testbench, improving modularity and reusability.

---

# Driving Signals

The driver performs a write operation by controlling three interface signals:

| Signal       | Purpose                            |
| ------------ | ---------------------------------- |
| `write_en`   | Enables the write operation        |
| `write_addr` | Selects the target memory location |
| `write_data` | Specifies the data to store        |

All signals are driven through the interface clocking block.

---

# Synchronization

The driver uses the write driver clocking block:

```systemverilog
@(vif.w_drv_cb)
```

This synchronizes all signal activity with the positive edge of the clock while avoiding race conditions with the DUT.

---

# Write Sequence

The driver follows this sequence for each transaction:

```text
Receive Transaction
        │
        ▼
Assert write_en
        │
        ▼
Wait for clock cycles
        │
        ▼
Drive address and data
        │
        ▼
Wait for clock cycles
        │
        ▼
Deassert write_en
```

This timing ensures that write requests are applied in a controlled and repeatable manner during simulation.

---

# Advantages

* Separates transaction processing from signal driving
* Uses synchronized clocking blocks
* Modular and reusable design
* Communicates through mailboxes for clean component interaction

---

# Summary

The write driver is responsible for translating abstract write transactions into synchronized interface activity. By driving the write enable, address, and data signals through the virtual interface, it enables the verification environment to interact with the RAM in a structured and modular way.
