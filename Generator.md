

## Overview

The generator is responsible for creating transactions and supplying stimulus to the verification environment.

It represents the starting point of the verification flow. Instead of manually driving interface signals, the generator creates high-level transaction objects and distributes them to the appropriate drivers.

---

# Purpose

The generator performs three primary tasks:

* Creates transaction objects
* Randomizes transaction fields
* Sends transactions to the write and read drivers through mailboxes

---

# Generator Architecture

```text
                Generator
                    │
        ┌───────────┴───────────┐
        │                       │
        ▼                       ▼
 Write Driver Mailbox      Read Driver Mailbox
        │                       │
        ▼                       ▼
   Write Driver           Read Driver
```

The generator communicates with both drivers independently, allowing read and write operations to be coordinated during simulation.

---

# Transaction Creation

At the beginning of the run task, a transaction object is created.

```systemverilog
txn = new();
```

This object holds all information required for a memory operation.

---

# Stimulus Generation

The generator creates five transactions.

```systemverilog
repeat(5)
```

Each transaction is randomized using inline constraints.

```systemverilog
write_addr == 7
read_addr  == 7
write_data == 99
```

Although constrained randomization is used, these constraints force fixed values. As a result, this acts as a directed test intended to verify a specific read/write scenario.

---

# Transaction Distribution

After randomization, copies of the transaction are created.

One copy is sent to the write driver.

The second copy is sent to the read driver.

```text
Transaction
      │
      ├────────► Write Driver
      │
      └────────► Read Driver
```

Using separate transaction objects prevents unintended modifications when multiple verification components process the same stimulus.

---

# Mailboxes

Two mailboxes are used for communication.

| Mailbox | Destination  |
| ------- | ------------ |
| `mbx1`  | Write Driver |
| `mbx2`  | Read Driver  |

Mailboxes provide synchronized communication between the generator and drivers while preserving transaction order.

---

# Verification Scenario

This generator repeatedly performs the following sequence:

1. Generate a transaction.
2. Write the value **99** to memory address **7**.
3. Request a read from memory address **7**.
4. Send the transaction to both drivers.
5. Repeat the process five times.

This directed stimulus verifies that data written to memory can be read back correctly from the same address.

---

# Summary

The generator serves as the source of stimulus for the verification environment. By producing transaction objects and distributing them through mailboxes, it separates stimulus creation from signal-level driving, resulting in a modular and reusable verification architecture.
