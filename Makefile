# NOTE: attiny4/5/9/10 need TPI-capable programmer. STK500 will not work.
PROGRAMMER_ID := avrispmkII
PORT := usb

AVRDUDE_OPTS = -c ${PROGRAMMER_ID} -P ${PORT} -p ${PARTNO}

PARTNO := t10
MMCU := attiny10
CLOCK := 2000000UL

CC := avr-gcc
CFLAGS += -Wall -Werror -Wstrict-prototypes
CFLAGS += -g -Os -mmcu=${MMCU} -DF_CPU=${CLOCK} -I.
CFLAGS += -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums
CFLAGS += -std=gnu99
CFLAGS += -Wa,-adhlns=$(<:%.c=%.lst)

LDFLAGS=-mmcu=${MMCU} -Wl,--cref,-Map=$(@:%.elf=%.map)

.PHONY: all desklight readfuses fuses_desklight prog_flash_desklight prog_eeprom_desklight erase clean

all:	desklight

desklight:	desklight.asm desklight.hex desklight.eep desklight.bin



red: CFLAGS += -DTAGID='COLOR2TAGID(255,0,0)'
red: clean desklight prog_flash_desklight

yellow: CFLAGS += -DTAGID='COLOR2TAGID(128,128,0)'
yellow: clean desklight prog_flash_desklight

green: CFLAGS += -DTAGID='COLOR2TAGID(0,255,0)'
green: clean desklight prog_flash_desklight

cyan: CFLAGS += -DTAGID='COLOR2TAGID(0,128,128)'
cyan: clean desklight prog_flash_desklight

blue: CFLAGS += -DTAGID='COLOR2TAGID(0,0,255)'
blue: clean desklight prog_flash_desklight

magenta: CFLAGS += -DTAGID='COLOR2TAGID(128,0,128)'
magenta: clean desklight prog_flash_desklight



readfuses:
	avrdude ${AVRDUDE_OPTS} -Ulfuse:r:fuse_low.hex:h -U hfuse:r:fuse_high.hex:h

fuses_desklight:
	avrdude ${AVRDUDE_OPTS} -U fuse:w:0xFF:m

prog_flash_desklight: desklight.hex fuses_desklight
	avrdude ${AVRDUDE_OPTS} -U flash:w:desklight.hex

prog_eeprom_desklight: desklight.eep
	avrdude ${AVRDUDE_OPTS} -U eeprom:w:desklight.eep

erase:
	avrdude ${AVRDUDE_OPTS} -e

clean:
	rm -f *.asm *.lst *.o *.map *.hex *.eep *.bin *.elf

desklight.elf: desklight.o

desklight.o: desklight.c ws2812.h

%.elf:
	$(CC) $(LDFLAGS) $^ -o $@

%.hex: %.elf
	avr-objcopy -j .text -j .data -O ihex $< $@
	avr-size $@

%.eep: %.elf
	avr-objcopy -j .eeprom -O ihex $< $@
	avr-size $@

%.bin: %.elf
	avr-objcopy -j .text -j .data -O binary $< $@

%.asm: %.elf
	avr-objdump -d $< > $@

%.o: %.S
	$(CC) $(CFLAGS) -x assembler-with-cpp -c -o $@ $<

