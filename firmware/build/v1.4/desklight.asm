
desklight.elf:     file format elf32-avr

Sections:
Idx Name                     Size      VMA       LMA       File off  Algn  Flags
  0 .text                    00000376  00000000  00000000  00000094  2**1  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data                    00000000  00800040  00000376  0000040a  2**0  CONTENTS, ALLOC, LOAD, DATA
  2 .bss                     00000006  00800040  00800040  0000040a  2**0  ALLOC
  3 .stab                    00000210  00000000  00000000  0000040c  2**2  CONTENTS, READONLY, DEBUGGING
  4 .stabstr                 00000133  00000000  00000000  0000061c  2**0  CONTENTS, READONLY, DEBUGGING
  5 .comment                 00000022  00000000  00000000  0000074f  2**0  CONTENTS, READONLY
  6 .note.gnu.avr.deviceinfo 0000003c  00000000  00000000  00000774  2**2  CONTENTS, READONLY
  7 .debug_aranges           00000028  00000000  00000000  000007b0  2**0  CONTENTS, READONLY, DEBUGGING
  8 .debug_info              00000931  00000000  00000000  000007d8  2**0  CONTENTS, READONLY, DEBUGGING
  9 .debug_abbrev            00000508  00000000  00000000  00001109  2**0  CONTENTS, READONLY, DEBUGGING
 10 .debug_line              00000371  00000000  00000000  00001611  2**0  CONTENTS, READONLY, DEBUGGING
 11 .debug_frame             000000a0  00000000  00000000  00001984  2**2  CONTENTS, READONLY, DEBUGGING
 12 .debug_str               0000048f  00000000  00000000  00001a24  2**0  CONTENTS, READONLY, DEBUGGING
 13 .debug_loc               00000430  00000000  00000000  00001eb3  2**0  CONTENTS, READONLY, DEBUGGING
 14 .debug_ranges            00000090  00000000  00000000  000022e3  2**0  CONTENTS, READONLY, DEBUGGING

Disassembly of section .text:

00000000 <__vectors>:
   0:	0a c0       	rjmp	.+20     	; 0x16 <__ctors_end>
   2:	19 c0       	rjmp	.+50     	; 0x36 <__bad_interrupt>
   4:	2d c1       	rjmp	.+602    	; 0x260 <__vector_2>
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
  32:	20 d1       	rcall	.+576    	; 0x274 <main>
  34:	9e c1       	rjmp	.+828    	; 0x372 <_exit>

00000036 <__bad_interrupt>:
  36:	e4 cf       	rjmp	.-56     	; 0x0 <__vectors>

00000038 <ws2812_send_single_byte(unsigned char)>:
{
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
  42:	61 f0       	breq	.+24     	; 0x5c <__SREG__+0x1d>
					     "nop \n\t"
					     "cbi %0, %1 \n\t"
					     :
					     : "i" (0x2), "i" (PIN_LED)
					     :
					);
  44:	10 9a       	sbi	0x02, 0	; 2
	...
  4e:	00 00       	nop
  50:	10 98       	cbi	0x02, 0	; 2
	for(uint8_t mask = 0x80; mask != 0; mask >>= 1) {
  52:	66 95       	lsr	r22
  54:	41 50       	subi	r20, 0x01	; 1
  56:	51 0b       	sbc	r21, r17
  58:	91 f7       	brne	.-28     	; 0x3e <__SP_H__>
					     : "i" (0x2), "i" (PIN_LED)
					     :
					);
		}
	}
}
  5a:	08 95       	ret
					);
  5c:	10 9a       	sbi	0x02, 0	; 2
  5e:	00 00       	nop
  60:	10 98       	cbi	0x02, 0	; 2
  62:	00 00       	nop
  64:	00 00       	nop
  66:	f5 cf       	rjmp	.-22     	; 0x52 <__SREG__+0x13>

00000068 <get_channel_brightness(unsigned char, unsigned char)>:
// attenuations that are distinct (plus one, which is NO attenuation '0')
#define MAX_ATTENUATION 53

static inline uint8_t decode_colormask(uint8_t mask)
{
	uint8_t ret = mask << 6;
  68:	82 95       	swap	r24
  6a:	88 0f       	add	r24, r24
  6c:	88 0f       	add	r24, r24
  6e:	80 7c       	andi	r24, 0xC0	; 192
	if(ret == 192)
  70:	80 3c       	cpi	r24, 0xC0	; 192
  72:	09 f4       	brne	.+2      	; 0x76 <get_channel_brightness(unsigned char, unsigned char)+0xe>
		ret = 255;
  74:	8f ef       	ldi	r24, 0xFF	; 255
	return ret;
}

static uint8_t get_channel_brightness(uint8_t channelmask, uint8_t current_attenuation)
{
	uint16_t val = decode_colormask(channelmask);
  76:	90 e0       	ldi	r25, 0x00	; 0
	while(current_attenuation--)
  78:	61 50       	subi	r22, 0x01	; 1
  7a:	98 f0       	brcs	.+38     	; 0xa2 <get_channel_brightness(unsigned char, unsigned char)+0x3a>
		val = ATTENUATION(val);
  7c:	59 2f       	mov	r21, r25
  7e:	48 2f       	mov	r20, r24
  80:	74 e0       	ldi	r23, 0x04	; 4
  82:	44 0f       	add	r20, r20
  84:	55 1f       	adc	r21, r21
  86:	7a 95       	dec	r23
  88:	e1 f7       	brne	.-8      	; 0x82 <get_channel_brightness(unsigned char, unsigned char)+0x1a>
  8a:	f5 2f       	mov	r31, r21
  8c:	e4 2f       	mov	r30, r20
  8e:	e8 1b       	sub	r30, r24
  90:	f9 0b       	sbc	r31, r25
  92:	9f 2f       	mov	r25, r31
  94:	8e 2f       	mov	r24, r30
  96:	e4 e0       	ldi	r30, 0x04	; 4
  98:	96 95       	lsr	r25
  9a:	87 95       	ror	r24
  9c:	ea 95       	dec	r30
  9e:	e1 f7       	brne	.-8      	; 0x98 <get_channel_brightness(unsigned char, unsigned char)+0x30>
	while(current_attenuation--)
  a0:	eb cf       	rjmp	.-42     	; 0x78 <get_channel_brightness(unsigned char, unsigned char)+0x10>
	return val;
}
  a2:	08 95       	ret

000000a4 <calca_set_new_values()>:
static uint8_t calca_width;

static uint8_t light_count;

static void calca_set_new_values(void)
{
  a4:	2f 93       	push	r18
  a6:	3f 93       	push	r19
  a8:	cf 93       	push	r28
  aa:	df 93       	push	r29
  ac:	00 d0       	rcall	.+0      	; 0xae <calca_set_new_values()+0xa>
  ae:	00 d0       	rcall	.+0      	; 0xb0 <calca_set_new_values()+0xc>
  b0:	00 d0       	rcall	.+0      	; 0xb2 <calca_set_new_values()+0xe>
  b2:	cd b7       	in	r28, 0x3d	; 61
  b4:	de b7       	in	r29, 0x3e	; 62
	uint8_t r = get_channel_brightness(calca_color >> 0, calca_attenuation);
  b6:	33 a1       	lds	r19, 0x43	; 0x800043 <calca_attenuation>
  b8:	44 a1       	lds	r20, 0x44	; 0x800044 <calca_color>
  ba:	ce 5f       	subi	r28, 0xFE	; 254
  bc:	df 4f       	sbci	r29, 0xFF	; 255
  be:	48 83       	st	Y, r20
  c0:	c2 50       	subi	r28, 0x02	; 2
  c2:	d0 40       	sbci	r29, 0x00	; 0
  c4:	63 2f       	mov	r22, r19
  c6:	84 2f       	mov	r24, r20
  c8:	cf df       	rcall	.-98     	; 0x68 <get_channel_brightness(unsigned char, unsigned char)>
  ca:	cf 5f       	subi	r28, 0xFF	; 255
  cc:	df 4f       	sbci	r29, 0xFF	; 255
  ce:	88 83       	st	Y, r24
  d0:	c1 50       	subi	r28, 0x01	; 1
  d2:	d0 40       	sbci	r29, 0x00	; 0
	uint8_t g = get_channel_brightness(calca_color >> 2, calca_attenuation);
  d4:	ce 5f       	subi	r28, 0xFE	; 254
  d6:	df 4f       	sbci	r29, 0xFF	; 255
  d8:	58 81       	ld	r21, Y
  da:	c2 50       	subi	r28, 0x02	; 2
  dc:	d0 40       	sbci	r29, 0x00	; 0
  de:	45 2f       	mov	r20, r21
  e0:	50 e0       	ldi	r21, 0x00	; 0
  e2:	cb 5f       	subi	r28, 0xFB	; 251
  e4:	df 4f       	sbci	r29, 0xFF	; 255
  e6:	58 83       	st	Y, r21
  e8:	4a 93       	st	-Y, r20
  ea:	c4 50       	subi	r28, 0x04	; 4
  ec:	d0 40       	sbci	r29, 0x00	; 0
  ee:	95 2f       	mov	r25, r21
  f0:	84 2f       	mov	r24, r20
  f2:	95 95       	asr	r25
  f4:	87 95       	ror	r24
  f6:	95 95       	asr	r25
  f8:	87 95       	ror	r24
  fa:	63 2f       	mov	r22, r19
  fc:	b5 df       	rcall	.-150    	; 0x68 <get_channel_brightness(unsigned char, unsigned char)>
  fe:	ce 5f       	subi	r28, 0xFE	; 254
 100:	df 4f       	sbci	r29, 0xFF	; 255
 102:	88 83       	st	Y, r24
 104:	c2 50       	subi	r28, 0x02	; 2
 106:	d0 40       	sbci	r29, 0x00	; 0
	uint8_t b = get_channel_brightness(calca_color >> 4, calca_attenuation);
 108:	cc 5f       	subi	r28, 0xFC	; 252
 10a:	df 4f       	sbci	r29, 0xFF	; 255
 10c:	89 91       	ld	r24, Y+
 10e:	98 81       	ld	r25, Y
 110:	c5 50       	subi	r28, 0x05	; 5
 112:	d0 40       	sbci	r29, 0x00	; 0
 114:	54 e0       	ldi	r21, 0x04	; 4
 116:	95 95       	asr	r25
 118:	87 95       	ror	r24
 11a:	5a 95       	dec	r21
 11c:	e1 f7       	brne	.-8      	; 0x116 <__DATA_REGION_LENGTH__+0x16>
 11e:	63 2f       	mov	r22, r19
 120:	a3 df       	rcall	.-186    	; 0x68 <get_channel_brightness(unsigned char, unsigned char)>
 122:	cd 5f       	subi	r28, 0xFD	; 253
 124:	df 4f       	sbci	r29, 0xFF	; 255
 126:	88 83       	st	Y, r24
 128:	c3 50       	subi	r28, 0x03	; 3
 12a:	d0 40       	sbci	r29, 0x00	; 0

	uint8_t calca_offpos = calca_pos + calca_width;
 12c:	42 a1       	lds	r20, 0x42	; 0x800042 <calca_pos>
 12e:	31 a1       	lds	r19, 0x41	; 0x800041 <calca_width>
 130:	84 2f       	mov	r24, r20
 132:	83 0f       	add	r24, r19
	uint8_t head_on = (calca_offpos > light_count) ? (calca_offpos % light_count) : 0;
 134:	50 a1       	lds	r21, 0x40	; 0x800040 <_edata>
 136:	cc 5f       	subi	r28, 0xFC	; 252
 138:	df 4f       	sbci	r29, 0xFF	; 255
 13a:	58 83       	st	Y, r21
 13c:	c4 50       	subi	r28, 0x04	; 4
 13e:	d0 40       	sbci	r29, 0x00	; 0
 140:	90 e0       	ldi	r25, 0x00	; 0
 142:	58 17       	cp	r21, r24
 144:	10 f4       	brcc	.+4      	; 0x14a <__DATA_REGION_LENGTH__+0x4a>
 146:	65 2f       	mov	r22, r21
 148:	08 d1       	rcall	.+528    	; 0x35a <__udivmodqi4>
	int8_t head_off = calca_pos - head_on;
	int8_t tail_on = calca_width - head_on;
 14a:	39 1b       	sub	r19, r25
	int8_t tail_off = light_count - head_on - head_off - tail_on;
 14c:	24 2f       	mov	r18, r20
 14e:	29 1b       	sub	r18, r25
 150:	cc 5f       	subi	r28, 0xFC	; 252
 152:	df 4f       	sbci	r29, 0xFF	; 255
 154:	58 81       	ld	r21, Y
 156:	c4 50       	subi	r28, 0x04	; 4
 158:	d0 40       	sbci	r29, 0x00	; 0
 15a:	54 1b       	sub	r21, r20
 15c:	53 1b       	sub	r21, r19
 15e:	cc 5f       	subi	r28, 0xFC	; 252
 160:	df 4f       	sbci	r29, 0xFF	; 255
 162:	58 83       	st	Y, r21
 164:	c4 50       	subi	r28, 0x04	; 4
 166:	d0 40       	sbci	r29, 0x00	; 0

	cli();
 168:	f8 94       	cli
	{
		int8_t i;

		for(i = head_on; i > 0; --i)
 16a:	ca 5f       	subi	r28, 0xFA	; 250
 16c:	df 4f       	sbci	r29, 0xFF	; 255
 16e:	98 83       	st	Y, r25
 170:	c6 50       	subi	r28, 0x06	; 6
 172:	d0 40       	sbci	r29, 0x00	; 0
 174:	ca 5f       	subi	r28, 0xFA	; 250
 176:	df 4f       	sbci	r29, 0xFF	; 255
 178:	48 81       	ld	r20, Y
 17a:	c6 50       	subi	r28, 0x06	; 6
 17c:	d0 40       	sbci	r29, 0x00	; 0
 17e:	14 17       	cp	r17, r20
 180:	f4 f4       	brge	.+60     	; 0x1be <__DATA_REGION_LENGTH__+0xbe>

static inline void ws2812_set_single(uint8_t r, uint8_t g, uint8_t b)
{
	ws2812_send_single_byte(g);
 182:	ce 5f       	subi	r28, 0xFE	; 254
 184:	df 4f       	sbci	r29, 0xFF	; 255
 186:	88 81       	ld	r24, Y
 188:	c2 50       	subi	r28, 0x02	; 2
 18a:	d0 40       	sbci	r29, 0x00	; 0
 18c:	55 df       	rcall	.-342    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 18e:	cf 5f       	subi	r28, 0xFF	; 255
 190:	df 4f       	sbci	r29, 0xFF	; 255
 192:	88 81       	ld	r24, Y
 194:	c1 50       	subi	r28, 0x01	; 1
 196:	d0 40       	sbci	r29, 0x00	; 0
 198:	4f df       	rcall	.-354    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 19a:	cd 5f       	subi	r28, 0xFD	; 253
 19c:	df 4f       	sbci	r29, 0xFF	; 255
 19e:	88 81       	ld	r24, Y
 1a0:	c3 50       	subi	r28, 0x03	; 3
 1a2:	d0 40       	sbci	r29, 0x00	; 0
 1a4:	49 df       	rcall	.-366    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1a6:	ca 5f       	subi	r28, 0xFA	; 250
 1a8:	df 4f       	sbci	r29, 0xFF	; 255
 1aa:	58 81       	ld	r21, Y
 1ac:	c6 50       	subi	r28, 0x06	; 6
 1ae:	d0 40       	sbci	r29, 0x00	; 0
 1b0:	51 50       	subi	r21, 0x01	; 1
 1b2:	ca 5f       	subi	r28, 0xFA	; 250
 1b4:	df 4f       	sbci	r29, 0xFF	; 255
 1b6:	58 83       	st	Y, r21
 1b8:	c6 50       	subi	r28, 0x06	; 6
 1ba:	d0 40       	sbci	r29, 0x00	; 0
 1bc:	db cf       	rjmp	.-74     	; 0x174 <__DATA_REGION_LENGTH__+0x74>
			ws2812_set_single(r, g, b);

		for(i = head_off; i > 0; --i)
 1be:	12 17       	cp	r17, r18
 1c0:	44 f4       	brge	.+16     	; 0x1d2 <__DATA_REGION_LENGTH__+0xd2>
	ws2812_send_single_byte(g);
 1c2:	80 e0       	ldi	r24, 0x00	; 0
 1c4:	39 df       	rcall	.-398    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 1c6:	80 e0       	ldi	r24, 0x00	; 0
 1c8:	37 df       	rcall	.-402    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 1ca:	80 e0       	ldi	r24, 0x00	; 0
 1cc:	35 df       	rcall	.-406    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1ce:	21 50       	subi	r18, 0x01	; 1
 1d0:	f6 cf       	rjmp	.-20     	; 0x1be <__DATA_REGION_LENGTH__+0xbe>
			ws2812_set_single(0, 0, 0);

		for(i = tail_on; i > 0; --i)
 1d2:	13 17       	cp	r17, r19
 1d4:	a4 f4       	brge	.+40     	; 0x1fe <__DATA_REGION_LENGTH__+0xfe>
	ws2812_send_single_byte(g);
 1d6:	ce 5f       	subi	r28, 0xFE	; 254
 1d8:	df 4f       	sbci	r29, 0xFF	; 255
 1da:	88 81       	ld	r24, Y
 1dc:	c2 50       	subi	r28, 0x02	; 2
 1de:	d0 40       	sbci	r29, 0x00	; 0
 1e0:	2b df       	rcall	.-426    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 1e2:	cf 5f       	subi	r28, 0xFF	; 255
 1e4:	df 4f       	sbci	r29, 0xFF	; 255
 1e6:	88 81       	ld	r24, Y
 1e8:	c1 50       	subi	r28, 0x01	; 1
 1ea:	d0 40       	sbci	r29, 0x00	; 0
 1ec:	25 df       	rcall	.-438    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 1ee:	cd 5f       	subi	r28, 0xFD	; 253
 1f0:	df 4f       	sbci	r29, 0xFF	; 255
 1f2:	88 81       	ld	r24, Y
 1f4:	c3 50       	subi	r28, 0x03	; 3
 1f6:	d0 40       	sbci	r29, 0x00	; 0
 1f8:	1f df       	rcall	.-450    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1fa:	31 50       	subi	r19, 0x01	; 1
 1fc:	ea cf       	rjmp	.-44     	; 0x1d2 <__DATA_REGION_LENGTH__+0xd2>
			ws2812_set_single(r, g, b);

		for(i = tail_off; i > 0; --i)
 1fe:	cc 5f       	subi	r28, 0xFC	; 252
 200:	df 4f       	sbci	r29, 0xFF	; 255
 202:	48 81       	ld	r20, Y
 204:	c4 50       	subi	r28, 0x04	; 4
 206:	d0 40       	sbci	r29, 0x00	; 0
 208:	14 17       	cp	r17, r20
 20a:	94 f4       	brge	.+36     	; 0x230 <__DATA_REGION_LENGTH__+0x130>
	ws2812_send_single_byte(g);
 20c:	80 e0       	ldi	r24, 0x00	; 0
 20e:	14 df       	rcall	.-472    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 210:	80 e0       	ldi	r24, 0x00	; 0
 212:	12 df       	rcall	.-476    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 214:	80 e0       	ldi	r24, 0x00	; 0
 216:	10 df       	rcall	.-480    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 218:	cc 5f       	subi	r28, 0xFC	; 252
 21a:	df 4f       	sbci	r29, 0xFF	; 255
 21c:	58 81       	ld	r21, Y
 21e:	c4 50       	subi	r28, 0x04	; 4
 220:	d0 40       	sbci	r29, 0x00	; 0
 222:	51 50       	subi	r21, 0x01	; 1
 224:	cc 5f       	subi	r28, 0xFC	; 252
 226:	df 4f       	sbci	r29, 0xFF	; 255
 228:	58 83       	st	Y, r21
 22a:	c4 50       	subi	r28, 0x04	; 4
 22c:	d0 40       	sbci	r29, 0x00	; 0
 22e:	e7 cf       	rjmp	.-50     	; 0x1fe <__DATA_REGION_LENGTH__+0xfe>
			ws2812_set_single(0, 0, 0);
	}
	sei();
 230:	78 94       	sei
}
 232:	0f 91       	pop	r16
 234:	0f 91       	pop	r16
 236:	0f 91       	pop	r16
 238:	0f 91       	pop	r16
 23a:	0f 91       	pop	r16
 23c:	0f 91       	pop	r16
 23e:	df 91       	pop	r29
 240:	cf 91       	pop	r28
 242:	3f 91       	pop	r19
 244:	2f 91       	pop	r18
 246:	08 95       	ret

00000248 <calca_init()>:
# error Only <= 126 lights are supported
#endif

static void calca_init(void)
{
	light_count = LIGHT_COUNT;
 248:	42 e2       	ldi	r20, 0x22	; 34
 24a:	40 a9       	sts	0x40, r20	; 0x800040 <_edata>
	DDRB |= (1 << PIN_LED);
 24c:	08 9a       	sbi	0x01, 0	; 1
	ws2812_init();

	calca_mode = MODE_ATTENUATION;
 24e:	15 a9       	sts	0x45, r17	; 0x800045 <calca_mode>
	calca_color = 0x3;
 250:	43 e0       	ldi	r20, 0x03	; 3
 252:	44 a9       	sts	0x44, r20	; 0x800044 <calca_color>
	calca_attenuation = MAX_ATTENUATION-1;
 254:	44 e3       	ldi	r20, 0x34	; 52
 256:	43 a9       	sts	0x43, r20	; 0x800043 <calca_attenuation>
	calca_pos = 0;
 258:	12 a9       	sts	0x42, r17	; 0x800042 <calca_pos>
	calca_width = light_count;
 25a:	40 a1       	lds	r20, 0x40	; 0x800040 <_edata>
 25c:	41 a9       	sts	0x41, r20	; 0x800041 <calca_width>

	calca_set_new_values();
 25e:	22 cf       	rjmp	.-444    	; 0xa4 <calca_set_new_values()>

00000260 <__vector_2>:
		previous_io = current_io;
	}
}

ISR(PCINT0_vect)
{ /* this just pulls us out of sleep mode */ }
 260:	1f 93       	push	r17
 262:	0f 93       	push	r16
 264:	0f b7       	in	r16, 0x3f	; 63
 266:	0f 93       	push	r16
 268:	10 e0       	ldi	r17, 0x00	; 0
 26a:	0f 91       	pop	r16
 26c:	0f bf       	out	0x3f, r16	; 63
 26e:	0f 91       	pop	r16
 270:	1f 91       	pop	r17
 272:	18 95       	reti

00000274 <main>:
	CCP = 0xD8;		// allow writes to CLKPSR
 274:	48 ed       	ldi	r20, 0xD8	; 216
 276:	4c bf       	out	0x3c, r20	; 60
	CLKPSR = 0;		// disable system clock prescaler
 278:	16 bf       	out	0x36, r17	; 54
	SMCR = 0;
 27a:	1a bf       	out	0x3a, r17	; 58
	PRR = (1 << PRADC) | (1 << PRTIM0);
 27c:	43 e0       	ldi	r20, 0x03	; 3
 27e:	45 bf       	out	0x35, r20	; 53
	DIDR0 = ~EVENT_MASK;
 280:	41 ef       	ldi	r20, 0xF1	; 241
 282:	47 bb       	out	0x17, r20	; 23
	DDRB &= ~EVENT_MASK;
 284:	41 b1       	in	r20, 0x01	; 1
 286:	41 7f       	andi	r20, 0xF1	; 241
 288:	41 b9       	out	0x01, r20	; 1
	PUEB = EVENT_MASK;
 28a:	4e e0       	ldi	r20, 0x0E	; 14
 28c:	43 b9       	out	0x03, r20	; 3
	PCICR |= (1 << PCIE0);
 28e:	90 9a       	sbi	0x12, 0	; 18
	PCMSK |= EVENT_MASK;
 290:	40 b3       	in	r20, 0x10	; 16
 292:	4e 60       	ori	r20, 0x0E	; 14
 294:	40 bb       	out	0x10, r20	; 16
	calca_init(); // activates interrupts
 296:	d8 df       	rcall	.-80     	; 0x248 <calca_init()>
	uint8_t previous_io = EVENT_MASK;
 298:	4e e0       	ldi	r20, 0x0E	; 14
		sleep_mode(); // will return once interrupted by ISR.
 29a:	5a b7       	in	r21, 0x3a	; 58
 29c:	51 60       	ori	r21, 0x01	; 1
 29e:	5a bf       	out	0x3a, r21	; 58
 2a0:	88 95       	sleep
 2a2:	5a b7       	in	r21, 0x3a	; 58
 2a4:	5e 7f       	andi	r21, 0xFE	; 254
 2a6:	5a bf       	out	0x3a, r21	; 58
		uint8_t current_io = PINB & EVENT_MASK;
 2a8:	50 b1       	in	r21, 0x00	; 0
 2aa:	c5 2f       	mov	r28, r21
 2ac:	ce 70       	andi	r28, 0x0E	; 14
		uint8_t changed_io = (current_io ^ previous_io);
 2ae:	64 2f       	mov	r22, r20
 2b0:	6c 27       	eor	r22, r28
		if((changed_io & ROTARY_MASK) && (0 == (previous_io & ROTARY_MASK))) {
 2b2:	76 2f       	mov	r23, r22
 2b4:	76 70       	andi	r23, 0x06	; 6
 2b6:	b9 f1       	breq	.+110    	; 0x326 <main+0xb2>
 2b8:	46 70       	andi	r20, 0x06	; 6
 2ba:	a9 f5       	brne	.+106    	; 0x326 <main+0xb2>
			calca_rotary_step( (current_io & (1 << PIN_ROTARY2)) ? 1 : -1);
 2bc:	6f ef       	ldi	r22, 0xFF	; 255
 2be:	52 fd       	sbrc	r21, 2
 2c0:	61 e0       	ldi	r22, 0x01	; 1
}

static inline void calca_rotary_step(int8_t dir)
{

	switch(calca_mode) {
 2c2:	55 a1       	lds	r21, 0x45	; 0x800045 <calca_mode>
 2c4:	51 30       	cpi	r21, 0x01	; 1
 2c6:	f1 f0       	breq	.+60     	; 0x304 <main+0x90>
 2c8:	90 f0       	brcs	.+36     	; 0x2ee <main+0x7a>
 2ca:	40 a1       	lds	r20, 0x40	; 0x800040 <_edata>
 2cc:	52 30       	cpi	r21, 0x02	; 2
 2ce:	f1 f0       	breq	.+60     	; 0x30c <main+0x98>
			calca_width = check_bounds(calca_width + dir, 1, light_count);
			break;
		default:
		case MODE_SPOTPOS:
			int16_t new_pos;
			new_pos = calca_pos;
 2d0:	82 a1       	lds	r24, 0x42	; 0x800042 <calca_pos>
			new_pos += light_count;
 2d2:	50 e0       	ldi	r21, 0x00	; 0
 2d4:	84 0f       	add	r24, r20
 2d6:	95 2f       	mov	r25, r21
 2d8:	91 1f       	adc	r25, r17
			new_pos += dir;
 2da:	86 0f       	add	r24, r22
 2dc:	91 1f       	adc	r25, r17
 2de:	67 fd       	sbrc	r22, 7
 2e0:	9a 95       	dec	r25
			while(new_pos > light_count)
 2e2:	48 17       	cp	r20, r24
 2e4:	59 07       	cpc	r21, r25
 2e6:	ec f4       	brge	.+58     	; 0x322 <main+0xae>
				new_pos -= light_count;
 2e8:	84 1b       	sub	r24, r20
 2ea:	95 0b       	sbc	r25, r21
 2ec:	fa cf       	rjmp	.-12     	; 0x2e2 <main+0x6e>
			calca_attenuation = check_bounds(calca_attenuation - dir, 0, MAX_ATTENUATION);
 2ee:	43 a1       	lds	r20, 0x43	; 0x800043 <calca_attenuation>
 2f0:	46 1b       	sub	r20, r22
 2f2:	46 33       	cpi	r20, 0x36	; 54
 2f4:	0c f0       	brlt	.+2      	; 0x2f8 <main+0x84>
 2f6:	45 e3       	ldi	r20, 0x35	; 53
 2f8:	47 fd       	sbrc	r20, 7
 2fa:	40 e0       	ldi	r20, 0x00	; 0
 2fc:	43 a9       	sts	0x43, r20	; 0x800043 <calca_attenuation>
			calca_pos = new_pos;
			break;
	};

	calca_set_new_values();
 2fe:	d2 de       	rcall	.-604    	; 0xa4 <calca_set_new_values()>
{
 300:	4c 2f       	mov	r20, r28
 302:	cb cf       	rjmp	.-106    	; 0x29a <main+0x26>
			calca_color += dir;
 304:	44 a1       	lds	r20, 0x44	; 0x800044 <calca_color>
 306:	64 0f       	add	r22, r20
 308:	64 a9       	sts	0x44, r22	; 0x800044 <calca_color>
 30a:	f9 cf       	rjmp	.-14     	; 0x2fe <main+0x8a>
			calca_width = check_bounds(calca_width + dir, 1, light_count);
 30c:	51 a1       	lds	r21, 0x41	; 0x800041 <calca_width>
 30e:	65 0f       	add	r22, r21
	return (value < lower) ? lower :
 310:	16 17       	cp	r17, r22
 312:	2c f4       	brge	.+10     	; 0x31e <main+0xaa>
 314:	64 17       	cp	r22, r20
 316:	0c f4       	brge	.+2      	; 0x31a <main+0xa6>
 318:	46 2f       	mov	r20, r22
			calca_width = check_bounds(calca_width + dir, 1, light_count);
 31a:	41 a9       	sts	0x41, r20	; 0x800041 <calca_width>
 31c:	f0 cf       	rjmp	.-32     	; 0x2fe <main+0x8a>
	return (value < lower) ? lower :
 31e:	41 e0       	ldi	r20, 0x01	; 1
 320:	fc cf       	rjmp	.-8      	; 0x31a <main+0xa6>
			calca_pos = new_pos;
 322:	82 a9       	sts	0x42, r24	; 0x800042 <calca_pos>
 324:	ec cf       	rjmp	.-40     	; 0x2fe <main+0x8a>
		} else if(changed_io & SWITCH_MASK) {
 326:	63 ff       	sbrs	r22, 3
 328:	eb cf       	rjmp	.-42     	; 0x300 <main+0x8c>
			if(!(current_io & SWITCH_MASK)) {
 32a:	53 fd       	sbrc	r21, 3
 32c:	0d c0       	rjmp	.+26     	; 0x348 <main+0xd4>
	calca_mode++;
 32e:	45 a1       	lds	r20, 0x45	; 0x800045 <calca_mode>
 330:	4f 5f       	subi	r20, 0xFF	; 255
	calca_mode %= MODECOUNT;
 332:	43 70       	andi	r20, 0x03	; 3
 334:	45 a9       	sts	0x45, r20	; 0x800045 <calca_mode>
				PRR = (1 << PRADC);
 336:	42 e0       	ldi	r20, 0x02	; 2
 338:	45 bf       	out	0x35, r20	; 53
				TCCR0A = 0;
 33a:	1e bd       	out	0x2e, r17	; 46
				TCCR0C = 0;
 33c:	1c bd       	out	0x2c, r17	; 44
				TCCR0B = 0x5; // TimerCLK is IoCLK/1024
 33e:	45 e0       	ldi	r20, 0x05	; 5
 340:	4d bd       	out	0x2d, r20	; 45
				TCNT0 = 0;
 342:	19 bd       	out	0x29, r17	; 41
 344:	18 bd       	out	0x28, r17	; 40
 346:	dc cf       	rjmp	.-72     	; 0x300 <main+0x8c>
				if(TCNT0 > 2604) // pressed for more than ~1/3 second
 348:	48 b5       	in	r20, 0x28	; 40
 34a:	59 b5       	in	r21, 0x29	; 41
 34c:	4d 32       	cpi	r20, 0x2D	; 45
 34e:	5a 40       	sbci	r21, 0x0A	; 10
 350:	08 f0       	brcs	.+2      	; 0x354 <main+0xe0>
					calca_init();
 352:	7a df       	rcall	.-268    	; 0x248 <calca_init()>
				PRR = (1 << PRADC) | (1 << PRTIM0);
 354:	43 e0       	ldi	r20, 0x03	; 3
 356:	45 bf       	out	0x35, r20	; 53
 358:	d3 cf       	rjmp	.-90     	; 0x300 <main+0x8c>

0000035a <__udivmodqi4>:
 35a:	99 1b       	sub	r25, r25
 35c:	79 e0       	ldi	r23, 0x09	; 9
 35e:	04 c0       	rjmp	.+8      	; 0x368 <__udivmodqi4_ep>

00000360 <__udivmodqi4_loop>:
 360:	99 1f       	adc	r25, r25
 362:	96 17       	cp	r25, r22
 364:	08 f0       	brcs	.+2      	; 0x368 <__udivmodqi4_ep>
 366:	96 1b       	sub	r25, r22

00000368 <__udivmodqi4_ep>:
 368:	88 1f       	adc	r24, r24
 36a:	7a 95       	dec	r23
 36c:	c9 f7       	brne	.-14     	; 0x360 <__udivmodqi4_loop>
 36e:	80 95       	com	r24
 370:	08 95       	ret

00000372 <_exit>:
 372:	f8 94       	cli

00000374 <__stop_program>:
 374:	ff cf       	rjmp	.-2      	; 0x374 <__stop_program>
