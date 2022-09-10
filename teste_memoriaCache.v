module teste_memoriaCache();
	reg clock;
	reg wren;
	reg [2:0] data;
	reg [4:0] address;
	wire hit, valid, LRU, dirty, writeBack;
	wire [2:0] tag;
	wire [2:0] dadoParaCPU;
	
	memoriaCache cache(clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);	//inicializacao da cache
	
	initial begin
		assign clock = 1;
		assign wren = 0;
		assign data = 3'b000;
		assign address = 5'b10000;
	
	end
	
	initial begin 
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
			#100;
				assign clock = ~clock;
				$display("Time=%0d clock=%0b wren=%0b data =%0d address = %0b hit = %0b valid = %0b LRU = %0b dirty = %0d writeBack= %0d tag = %0d dadoParaCPU = %0d",
							$time, clock, wren, data, address, hit, valid, LRU, dirty, writeBack, tag, dadoParaCPU);
	end

endmodule 