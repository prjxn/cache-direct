# Direct-Mapped Cache System

A streamlined Verilog implementation of a **direct-mapped cache**, developed during a Makeathon. The design models a simple memory hierarchy with a dual-edge timing strategy: cache writes occur on the **negedge** of the clock, while reads and tag operations use the **posedge**. This system was built and tested for a **Cyclone IV E FPGA (50 MHz)**.

## Architecture Overview

- **Main Memory (`main_mem`)**  
  64-byte synchronous memory serving as the backing store.

- **Cache Memory (`cache_mem`)**  
  8-line direct-mapped cache implementing split-edge read/write behavior.

- **Tag Memory (`tag_mem`)**  
  Stores tag bits and valid flags for cache-line identification and hit detection.

- **Controller (`direct_cmem`)**  
  Manages address splitting, hit/miss evaluation, and line refills on cache misses.

**NOTE:** Quartus Prime infers a **negated clock** for the negedge write path in `cache_mem`. This is an unintended synthesis artifact resulting from the dual-edge design and is not the desired hardware implementation.

This project serves as a compact reference for understanding cache behavior, timing interactions, and memory hierarchy design on FPGA platforms.
