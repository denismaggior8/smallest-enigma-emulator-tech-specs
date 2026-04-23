# Technical Specifications: Guinness World Record Attempt

## Record Title
**"The smallest, documented, computationally autonomous Enigma machine emulator running on embedded hardware, capable of decrypting original 1945-era Enigma ciphertexts when provided with correct key settings."**

---

## 1. Executive Summary
This repository serves as the official Technical Specifications/Implementations document for a Guinness World Records attempt. The objective is to design, deploy, and verify the smallest possible self-contained Enigma machine emulator (hardware + software) that accurately replicates the cryptographic functions of a legitimate World War II Enigma machine (such as the M3 or M4) and can successfully decrypt historical ciphertexts.

## 2. Claim Definition & Scope
To ensure strict adherence to the record title, the following terms are technically defined:

*   **Smallest**: The record is defined by three primary dimensions of miniaturization:
    *   **Physical Hardware Footprint**: The physical dimensions of the self-contained hardware emulator
    *   **Software/Firmware Size**: The total compiled software payload footprint
    *   **Computational Resources**: The strict hardware constraints imposed on the system, specifically concerning CPU capability, volatile memory (RAM), and non-volatile storage (ROM/File System)
*   **Documented**: Every physical and software aspect of the record-attempting device is exhaustively documented to ensure it is fully reproducible, challengeable, and verifiable by independent adjudicators.
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
*   **Total firmware size in KB (UF2), including runtime and frozen modules**: 771 KB
*   **Computational Resources**:
    *   **HW Model**: WaveShare RP2040-Zero
    *   **CPU**: Dual-core ARM Cortex-M0+ processor (flexible clock up to 133 MHz)
    *   **RAM**: 264KB of SRAM for execution
    *   **ROM/File System**: 2MB of on-board Flash memory for firmware and logic payloads
*   **Enigma Machine Models Implemented**: M3 / M4
*   **Firmware Dependencies & Architecture**:
    The system execution is driven by **MicroPython v1.26.1** runtime and two custom-built, highly optimized application libraries developed by the claimant:
    1.  **[enigma-core (v1.0.1)](https://github.com/denismaggior8/enigma-core)**: The top-level firmware responsible for device boot, user interaction, logic orchestration, and accepting/persisting machine configurations.
    2.  **[enigma-python (v3.1.2)](https://github.com/denismaggior8/enigma-python)** MicroPython-specific implementation that serves as the cryptographic engine, allowing the Enigma logic to execute autonomously.

## 5. Verification Methodology
To satisfy Guinness World Records adjudicators, the definitive proof of cryptographic accuracy is that the hardware emulator must be capable of successfully deciphering **any original, historically documented WWII Enigma plaintext/ciphertext pair** (often referred to as "broken messages"). Furthermore, to explicitly validate the reciprocal nature of the cipher, the emulator must be capable of subsequently re-encrypting the resulting plaintext directly back into the exact original ciphertext.

To facilitate adjudication, this repository provides the following,   reproducible,  **[Verification Kits](./tests)**:

- [`verify_p1030700.sh`](./tests/verify_p1030700.sh) based on the famous U-534 M4 interception preserved by the [Hoerenberg Enigma M4 Project](https://enigma.hoerenberg.com/index.php?cat=The%20U534%20messages&page=P1030700). This shell script automatically dispatches the exact authentic historical ring settings, rotor topology, and plugboard connections directly into the emulator over serial via `enigma-core` AT commands, before streaming the 1940s ciphertext to visually demonstrate the translation into the original German plaintext.

*Note: While the Verification Kit utilizes/provides some well known M4 message for immediate proof, the emulator is strictly **not** limited to these specific examples. It is a functionally complete replica capable of encrypting or decrypting any authentic M3/M4 Enigma configuration.*

## 6. Evidence Collection
To support the record claim, this repository will eventually contain:
1.  **Firmware and Libraries Source Code**: A reference to the source codes of all the employed software parts (firmware + enigma libraries), available at:
    - [enigma-core v1.0.1](https://github.com/denismaggior8/enigma-core/releases/tag/v1.0.1)
        - **Board Firmware**: [`enigma-core_firmware_v1.0.1_RPI_PICO.uf2`](https://github.com/denismaggior8/enigma-core/releases/download/v1.0.1/enigma-core_firmware_v1.0.1_RPI_PICO.uf2) (SHA256: `791bf4c142088071c10815574e90e70b8020713cc935afbc9a3e3f105b71db0d`)
    - [enigma-python v3.1.2](https://github.com/denismaggior8/enigma-python/releases/tag/v3.1.2)
2.  **Video Demonstration**: Raw, unedited footage of the verification and the test vector decryption run.
3.  **[Log Files](./logs)**: This repository explicitly contains the raw, unedited standard output logs (`.log` files) produced by every Verification Kit script execution. These files permanently document the exact, real-time AT commands, decryption streams, and reverse-encryption processes as well as the test status.

In the following table, we summarize the Verification Kits provided in this repository, detailing their execution commands, completion status, output logs, and native video recordings:



| Verification Script | Verification Command | Execution Status | Output Log | Video |
| :--- | :--- | :---: | :--- | :--- |
| [`verify_p1030700.sh`](./tests/verify_p1030700.sh) | `asciinema rec -q -c "./tests/verify_p1030700.sh" video/video_p1030700.cast --overwrite \| tee logs/verify_p1030700.log` | ✅ VERIFIED | [`verify_p1030700.log`](./logs/verify_p1030700.log) | [`video_p1030700.cast`](./video/video_p1030700.cast) |

*Note: The **Video Demonstrations** have been recorded using [asciinema](https://asciinema.org/) to faithfully capture standard output directly from the hardware execution. You can seamlessly replay any `.cast` file linked above by running `asciinema play <file.cast>` in your terminal (e.g., `asciinema play video/video_p1030700.cast`).*

## 7. Supersession Criteria

To officially supersede this record, a competing implementation must equal or improve upon *all three* primary dimensions of miniaturization, demonstrating a strictly smaller footprint in **at least one** dimension while not exceeding the benchmarks established here in the others.

---
*Maintained for Guinness World Record Adjudication.*
