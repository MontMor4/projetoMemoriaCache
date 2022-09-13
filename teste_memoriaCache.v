module teste_memoriaCache();
	reg clock;
	reg wren;
	reg [2:0] data;
	reg [4:0] address;
	wire hit, valid, LRU, dirty, writeBack;
	wire [2:0] tag;
	wire [2:0] dadoParaCPU;
	integer count;
	
	memoriaCache cache(clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);	//inicializacao da cache
	
	initial begin
		assign clock = 1;
		assign wren = 0;
		assign data = 3'b000;
		assign address = 5'b10000;
	
	end
	
	initial begin 
			
			//primeiro caso teste
			for(count = 0; count < 3; count = count + 1)begin	
				#100;
					assign clock = ~clock;
					$display("1: Time=%0d clock=%0b wren=%0b data=%0d address=%0d hit=%0b valid=%0b LRU=%0b dirty=%0b writeBack=%0b tag=%0b dadoParaCPU=%0d",
								$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			end
			
			//segundo caso teste
			assign wren = 0;
			assign data = 3'b000;
			assign address = 5'b00001;
			for(count = 0; count < 3; count = count + 1)begin	
				#100;
					assign clock = ~clock;
					$display("2: Time=%0d clock=%0b wren=%0b data=%0d address=%0d hit=%0b valid=%0b LRU=%0b dirty=%0b writeBack=%0b tag=%0b dadoParaCPU=%0d",
								$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			end
			
			//terceiro caso teste
			assign wren = 1;
			assign data = 3'b101;
			assign address = 5'b00001;
			for(count = 0; count < 4; count = count + 1)begin	
				#100;
					assign clock = ~clock;
					$display("3: Time=%0d clock=%0b wren=%0b data=%0d address=%0d hit=%0b valid=%0b LRU=%0b dirty=%0b writeBack=%0b tag=%0b dadoParaCPU=%0d",
								$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			end
			
			//quarto caso teste
			assign wren = 1;
			assign data = 3'b100;
			assign address = 5'b01001;
			for(count = 0; count < 4; count = count + 1)begin	
				#100;
					assign clock = ~clock;
					$display("4: Time=%0d clock=%0b wren=%0b data=%0d address=%0d hit=%0b valid=%0b LRU=%0b dirty=%0b writeBack=%0b tag=%0b dadoParaCPU=%0d",
								$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			end
			
			//quinto caso teste
			assign wren = 0;
			assign data = 3'b000;
			assign address = 5'b00101;
			for(count = 0; count < 7; count = count + 1)begin	
				#100;
					assign clock = ~clock;
					$display("5: Time=%0d clock=%0b wren=%0b data=%0d address=%0d hit=%0b valid=%0b LRU=%0b dirty=%0b writeBack=%0b tag=%0b dadoParaCPU=%0d",
								$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			end

	end

endmodule 