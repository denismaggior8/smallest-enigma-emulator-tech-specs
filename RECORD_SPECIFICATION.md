# Technical Specification Document  
## Smallest M4 Enigma Emulator (Guinness World Records Submission)

---

## 1. Scope

This document defines the strict technical, measurement, and validation requirements for the Guinness World Records title:

**"The smallest volume (mm³) of a self-contained hardware device capable of executing a fully functional M4 Enigma cipher algorithm."**

---

## 2. Record Definition

To ensure strict adherence to the record title, the record is defined as:

> The smallest volume (mm³) of a self-contained hardware device capable of executing a fully functional Naval M4 Enigma cipher algorithm, as measured using the axis-aligned bounding box method.

### 2.1 Historical Baseline Comparison
To provide a physical baseline for the miniaturization claim, the original electromechanical Enigma M4 (introduced in 1942 for the German U-boat fleet) had the following characteristics:
*   **Physical Dimensions:** ~ 340 mm (width) × 280 mm (depth) × 150 mm (height)
*   **Weight:** ~ 12 kg (26 lbs)
*   **Construction:** Heavy wooden casing housing a die-cast metal chassis.

---

## 3. Measurement Specification

### 3.1 Measurement Quantity

V = L × W × H

Where:
- L = length (mm)  
- W = width (mm)  
- H = height (mm)

---

### 3.2 Measurement Method

The physical size of the emulator MUST be measured using an **orthogonal, axis-aligned bounding box** method using calibrated digital calipers.

To prevent artificial volume reduction, the measurement axes (Length, Width, Height) must be strictly orthogonal (perpendicular) to each other and aligned with the primary geometric axes of the device's main PCB or enclosure. Diagonal measurements, rotation within the bounding box to minimize the footprint, contour-following, or calculating the aggregate volume of individual components are strictly prohibited. The bounding box must completely encapsulate the entire assembled, functional unit.

---

### 3.3 Inclusion Criteria

The measured volume MUST strictly account for the entirety of the functional emulator unit. This includes:
- **Printed Circuit Board (PCB):** The main physical board(s) forming the structural substrate of the device.
- **Surface & Through-Hole Components:** All onboard microcontrollers, resistors, capacitors, and any other mounted hardware required for operation.
- **Connectors & Interfaces:** Any permanently attached sockets, pins, or ports used for external interfacing.
- **Solder Joints & Assembly Tolerances:** The measurement must capture the absolute maximum physical extremities of the device, which naturally includes the added height/width from solder bumps, component misalignments, and manufacturing tolerances.

---

### 3.4 Exclusion Criteria

To ensure the measurement isolates the core computational unit from its temporary operational environment, the following items are explicitly excluded from the bounding box volume:
- **External Cables and Adapters:** USB cables, serial adapters, or any external wiring used to connect the emulator to a host machine.
- **External Power Supplies:** Batteries, power banks, or mains adapters that provide electrical power but perform no cryptographic logic.
- **Measurement Fixtures:** Calipers, stands, or mounting putty used temporarily to hold the device during the measurement process.
- **Temporary I/O Jumper Wires:** If bare wires or jumper cables are temporarily attached or soldered solely for the purpose of demonstrating I/O during the record attempt, they do not count towards the device's permanent physical footprint.

---

## 4. Functional Specification — M4 Enigma Emulator

The system must cryptographically mirror the EXACT behavior of the historical Naval M4 machine. The emulator is required to fully support **ANY historically valid M4 configuration**, not merely a subset. It must explicitly implement and handle:

- **Comprehensive 4-Rotor Architecture:** It must support the use of all 8 standard WWII Naval rotors (I, II, III, IV, V, VI, VII, VIII) in the three right-most positions, plus either of the 2 thin *Zusatzwalze* rotors (Beta or Gamma) in the fourth position.
- **Thin Reflectors:** It must implement both historical thin reflectors (*Umkehrwalze* "B Thin" and "C Thin").
- **Rotor Settings:** Full support for *Grundstellung* (initial position) and *Ringstellung* (ring settings) across all inserted rotors.
- **Plugboard (*Steckerbrett*):** Must allow for up to 13 arbitrary standard alphabet (A-Z) letter pairings.
- **Correct Rotor Stepping:** Accurately mirroring the mechanical stepping mechanism, including the infamous historical "double-stepping" anomalies of the middle rotor.
- **Optional Add-ons:** The emulation of highly specialized or experimental Enigma accessories—such as the *Enigma-Uhr* (a plugboard expansion switch) or the *UKW-D* (a field-rewirable reflector known as "Uncle D")—is not strictly required for a valid claim, although their inclusion remains permitted.
- **User Interface Independence:** The physical user interface components of the historical machine (such as the keyboard and lampboard) have been intentionally omitted from this specification. The emulator is permitted to implement any user interface (e.g., a serial connection) provided the core cryptographic algorithm remains intact.

*For historical and technical reference on the original Naval M4 Enigma, please consult:*
*   [Wikipedia: Enigma-M4](https://en.wikipedia.org/wiki/Enigma-M4)
*   [Crypto Museum: Enigma M4](https://www.cryptomuseum.com/crypto/enigma/m4/)

---

## 5. Anti-Cheating Requirements

In pursuit of a legitimate "emulator," the following constraints apply:

- **No Pre-computed Ciphertext Tables:** The emulator cannot use massive look-up tables containing pre-computed ciphertexts to bypass the algorithmic implementation of the Enigma machine. (Note: The use of data structures or lookup tables used exclusively to define the static internal wirings of the historical rotors and reflectors is permitted).
- **Computationally Autonomous & Self-Contained:** All encryption and decryption operations MUST be executed entirely on the physical device itself using only its own internal processor and memory. Offloading computation to external servers or network calls is strictly prohibited. To clarify "self-contained operation":
    - *Power Source:* External power supplies or batteries are permitted (and are excluded from the volume measurement) provided they supply *only* power and contain no computational logic or data side-channels.
    - *I/O Expectations:* External I/O interfaces (such as a USB serial connection) are permitted for the sole purpose of transmitting key configurations, streaming input ciphertexts, and reading the output plaintexts. The external client connected to the I/O interface MUST NOT perform any part of the Enigma cryptographic algorithm. It is explicitly permitted for a single USB cable to simultaneously supply power and serve as the I/O interface.
    - *Initialization Conditions:* The device must be capable of receiving a full state reset and processing a new M4 configuration from a cold boot, without relying on persistent external state or configuration files from a host machine.
- **No Hardcoded Outputs:** The system must deterministically process the input based solely on the provided key settings, without hardcoded historical solutions.

---

## 6. Validation Procedure

To satisfy adjudicators, the definitive proof of cryptographic accuracy is that the hardware emulator must be capable of successfully deciphering **any original, historically documented WWII Enigma plaintext/ciphertext pair** (often referred to as "broken messages").

Each test vector must define:
- **Configuration:** The correct historical key settings (Rotors, Ring settings, Plugboard connections, initial positions).
- **Input:** The Original 1945-era Ciphertext (e.g., the U-534 interceptions).
- **Expected Output:** The documented historical German plaintext.

The output must match exactly. Furthermore, to explicitly validate the **reciprocal nature** of the cipher, the emulator must be capable of subsequently re-encrypting the resulting plaintext directly back into the exact original ciphertext.

### 6.1 Test Vector Trust Chain
To establish an unassailable trust chain for the test vectors, the validation procedure must adhere to the following:

- **Source of Truth:** All ciphertexts and their corresponding key settings and plaintexts must be sourced from publicly recognized, peer-reviewed historical archives (e.g., the Hoerenberg Enigma M4 Project).
- **Reference Implementation:** The correctness of the chosen test vectors must be independently verifiable against recognized, standard software Enigma simulators (such as Universal Enigma or those provided by the Crypto Museum) to prove the baseline is accurate.
- **Reproducibility Method:** The validation process must be fully reproducible. The applicant must provide automated execution tools (e.g., shell scripts) that deterministically feed the configuration and ciphertext to the emulator, allowing adjudicators to easily replicate the exact test conditions and verify the output.

### 6.2 Validation Exceptions
- **Batched Processing Exception:** Given the intentionally constrained hardware memory of miniaturized devices, the emulator is *not* required to buffer an entire historical message simultaneously during validation. The external client is permitted to stream lengthy payloads to the device iteratively in discrete batches.

---

## 7. Evidence Requirements

The applicant must provide rigorous proof of the claim. A complete Evidence Inventory (documented in the separate `RECORD_ATTEMPT.md` file) must include:

- **Unbroken Video Evidence:** A continuous, unedited physical camera recording showing the hardware board, the measurement process with calipers, and the real-time decryption output on a monitor simultaneously.
- **Raw System Logs:** Unedited standard output logs and/or interactive terminal recordings documenting the exact commands, decryption streams, and reverse-encryption processes.
- **Independent Witness Statements:** Signed declarations from independent specialist witnesses (e.g., engineering or cryptography experts) verifying both the physical measurements and the cryptographic accuracy of the device.
- **Photographic Evidence:** High-resolution photos of the board being measured.

---

## 8. Final Statement

Provided that the emulator strictly meets the functional specification of the Enigma M4, the record is determined by its minimum measured volume (mm³).

---

## 9. Supersession Criteria
Each record attempt must demonstrate independent implementation and full compliance with the functional and validation requirements defined in this specification.

To officially supersede this record, a competing implementation must demonstrate a strictly smaller physical volume (mm³) than the benchmark established here, while maintaining full historical cryptographic accuracy and computational autonomy as defined in this specification.
