
desklight.elf:     file format elf32-avr

Sections:
Idx Name                     Size      VMA       LMA       File off  Algn  Flags
  0 .text                    000003e2  00000000  00000000  00000094  2**1  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data                    00000000  00800040  000003e2  00000476  2**0  CONTENTS, ALLOC, LOAD, DATA
  2 .bss                     00000006  00800040  00800040  00000476  2**0  ALLOC
  3 .stab                    000004e0  00000000  00000000  00000478  2**2  CONTENTS, READONLY, DEBUGGING
  4 .stabstr                 000001be  00000000  00000000  00000958  2**0  CONTENTS, READONLY, DEBUGGING
  5 .comment                 00000022  00000000  00000000  00000b16  2**0  CONTENTS, READONLY
  6 .note.gnu.avr.deviceinfo 0000003c  00000000  00000000  00000b38  2**2  CONTENTS, READONLY
  7 .debug_aranges           00000028  00000000  00000000  00000b74  2**0  CONTENTS, READONLY, DEBUGGING
  8 .debug_info              00000906  00000000  00000000  00000b9c  2**0  CONTENTS, READONLY, DEBUGGING
  9 .debug_abbrev            000004e2  00000000  00000000  000014a2  2**0  CONTENTS, READONLY, DEBUGGING
 10 .debug_line              00000355  00000000  00000000  00001984  2**0  CONTENTS, READONLY, DEBUGGING
 11 .debug_frame             000000a0  00000000  00000000  00001cdc  2**2  CONTENTS, READONLY, DEBUGGING
 12 .debug_str               00000487  00000000  00000000  00001d7c  2**0  CONTENTS, READONLY, DEBUGGING
 13 .debug_loc               00000446  00000000  00000000  00002203  2**0  CONTENTS, READONLY, DEBUGGING
 14 .debug_ranges            00000090  00000000  00000000  00002649  2**0  CONTENTS, READONLY, DEBUGGING

Disassembly of section .text:

00000000 <__vectors>:
   0:	0a c0       	rjmp	.+20     	; 0x16 <__ctors_end>
   2:	19 c0       	rjmp	.+50     	; 0x36 <__bad_interrupt>
   4:	30 c1       	rjmp	.+608    	; 0x266 <__vector_2>
   6:	17 c0       	rjmp	.+46     	; 0x36 <__bad_interrupt>
   8:	16 c0       	rjmp	.+44     	; 0x36 <__bad_interrupt>
   a:	15 c0       	rjmp	.+42     	; 0x36 <__bad_interrupt>
   c:	14 c0       	rjmp	.+40     	; 0x36 <__bad_interrupt>
   e:	13 c0       	rjmp	.+38     	; 0x36 <__bad_interrupt>
  10:	12 c0       	rjmp	.+36     	; 0x36 <__bad_interrupt>
  12:	11 c0       	rjmp	.+34     	; 0x36 <__bad_interrupt>
  14:	10 c0       	rjmp	.+32     	; 0x36 <__bad_interrupt>

00000016 <__ctors_end>:
  16:	11 27       	eor	r17, r17
  18:	1f bf       	out	0x3f, r17	; 63
  1a:	cf e5       	ldi	r28, 0x5F	; 95
  1c:	d0 e0       	ldi	r29, 0x00	; 0
  1e:	de bf       	out	0x3e, r29	; 62
  20:	cd bf       	out	0x3d, r28	; 61

00000022 <__do_clear_bss>:
  22:	20 e0       	ldi	r18, 0x00	; 0
  24:	a0 e4       	ldi	r26, 0x40	; 64
  26:	b0 e0       	ldi	r27, 0x00	; 0
  28:	01 c0       	rjmp	.+2      	; 0x2c <.do_clear_bss_start>

0000002a <.do_clear_bss_loop>:
  2a:	1d 93       	st	X+, r17

0000002c <.do_clear_bss_start>:
  2c:	a6 34       	cpi	r26, 0x46	; 70
  2e:	b2 07       	cpc	r27, r18
  30:	e1 f7       	brne	.-8      	; 0x2a <.do_clear_bss_loop>
  32:	23 d1       	rcall	.+582    	; 0x27a <main>
  34:	d4 c1       	rjmp	.+936    	; 0x3de <_exit>

00000036 <__bad_interrupt>:
  36:	e4 cf       	rjmp	.-56     	; 0x0 <__vectors>

00000038 <ws2812_send_single_byte(unsigned char)>:
	light_count = LIGHT_COUNT;
	DDRB |= (1 << PIN_LED);
}

static inline void ws2812_send_single_byte(uint8_t byte)
{
  38:	48 e0       	ldi	r20, 0x08	; 8
  3a:	50 e0       	ldi	r21, 0x00	; 0
	for(uint8_t mask = 0x80; mask != 0; mask >>= 1) {
  3c:	60 e8       	ldi	r22, 0x80	; 128
		if(byte & mask) {
  3e:	78 2f       	mov	r23, r24
  40:	76 23       	and	r23, r22
  42:	51 f0       	breq	.+20     	; 0x58 <__SREG__+0x19>
					     "nop \n\t"
					     "cbi %0, %1 \n\t"
					     :
					     : "i" (0x2), "i" (PIN_LED)
					     :
					);
  44:	10 9a       	sbi	0x02, 0	; 2
  46:	00 00       	nop
  48:	00 00       	nop
  4a:	00 00       	nop
  4c:	10 98       	cbi	0x02, 0	; 2
	for(uint8_t mask = 0x80; mask != 0; mask >>= 1) {
  4e:	66 95       	lsr	r22
  50:	41 50       	subi	r20, 0x01	; 1
  52:	51 0b       	sbc	r21, r17
  54:	a1 f7       	brne	.-24     	; 0x3e <__SP_H__>
					     : "i" (0x2), "i" (PIN_LED)
					     :
					);
		}
	}
}
  56:	08 95       	ret
					);
  58:	10 9a       	sbi	0x02, 0	; 2
  5a:	00 00       	nop
  5c:	10 98       	cbi	0x02, 0	; 2
  5e:	f7 cf       	rjmp	.-18     	; 0x4e <__SREG__+0xf>

00000060 <get_channel_brightness(unsigned char, unsigned char)>:
		ret = 255;
	return ret;
}

static uint8_t get_channel_brightness(uint8_t channelmask, uint8_t current_attenuation)
{
  60:	46 2f       	mov	r20, r22
	uint8_t ret = mask << 6;
  62:	82 95       	swap	r24
  64:	88 0f       	add	r24, r24
  66:	88 0f       	add	r24, r24
  68:	80 7c       	andi	r24, 0xC0	; 192
	if(ret == 192)
  6a:	80 3c       	cpi	r24, 0xC0	; 192
  6c:	09 f4       	brne	.+2      	; 0x70 <get_channel_brightness(unsigned char, unsigned char)+0x10>
		ret = 255;
  6e:	8f ef       	ldi	r24, 0xFF	; 255
	uint16_t val = decode_colormask(channelmask);
  70:	90 e0       	ldi	r25, 0x00	; 0
	while(current_attenuation--)
  72:	41 50       	subi	r20, 0x01	; 1
  74:	48 f0       	brcs	.+18     	; 0x88 <get_channel_brightness(unsigned char, unsigned char)+0x28>
		val = ATTENUATION(val);
  76:	6f e0       	ldi	r22, 0x0F	; 15
  78:	70 e0       	ldi	r23, 0x00	; 0
  7a:	76 d1       	rcall	.+748    	; 0x368 <__mulhi3>
  7c:	54 e0       	ldi	r21, 0x04	; 4
  7e:	96 95       	lsr	r25
  80:	87 95       	ror	r24
  82:	5a 95       	dec	r21
  84:	e1 f7       	brne	.-8      	; 0x7e <get_channel_brightness(unsigned char, unsigned char)+0x1e>
	while(current_attenuation--)
  86:	f5 cf       	rjmp	.-22     	; 0x72 <get_channel_brightness(unsigned char, unsigned char)+0x12>
	return val;
}
  88:	08 95       	ret

0000008a <calca_set_new_values()>:
static int8_t calca_attenuation;
static int8_t calca_pos;
static int8_t calca_width;

static void calca_set_new_values(void)
{
  8a:	2f 93       	push	r18
  8c:	3f 93       	push	r19
  8e:	cf 93       	push	r28
  90:	df 93       	push	r29
  92:	00 d0       	rcall	.+0      	; 0x94 <calca_set_new_values()+0xa>
  94:	00 d0       	rcall	.+0      	; 0x96 <calca_set_new_values()+0xc>
  96:	00 d0       	rcall	.+0      	; 0x98 <calca_set_new_values()+0xe>
  98:	cd b7       	in	r28, 0x3d	; 61
  9a:	de b7       	in	r29, 0x3e	; 62
	uint8_t r = get_channel_brightness(calca_color >> 0, calca_attenuation);
  9c:	33 a1       	lds	r19, 0x43	; 0x800043 <calca_attenuation>
  9e:	44 a1       	lds	r20, 0x44	; 0x800044 <calca_color>
  a0:	ce 5f       	subi	r28, 0xFE	; 254
  a2:	df 4f       	sbci	r29, 0xFF	; 255
  a4:	48 83       	st	Y, r20
  a6:	c2 50       	subi	r28, 0x02	; 2
  a8:	d0 40       	sbci	r29, 0x00	; 0
  aa:	63 2f       	mov	r22, r19
  ac:	84 2f       	mov	r24, r20
  ae:	d8 df       	rcall	.-80     	; 0x60 <get_channel_brightness(unsigned char, unsigned char)>
  b0:	cf 5f       	subi	r28, 0xFF	; 255
  b2:	df 4f       	sbci	r29, 0xFF	; 255
  b4:	88 83       	st	Y, r24
  b6:	c1 50       	subi	r28, 0x01	; 1
  b8:	d0 40       	sbci	r29, 0x00	; 0
	uint8_t g = get_channel_brightness(calca_color >> 2, calca_attenuation);
  ba:	ce 5f       	subi	r28, 0xFE	; 254
  bc:	df 4f       	sbci	r29, 0xFF	; 255
  be:	58 81       	ld	r21, Y
  c0:	c2 50       	subi	r28, 0x02	; 2
  c2:	d0 40       	sbci	r29, 0x00	; 0
  c4:	45 2f       	mov	r20, r21
  c6:	50 e0       	ldi	r21, 0x00	; 0
  c8:	cb 5f       	subi	r28, 0xFB	; 251
  ca:	df 4f       	sbci	r29, 0xFF	; 255
  cc:	58 83       	st	Y, r21
  ce:	4a 93       	st	-Y, r20
  d0:	c4 50       	subi	r28, 0x04	; 4
  d2:	d0 40       	sbci	r29, 0x00	; 0
  d4:	95 2f       	mov	r25, r21
  d6:	84 2f       	mov	r24, r20
  d8:	95 95       	asr	r25
  da:	87 95       	ror	r24
  dc:	95 95       	asr	r25
  de:	87 95       	ror	r24
  e0:	63 2f       	mov	r22, r19
  e2:	be df       	rcall	.-132    	; 0x60 <get_channel_brightness(unsigned char, unsigned char)>
  e4:	ce 5f       	subi	r28, 0xFE	; 254
  e6:	df 4f       	sbci	r29, 0xFF	; 255
  e8:	88 83       	st	Y, r24
  ea:	c2 50       	subi	r28, 0x02	; 2
  ec:	d0 40       	sbci	r29, 0x00	; 0
	uint8_t b = get_channel_brightness(calca_color >> 4, calca_attenuation);
  ee:	cc 5f       	subi	r28, 0xFC	; 252
  f0:	df 4f       	sbci	r29, 0xFF	; 255
  f2:	89 91       	ld	r24, Y+
  f4:	98 81       	ld	r25, Y
  f6:	c5 50       	subi	r28, 0x05	; 5
  f8:	d0 40       	sbci	r29, 0x00	; 0
  fa:	54 e0       	ldi	r21, 0x04	; 4
  fc:	95 95       	asr	r25
  fe:	87 95       	ror	r24
 100:	5a 95       	dec	r21
 102:	e1 f7       	brne	.-8      	; 0xfc <calca_set_new_values()+0x72>
 104:	63 2f       	mov	r22, r19
 106:	ac df       	rcall	.-168    	; 0x60 <get_channel_brightness(unsigned char, unsigned char)>
 108:	cd 5f       	subi	r28, 0xFD	; 253
 10a:	df 4f       	sbci	r29, 0xFF	; 255
 10c:	88 83       	st	Y, r24
 10e:	c3 50       	subi	r28, 0x03	; 3
 110:	d0 40       	sbci	r29, 0x00	; 0

	int8_t calca_offpos = calca_pos + calca_width;
 112:	42 a1       	lds	r20, 0x42	; 0x800042 <calca_pos>
 114:	31 a1       	lds	r19, 0x41	; 0x800041 <calca_width>
 116:	84 2f       	mov	r24, r20
 118:	83 0f       	add	r24, r19
	int8_t head_on = (calca_offpos > light_count) ? (calca_offpos % light_count) : 0;
 11a:	50 a1       	lds	r21, 0x40	; 0x800040 <_edata>
 11c:	cc 5f       	subi	r28, 0xFC	; 252
 11e:	df 4f       	sbci	r29, 0xFF	; 255
 120:	58 83       	st	Y, r21
 122:	c4 50       	subi	r28, 0x04	; 4
 124:	d0 40       	sbci	r29, 0x00	; 0
 126:	58 17       	cp	r21, r24
 128:	0c f0       	brlt	.+2      	; 0x12c <__DATA_REGION_LENGTH__+0x2c>
 12a:	46 c0       	rjmp	.+140    	; 0x1b8 <__DATA_REGION_LENGTH__+0xb8>
 12c:	08 2f       	mov	r16, r24
 12e:	00 0f       	add	r16, r16
 130:	99 0b       	sbc	r25, r25
 132:	65 2f       	mov	r22, r21
 134:	55 0f       	add	r21, r21
 136:	77 0b       	sbc	r23, r23
 138:	29 d1       	rcall	.+594    	; 0x38c <__divmodhi4>
 13a:	ca 5f       	subi	r28, 0xFA	; 250
 13c:	df 4f       	sbci	r29, 0xFF	; 255
 13e:	88 83       	st	Y, r24
 140:	c6 50       	subi	r28, 0x06	; 6
 142:	d0 40       	sbci	r29, 0x00	; 0
	int8_t head_off = calca_pos - head_on;
	int8_t tail_on = calca_width - head_on;
 144:	ca 5f       	subi	r28, 0xFA	; 250
 146:	df 4f       	sbci	r29, 0xFF	; 255
 148:	58 81       	ld	r21, Y
 14a:	c6 50       	subi	r28, 0x06	; 6
 14c:	d0 40       	sbci	r29, 0x00	; 0
 14e:	35 1b       	sub	r19, r21
	int8_t tail_off = light_count - head_on - head_off - tail_on;
 150:	24 2f       	mov	r18, r20
 152:	25 1b       	sub	r18, r21
 154:	cc 5f       	subi	r28, 0xFC	; 252
 156:	df 4f       	sbci	r29, 0xFF	; 255
 158:	58 81       	ld	r21, Y
 15a:	c4 50       	subi	r28, 0x04	; 4
 15c:	d0 40       	sbci	r29, 0x00	; 0
 15e:	54 1b       	sub	r21, r20
 160:	53 1b       	sub	r21, r19
 162:	cc 5f       	subi	r28, 0xFC	; 252
 164:	df 4f       	sbci	r29, 0xFF	; 255
 166:	58 83       	st	Y, r21
 168:	c4 50       	subi	r28, 0x04	; 4
 16a:	d0 40       	sbci	r29, 0x00	; 0

	cli();
 16c:	f8 94       	cli
	{
		int8_t i;

		for(i = head_on; i > 0; --i)
 16e:	ca 5f       	subi	r28, 0xFA	; 250
 170:	df 4f       	sbci	r29, 0xFF	; 255
 172:	48 81       	ld	r20, Y
 174:	c6 50       	subi	r28, 0x06	; 6
 176:	d0 40       	sbci	r29, 0x00	; 0
 178:	14 17       	cp	r17, r20
 17a:	24 f5       	brge	.+72     	; 0x1c4 <__DATA_REGION_LENGTH__+0xc4>

static inline void ws2812_set_single(uint8_t r, uint8_t g, uint8_t b)
{
	ws2812_send_single_byte(g);
 17c:	ce 5f       	subi	r28, 0xFE	; 254
 17e:	df 4f       	sbci	r29, 0xFF	; 255
 180:	88 81       	ld	r24, Y
 182:	c2 50       	subi	r28, 0x02	; 2
 184:	d0 40       	sbci	r29, 0x00	; 0
 186:	58 df       	rcall	.-336    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 188:	cf 5f       	subi	r28, 0xFF	; 255
 18a:	df 4f       	sbci	r29, 0xFF	; 255
 18c:	88 81       	ld	r24, Y
 18e:	c1 50       	subi	r28, 0x01	; 1
 190:	d0 40       	sbci	r29, 0x00	; 0
 192:	52 df       	rcall	.-348    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 194:	cd 5f       	subi	r28, 0xFD	; 253
 196:	df 4f       	sbci	r29, 0xFF	; 255
 198:	88 81       	ld	r24, Y
 19a:	c3 50       	subi	r28, 0x03	; 3
 19c:	d0 40       	sbci	r29, 0x00	; 0
 19e:	4c df       	rcall	.-360    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1a0:	ca 5f       	subi	r28, 0xFA	; 250
 1a2:	df 4f       	sbci	r29, 0xFF	; 255
 1a4:	58 81       	ld	r21, Y
 1a6:	c6 50       	subi	r28, 0x06	; 6
 1a8:	d0 40       	sbci	r29, 0x00	; 0
 1aa:	51 50       	subi	r21, 0x01	; 1
 1ac:	ca 5f       	subi	r28, 0xFA	; 250
 1ae:	df 4f       	sbci	r29, 0xFF	; 255
 1b0:	58 83       	st	Y, r21
 1b2:	c6 50       	subi	r28, 0x06	; 6
 1b4:	d0 40       	sbci	r29, 0x00	; 0
 1b6:	db cf       	rjmp	.-74     	; 0x16e <__DATA_REGION_LENGTH__+0x6e>
	int8_t head_on = (calca_offpos > light_count) ? (calca_offpos % light_count) : 0;
 1b8:	ca 5f       	subi	r28, 0xFA	; 250
 1ba:	df 4f       	sbci	r29, 0xFF	; 255
 1bc:	18 83       	st	Y, r17
 1be:	c6 50       	subi	r28, 0x06	; 6
 1c0:	d0 40       	sbci	r29, 0x00	; 0
 1c2:	c0 cf       	rjmp	.-128    	; 0x144 <__DATA_REGION_LENGTH__+0x44>
			ws2812_set_single(r, g, b);

		for(i = head_off; i > 0; --i)
 1c4:	12 17       	cp	r17, r18
 1c6:	44 f4       	brge	.+16     	; 0x1d8 <__DATA_REGION_LENGTH__+0xd8>
	ws2812_send_single_byte(g);
 1c8:	80 e0       	ldi	r24, 0x00	; 0
 1ca:	36 df       	rcall	.-404    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 1cc:	80 e0       	ldi	r24, 0x00	; 0
 1ce:	34 df       	rcall	.-408    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 1d0:	80 e0       	ldi	r24, 0x00	; 0
 1d2:	32 df       	rcall	.-412    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1d4:	21 50       	subi	r18, 0x01	; 1
 1d6:	f6 cf       	rjmp	.-20     	; 0x1c4 <__DATA_REGION_LENGTH__+0xc4>
			ws2812_set_single(0, 0, 0);

		for(i = tail_on; i > 0; --i)
 1d8:	13 17       	cp	r17, r19
 1da:	a4 f4       	brge	.+40     	; 0x204 <__DATA_REGION_LENGTH__+0x104>
	ws2812_send_single_byte(g);
 1dc:	ce 5f       	subi	r28, 0xFE	; 254
 1de:	df 4f       	sbci	r29, 0xFF	; 255
 1e0:	88 81       	ld	r24, Y
 1e2:	c2 50       	subi	r28, 0x02	; 2
 1e4:	d0 40       	sbci	r29, 0x00	; 0
 1e6:	28 df       	rcall	.-432    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 1e8:	cf 5f       	subi	r28, 0xFF	; 255
 1ea:	df 4f       	sbci	r29, 0xFF	; 255
 1ec:	88 81       	ld	r24, Y
 1ee:	c1 50       	subi	r28, 0x01	; 1
 1f0:	d0 40       	sbci	r29, 0x00	; 0
 1f2:	22 df       	rcall	.-444    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 1f4:	cd 5f       	subi	r28, 0xFD	; 253
 1f6:	df 4f       	sbci	r29, 0xFF	; 255
 1f8:	88 81       	ld	r24, Y
 1fa:	c3 50       	subi	r28, 0x03	; 3
 1fc:	d0 40       	sbci	r29, 0x00	; 0
 1fe:	1c df       	rcall	.-456    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 200:	31 50       	subi	r19, 0x01	; 1
 202:	ea cf       	rjmp	.-44     	; 0x1d8 <__DATA_REGION_LENGTH__+0xd8>
			ws2812_set_single(r, g, b);

		for(i = tail_off; i > 0; --i)
 204:	cc 5f       	subi	r28, 0xFC	; 252
 206:	df 4f       	sbci	r29, 0xFF	; 255
 208:	48 81       	ld	r20, Y
 20a:	c4 50       	subi	r28, 0x04	; 4
 20c:	d0 40       	sbci	r29, 0x00	; 0
 20e:	14 17       	cp	r17, r20
 210:	94 f4       	brge	.+36     	; 0x236 <__DATA_REGION_LENGTH__+0x136>
	ws2812_send_single_byte(g);
 212:	80 e0       	ldi	r24, 0x00	; 0
 214:	11 df       	rcall	.-478    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 216:	80 e0       	ldi	r24, 0x00	; 0
 218:	0f df       	rcall	.-482    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 21a:	80 e0       	ldi	r24, 0x00	; 0
 21c:	0d df       	rcall	.-486    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 21e:	cc 5f       	subi	r28, 0xFC	; 252
 220:	df 4f       	sbci	r29, 0xFF	; 255
 222:	58 81       	ld	r21, Y
 224:	c4 50       	subi	r28, 0x04	; 4
 226:	d0 40       	sbci	r29, 0x00	; 0
 228:	51 50       	subi	r21, 0x01	; 1
 22a:	cc 5f       	subi	r28, 0xFC	; 252
 22c:	df 4f       	sbci	r29, 0xFF	; 255
 22e:	58 83       	st	Y, r21
 230:	c4 50       	subi	r28, 0x04	; 4
 232:	d0 40       	sbci	r29, 0x00	; 0
 234:	e7 cf       	rjmp	.-50     	; 0x204 <__DATA_REGION_LENGTH__+0x104>
			ws2812_set_single(0, 0, 0);
	}
	sei();
 236:	78 94       	sei
}
 238:	0f 91       	pop	r16
 23a:	0f 91       	pop	r16
 23c:	0f 91       	pop	r16
 23e:	0f 91       	pop	r16
 240:	0f 91       	pop	r16
 242:	0f 91       	pop	r16
 244:	df 91       	pop	r29
 246:	cf 91       	pop	r28
 248:	3f 91       	pop	r19
 24a:	2f 91       	pop	r18
 24c:	08 95       	ret

0000024e <calca_init()>:
	light_count = LIGHT_COUNT;
 24e:	42 e2       	ldi	r20, 0x22	; 34
 250:	40 a9       	sts	0x40, r20	; 0x800040 <_edata>
	DDRB |= (1 << PIN_LED);
 252:	08 9a       	sbi	0x01, 0	; 1

static void calca_init(void)
{
	ws2812_init();

	calca_mode = MODE_ATTENUATION;
 254:	15 a9       	sts	0x45, r17	; 0x800045 <calca_mode>
	calca_color = 0x3;
 256:	43 e0       	ldi	r20, 0x03	; 3
 258:	44 a9       	sts	0x44, r20	; 0x800044 <calca_color>
	calca_attenuation = MAX_ATTENUATION-1;
 25a:	44 e3       	ldi	r20, 0x34	; 52
 25c:	43 a9       	sts	0x43, r20	; 0x800043 <calca_attenuation>
	calca_pos = 0;
 25e:	12 a9       	sts	0x42, r17	; 0x800042 <calca_pos>
	calca_width = light_count;
 260:	40 a1       	lds	r20, 0x40	; 0x800040 <_edata>
 262:	41 a9       	sts	0x41, r20	; 0x800041 <calca_width>

	calca_set_new_values();
 264:	12 cf       	rjmp	.-476    	; 0x8a <calca_set_new_values()>

00000266 <__vector_2>:
		previous_io = current_io;
	}
}

ISR(PCINT0_vect)
{ /* this just pulls us out of sleep mode */ }
 266:	1f 93       	push	r17
 268:	0f 93       	push	r16
 26a:	0f b7       	in	r16, 0x3f	; 63
 26c:	0f 93       	push	r16
 26e:	10 e0       	ldi	r17, 0x00	; 0
 270:	0f 91       	pop	r16
 272:	0f bf       	out	0x3f, r16	; 63
 274:	0f 91       	pop	r16
 276:	1f 91       	pop	r17
 278:	18 95       	reti

0000027a <main>:
	CCP = 0xD8;		// allow writes to CLKPSR
 27a:	48 ed       	ldi	r20, 0xD8	; 216
 27c:	4c bf       	out	0x3c, r20	; 60
	CLKPSR = 0;		// disable prescaler
 27e:	16 bf       	out	0x36, r17	; 54
	CCP = 0xD8;		// allow writes to CLKPSR
 280:	4c bf       	out	0x3c, r20	; 60
	CLKMSR = 0x0U;		// select internal 8MHz oscillator
 282:	17 bf       	out	0x37, r17	; 55
	SMCR = 0;
 284:	1a bf       	out	0x3a, r17	; 58
	PRR |= (1 << PRADC) | (1 << PRTIM0);
 286:	45 b7       	in	r20, 0x35	; 53
 288:	43 60       	ori	r20, 0x03	; 3
 28a:	45 bf       	out	0x35, r20	; 53
	DIDR0 = ~EVENT_MASK;
 28c:	41 ef       	ldi	r20, 0xF1	; 241
 28e:	47 bb       	out	0x17, r20	; 23
	DDRB &= ~EVENT_MASK;
 290:	41 b1       	in	r20, 0x01	; 1
 292:	41 7f       	andi	r20, 0xF1	; 241
 294:	41 b9       	out	0x01, r20	; 1
	PUEB = EVENT_MASK;
 296:	4e e0       	ldi	r20, 0x0E	; 14
 298:	43 b9       	out	0x03, r20	; 3
	PCICR |= (1 << PCIE0);
 29a:	90 9a       	sbi	0x12, 0	; 18
	PCMSK |= EVENT_MASK;
 29c:	40 b3       	in	r20, 0x10	; 16
 29e:	4e 60       	ori	r20, 0x0E	; 14
 2a0:	40 bb       	out	0x10, r20	; 16
	calca_init(); // activates interrupts
 2a2:	d5 df       	rcall	.-86     	; 0x24e <calca_init()>
	uint8_t previous_io = EVENT_MASK;
 2a4:	4e e0       	ldi	r20, 0x0E	; 14
		sleep_mode(); // will return once interrupted by ISR.
 2a6:	5a b7       	in	r21, 0x3a	; 58
 2a8:	51 60       	ori	r21, 0x01	; 1
 2aa:	5a bf       	out	0x3a, r21	; 58
 2ac:	88 95       	sleep
 2ae:	5a b7       	in	r21, 0x3a	; 58
 2b0:	5e 7f       	andi	r21, 0xFE	; 254
 2b2:	5a bf       	out	0x3a, r21	; 58
		uint8_t current_io = PINB & EVENT_MASK;
 2b4:	50 b1       	in	r21, 0x00	; 0
 2b6:	c5 2f       	mov	r28, r21
 2b8:	ce 70       	andi	r28, 0x0E	; 14
		uint8_t changed_io = (current_io ^ previous_io);
 2ba:	64 2f       	mov	r22, r20
 2bc:	6c 27       	eor	r22, r28
		if((changed_io & ROTARY_MASK) && (0 == (previous_io & ROTARY_MASK))) {
 2be:	76 2f       	mov	r23, r22
 2c0:	76 70       	andi	r23, 0x06	; 6
 2c2:	b1 f1       	breq	.+108    	; 0x330 <main+0xb6>
 2c4:	46 70       	andi	r20, 0x06	; 6
 2c6:	a1 f5       	brne	.+104    	; 0x330 <main+0xb6>
			calca_rotary_step( (current_io & (1 << PIN_ROTARY1)) ? 1 : -1);
 2c8:	8f ef       	ldi	r24, 0xFF	; 255
 2ca:	51 fd       	sbrc	r21, 1
 2cc:	81 e0       	ldi	r24, 0x01	; 1
		value;
}

static inline void calca_rotary_step(int8_t dir)
{
	switch(calca_mode) {
 2ce:	45 a1       	lds	r20, 0x45	; 0x800045 <calca_mode>
 2d0:	41 30       	cpi	r20, 0x01	; 1
 2d2:	f9 f0       	breq	.+62     	; 0x312 <main+0x98>
 2d4:	98 f0       	brcs	.+38     	; 0x2fc <main+0x82>
 2d6:	60 a1       	lds	r22, 0x40	; 0x800040 <_edata>
 2d8:	42 30       	cpi	r20, 0x02	; 2
 2da:	f9 f0       	breq	.+62     	; 0x31a <main+0xa0>
		case MODE_SPOTWIDTH:
			calca_width = check_bounds(calca_width + dir, 1, light_count);
			break;
		default:
		case MODE_SPOTPOS:
			calca_pos = (calca_pos + dir + light_count) % light_count;
 2dc:	06 2f       	mov	r16, r22
 2de:	00 0f       	add	r16, r16
 2e0:	77 0b       	sbc	r23, r23
 2e2:	42 a1       	lds	r20, 0x42	; 0x800042 <calca_pos>
 2e4:	08 2f       	mov	r16, r24
 2e6:	00 0f       	add	r16, r16
 2e8:	99 0b       	sbc	r25, r25
 2ea:	84 0f       	add	r24, r20
 2ec:	91 1f       	adc	r25, r17
 2ee:	47 fd       	sbrc	r20, 7
 2f0:	9a 95       	dec	r25
 2f2:	86 0f       	add	r24, r22
 2f4:	97 1f       	adc	r25, r23
 2f6:	4a d0       	rcall	.+148    	; 0x38c <__divmodhi4>
 2f8:	82 a9       	sts	0x42, r24	; 0x800042 <calca_pos>
 2fa:	08 c0       	rjmp	.+16     	; 0x30c <main+0x92>
			calca_attenuation = check_bounds(calca_attenuation + dir, 0, MAX_ATTENUATION);
 2fc:	43 a1       	lds	r20, 0x43	; 0x800043 <calca_attenuation>
 2fe:	84 0f       	add	r24, r20
 300:	86 33       	cpi	r24, 0x36	; 54
 302:	0c f0       	brlt	.+2      	; 0x306 <main+0x8c>
 304:	85 e3       	ldi	r24, 0x35	; 53
 306:	87 fd       	sbrc	r24, 7
 308:	80 e0       	ldi	r24, 0x00	; 0
 30a:	83 a9       	sts	0x43, r24	; 0x800043 <calca_attenuation>
			break;
	};

	calca_set_new_values();
 30c:	be de       	rcall	.-644    	; 0x8a <calca_set_new_values()>
{
 30e:	4c 2f       	mov	r20, r28
 310:	ca cf       	rjmp	.-108    	; 0x2a6 <main+0x2c>
			calca_color += dir;
 312:	44 a1       	lds	r20, 0x44	; 0x800044 <calca_color>
 314:	84 0f       	add	r24, r20
 316:	84 a9       	sts	0x44, r24	; 0x800044 <calca_color>
 318:	f9 cf       	rjmp	.-14     	; 0x30c <main+0x92>
			calca_width = check_bounds(calca_width + dir, 1, light_count);
 31a:	41 a1       	lds	r20, 0x41	; 0x800041 <calca_width>
 31c:	84 0f       	add	r24, r20
	return (value < lower) ? lower :
 31e:	18 17       	cp	r17, r24
 320:	2c f4       	brge	.+10     	; 0x32c <main+0xb2>
 322:	86 17       	cp	r24, r22
 324:	0c f4       	brge	.+2      	; 0x328 <main+0xae>
 326:	68 2f       	mov	r22, r24
			calca_width = check_bounds(calca_width + dir, 1, light_count);
 328:	61 a9       	sts	0x41, r22	; 0x800041 <calca_width>
 32a:	f0 cf       	rjmp	.-32     	; 0x30c <main+0x92>
	return (value < lower) ? lower :
 32c:	61 e0       	ldi	r22, 0x01	; 1
 32e:	fc cf       	rjmp	.-8      	; 0x328 <main+0xae>
		} else if(changed_io & SWITCH_MASK) {
 330:	63 ff       	sbrs	r22, 3
 332:	ed cf       	rjmp	.-38     	; 0x30e <main+0x94>
			if(!(current_io & SWITCH_MASK)) {
 334:	53 fd       	sbrc	r21, 3
 336:	0e c0       	rjmp	.+28     	; 0x354 <main+0xda>
	calca_mode++;
 338:	45 a1       	lds	r20, 0x45	; 0x800045 <calca_mode>
 33a:	4f 5f       	subi	r20, 0xFF	; 255
	calca_mode %= MODECOUNT;
 33c:	43 70       	andi	r20, 0x03	; 3
 33e:	45 a9       	sts	0x45, r20	; 0x800045 <calca_mode>
				PRR &= ~(1 << PRTIM0);
 340:	45 b7       	in	r20, 0x35	; 53
 342:	4e 7f       	andi	r20, 0xFE	; 254
 344:	45 bf       	out	0x35, r20	; 53
				TCCR0A = 0;
 346:	1e bd       	out	0x2e, r17	; 46
				TCCR0C = 0;
 348:	1c bd       	out	0x2c, r17	; 44
				TCCR0B = 0x5; // TimerCLK is IoCLK/1024
 34a:	45 e0       	ldi	r20, 0x05	; 5
 34c:	4d bd       	out	0x2d, r20	; 45
				TCNT0 = 0;
 34e:	19 bd       	out	0x29, r17	; 41
 350:	18 bd       	out	0x28, r17	; 40
 352:	dd cf       	rjmp	.-70     	; 0x30e <main+0x94>
				if(TCNT0 > 2604) // pressed for more than ~1/3 second
 354:	48 b5       	in	r20, 0x28	; 40
 356:	59 b5       	in	r21, 0x29	; 41
 358:	4d 32       	cpi	r20, 0x2D	; 45
 35a:	5a 40       	sbci	r21, 0x0A	; 10
 35c:	08 f0       	brcs	.+2      	; 0x360 <main+0xe6>
					calca_init();
 35e:	77 df       	rcall	.-274    	; 0x24e <calca_init()>
				PRR |= (1 << PRTIM0);
 360:	45 b7       	in	r20, 0x35	; 53
 362:	41 60       	ori	r20, 0x01	; 1
 364:	45 bf       	out	0x35, r20	; 53
 366:	d3 cf       	rjmp	.-90     	; 0x30e <main+0x94>

00000368 <__mulhi3>:
 368:	00 27       	eor	r16, r16
 36a:	55 27       	eor	r21, r21
 36c:	04 c0       	rjmp	.+8      	; 0x376 <__mulhi3+0xe>
 36e:	08 0f       	add	r16, r24
 370:	59 1f       	adc	r21, r25
 372:	88 0f       	add	r24, r24
 374:	99 1f       	adc	r25, r25
 376:	80 50       	subi	r24, 0x00	; 0
 378:	90 40       	sbci	r25, 0x00	; 0
 37a:	29 f0       	breq	.+10     	; 0x386 <__mulhi3+0x1e>
 37c:	76 95       	lsr	r23
 37e:	67 95       	ror	r22
 380:	b0 f3       	brcs	.-20     	; 0x36e <__mulhi3+0x6>
 382:	71 07       	cpc	r23, r17
 384:	b1 f7       	brne	.-20     	; 0x372 <__mulhi3+0xa>
 386:	80 2f       	mov	r24, r16
 388:	95 2f       	mov	r25, r21
 38a:	08 95       	ret

0000038c <__divmodhi4>:
 38c:	97 fb       	bst	r25, 7
 38e:	07 2f       	mov	r16, r23
 390:	16 f4       	brtc	.+4      	; 0x396 <__divmodhi4+0xa>
 392:	00 95       	com	r16
 394:	06 d0       	rcall	.+12     	; 0x3a2 <__divmodhi4_neg1>
 396:	77 fd       	sbrc	r23, 7
 398:	08 d0       	rcall	.+16     	; 0x3aa <__divmodhi4_neg2>
 39a:	0b d0       	rcall	.+22     	; 0x3b2 <__udivmodhi4>
 39c:	07 fd       	sbrc	r16, 7
 39e:	05 d0       	rcall	.+10     	; 0x3aa <__divmodhi4_neg2>
 3a0:	3e f4       	brtc	.+14     	; 0x3b0 <__divmodhi4_exit>

000003a2 <__divmodhi4_neg1>:
 3a2:	90 95       	com	r25
 3a4:	81 95       	neg	r24
 3a6:	9f 4f       	sbci	r25, 0xFF	; 255
 3a8:	08 95       	ret

000003aa <__divmodhi4_neg2>:
 3aa:	70 95       	com	r23
 3ac:	61 95       	neg	r22
 3ae:	7f 4f       	sbci	r23, 0xFF	; 255

000003b0 <__divmodhi4_exit>:
 3b0:	08 95       	ret

000003b2 <__udivmodhi4>:
 3b2:	aa 1b       	sub	r26, r26
 3b4:	bb 1b       	sub	r27, r27
 3b6:	51 e1       	ldi	r21, 0x11	; 17
 3b8:	07 c0       	rjmp	.+14     	; 0x3c8 <__udivmodhi4_ep>

000003ba <__udivmodhi4_loop>:
 3ba:	aa 1f       	adc	r26, r26
 3bc:	bb 1f       	adc	r27, r27
 3be:	a6 17       	cp	r26, r22
 3c0:	b7 07       	cpc	r27, r23
 3c2:	10 f0       	brcs	.+4      	; 0x3c8 <__udivmodhi4_ep>
 3c4:	a6 1b       	sub	r26, r22
 3c6:	b7 0b       	sbc	r27, r23

000003c8 <__udivmodhi4_ep>:
 3c8:	88 1f       	adc	r24, r24
 3ca:	99 1f       	adc	r25, r25
 3cc:	5a 95       	dec	r21
 3ce:	a9 f7       	brne	.-22     	; 0x3ba <__udivmodhi4_loop>
 3d0:	80 95       	com	r24
 3d2:	90 95       	com	r25
 3d4:	68 2f       	mov	r22, r24
 3d6:	79 2f       	mov	r23, r25
 3d8:	8a 2f       	mov	r24, r26
 3da:	9b 2f       	mov	r25, r27
 3dc:	08 95       	ret

000003de <_exit>:
 3de:	f8 94       	cli

000003e0 <__stop_program>:
 3e0:	ff cf       	rjmp	.-2      	; 0x3e0 <__stop_program>
