module bf(output reg[15:0] lamps, input[1:0] flick , clk, rst_n);
    parameter S_0 =0 , 
            S_1=1 , 
            S_2=2 ,
            S_3=3 ,
            S_4= 4 ,
            S_5 =5 , 
            S_6 = 6 ;
    reg [2:0] state ;
    always@ (negedge rst_n , negedge clk ) begin 
        if (rst_n ==0) state <= S_0;
        else 
        case (state)
        S_0 : 
        begin
            lamps <=0 ;
            if (flick[0] ==1 ) state <= S_1;
        end
        S_1:
        begin
            lamps <= (lamps << 1) +4'h1 ;
            if (lamps ==16'hFFFF) state <= S_2;
        end
        S_2 :
        begin 
            lamps <= lamps >> 1 ;
            if (lamps == 16'h001F) begin
                if (flick [1] == 1) state <= S_1; 
                else state <= S_3;
            end
        end
        S_3 :
        begin 
            lamps <= (lamps << 1) +1 ;
            if (lamps ==16'h07FF) state <= S_4;
        end
        S_4 :
        begin
            lamps <= (lamps >>1) ;
            if (lamps == 16'h001F) begin 
                if (flick[1]==1) state <= S_3;
            end 
            else if (lamps== 0) begin
                if (flick[0]) state <= S_3 ;
                else state <= S_5;
            end
        end
        S_5 :
        begin
            lamps<= (lamps<<1) +1 ; 
            if (lamps == 16'h003F) state <= S_6 ; 
        end
        S_6 :
        begin
            lamps <= lamps>> 1 ; 
            if (lamps ==0 ) 
            state <= S_0;
        end    
            endcase
        
    end  
endmodule 