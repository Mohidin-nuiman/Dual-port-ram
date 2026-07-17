
## Overview

This project implements a **parameterized synchronous Dual Port RAM** using SystemVerilog. The design supports one dedicated write port and one dedicated read port, allowing read and write operations to occur independently using the same clock.

The memory size is configurable through parameters, making the design reusable for different applications without modifying the source code.

---

# Design Specifications

| Feature         | Description          |
| --------------- | -------------------- |
| Language        | SystemVerilog        |
| RAM Type        | Simple Dual Port RAM |
| Read Operation  | Synchronous          |
| Write Operation | Synchronous          |
| Clock           | Single Clock         |
| Data Width      | Parameterized        |
| Address Width   | Parameterized        |
| Memory Depth    | 2^ADDR_WIDTH         |

---



# Module Declaration

```systemverilog
module dual_port_ram #(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 32)
```

The module uses parameters so that the same RTL can implement memories of different sizes.

### Parameters

### ADDR_WIDTH

Determines the number of address bits.

Memory Depth = 2^ADDR_WIDTH

Example:

* ADDR_WIDTH = 8
* Memory Depth = 256 locations

---

### DATA_WIDTH

Determines how many bits are stored in each memory location.

Example:

* DATA_WIDTH = 32

Each address stores 32 bits.

---

# Port Description

## Clock

```systemverilog
input logic clk;
```

All read and write operations occur on the positive edge of the clock.

---

## Write Interface

### write_en

Enables a write operation.

When high, the input data is stored into the specified memory location on the next rising clock edge.

---

### write_addr

Specifies which memory location will be written.

---

### write_data

Contains the data that will be stored in memory.

---

## Read Interface

### read_en

Enables the read operation.

---

### read_addr

Specifies which memory location will be read.

---

### read_data

Outputs the data stored at the requested address.

Since this is a synchronous RAM, the value appears after the active clock edge when `read_en` is asserted.

---

# Internal Memory

```systemverilog
logic [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];
```

The memory is declared as an array of registers.

For the default parameters:

* Address Width = 8
* Data Width = 32

the memory contains:

* 256 memory locations
* each location stores 32 bits

Total memory capacity:

256 × 32 = 8192 bits (1024 Bytes)

---

# Write Operation

```systemverilog
always_ff @(posedge clk)
```

Whenever the clock rises,

if `write_en` is asserted,

the incoming data is stored into the selected memory location.

```systemverilog
mem[write_addr] <= write_data;
```

The non-blocking assignment ensures proper sequential behavior and synthesizes correctly into hardware.

---

# Read Operation

The RAM implements **synchronous read**.

```systemverilog
always_ff @(posedge clk)
```

When `read_en` is asserted,

the data stored at `read_addr` is copied to the output register.

```systemverilog
read_data <= mem[read_addr];
```

Unlike asynchronous RAM, the output changes only after a clock edge.

This makes timing predictable and matches the behavior of FPGA block RAMs and many ASIC memory macros.

---

# Simultaneous Read and Write

The design contains independent read and write ports.

Therefore,

* writing and reading can occur during the same clock cycle,
* provided the appropriate enable signals are asserted.

When both operations target different addresses, they execute independently.

If both ports access the same address in the same clock cycle, the observed read value depends on the target technology's read-during-write behavior and synthesis implementation. This implementation does not explicitly define that behavior.

---

# Advantages of This Design

* Fully synthesizable
* Parameterized and reusable
* Simple architecture
* FPGA friendly
* Easy to integrate into larger digital systems
* Suitable for learning memory design concepts

---

# Limitations

* Single clock only
* One write port and one read port (Simple Dual Port RAM)
* No reset for memory contents
* No byte-enable support
* No error correction (ECC)
* Read-during-write to the same address is not explicitly defined

---

# Summary

This RTL implements a configurable synchronous Simple Dual Port RAM with separate read and write ports. The design emphasizes simplicity, portability, and synthesizability, making it a strong foundation for learning memory design and for building a complete UVM verification environment.
