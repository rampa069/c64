
module cbm_sid
(
	input         reset,

	input            clk32,
	input            clk_1MHz,

	input            sid1_we,
	input            sid2_we,
	input            sid1_cs,
	input            sid2_cs,
	
	input      [4:0] sid1_addr,
	input      [7:0] sid1_din,
	output     [7:0] sid1_dout,

	input      [7:0] sid1_pot_x,
	input      [7:0] sid1_pot_y,
	
	input            sid1_mode,

	input      [4:0] sid2_addr,
	input      [7:0] sid2_din,
	output     [7:0] sid2_dout,

	input      [7:0] sid2_pot_x,
	input      [7:0] sid2_pot_y,
	
	input            sid2_mode,

	
	output reg signed[17:0] sid1_audio_data,
	output reg signed[17:0] sid2_audio_data
);

// Internal Signals



reg  [7:0] sid1_Voice_1_Freq_lo;
reg  [7:0] sid1_Voice_1_Freq_hi;
reg  [7:0] sid1_Voice_1_Pw_lo;
reg  [3:0] sid1_Voice_1_Pw_hi;
reg  [7:0] sid1_Voice_1_Control;
reg  [7:0] sid1_Voice_1_Att_dec;
reg  [7:0] sid1_Voice_1_Sus_Rel;

reg  [7:0] sid1_Voice_2_Freq_lo;
reg  [7:0] sid1_Voice_2_Freq_hi;
reg  [7:0] sid1_Voice_2_Pw_lo;
reg  [3:0] sid1_Voice_2_Pw_hi;
reg  [7:0] sid1_Voice_2_Control;
reg  [7:0] sid1_Voice_2_Att_dec;
reg  [7:0] sid1_Voice_2_Sus_Rel;

reg  [7:0] sid1_Voice_3_Freq_lo;
reg  [7:0] sid1_Voice_3_Freq_hi;
reg  [7:0] sid1_Voice_3_Pw_lo;
reg  [3:0] sid1_Voice_3_Pw_hi;
reg  [7:0] sid1_Voice_3_Control;
reg  [7:0] sid1_Voice_3_Att_dec;
reg  [7:0] sid1_Voice_3_Sus_Rel;

reg  [7:0] sid1_Filter_Fc_lo;
reg  [7:0] sid1_Filter_Fc_hi;
reg  [7:0] sid1_Filter_Res_Filt;
reg  [7:0] sid1_Filter_Mode_Vol;


wire [7:0] sid1_Misc_Osc3_Random_6581;
wire [7:0] sid1_Misc_Env3_6581;
wire [7:0] sid1_Misc_Osc3_Random_8580;
wire [7:0] sid1_Misc_Env3_8580;

reg  [7:0] sid1_do_buf;

reg  [7:0] sid2_Voice_1_Freq_lo;
reg  [7:0] sid2_Voice_1_Freq_hi;
reg  [7:0] sid2_Voice_1_Pw_lo;
reg  [3:0] sid2_Voice_1_Pw_hi;
reg  [7:0] sid2_Voice_1_Control;
reg  [7:0] sid2_Voice_1_Att_dec;
reg  [7:0] sid2_Voice_1_Sus_Rel;

reg  [7:0] sid2_Voice_2_Freq_lo;
reg  [7:0] sid2_Voice_2_Freq_hi;
reg  [7:0] sid2_Voice_2_Pw_lo;
reg  [3:0] sid2_Voice_2_Pw_hi;
reg  [7:0] sid2_Voice_2_Control;
reg  [7:0] sid2_Voice_2_Att_dec;
reg  [7:0] sid2_Voice_2_Sus_Rel;

reg  [7:0] sid2_Voice_3_Freq_lo;
reg  [7:0] sid2_Voice_3_Freq_hi;
reg  [7:0] sid2_Voice_3_Pw_lo;
reg  [3:0] sid2_Voice_3_Pw_hi;
reg  [7:0] sid2_Voice_3_Control;
reg  [7:0] sid2_Voice_3_Att_dec;
reg  [7:0] sid2_Voice_3_Sus_Rel;

reg  [7:0] sid2_Filter_Fc_lo;
reg  [7:0] sid2_Filter_Fc_hi;
reg  [7:0] sid2_Filter_Res_Filt;
reg  [7:0] sid2_Filter_Mode_Vol;


wire [7:0] sid2_Misc_Osc3_Random_6581;
wire [7:0] sid2_Misc_Env3_6581;
wire [7:0] sid2_Misc_Osc3_Random_8580;
wire [7:0] sid2_Misc_Env3_8580;

reg  [7:0] sid2_do_buf;


////////////////////////////////////////////


wire [11:0] sid1_voice_6581_1;
wire [11:0] sid1_voice_6581_2;
wire [11:0] sid1_voice_6581_3;

wire [11:0] sid1_voice_8580_1;
wire [11:0] sid1_voice_8580_2;
wire [11:0] sid1_voice_8580_3;

reg signed [17:0] sid1_signed_voice1;
reg signed [17:0] sid1_signed_voice2;
reg signed [17:0] sid1_signed_voice3;

wire [17:0] sid1_voice_mixed;
reg  [17:0] sid1_voice_volume;


wire        sid1_voice_1_PA_MSB_6581;
wire        sid1_voice_2_PA_MSB_6581;
wire        sid1_voice_3_PA_MSB_6581;
wire        sid1_voice_1_PA_MSB_8580;
wire        sid1_voice_2_PA_MSB_8580;
wire        sid1_voice_3_PA_MSB_8580;

wire signed [18:0] sid1_filtered_audio;
wire [17:0] sid1_unsigned_audio;
wire [18:0] sid1_unsigned_filt;

////////////////////////////////////////////


wire [11:0] sid2_voice_6581_1;
wire [11:0] sid2_voice_6581_2;
wire [11:0] sid2_voice_6581_3;

wire [11:0] sid2_voice_8580_1;
wire [11:0] sid2_voice_8580_2;
wire [11:0] sid2_voice_8580_3;

reg signed [17:0] sid2_signed_voice1;
reg signed [17:0] sid2_signed_voice2;
reg signed [17:0] sid2_signed_voice3;

wire [17:0] sid2_voice_mixed;
reg  [17:0] sid2_voice_volume;


wire        sid2_voice_1_PA_MSB_6581;
wire        sid2_voice_2_PA_MSB_6581;
wire        sid2_voice_3_PA_MSB_6581;
wire        sid2_voice_1_PA_MSB_8580;
wire        sid2_voice_2_PA_MSB_8580;
wire        sid2_voice_3_PA_MSB_8580;

wire signed [18:0] sid2_filtered_audio;
wire [17:0] sid2_unsigned_audio;
wire [18:0] sid2_unsigned_filt;

////////////////////////////////////////////



reg [7:0] _st_out[3];
reg [7:0] p_t_out[3];
reg [7:0] ps__out[3];
reg [7:0] pst_out[3];
wire [11:0] sid1_sawtooth[3];
wire [11:0] sid1_triangle[3];
wire [11:0] sid2_sawtooth[3];
wire [11:0] sid2_triangle[3];

////////////////////////////////////////////
// SID1 Voice 1 Instantiation
////////////////////////////////////////////

sid_voice_6581 sid1_v1_1
(
	.clk32(clk32),
	.clk_1MHz(clk_1MHz),
	.reset(reset),
	.Freq_lo(sid1_Voice_1_Freq_lo),
	.Freq_hi(sid1_Voice_1_Freq_hi),
	.Pw_lo(sid1_Voice_1_Pw_lo),
	.Pw_hi(sid1_Voice_1_Pw_hi),
	.Control(sid1_Voice_1_Control),
	.Att_dec(sid1_Voice_1_Att_dec),
	.Sus_rel(sid1_Voice_1_Sus_Rel),
	.PA_MSB_in(sid1_voice_3_PA_MSB_6581),
	.PA_MSB_out(sid1_voice_1_PA_MSB_6581),
	.voice(sid1_voice_6581_1)
);

sid_voice_8580 sid1_v1_2
(
	.clock(clk32),
	.ce_1m(clk_1MHz),
	.reset(reset),
	.freq_lo(sid1_Voice_1_Freq_lo),
	.freq_hi(sid1_Voice_1_Freq_hi),
	.pw_lo(sid1_Voice_1_Pw_lo),
	.pw_hi(sid1_Voice_1_Pw_hi),
	.control(sid1_Voice_1_Control),
	.att_dec(sid1_Voice_1_Att_dec),
	.sus_rel(sid1_Voice_1_Sus_Rel),
	.osc_msb_in(sid1_voice_3_PA_MSB_8580),
	.osc_msb_out(sid1_voice_1_PA_MSB_8580),
	.signal_out(sid1_voice_8580_1),
	._st_out(_st_out[0]),
	.p_t_out(p_t_out[0]),
	.ps__out(ps__out[0]),
	.pst_out(pst_out[0]),
	.sawtooth(sid1_sawtooth[0]),
	.triangle(sid1_triangle[0])
);


// Voice 2 Instantiation

sid_voice_6581 sid1_v2_1
(
	.clk32(clk32),
	.clk_1MHz(clk_1MHz),
	.reset(reset),
	.Freq_lo(sid1_Voice_2_Freq_lo),
	.Freq_hi(sid1_Voice_2_Freq_hi),
	.Pw_lo(sid1_Voice_2_Pw_lo),
	.Pw_hi(sid1_Voice_2_Pw_hi),
	.Control(sid1_Voice_2_Control),
	.Att_dec(sid1_Voice_2_Att_dec),
	.Sus_rel(sid1_Voice_2_Sus_Rel),
	.PA_MSB_in(sid1_voice_1_PA_MSB_6581),
	.PA_MSB_out(sid1_voice_2_PA_MSB_6581),
	.voice(sid1_voice_6581_2)
);

sid_voice_8580 sid1_v2_2
(
	.clock(clk32),
	.ce_1m(clk_1MHz),
	.reset(reset),
	.freq_lo(sid1_Voice_2_Freq_lo),
	.freq_hi(sid1_Voice_2_Freq_hi),
	.pw_lo(sid1_Voice_2_Pw_lo),
	.pw_hi(sid1_Voice_2_Pw_hi),
	.control(sid1_Voice_2_Control),
	.att_dec(sid1_Voice_2_Att_dec),
	.sus_rel(sid1_Voice_2_Sus_Rel),
	.osc_msb_in(sid1_voice_1_PA_MSB_8580),
	.osc_msb_out(sid1_voice_2_PA_MSB_8580),
	.signal_out(sid1_voice_8580_2),
	._st_out(_st_out[1]),
	.p_t_out(p_t_out[1]),
	.ps__out(ps__out[1]),
	.pst_out(pst_out[1]),
	.sawtooth(sid1_sawtooth[1]),
	.triangle(sid1_triangle[1])
);

// Voice 3 Instantiation

sid_voice_6581 sid1_v3_1
(
	.clk32(clk32),
	.clk_1MHz(clk_1MHz),
	.reset(reset),
	.Freq_lo(sid1_Voice_3_Freq_lo),
	.Freq_hi(sid1_Voice_3_Freq_hi),
	.Pw_lo(sid1_Voice_3_Pw_lo),
	.Pw_hi(sid1_Voice_3_Pw_hi),
	.Control(sid1_Voice_3_Control),
	.Att_dec(sid1_Voice_3_Att_dec),
	.Sus_rel(sid1_Voice_3_Sus_Rel),
	.PA_MSB_in(sid1_voice_2_PA_MSB_6581),
	.PA_MSB_out(sid1_voice_3_PA_MSB_6581),
	.voice(sid1_voice_6581_3),
	.Osc(sid1_Misc_Osc3_Random_6581),
	.Env(sid1_Misc_Env3_6581)
);

	
sid_voice_8580 sid1_v3_2
(
	.clock(clk32),
	.ce_1m(clk_1MHz),
	.reset(reset),
	.freq_lo(sid1_Voice_3_Freq_lo),
	.freq_hi(sid1_Voice_3_Freq_hi),
	.pw_lo(sid1_Voice_3_Pw_lo),
	.pw_hi(sid1_Voice_3_Pw_hi),
	.control(sid1_Voice_3_Control),
	.att_dec(sid1_Voice_3_Att_dec),
	.sus_rel(sid1_Voice_3_Sus_Rel),
	.osc_msb_in(sid1_voice_2_PA_MSB_8580),
	.osc_msb_out(sid1_voice_3_PA_MSB_8580),
	.signal_out(sid1_voice_8580_3),
	.osc_out(sid1_Misc_Osc3_Random_8580),
	.env_out(sid1_Misc_Env3_8580),
	._st_out(_st_out[2]),
	.p_t_out(p_t_out[2]),
	.ps__out(ps__out[2]),
	.pst_out(pst_out[2]),
	.sawtooth(sid1_sawtooth[2]),
	.triangle(sid1_triangle[2])
);

////////////////////////////////////////////
// SID1 Voice 1 Instantiation
////////////////////////////////////////////

sid_voice_6581 sid2_v1_1
(
        .clk32(clk32),
        .clk_1MHz(clk_1MHz),
        .reset(reset),
        .Freq_lo(sid2_Voice_1_Freq_lo),
        .Freq_hi(sid2_Voice_1_Freq_hi),
        .Pw_lo(sid2_Voice_1_Pw_lo),
        .Pw_hi(sid2_Voice_1_Pw_hi),
        .Control(sid2_Voice_1_Control),
        .Att_dec(sid2_Voice_1_Att_dec),
        .Sus_rel(sid2_Voice_1_Sus_Rel),
        .PA_MSB_in(sid2_voice_3_PA_MSB_6581),
        .PA_MSB_out(sid2_voice_1_PA_MSB_6581),
        .voice(sid2_voice_6581_1)
);

sid_voice_8580 sid2_v1_2
(
        .clock(clk32),
        .ce_1m(clk_1MHz),
        .reset(reset),
        .freq_lo(sid2_Voice_1_Freq_lo),
        .freq_hi(sid2_Voice_1_Freq_hi),
        .pw_lo(sid2_Voice_1_Pw_lo),
        .pw_hi(sid2_Voice_1_Pw_hi),
        .control(sid2_Voice_1_Control),
        .att_dec(sid2_Voice_1_Att_dec),
        .sus_rel(sid2_Voice_1_Sus_Rel),
        .osc_msb_in(sid2_voice_3_PA_MSB_8580),
        .osc_msb_out(sid2_voice_1_PA_MSB_8580),
        .signal_out(sid2_voice_8580_1),
        ._st_out(_st_out[0]),
        .p_t_out(p_t_out[0]),
        .ps__out(ps__out[0]),
        .pst_out(pst_out[0]),
        .sawtooth(sid2_sawtooth[0]),
        .triangle(sid2_triangle[0])
);


// Voice 2 Instantiation

sid_voice_6581 sid2_v2_1
(
        .clk32(clk32),
        .clk_1MHz(clk_1MHz),
        .reset(reset),
        .Freq_lo(sid2_Voice_2_Freq_lo),
        .Freq_hi(sid2_Voice_2_Freq_hi),
        .Pw_lo(sid2_Voice_2_Pw_lo),
        .Pw_hi(sid2_Voice_2_Pw_hi),
        .Control(sid2_Voice_2_Control),
        .Att_dec(sid2_Voice_2_Att_dec),
        .Sus_rel(sid2_Voice_2_Sus_Rel),
        .PA_MSB_in(sid2_voice_1_PA_MSB_6581),
        .PA_MSB_out(sid2_voice_2_PA_MSB_6581),
        .voice(sid2_voice_6581_2)
);

sid_voice_8580 sid2_v2_2
(
        .clock(clk32),
        .ce_1m(clk_1MHz),
        .reset(reset),
        .freq_lo(sid2_Voice_2_Freq_lo),
        .freq_hi(sid2_Voice_2_Freq_hi),
        .pw_lo(sid2_Voice_2_Pw_lo),
        .pw_hi(sid2_Voice_2_Pw_hi),
        .control(sid2_Voice_2_Control),
        .att_dec(sid2_Voice_2_Att_dec),
        .sus_rel(sid2_Voice_2_Sus_Rel),
        .osc_msb_in(sid2_voice_1_PA_MSB_8580),
        .osc_msb_out(sid2_voice_2_PA_MSB_8580),
        .signal_out(sid2_voice_8580_2),
        ._st_out(_st_out[1]),
        .p_t_out(p_t_out[1]),
        .ps__out(ps__out[1]),
        .pst_out(pst_out[1]),
        .sawtooth(sid2_sawtooth[1]),
        .triangle(sid2_triangle[1])
);

// Voice 3 Instantiation

sid_voice_6581 sid2_v3_1
(
        .clk32(clk32),
        .clk_1MHz(clk_1MHz),
        .reset(reset),
        .Freq_lo(sid2_Voice_3_Freq_lo),
        .Freq_hi(sid2_Voice_3_Freq_hi),
        .Pw_lo(sid2_Voice_3_Pw_lo),
        .Pw_hi(sid2_Voice_3_Pw_hi),
        .Control(sid2_Voice_3_Control),
        .Att_dec(sid2_Voice_3_Att_dec),
        .Sus_rel(sid2_Voice_3_Sus_Rel),
        .PA_MSB_in(sid2_voice_2_PA_MSB_6581),
        .PA_MSB_out(sid2_voice_3_PA_MSB_6581),
        .voice(sid2_voice_6581_3),
        .Osc(sid2_Misc_Osc3_Random_6581),
        .Env(sid2_Misc_Env3_6581)
);

sid_voice_8580 sid2_v3_2
(
	.clock(clk32),
	.ce_1m(clk_1MHz),
	.reset(reset),
	.freq_lo(sid2_Voice_3_Freq_lo),
	.freq_hi(sid2_Voice_3_Freq_hi),
	.pw_lo(sid2_Voice_3_Pw_lo),
	.pw_hi(sid2_Voice_3_Pw_hi),
	.control(sid2_Voice_3_Control),
	.att_dec(sid2_Voice_3_Att_dec),
	.sus_rel(sid2_Voice_3_Sus_Rel),
	.osc_msb_in(sid2_voice_2_PA_MSB_8580),
	.osc_msb_out(sid2_voice_3_PA_MSB_8580),
	.signal_out(sid2_voice_8580_3),
	.osc_out(sid2_Misc_Osc3_Random_8580),
	.env_out(sid2_Misc_Env3_8580),
	._st_out(_st_out[2]),
	.p_t_out(p_t_out[2]),
	.ps__out(ps__out[2]),
	.pst_out(pst_out[2]),
	.sawtooth(sid2_sawtooth[2]),
	.triangle(sid2_triangle[2])
);



// Filter Instantiation
//sid_filters filters
//(
//	.clk(clk32),
//	.rst(reset),
//	.Fc_lo(Filter_Fc_lo),
//	.Fc_hi(Filter_Fc_hi),
//	.Res_Filt(Filter_Res_Filt),
//	.Mode_Vol(Filter_Mode_Vol),
//	.voice1(signed_voice1),
//	.voice2(signed_voice2),
//	.voice3(signed_voice3 ),
//	.input_valid(clk_1MHz),
//	.ext_in(12'h000),
//	.sound(filtered_audio),
//	.extfilter_en(extfilter_en)
//);


// Filter Instantiation
sid_filters sid1_filter
(
	.clk(clk32),
	.rst(reset),
	.Fc_lo(sid1_Filter_Fc_lo),
	.Fc_hi(sid1_Filter_Fc_hi),
	.Res_Filt(sid1_Filter_Res_Filt),
	.Mode_Vol(sid1_Filter_Mode_Vol),
	.voice1(sid1_signed_voice1),
	.voice2(sid1_signed_voice2),
	.voice3(sid1_signed_voice3 ),
	.input_valid(clk_1MHz),
	.ext_in(12'h000),
	.mode (sid1_mode),
	.sound(sid1_filtered_audio)
);

// Filter Instantiation
sid_filters sid2_filters
(
	.clk(clk32),
	.rst(reset),
	.Fc_lo(sid2_Filter_Fc_lo),
	.Fc_hi(sid2_Filter_Fc_hi),
	.Res_Filt(sid2_Filter_Res_Filt),
	.Mode_Vol(sid2_Filter_Mode_Vol),
	.voice1(sid2_signed_voice1),
	.voice2(sid2_signed_voice2),
	.voice3(sid2_signed_voice3 ),
	.input_valid(clk_1MHz),
	.ext_in(12'h000),
	.mode (sid2_mode),
	.sound(sid2_filtered_audio)
);

sid_tables sid_tables
(
	.clock(clk32),
	.sawtooth(f_sawtooth),
	.triangle(f_triangle),
	._st_out(f__st_out),
	.p_t_out(f_p_t_out),
	.ps__out(f_ps__out),
	.pst_out(f_pst_out)
);

wire [7:0] f__st_out;
wire [7:0] f_p_t_out;
wire [7:0] f_ps__out;
wire [7:0] f_pst_out;
reg [11:0] f_sawtooth;
reg [11:0] f_triangle;

always @(posedge clk32) begin
	reg [3:0] state;
	sid1_signed_voice1 <= sid1_mode ? {1'b0,sid1_voice_8580_1} : {1'b0,sid1_voice_6581_1};
	sid1_signed_voice2 <= sid1_mode ? {1'b0,sid1_voice_8580_2} : {1'b0,sid1_voice_6581_2};
	sid1_signed_voice3 <= sid1_mode ? {1'b0,sid1_voice_8580_3} : {1'b0,sid1_voice_6581_3};
	sid2_signed_voice1 <= sid2_mode ? {1'b0,sid2_voice_8580_1} : {1'b0,sid2_voice_6581_1};
	sid2_signed_voice2 <= sid2_mode ? {1'b0,sid2_voice_8580_2} : {1'b0,sid2_voice_6581_2};
	sid2_signed_voice3 <= sid2_mode ? {1'b0,sid2_voice_8580_3} : {1'b0,sid2_voice_6581_3};

	sid1_audio_data <= sid1_filtered_audio[18:1];
	sid2_audio_data <= sid2_filtered_audio[18:1];
	
	if(~&state) state <= state + 1'd1;;
	if(clk_1MHz) state <= 0;

	case(state)
		1,5,9: begin
			if (sid1_we) begin
			 f_sawtooth <= sid1_sawtooth[state[3:2]];
			 f_triangle <= sid1_triangle[state[3:2]];
			end
			if (sid2_we) begin
			 f_sawtooth <= sid2_sawtooth[state[3:2]];
			 f_triangle <= sid2_triangle[state[3:2]];
			end
			
		end
	endcase

	case(state)
		3,7,11: begin
			_st_out[state[3:2]] <= f__st_out;
			p_t_out[state[3:2]] <= f_p_t_out;
			ps__out[state[3:2]] <= f_ps__out;
			pst_out[state[3:2]] <= f_pst_out;
		end
	endcase
end

assign sid1_dout = sid1_do_buf;
assign sid2_dout = sid2_do_buf;

reg [7:0] sid1_last_wr,sid2_last_wr;


// Register Decoding
always @(posedge clk32) begin
	if (reset) begin
		sid1_Voice_1_Freq_lo <= 0;
		sid1_Voice_1_Freq_hi <= 0;
		sid1_Voice_1_Pw_lo   <= 0;
		sid1_Voice_1_Pw_hi   <= 0;
		sid1_Voice_1_Control <= 0;
		sid1_Voice_1_Att_dec <= 0;
		sid1_Voice_1_Sus_Rel <= 0;
		sid1_Voice_2_Freq_lo <= 0;
		sid1_Voice_2_Freq_hi <= 0;
		sid1_Voice_2_Pw_lo   <= 0;
		sid1_Voice_2_Pw_hi   <= 0;
		sid1_Voice_2_Control <= 0;
		sid1_Voice_2_Att_dec <= 0;
		sid1_Voice_2_Sus_Rel <= 0;
		sid1_Voice_3_Freq_lo <= 0;
		sid1_Voice_3_Freq_hi <= 0;
		sid1_Voice_3_Pw_lo   <= 0;
		sid1_Voice_3_Pw_hi   <= 0;
		sid1_Voice_3_Control <= 0;
		sid1_Voice_3_Att_dec <= 0;
		sid1_Voice_3_Sus_Rel <= 0;
		sid1_Filter_Fc_lo    <= 0;
		sid1_Filter_Fc_hi    <= 0;
		sid1_Filter_Res_Filt <= 0;
		sid1_Filter_Mode_Vol <= 0;
      //
		sid2_Voice_1_Freq_lo <= 0;
		sid2_Voice_1_Freq_hi <= 0;
		sid2_Voice_1_Pw_lo   <= 0;
		sid2_Voice_1_Pw_hi   <= 0;
		sid2_Voice_1_Control <= 0;
		sid2_Voice_1_Att_dec <= 0;
		sid2_Voice_1_Sus_Rel <= 0;
		sid2_Voice_2_Freq_lo <= 0;
		sid2_Voice_2_Freq_hi <= 0;
		sid2_Voice_2_Pw_lo   <= 0;
		sid2_Voice_2_Pw_hi   <= 0;
		sid2_Voice_2_Control <= 0;
		sid2_Voice_2_Att_dec <= 0;
		sid2_Voice_2_Sus_Rel <= 0;
		sid2_Voice_3_Freq_lo <= 0;
		sid2_Voice_3_Freq_hi <= 0;
		sid2_Voice_3_Pw_lo   <= 0;
		sid2_Voice_3_Pw_hi   <= 0;
		sid2_Voice_3_Control <= 0;
		sid2_Voice_3_Att_dec <= 0;
		sid2_Voice_3_Sus_Rel <= 0;
		sid2_Filter_Fc_lo    <= 0;
		sid2_Filter_Fc_hi    <= 0;
		sid2_Filter_Res_Filt <= 0;
		sid2_Filter_Mode_Vol <= 0;

	end
	else begin
	  if (sid1_cs) begin
		if (sid1_we) begin
			sid1_last_wr <= sid1_din;
			case (sid1_addr)
				5'h00: sid1_Voice_1_Freq_lo <= sid1_din;
				5'h01: sid1_Voice_1_Freq_hi <= sid1_din;
				5'h02: sid1_Voice_1_Pw_lo   <= sid1_din;
				5'h03: sid1_Voice_1_Pw_hi   <= sid1_din[3:0];
				5'h04: sid1_Voice_1_Control <= sid1_din;
				5'h05: sid1_Voice_1_Att_dec <= sid1_din;
				5'h06: sid1_Voice_1_Sus_Rel <= sid1_din;
				5'h07: sid1_Voice_2_Freq_lo <= sid1_din;
				5'h08: sid1_Voice_2_Freq_hi <= sid1_din;
				5'h09: sid1_Voice_2_Pw_lo   <= sid1_din;
				5'h0a: sid1_Voice_2_Pw_hi   <= sid1_din[3:0];
				5'h0b: sid1_Voice_2_Control <= sid1_din;
				5'h0c: sid1_Voice_2_Att_dec <= sid1_din;
				5'h0d: sid1_Voice_2_Sus_Rel <= sid1_din;
				5'h0e: sid1_Voice_3_Freq_lo <= sid1_din;
				5'h0f: sid1_Voice_3_Freq_hi <= sid1_din;
				5'h10: sid1_Voice_3_Pw_lo   <= sid1_din;
				5'h11: sid1_Voice_3_Pw_hi   <= sid1_din[3:0];
				5'h12: sid1_Voice_3_Control <= sid1_din;
				5'h13: sid1_Voice_3_Att_dec <= sid1_din;
				5'h14: sid1_Voice_3_Sus_Rel <= sid1_din;
				5'h15: sid1_Filter_Fc_lo    <= sid1_din;
				5'h16: sid1_Filter_Fc_hi    <= sid1_din;
				5'h17: sid1_Filter_Res_Filt <= sid1_din;
				5'h18: sid1_Filter_Mode_Vol <= sid1_din;
			endcase
		  end 
		  else begin
		  	case (sid1_addr)
				5'h19: sid1_do_buf = sid1_pot_x;
				5'h1a: sid1_do_buf = sid1_pot_y;
				5'h1b: sid1_do_buf = sid1_mode ? sid1_Misc_Osc3_Random_8580: sid1_Misc_Osc3_Random_6581;
				5'h1c: sid1_do_buf = sid1_mode ? sid1_Misc_Env3_8580       : sid1_Misc_Env3_6581;
				default: sid1_do_buf = sid1_mode ? 8'hff : sid1_last_wr;
			endcase
		 end
	  end
	end
	  if (sid2_cs) begin
		if (sid2_we) begin
			sid1_last_wr <= sid2_din;
			case (sid2_addr)
				5'h00: sid2_Voice_1_Freq_lo <= sid2_din;
				5'h01: sid2_Voice_1_Freq_hi <= sid2_din;
				5'h02: sid2_Voice_1_Pw_lo   <= sid2_din;
				5'h03: sid2_Voice_1_Pw_hi   <= sid2_din[3:0];
				5'h04: sid2_Voice_1_Control <= sid2_din;
				5'h05: sid2_Voice_1_Att_dec <= sid2_din;
				5'h06: sid2_Voice_1_Sus_Rel <= sid2_din;
				5'h07: sid2_Voice_2_Freq_lo <= sid2_din;
				5'h08: sid2_Voice_2_Freq_hi <= sid2_din;
				5'h09: sid2_Voice_2_Pw_lo   <= sid2_din;
				5'h0a: sid2_Voice_2_Pw_hi   <= sid2_din[3:0];
				5'h0b: sid2_Voice_2_Control <= sid2_din;
				5'h0c: sid2_Voice_2_Att_dec <= sid2_din;
				5'h0d: sid2_Voice_2_Sus_Rel <= sid2_din;
				5'h0e: sid2_Voice_3_Freq_lo <= sid2_din;
				5'h0f: sid2_Voice_3_Freq_hi <= sid2_din;
				5'h10: sid2_Voice_3_Pw_lo   <= sid2_din;
				5'h11: sid2_Voice_3_Pw_hi   <= sid2_din[3:0];
				5'h12: sid2_Voice_3_Control <= sid2_din;
				5'h13: sid2_Voice_3_Att_dec <= sid2_din;
				5'h14: sid2_Voice_3_Sus_Rel <= sid2_din;
				5'h15: sid2_Filter_Fc_lo    <= sid2_din;
				5'h16: sid2_Filter_Fc_hi    <= sid2_din;
				5'h17: sid2_Filter_Res_Filt <= sid2_din;
				5'h18: sid2_Filter_Mode_Vol <= sid2_din;
			endcase
		  end 
		  else begin
		  	case (sid2_addr)
				5'h19: sid2_do_buf = sid2_pot_x;
				5'h1a: sid2_do_buf = sid2_pot_y;
				5'h1b: sid2_do_buf = sid2_mode ? sid2_Misc_Osc3_Random_8580: sid2_Misc_Osc3_Random_6581;
				5'h1c: sid2_do_buf = sid2_mode ? sid2_Misc_Env3_8580       : sid2_Misc_Env3_6581;
				default: sid2_do_buf = sid2_mode ? 8'hff : sid2_last_wr;
			endcase
		 end
	  end
	end

endmodule
