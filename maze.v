`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:43 12/01/2021 
// Design Name: 
// Module Name:    maze 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module maze(
    input 		          clk,
	 input [maze_width - 1:0]  starting_col, starting_row, 	// indicii punctului de start
	 input  			  maze_in, 			// ofera informa?ii despre punctul de coordonate [row, col]
	 output reg [maze_width - 1:0] row, col,	 		// selecteaza un rând si o coloana din labirint
	 output reg			  maze_oe,			// output enable (activeaza citirea din labirint la rândul ?i coloana date) - semnal sincron	
	 output reg			  maze_we, 			// write enable (activeaza scrierea în labirint la rândul ?i coloana date) - semnal sincron
	 output reg			  done);
	
	parameter maze_width=6;
	
	reg [4:0] state, next_state;
	
	reg [4:0] direction;
	reg [maze_width-1:0] actual_row, actual_col;
	reg [1:0] final;
	
	
	// partea secven?iala
	always @(posedge clk) begin
		
		state <= next_state;
		
	end
 
	// partea combinationala
	always @(*) begin
		
		maze_oe=0;
		maze_we=0;
		//done=0;
		
		case(state)
			
			1: begin //preiau coordonatele elementului din dreapta (dreapta relativa orientarii actuale)
				
				row=actual_row;
				col=actual_col;
				
				if(direction==0) begin
					col=actual_col-1;
				end
				
				if(direction==1) begin
					row=actual_row-1;
				end
				
				if(direction==2) begin
					col=actual_col+1;
				end
				
				if(direction==3) begin
					row=actual_row+1;
				end
				
				maze_oe=1;
				
				next_state=2;
			end
			
			2: begin //verific ce fel de element este in dreapta
				
				if(maze_in!=1) begin
					
					//daca in dreapta nu mai am zid atunci ma voi reorienta, aceea devine noua directie
					if(direction==3) begin
						
						direction=0;
						
					end
					else begin
					
						direction=direction+1;
					
					end
					
				end
				
				//revin la coordonatele elementului pe care ma aflu
				row=actual_row;
				col=actual_col;
				
				next_state=3;
				
			end
			
			3: begin //pe aceeasi idee ca la verificarea elementului din dreapta voi verifica si elementul din fata, aici preiau coordonatele acestuia
			
				if(direction==0) begin
					row=actual_row+1;
				end
				
				if(direction==1) begin
					col=actual_col-1;
				end
				
				if(direction==2) begin
					row=actual_row-1;
				end
				
				if(direction==3) begin
					col=actual_col+1;
				end
				
				maze_oe=1;
				
				next_state=4;
			
			end
			
			4: begin //verific elementul din fata
			
				if(maze_in==1) begin
				
					//daca am zid in fata ma voi orienta cu fata catre stanga
					if(direction==0) begin
						
						direction=3;
						
					end
					else begin
					
						direction=direction-1;
					
					end
					
					row=actual_row;
					col=actual_col;
					
					next_state=3;
				end
				else begin
					
					//daca se poate merge in fata atunci nu schimb directia de deplasare, urmand sa ma deplasez in fata
					row=actual_row;
					col=actual_col;
					
					next_state=5;
				
				end
			
			end
			
			5: begin //fac deplasarea in fata, pe elementul urmator, dupa ce orientarea a fost corect aleasa si stiu ca ma pot deplasa pe elementul din fata
				
				//variablia de ajutor pentru ajungerea in starea de final
				final=0;
				
				//pun 2 pe elementul pe care ma aflu
				maze_we=1;
				//$display("value:%d with X:%d and Y:%d",maze_in,actual_row,actual_col);
				
				//inaintez pe urmatorul element
				if(direction==0) begin
					actual_row=actual_row+1;
					
					//daca ma aflu pe pozitia de final ma asigur ca ma voi duce in starea 6
					if(actual_row==63)begin
						next_state=6;
						final=1;
					end
				end
				
				if(direction==1) begin
					actual_col=actual_col-1;
					if(actual_col==0)begin
						next_state=6;
						final=1;
					end
				end
				
				if(direction==2) begin
					actual_row=actual_row-1;
					if(actual_row==0)begin
						next_state=6;
						final=1;
					end
				end
				
				if(direction==3) begin
					actual_col=actual_col+1;
					if(actual_col==63)begin
						next_state=6;
						final=1;
					end
				end
				
				//dadca nu ma aflu in pozitia de final reiau algoritmul
				if(final==0)begin
					next_state=1;
				end
			end
			
			6: begin // am ajuns la finalul labirintului si pun 2 pe ultimul element
					
					row=actual_row;
					col=actual_col;
					
					maze_we=1;
					done=1;
					//$display("value:%d with X:%d and Y:%d",maze_in,actual_row,actual_col);
			end
			
			default: begin
				actual_row=starting_row;
				actual_col=starting_col;
				
				direction=0;
				
				//maze_we=1;
				
				next_state=1;
			end
		endcase
	end

endmodule
