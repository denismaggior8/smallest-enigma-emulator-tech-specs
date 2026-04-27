# Record Attempt

## 1. Guinness World Records Application Details
*   **Application Reference Number:** `[Insert GWR Application ID]`
*   **Applicant Name:** `Denis Maggiorotto`
*   **Date of Attempt:** `[Insert Date]`
*   **Location of Attempt:** `Chieri (Turin), Italy`
*   **Hardware Platform:** [WaveShare RP2040-Tiny](https://www.waveshare.com/rp2040-tiny.htm?srsltid=AfmBOopdHzICTJyQRDJfgRg1Y4STzqKt4vT1tkt6pyTvpTrWu_gPU1E2)

## 2. Emulator Implementation Architecture

The core of this attempt relies on the **[enigma-core](https://github.com/denismaggior8/enigma-core)** library, a standalone, embedded-ready Enigma machine simulator built by the claimant specifically for extremely constrained microcontrollers. The implementation leverages the following architectural features to achieve computational autonomy:

*   **AT Command Interface:** The device operates seamlessly as a hardware peripheral, accepting configuration settings and streaming ciphertexts via a classic, modem-style AT command interface over a USB serial connection.
*   **MicroPython Foundation:** Written in pure Python, the firmware executes directly on the RP2040-Tiny using the MicroPython runtime, allowing complex cryptographic algorithms to run efficiently on embedded hardware.
*   **Handler-Based Dispatching:** Commands are implemented as isolated, runtime-loaded modules, ensuring a clean separation between I/O parsing and the actual cryptographic processing engine.
*   **Centralized State & Memory Management:** The emulator utilizes a strict Device State Singleton to maintain rotor positions securely in memory. To survive the severe RAM limitations of the hardware, it triggers automatic memory cleanup (garbage collection hooks) after state changes, making it capable of processing the lengthy, historically authentic ciphertexts required for validation.

## 3. Measurement Results & Methodology
To satisfy the strict requirements of the "smallest volume" claim, the physical hardware footprint of the assembled emulator was meticulously measured and documented according to the axis-aligned bounding box method.

*   **Vendor Declared Dimensions:** 23.5 mm (L) × 18.0 mm (W) × 2.1 mm (H)
*   **Vendor Declared Volume:** 888.3 mm³
*   **Measured Dimensions (Mean of 3 measurements):** `[Insert Length]` mm (L) × `[Insert Width]` mm (W) × `[Insert Height]` mm (H)
*   **Calculated Measured Volume:** `[Insert Volume]` mm³
*   **Measurement Instrument:** Calibrated Digital Calipers `[Insert Model/Serial Number]`
*   **Methodology:** The dimensions were taken at the widest, longest, and highest points of the assembled RP2040-Tiny board, explicitly including the PCB, components, connectors, and solder joints, while excluding temporary I/O jumper wires. Each axis was measured 3 times, and the arithmetic mean was recorded as the final dimension.
*   **Photographic Evidence:** `[Insert link/reference to high-resolution photos showing the calipers reading the exact L, W, and H dimensions of the board]`

## 4. Independent Witnesses
GWR requires independent specialist witnesses to verify both the physical measurements and the cryptographic accuracy of the device. The signed statements from the following experts are included in the Evidence Inventory:
*   **Witness 1:** `[Insert Name]`, `[Insert Title/Expertise, e.g., Professor of Computer Science / Cryptography Expert]`
*   **Witness 2:** `[Insert Name]`, `[Insert Title/Expertise, e.g., Senior Electrical Engineer]`

## 5. Cryptographic Validation
In accordance with the validation procedures defined in the specifications, the emulator's cryptographic accuracy and reciprocity were rigorously tested against authentic historical interceptions.

This attempt utilizes the following reproducible **[Verification Kit](./tests)** to demonstrate compliance:

- [`verify_p1030700.sh`](./tests/verify_p1030700.sh) based on the famous U-534 M4 interception preserved by the [Hoerenberg Enigma M4 Project](https://enigma.hoerenberg.com/index.php?cat=The%20U534%20messages&page=P1030700). This shell script automatically dispatches the exact authentic historical ring settings, rotor topology, and plugboard connections directly into the emulator over serial via `enigma-core` AT commands, before streaming the 1940s ciphertext to visually demonstrate the translation into the original German plaintext.

*Note: While the Verification Kit utilizes/provides a well known M4 message for immediate proof, the emulator is strictly **not** limited to this specific example. It is a functionally complete replica capable of encrypting or decrypting any authentic M4 Enigma configuration.*

## 6. Reproducibility

To ensure complete transparency and allow adjudicators to independently verify this record claim, the entire system is designed to be fully reproducible. Any third party can independently replicate these exact results by following three simple steps:
1. **Acquire Hardware:** Obtain a standard, unmodified [WaveShare RP2040-Tiny](https://www.waveshare.com/rp2040-tiny.htm?srsltid=AfmBOopdHzICTJyQRDJfgRg1Y4STzqKt4vT1tkt6pyTvpTrWu_gPU1E2) microcontroller board.
2. **Flash Firmware:** Connect the board via USB and drag-and-drop the pre-compiled `enigma-core` `.uf2` firmware image (provided in the Evidence Inventory) directly onto the drive to initialize the bare-metal emulator.
3. **Execute Verification:** Run the `verify_p1030700.sh` script against the attached serial port to deterministically reproduce the historical cryptographic decryption.

## 7. Evidence Inventory
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

    **Verification Kits Summary:**
    In the following table, we summarize the Verification Kits provided in this repository, detailing their execution commands, completion status, output logs, and native video recordings:

    | Verification Script | Verification Command | Execution Status | Output Log | Terminal Recording |
    | :--- | :--- | :---: | :--- | :--- |
    | [`verify_p1030700.sh`](./tests/verify_p1030700.sh) | `asciinema rec -q -c "./tests/verify_p1030700.sh" recs/rec_p1030700.cast --overwrite \| tee logs/verify_p1030700.log` | ✅ VERIFIED | [`verify_p1030700.log`](./logs/verify_p1030700.log) | [`rec_p1030700.cast`](./recs/rec_p1030700.cast) |

    *Note: The **Video Demonstrations** have been recorded using [asciinema](https://asciinema.org/) to faithfully capture standard output directly from the hardware execution. You can seamlessly replay any `.cast` file linked above by running `asciinema play <file.cast>` in your terminal (e.g., `asciinema play recs/rec_p1030700.cast`).*

*   **Exhibit E: Witness Statements**
    *   Signed declarations from the independent witnesses.
    *   `[Link to Witness Statements PDF]`
*   **Exhibit F: Board Firmware & Enigma Library Source Code**
    *   **Board Firmware**: [`enigma-core_firmware_v1.0.1_RPI_PICO.uf2`](https://github.com/denismaggior8/smallest-enigma-emulator-tech-specs/releases/latest/download/enigma-core_firmware_v1.0.1_RPI_PICO.uf2) (SHA256: `791bf4c142088071c10815574e90e70b8020713cc935afbc9a3e3f105b71db0d`)
    *   **Enigma Library Source Code**: [enigma-python v3.1.2](https://github.com/denismaggior8/enigma-python/releases/tag/v3.1.2)

---
*Maintained for Guinness World Record Adjudication.*
