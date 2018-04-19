#!/usr/bin/python3

####################
# Developed by Luiz Felipe
# - https://github.com/Silva97
#
# Distributed under the MIT License
####################

import argparse, os.path

parser = argparse.ArgumentParser()
parser.add_argument("executable", help="Executable name", type=str)

args = parser.parse_args()

if not os.path.isfile(args.executable):
    print("File not found")
    quit()


def getbytes(data):
    return int.from_bytes(data, "little");


with open(args.executable, "rb") as elf:
    magic = getbytes(elf.read(4))
    if magic != 0x464C457F:
        print("This is not a elf executable")
        quit()

    elf.seek(0x18) # Offset of the entrypoint
    entrypoint = getbytes(elf.read(8))
    pheader    = getbytes(elf.read(8))

    elf.seek(pheader)
    while True:
        if getbytes(elf.read(4)) == 1:
            flags = getbytes(elf.read(4))
            if flags & 1:
                elf.seek(8, 1)
                vaddress = getbytes(elf.read(8))
                break
            else:
                elf.seek(48, 1)
        else:
            elf.seek(52, 1)


    entryraw = entrypoint - vaddress

    elf.seek(entryraw)
    while True:
        b = getbytes(elf.read(2))
        if b == 0x15FF:
            i = elf.tell()-2
            elf.seek(i-7)
            b = getbytes(elf.read(2))
            elf.seek(1, 1)

            if b == 0x8D48: # LEA
                raddr       = 0xFFFFFFFF - getbytes(elf.read(4)) + 1
                mainaddress = (i - raddr) + vaddress
            else:
                mainaddress = getbytes(elf.read(4))

            break

print("""Developed by Luiz Felipe
    https://github.com/Silva97

Virtual entry point:  %08X
Raw entry point:      %08X
Virtual main address: %08X
Raw main address:     %08X
""" % (entrypoint, entryraw, mainaddress, mainaddress - vaddress))