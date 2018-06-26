
desklight.elf:     file format elf32-avr

Sections:
Idx Name                     Size      VMA       LMA       File off  Algn  Flags
  0 .text                    00000362  00000000  00000000  00000094  2**1  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data                    00000000  00800040  00000362  000003f6  2**0  CONTENTS, ALLOC, LOAD, DATA
  2 .bss                     00000006  00800040  00800040  000003f6  2**0  ALLOC
  3 .stab                    00000210  00000000  00000000  000003f8  2**2  CONTENTS, READONLY, DEBUGGING
  4 .stabstr                 00000133  00000000  00000000  00000608  2**0  CONTENTS, READONLY, DEBUGGING
  5 .comment                 00000022  00000000  00000000  0000073b  2**0  CONTENTS, READONLY
  6 .note.gnu.avr.deviceinfo 0000003c  00000000  00000000  00000760  2**2  CONTENTS, READONLY
  7 .debug_aranges           00000028  00000000  00000000  0000079c  2**0  CONTENTS, READONLY, DEBUGGING
  8 .debug_info              00000906  00000000  00000000  000007c4  2**0  CONTENTS, READONLY, DEBUGGING
  9 .debug_abbrev            000004fa  00000000  00000000  000010ca  2**0  CONTENTS, READONLY, DEBUGGING
 10 .debug_line              0000035b  00000000  00000000  000015c4  2**0  CONTENTS, READONLY, DEBUGGING
 11 .debug_frame             000000a0  00000000  00000000  00001920  2**2  CONTENTS, READONLY, DEBUGGING
 12 .debug_str               00000487  00000000  00000000  000019c0  2**0  CONTENTS, READONLY, DEBUGGING
 13 .debug_loc               0000040e  00000000  00000000  00001e47  2**0  CONTENTS, READONLY, DEBUGGING
 14 .debug_ranges            00000078  00000000  00000000  00002255  2**0  CONTENTS, READONLY, DEBUGGING

Disassembly of section .text:

00000000 <__vectors>:
   0:	0a c0       	rjmp	.+20     	; 0x16 <__ctors_end>
   2:	19 c0       	rjmp	.+50     	; 0x36 <__bad_interrupt>
   4:	29 c1       	rjmp	.+594    	; 0x258 <__vector_2>
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
  32:	1c d1       	rcall	.+568    	; 0x26c <main>
  34:	94 c1       	rjmp	.+808    	; 0x35e <_exit>

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
// attenuations that are distinct (plus one, which is NO attenuation '0')
#define MAX_ATTENUATION 53

static inline uint8_t decode_colormask(uint8_t mask)
{
	uint8_t ret = mask << 6;
  60:	82 95       	swap	r24
  62:	88 0f       	add	r24, r24
  64:	88 0f       	add	r24, r24
  66:	80 7c       	andi	r24, 0xC0	; 192
	if(ret == 192)
  68:	80 3c       	cpi	r24, 0xC0	; 192
  6a:	09 f4       	brne	.+2      	; 0x6e <get_channel_brightness(unsigned char, unsigned char)+0xe>
		ret = 255;
  6c:	8f ef       	ldi	r24, 0xFF	; 255
	return ret;
}

static uint8_t get_channel_brightness(uint8_t channelmask, uint8_t current_attenuation)
{
	uint16_t val = decode_colormask(channelmask);
  6e:	90 e0       	ldi	r25, 0x00	; 0
	while(current_attenuation--)
  70:	61 50       	subi	r22, 0x01	; 1
  72:	98 f0       	brcs	.+38     	; 0x9a <get_channel_brightness(unsigned char, unsigned char)+0x3a>
		val = ATTENUATION(val);
  74:	59 2f       	mov	r21, r25
  76:	48 2f       	mov	r20, r24
  78:	74 e0       	ldi	r23, 0x04	; 4
  7a:	44 0f       	add	r20, r20
  7c:	55 1f       	adc	r21, r21
  7e:	7a 95       	dec	r23
  80:	e1 f7       	brne	.-8      	; 0x7a <get_channel_brightness(unsigned char, unsigned char)+0x1a>
  82:	f5 2f       	mov	r31, r21
  84:	e4 2f       	mov	r30, r20
  86:	e8 1b       	sub	r30, r24
  88:	f9 0b       	sbc	r31, r25
  8a:	9f 2f       	mov	r25, r31
  8c:	8e 2f       	mov	r24, r30
  8e:	e4 e0       	ldi	r30, 0x04	; 4
  90:	96 95       	lsr	r25
  92:	87 95       	ror	r24
  94:	ea 95       	dec	r30
  96:	e1 f7       	brne	.-8      	; 0x90 <get_channel_brightness(unsigned char, unsigned char)+0x30>
	while(current_attenuation--)
  98:	eb cf       	rjmp	.-42     	; 0x70 <get_channel_brightness(unsigned char, unsigned char)+0x10>
	return val;
}
  9a:	08 95       	ret

0000009c <calca_set_new_values()>:
static int8_t calca_attenuation;
static uint8_t calca_pos;
static uint8_t calca_width;

static void calca_set_new_values(void)
{
  9c:	2f 93       	push	r18
  9e:	3f 93       	push	r19
  a0:	cf 93       	push	r28
  a2:	df 93       	push	r29
  a4:	00 d0       	rcall	.+0      	; 0xa6 <calca_set_new_values()+0xa>
  a6:	00 d0       	rcall	.+0      	; 0xa8 <calca_set_new_values()+0xc>
  a8:	00 d0       	rcall	.+0      	; 0xaa <calca_set_new_values()+0xe>
  aa:	cd b7       	in	r28, 0x3d	; 61
  ac:	de b7       	in	r29, 0x3e	; 62
	uint8_t r = get_channel_brightness(calca_color >> 0, calca_attenuation);
  ae:	33 a1       	lds	r19, 0x43	; 0x800043 <calca_attenuation>
  b0:	44 a1       	lds	r20, 0x44	; 0x800044 <calca_color>
  b2:	ce 5f       	subi	r28, 0xFE	; 254
  b4:	df 4f       	sbci	r29, 0xFF	; 255
  b6:	48 83       	st	Y, r20
  b8:	c2 50       	subi	r28, 0x02	; 2
  ba:	d0 40       	sbci	r29, 0x00	; 0
  bc:	63 2f       	mov	r22, r19
  be:	84 2f       	mov	r24, r20
  c0:	cf df       	rcall	.-98     	; 0x60 <get_channel_brightness(unsigned char, unsigned char)>
  c2:	cf 5f       	subi	r28, 0xFF	; 255
  c4:	df 4f       	sbci	r29, 0xFF	; 255
  c6:	88 83       	st	Y, r24
  c8:	c1 50       	subi	r28, 0x01	; 1
  ca:	d0 40       	sbci	r29, 0x00	; 0
	uint8_t g = get_channel_brightness(calca_color >> 2, calca_attenuation);
  cc:	ce 5f       	subi	r28, 0xFE	; 254
  ce:	df 4f       	sbci	r29, 0xFF	; 255
  d0:	58 81       	ld	r21, Y
  d2:	c2 50       	subi	r28, 0x02	; 2
  d4:	d0 40       	sbci	r29, 0x00	; 0
  d6:	45 2f       	mov	r20, r21
  d8:	50 e0       	ldi	r21, 0x00	; 0
  da:	cb 5f       	subi	r28, 0xFB	; 251
  dc:	df 4f       	sbci	r29, 0xFF	; 255
  de:	58 83       	st	Y, r21
  e0:	4a 93       	st	-Y, r20
  e2:	c4 50       	subi	r28, 0x04	; 4
  e4:	d0 40       	sbci	r29, 0x00	; 0
  e6:	95 2f       	mov	r25, r21
  e8:	84 2f       	mov	r24, r20
  ea:	95 95       	asr	r25
  ec:	87 95       	ror	r24
  ee:	95 95       	asr	r25
  f0:	87 95       	ror	r24
  f2:	63 2f       	mov	r22, r19
  f4:	b5 df       	rcall	.-150    	; 0x60 <get_channel_brightness(unsigned char, unsigned char)>
  f6:	ce 5f       	subi	r28, 0xFE	; 254
  f8:	df 4f       	sbci	r29, 0xFF	; 255
  fa:	88 83       	st	Y, r24
  fc:	c2 50       	subi	r28, 0x02	; 2
  fe:	d0 40       	sbci	r29, 0x00	; 0
	uint8_t b = get_channel_brightness(calca_color >> 4, calca_attenuation);
 100:	cc 5f       	subi	r28, 0xFC	; 252
 102:	df 4f       	sbci	r29, 0xFF	; 255
 104:	89 91       	ld	r24, Y+
 106:	98 81       	ld	r25, Y
 108:	c5 50       	subi	r28, 0x05	; 5
 10a:	d0 40       	sbci	r29, 0x00	; 0
 10c:	54 e0       	ldi	r21, 0x04	; 4
 10e:	95 95       	asr	r25
 110:	87 95       	ror	r24
 112:	5a 95       	dec	r21
 114:	e1 f7       	brne	.-8      	; 0x10e <__DATA_REGION_LENGTH__+0xe>
 116:	63 2f       	mov	r22, r19
 118:	a3 df       	rcall	.-186    	; 0x60 <get_channel_brightness(unsigned char, unsigned char)>
 11a:	cd 5f       	subi	r28, 0xFD	; 253
 11c:	df 4f       	sbci	r29, 0xFF	; 255
 11e:	88 83       	st	Y, r24
 120:	c3 50       	subi	r28, 0x03	; 3
 122:	d0 40       	sbci	r29, 0x00	; 0

	uint8_t calca_offpos = calca_pos + calca_width;
 124:	42 a1       	lds	r20, 0x42	; 0x800042 <calca_pos>
 126:	31 a1       	lds	r19, 0x41	; 0x800041 <calca_width>
 128:	84 2f       	mov	r24, r20
 12a:	83 0f       	add	r24, r19
	uint8_t head_on = (calca_offpos > light_count) ? (calca_offpos % light_count) : 0;
 12c:	50 a1       	lds	r21, 0x40	; 0x800040 <_edata>
 12e:	cc 5f       	subi	r28, 0xFC	; 252
 130:	df 4f       	sbci	r29, 0xFF	; 255
 132:	58 83       	st	Y, r21
 134:	c4 50       	subi	r28, 0x04	; 4
 136:	d0 40       	sbci	r29, 0x00	; 0
 138:	90 e0       	ldi	r25, 0x00	; 0
 13a:	58 17       	cp	r21, r24
 13c:	10 f4       	brcc	.+4      	; 0x142 <__DATA_REGION_LENGTH__+0x42>
 13e:	65 2f       	mov	r22, r21
 140:	02 d1       	rcall	.+516    	; 0x346 <__udivmodqi4>
	int8_t head_off = calca_pos - head_on;
	int8_t tail_on = calca_width - head_on;
 142:	39 1b       	sub	r19, r25
	int8_t tail_off = light_count - head_on - head_off - tail_on;
 144:	24 2f       	mov	r18, r20
 146:	29 1b       	sub	r18, r25
 148:	cc 5f       	subi	r28, 0xFC	; 252
 14a:	df 4f       	sbci	r29, 0xFF	; 255
 14c:	58 81       	ld	r21, Y
 14e:	c4 50       	subi	r28, 0x04	; 4
 150:	d0 40       	sbci	r29, 0x00	; 0
 152:	54 1b       	sub	r21, r20
 154:	53 1b       	sub	r21, r19
 156:	cc 5f       	subi	r28, 0xFC	; 252
 158:	df 4f       	sbci	r29, 0xFF	; 255
 15a:	58 83       	st	Y, r21
 15c:	c4 50       	subi	r28, 0x04	; 4
 15e:	d0 40       	sbci	r29, 0x00	; 0

	cli();
 160:	f8 94       	cli
	{
		int8_t i;

		for(i = head_on; i > 0; --i)
 162:	ca 5f       	subi	r28, 0xFA	; 250
 164:	df 4f       	sbci	r29, 0xFF	; 255
 166:	98 83       	st	Y, r25
 168:	c6 50       	subi	r28, 0x06	; 6
 16a:	d0 40       	sbci	r29, 0x00	; 0
 16c:	ca 5f       	subi	r28, 0xFA	; 250
 16e:	df 4f       	sbci	r29, 0xFF	; 255
 170:	48 81       	ld	r20, Y
 172:	c6 50       	subi	r28, 0x06	; 6
 174:	d0 40       	sbci	r29, 0x00	; 0
 176:	14 17       	cp	r17, r20
 178:	f4 f4       	brge	.+60     	; 0x1b6 <__DATA_REGION_LENGTH__+0xb6>

static inline void ws2812_set_single(uint8_t r, uint8_t g, uint8_t b)
{
	ws2812_send_single_byte(g);
 17a:	ce 5f       	subi	r28, 0xFE	; 254
 17c:	df 4f       	sbci	r29, 0xFF	; 255
 17e:	88 81       	ld	r24, Y
 180:	c2 50       	subi	r28, 0x02	; 2
 182:	d0 40       	sbci	r29, 0x00	; 0
 184:	59 df       	rcall	.-334    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 186:	cf 5f       	subi	r28, 0xFF	; 255
 188:	df 4f       	sbci	r29, 0xFF	; 255
 18a:	88 81       	ld	r24, Y
 18c:	c1 50       	subi	r28, 0x01	; 1
 18e:	d0 40       	sbci	r29, 0x00	; 0
 190:	53 df       	rcall	.-346    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 192:	cd 5f       	subi	r28, 0xFD	; 253
 194:	df 4f       	sbci	r29, 0xFF	; 255
 196:	88 81       	ld	r24, Y
 198:	c3 50       	subi	r28, 0x03	; 3
 19a:	d0 40       	sbci	r29, 0x00	; 0
 19c:	4d df       	rcall	.-358    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 19e:	ca 5f       	subi	r28, 0xFA	; 250
 1a0:	df 4f       	sbci	r29, 0xFF	; 255
 1a2:	58 81       	ld	r21, Y
 1a4:	c6 50       	subi	r28, 0x06	; 6
 1a6:	d0 40       	sbci	r29, 0x00	; 0
 1a8:	51 50       	subi	r21, 0x01	; 1
 1aa:	ca 5f       	subi	r28, 0xFA	; 250
 1ac:	df 4f       	sbci	r29, 0xFF	; 255
 1ae:	58 83       	st	Y, r21
 1b0:	c6 50       	subi	r28, 0x06	; 6
 1b2:	d0 40       	sbci	r29, 0x00	; 0
 1b4:	db cf       	rjmp	.-74     	; 0x16c <__DATA_REGION_LENGTH__+0x6c>
			ws2812_set_single(r, g, b);

		for(i = head_off; i > 0; --i)
 1b6:	12 17       	cp	r17, r18
 1b8:	44 f4       	brge	.+16     	; 0x1ca <__DATA_REGION_LENGTH__+0xca>
	ws2812_send_single_byte(g);
 1ba:	80 e0       	ldi	r24, 0x00	; 0
 1bc:	3d df       	rcall	.-390    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 1be:	80 e0       	ldi	r24, 0x00	; 0
 1c0:	3b df       	rcall	.-394    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 1c2:	80 e0       	ldi	r24, 0x00	; 0
 1c4:	39 df       	rcall	.-398    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1c6:	21 50       	subi	r18, 0x01	; 1
 1c8:	f6 cf       	rjmp	.-20     	; 0x1b6 <__DATA_REGION_LENGTH__+0xb6>
			ws2812_set_single(0, 0, 0);

		for(i = tail_on; i > 0; --i)
 1ca:	13 17       	cp	r17, r19
 1cc:	a4 f4       	brge	.+40     	; 0x1f6 <__DATA_REGION_LENGTH__+0xf6>
	ws2812_send_single_byte(g);
 1ce:	ce 5f       	subi	r28, 0xFE	; 254
 1d0:	df 4f       	sbci	r29, 0xFF	; 255
 1d2:	88 81       	ld	r24, Y
 1d4:	c2 50       	subi	r28, 0x02	; 2
 1d6:	d0 40       	sbci	r29, 0x00	; 0
 1d8:	2f df       	rcall	.-418    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 1da:	cf 5f       	subi	r28, 0xFF	; 255
 1dc:	df 4f       	sbci	r29, 0xFF	; 255
 1de:	88 81       	ld	r24, Y
 1e0:	c1 50       	subi	r28, 0x01	; 1
 1e2:	d0 40       	sbci	r29, 0x00	; 0
 1e4:	29 df       	rcall	.-430    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 1e6:	cd 5f       	subi	r28, 0xFD	; 253
 1e8:	df 4f       	sbci	r29, 0xFF	; 255
 1ea:	88 81       	ld	r24, Y
 1ec:	c3 50       	subi	r28, 0x03	; 3
 1ee:	d0 40       	sbci	r29, 0x00	; 0
 1f0:	23 df       	rcall	.-442    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 1f2:	31 50       	subi	r19, 0x01	; 1
 1f4:	ea cf       	rjmp	.-44     	; 0x1ca <__DATA_REGION_LENGTH__+0xca>
			ws2812_set_single(r, g, b);

		for(i = tail_off; i > 0; --i)
 1f6:	cc 5f       	subi	r28, 0xFC	; 252
 1f8:	df 4f       	sbci	r29, 0xFF	; 255
 1fa:	48 81       	ld	r20, Y
 1fc:	c4 50       	subi	r28, 0x04	; 4
 1fe:	d0 40       	sbci	r29, 0x00	; 0
 200:	14 17       	cp	r17, r20
 202:	94 f4       	brge	.+36     	; 0x228 <__DATA_REGION_LENGTH__+0x128>
	ws2812_send_single_byte(g);
 204:	80 e0       	ldi	r24, 0x00	; 0
 206:	18 df       	rcall	.-464    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(r);
 208:	80 e0       	ldi	r24, 0x00	; 0
 20a:	16 df       	rcall	.-468    	; 0x38 <ws2812_send_single_byte(unsigned char)>
	ws2812_send_single_byte(b);
 20c:	80 e0       	ldi	r24, 0x00	; 0
 20e:	14 df       	rcall	.-472    	; 0x38 <ws2812_send_single_byte(unsigned char)>
 210:	cc 5f       	subi	r28, 0xFC	; 252
 212:	df 4f       	sbci	r29, 0xFF	; 255
 214:	58 81       	ld	r21, Y
 216:	c4 50       	subi	r28, 0x04	; 4
 218:	d0 40       	sbci	r29, 0x00	; 0
 21a:	51 50       	subi	r21, 0x01	; 1
 21c:	cc 5f       	subi	r28, 0xFC	; 252
 21e:	df 4f       	sbci	r29, 0xFF	; 255
 220:	58 83       	st	Y, r21
 222:	c4 50       	subi	r28, 0x04	; 4
 224:	d0 40       	sbci	r29, 0x00	; 0
 226:	e7 cf       	rjmp	.-50     	; 0x1f6 <__DATA_REGION_LENGTH__+0xf6>
			ws2812_set_single(0, 0, 0);
	}
	sei();
 228:	78 94       	sei
}
 22a:	0f 91       	pop	r16
 22c:	0f 91       	pop	r16
 22e:	0f 91       	pop	r16
 230:	0f 91       	pop	r16
 232:	0f 91       	pop	r16
 234:	0f 91       	pop	r16
 236:	df 91       	pop	r29
 238:	cf 91       	pop	r28
 23a:	3f 91       	pop	r19
 23c:	2f 91       	pop	r18
 23e:	08 95       	ret

00000240 <calca_init()>:
	light_count = LIGHT_COUNT;
 240:	42 e2       	ldi	r20, 0x22	; 34
 242:	40 a9       	sts	0x40, r20	; 0x800040 <_edata>
	DDRB |= (1 << PIN_LED);
 244:	08 9a       	sbi	0x01, 0	; 1

static void calca_init(void)
{
	ws2812_init();

	calca_mode = MODE_ATTENUATION;
 246:	15 a9       	sts	0x45, r17	; 0x800045 <calca_mode>
	calca_color = 0x3;
 248:	43 e0       	ldi	r20, 0x03	; 3
 24a:	44 a9       	sts	0x44, r20	; 0x800044 <calca_color>
	calca_attenuation = MAX_ATTENUATION-1;
 24c:	44 e3       	ldi	r20, 0x34	; 52
 24e:	43 a9       	sts	0x43, r20	; 0x800043 <calca_attenuation>
	calca_pos = 0;
 250:	12 a9       	sts	0x42, r17	; 0x800042 <calca_pos>
	calca_width = light_count;
 252:	40 a1       	lds	r20, 0x40	; 0x800040 <_edata>
 254:	41 a9       	sts	0x41, r20	; 0x800041 <calca_width>

	calca_set_new_values();
 256:	22 cf       	rjmp	.-444    	; 0x9c <calca_set_new_values()>

00000258 <__vector_2>:
		previous_io = current_io;
	}
}

ISR(PCINT0_vect)
{ /* this just pulls us out of sleep mode */ }
 258:	1f 93       	push	r17
 25a:	0f 93       	push	r16
 25c:	0f b7       	in	r16, 0x3f	; 63
 25e:	0f 93       	push	r16
 260:	10 e0       	ldi	r17, 0x00	; 0
 262:	0f 91       	pop	r16
 264:	0f bf       	out	0x3f, r16	; 63
 266:	0f 91       	pop	r16
 268:	1f 91       	pop	r17
 26a:	18 95       	reti

0000026c <main>:
	CCP = 0xD8;		// allow writes to CLKPSR
 26c:	48 ed       	ldi	r20, 0xD8	; 216
 26e:	4c bf       	out	0x3c, r20	; 60
	CLKPSR = 0;		// disable prescaler
 270:	16 bf       	out	0x36, r17	; 54
	CCP = 0xD8;		// allow writes to CLKPSR
 272:	4c bf       	out	0x3c, r20	; 60
	CLKMSR = 0x0U;		// select internal 8MHz oscillator
 274:	17 bf       	out	0x37, r17	; 55
	SMCR = 0;
 276:	1a bf       	out	0x3a, r17	; 58
	PRR |= (1 << PRADC) | (1 << PRTIM0);
 278:	45 b7       	in	r20, 0x35	; 53
 27a:	43 60       	ori	r20, 0x03	; 3
 27c:	45 bf       	out	0x35, r20	; 53
	DIDR0 = ~EVENT_MASK;
 27e:	41 ef       	ldi	r20, 0xF1	; 241
 280:	47 bb       	out	0x17, r20	; 23
	DDRB &= ~EVENT_MASK;
 282:	41 b1       	in	r20, 0x01	; 1
 284:	41 7f       	andi	r20, 0xF1	; 241
 286:	41 b9       	out	0x01, r20	; 1
	PUEB = EVENT_MASK;
 288:	4e e0       	ldi	r20, 0x0E	; 14
 28a:	43 b9       	out	0x03, r20	; 3
	PCICR |= (1 << PCIE0);
 28c:	90 9a       	sbi	0x12, 0	; 18
	PCMSK |= EVENT_MASK;
 28e:	40 b3       	in	r20, 0x10	; 16
 290:	4e 60       	ori	r20, 0x0E	; 14
 292:	40 bb       	out	0x10, r20	; 16
	calca_init(); // activates interrupts
 294:	d5 df       	rcall	.-86     	; 0x240 <calca_init()>
	uint8_t previous_io = EVENT_MASK;
 296:	4e e0       	ldi	r20, 0x0E	; 14
		sleep_mode(); // will return once interrupted by ISR.
 298:	5a b7       	in	r21, 0x3a	; 58
 29a:	51 60       	ori	r21, 0x01	; 1
 29c:	5a bf       	out	0x3a, r21	; 58
 29e:	88 95       	sleep
 2a0:	5a b7       	in	r21, 0x3a	; 58
 2a2:	5e 7f       	andi	r21, 0xFE	; 254
 2a4:	5a bf       	out	0x3a, r21	; 58
		uint8_t current_io = PINB & EVENT_MASK;
 2a6:	50 b1       	in	r21, 0x00	; 0
 2a8:	c5 2f       	mov	r28, r21
 2aa:	ce 70       	andi	r28, 0x0E	; 14
		uint8_t changed_io = (current_io ^ previous_io);
 2ac:	64 2f       	mov	r22, r20
 2ae:	6c 27       	eor	r22, r28
		if((changed_io & ROTARY_MASK) && (0 == (previous_io & ROTARY_MASK))) {
 2b0:	76 2f       	mov	r23, r22
 2b2:	76 70       	andi	r23, 0x06	; 6
 2b4:	61 f1       	breq	.+88     	; 0x30e <main+0xa2>
 2b6:	46 70       	andi	r20, 0x06	; 6
 2b8:	51 f5       	brne	.+84     	; 0x30e <main+0xa2>
			calca_rotary_step( (current_io & (1 << PIN_ROTARY1)) ? 1 : -1);
 2ba:	81 e0       	ldi	r24, 0x01	; 1
 2bc:	51 ff       	sbrs	r21, 1
 2be:	8f ef       	ldi	r24, 0xFF	; 255
		value;
}

static inline void calca_rotary_step(int8_t dir)
{
	switch(calca_mode) {
 2c0:	45 a1       	lds	r20, 0x45	; 0x800045 <calca_mode>
 2c2:	41 30       	cpi	r20, 0x01	; 1
 2c4:	a9 f0       	breq	.+42     	; 0x2f0 <main+0x84>
 2c6:	48 f0       	brcs	.+18     	; 0x2da <main+0x6e>
 2c8:	60 a1       	lds	r22, 0x40	; 0x800040 <_edata>
 2ca:	42 30       	cpi	r20, 0x02	; 2
 2cc:	a9 f0       	breq	.+42     	; 0x2f8 <main+0x8c>
		case MODE_SPOTWIDTH:
			calca_width = check_bounds(calca_width + dir, 1, light_count);
			break;
		default:
		case MODE_SPOTPOS:
			calca_pos = uint8_t(calca_pos + dir + light_count) % light_count;
 2ce:	42 a1       	lds	r20, 0x42	; 0x800042 <calca_pos>
 2d0:	46 0f       	add	r20, r22
 2d2:	84 0f       	add	r24, r20
 2d4:	38 d0       	rcall	.+112    	; 0x346 <__udivmodqi4>
 2d6:	92 a9       	sts	0x42, r25	; 0x800042 <calca_pos>
 2d8:	08 c0       	rjmp	.+16     	; 0x2ea <main+0x7e>
			calca_attenuation = check_bounds(calca_attenuation + dir, 0, MAX_ATTENUATION);
 2da:	43 a1       	lds	r20, 0x43	; 0x800043 <calca_attenuation>
 2dc:	84 0f       	add	r24, r20
 2de:	86 33       	cpi	r24, 0x36	; 54
 2e0:	0c f0       	brlt	.+2      	; 0x2e4 <main+0x78>
 2e2:	85 e3       	ldi	r24, 0x35	; 53
 2e4:	87 fd       	sbrc	r24, 7
 2e6:	80 e0       	ldi	r24, 0x00	; 0
 2e8:	83 a9       	sts	0x43, r24	; 0x800043 <calca_attenuation>
			break;
	};

	calca_set_new_values();
 2ea:	d8 de       	rcall	.-592    	; 0x9c <calca_set_new_values()>
{
 2ec:	4c 2f       	mov	r20, r28
 2ee:	d4 cf       	rjmp	.-88     	; 0x298 <main+0x2c>
			calca_color += dir;
 2f0:	44 a1       	lds	r20, 0x44	; 0x800044 <calca_color>
 2f2:	84 0f       	add	r24, r20
 2f4:	84 a9       	sts	0x44, r24	; 0x800044 <calca_color>
 2f6:	f9 cf       	rjmp	.-14     	; 0x2ea <main+0x7e>
			calca_width = check_bounds(calca_width + dir, 1, light_count);
 2f8:	41 a1       	lds	r20, 0x41	; 0x800041 <calca_width>
 2fa:	84 0f       	add	r24, r20
	return (value < lower) ? lower :
 2fc:	18 17       	cp	r17, r24
 2fe:	2c f4       	brge	.+10     	; 0x30a <main+0x9e>
 300:	86 17       	cp	r24, r22
 302:	0c f4       	brge	.+2      	; 0x306 <main+0x9a>
 304:	68 2f       	mov	r22, r24
			calca_width = check_bounds(calca_width + dir, 1, light_count);
 306:	61 a9       	sts	0x41, r22	; 0x800041 <calca_width>
 308:	f0 cf       	rjmp	.-32     	; 0x2ea <main+0x7e>
	return (value < lower) ? lower :
 30a:	61 e0       	ldi	r22, 0x01	; 1
 30c:	fc cf       	rjmp	.-8      	; 0x306 <main+0x9a>
		} else if(changed_io & SWITCH_MASK) {
 30e:	63 ff       	sbrs	r22, 3
 310:	ed cf       	rjmp	.-38     	; 0x2ec <main+0x80>
			if(!(current_io & SWITCH_MASK)) {
 312:	53 fd       	sbrc	r21, 3
 314:	0e c0       	rjmp	.+28     	; 0x332 <main+0xc6>
	calca_mode++;
 316:	45 a1       	lds	r20, 0x45	; 0x800045 <calca_mode>
 318:	4f 5f       	subi	r20, 0xFF	; 255
	calca_mode %= MODECOUNT;
 31a:	43 70       	andi	r20, 0x03	; 3
 31c:	45 a9       	sts	0x45, r20	; 0x800045 <calca_mode>
				PRR &= ~(1 << PRTIM0);
 31e:	45 b7       	in	r20, 0x35	; 53
 320:	4e 7f       	andi	r20, 0xFE	; 254
 322:	45 bf       	out	0x35, r20	; 53
				TCCR0A = 0;
 324:	1e bd       	out	0x2e, r17	; 46
				TCCR0C = 0;
 326:	1c bd       	out	0x2c, r17	; 44
				TCCR0B = 0x5; // TimerCLK is IoCLK/1024
 328:	45 e0       	ldi	r20, 0x05	; 5
 32a:	4d bd       	out	0x2d, r20	; 45
				TCNT0 = 0;
 32c:	19 bd       	out	0x29, r17	; 41
 32e:	18 bd       	out	0x28, r17	; 40
 330:	dd cf       	rjmp	.-70     	; 0x2ec <main+0x80>
				if(TCNT0 > 2604) // pressed for more than ~1/3 second
 332:	48 b5       	in	r20, 0x28	; 40
 334:	59 b5       	in	r21, 0x29	; 41
 336:	4d 32       	cpi	r20, 0x2D	; 45
 338:	5a 40       	sbci	r21, 0x0A	; 10
 33a:	08 f0       	brcs	.+2      	; 0x33e <main+0xd2>
					calca_init();
 33c:	81 df       	rcall	.-254    	; 0x240 <calca_init()>
				PRR |= (1 << PRTIM0);
 33e:	45 b7       	in	r20, 0x35	; 53
 340:	41 60       	ori	r20, 0x01	; 1
 342:	45 bf       	out	0x35, r20	; 53
 344:	d3 cf       	rjmp	.-90     	; 0x2ec <main+0x80>

00000346 <__udivmodqi4>:
 346:	99 1b       	sub	r25, r25
 348:	79 e0       	ldi	r23, 0x09	; 9
 34a:	04 c0       	rjmp	.+8      	; 0x354 <__udivmodqi4_ep>

0000034c <__udivmodqi4_loop>:
 34c:	99 1f       	adc	r25, r25
 34e:	96 17       	cp	r25, r22
 350:	08 f0       	brcs	.+2      	; 0x354 <__udivmodqi4_ep>
 352:	96 1b       	sub	r25, r22

00000354 <__udivmodqi4_ep>:
 354:	88 1f       	adc	r24, r24
 356:	7a 95       	dec	r23
 358:	c9 f7       	brne	.-14     	; 0x34c <__udivmodqi4_loop>
 35a:	80 95       	com	r24
 35c:	08 95       	ret

0000035e <_exit>:
 35e:	f8 94       	cli

00000360 <__stop_program>:
 360:	ff cf       	rjmp	.-2      	; 0x360 <__stop_program>
