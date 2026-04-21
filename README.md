# Technical Specifications: Guinness World Record Attempt

## Record Title
**"The smallest, documented, computationally autonomous Enigma machine emulator, capable of decrypting original 1945-era Enigma ciphertexts when provided with correct key settings."**

---

## 1. Executive Summary
This repository serves as the official Technical Specifications document for a Guinness World Records attempt. The objective is to design, deploy, and verify the smallest possible self-contained Enigma machine emulator (hardware + software) that accurately replicates the cryptographic functions of a legitimate World War II Enigma machine (such as the M3 or M4) and can successfully decrypt historical ciphertexts.

## 2. Claim Definition & Scope
To ensure strict adherence to the record title, the following terms are technically defined:

*   **Smallest**: The record is defined by two primary metrics of miniaturization:
    *   **Physical Hardware Footprint**: The physical dimensions of the self-contained hardware emulator
    *   **Software/Firmware Size**: The total compiled software payload footprint
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

*   **Target Language / Firmware**: MicroPython
*   **Hardware**: WaveShare RP2040-Zero
*   **Physical Footprint**: 23.5 × 18 mm
    <br><img src="https://www.waveshare.com/w/upload/f/f4/900px-RP2040-Zero-details-size.jpg" alt="RP2040-Zero Physical Dimensions Diagram" width="500">
*   **Software Size**: 410 KB
*   **Machine Target**: M3 / M4
*   **Firmware Dependencies & Architecture**:
    The system execution is driven by two custom-built, highly optimized libraries developed by the claimant:
    1.  **[enigma-core (v1.0.1)](https://github.com/denismaggior8/enigma-core)**: The top-level firmware responsible for device boot, user interaction, logic orchestration, and accepting/persisting machine configurations.
    2.  **[micropython-enigma-python (v3.1.2)](https://github.com/denismaggior8/micropython-enigma-python)**: The **[enigma-python (v3.1.2)](https://github.com/denismaggior8/enigma-python)** MicroPython-specific implementation that serves as the cryptographic engine, allowing the Enigma logic to execute autonomously.

## 5. Verification Methodology
To satisfy Guinness World Records adjudicators, the following verification steps will be strictly documented:

### 5.1 Cryptographic Verification
The definitive proof of mathematical and cryptographic accuracy is that the hardware emulator must be capable of successfully deciphering **any original, historically documented WWII Enigma plaintext/ciphertext pair** (often referred to as "broken messages").

To facilitate adjudication, this repository provides a reproducible **Verification Kit** (`verify_p1030700.sh`) based on the famous U-534 M4 interception preserved by the [Hoerenberg Enigma M4 Project](https://enigma.hoerenberg.com/index.php?cat=The%20U534%20messages&page=P1030700). This shell script automatically dispatches the exact authentic historical ring settings, rotor topology, and plugboard connections directly into the emulator over serial via `enigma-core` AT commands, before streaming the 1940s ciphertext to visually demonstrate the translation into the original German plaintext.

> **Status:** ✅ VERIFIED. The emulator hardware logic perfectly computes the sequence identically to mathematical emulation standards, securely accounting for physical edge-cases (like double stepping) naturally on the MicroPython hardware.

*Note: While the Verification Kit utilizes the Hoerenberg M4 message for immediate proof, the emulator is strictly **not** limited to these specific examples. It is a functionally complete replica capable of encrypting or decrypting any authentic WWII Enigma configuration.*

## 6. Evidence Collection
To support the record claim, this repository will eventually contain:
1.  **Source Code**: The raw, minimized code.
2.  **Un-minified Equivalent**: A readable version mapping exactly to the minimized version to satisfy the "documented" requirement.
3.  **Video Demonstration**: Raw, unedited footage of the byte-count verification and the test vector decryption run.
4.  **Log Files**: Standard out traces of the decryption process.
5.  **Independent Witness Signatures**: Contact details and statements from computing/cryptography professionals verifying the legitimacy of the code.

---
*Maintained for Guinness World Record Adjudication.*
