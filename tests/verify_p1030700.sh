#!/bin/bash

# ==============================================================================
# Guinness World Record Verification Kit
# Target: Enigma M4 Message P1030700 (Hoerenberg Collection U-534)
# Source: https://enigma.hoerenberg.com/index.php?cat=The%20U534%20messages&page=P1030700
# ==============================================================================

# Define your serial port here
SERIAL_PORT="/dev/tty.usbmodem101"

# We use an embedded python script to reliably communicate over the serial interface,
# as traditional Unix 'echo > /dev/tty' can block indefinitely on MacOS USB drivers.

python3 -c '
import serial
import time
import sys
from datetime import datetime

ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
print(f"[{ts}] Starting Verification Kit Run")

port = "'"$SERIAL_PORT"'"
try:
    s = serial.Serial(port, 115200, timeout=0.1)
    # Hardware Reset Routine
    print(f"Initializing Smallest Enigma Emulator (P1030700 Verification Mode) on {port}...")
    s.write(b"\x03\x04") # Break any running loops and soft-reboot MicroPython!
    time.sleep(4.0) # Wait for Enigma Core boot sequence & AT Registry to initialize
    s.read_all() # Clear boot buffer
    
    # Flush PySerial Buffers completely
    s.reset_input_buffer()
    s.reset_output_buffer()
    
    # Send a dummy newline and AT command to synchronize the board UART FIFO and clear any noise
    s.write(bytes([13, 10, 65, 84, 13, 10]))
    time.sleep(0.5)
    s.read_all()
    
except Exception as e:
    print(f"Failed to open {port}: {e}")
    print("Hint: Install pyserial via `pip install pyserial` if you have not already.")
    sys.exit(1)

def send_cmd(cmd):
    print(f"Sending: {cmd}")
    s.write(f"{cmd}\r\n".encode("utf-8"))
    time.sleep(0.8)  # Increase delay so RP2040 has plenty of time to process each command
    resp = s.read_all().decode("utf-8", errors="ignore").strip()
    if resp:
        for line in resp.split("\n"):
            print(f"   -> {line.strip()}")

# 1. Force a clean state reset by switching model architectures
send_cmd("AT+ENIGMA=M3")
send_cmd("AT+ENIGMA=M4")

# 2. Select the B-Reflector (Thin) -> mapped as BT in Firmware
send_cmd("AT+REFLECTOR=BT")

# 3. Configure the 4 Rotors
# AT+ROTOR=<idx>,<type>,<ring>,<pos> 
# M4 requires indices 0-3. Ring/Pos must be numeric where A=0 -> Z=25.
# With micropython-enigma-python, index 0 is mapped to the Fast Rotor
# Settings: VIII (Fast), III (Mid), IV (Slow), Greek Gamma (Static)
# Rings: AACU -> 20, 2, 0, 0
# Pos: VMGC -> 2, 6, 12, 21
send_cmd("AT+ROTOR=0,VIII,20,2")
send_cmd("AT+ROTOR=1,III,2,6")
send_cmd("AT+ROTOR=2,IV,0,12")
send_cmd("AT+ROTOR=3,G,0,21")

# 4. Connect the Plugboard (Steckerbrett)
send_cmd("AT+PLUGBOARD=C,H")
send_cmd("AT+PLUGBOARD=E,J")
send_cmd("AT+PLUGBOARD=N,V")
send_cmd("AT+PLUGBOARD=O,U")
send_cmd("AT+PLUGBOARD=T,Y")
send_cmd("AT+PLUGBOARD=L,G")
send_cmd("AT+PLUGBOARD=S,Z")
send_cmd("AT+PLUGBOARD=P,K")
send_cmd("AT+PLUGBOARD=D,I")
send_cmd("AT+PLUGBOARD=Q,B")

print("Configuration applied successfully. Transmitting Ciphertext blocks...")

CIPHERTEXT="QBHEWTDFEQITKUWFQUHLIQQGVYGRSDOHDCOBFMDHXSKOFPAODRSVBEREIQZVEDAXSHOHBIYMCIIZSKGNDLNFKFVLWWHZXZGQXWSSPWLSOQXEANCELJYJCETZTLSTTWMTOBW"

s.read_all() # clean buffer

# To prevent MicroPython MemoryError (OOM) on the RP2040 (which has 180KB RAM), 
# we split the 241 char string into individual characters to process one by one.
out = ""
for i, char in enumerate(CIPHERTEXT):
    s.write(f"{char}\r\n".encode("utf-8"))
    time.sleep(0.05)
    
    # Try reading whatever the device has emitted
    resp = s.read_all().decode("utf-8", errors="ignore")
    # Clean the response string from OKs and newlines
    clean_chunk = resp.replace("OK", "").replace("\r", "").replace("\n", "").strip()
    out += clean_chunk
    
    # Log progress every 20 chars
    if (i + 1) % 20 == 0:
        print(f"[{i+1}/{len(CIPHERTEXT)}] Processed so far: {out[-20:]}...")

EXPECTED_PLAINTEXT="KOMXBDMXUUUBOOTEYFXDXUUUAUSBILVUNYYZWOSECHSXUUUFLOTTXVVVUUURWODREISECHSVIERKKREMASKKMITUUVZWODREIFUVFYEWHSYUUUZWODREIFUNFZWOYUUFZWL"

# Clean whitespace/newlines to ensure accurate matching against the stream
time.sleep(2)
final_resp = s.read(1024).decode("utf-8", errors="ignore")
out += final_resp.replace("OK", "").replace("\r", "").replace("\n", "").strip()
cleaned_output = "".join(out.split())

if EXPECTED_PLAINTEXT in cleaned_output.upper():
    print(f"\n=============================================================================")
    print(f"✅ VERIFIED: P1030700 decryption matches expected historical plaintext!")
    print(f"=============================================================================\n")
    
    print("Re-initializing rotor positions for reverse (encryption) verification...")
    # Resend the initial positions to reset the state
    send_cmd("AT+ROTOR=0,VIII,20,2")
    send_cmd("AT+ROTOR=1,III,2,6")
    send_cmd("AT+ROTOR=2,IV,0,12")
    send_cmd("AT+ROTOR=3,G,0,21")
    
    print("Transmitting Plaintext blocks to verify encryption...")
    s.read_all() # clean buffer
    
    reverse_out = ""
    for i, char in enumerate(EXPECTED_PLAINTEXT):
        s.write(f"{char}\r\n".encode("utf-8"))
        time.sleep(0.05)
        
        resp = s.read_all().decode("utf-8", errors="ignore")
        clean_chunk = resp.replace("OK", "").replace("\r", "").replace("\n", "").strip()
        reverse_out += clean_chunk
        
        if (i + 1) % 20 == 0:
            print(f"[{i+1}/{len(EXPECTED_PLAINTEXT)}] Encrypted so far: {reverse_out[-20:]}...")
            
    time.sleep(2)
    final_resp = s.read(1024).decode("utf-8", errors="ignore")
    reverse_out += final_resp.replace("OK", "").replace("\r", "").replace("\n", "").strip()
    cleaned_reverse_output = "".join(reverse_out.split())

    if CIPHERTEXT in cleaned_reverse_output.upper():
        print(f"\n=============================================================================")
        print(f"✅ VERIFIED: P1030700 encryption identically reproduces the historical ciphertext!")
        print(f"=============================================================================\n")
        sys.exit(0)
    else:
        print(f"\n=============================================================================")
        print(f"FAILED: Hardware output did not match expected P1030700 ciphertext in reverse mode.")
        print(f"EXPECTED : {CIPHERTEXT}")
        print(f"RECEIVED (RAW): \n{cleaned_reverse_output.upper()}")
        print(f"=============================================================================\n")
        sys.exit(1)
else:
    print(f"\n=============================================================================")
    print(f"FAILED: Hardware output did not match expected P1030700 plaintext.")
    print(f"EXPECTED : {EXPECTED_PLAINTEXT}")
    print(f"RECEIVED (RAW): \n{cleaned_output.upper()}")
    print(f"=============================================================================\n")
    sys.exit(1)
'
