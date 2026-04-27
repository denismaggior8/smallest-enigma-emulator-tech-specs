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

The minimum axis-aligned bounding box enclosing the device is used. All measurements must be meticulously recorded using highly precise instruments, such as **Calibrated Digital Calipers**. The dimensions must be taken at the widest, longest, and highest points of the assembled emulator.

---

### 3.3 Inclusion Criteria

Include:
- PCB
- Components
- Connectors
- Solder joints

---

### 3.4 Exclusion Criteria

Exclude:
- External cables and adapters (if any)
- External power supplies
- Measurement fixtures
- Temporary jumper wires used for I/O (if any)

---

## 4. Functional Specification — M4 Enigma Emulator

The system must cryptographically mirror the EXACT behavior of the historical Naval M4 machine. The emulator must explicitly implement and handle:

- **4-Rotor Architecture:** Including 3 standard rotors selected from I-VIII, plus 1 thin 'Zusatzwalze' rotor (Beta or Gamma).
- **Thin Reflector:** Implementing the specific *Umkehrwalze* B or C logic.
- **Rotor Settings:** Full support for *Grundstellung* (initial position) and *Ringstellung* (ring settings).
- **Plugboard (*Steckerbrett*):** Allowing for arbitrary letter pairings.
- **Correct Rotor Stepping:** Accurately mirroring the mechanical stepping mechanism, including the infamous historical "double-stepping" anomalies of the middle rotor.
- **User Interface Independence:** The physical user interface components of the historical machine (such as the keyboard and lampboard) have been intentionally omitted from this specification. The emulator is permitted to implement any user interface (e.g., a serial connection) provided the core cryptographic algorithm remains intact.

*For historical and technical reference on the original Naval M4 Enigma, please consult:*
*   [Wikipedia: Enigma-M4](https://en.wikipedia.org/wiki/Enigma-M4)
*   [Crypto Museum: Enigma M4](https://www.cryptomuseum.com/crypto/enigma/m4/)

---

## 5. Anti-Cheating Requirements

In pursuit of a legitimate "emulator," the following constraints apply:

- **No Pre-computed Ciphertext Tables:** The emulator cannot use massive look-up tables containing pre-computed ciphertexts to bypass the algorithmic implementation of the Enigma machine. (Note: The use of data structures or lookup tables used exclusively to define the static internal wirings of the historical rotors and reflectors is permitted and required).
- **Computationally Autonomous:** All encryption and decryption operations MUST be executed entirely on the physical device itself. Offloading computation to external servers or network calls is strictly prohibited.
- **No Hardcoded Outputs:** The system must deterministically process the input based solely on the provided key settings, without hardcoded historical solutions.

---

## 6. Validation Procedure

To satisfy adjudicators, the definitive proof of cryptographic accuracy is that the hardware emulator must be capable of successfully deciphering **any original, historically documented WWII Enigma plaintext/ciphertext pair** (often referred to as "broken messages").

Each test vector must define:
- **Configuration:** The correct historical key settings (Rotors, Ring settings, Plugboard connections, initial positions).
- **Input:** The Original 1945-era Ciphertext (e.g., the U-534 interceptions).
- **Expected Output:** The documented historical German plaintext.

The output must match exactly. Furthermore, to explicitly validate the **reciprocal nature** of the cipher, the emulator must be capable of subsequently re-encrypting the resulting plaintext directly back into the exact original ciphertext.

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

To officially supersede this record, a competing implementation must demonstrate a strictly smaller physical volume (mm³) than the benchmark established here, while maintaining full historical cryptographic accuracy and computational autonomy as defined in this specification.
