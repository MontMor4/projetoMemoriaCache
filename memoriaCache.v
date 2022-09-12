/* 
	4 conjuntos de 2 viaas -> 8 blocos no total
	palavra de 8 bits
	address de 5 bits, sendo 3 para tag e 2 para índice
	sem offset
	
	Saidas:
	Hit : 1 para hit 0 para miss
	writeBack : 1 para acontecer writeBack, 0 para não acontecer
	enderecoMemoria: endereço para escrever ou ler dado da memória
	dadoParaMemoria : dado para ser escrito na memoria principal

	Legenda bits cache para cada via , totalizando 9 bits, cada conjunto é formado por duas vias
	val LRU Dirty tag[3] data[3]
*/
	

module memoriaCache(
	input clock,
	input wren,	// 1 para escrita e 0 para leitura
	input [2:0] data,
	input [4:0] address,	//endereco
	output reg hit, valid, LRU, dirty, writeBack,
	output reg [2:0] tag,
	output reg [2:0] dadoParaCPU);
 	//output reg [2:0] dadoParaMemoria,
	//output reg [3:0] enderecoParaMemoria);
	reg [8:0] cache[7:0];	//8 blocos de 9 bits cada 
	reg [2:0] mem[15:0]; 	//16 blocos de 3 bits cada
	reg [3:0] varEndMem;
	reg [2:0] varDadoWriteBack;
 	integer via1;
	integer via2;
	
	memoriaPrincipal ram(address[3:0], clock, data, wren, q); //inicializando a memoria princial
	
	initial begin
	//inicializando os blocos da cache
   //via1	  						via2
	cache[0] = 9'b000100011;	cache[1] = 9'b110101100;	//index 00
	cache[2] = 9'b100000011;	cache[3] = 9'b110001111;	//index 01
	cache[4] = 9'b000000000;	cache[5] = 9'b000000000;	//index 10
	cache[6] = 9'b000000000; 	cache[7] = 9'b000000000;	//index 11
	
	/*
		Legenda para facilitar o desenvolvimento:
			* Address
				index: 	[0:1]
				tag: 		[4:2]
			
			* Cache
				data: 	[2:0]
				tag:		[5:3]
				dirty:	[6]
				LRU: 		[7]
				valid: 	[8]
	*/
	
	/*
	//inicializando os blocos da memoria para realizar testes
	mem[0] = 3'b111;
	mem[1] = 3'b011;
	mem[2] = 3'b100;
	mem[3] = 3'b111;
	mem[4] = 3'b100;
	mem[5] = 3'b011;
	mem[6] = 3'b001;
	mem[7] = 3'b000;
	mem[8] = 3'b001;
	mem[9] = 3'b010;
	mem[10] = 3'b011;
	mem[11] = 3'b100;
	mem[12] = 3'b101;
	mem[13] = 3'b111;
	mem[14] = 3'b000;
	mem[15] = 3'b000;
	*/
	end

	always @(posedge clock) begin
		//inicializando as saídas como 0 para evitar bugs
		hit = 0;
		valid = 0;	//bit 8 -> 1 para valido e 0 para invalido
		LRU = 0;		//bit 7 -> 1 para dado mais novo e 0 para dado mais antigo
		dirty = 0;	//bit 6 -> 1 para "sujo" e 0 para "limpo"
		writeBack = 0;
		//out = 0;
		tag = 0;
		
		/*
		via1 = address[1:0] << 1;
		via2 = via1 + 1;
		*/
		
		//definindo quais posicoes da cache serao acessadas
		if(address[1:0] == 2'b00)begin
			via1 = 0;
			via2 = 1;
		end else if(address[1:0] == 2'b01)begin
			via1 = 2;
			via2 = 3;
		end else if(address[1:0] == 2'b10)begin
			via1 = 4;
			via2 = 5;
		end else if(address[1:0] == 2'b11)begin
			via1 = 6;
			via2 = 7;
		end
		
		if(wren == 0)begin //para leitura (wren == 0)
		
			if(cache[via1][8] == 1 && cache[via1][5:3] == address[4:2])begin //verifica valid e hit na primeira via
				
				dadoParaCPU <= cache[via1][2:0]; //CPU recebe o dado que estava na cache
				cache[via1][7] = 1'b1; //LRU (dado mais recente recebe 1)
				cache[via2][7] = 1'b0; //LRU (dado mais antigo recebe 0)
				
				hit = 1;
				valid <= cache[via1][8];
				LRU <= cache[via1][7];
				dirty <= cache[via1][6];
				tag <= cache[via1][5:3];
				writeBack = 0;
				
			end else if(cache[via2][8] == 1 && cache[via2][5:3] == address[4:2])begin //verifica valid e hit na segunda via
				
				dadoParaCPU <= cache[via2][2:0]; //CPU recebe o dado que estava na cache
				cache[via2][7] = 1'b1; //LRU (dado mais recente recebe 1)
				cache[via1][7] = 1'b0; //LRU (dado mais antigo recebe 0)
				
				hit = 1;
				valid <= cache[via2][8];
				LRU <= cache[via2][7];
				dirty <= cache[via2][6];
				tag <= cache[via2][5:3];
				writeBack = 0;
				
				end else begin
				
					hit = 0; //dado nao esta na cache (read miss)
					if(cache[via1][7] == 0)begin //verifica LRU (0 = dado mais antigo)
					
						if(cache[via1][6] == 1)begin //se dirty = 1
						
							writeBack = 1;	//deve ocorrer um writeBack
							varDadoWriteBack = cache[via1][2:0];	//registrador que aramazena dado da cache para fazer o writeBack
							
						end
						
						varEndMem[3:2] = cache[via1][4:3];	//variavel que recebe o endereco onde o dado sera buscado na memoria
						varEndMem[1:0] = address[1:0];
						
						cache[via1][2:0] <= mem[address[3:0]];	//atualiza o dado da cache
						
						dadoParaCPU <= cache[via1][2:0];	//dado atualizado enviado para a CPU
						
						cache[via1][8] = 1;		//valid = 1
						cache[via1][7] = 1'b1; 	//LRU (dado mais recente recebe 1)
						cache[via2][7] = 1'b0; 	//LRU (dado mais antigo recebe 0)	
						cache[via1][6] = 0; 		//dirty = 0 pois é um novo bloco		VERIFICAR
						
						hit = 0;
						valid <= cache[via1][8];
						LRU <= cache[via1][7];
						dirty <= cache[via1][6];
						tag <= cache[via1][5:3];
						
					end else begin
					
						if(cache[via2][6] == 1)begin //se dirty = 1
						
							writeBack = 1;	//deve ocorrer um writeBack
							varDadoWriteBack = cache[via2][2:0];	//registrador que aramazena dado da cache para fazer o writeBack
							
						end
						
						varEndMem[3:2] = cache[via2][4:3];	//variavel que recebe o endereco onde o dado sera buscado na memoria
						varEndMem[1:0] = address[1:0];
						
						cache[via2][2:0] <= mem[address[3:0]];	//atualiza o dado da cache
						
						dadoParaCPU <= cache[via2][2:0];	//dado atualizado enviado para a CPU
						
						cache[via2][8] = 1;		//valid = 1
						cache[via2][7] = 1'b1; 	//LRU (dado mais recente recebe 1)
						cache[via1][7] = 1'b0; 	//LRU (dado mais antigo recebe 0)	
						cache[via2][6] = 0; 		//dirty = 0 pois é um novo bloco		VERIFICAR
						
						hit = 0;
						valid <= cache[via2][8];
						LRU <= cache[via2][7];
						dirty <= cache[via2][6];
						tag <= cache[via2][5:3];
						
					end
				end
				
				if(writeBack == 1) mem[varEndMem] = varDadoWriteBack;	//memoria recebe dado que estava na cache
					
			end else begin	//para escrita (wren == 1)
				
				if(cache[via1][8] == 1 && cache[via1][5:3] == address[4:2])begin //verifica valid e hit na primeira via
					
					if(cache[via1][6] == 1)begin	//verifica dirty do dado que esta na cache
						
						writeBack = 1;
						varEndMem[3:2] = cache[via1][4:3];	//variavel que recebe o endereco onde o dado sera buscado na memoria
						varEndMem[1:0] = address[1:0];
						mem[varEndMem] = cache[via1][2:0];	//memoria recebe dado que estava na cache
						
					end
					
					cache[via1][2:0] = data;	//cache na via recebe o dado
					cache[via1][8] = 1;		//valid = 1
					cache[via1][7] = 1'b1; 	//LRU (dado mais recente recebe 1)
					cache[via2][7] = 1'b0; 	//LRU (dado mais antigo recebe 0)	
					cache[via1][6] = 1; 		//dirty = 1 pois esta atualizando o dado
					
					hit = 0;
					valid <= cache[via1][8];
					LRU <= cache[via1][7];
					dirty <= cache[via1][6];
					tag <= cache[via1][5:3];
					
				end else if(cache[via2][8] == 1 && cache[via2][5:3] == address[4:2])begin //verifica valid e hit na segunda via
					
					if(cache[via2][6] == 1)begin	//verifica dirty do dado que esta na cache
						
						writeBack = 1;
						varEndMem[3:2] = cache[via2][4:3];	//variavel que recebe o endereco onde o dado sera buscado na memoria
						varEndMem[1:0] = address[1:0];
						mem[varEndMem] = cache[via2][2:0];	//memoria recebe dado que estava na cache
						
					end
					
					cache[via2][2:0] = data;	//cache na via recebe o dado
					cache[via2][8] = 1;		//valid = 1
					cache[via2][7] = 1'b1; 	//LRU (dado mais recente recebe 1)
					cache[via1][7] = 1'b0; 	//LRU (dado mais antigo recebe 0)	
					cache[via2][6] = 1; 		//dirty = 0 pois é um novo bloco		VERIFICAR
					
					hit = 0;
					valid <= cache[via2][8];
					LRU <= cache[via2][7];
					dirty <= cache[via2][6];
					tag <= cache[via2][5:3];
					
				end
			end	//fim da escrita
			
		end	// fim do always

endmodule