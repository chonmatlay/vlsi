module t_bound_flasher ; 
reg [2:0] stim; 
wire [15:0] S ;
bf a(.clk(stim[0]),.rst_n(stim[1]),.flick(stim[2]),.lamps(S));
// initial stim[0]=0;
always @(stim[0]) #5 stim[0]=~stim[0];
initial begin
    stim=3'b000;
    #1 stim=3'b110;
    #10 stim[2]=0;
    #500 stim[2]=1; 
    #270 stim[2]=0;
end
endmodule 
