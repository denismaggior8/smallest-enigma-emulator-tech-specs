# Technical Specifications: Guinness World Record Attempt

## Record Title
**"The smallest, computationally autonomous Enigma machine emulator, capable of decrypting original 1945-era Enigma ciphertexts when provided with correct key settings."**

---

## Guinness World Records Application Details
*   **Application Reference Number:** `[Insert GWR Application ID]`
*   **Applicant Name:** `[Your Name / Team Name]`
*   **Date of Attempt:** `[Insert Date]`
*   **Location of Attempt:** `[City, Country]`

---

## 1. Executive Summary
This repository serves as the official Technical Specifications/Implementations document for a Guinness World Records attempt. The objective is to design, deploy, and verify the smallest possible self-contained Enigma machine emulator (hardware + software) that accurately replicates the cryptographic functions of a legitimate World War II Enigma machine (such as the M3 or M4) and can successfully decrypt historical ciphertexts.

## 2. Claim Definition & Scope
To ensure strict adherence to the record title, the following terms are technically defined:

*   **Smallest**: The record is defined by the **Physical Hardware Footprint** (The physical dimensions of the self-contained hardware emulator)
*   **Computationally Autonomous**: All encryption and decryption operations MUST be executed entirely on the physical device itself, without offloading any computation or relying on network calls. However, given the intentionally constrained hardware memory, the emulator is not required to buffer an entire message simultaneously; rather, the external client is permitted to stream lengthy payloads to the device iteratively in discrete batches.
*   **Enigma Machine Emulator**: The system must cryptographically mirror the behavior of the historical machine, explicitly handling:
    *   Rotor wiring and stepping (including double-stepping anomalies).
    *   Rotor settings (*Grundstellung* + *Ringstellung*).
    *   Reflector (*Umkehrwalze*).
    *   Plugboard (*Steckerbrett*).
*   **Original 1945-era Ciphertexts**: The emulator must be validated against known, historically accurate messages, provided with correct key settings.


## 3. Technical Constraints & Design Rules
In pursuit of the absolute minimal size, the following technical constraints apply to the implementation:
1.  **Input/Output**: The system must provide a deterministic way to input the key settings (Rotor selection, Ring settings, Plugboard connections, initial positions) and the ciphertext, and output the plaintext.
2.  **No Pre-computed Tables**: The emulator cannot use massive pre-computed look-up tables to bypass the algorithmic implementation of the Enigma machine, as this violates the spirit of "emulation."
3.  **Language**: The specific programming language (e.g., Python, C, Assembly) will be selected based on its capacity for lexical minimalism or binary footprint. 

## 4. Architecture & Implementation

*   **Physical Hardware Footprint**: 23.5 × 18 mm
    <br><img src="https://www.waveshare.com/w/upload/f/f4/900px-RP2040-Zero-details-size.jpg" alt="RP2040-Zero Physical Dimensions Diagram" width="500">
*   **Enigma Machine Models Implemented**: M3 / M4
*   **Firmware Dependencies & Architecture**:
    The system execution is driven by **MicroPython v1.26.1** runtime and two custom-built, highly optimized application libraries developed by the claimant:
    1.  **[enigma-core (v1.0.1)](https://github.com/denismaggior8/enigma-core)**: The top-level firmware responsible for device boot, user interaction, logic orchestration, and accepting/persisting machine configurations.
    2.  **[enigma-python (v3.1.2)](https://github.com/denismaggior8/enigma-python)** MicroPython-specific implementation that serves as the cryptographic engine, allowing the Enigma logic to execute autonomously.

### Size Comparison

To contextualize the "smallest" claim, the table below compares the physical dimensions of this project against other well-known historical and hardware-based Enigma implementations.

| Implementation | Type | Physical Footprint | Hardware Platform |
| :--- | :--- | :--- | :--- |
| **Historical Enigma M4** | Electromechanical | ~ 340 × 280 × 150 mm (12 kg) | N/A |
| **Enigma-E** (Crypto Museum) | Electronic DIY Kit | ~ 220 × 160 mm (PCB only) | Custom Microcontroller |
| **Arduino Enigma Simulator** | Touchscreen Emulator | ~ 100 × 70 × 30 mm | Arduino Mega |
| **PicoEnigma** | Pocket Emulator | ~ 100 × 100 × 20 mm | Raspberry Pi Pico |
| **This Project** | **Embedded Autonomous Emulator** | **23.5 × 18 mm** | **RP2040-Zero** |

## 5. Measurement Methodology
To satisfy the strict requirements of the "smallest" claim, the physical hardware footprint must be meticulously measured and documented.
*   **Measurement Instrument:** `[e.g., Calibrated Digital Calipers, Model XYZ]`
*   **Methodology:** The dimensions are measured at the widest and longest points of the main printed circuit board (PCB), excluding any removable peripheral jumper wires used temporarily for I/O.
*   **Photographic Evidence:** `[Insert link/reference to high-resolution photos showing the calipers reading the exact dimensions of the board]`

## 6. Independent Witnesses
GWR requires independent specialist witnesses to verify both the physical measurements and the cryptographic accuracy of the device. The signed statements from the following experts are included in the Evidence Inventory:
*   **Witness 1:** `[Insert Name]`, `[Insert Title/Expertise, e.g., Professor of Computer Science / Cryptography Expert]`
*   **Witness 2:** `[Insert Name]`, `[Insert Title/Expertise, e.g., Senior Electrical Engineer]`

## 7. Verification Methodology
To satisfy Guinness World Records adjudicators, the definitive proof of cryptographic accuracy is that the hardware emulator must be capable of successfully deciphering **any original, historically documented WWII Enigma plaintext/ciphertext pair** (often referred to as "broken messages"). Furthermore, to explicitly validate the reciprocal nature of the cipher, the emulator must be capable of subsequently re-encrypting the resulting plaintext directly back into the exact original ciphertext.

To facilitate adjudication, this repository provides the following,   reproducible,  **[Verification Kits](./tests)**:

- [`verify_p1030700.sh`](./tests/verify_p1030700.sh) based on the famous U-534 M4 interception preserved by the [Hoerenberg Enigma M4 Project](https://enigma.hoerenberg.com/index.php?cat=The%20U534%20messages&page=P1030700). This shell script automatically dispatches the exact authentic historical ring settings, rotor topology, and plugboard connections directly into the emulator over serial via `enigma-core` AT commands, before streaming the 1940s ciphertext to visually demonstrate the translation into the original German plaintext.

*Note: While the Verification Kit utilizes/provides some well known M4 message for immediate proof, the emulator is strictly **not** limited to these specific examples. It is a functionally complete replica capable of encrypting or decrypting any authentic M3/M4 Enigma configuration.*

## 8. Evidence Inventory
To formally support the record claim, this repository contains the following indexed exhibits:

*   **Exhibit A: Cover Letter & Application Summary** 
    *   `[Link to Cover Letter PDF]`
*   **Exhibit B: Unbroken Video Evidence** 
    *   *Requirement:* A continuous, unedited physical camera recording showing the hardware board, the measurement process, and the real-time decryption output on the monitor simultaneously.
    *   `[Link to Raw Video File]`
*   **Exhibit C: Photographic Evidence**
    *   High-resolution images of the board and the measurement process.
    *   `[Link to Photo Directory]`
*   **Exhibit D: System Logs & Terminal Casts**
    *   The raw, unedited standard output logs (`.log` files) and interactive terminal recordings (`.cast` files) documenting the exact AT commands, decryption streams, and reverse-encryption processes.
    *   *(See Verification Kits table below)*
*   **Exhibit E: Witness Statements**
    *   Signed declarations from the independent witnesses.
    *   `[Link to Witness Statements PDF]`
*   **Exhibit F: Source Code & Firmware**
    *   [enigma-core v1.0.1](https://github.com/denismaggior8/enigma-core/releases/tag/v1.0.1)
        *   **Board Firmware**: [`enigma-core_firmware_v1.0.1_RPI_PICO.uf2`](https://github.com/denismaggior8/enigma-core/releases/download/v1.0.1/enigma-core_firmware_v1.0.1_RPI_PICO.uf2) (SHA256: `791bf4c142088071c10815574e90e70b8020713cc935afbc9a3e3f105b71db0d`)
    *   [enigma-python v3.1.2](https://github.com/denismaggior8/enigma-python/releases/tag/v3.1.2)

### Verification Kits (Part of Exhibit D)
In the following table, we summarize the Verification Kits provided in this repository, detailing their execution commands, completion status, output logs, and native video recordings:



| Verification Script | Verification Command | Execution Status | Output Log | Terminal Recording |
| :--- | :--- | :---: | :--- | :--- |
| [`verify_p1030700.sh`](./tests/verify_p1030700.sh) | `asciinema rec -q -c "./tests/verify_p1030700.sh" recs/rec_p1030700.cast --overwrite \| tee logs/verify_p1030700.log` | ✅ VERIFIED | [`verify_p1030700.log`](./logs/verify_p1030700.log) | [`rec_p1030700.cast`](./recs/rec_p1030700.cast) |

*Note: The **Video Demonstrations** have been recorded using [asciinema](https://asciinema.org/) to faithfully capture standard output directly from the hardware execution. You can seamlessly replay any `.cast` file linked above by running `asciinema play <file.cast>` in your terminal (e.g., `asciinema play recs/rec_p1030700.cast`).*

## 9. Supersession Criteria

To officially supersede this record, a competing implementation must demonstrate a strictly smaller physical footprint than the benchmark established here, while maintaining full historical cryptographic accuracy and computational autonomy.

---
*Maintained for Guinness World Record Adjudication.*
