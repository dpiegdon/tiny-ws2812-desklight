
CROSSCOMPILE ?= avr-

CC := $(CROSSCOMPILE)gcc
CPP := $(CROSSCOMPILE)gcc
CXX := $(CROSSCOMPILE)g++
AS := $(CROSSCOMPILE)as
AR := $(CROSSCOMPILE)ar
LD := $(CROSSCOMPILE)gcc
GDB := $(CROSSCOMPILE)gdb
NM := $(CROSSCOMPILE)nm
OBJCOPY := $(CROSSCOMPILE)objcopy
OBJDUMP := $(CROSSCOMPILE)objdump
READELF := $(CROSSCOMPILE)readelf
SIZE := $(CROSSCOMPILE)size

###

PARTNO := t10
MMCU := attiny10
CLOCK := 8000000UL

MCU_FLAGS += -mmcu=${MMCU} -DF_CPU=${CLOCK} -I.
DEBUG_OPTIMIZE_FLAGS += -g -gdwarf-4 -Os

# only one of these makes sense: either use LTO
#DEBUG_OPTIMIZE_FLAGS += -flto
# or generate listings. listings wont make any sense when using LTO, as LTO does not
# generate actual assembler code
CXXC_FLAGS += -Wa,-adhlns=$(<:%=%.lst)

CXXC_FLAGS += -Wall -Werror -Wshadow --pedantic
CXXC_FLAGS += -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -fstack-usage
CXXC_FLAGS += $(MCU_FLAGS) $(DEBUG_OPTIMIZE_FLAGS)
CXXFLAGS += $(CXXC_FLAGS) -std=c++17
CFLAGS += $(CXXC_FLAGS) -std=c11

LDFLAGS += $(MCU_FLAGS) $(DEBUG_OPTIMIZE_FLAGS)
LDFLAGS += -Wl,--cref,-Map=$(@:%.elf=%.map)

###

# NOTE: attiny4/5/9/10 need TPI-capable programmer. STK500 will not work.
PROGRAMMER_ID := avrispmkII
PORT := usb
AVRDUDE_OPTS := -c ${PROGRAMMER_ID} -P ${PORT} -p ${PARTNO}

###

.PHONY: all desklight readfuses fuses_desklight prog_flash_desklight prog_eeprom_desklight erase clean

all:	desklight

desklight:	desklight.asm desklight.hex desklight.eep desklight.bin

readfuses:
	avrdude ${AVRDUDE_OPTS} -Ulfuse:r:fuse_low.hex:h -U hfuse:r:fuse_high.hex:h

fuses_desklight:
	avrdude ${AVRDUDE_OPTS} -U fuse:w:0xFE:m

prog_flash_desklight: desklight.hex fuses_desklight
	avrdude ${AVRDUDE_OPTS} -U flash:w:desklight.hex

prog_eeprom_desklight: desklight.eep
	avrdude ${AVRDUDE_OPTS} -U eeprom:w:desklight.eep

erase:
	avrdude ${AVRDUDE_OPTS} -e

clean:
	rm -f *.asm *.lst *.o *.map *.hex *.eep *.bin *.elf *.su

###

desklight.o: desklight.cpp calca.h ws2812.h

###

%.elf: %.o
	$(CC) $(LDFLAGS) $^ -o $@

%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@
	$(SIZE) $@

%.eep: %.elf
	$(OBJCOPY) -j .eeprom -O ihex $< $@
	$(SIZE) $@

%.bin: %.elf
	$(OBJCOPY) -j .text -j .data -O binary $< $@

%.asm: %.elf
	$(OBJDUMP) -dgCxwsSh --show-raw-insn $< > $@

